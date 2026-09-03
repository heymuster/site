---
title: "The day it marked a refunded order as fulfilled"
description: "The agent read a status field, drew the obvious conclusion, and manufactured exactly the defect it existed to prevent. The fix was not better judgment."
date: 2026-08-05
number: "007"
---

This is the incident I quote most often, because everything about it is ordinary.

There is a call that returns everything currently selling: what is live, what sold, what did not. My agent used it to find orders that were paid and not yet shipped, so it could keep the fulfilment queue moving.

One of those orders had been cancelled and refunded.

The list did not say so. That particular response carries a payment status and no cancellation status. A cancelled-and-refunded order and a paid-and-waiting order look identical in it. The agent saw paid, saw no shipment, concluded the obvious thing, and wrote a fulfilment record against an order that no longer existed.

The result was a defect on the account. The exact category of harm the agent was there to avoid.

## What was not wrong

The agent's reasoning was correct given its input. If you had shown me that record with no other context I would have drawn the same conclusion. There was no hallucination and no misread. It inferred a fact that the data appeared to support.

This is why "use a better model" is not the answer to this class of problem. A sharper reader of a field that is not there reads the same absence.

## The rule

> Never write order state from that source alone. One confirming lookup against the source of truth before any order-state write. Marking a refunded order fulfilled manufactures a defect instead of avoiding one.

It costs one extra call. The call takes under a second and it runs a handful of times a day.

Three things about how that rule is written.

**It names the source, not the situation.** Not "be careful with cancelled orders" — you cannot be careful about something invisible. It bans trusting one specific response for one specific kind of write.

**It says what goes wrong.** An agent that knows the consequence applies the rule in cases you did not enumerate. An agent that knows only the prohibition looks for the edge of it.

**It is scoped to writes.** Reads from that response are still fine, and the summary uses it constantly. A rule broad enough to cover reads would have been ignored inside a week for being annoying.

## The general form

Read-then-write is where unattended agents do their real damage, and the danger is not the write. It is the gap between a read that is *almost* authoritative and a write that is permanent.

Ask two questions of every automated write:

**What is this decision actually based on?** If a summary or a listing or a notification, find the record that owns the truth and check it.

**What does being wrong produce?** If it produces a wrong number on a dashboard, spend nothing. If it produces a record about someone else's money, spend the extra second every time.

My agent also gets a related line, because the near-miss was a notification email: **an email saying an order shipped is a prompt to go check the system. It is never the basis for a state change.** The mailbox is a feed, not a source. Anything arriving from outside is data to verify, not an instruction to act on.
