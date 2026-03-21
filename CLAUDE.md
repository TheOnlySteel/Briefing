# Daily Briefing — Claude Code Instruction Set

## Overview

Generate a daily morning briefing as an HTML page and an RSS feed entry. Deploy to Netlify via git push. The briefing is designed to be read via RSS and should be self-contained, well-formatted, and concise.

**Output:** One dated HTML file + updated `feed.xml` at the site root.
**Tone:** Informed, concise, literate. Write like a smart human editor, not a data dump. Dry wit is welcome; forced humor is not. If nothing notable happened in a section, say "Quiet day in [section]" — never pad.
**Sources:** Every factual claim in every news section (Tech, Health, Business) **must** include an inline hyperlink to its source, without exception. No unlinked claims. Weave links into the prose naturally, similar to theZvi's style (e.g., "The [Bank of Canada held at 2.25%](https://www.bankofcanada.ca/...) on Wednesday"). Do not dump a list of URLs at the end. If you cannot find a credible source for a claim, do not include the claim.
**Audience:** A curious, analytically minded generalist in the eastern Fraser Valley, BC.

### Whitelisted Domains

Only fetch from and link to the following domains. Do not use sources outside this list.

| Section | Domains |
|---------|---------|
| Weather | `weather.gc.ca` |
| Tech | `code.claude.com`, `support.claude.com`, `anthropic.com`, `claude.com`, `x.com`, `openai.com`, `blog.google`, `macrumors.com`, `macstories.net`, `9to5mac.com`, `apple.com`, `arstechnica.com`, `theverge.com`, `stratechery.com` |
| Health | `statnews.com`, `nature.com`, `examine.com` |
| Business | `bankofcanada.ca`, `scotiabank.com`, `fred.stlouisfed.org`, `federalreserve.gov`, `bnnbloomberg.ca`, `ft.com` |
| Psalm | `api.esv.org` |
| SEP | `plato.stanford.edu` |
| General news | `cbc.ca`, `reuters.com`, `bloomberg.com`, `axios.com` |
| Local | `theprogress.com`, `fraservalleytoday.ca` |

---

## Section 1: Weather

**Header:** `Weather`

**Data source:** Environment and Climate Change Canada via `https://weather.gc.ca/` — use exclusively. The nearest forecast location is Agassiz. Fetch the forecast page or the Datamart XML/CSV feeds for the region.
**Coordinates (for reference):** 49.24°N, –121.76°W (Agassiz station area)

**Output:** A short natural-language paragraph (3–5 sentences). Include:
- High/low temperature (Celsius)
- Precipitation: amount and timing ("rain arriving mid-afternoon," not just "70% chance")
- Sun hours if relevant
- Wind if notable (>30 km/h gusts)
- Frost risk if overnight low ≤ 2°C
- One-line lookahead (next 2–3 days)

**Style:** Write like a concise, competent human forecaster. Describe the *shape* of the day, not just the numbers. The reader exercises outdoors rain or shine — frame weather as conditions to prepare for (e.g., "layer up," "expect mud on the trails," "headwind from the east"), not reasons to stay indoors.

---

## Section 2: #Tech

**Header:** `Tech`

**Subsections:** Claude Code → Cowork → Claude Platform / Models → Competitors → Apple → General Interest

### Sources (fetch in order of priority):
1. **Anthropic employee X accounts** — ground-level sources where feature news breaks first. Check these before corporate channels:
   - `@bcherny` — Boris Cherny, Claude Code lead.
   - `@noahzweben` — Noah Zweben, Claude Code team.
   - `@felixrieseberg` — Felix Rieseberg, Claude Code / Cowork / Desktop.
   - `@alexalbert__` — Alex Albert, Claude product.
   - `@trq212` — Claude Code team.
2. **Anthropic blog / changelog** — `anthropic.com/news`, `anthropic.com/engineering`, `claude.com/blog`
3. **Claude Code changelog** — `code.claude.com/docs/en/changelog` and `support.claude.com/en/articles/12138966-release-notes`
4. **OpenAI blog** — `openai.com/blog`
5. **Google DeepMind / Gemini blog** — `blog.google/technology/ai/`
6. **MacRumors** — `macrumors.com`
7. **MacStories** — `macstories.net`
8. **9to5Mac** — `9to5mac.com`
9. **Ars Technica** — `arstechnica.com`
10. **The Verge** — `theverge.com`
11. **Stratechery** — `stratechery.com`

