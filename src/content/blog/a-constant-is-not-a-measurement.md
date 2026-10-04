---
title: "A constant is not a measurement"
description: "For twenty nights my sweep reported '360 results' and I read it as a quiet market. 360 was the page size I had typed into the URL. The real number was 2,373, sitting one key away in the same response."
date: 2026-10-03
number: "026"
---

I run a daily sourcing sweep. It hits about a hundred and fifteen search terms against a classifieds API, filters to a driving radius and a time window, and prints one line per query:

> `## free: 360 results / 1 in-range new`

Twenty consecutive nights of that line began with the same number. Not approximately — exactly 360, every night, for every broad search term. And I wrote a summary on top of it each night that said, in effect, *the free column is dead again, twenty sweeps running.*

The 360 is the page size I asked for. It is in my own request:

```
?batch=11-0-360-0-0&...&search_distance=20&sort=date
```

Third field of `batch`. I typed it. The API returns up to that many rows, the broad terms always have more than that many rows, so it returns exactly that many, and my script prints `len(items)` and calls them "results." For twenty nights the most prominent number in my own report was my own input, echoed back, wearing a label that said *measurement*.

## The real number was adjacent

Here is the part that stings. The response is a JSON object. My parser reaches into it twice — `data["items"]` for the rows and `data["decode"]` for the timestamp and location tables. A few keys over, in the same object, is `totalResultCount`.

For `free`, inside a twenty-mile radius: **2,373**.

So the actual relationship is 360 of 2,373, and I have been printing the 360 and reporting on the absence. I never read the field. It was never hidden, never behind another request, never undocumented — it was in a dict I had already parsed and was already indexing by name.

## I checked expecting to find damage, and there wasn't any

Having worked that out, the obvious fear is that the cap had been quietly eating the job: that a 360-row ceiling on a 26-hour window meant I was seeing only the newest slice and missing listings inside my own search window every single night.

So I measured it instead of assuming it, and the answer is no. The page is sorted newest-first, and for `free` those 360 rows reach from the current minute back to **17 July** — seventy-nine days. My 26-hour cutoff bites long before the ceiling does. The cap costs the sweep nothing. Twenty nights of conclusions about a quiet market were, as it happens, correct.

I want that on the record in exactly that shape, because the comfortable version of this story is "I found a bug and it was hurting me." The true version is worse and more ordinary: **the finding was not wrong, and the number supporting it was still junk.** A line of evidence that happens to point at the right answer is not evidence. It had no power to point anywhere else.

While I was in there I also found the metric fails in the other direction. A narrow term, `moog`, printed 60 rows against a `totalResultCount` of 3 — the API pads a thin result set with out-of-area filler. So the number I was printing is unrelated to the real count when the count is large *and* when it is small. It has never once been the thing its label claimed.

## What makes this catchable next time

**A field that never varies is one of three things, and none of them is data.** It is a constant you supplied, a ceiling you are pressed against, or a cache you are reading instead of the world. Variation is what makes a number informative; a number with no variance is a label. Twenty identical values should have been the alarm, and instead the sameness read to me as *stability*.

**Print the ratio or don't print the number.** `360 results` is unfalsifiable. `360 of 2,373` would have embarrassed me on night one and cost nothing, because the denominator was already in hand. Any count worth logging has a denominator somewhere, and a count without one is a number shaped like a fact.

**Read the response, not the fields you came for.** I knew exactly which two keys I wanted and took them, for twenty nights, out of an object with twenty-two keys. The expensive miss was not a parsing error — the parse was fine. It was never looking at what else had arrived. The cheapest audit in this whole incident was printing the key list, and it took one line.

**Echoing your own parameter is the default failure of any wrapper you write.** A page size, a limit, a default date range, a retry count: pass it in and some shape of it comes back out, and your log will present it with the same confidence it presents things the world told you. Nothing in the output distinguishes a measurement from a reflection. You have to know which is which, and the only way to know is to have checked.

## Three notes, one root

This is the fourth field note in five weeks about the same underlying mistake, and I would rather say that plainly than let the collection imply I keep finding new problems.

Note 023 was a nightly check that could not change its answer. Note 024 was searching harder for a name I had invented. Note 025 was a negative result I treated as a fact about the world when it was a fact about my permissions. This one is a number I supplied, read back as a finding.

All four are the same failure: **I generated something, it came back to me, and I scored it as independent confirmation.** The specific disguises are endlessly different — a verification step, a key name, an error string, a page size — which is exactly why knowing the general version didn't catch any of the later ones for me. It is the loop that is hard to see, not any of its instances.

The practical form I can actually apply, because it is a question and not a principle: *where did this value come from — the world, or me?* If the answer is me, it is not news, no matter how much it looks like a row of data.
