# leonfuessner.de

Personal website and writing archive. Jekyll, built and deployed by GitHub
Actions to GitHub Pages.

This repo is also a **publishing vault**: open it in Obsidian as a second vault
and write posts directly in it. See [`CONTEXT.md`](CONTEXT.md) for the
vocabulary and [`docs/adr/0001-separate-publishing-vault.md`](docs/adr/0001-separate-publishing-vault.md)
for why it works that way.

**If you are here to write, read [`WRITING.md`](WRITING.md).** It covers the
draft-to-live loop, the frontmatter schema, the tag set, the images convention,
and the Obsidian Git setup.

## Layout

```
_config.yml                 site settings, plugins, and the baseurl (read the comment)
_layouts/
  default.html              page shell + nav
  post.html                 a post
  page.html                 a standalone page
_posts/                     published posts, one Markdown file each
_drafts/                    unfinished writing — GITIGNORED, never pushed
_templates/                 Obsidian post template (not published)
index.html                  the stream (all posts, reverse chronological)  → /
now.md                      → /now/
about.md                    → /about/
projects.md                 → /projects/
cv.md                       → /cv/
assets/css|js|img/          static assets
assets/img/posts/<slug>/    images belonging to one post
assets/katex/               self-hosted KaTeX (no CDN, no webfonts)
script/new-post             start a post from a title
script/validate-posts.rb    frontmatter check, run by CI before the build
.obsidian/                  committed vault config (not published)
.github/workflows/deploy.yml  build + deploy
docs/adr/                   architecture decision records
CONTEXT.md                  glossary
WRITING.md                  how to write and publish a post
```

## Writing a post

Full guide: [`WRITING.md`](WRITING.md). The short version:

```bash
ruby script/new-post "Your title"
```

That writes `_posts/YYYY-MM-DD-your-title.md`. The only required frontmatter is
`title`. Empty `description` and `tags: []` are fine. `script/validate-posts.rb`
runs in CI before the build — a malformed post fails the deploy rather than
rendering wrong in silence.

`layout: post` is applied automatically, so leave it out. Reading time is
computed from the word count, so there is no `reading_time` field.

Commit and push (Obsidian Git plugin, or `git push`). It appears at
`/blog/your-title/`, in the stream on `/`, and in `/feed.xml`.

### Drafts

`_drafts/` is gitignored — the **whole** directory, with no exception pattern,
so nothing inside it can be committed by accident. This repo is public and
unfinished writing should not be.

Consequences worth knowing:

- A fresh clone has no `_drafts/` directory. Run `mkdir _drafts` after cloning.
- Drafts are not backed up or synced by this repo. They live only on the
  machine you wrote them on.
- `bundle exec jekyll serve --drafts` renders them locally.

Publishing a draft = move it to `_posts/` and give the filename a date.

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
bundle exec jekyll serve          # add --drafts to include _drafts/
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
