# Atlassian Community API reference

Atlassian Community moved from Khoros to Vanilla Forums in September 2026. The
Khoros LiQL endpoint now returns HTTP 404. Everything below was verified
anonymously against the live Vanilla API v2 on 2026-10-21. Re-run
the smoke request if the service contract appears to have changed.

## Endpoint and response

```text
GET https://community.atlassian.com/forums/api/v2/<resource>?<query parameters>
```

No authentication is required for public content. Note the `/forums` prefix:
`https://community.atlassian.com/api/v2/...` serves the HTML site with HTTP 200.

A successful response is a bare JSON array (lists) or object (single record),
not an envelope. Paging metadata is in the response headers:

| Header                    | Meaning                                          |
| ------------------------- | ------------------------------------------------ |
| `x-app-page-result-count` | Total matches, capped at `10000`                 |
| `x-app-page-current`      | Current page number                              |
| `x-app-page-limit`        | Page size in effect                              |
| `x-app-page-next-url`     | Absolute URL of the next page; absent at the end |
| `link`                    | The same `first` / `next` / `last` URLs          |

Errors are JSON objects with `message` and `status` (or `code`). Validation
failures are HTTP 400 and list the allowed enum values in `errors[].message`,
which is the quickest way to discover a valid `sort` or `types` value.

## Smoke request

```bash
curl --silent --show-error --fail-with-body \
  'https://community.atlassian.com/forums/api/v2/discussions?limit=1' |
  jq '.[0] | {discussionID, name, url}'
```

## Content model

| Khoros (old)                   | Vanilla (new)                                                      |
| ------------------------------ | ------------------------------------------------------------------ |
| Topic (`depth = 0`)            | Discussion, `discussionID`                                         |
| Reply (`depth > 0`)            | Comment, `commentID`; `depth` 1 is a direct answer, 2+ is threaded |
| `conversation.style = 'qanda'` | Discussion `type = question`                                       |
| `conversation.style = 'blog'`  | Discussion `type = discussion` in an `*-articles-board` category   |
| `conversation.solved = true`   | `statusID = 3` / `attributes.question.status = accepted`           |
| `is_solution = true`           | Comment `attributes.answer.status = accepted`                      |
| Board                          | Category, `categoryID`                                             |

Discussion IDs carried over from Khoros message IDs, so an ID from an old link
still resolves. Legacy `community.atlassian.com/t5/.../qaq-p/<id>` links redirect
to `/forums/discussion/<id>/<slug>`; cite the new `url`.

Question status (`statusID` on questions, `attributes.question.status`):

| `statusID` | Status       |
| ---------- | ------------ |
| `1`        | `unanswered` |
| `2`        | `answered`   |
| `3`        | `accepted`   |

## Search (`/search`)

Full-text search across discussions and comments, ranked by relevance. This is
the main entry point.

```bash
curl --silent --show-error --fail-with-body --get \
  --data-urlencode 'query=behaviours setRequired' \
  --data-urlencode 'types[]=question' \
  --data-urlencode 'tags[]=scriptrunner' \
  --data 'limit=25' \
  'https://community.atlassian.com/forums/api/v2/search' |
  jq '[.[] | {recordType, type, discussionID, recordID, name, url, dateInserted, labelCodes, highlight}]'
```

