+++
title = "Introduction to Git for Sane People"
date = "2024-08-01T12:33:29+08:00"
# description = "An optional description for SEO. If not provided, an automatically created summary will be used."
tags = ["explanatory"]
+++

## What is Git?

Git is a tool for tracking changes you made to your code. With Git, you can answer questions like:

- What did I write last Friday at 3pm?
- Who the fuck wrote this buggy line of code?
- What the fuck was I thinking when I wrote this?

You can also do things like:

- I don't feel like working on this feature anymore. I'll just undo everything and time-travel back to before I worked on this feature.

## Rocks in a River

Here's a very brief analogy:

![Created by James, 8 years old](/blog/images/git-for-sane-people/image.png)

A Git repository is akin to building a stone path in a river (I assume, not that I've ever built one). Starting from nothing, you lay rocks in the river one by one as you move forward. Each rock is fixed in place - once you put it down, you can't move or change it at all. If you've misplaced a stone, the only thing you can do is backtrack a stone back and place a new stone. Sometimes the path may not turn out as you expected, so you backtrack several stones back and start building a new path from there.

Along the way, you place anchors to stop the river from washing away your carefully-constructed path. The tides of the river will eventually wash away paths that are unanchored. Don't worry if you've misplaced a stone - simply backtrack and build a new path, the tides will clear out your old paths with time.

## Commits and Anchors

Branches are anchors you carry. It follows you around until you checkout a different branch or put it down manually.

Tags are anchors that you leave alone. It stays with a specific commit and doesn't move around when you move.

## But I don't want to carry a flag!

Detached HEAD mode

## Remote branches

Remote branches are Globally Synced Autonomous Mobile Anchors™ (GSAMA™).

## Diverged origin branch

The GSAMA™ content management team has detected anomalies

If you're sure you want to replace the old path entirely, you can tell GSAMA™ to eat shit and do as you say with:

```sh
git push --force
```
