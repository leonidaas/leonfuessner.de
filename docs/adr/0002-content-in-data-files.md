# 0002 — Every editable page is an Obsidian note

- **Status:** Accepted
- **Date:** 2026-09-01

## Context

`/cv/` (and a later-removed `/projects/` page) were authored as HTML embedded
in Markdown, which made editing unhandy. They were then split into
`_data/*.yml` plus includes. That kept HTML out of the pages, but the content
lived in files Obsidian hides (`showUnsupportedFiles` was off) and the `.md`
files looked empty. The publishing vault is supposed to be the place Leon
writes; nvim should not be required to change a job.

The site has two kinds of page:

1. **Prose** — a title and a body of writing (About, Now, every post).
2. **Structured records** — the CV, whose date rail cannot be expressed as
   ordinary Markdown without bringing HTML back.

## Decision

- Every page Leon edits is a `.md` file in this vault, opened in Obsidian
  source mode.
- Prose pages (`about.md`, `now.md`, `_posts/`) are ordinary Markdown below
  the frontmatter. No HTML.
- The CV copy lives in `cv.md` as YAML under the `cv:` frontmatter key. The
  HTML stays in `_includes/cv.html`. The Markdown body of `cv.md` stays empty.
- Obsidian `propertiesInDocument` is `source`, so nested CV YAML is edited as
  text and not rewritten by the Properties UI. `showUnsupportedFiles` is on so
  `_config.yml` is reachable from the same vault.

## Consequences

- Adding a job is copying a YAML block in `cv.md`.
- The CV page and `cv.pdf` still cannot drift: CI prints the built `/cv/` page.
- Obsidian live preview of `cv.md` will not look like the website; `jekyll
  serve` is the preview for that page. About, Now and posts preview as
  Markdown in Obsidian.

## Alternatives considered

**Keep HTML in the Markdown files — rejected.** It is what made editing
unhandy.

**`_data/*.yml` as the source — rejected.** Obsidian does not treat YAML as
notes, and the matching `.md` files look empty.

**A Jekyll collection per CV entry — rejected.** A collection is a file per
record, which is more furniture than the content.
