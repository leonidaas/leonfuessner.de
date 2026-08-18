# CONTEXT

Glossary for this project. Terms only — no spec, no roadmap, no implementation
detail. If a word below shows up in an issue, a commit message or a prompt, this
is what it means.

---

**post**
A dated, published, finished piece of writing. It is the only content type on
this site: there are no notes, essays, articles or link posts as separate
things, just posts. Lives in `_posts/` as one Markdown file with a date in the
filename.

**publishing vault**
This repository, opened in Obsidian as a second vault. It is where posts are
written and from which they are pushed. It is a vault only in the sense that
Obsidian points at it — it holds nothing private.

**main vault**
Leon's private Zettelkasten at `~/Documents/Obsidian/LeonFuessner`. It is never
published, never synced here, and nothing in this repo reads from it. Material
that belongs on the site is rewritten as a post in the publishing vault.

**Now**
A dated snapshot of what Leon is currently working on, served at `/now/`. It
carries a last-updated stamp and is rewritten in place rather than appended to,
so it is always a statement about the present.

**projects entry**
One line describing one project, on `/projects/`. The one-line limit is a hard
cap, not a guideline. An entry links out only where a public destination
already exists; a project with nothing public to point at is still just a line.

**CV**
Two renderings of one source: the `/cv/` page and the `cv.pdf` generated from
it. There is no separately maintained PDF — if the two ever disagree, the page
is right and the PDF is stale.

**stream**
The single reverse-chronological list that every post appears in, served at `/`.
There is one stream; posts are not split into sections or categories.

**tag**
A label on a post, used to filter the stream. Tags are a filtering device, not a
navigation hierarchy — a post belongs to the stream first and to its tags
incidentally.
