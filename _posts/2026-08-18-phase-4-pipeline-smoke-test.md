---
title: "Phase 4 pipeline smoke test — DELETE ME"
date: 2026-08-18
description: "Temporary post proving the Obsidian → git → Actions → Pages pipeline, including a pasted image. Deleted immediately after."
tags: [tools, writing]
---

This post exists to prove the authoring pipeline end to end and will be deleted
in the next commit. It was created from `_templates/post.md`, carries the
frontmatter schema documented in `WRITING.md`, and embeds an image stored under
the images convention.

Below: the image, wrapped in `relative_url` the way `WRITING.md` says to.

![bars]({{ '/assets/img/posts/phase-4-pipeline-smoke-test/bars.png' | relative_url }})

And here is the raw form Obsidian writes it in, left unwrapped on purpose so the
built HTML shows the difference:

![bars](/assets/img/posts/phase-4-pipeline-smoke-test/bars.png)

A [wrapped internal link]({{ '/about/' | relative_url }}) and a raw one:
[unwrapped](/about/).

Enough words to make the reading-time calculation produce something, since the
layout divides the word count by 220 and floors at one minute.
