---
name: research-it
description: Research a topic on the Internet and report back in Lee's preferred format. Use this skill whenever the user asks you to research, look up, investigate, or summarize anything from the web — whether it's a quick triage ("is this worth my time?") or a deep dive into concepts and patterns. Also trigger when the user asks "what is X", "how does X work", "explain X to me", or "give me the rundown on X". Always use this skill before answering research questions from memory alone — go look it up.
---

# Research Skill

Research a topic and report back clearly. Two modes depending on what's asked.

---

## Mode 1: Triage

> "Is this worth my time / money / attention?"

Punch card format. No fluff. Keep it tight.

```
**What it is:** One sentence.
**Problem it solves:** One sentence.
**Who it's for:** One sentence.
**Where it shines:** 2-3 bullets max.
**Where it falls flat:** 2-3 bullets max.
**vs. what Lee already uses:** Direct comparison if applicable.
**Verdict:** Worth pursuing? Yes / No / Maybe — one sentence why.
**Sources:** Cite all of them.
```

---

## Mode 2: Deep Dive

> "I want to really understand this — concepts, patterns, mental model."

### Structure

**1. The Analogy**
Lead with an analogy to something Lee already knows. Ground it in dev, systems, or music. Make it land fast.

**2. The Mental Model Diagram**
Always include a visual — ASCII diagram, flowchart, or boxes+arrows. Show relationships and flow, not just a list of parts. This is non-negotiable.

Example formats:

```
[Input] → [Process A] → [Process B] → [Output]
               ↓
          [Side Effect]
```

or

```
┌─────────────┐     ┌─────────────┐
│  Component A│────▶│  Component B│
└─────────────┘     └─────────────┘
        │
        ▼
┌─────────────┐
│  Component C│
└─────────────┘
```

**3. Core Concepts** (in order of importance)
Each concept gets:

- Name + one-line definition
- Why it matters
- How it connects to the mental model

**4. Patterns**
What are the recurring patterns in how this thing is used? Think design patterns, not just features.

**5. Where it fits / Where it breaks**
Be honest. Where does this shine? Where does it fall apart or get misused?

**6. Go Deeper**
2-3 curated links if Lee wants to pull the thread further. Prefer official docs, well-regarded blog posts, or conference talks over SEO content farms.

**7. Sources**
Cite everything used to build this response. Every claim that came from somewhere gets a link.

---

## The IDK Rule (Most Important Rule)

If something is uncertain, incomplete, or potentially out of date — **say so explicitly**.

Format:

> ⚠️ **Not sure:** [What I'm uncertain about and why. What you'd want to verify.]

Do NOT:

- State uncertain things as fact
- Fill gaps with plausible-sounding bullshit
- Hedge so softly it reads like confidence

A blank with an explanation is 3x better than a confident wrong answer.

---

## Formatting Rules

- **No walls of text.** Use headers, whitespace, and short paragraphs.
- **Diagrams before prose** when explaining architecture or flow.
- **Bold the signal.** Key terms, verdicts, warnings — bold them so they're scannable.
- **Cite everything.** Every specific claim gets a source. No exceptions.
- **Short sentences.** If a sentence needs a semicolon, split it.

---

## Research Process

1. Search broadly first (2-3 queries to orient)
2. Fetch primary sources — official docs, spec pages, authoritative blog posts
3. Cross-reference at least 2 sources for any factual claim
4. If sources conflict → flag it with ⚠️ and show both
5. Build the response bottom-up (understand it yourself first, then write)

---

## Mode Selection

| Signal                                                             | Mode                                                   |
| ------------------------------------------------------------------ | ------------------------------------------------------ |
| "is this worth it", "should I use", "what is"                      | Triage                                                 |
| "how does it work", "explain", "deep dive", "concepts", "patterns" | Deep Dive                                              |
| Ambiguous                                                          | Ask one question: "Quick triage or full mental model?" |
