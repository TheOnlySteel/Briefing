# Daily Briefing — Claude Code Instruction Set

## Overview

Generate a daily morning briefing as an HTML page and an RSS feed entry. Deploy to Netlify via git push. The briefing is designed to be read via RSS and should be self-contained, well-formatted, and concise.

**Schedule:** Run daily via GitHub Actions cron at 5:30 AM Pacific.  
**Output:** One dated HTML file + updated `feed.xml` at the site root.  
**Tone:** Informed, concise, literate. Write like a smart human editor, not a data dump. Dry wit is welcome; forced humor is not. If nothing notable happened in a section, say "Quiet day in [section]" — never pad.  
**Audience:** A curious, analytically minded generalist in the eastern Fraser Valley, BC.

---

## Section 1: Weather

**Header:** `☀️ Weather — Chilliwack / Agassiz`

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

**Header:** `💻 #Tech`

**Subsections:** AI / Claude → Competitors → Apple → General Interest

### Sources (fetch in order of priority):
1. **Anthropic team members on X** — the ground-level sources where feature news breaks first. Key accounts: `@noahzweben` (Claude Code), `@felixrieseberg` (Claude Code), `@alexalbert__` (Claude product). Check these before the corporate channels.
2. **Anthropic blog / changelog** — `https://www.anthropic.com/news` and `https://www.anthropic.com/engineering` — for official announcements, model releases, and policy updates.
3. **OpenAI blog** — `https://openai.com/blog`
4. **Google DeepMind / Gemini blog** — `https://blog.google/technology/ai/`
5. **MacRumors** — `https://www.macrumors.com/` (Apple breaking news)
6. **MacStories** — `https://www.macstories.net/` (Apple depth/reviews)
7. **Six Colors** — `https://sixcolors.com/` (Jason Snell, concise Apple commentary)
8. **Ars Technica** — `https://arstechnica.com/`
9. **The Verge** — `https://www.theverge.com/`
10. **Stratechery** — `https://stratechery.com/` (Ben Thompson, framework analysis)
11. **Hacker News front page** — `https://news.ycombinator.com/` (signal filter for what technical community cares about)

### Instructions:
- Lead with Claude/Anthropic updates. Even minor feature drops are worth noting.
- For OpenAI and Google, only include genuinely notable releases or capability shifts. Not every blog post is news.
- Apple: product launches, OS updates, reviews of new hardware. When reviews are available for a new product, synthesize the consensus.
- General interest: filtered for a technically literate reader who cares about infrastructure, open source, semiconductors, and genuine capability shifts. Not crypto unless structurally significant.
- **3–5 sentences per subsection.** If a subsection has nothing, omit it — do not pad.

---

## Section 3: #Health

**Header:** `🧬 #Health`

