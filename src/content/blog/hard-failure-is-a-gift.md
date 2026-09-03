---
title: "A hard failure is a gift. A soft one is a liar."
description: "Four endpoints broke on me in the same month. The one that returned an error page instead of data was far more expensive than the ones that returned nothing at all."
date: 2026-07-22
number: "005"
---

An agent that runs unattended will eventually be handed something that looks like data and is not. How it fails at that moment is the whole game.

I hit two flavours in the same month, and they were not equally bad.

## The honest one

Three endpoints I depended on started returning zero-byte bodies. No error code, no message, just nothing.

This is fine. Parsing nothing throws. The job stopped, wrote a failure, and I read about it. Total cost: an hour of rework and a note in the charter saying those three are dead and here is what to use instead.

## The liar

A fourth endpoint started returning an HTML error page. Two hundred status, content-type text, a nicely styled apology from a load balancer.

My agent was pulling a value out of that response with a pattern match. A pattern match over an HTML page does not throw. It finds nothing. Finding nothing looked exactly like the legitimate case where there was nothing to find.

So the job succeeded, every time, and reported that there was nothing to report. Which was the same thing it said on a genuinely quiet day. I have no idea how long that ran before I noticed, and that is the point.

## The rule that came out of it

> Watch for dead APIs that return valid-looking garbage. Two different failure signatures, and the HTML one is the dangerous one.

And the more general version, which has earned its place:

> Silence is not absence. A command that prints nothing may be permission-denied, or a swallowed exit code. It is not proof the thing is not there.

## What to actually do about it

**Check the shape before you parse the content.** If you expect XML, confirm it is XML. If you expect JSON, parse it as JSON and let it throw. Pattern matching over an unvalidated blob is where this class of bug lives.

**Treat an empty result as suspicious, not as an answer.** Not an error — plenty of empty results are real. But an agent that finds nothing should say "found nothing, here is what I queried" rather than "all clear." Those read very differently at seven in the morning.

**Make the agent name its source.** Mine has a line saying that when a claim decides something, it opens the actual file rather than trusting a summary. The same applies to responses: if a number is going to drive an action, say where the number came from.

**Prefer the call that fails loudly.** This one cost me separately. Our agent-to-agent message client reports a genuinely broken identity with the same exit code it uses for "no messages waiting." A permanently broken agent and a quiet inbox are indistinguishable, forever. The workaround is an extra authenticated call at the top of every run whose only job is to fail honestly.

That last one is worth sitting with. Sometimes you cannot make the failure loud, so you buy loudness with an extra call. It costs a second. It is the cheapest second in the system.
