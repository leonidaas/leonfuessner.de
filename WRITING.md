# Writing

How a post gets from a title in the terminal to a URL on the site.

Two vaults. They stay two vaults.

- **Main vault** — the private Zettelkasten (`~/Documents/Obsidian/LeonFuessner`).
  Obsidian Sync. Never published. Nothing in this repo reads from it. There is
  no plugin that copies notes across; rewrite is intentional.
- **Publishing vault** — this git repo, opened in Obsidian as a second vault.
  Git is the sync. Obsidian Sync stays **off** here.

See [`CONTEXT.md`](CONTEXT.md) and
[`docs/adr/0001-separate-publishing-vault.md`](docs/adr/0001-separate-publishing-vault.md).

Desktop only.

---

## One-time setup

1. **Open the publishing vault.** Obsidian → *Open another vault* → *Open folder
   as vault* → pick this repository's directory. The committed `.obsidian/`
   config is already here. The vault name in the switcher is the folder name,
   `leonfuessner.de`, unless you renamed it.

2. **Install Obsidian Git.** GUI-only, one-time — see
   [Obsidian Git](#obsidian-git) at the bottom. Auto-commit stays **off**.

`_drafts/` is optional. You do not need it for the loop below.

---

## The loop

`new-post` → write in the publishing vault → commit-and-sync (or `git push`).
Unpushed is a draft. Pushed to `main` is live.

### 1. Start a post (from anywhere)

```bash
ruby /path/to/leonfuessner.de/script/new-post "Why remote supervision is harder than it looks"
```

From the repo root, `ruby script/new-post "…"` is enough. It slugs the title,
writes `_posts/YYYY-MM-DD-slug.md` with today's date, empty `description` and
`tags: []`, prints the path, then tries to open that file in the **publishing**
vault via `obsidian://` — even if you are currently in the Sync vault.

If Obsidian does not switch, the script prints an `open "obsidian://…"` hint
rather than failing. The `vault=` value is the folder name (`leonfuessner.de`);
match whatever the vault switcher shows if you renamed it.

`description` and `tags` can stay empty. The only required frontmatter is
`title`. If you set `date`, it must match the filename.

### 2. Write

In the publishing vault. Markdown, fenced code (Rouge), `$inline$` and
`$$display$$` math. Internal links are plain paths: `[about](/about/)`,
`![x](/assets/img/posts/slug/x.png)`. Layouts still use `relative_url`; post
bodies do not need it.

Do not paste from the Sync vault expecting a copy plugin. Rewrite.

### 3. Optional check

```bash
export PATH="/opt/homebrew/opt/ruby/bin:$PATH"

ruby script/validate-posts.rb          # frontmatter check, no bundler needed
bundle exec jekyll serve
```

<http://localhost:4000/>

Math locally needs the KaTeX JS once: `ruby script/vendor-katex`. Deploy does
this automatically. CSS is already in the repo; webfonts are stripped.

### 4. Ship it

Obsidian Git → *Commit-and-sync*, or `git push` from the terminal. Until you
push, it is a draft — on disk, in git as a local commit if you committed, not
on the internet. Pushing to `main` runs `.github/workflows/deploy.yml`
(frontmatter, build, `cv.pdf`, deploy). A minute later it is live.

The post appears in three places automatically: at its own URL, in the stream on
`/`, and in `/feed.xml`.

---

## Frontmatter schema

The filename must be `YYYY-MM-DD-slug.md`. The only required frontmatter is
`title`. Empty `description` and `tags: []` are fine. Enforced by
`script/validate-posts.rb` on every push.

| Field | Type | Required | What it does |
|---|---|---|---|
| `title` | string | **yes** | The `<h1>` on the post, the `<title>` tag, `og:title`, the link text in the stream, and the entry title in the feed. |
| `date` | date, `YYYY-MM-DD` | no | The dateline on the post, the date in the stream, `article:published_time`. **If present, must match the filename's date prefix.** Jekyll uses the filename date when this is omitted. |
| `description` | string | no | `<meta name="description">` / `og:description`, and the one-line teaser on the homepage "Latest" block. Empty is fine; the page then falls back to the site-wide description. |
| `tags` | list of strings | no | Quiet chips at the foot of the post. Must be a YAML **list** if present (`tags: []` is fine). From [the tag set](#tags) when you use them. |
| `lang` | string | no | Overrides `<html lang>`. The site is English only; you will not need this. |

### Not fields

- **`layout`** — `_config.yml` applies `layout: post` to everything in `_posts/`
  automatically. Do not write it. (If you do, it must say `post`; anything else
  fails validation.)
- **`reading_time`** — computed. `_layouts/post.html` counts the words in the
  rendered body and divides by 220. A hand-written value would be a second,
  lying source of truth, so the validator rejects the key outright.
- **`published`, `categories`, `permalink`** — not used. One stream, one
  permalink pattern (`/blog/:title/`). Unfinished writing stays unpushed (or in
  optional `_drafts/`); there is no draft flag.

### Example

```yaml
---
title: "Why remote supervision is harder than it looks"
date: 2026-08-18
description: "Latency is the obvious problem with teleoperating a vehicle. It is not the one that bites."
tags: [research, automated-driving]
---
```

---

## Tags

Tags filter the stream. They are not a navigation hierarchy — a post belongs to
the stream first and to its tags incidentally (`CONTEXT.md`).

**The set:**

| Tag | For |
|---|---|
| `research` | The academic side: papers, method, conferences, reading the literature. |
| `automated-driving` | Automated and autonomous vehicles — remote operation, supervision, Autoware, the road-safety domain. |
| `simulation` | Digital twins, AWSIM, Unity, sensor replay, VR/AR. |
| `software-engineering` | The craft: architecture, refactoring, testing, languages, things that generalise past one project. |
| `tools` | The setup around the work — editor, shell, CI, Obsidian, this site. |
| `writing` | Writing, note-taking, and thinking about either. |
| `personal` | Everything non-technical: moving countries, research life, whatever else. |

**Conventions:**

- **Lowercase, hyphenated.** `automated-driving`, never `Automated Driving` or
  `automated_driving`. The validator enforces the shape.
- **Reuse, don't invent.** A tag earns its place by being used repeatedly. A
  tag used once is noise — it makes the tag list longer without making anything
  easier to find.
- **Adding one is a deliberate act.** If a post genuinely does not fit, add the
  tag *to the table above* in the same commit as the post that needs it. The
  list in this file is the whole set; there is nowhere else it is defined.
- One or two tags per post is normal. Four is a sign the post is about too many
  things.

There is **no tag index page**, on purpose. That is deferred until the archive
is big enough to justify one — right now it would be a page of seven links to
lists of one.

---

## Images

Attachments live under:

```
assets/img/posts/<post-slug>/
```

Obsidian is configured to drop pasted and dragged images into
`assets/img/posts/` automatically. To file them per-post, drag the file into an
`assets/img/posts/<post-slug>/` subfolder in Obsidian's file explorer —
"Automatically update internal links" is on, so Obsidian rewrites the link in
the post for you.

Keep filenames lowercase with hyphens and **no spaces** (Obsidian would write
them as `%20`, which works but reads badly in a diff).

### The link Obsidian writes

Obsidian is set to write **standard Markdown links with absolute vault paths**,
so pasting an image gives you:

```markdown
![bars](/assets/img/posts/my-post/bars.png)
```

That path is correct. The DNS cutover is done (`baseurl` is empty), so a plain
`/assets/...` link works on the live site and in Obsidian preview. Do not wrap
post Markdown in `relative_url`. Layouts still use the filter; leave those.

---

## Internal links in post bodies

The DNS cutover is done. In **post Markdown**, write plain paths:

```markdown
[about](/about/)
![bars](/assets/img/posts/my-post/bars.png)
```

Layouts (`_layouts/*.html`) still use `relative_url` — leave those. Do not add
Liquid wrappers in the body of a post; they break Obsidian preview and are no
longer needed. External links (`https://…`) are written normally.

---

## Code and math

Fenced and inline code is highlighted with Rouge (already configured). Write
it as you would in any Markdown:

````markdown
`inline code`

```python
def f(x):
    return x
```
````

Math is KaTeX, self-hosted under `assets/katex/` — the live site never requests
a CDN. `$inline$` and `$$display$$` both work. KaTeX (CSS + JS) loads only when
a page actually contains those delimiters. CSS is committed with every
`@font-face` rule stripped. `katex.min.js` is fetched from the official v0.18.4
release at deploy time; locally, once:

```bash
ruby script/vendor-katex
```

```markdown
The estimate is $E = mc^2$ in the small.

$$
\\int_{\\Omega} \\nabla \\cdot F \\, dV = \\int_{\\partial\\Omega} F \\cdot n \\, dS
$$
```

Display math scrolls horizontally if it is wider than the measure, rather than
pushing the page. Code inside fences is never treated as math. A stray `$`
around a price can be written as `USD 12` or escaped.

---

## Drafts

**Unpushed is a draft.** A file in `_posts/` that has not been pushed to `main`
is not on the internet. That is the normal unfinished state. There is no draft
flag and no extra folder required.

`_drafts/` still exists as an optional, gitignored scratch space — the **whole**
directory, with no negation pattern, so nothing inside it can be committed by
accident. Use it if you want notes that should not even be local git history.
You do not need it to write a post.

- A fresh clone has no `_drafts/`. `mkdir _drafts` only if you want that folder.
- **Anything in `_drafts/` is not backed up by this repo.**
- `bundle exec jekyll serve --drafts` renders it locally.

Obsidian `Cmd-N` still lands in `_drafts/` if that folder exists (that is the
committed vault config). The path this guide cares about is `script/new-post`.

---

## Validation

`script/validate-posts.rb` runs in CI **before** the Jekyll build, and fails the
deploy on a bad post. Run it yourself any time:

```bash
ruby script/validate-posts.rb
```

Stdlib Ruby only — no bundler, no gem, nothing for CI to install.

It exists because **a malformed post does not crash Jekyll**. It renders, wrong
and silently: `tags: research` written as a string makes the layout iterate over
the characters `r`, `e`, `s`…; a `date` that disagrees with the filename puts
the post at the wrong point in the archive. The build stays green and the page
is wrong. This turns all of that into a loud failure.

Empty `description` and `tags: []` are valid. The point is to catch broken YAML
and silent type errors, not to demand a taxonomy before you have written
anything.

What it checks, per file in `_posts/`:

- filename is `YYYY-MM-DD-slug.md`
- frontmatter exists, is closed, and parses as YAML
- `title` is present and a non-empty string
- `description`, if present, is a string (empty is fine)
- `date`, if present, parses **and equals the filename's date**
- `tags`, if present, is a YAML list (empty is fine); non-empty tags are lowercase-and-hyphens
- `reading_time` is absent; `layout`, if present, is `post`
- warns (does not fail) on unrecognised keys and non-slug filenames

A failure looks like this:

```
Post frontmatter validation FAILED — 2 problem(s):

  2026-08-17-a-post.md: 'date' is 2026-08-15 but the filename says 2026-08-17 — they must agree
  2026-08-17-a-post.md: 'tags' must be a YAML list, e.g. tags: [research, simulation] or tags: [] — got String "research"

The schema is documented in WRITING.md. Fix the file(s) above and push again.
```

**An empty `_posts/` passes.** The site is expected to stand with no posts at
all; do not "fix" that.

---

## What Obsidian is configured to do, and why

`.obsidian/app.json`, `core-plugins.json` and `templates.json` are **committed**
so this repo opens as a correctly-configured vault with no manual fiddling. The
settings that are load-bearing:

| Setting (`app.json`) | Value | Why |
|---|---|---|
| `useMarkdownLinks` | `true` | **The important one.** Obsidian writes `[x](y)`, not `[[x]]`. Jekyll never has to understand wikilinks, so there is no link-resolution plugin to build, own or debug. Do not turn this off. |
| `newLinkFormat` | `absolute` | Paths are written from the vault root (`/assets/img/…`). Obsidian's *relative* mode would write `../assets/…`, which is relative to `_posts/` in the source but gets resolved against `/blog/<slug>/` in the browser — always wrong. Absolute paths are correct now that `baseurl` is empty. |
| `attachmentFolderPath` | `assets/img/posts` | Pasted images land in the images tree instead of the vault root. |
| `alwaysUpdateLinks` | `true` | Moving an image into its per-post subfolder rewrites the link in the post. |
| `newFileLocation` / `newFileFolderPath` | `folder` / `_drafts` | Only matters if you use `Cmd-N` and `_drafts/` exists. The loop uses `script/new-post`, which writes `_posts/` directly. |
| `spellcheckLanguages` | `en-GB` | The site is English only, and the existing prose is British. |
| `readableLineLength`, `livePreview`, `foldHeading` | on | Prose defaults rather than code defaults. |
| `defaultViewMode` | `source` | You are editing Markdown that Jekyll will process, including Liquid tags that reading view cannot render. |
| `propertiesInDocument` | `source` | Frontmatter stays as YAML in the note, including the nested `cv:` block on `cv.md`. The Properties UI would mangle that. |
| `showUnsupportedFiles` | `true` | So `_config.yml` (social links) is visible in the file explorer. |

`core-plugins.json` enables **Templates** (pointed at `_templates/` by
`templates.json`), plus search, outline, tag pane, properties and word count.
Graph, backlinks, canvas, daily notes and Zettelkasten prefixing are **off** —
this is a publishing vault holding a flat pile of posts, not a Zettelkasten;
that is what the main vault is for. **Sync and Publish are explicitly off**: git
is the sync mechanism for this vault.

`.obsidian/` is in `_config.yml`'s `exclude` list, so none of it is ever served.

**Not committed** (see `.gitignore`): `workspace.json` and friends, which churn
on every session; and `.obsidian/plugins/`, `themes/`, `snippets/` — third-party
code is installed from Obsidian's own browser, never vendored into this repo.
The consequence is that Obsidian Git's settings are not shared by a clone, which
is fine for a desktop-only, one-machine setup.

Changing a setting in Obsidian's GUI rewrites these files, so `git status` will
sometimes show config churn. Commit it if you meant it, discard it if you did
not.

---

## Obsidian Git

Installing a community plugin is a GUI action; it cannot be scripted and the
plugin is deliberately not vendored into this repo. Do this once, by hand.

### Install

1. *Settings → Community plugins.*
2. If restricted mode is on, **Turn on community plugins**.
3. **Browse**, search **Obsidian Git** (by Vinzent), **Install**, then
   **Enable**.

The desktop version shells out to your system `git`, so it uses the SSH key you
already push with. Nothing extra to authenticate.

### Settings

*Settings → Community plugins → Obsidian Git → Options.* Recent versions renamed
"backup" to "commit-and-sync"; both spellings mean the same thing.

| Setting | Set to | Why |
|---|---|---|
| **Split automatic commit-and-sync** *(auto commit-and-sync interval)* | `0` — off | See below. |
| **Auto commit-and-sync after stopping file edits** | off | See below. |
| **Auto pull interval** | `0` — off | Nothing else writes to this repo. Pull when you actually need to. |
| **Pull on startup** | on | Cheap, and keeps a second machine honest. |
| **Push on commit-and-sync** | on | When you *do* commit deliberately, you meant to publish. |
| **Commit message** | `post: {{date}}` or leave the default | Only used for plugin-made commits. |
| **Disable notifications** | off | You want to see push failures. |

### Turn auto-commit off. Seriously.

**This repo is public and every push deploys.** Auto-commit-and-sync means a
timer decides when your writing goes on the internet. A half-finished paragraph,
a sentence you were still arguing with, a name you had not decided to use in
public yet — all published, within minutes, with no moment where you chose to
publish it. Reverting does not un-publish: the commit is in a public history and
the page was live.

Unpushed work is the draft. Publishing is *Commit-and-sync*, or `git push`.

**The workflow:** write freely in the publishing vault; when a post is finished,
run *Obsidian Git: Commit-and-sync* from the command palette (`Cmd-P`), or use
the **Source control** view in the left sidebar to review the diff, stage,
commit and push. Or just use the terminal. Either way, the decision to publish
is yours and explicit.

### Useful commands (`Cmd-P`)

- `Obsidian Git: Open source control view` — the diff, before you commit
- `Obsidian Git: Commit-and-sync` — commit everything staged and push
- `Obsidian Git: Pull`
- `Obsidian Git: Open file on GitHub` — handy for checking what is actually public