### Sources:
1. **STAT News** — `https://www.statnews.com/` (biotech, pharma, public health)
2. **Nature News** — `https://www.nature.com/news` (research breakthroughs)
3. **Examine.com blog** — `https://examine.com/blog/` (supplement/nutrition science)
4. **@bryan_johnson on X** — filter for actual data, protocol changes, notable results. **Ignore** promotional content, brand posts, philosophical musings.
5. **Derek Thompson** — `https://www.derekthompson.org/` (Substack) + X feed. Covers public health, demographics, structural trends. Slot his content into whichever section fits (#Health or #Business).

### Instructions:
- Biotech: new treatments, longevity research, notable trial results.
- Biohacking/optimization: new findings on supplements, training, sleep, anything with real data.
- Public health: epidemiology, policy shifts, population-level significance.
- **3–5 sentences total.** Say "Quiet day in health/biotech" if nothing notable.

---

## Section 4: #Business

**Header:** `📈 #Business`

**Subsections:** Markets → Canada Macro → US Macro

### Sources:
1. **Derek Holt / Scotia Economics Daily Points** — `https://www.scotiabank.com/ca/en/about/economics/economics-publications.daily-points.html` (Canadian macro, rates, BoC — primary source, published daily on business days)
2. **Bank of Canada press releases** — `https://www.bankofcanada.ca/` (rate decisions, MPR days)
3. **FRED / US BLS** — `https://fred.stlouisfed.org/` (US macro data)
4. **Matt Levine's Money Stuff** — Bloomberg newsletter archive (markets + context, daily on business days)
5. **Financial Times** — `https://www.ft.com/` (global macro narrative, best-effort given paywall — use freely available headlines and summaries)

### Instructions:
- **Markets:** Quick read on major indices, oil, notable sector moves. One to two sentences. More like a ticker than analysis, unless something dramatic happened.
- **Canada Macro:** Rates, employment, housing, BoC signaling, CAD movement. Derek Holt is the anchor source here. 2–3 sentences.
- **US Macro:** Fed, employment, GDP, trade policy, anything with spillover relevance to Canada. 2–3 sentences.
- On weekends/holidays when markets are closed, use Friday close data and note it's a weekend summary.

---

## Section 5: Psalm of the Day

**Header:** `📖 Psalm of the Day`

### Instructions:
- Cycle sequentially through the 150 Psalms, starting at Psalm 1 on the first run. Track current position in a `state.json` file in the repo. After Psalm 150, wrap back to Psalm 1.
- **Text:** Reproduce the full psalm text in the ESV translation. Include the ESV copyright notice: *"Scripture quotations are from the ESV® Bible (The Holy Bible, English Standard Version®), © 2001 by Crossway, a publishing ministry of Good News Publishers. Used by permission. All rights reserved."*
- Fetch the text from `https://api.esv.org/v3/passage/text/` (API key required — store in GitHub secrets as `ESV_API_KEY`) or from a local ESV text file.
- **Exegesis:** 4–6 sentences. This section must hold up to scrutiny from a trained biblical scholar with Hebrew competency. Approach in the tradition of Waltke, Goldingay, Longman — historical-grammatical, attentive to Hebrew poetic structure (parallelism, chiasm, stanza breaks, envelope structures). Where a Hebrew term is load-bearing for interpretation, transliterate it and note the semantic range (e.g., *yada* as covenantal knowledge vs. mere cognition, *hesed* as covenant loyalty vs. generic "love"). Identify the psalm's genre (lament, praise, royal, wisdom, Torah, enthronement, imprecatory) and note how genre shapes the reading. Situate historically where the superscription or internal evidence warrants it — but do not fabricate historical context where the evidence is genuinely uncertain. Draw out the theological argument the psalmist is making. Engage with the psalm's claims as philosophically serious, not devotional sentiment. Centrist analytic theology positioning.
- **What to avoid:** Devotional platitudes, application bullet points, church bulletin tone, pseudo-scholarly hand-waving, and claiming more historical specificity than the text supports. Do not flatten poetic ambiguity into tidy propositions. If a psalm contains genuine tension (e.g., Psalm 88's unanswered lament, the imprecatory psalms' violence), engage with the difficulty rather than resolving it prematurely.

---

## Section 6: Stanford Encyclopedia of Philosophy

**Header:** `🏛️ SEP — [Entry Title]`

### Instructions:
- Fetch the SEP table of contents from `https://plato.stanford.edu/contents.html`.
- Select a random entry. If the entry is too narrow to summarize compellingly (fewer than ~2,000 words in the actual entry), re-pick.
- **Link:** Include the direct URL to the SEP entry.
- **Summary:** 8–10 sentences. For philosopher entries, include dates, tradition, and the one or two contributions that matter most. For concept entries, explain the problem being addressed, the major positions, and why it matters.
- **Lens:** Default to analytic tradition framing. When the entry is continental or eastern, adopt the frame: "here's why an analytic philosopher should care about this."
- Track previously used entries in `state.json` to avoid repeats within a full cycle.

---

## Section 7: Bias / Fallacy of the Day

**Header:** `🧠 Cognitive Bias of the Day: [Name]`

### Instructions:
- Cycle through the universe of cognitive biases and logical fallacies. Sources: Munger's 25 tendencies, Kahneman/Tversky catalog, standard lists of logical fallacies, yourbiasis.is. Track in `state.json`.
- **4–5 sentences.** Name the bias. One sentence defining it. One or two sentences with a concrete, everyday example — something you'd encounter in a meeting, a negotiation, or a Twitter argument, not a textbook scenario. Closing line on the corrective.
- **Tone:** Direct second-person voice. Pithy, not preachy. Think Munger: mordant, concrete, slightly amused.

---

## Output Format

### HTML File
- Save to `/briefings/YYYY-MM-DD.html`
- Clean, readable HTML. Use a simple, consistent template with a serif font for body text, clear section headers, and adequate whitespace.
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
  - `psalm_number` (1–150, wraps)
  - `sep_entries_used` (array of URLs, clears when full cycle complete)
  - `bias_entries_used` (array of names, clears when full cycle complete)
  - `last_run_date` (ISO date string)

---

## Error Handling

- If a source is unreachable, skip that subsection and note: "[Source] unavailable today."
- If web search returns no relevant results for a section, say "Nothing notable today" — never fabricate.
- If the ESV API is down, use a cached local copy of the Psalms.
- Log all fetch attempts and failures for debugging.

---

## Date Anchoring

**Critical:** All searches and content must be anchored to the previous 24 hours. When searching for news, always include today's date or "today" / "yesterday" in queries. Stale results dressed up as new is a failure mode. If a story is more than 24 hours old, it's not news — it's context. Do not write weekly roundups or summarize multi-day arcs. Each briefing covers what happened *since the last briefing*. The only exception is the weather lookahead, which should glance 2–3 days forward.

---

## Quality Principles

1. **Be an editor, not a journalist.** Synthesize good sources. Don't go find the story.
2. **Say nothing when there's nothing to say.** A one-line "quiet day" is better than padding.
3. **Interpret, don't dump.** "7°C overnight, no frost risk, but Thursday drops to 1°C — plan accordingly" beats a table of numbers.
4. **Anchor to sources.** Never hallucinate a news item. If you're uncertain whether something happened, don't include it.
5. **Respect the reader's time.** The whole briefing should be readable in 5–7 minutes.