| Parameter           | Tested behaviour                                                                                                                                                                     |
| ------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `query`             | Full-text terms; stemmed and fuzzy. Wrap a phrase in double quotes (`"field behaviours"`) to narrow sharply                                                                          |
| `name`              | Match on title only                                                                                                                                                                  |
| `types[]`           | `question`, `discussion` (articles and other non-question posts), `answer` (comments on questions), `comment`, `idea`, `poll`, `event`, `article`, … `article` is empty on this site |
| `recordTypes[]`     | `discussion` or `comment`                                                                                                                                                            |
| `tags[]`            | Tag name; repeat for several. `tagOperator=and` or `or`. A bare `tags=x` is rejected with HTTP 400                                                                                   |
| `categoryID`        | One category; add `includeChildCategories=1` to widen. Some categories return HTTP 403                                                                                               |
| `discussionID`      | Restrict to one thread (its discussion plus comments)                                                                                                                                |
| `insertUserNames[]` | Author display name, exact                                                                                                                                                           |
| `statusID`          | Question status, see table above                                                                                                                                                     |
| `dateInserted`      | `>=2026-01-01`, `<2025-06-30`, or a range `[2025-01-01,2025-06-30]`                                                                                                                  |
| `sort`              | `relevance` (default), `dateInserted`, `dateUpdated`, `dateLastComment`, `score`, `hot`, each also descending with a `-` prefix                                                      |
| `limit`             | 1 to 100; above 100 is HTTP 400                                                                                                                                                      |
| `page`              | `page × limit` must stay within 10 000, otherwise HTTP 500                                                                                                                           |
| `expand`            | `insertUser` adds the author object; `-body` drops the HTML body                                                                                                                     |

Result fields: `recordType`, `type`, `recordID`, `discussionID`, `name`, `url`,
`dateInserted`, `insertUserID`, `categoryID`, `breadcrumbs`, `labelCodes`,
`highlight`, `searchScore`, `body` (HTML) and `bodyPlainText`. `labelCodes`
contains `Accepted` for an accepted answer comment or a solved question.

Search result `url`s carry `utm_*` tracking parameters; strip the query string
before citing. Titles (`name`) are HTML-escaped (`&quot;`, `&amp;`). Sorting by date throws away relevance and quickly surfaces loose
fuzzy matches, so only combine `-dateInserted` with tight filters (`types[]`,
`tags[]`, a quoted phrase or a `dateInserted` window). Unknown parameters are
ignored silently, and so are some unsupported filters (`labelCodes[]` changes
nothing), so check `x-app-page-result-count` moved when adding a filter.

## Discussions (`/discussions`)

Structured listing without full-text search. Use it for "latest in a tag or
category" and to fetch a known thread.

```bash
# Newest ScriptRunner questions
curl --silent --show-error --fail-with-body \
  'https://community.atlassian.com/forums/api/v2/discussions?tagID=10&type=question&sort=-dateInserted&limit=25&expand=excerpt' |
  jq '[.[] | {discussionID, name, url, dateInserted, countComments, status: .attributes.question.status, excerpt}]'

# One thread
curl --silent --show-error --fail-with-body \
  'https://community.atlassian.com/forums/api/v2/discussions/1426174' |
  jq '{discussionID, type, name, url, dateInserted, insertUser: .insertUser.name, countComments, countViews, status: .attributes.question.status, tags: [.tags[].name], body}'
```

| Parameter       | Tested behaviour                                                                                                                                           |
| --------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `type`          | `question` or `discussion`. An unknown value returns an empty list, not an error                                                                           |
| `tagID`         | Numeric tag ID (look it up with `/tags`)                                                                                                                   |
| `categoryID`    | Numeric category ID (look it up with `/categories/search`)                                                                                                 |
| `insertUserID`  | Numeric author ID (look it up with `/users/by-names`)                                                                                                      |
| `discussionID`  | Comma-separated IDs to batch-fetch known threads; check that every ID in the list is numeric                                                               |
| `dateInserted`  | Same comparison syntax as search                                                                                                                           |
| `sort`          | `dateInserted`, `dateLastComment`, `score`, `hot`, each also descending with a `-` prefix. Any other value, including `name` and `countViews`, is HTTP 500 |
| `expand`        | `excerpt` for a short plain-text summary; `all` for everything                                                                                             |
| `limit`, `page` | Keep `limit` at 100 or less; the endpoint does not enforce a cap                                                                                           |

