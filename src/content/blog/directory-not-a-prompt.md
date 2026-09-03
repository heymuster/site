---
title: "Give an agent a directory, not a prompt"
description: "A long prompt is something you rewrite every session. A directory with a charter file in it is something the agent is. The difference shows up in week two."
date: 2026-06-24
number: "001"
---

The first version of this was a very long prompt. I had it in a note. I pasted it in at the start of every session, edited it when it got something wrong, and pasted the new version in next time.

It worked for about a week. Then I had four of these notes, each drifting from the others, and no way to know which one was current.

The fix was boring. One repository. One directory per agent. A file in each directory that says who that agent is and what it may do. The agent reads it at the start of every session because the tooling reads it automatically, not because I remembered to paste it.

## What changes when it is a file

**It survives.** A prompt lives for one session. A file lives until you edit it, which means a correction you make on a Tuesday is still in force in October.

**It can be edited by the thing it governs.** When my revenue agent learns that a particular endpoint lies, it writes that down. Next session it knows. I did not have to be present for the learning to stick.

**It has a history.** The charter is in version control, so when an agent starts behaving differently I can see what changed and when. This has been more useful than I expected. Twice the answer was "you changed it and forgot."

**It stops being about wording.** A prompt invites you to fiddle with phrasing. A file invites you to fix the rule. Those produce different work.

## The layout

```
fleet/
  agents/
    griff/
      CLAUDE.md        the charter — who it is, what it may decide
      griff_crons.json the scheduled jobs
      notes/           reference material it reads
    louie/
      ...
  vault/
    griff/
      STATE.md         what it believes right now
      board-log.md     what it has done, dated
```

Two directories, not one. The charter is code and lives with the code. The memory is data and lives somewhere it can be rewritten nightly without producing a commit every time an agent has a thought.

That split matters more than it sounds. When memory and instructions live in the same file, agents edit their own instructions while trying to record a fact, and you find out three weeks later.

## The part people skip

A directory only helps if the file in it is specific enough to constrain behaviour. "Be helpful and thorough" in a file is exactly as useless as "be helpful and thorough" in a prompt.

What goes in the file is the actual work, and it is the subject of most of what follows here. But the container comes first, because you cannot iterate on a rule you have to retype.

Mine took an afternoon to set up and I have not rebuilt it since. Everything after this was written on top of it.
