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
script/validate-posts.rb    frontmatter check, run by CI before the build
.obsidian/                  committed vault config (not published)
.github/workflows/deploy.yml  build + deploy
docs/adr/                   architecture decision records
CONTEXT.md                  glossary
WRITING.md                  how to write and publish a post
```

## Writing a post

Full guide: [`WRITING.md`](WRITING.md). The short version — create
`_posts/YYYY-MM-DD-some-slug.md`:

```markdown
---
title: "Your title"
date: 2026-08-18
description: "One line. Meta description, and the blurb in the stream."
tags: [writing, research]
---

Your Markdown here.
```

All four fields are required and are checked by `script/validate-posts.rb`,
which CI runs before the build — a malformed post fails the deploy rather than
rendering wrong in silence. Run it locally with `ruby script/validate-posts.rb`.

`layout: post` is applied automatically, so leave it out. Reading time is
computed from the word count, so there is no `reading_time` field.

Commit and push (Obsidian Git plugin, or `git push`). It appears at
`/blog/some-slug/`, in the stream on `/`, and in `/feed.xml`.

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
configured to paste them there. Reference them through `relative_url` — see
[`WRITING.md`](WRITING.md#images) and the baseurl section below.

## Previewing locally

macOS ships an old Ruby that Jekyll 4 will not run on. Install a current one
(same workaround as `cv_2025`):

```bash
brew install ruby
export PATH="/opt/homebrew/opt/ruby/bin:$PATH"

bundle install
bundle exec jekyll serve          # add --drafts to include _drafts/
```

Then open <http://localhost:4000/leonfuessner.de/> — note the path prefix, see
below.

## How deploying works

Push to `main` → `.github/workflows/deploy.yml` runs → Jekyll builds → the
`_site` directory is uploaded as a Pages artifact and deployed.

This is **GitHub Actions**, not the classic GitHub Pages branch auto-build. The
repo's Pages source is set to "GitHub Actions". The reason is that the classic
build only allows a whitelist of plugins, and later phases need plugins outside
it plus a PDF-generation step.

There is no other deploy path. Do not switch the Pages source back to
"Deploy from a branch" — the site would silently rebuild without the workflow.

## The baseurl gotcha

Until the DNS cutover the site is served from a GitHub Pages **project page**:

```
https://leonidaas.github.io/leonfuessner.de/
```

A project page lives under a path prefix. Any internal link written as a bare
absolute path (`/about/`, `/assets/css/style.css`) resolves to
`leonidaas.github.io/about/` and 404s.

So: **every internal link in this repo goes through the `relative_url` filter.**

```liquid
<a href="{{ '/about/' | relative_url }}">About</a>
<a href="{{ post.url | relative_url }}">{{ post.title }}</a>
```

Never write a bare `href="/something"`. If you add a link and it works locally
but 404s on the deployed site, this is why.

`_config.yml` currently sets `baseurl: "/leonfuessner.de"`. At the DNS cutover,
set `baseurl: ""` and `url: "https://leonfuessner.de"` — because every link goes
through `relative_url`, those two lines fix all of them at once. The comment in
`_config.yml` says the same thing where you will actually see it.