Discussion fields: `discussionID`, `type`, `postTypeID`, `name`, `url`,
`canonicalUrl`, `body` (HTML), `format`, `dateInserted`, `dateLastComment`,
`insertUser`, `countComments`, `countViews`, `score`, `categoryID`, `tags`,
`statusID`, `closed` and `attributes.question` (`status`, `dateAnswered`,
`dateAccepted`). There is no view-count sort; sort client-side on `countViews`
if needed.

A missing ID is HTTP 404 with `{"message": "Discussion not found."}`.

## Comments (`/comments`)

```bash
# Accepted answer first, then the rest
curl --silent --show-error --fail-with-body \
  'https://community.atlassian.com/forums/api/v2/comments?discussionID=1426174&sort=acceptedAnswerFirst&limit=50' |
  jq '[.[] | {commentID, depth, parentCommentID, insertUser: .insertUser.name, dateInserted, score, accepted: (.attributes.answer.status == "accepted"), url, body}]'

# Only the accepted answer
curl --silent --show-error --fail-with-body \
  'https://community.atlassian.com/forums/api/v2/comments?discussionID=1426174&qna=accepted'
```

| Parameter       | Tested behaviour                                                                                                                           |
| --------------- | ------------------------------------------------------------------------------------------------------------------------------------------ |
| `discussionID`  | Every comment in the thread, threaded replies included                                                                                     |
| `qna`           | `accepted` returns accepted answers only; `rejected` is HTTP 403 anonymously                                                               |
| `sort`          | `dateInserted`, `dateUpdated`, `commentID`, `score`, `acceptedAnswerFirst`, `experimentalTrending`, each also descending with a `-` prefix |
| `limit`, `page` | As for discussions                                                                                                                         |

`/comments/<commentID>` fetches one comment. Threading uses `depth`,
`parentCommentID` and `countChildComments`; one `discussionID` request already
returns the nested replies, so no recursion is needed.

Comment bodies are HTML. For plain text, run a search scoped to the thread:
`/search?query=*&discussionID=<id>&recordTypes[]=comment` returns
`bodyPlainText` for each comment.

## Lookups

```bash
# Tags: name to tagID, with post counts (scriptrunner is tagID 10)
curl --silent --show-error --fail-with-body --get \
  --data-urlencode 'query=scriptrunner' --data 'limit=10' \
  'https://community.atlassian.com/forums/api/v2/tags' |
  jq '[.[] | {tagID, name, countDiscussions}]'

# Categories: question boards are *-questions-board, articles *-articles-board
curl --silent --show-error --fail-with-body --get \
  --data-urlencode 'query=jira' --data 'limit=10' \
  'https://community.atlassian.com/forums/api/v2/categories/search' |
  jq '[.[] | {categoryID, name, url}]'

# Users: display name (trailing * for prefix) to userID
curl --silent --show-error --fail-with-body --get \
  --data-urlencode 'name=Nic Brough*' --data 'limit=5' \
  'https://community.atlassian.com/forums/api/v2/users/by-names' |
  jq '[.[] | {userID, name}]'
```

## Pagination

Follow `x-app-page-next-url` (or the `link` header's `rel="next"`) only while it
is present and more results are needed. Read it with curl's
`--write-out '%header{x-app-page-next-url}'` (curl 7.84 or later) or
`--dump-header`. Keep the same
filters, sort and limit between pages. Results beyond the first 10 000 are not
reachable: narrow the query instead.

## Unsupported or misleading forms

- The Khoros endpoints (`/forums/s/api/2.0/search`, `/api/2.0/search`) and LiQL
  are gone. There is no SQL-like query language.
- `/forums/api/v2/open-api/v3` is HTTP 403; the API schema is not public.
- There are no response rate-limit headers. Responses are cached at the edge
  for about two minutes (`cache-control: public, max-age=120`).
- Browser cross-origin calls get no `Access-Control-Allow-Origin` header. Call
  from a shell or server-side process.
- The API exposes public content only. Private groups and some categories
  return HTTP 403.
