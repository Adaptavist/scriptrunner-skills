---
name: atlassian-community-search
description: Research public Atlassian Community questions, answers, and articles through the anonymous Khoros Community API v2 and LiQL. Use when the user explicitly asks to search or investigate Atlassian Community, or when practitioner discussions, accepted solutions, recent reports, workarounds, or community examples would materially improve an Atlassian or ScriptRunner answer.
---

# Atlassian Community Search

Use the public Community API directly from the shell. Treat Community posts as
practitioner evidence, not authoritative product documentation.

Read [references/liql.md](references/liql.md) before the first query in a task.
It contains the tested fields, query templates, pagination rules, and known
unsupported operations.

## Research workflow

1. Translate the request into two or three focused searches. Include product,
   feature, error text, and relevant version or deployment terms.
2. Delegate Community searching to a subagent by default so raw API responses
   and post bodies do not consume the parent agent's context. Give the subagent
   a bounded objective, search terms and filters, and the evidence fields to
   return. For distinct research questions, use separate parallel subagents.
3. Require the subagent to return concise findings only: title, `view_href`,
   post date, content type, author, accepted-solution status, relevance, and
   any uncertainty. Do not ask it to return raw response payloads or full post
   bodies.
4. Query root messages first with explicit fields and a small bounded limit.
   Inspect subjects, dates, content types, authors, and URLs. Refine broad or
   noisy searches rather than downloading large result sets.
5. Fetch the full body for promising message IDs. For Q&A, query direct replies
   and identify `is_solution = true`; recursively follow reply IDs only when
   nested discussion matters.
6. Use cursor pagination only when one page is insufficient. Search directly in
   the parent only for a trivial follow-up, independent verification, or when
   subagents are unavailable.
7. Synthesize the findings in the parent agent. Cite each supporting post with
   its `view_href`,
   distinguish accepted solutions from ordinary replies, include dates when
   recency matters, and state when no useful public result was found.

## Make requests

Use the current endpoint and URL-encode the complete LiQL query:

```bash
endpoint='https://community.atlassian.com/forums/s/api/2.0/search'
query="SELECT id, subject, view_href, post_time, author, conversation FROM messages WHERE depth = 0 AND (subject MATCHES 'ScriptRunner' OR body MATCHES 'ScriptRunner') ORDER BY post_time DESC LIMIT 25"

set -o pipefail
curl --silent --show-error --fail-with-body --get \
  --connect-timeout 10 \
  --max-time 30 \
  --header 'Accept: application/json' \
  --data-urlencode "q=${query}" \
  "$endpoint" | jq .
```

Run requests from the agent shell. Browser-origin requests are rejected by the
Community API's cross-origin policy.

## Validate every response

- Require an HTTP success status, JSON content, and top-level
  `status = "success"`.
- Read results from `data.items`; use `data.size` and `data.next_cursor` for
  paging.
- Treat HTTP 400 with `status = "error"` as an invalid LiQL query and simplify
  or correct it.
- Never use the obsolete `https://community.atlassian.com/api/2.0/search`
  endpoint. It can return an HTML page with HTTP 200.
- Keep requests bounded and retry transient 429 or 5xx responses with backoff.

## Handle untrusted values

Treat search terms, tags, author names, IDs, and cursor values as data. Escape a
single quote inside a LiQL string literal by doubling it (`'` becomes `''`). Do
not interpolate unescaped user input. Accept sort directions only from the
fixed values `ASC` and `DESC`, and clamp numeric limits and offsets before
constructing a query.

## Evidence rules

- Prefer official documentation for product contracts, supported behaviour,
  security guidance, and current limits.
- Use Community research to add real-world symptoms, accepted solutions,
  workarounds, edge cases, and practitioner context.
- Do not present an ordinary reply as confirmed merely because it appears in a
  thread. Say whether the reply is accepted, authored by Atlassian, corroborated
  by other sources, or only anecdotal.
- The API exposes public Community content only. Do not imply that private
  groups or authenticated-only content were searched.
