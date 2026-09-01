# leonfuessner.de

Personal website and writing archive. Jekyll, built and deployed by GitHub
Actions to GitHub Pages.

This repo is also a **publishing vault**: open it in Obsidian as a second vault
and write posts directly in it. The private Zettelkasten (Obsidian Sync) stays
a separate vault — nothing here reads from it, and there is no copy plugin.
See [`CONTEXT.md`](CONTEXT.md) and
[`docs/adr/0001-separate-publishing-vault.md`](docs/adr/0001-separate-publishing-vault.md).

**If you are here to write, read [`WRITING.md`](WRITING.md).**

## Layout

```
_config.yml                 site settings, plugins, social links, baseurl
_includes/
  cv.html                   CV markup — do not edit to change content
_layouts/
  default.html              page shell + nav
  post.html                 a post
  page.html                 a standalone page
_posts/                     posts (unpushed = draft; pushed to main = live)
_drafts/                    optional scratch — GITIGNORED, not required
_templates/                 Obsidian post template (not published)
index.html                  the stream (all posts, reverse chronological)  → /
now.md                      → /now/
about.md                    → /about/
cv.md                       → /cv/  (copy is the YAML frontmatter in this file)
assets/css|js|img/          static assets (paper.css locks parchment)
assets/img/posts/<slug>/    images belonging to one post
assets/katex/               self-hosted KaTeX CSS (JS vendored at build)
script/new-post             start a post from a title; opens in Obsidian
script/vendor-katex         fetch katex.min.js for local math preview
script/validate-posts.rb    frontmatter check, run by CI before the build
.obsidian/                  committed vault config (not published)
.github/workflows/deploy.yml  build + deploy
docs/adr/                   architecture decision records
CONTEXT.md                  glossary
WRITING.md                  how to write and publish a post
```

## Editing the site

Everything you change is a Markdown file in this vault. Open it in Obsidian
(source mode). Do not put HTML in a page to change copy.

| What you want to change | Open in Obsidian | What to edit |
|---|---|---|
| A blog post | `_posts/…` | the Markdown body — see [`WRITING.md`](WRITING.md) |
| Now | `now.md` | the Markdown body; bump `updated:` when you rewrite it |
| About | `about.md` | the Markdown body |
| The CV (page **and** PDF) | `cv.md` | the `cv:` YAML in the frontmatter. Copy an existing job block to add one |
| GitHub / LinkedIn / X | `_config.yml` | those three keys. Footer and CV contact rail both read them |

## Writing a post

Full guide: [`WRITING.md`](WRITING.md). The short version:

```bash
ruby script/new-post "Your title"
```

Works from any working directory. Writes `_posts/YYYY-MM-DD-your-title.md` and
tries to open it in the publishing vault (`obsidian://`), even if you are in the
Sync vault. The only required frontmatter is `title`. Empty `description` and
`tags: []` are fine.

Unpushed = draft. Commit-and-sync (Obsidian Git) or `git push` when it should
go live. It appears at `/blog/your-title/`, in the stream on `/`, and in
`/feed.xml`.

`_drafts/` is optional gitignored scratch. You do not need it for this loop.

### Images

Images for a post live in `assets/img/posts/<post-slug>/`, and Obsidian is
configured to paste them there. Write them as `/assets/img/posts/<slug>/file.png`
— see [`WRITING.md`](WRITING.md#images).

## Previewing locally

macOS ships an old Ruby that Jekyll 4 will not run on. Install a current one
(same workaround as `cv_2025`):

```bash
brew install ruby
export PATH="/opt/homebrew/opt/ruby/bin:$PATH"

bundle install
ruby script/vendor-katex              # once, for math preview
bundle exec jekyll serve
```

Then open <http://localhost:4000/>.

## How deploying works

Push to `main` → `.github/workflows/deploy.yml` runs → Jekyll builds → the
`_site` directory is uploaded as a Pages artifact and deployed.

This is **GitHub Actions**, not the classic GitHub Pages branch auto-build. The
repo's Pages source is set to "GitHub Actions". The reason is that the classic
build only allows a whitelist of plugins, and later phases need plugins outside
it plus a PDF-generation step.

There is no other deploy path. Do not switch the Pages source back to
"Deploy from a branch" — the site would silently rebuild without the workflow.

## The baseurl (DNS cutover is done)

The site is served at `https://leonfuessner.de` with `baseurl: ""`. In **post
Markdown**, write plain paths (`[about](/about/)`, `![x](/assets/img/...)`).
Layouts still go through `relative_url` so they stay correct if a prefix ever
comes back; do not add those wrappers in post bodies.
