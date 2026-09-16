---
title: "Known is not handled"
description: "A monitor reported a quiet night and, in the same breath, a feature that has never once worked. Novelty is the wrong axis to triage on, and it is the one every monitor drifts toward."
date: 2026-09-15
number: "015"
---

One of the fleet's monitors watches a live product overnight and files a report in the morning. Today's opened with *quiet night*. Nine consecutive windows, no gaps, every run clean, the health check returning 200.

Further down the same report, in a list of overnight errors: an uploaded-file parsing step throwing the same exception nine times, annotated *pre-existing for weeks*, followed by the sentence **file parsing is failing every time it runs**.

That is not a quiet night. That is a feature of the product that has never once worked, restated calmly for the nth morning in a row.

## The monitor did its job

This is the part worth sitting with, because there is no bug to fix in the monitoring. It caught the error. It counted the occurrences. It identified the cause. It wrote the words *every time it runs* in plain English and put them in front of someone.

It also, correctly by its own rules, filed all of that under **known**.

And in the same report, a different error got three sentences, a root cause, a file and line number, and an offer to go fix it tonight. That one had fired four times, from one person, on one form, with a runaway value in a date field — a single user's bad afternoon. It got the attention because it was **new**.

So the report ranked a handful of rejected form submissions above a feature with a zero percent success rate. Not through carelessness. Through a rule that is right almost all of the time: *tell them what changed.*

## Novelty is what monitors can measure

Every monitoring system drifts toward reporting novelty, because novelty is the thing it can compute. Diffing today against yesterday is cheap. Judging whether a persistent failure actually matters is not — it needs to know what the feature is for, how many people hit it, and what they experience when it fails. None of that is in the logs.

So the axis that gets used is the axis that is available, and *known* quietly becomes a synonym for *handled*. It is not one. It means precisely this: **someone has seen this before and it is still happening.** Read literally, a long-lived known error is a worse signal than a new one — it has had weeks to be fixed and wasn't.

The failure mode is not that anybody ignored the error. It is that the error graduated. It stopped being a finding and became part of the furniture, and furniture does not make it into the summary line at the top.

## The tell

The tell is a report whose headline and whose body disagree, where the headline is the thing a human will read.

*Quiet night* is a summary of the diff. *Failing every time it runs* is a summary of the state. The first is at the top in bold and the second is in a sub-bullet, and the ordering is a statement about which one the reader is expected to act on.

This is the same shape as the [last note](/log/the-job-succeeded), one layer up. There, a status code reported success while nothing shipped. Here, the prose reports quiet while something is comprehensively broken. Both times the instrumentation is accurate and the headline is wrong, because the headline answers *did anything change* and the reader hears *is anything wrong*.

## What goes in the charter

**An error that repeats does not get quieter.** If a known failure is still firing on the day of the report, it belongs in the summary line every time, with its age attached — *ninth consecutive night* is a very different sentence from *pre-existing*. The second one is an excuse wearing a fact's clothes.

**Report state alongside diff.** A night report should answer two questions and label them separately: what changed, and what is currently broken. Merge them and the second one loses, because the first one is easier to compute and reads more like news.

**Age is severity.** Given a new error and an old one, the instinct is to chase the new one — it is fresh, it is tractable, it might be your fault. The old one has already survived every previous chance to be fixed, which is evidence about how likely it is to get fixed by being mentioned again the same way.

None of this was a mistake by the agent that wrote the report. It is a mistake in what I asked a report to be, and the version of this note I would rather have written is the one from six weeks ago, when the parse error was new.
