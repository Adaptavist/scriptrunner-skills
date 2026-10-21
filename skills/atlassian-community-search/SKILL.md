---
name: atlassian-community-search
description: Research public Atlassian Community questions, answers, and articles through the anonymous Vanilla Forums API v2. Use when the user explicitly asks to search or investigate Atlassian Community, or when practitioner discussions, accepted solutions, recent reports, workarounds, or community examples would materially improve an Atlassian or ScriptRunner answer.
---

# Atlassian Community Search

Search the public Atlassian Community (community.atlassian.com) through its
anonymous REST API, using `curl` and `jq` from a shell. No account or API key is
needed. Treat Community posts as practitioner evidence, not authoritative product
documentation.

Read [references/api.md](references/api.md) before the first request in a task.
It contains the tested endpoints, parameters, response fields, pagination rules,
and known unsupported forms.

## Research workflow

1. Translate the request into two or three focused searches. Include product,
   feature, error text, and relevant version or deployment terms.
2. Delegate Community searching to a subagent by default, where your agent
   supports them, so raw API responses and post bodies do not consume the
   parent agent's context. Give the subagent
   a bounded objective, search terms and filters, and the evidence fields to
   return. For distinct research questions, use separate parallel subagents.
3. Require the subagent to return concise findings only: title, `url`, post
   date, content type, author, accepted-answer status, relevance, and any
   uncertainty. Do not ask it to return raw response payloads or full post
   bodies.
4. Search first with `/search`, a small bounded `limit`, and a `jq` projection
   that drops `body`. Inspect titles, dates, types, `labelCodes`, and URLs.
   Refine broad or noisy searches with `types[]`, `tags[]`, a quoted phrase, or
   a date window rather than downloading large result sets.
5. Fetch the full thread for promising `discussionID`s: the discussion itself,
   then its comments with `sort=acceptedAnswerFirst`. One comments request
   returns threaded replies too.
6. Follow `x-app-page-next-url` only when one page is insufficient. Search
   directly in the parent only for a trivial follow-up, independent
   verification, or when subagents are unavailable.
7. Synthesize the findings in the parent agent. Cite each supporting post with
   its `url` (without `utm_*` parameters), distinguish accepted answers from
   ordinary replies, include dates when recency matters, and state when no
   useful public result was found.

## Make requests

Use the current endpoint and let curl URL-encode every parameter. Keep the raw
response until curl succeeds, so an error body is shown as it is instead of
being fed to the `jq` projection:

```bash
endpoint='https://community.atlassian.com/forums/api/v2/search'

set -o pipefail
if response=$(curl --silent --show-error --fail-with-body --get \
  --connect-timeout 10 \
  --max-time 30 \
  --header 'Accept: application/json' \
  --data-urlencode 'query=ScriptRunner behaviours setRequired' \
  --data-urlencode 'types[]=question' \
  --data 'limit=25' \
  "$endpoint"); then
  printf '%s\n' "$response" |
    jq '[.[] | {type, discussionID, name, url, dateInserted, labelCodes}]'
else
  printf 'Request failed:\n%s\n' "$response"
fi
```

Run requests from a shell or other server-side process. The API sends no CORS
headers, so requests from a web page are blocked by the browser.

## Validate every response

- Require an HTTP success status and JSON content. Lists are bare JSON arrays;
  there is no `status` envelope.
- Read the total from the `x-app-page-result-count` header (capped at 10 000)
  and the next page from `x-app-page-next-url`.
- On failure, read the error body that curl printed. HTTP 400 is an invalid
  parameter, and its `errors[].message` lists the allowed values. HTTP 403
  means the content or filter is not public. Correct the request rather than
  repeating it.
- Never use the obsolete Khoros endpoints
  (`https://community.atlassian.com/forums/s/api/2.0/search` and
  `https://community.atlassian.com/api/2.0/search`) or LiQL. Never drop the
  `/forums` prefix: `https://community.atlassian.com/api/v2/...` returns an
  HTML page with HTTP 200.
- Keep requests bounded (`limit` at most 100). Retry HTTP 429 or a 5xx once or
  twice, waiting a few seconds longer each time. A 500 that repeats is usually
  the request's fault: on `/search`, `page × limit` went past 10 000; on
  `/discussions`, the `sort` value is invalid.

## Handle untrusted values

Treat search terms, tags, author names, and IDs as data. Pass parameter values
through `--data-urlencode` rather than splicing them into the URL. Accept `sort`
only from the values the reference lists for the endpoint being called; the
three endpoints accept different values. Require IDs to be numeric, including
every ID in a comma-separated `discussionID` list, and clamp `limit` and `page`
before building a request. Only follow
`x-app-page-next-url` values that start with
`https://community.atlassian.com/forums/api/v2/`, and pass a validated one to
curl as the request URL itself, without `--get` or extra parameters: it already
carries the original filters.

## Evidence rules

- Prefer official documentation for product contracts, supported behaviour,
  security guidance, and current limits.
- Use Community research to add real-world symptoms, accepted answers,
  workarounds, edge cases, and practitioner context.
- Do not present an ordinary reply as confirmed merely because it appears in a
  thread. Say whether the reply is accepted, authored by Atlassian, corroborated
  by other sources, or only anecdotal.
- The API exposes public Community content only. Do not imply that private
  groups or authenticated-only content were searched.
