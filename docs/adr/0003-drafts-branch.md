# 0003 — Drafts live on a pushed `drafts` branch

- **Status:** Accepted
- **Date:** 2026-10-24
- **Supersedes:** the drafts consequence of [0001](0001-separate-publishing-vault.md)

## Context

Posts are written on two machines, a Mac and a ThinkPad. Under 0001, a draft
was either unpushed or in the gitignored `_drafts/`, so it existed only on the
machine it was started on. Pushing it to `main` was the only way to move it,
and pushing to `main` deploys.

## Decision

Drafts are committed and pushed to a `drafts` branch. Every clone keeps its
publishing vault checked out on `drafts`, and Obsidian Git's commit-and-sync
moves drafts between machines. The deploy workflow only runs on `main`.

`script/publish <paths…>` is the only route onto `main`: it copies the named
files (a post brings its `assets/img/posts/<slug>/` folder) from the committed
`drafts` tip into a temporary worktree of `main`, validates, commits and
pushes, then merges `main` back into `drafts`.

## Consequences

- Drafts are synced and backed up by GitHub.
- **Drafts are public.** The repo is public, so anything on `drafts` can be
  read on GitHub, though it is not on the site. Truly private material stays in
  the main vault.
- Publishing is a per-file decision. Other drafts on the branch stay unpublished.
- A vault left on `main` by mistake would deploy on commit-and-sync. Keeping
  auto-commit off (WRITING.md) limits that to a deliberate action.

## Alternatives considered

- **Draft in the main (Obsidian Sync) vault and copy over** — rejected: drafts
  should live with the posts on GitHub.
- **Private repo with tracked `_drafts/`** — rejected for now: Pages from a
  private repo needs a paid plan.