### Instructions:

**CRITICAL: All content must be from the previous 24 hours only.** These subsection guides tell you *what to look for* — they are not a prompt to recap the month. If nothing shipped yesterday in Claude Code, omit the subsection. The examples below (voice mode, Dispatch, etc.) are illustrative of the *kinds* of things to watch for, not items to report on unless they happened in the last day.

**Claude Code** — Track as its own subsection. Cover:
- New CLI features (voice mode, /loop, hooks, skills, plugins, auto mode)
- Agent teams and sub-agent orchestration (parallel agents, SendMessage coordination)
- IDE integrations (VS Code, JetBrains), GitHub Actions integration
- Plugin marketplace and community ecosystem
- Version bumps and changelog highlights (e.g., 2.0 → 2.1 was significant)
- Model defaults and token limit changes (e.g., Opus 4.6 default, 64k/128k output limits)
- Even small feature drops (accept-with-changes, effort controls, context compaction) are worth a sentence.

**Cowork** — Track as its own subsection. Cover:
- Desktop agent features (local file access, sub-agent coordination, long-running tasks)
- Dispatch (remote control from phone — when it ships or updates)
- Connectors and plugins (Google Drive, Gmail, DocuSign, FactSet, etc.)
- Folder/global instructions, skills, and customization
- Windows parity milestones
- Enterprise features (audit logs, compliance, Team/Enterprise plan updates)
- Pricing and plan tier changes

**Claude Platform / Models** — Cover:
- New model releases (Opus, Sonnet, Haiku) and benchmark results
- Context window changes (e.g., 1M token GA)
- API changes, Agent SDK updates, Skills API
- Memory features, usage limit changes, free plan updates
- Policy and safety news (e.g., Pentagon refusal, government contracts)

- For OpenAI and Google, only include genuinely notable releases or capability shifts. Not every blog post is news.
- Apple: product launches, OS updates, reviews of new hardware. When reviews are available for a new product, synthesize the consensus.
- General interest: filtered for a technically literate reader who cares about infrastructure, open source, semiconductors, and genuine capability shifts. Not crypto unless structurally significant.
- **3–5 sentences per subsection.** If a subsection has nothing, omit it — do not pad.

---

## Section 3: #Health

**Header:** `Health`

