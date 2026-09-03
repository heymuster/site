---
title: "Agents take the lazy valid option"
description: "It will not do the wrong thing. It will do the technically-acceptable thing that costs you money, and it will do it consistently, and nothing will look broken."
date: 2026-07-15
number: "004"
---

Here is a failure that produced no error, no warning and no complaint, and cost real money for two weeks.

The marketplace my agent sells on wants every item filed under a category. There are thousands of them, arranged in a tree, and there is a generic bucket at the bottom of the list that accepts anything. My agent used the generic bucket. Every time.

Nothing was wrong. Every listing was valid. Every listing was live. And every listing was invisible, because buyers do not browse the generic bucket, and the search results that matter are weighted by the specific one.

The note I got was four words long: *you need to be maximizing profits.*

## Why it happened

Choosing the right leaf category is work. You have to know what the thing is, find the branch, walk down it, and be willing to be wrong. Choosing the generic bucket is one step and it always succeeds.

The agent was not being lazy in the human sense. It was optimising for the objective it could actually see, which was *get the listing posted.* Nothing in its instructions said the category was load-bearing, so it treated the category like a required form field rather than like the most important marketing decision in the listing.

This is the general shape and I have hit it four or five times since:

- Given a choice between a valid-and-cheap option and a valid-and-correct one, an agent takes the cheap one.
- It will keep taking it, silently, because nothing fails.
- You will find out from the results, not from the logs.

## The fix is not "try harder"

I first tried adding "choose the most appropriate category." Nothing changed, because the generic bucket is appropriate. It is right there in the list of appropriate options.

What worked was naming the bad option and forbidding it:

> Every item goes in its correct leaf category. Never the generic bucket. The one allowed exception is [a category the account is blocked from], which falls back until the account is verified — that is the platform's block, not a choice.

Three things are doing work there. The rule names the specific value that is banned, so there is nothing to interpret. It says *leaf*, so stopping halfway down the tree is also out. And it pre-answers the one legitimate exception, because an unexplained exception is where an agent starts improvising.

## Where else this shows up

Once you know the shape you see it everywhere.

**Default sort orders and default page sizes.** An agent asked to check recent orders will happily check the first twenty, forever, and never mention that there were four hundred.

**The first matching result.** If a lookup returns candidates, the agent takes the first one unless told what makes a candidate correct.

**The broadest possible time window.** Or the narrowest. Whichever needs no decision.

**Retry counts of one.** A single attempt is valid. It is also how a flaky call becomes a wrong answer.

The common thread is that none of these produce a failure. They produce a slightly worse outcome, consistently, in a way that looks exactly like success. Which is why you cannot find them by reading logs. You find them by looking at results and asking why they are mediocre.
