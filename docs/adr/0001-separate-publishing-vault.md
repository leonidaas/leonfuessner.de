# 0001 — The site repo is its own publishing vault

- **Status:** Accepted
- **Date:** 2026-08-18

## Context

Posts for this site are written in Obsidian. There are two ways to get an
Obsidian note onto a public website:

1. Write it in the main vault, mark it `publish: true` in frontmatter, and run
   an export pipeline that copies flagged notes into the site repo.
2. Make the site repo itself a small Obsidian vault, opened as a second vault,
   and write posts directly in it.

The state of the main vault decides this. It holds roughly 34 notes, is not
under version control, and has no established writing pipeline — there is no
habit or convention for a `publish` flag to hook into. Leon also intends to
restructure the main vault in a future, separate session, which means its
folder layout, naming and frontmatter conventions are all expected to change.

An export pipeline would couple publishing to exactly those unstable things. It
would need to be designed against a structure that is about to be replaced, and
rewritten once the restructure lands. It would also make privacy a property of
a frontmatter field: every private note in the vault would be one typo or one
misapplied template away from the public internet.

## Decision

The site repository is its own publishing vault. Leon opens it in Obsidian as a
second vault and writes posts directly into `_posts/`. Nothing reads from the
main vault, and no export or sync step exists between the two.

Material that starts as a note in the main vault gets rewritten as a post here.
That rewrite is treated as a feature, not friction: a Zettelkasten note and a
published post are different artefacts with different audiences.

## Consequences

- Publishing is decoupled from the main-vault restructure. That restructure can
  happen whenever, and change whatever, without touching this repo.
- The privacy boundary is a directory boundary rather than a frontmatter field.
  A note cannot leak by being mis-tagged, because nothing in the main vault is
  ever read by anything here.
- No pipeline to build, own, or debug. The publish action is `git push`, via the
  Obsidian Git plugin.
- **This repo is public, so drafts are gitignored rather than pushed.** Work in
  progress lives in `_drafts/`, which is excluded from version control entirely.
  The cost is that drafts are not backed up or synced by this repo and exist
  only on the machine they were written on.
- Notes are duplicated when a vault note becomes a post. There is no automatic
  link back to the source note, and the two can drift.
- Obsidian features that assume a single graph — wikilinks across vaults,
  global backlinks, vault-wide search — do not span the two vaults.

## Alternatives considered

**Export pipeline (`publish: true` + copy step) — rejected.** It would have to
be written against a vault structure scheduled for replacement, it makes privacy
depend on per-note frontmatter being correct, and it adds a build step to
maintain for a site that currently has no posts. Revisit only if the main vault
stabilises and the volume of writing makes manual rewriting the bottleneck.