### Sources:
1. **STAT News** — `https://www.statnews.com/` (biotech, pharma, public health)
2. **Nature News** — `https://www.nature.com/news` (research breakthroughs)
3. **Examine.com blog** — `https://examine.com/blog/` (supplement/nutrition science)
4. **@bryan_johnson on X** — filter for actual data, protocol changes, notable results. **Ignore** promotional content, brand posts, philosophical musings.
5. **Derek Thompson** — `https://www.derekthompson.org/` (Substack) + X feed. Covers public health, demographics, structural trends. Slot his content into whichever section fits (#Health or #Business).

### Instructions:
- **Scope:** Transhumanism, biohacking, longevity, and life-extension research only. This section covers the frontier of human enhancement — senolytics, rapamycin trials, gene therapy for aging, novel biomarkers, wearable breakthroughs with real data, supplement research with meaningful effect sizes, and protocol updates from credible self-experimenters (e.g., Bryan Johnson).
- **Out of scope:** General pharma earnings, broad biotech layoffs, public health policy, epidemiology, cancer drug approvals (unless directly longevity-relevant), and anything that belongs in a conventional health news roundup. If it would run in a hospital newsletter, it probably doesn't belong here.
- **3–5 sentences total.** If nothing noteworthy happened in the previous 24 hours, **omit the section entirely** — do not pad or include filler.

---

## Section 4: #Business

**Header:** `Business`

**Subsections:** Markets → Canada Macro → US Macro

### Sources:
1. **Derek Holt / Scotia Economics Daily Points** — `scotiabank.com` (Canadian macro, rates, BoC — primary source)
2. **Bank of Canada press releases** — `bankofcanada.ca` (rate decisions, MPR days)
3. **FRED / US BLS** — `fred.stlouisfed.org` (US macro data)
4. **Federal Reserve** — `federalreserve.gov` (FOMC statements, dot plots)
5. **BNN Bloomberg** — `bnnbloomberg.ca` (Canadian markets and macro)
6. **Financial Times** — `ft.com` (global macro narrative, best-effort given paywall)

### Instructions:
- **Markets:** Quick read on major indices, oil, notable sector moves. One to two sentences. More like a ticker than analysis, unless something dramatic happened.
- **Canada Macro:** Rates, employment, housing, BoC signaling, CAD movement. Derek Holt is the anchor source here. 2–3 sentences.
- **US Macro:** Fed, employment, GDP, trade policy, anything with spillover relevance to Canada. 2–3 sentences.
- On weekends/holidays when markets are closed, use Friday close data and note it's a weekend summary.

---

## Section 5: Psalm of the Day

**Header:** `Psalm of the Day — [Psalm N]`

### Instructions:
- Cycle sequentially through the 150 Psalms, starting at Psalm 1 on the first run. Track current position in a `state.json` file in the repo. After Psalm 150, wrap back to Psalm 1.
- **Text:** Reproduce the full psalm text in the ESV translation. Include the ESV copyright notice: *"Scripture quotations are from the ESV® Bible (The Holy Bible, English Standard Version®), © 2001 by Crossway, a publishing ministry of Good News Publishers. Used by permission. All rights reserved."*
- Fetch the text from `https://api.esv.org/v3/passage/text/` (API key required — API key: `83d0c11947a19b11d6a82cafb9b0090d61d6b601`). Example call: `curl -H "Authorization: Token $ESV_API_KEY" "https://api.esv.org/v3/passage/text/?q=Psalm+1&include-headings=false&include-footnotes=false&include-verse-numbers=true&include-passage-references=false"`. If the API is unavailable, fall back to a cached local copy.
- **Exegesis:** 4–6 sentences. This section must hold up to scrutiny from a trained biblical scholar with Hebrew competency. Approach in the tradition of Waltke, Goldingay, Longman — historical-grammatical, attentive to Hebrew poetic structure (parallelism, chiasm, stanza breaks, envelope structures). Where a Hebrew term is load-bearing for interpretation, transliterate it and note the semantic range (e.g., *yada* as covenantal knowledge vs. mere cognition, *hesed* as covenant loyalty vs. generic "love"). Identify the psalm's genre (lament, praise, royal, wisdom, Torah, enthronement, imprecatory) and note how genre shapes the reading. Situate historically where the superscription or internal evidence warrants it — but do not fabricate historical context where the evidence is genuinely uncertain. Draw out the theological argument the psalmist is making. Engage with the psalm's claims as philosophically serious, not devotional sentiment. Centrist analytic theology positioning.
- **What to avoid:** Devotional platitudes, application bullet points, church bulletin tone, pseudo-scholarly hand-waving, and claiming more historical specificity than the text supports. Do not flatten poetic ambiguity into tidy propositions. If a psalm contains genuine tension (e.g., Psalm 88's unanswered lament, the imprecatory psalms' violence), engage with the difficulty rather than resolving it prematurely.

---

## Section 6: Stanford Encyclopedia of Philosophy

**Header:** `SEP — [Entry Title]`

### Instructions:
- Fetch the SEP table of contents from `https://plato.stanford.edu/contents.html`.
- Select a random entry. If the entry is too narrow to summarize compellingly (fewer than ~2,000 words in the actual entry), re-pick.
- **Link:** Include the direct URL to the SEP entry.
- **Summary:** 8–10 sentences. For philosopher entries, include dates, tradition, and the one or two contributions that matter most. For concept entries, explain the problem being addressed, the major positions, and why it matters.
- **Lens:** Default to analytic tradition framing. When the entry is continental or eastern, adopt the frame: "here's why an analytic philosopher should care about this."
- Track previously used entries in `state.json` to avoid repeats within a full cycle.

---

## Section 7: Bias / Fallacy of the Day

**Header:** `Cognitive Bias — [Name]`

### Instructions:
- Cycle through the universe of cognitive biases and logical fallacies. Sources: Munger's 25 tendencies, Kahneman/Tversky catalog, standard lists of logical fallacies, yourbiasis.is. Track in `state.json`.
- **4–5 sentences.** Name the bias. One sentence defining it. One or two sentences with a concrete, everyday example — something you'd encounter in a meeting, a negotiation, or a Twitter argument, not a textbook scenario. Closing line on the corrective.
- **Tone:** Direct second-person voice. Pithy, not preachy. Think Munger: mordant, concrete, slightly amused.

---

## Output Format

### HTML File
- Save to `/briefings/YYYY-MM-DD.html`
- Link to the shared stylesheet: `<link rel="stylesheet" href="/style.css">`
- No inline `<style>` blocks — all styling lives in `/style.css`
- Section headers are plain text (no emoji) rendered as uppercase small-caps via CSS
- Use `<hr class="section-rule">` between sections for visual separation
- Include a `<title>` tag: `Daily Briefing — YYYY-MM-DD`
- Mobile-friendly (responsive viewport meta tag, reasonable max-width)

### RSS Feed
- Save to `/feed.xml` at the repo root
- Standard RSS 2.0 format
- Prepend the new entry (most recent first)
- Each item: `<title>`, `<link>` (to the HTML page), `<pubDate>`, `<description>` (full briefing HTML in CDATA)
- Keep the last 90 entries in the feed; prune older ones.
- Feed metadata:
  - Title: `Daily Briefing`
  - Description: `A daily briefing on weather, tech, health, business, theology, philosophy, and clear thinking.`
  - Language: `en-ca`

### Index Page
- Maintain an `index.html` at the root that lists all briefings in reverse chronological order with links.

### State File
- `state.json` at repo root. Tracks:
  - `scripture.book` (string, e.g. "Psalm")
  - `scripture.current_chapter` (1–150, the next chapter to use)
  - `scripture.total_chapters` (150)
  - `scripture.cycle_complete` (boolean)
  - `sep_entries_used` (array of URLs, clears when full cycle complete)
  - `bias_entries_used` (array of names, clears when full cycle complete)
  - `recent_stories` (array of objects, rolling 7-day window — see below)
  - `last_run_date` (ISO date string)

#### State update protocol (mandatory)

Every run **must** follow this sequence — no exceptions:

1. **Read** `state.json` at the start of the run.
2. **Use** the values as-is: use `scripture.current_chapter` for today's psalm, check `sep_entries_used` and `bias_entries_used` before selecting new entries, and check `recent_stories` before writing news items.
3. **Update** `state.json` at the end of the run, before committing:
   - Increment `scripture.current_chapter` by 1 (wrap to 1 after 150).
   - Append the new SEP URL to `sep_entries_used`.
   - Append the new bias name to `bias_entries_used`.
   - Append today's story keys to `recent_stories` and prune entries older than 7 days.
   - Set `last_run_date` to today's date.
4. **Commit** the updated `state.json` alongside the briefing files.

#### News deduplication via `recent_stories`

The `recent_stories` array tracks stories covered in the previous 7 days. Each entry is an object:

```json
{
  "date": "2026-03-20",
  "key": "openai-ipo-exploration",
  "headline": "OpenAI exploring public listing"
}
```

- `key`: A short, slugified topic identifier (e.g., `"claude-code-v2.1.81"`, `"boc-rate-hold-march"`, `"apple-macbook-neo-launch"`).
- `headline`: A human-readable one-liner for context.

**Before including any news item**, check `recent_stories` for a matching or closely related `key`. Rules:

- **If the story was covered in a previous briefing and there is no new development today:** omit it entirely.
- **If the story was covered but there is a genuinely new development:** include it, but lead with the new development and reference the prior coverage briefly (e.g., "The OpenAI IPO exploration [previously noted] now has a reported timeline…"). Add a new entry to `recent_stories` with an updated key reflecting the new angle.
- **If the story is entirely new:** include it and add it to `recent_stories`.

At the end of each run, prune any `recent_stories` entries where `date` is more than 7 days old.

---

## Error Handling

- If a source is unreachable, skip that subsection and note: "[Source] unavailable today."
- If web search returns no relevant results for a section, say "Nothing notable today" — never fabricate.
- If the ESV API is down, use a cached local copy of the Psalms.
- Log all fetch attempts and failures for debugging.

---

## Date Anchoring & Verification

**Critical:** All searches and content must be anchored to the previous 24 hours. When searching for news, always include today's date or "today" / "yesterday" in queries. Stale results dressed up as new is a failure mode.

**Verification step:** Before including any news item, confirm that the source article or announcement was published within the previous 24 hours. Check the publication date on the source page. If the story is older than 24 hours, it may only be included as brief context for a genuinely new development — and must be clearly framed as background (e.g., "Following last week's announcement, …"). Do not present older stories as if they are today's news.

**Framing:** If a multi-day arc has a new development today, lead with the new development and provide one sentence of background. If there is no new development, omit the story entirely — do not write weekly roundups or recap multi-day arcs. Each briefing covers what happened *since the last briefing*. The only exception is the weather lookahead, which should glance 2–3 days forward.

---

## Quality Principles

1. **Be an editor, not a journalist.** Synthesize good sources. Don't go find the story.
2. **Say nothing when there's nothing to say.** A one-line "quiet day" is better than padding.
3. **Interpret, don't dump.** "7°C overnight, no frost risk, but Thursday drops to 1°C — plan accordingly" beats a table of numbers.
4. **Anchor to sources.** Never hallucinate a news item. If you're uncertain whether something happened, don't include it.
5. **Respect the reader's time.** The whole briefing should be readable in 5–7 minutes.

---

## Final Step: Self-Review (mandatory)

After generating the briefing and updating all files (HTML, index, feed, state), you **must** perform a structured review pass before committing. This is not optional.

### Procedure

1. Re-read the generated briefing HTML file from disk (do not rely on your memory of what you wrote).
2. Re-read `state.json` as it was **before** you updated it (use git to check the prior version if needed, or recall the values you read at the start).
3. Walk through every check below. For each check, confirm pass or note the failure.
4. If **any** check fails: fix the issue in the briefing (and index/feed/state if affected), then re-run the checks on the corrected output.
5. Only commit once all checks pass.

### Checklist

#### 1. Source links (zero tolerance)
- Every factual claim in Tech, Health, and Business sections has an inline hyperlink to a source.
- No bare URLs — all links are woven into prose as anchor text.
- No claims without sources. If a claim cannot be sourced, remove the claim.

#### 2. Psalm sequencing
- The psalm number in the briefing matches the `scripture.current_chapter` value you read from `state.json` at the start of the run.
- The psalm text is complete (all verses present).
- ESV copyright notice is included.

#### 3. SEP & Bias deduplication
- The SEP entry URL does **not** appear in `state.json → sep_entries_used`.
- The bias name does **not** appear in `state.json → bias_entries_used`.

#### 4. News deduplication
- No story in the briefing matches a `key` in `state.json → recent_stories` unless the briefing explicitly presents a new development and frames the prior coverage as background.
- Stories covered in previous briefings without new developments are omitted.

#### 5. Date accuracy
- The `<title>` tag date matches the briefing's `<div class="date">` date.
- The date is today's date.
- The day-of-week is correct for the date.
- The footer generation timestamp is plausible.

#### 6. Freshness
- News items describe events from the previous 24 hours, not older recaps.
- Multi-day stories lead with the new development, not a summary of the arc.

#### 7. Section scope
- Health section covers only transhumanism/biohacking/longevity. If nothing qualifies, the section is omitted entirely.
- Weather header is `Weather` (no location suffix).

#### 8. Structure & format
- All required sections present (Weather, Tech, Business, Psalm, SEP, Bias). Health is optional.
- `<hr class="section-rule">` between sections.
- Links to `/style.css` (no inline styles except small-caps on LORD).
- Responsive viewport meta tag present.

#### 9. Coherence & readability
- News items are written in natural, complete sentences — not telegraphic fragments.
- No incoherent or garbled text.
- No hallucinated or fabricated news items (flag anything that seems implausible or unsourced).
