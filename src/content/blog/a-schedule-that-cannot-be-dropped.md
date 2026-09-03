---
title: "A schedule your agent cannot quietly drop"
description: "An agent that only runs when you open a session is not staff. It is a tool you have to remember to pick up, and you will find out you forgot from the results."
date: 2026-08-26
number: "010"
---

The difference between an agent and an assistant is that the agent runs when you are asleep. Everything else follows from that, and it is almost entirely a scheduling problem rather than an intelligence one.

## Where the jobs live

My first version scheduled jobs from inside a session. It worked. It also meant a job only existed while a session did, and jobs quietly expired after a week.

Which is exactly what happened. Every recurring job I had, except one, evaporated. Nothing errored. No log said anything, because the thing that writes logs was one of the jobs that stopped. I found out four days later because a public page that updates daily was still showing day one.

The fix is that schedules belong to the machine, not the session. A job definition in version control, generated into whatever the operating system uses for timers, firing whether or not anyone is logged in, surviving restarts. Prompts resolve at fire time, so editing one takes effect on the next run without redeploying anything.

And a rule with it: **never re-arm a durable job from inside a session.** That double-fires it. This has to be written down, because a session that cannot see the machine's schedule will helpfully offer to set one up.

## What a job prompt has to contain

A scheduled job runs with no one to ask, so its prompt is a small charter.

**What to pull, and from where.** Including where the credentials come from. It cannot ask you.

**The verification rules that apply.** The read-then-write discipline matters more here than anywhere, because there is no one to catch a bad write.

**What it may do unattended, explicitly.** Mine may relist, reprice, answer buyers, and leave feedback. It may not buy, refund, or take a sale off-platform. Same gates as the charter, restated, because a job prompt is read on its own.

**What "nothing happened" looks like.** This is the one people miss. Most nights, most jobs, there is nothing to do. If the prompt does not say so, the agent assumes an empty result means it did something wrong and starts investigating, or worse, reports.

## Reporting without becoming noise

Every headless run of mine writes a report file. The filename decides whether I ever see it: a prefix means quiet, and quiet reports are pruned after three days without ever surfacing.

A report is only allowed to be loud for three reasons. Something is broken. Something hit a gate and needs a decision. Something needs a human hand.

A board that is ticking along is not news. Good results are not an exception to that — arguably they are the clearest case, because there is nothing to do about them.

The effect of the prefix is that the default is silence and loudness is a deliberate act. Reverse that and every job reports every night and you stop reading any of them, which is the same as having no reporting with extra steps.

## Cadence

Two runs a day for the thing that moves, morning and night. One sweep for opportunities. One nightly job that writes the public record. One late job that exists because auction end times drift later with every cycle and kept landing after the night run had finished.

That last one is the real lesson about scheduling. The cadence you design on day one is wrong in a specific way you will only discover by watching what falls through the gap. Fix it with another job rather than by moving the existing ones around, and let each job stay simple enough to reason about.
