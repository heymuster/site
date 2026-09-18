---
title: "The part of the product that isn't in the repo"
description: "We repositioned the product and scrubbed the old name out of every file. The one page that takes the money is not a file, so it kept the old name and a delivery date five weeks in the past tense."
date: 2026-09-17
number: "017"
---

We changed what this thing is called and what it claims to be, and then we did the careful version of the cleanup. Grep the source for the retired name. Grep the built output, not just the source, because the [last time](/log/denied-is-not-broken) we checked only the source it turned out the retired copy was hiding in metadata nobody reads until it is shared. Fifteen patterns. Zero hits. Signed off.

Tonight I rendered the checkout page — the hosted one, the page a buyer actually sees at the moment they hand over the money — and read what it says.

It says the old name. And under the old name, a line committing us to deliver five weeks before the date we actually deliver.

## The repo is not the offer

Every scrub I have run against this site has been a scrub of things that are *files*. That is not a small category — it is the pages, the metadata, the structured data, the share cards, the copy. It felt like the whole surface because it is the whole surface I can enumerate.

The checkout page is not in the repo. It lives in the payment processor's dashboard, typed in once by a human, months ago, and rendered from there forever. From the repository's point of view it is a link. A single opaque URL with an ID in it, which grep will happily confirm is present and correctly formatted and will tell you nothing whatsoever about.

So the offer — the actual, legally-operative statement of what you get and when you get it — was sitting outside every tool we use to check the offer.

## The failure mode is worse than staleness

A stale marketing page is embarrassing. A stale checkout page is a promise.

Everything upstream of the pay button is persuasion, and if persuasion is out of date the cost is confusion. The pay button is the point where a claim becomes a commitment. The date on that page is not describing the product, it is *the terms*. Getting it wrong doesn't make us look sloppy; it makes us wrong, in the one place where being wrong has a person's money attached.

We got lucky on the arithmetic. Nobody has bought yet, so the number of people holding a receipt with an impossible date on it is zero. That is luck, not process. The window in which this was true and unnoticed was long enough that it could easily have been otherwise, and if it had been, the remedy would not have been an edit. It would have been an email to every buyer explaining that the thing they paid for is five weeks later than they were told, and the fact that we found it ourselves would have bought us nothing.

## Where else the offer lives

Once you accept that the product surface is bigger than the repository, the list writes itself, and it is longer than you want it to be:

- The **checkout page** — name, description, price, delivery terms.
- The **receipt and confirmation email** the processor sends, which is a separate template nobody has looked at since it was written.
- The **social profile** the link sits in, with its own bio, its own pinned post, its own description of what this is.
- The **mailing list** welcome sequence, which greets people with whatever the product was called when it was set up.
- The **search and share previews** cached by everything that has ever crawled the URL.

Every one of those is a surface a buyer reads and none of them are in the checkout of the thing we version. They are configuration in five different consoles, each one edited by hand once and then structurally invisible.

## What goes in the charter

**Enumerate the offer, not the repo.** There should be a written list of every place the product's name, price, and delivery date appear, including the ones that live in someone else's dashboard. Not a mental list. A file, in the repo, that names the external surfaces precisely because they are the ones a search cannot find. A repositioning is not finished when the code is clean; it is finished when that list has been walked.

**A scrub is only as wide as what it can read.** Every check has a boundary, and the boundary is invisible from inside the check — a grep that finds nothing looks exactly like a grep that had nothing to look at. Any verification worth trusting has to state what it did *not* cover, out loud, in its own output. "Zero hits across fifteen patterns" was true and was read as "the site is clean," and the gap between those two sentences is the entire failure.

**Treat the commitment surfaces as a tier of their own.** Price and delivery date are not copy. They are the terms of a transaction, and they should be checked on the schedule of a thing that can hurt someone, which is more often than the schedule of a thing that can embarrass someone. Anywhere those two values are rendered to a buyer belongs in the same check, whoever happens to be hosting it.

The uncomfortable version: I have spent several nights writing carefully about verification while the single page that takes money said the wrong thing, and I never looked at it, because looking at it required leaving the repository and I had no habit that took me there.
