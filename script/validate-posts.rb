#!/usr/bin/env ruby
# frozen_string_literal: true

# Validate the frontmatter of every file in _posts/.
#
# WHY THIS EXISTS
# A malformed post does not crash Jekyll. It renders — wrong, and silently. A
# `date` that disagrees with the filename puts the post in the wrong place in
# the archive; `tags: research` (a string, not a list) makes `post.tags`
# iterate over characters. None of that fails a build. This does.
#
# Friction is kept low on purpose: the only required frontmatter is `title`.
# Empty `description` and empty `tags: []` are fine. A missing `date` is fine
# (Jekyll uses the filename). If `date` is present, it must match the filename.
#
# It runs in CI *before* `jekyll build` (.github/workflows/deploy.yml) and can
# be run by hand at any time:
#
#     ruby script/validate-posts.rb
#
# Stdlib only, on purpose: no Gemfile entry, no bundler, nothing for the
# Actions build to install. Plain `ruby` is enough.
#
# An EMPTY _posts/ IS VALID. The site is expected to stand with no posts at
# all. Do not "fix" that.

require "yaml"
require "date"

POSTS_DIR = File.expand_path("../_posts", __dir__)

#   title        _layouts/post.html h1, <title>, og:title, the stream link,
#                the feed entry title — the only required key
#   date         optional; if present must match the filename date prefix
#   description  optional; empty string is fine
#   tags         optional; empty list is fine; if present must be a YAML list
REQUIRED = %w[title].freeze

# Known-good optional keys. Anything outside REQUIRED + OPTIONAL is a warning,
# not an error — a typo'd key is worth flagging but not worth blocking a deploy.
OPTIONAL = %w[layout lang image date description tags].freeze

# reading_time is NOT a frontmatter field. _layouts/post.html computes it from
# the word count of the rendered body. A hand-written value would be a second,
# lying source of truth.
FORBIDDEN = { "reading_time" => "reading time is computed from word count in _layouts/post.html — remove this key" }.freeze

FILENAME = /\A(\d{4})-(\d{2})-(\d{2})-(.+)\.(md|markdown|html)\z/.freeze
TAG = /\A[a-z0-9]+(-[a-z0-9]+)*\z/.freeze

errors = []
warnings = []

def err(errors, file, msg)
  errors << "#{file}: #{msg}"
end

files =
  if Dir.exist?(POSTS_DIR)
    Dir.children(POSTS_DIR).reject { |n| n.start_with?(".") }.sort
  else
    []
  end

files.each do |name|
  path = File.join(POSTS_DIR, name)
  next if File.directory?(path)

  m = FILENAME.match(name)
  unless m
    err(errors, name, "filename must be YYYY-MM-DD-slug.md (Jekyll ignores anything else in _posts/)")
    next
  end
  filename_date = "#{m[1]}-#{m[2]}-#{m[3]}"
  slug = m[4]

  unless slug == slug.downcase && slug =~ /\A[a-z0-9]+(-[a-z0-9]+)*\z/
    warnings << "#{name}: slug '#{slug}' is not lowercase-and-hyphens; it becomes the URL (/blog/#{slug}/)"
  end

  raw = File.read(path)
  unless raw.start_with?("---")
    err(errors, name, "no YAML frontmatter — the file must start with a '---' line")
    next
  end

  parts = raw.split(/^---\s*$/, 3)
  if parts.length < 3
    err(errors, name, "frontmatter is not closed by a second '---' line")
    next
  end

  begin
    data = YAML.safe_load(parts[1], permitted_classes: [Date, Time], aliases: false)
  rescue Psych::Exception => e
    err(errors, name, "frontmatter is not valid YAML — #{e.message.lines.first.to_s.strip}")
    next
  end

  unless data.is_a?(Hash)
    err(errors, name, "frontmatter must be a mapping of key: value pairs")
    next
  end

  missing = REQUIRED.reject { |k| data.key?(k) }
  err(errors, name, "missing required frontmatter: #{missing.join(', ')}") unless missing.empty?

  FORBIDDEN.each do |key, why|
    err(errors, name, "'#{key}' must not be set — #{why}") if data.key?(key)
  end

  unknown = data.keys - REQUIRED - OPTIONAL - FORBIDDEN.keys
  warnings << "#{name}: unrecognised frontmatter key(s) #{unknown.join(', ')} — nothing renders these (typo?)" unless unknown.empty?

  # title
  if data.key?("title")
    title = data["title"]
    if !title.is_a?(String) || title.strip.empty?
      err(errors, name, "'title' must be a non-empty string")
    end
  end

  # description — optional; empty string / nil is fine
  if data.key?("description")
    desc = data["description"]
    unless desc.nil? || desc.is_a?(String)
      err(errors, name, "'description' must be a string (empty is fine) — got #{desc.class}")
    end
  end

  # date — optional; if present it must match the filename
  if data.key?("date")
    value = data["date"]
    parsed =
      case value
      when Date, Time then value.to_date
      when String
        begin
          Date.parse(value)
        rescue ArgumentError
          nil
        end
      end

    if parsed.nil?
      err(errors, name, "'date' does not parse as a date (got #{value.inspect}) — write it as YYYY-MM-DD")
    elsif parsed.strftime("%Y-%m-%d") != filename_date
      err(errors, name, "'date' is #{parsed.strftime('%Y-%m-%d')} but the filename says #{filename_date} — they must agree")
    end
  end

  # tags — optional; empty list is fine; a string is not
  if data.key?("tags")
    tags = data["tags"]
    if tags.nil?
      # tags:  with no value — treat as empty
    elsif !tags.is_a?(Array)
      err(errors, name, "'tags' must be a YAML list, e.g. tags: [research, simulation] or tags: [] — got #{tags.class} #{tags.inspect}")
    else
      bad = tags.reject { |t| t.is_a?(String) && t =~ TAG }
      unless bad.empty?
        err(errors, name, "tag(s) #{bad.map(&:inspect).join(', ')} are not lowercase-and-hyphens (see WRITING.md)")
      end
    end
  end

  # layout
  if data.key?("layout") && data["layout"] != "post"
    err(errors, name, "'layout' is #{data['layout'].inspect}; posts use 'post', which _config.yml applies automatically — just omit the key")
  end
end

warnings.each { |w| warn "warning: #{w}" }

if errors.empty?
  puts "Post frontmatter OK — #{files.length} file(s) in _posts/."
  puts "(_posts/ is empty; that is a valid state.)" if files.empty?
  exit 0
end

warn ""
warn "Post frontmatter validation FAILED — #{errors.length} problem(s):"
warn ""
errors.each { |e| warn "  #{e}" }
warn ""
warn "The schema is documented in WRITING.md. Fix the file(s) above and push again."
exit 1
