# Atlassian Community LiQL reference

These query forms were verified against the public Atlassian Community API on
2026-07-31. Re-run the smoke query if the service contract appears to have
changed.

## Endpoint and response

Use:

```text
GET https://community.atlassian.com/forums/s/api/2.0/search?q=<URL-encoded LiQL>
```

No authentication is required for public content. A successful response has
this shape:

```json
{
	"status": "success",
	"message": "",
	"http_code": 200,
	"data": {
		"type": "messages",
		"list_item_type": "message",
		"size": 25,
		"items": [],
		"next_cursor": "..."
	},
	"metadata": {}
}
```

Message fields vary by content type and selection. Useful tested fields include:

| Field           | Meaning                                                           |
| --------------- | ----------------------------------------------------------------- |
| `id`            | Message ID                                                        |
| `subject`       | Topic or reply subject                                            |
| `body`          | Message body object/content                                       |
| `view_href`     | Public Community URL to cite                                      |
| `post_time`     | Timestamp with offset                                             |
| `depth`         | `0` for a topic; greater than zero for replies                    |
| `author`        | Author object, including `id` and `login`                         |
| `conversation`  | Thread metadata including `style`, `solved`, and `messages_count` |
| `replies`       | Direct-reply metadata including `count` and a follow-up query     |
| `parent`        | Direct parent message                                             |
| `metrics.views` | View count                                                        |
| `is_answer`     | Whether a reply is an answer                                      |
| `is_solution`   | Whether a reply is the accepted solution                          |

Prefer explicit fields. `SELECT *` is useful only for inspecting one known
message because message objects can be large.

## Query templates

### Smoke test

```sql
SELECT id, subject, view_href
FROM messages
WHERE depth = 0
ORDER BY post_time DESC
LIMIT 1
```

### Search topics and articles

```sql
SELECT id, subject, view_href, post_time, author, conversation
FROM messages
WHERE depth = 0
  AND (subject MATCHES 'search terms' OR body MATCHES 'search terms')
ORDER BY post_time DESC
LIMIT 25
```

Add `conversation.style = 'qanda'` for Q&A or
`conversation.style = 'blog'` for articles.

### Filter by tags

```sql
SELECT id, subject, view_href, post_time, conversation
FROM messages
WHERE depth = 0
  AND tags.text IN ('jira', 'jira-cloud')
ORDER BY post_time DESC
LIMIT 25
```

`tags.text = 'jira'` also works for one tag.

### Answer and solution state

```sql
-- Topics with at least one direct reply
SELECT id, subject, view_href, replies
FROM messages
WHERE depth = 0 AND replies.count(*) > 0
ORDER BY post_time DESC
LIMIT 25

-- Topics with no direct replies
SELECT id, subject, view_href, replies
FROM messages
WHERE depth = 0 AND replies.count(*) = 0
ORDER BY post_time DESC
LIMIT 25

-- Q&A topics with an accepted solution
SELECT id, subject, view_href, conversation
FROM messages
WHERE depth = 0
  AND conversation.style = 'qanda'
  AND conversation.solved = true
ORDER BY post_time DESC
LIMIT 25
```

Do not use the obsolete fields `reply_count` or `accepted_solution_id`.

### Sort by views

```sql
SELECT id, subject, view_href, metrics
FROM messages
WHERE depth = 0 AND tags.text = 'jira'
ORDER BY metrics.views DESC
LIMIT 25
```

Do not use `view_count`.

### Content by author

```sql
-- Root content only
SELECT id, subject, view_href, post_time, depth
FROM messages
WHERE depth = 0 AND author.login = 'Display Name'
ORDER BY post_time DESC
LIMIT 25

-- Include replies
SELECT id, subject, view_href, post_time, depth, parent, is_answer, is_solution
FROM messages
WHERE author.login = 'Display Name'
ORDER BY post_time DESC
LIMIT 25
```

### Fetch a message body

```sql
SELECT id, subject, body, view_href, post_time, author, conversation, metrics
FROM messages
WHERE id = '3269701'
LIMIT 1
```

### Fetch answers and replies

```sql
SELECT id, subject, body, view_href, post_time, author, depth, parent, is_answer, is_solution
FROM messages
WHERE depth > 0 AND parent.id = '3269701'
ORDER BY post_time ASC
LIMIT 100
```

`parent.id` returns direct children. To include deeper comments, collect reply
IDs and query their children recursively. Batch known parents when useful:

```sql
WHERE parent.id IN ('3269701', '3269703')
```

### Fetch tags for one message

```sql
SELECT *
FROM tags
WHERE messages.id = '3269701'
LIMIT 25
```

The tags collection requires a message constraint.

## Pagination

Use the opaque `data.next_cursor` value by appending a `CURSOR` clause to the
same stable, ordered query:

```sql
SELECT id, subject, view_href, post_time
FROM messages
WHERE depth = 0
ORDER BY post_time DESC
LIMIT 25
CURSOR '<data.next_cursor>'
```

Do not pass the cursor as a separate URL parameter. Continue only while a
cursor is present and more results are needed. Preserve the original filters,
field selection, ordering, and limit between pages. `LIMIT ... OFFSET ...` also
works for small result sets, but cursor pagination is preferred.

## Unsupported or misleading forms

- Global tag aggregation with `COUNT`, aliases, and `GROUP BY` is rejected.
- `SELECT * FROM tags` without `WHERE messages.id = ...` is rejected.
- The anonymous legacy v1 all-tags endpoint is permission-restricted.
- `conversation.id = ...` was rejected as a message constraint; traverse
  replies through `parent.id` instead.
- Browser cross-origin calls are rejected. Call from the server-side agent
  shell with `curl`.
- The API searches only public Community content and returns no total-result
  count.
