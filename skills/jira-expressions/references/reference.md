# Jira Expressions Reference

## Syntax & Operators

- **Member access:** `issue.key`, `issue['property-name']`, `issue?.optional`, `issue?.[computed]`
    - Optional chaining (`?.`) returns `null` on failure instead of error
    - Use for nullable values or missing properties: `issue?.customfield_10010`
- **Math:** `+`, `-`, `*`, `/`, `%` (all 64-bit float)
- **Boolean:** `&&`, `||`, `!` (follows JS truthiness)
- **Comparison:** `==`, `!=`, `<`, `>`, `<=`, `>=` (same types only)
- **String concat:** `'text' + value` (auto-converts non-strings)
- **Nullish coalescing:** `value ?? defaultValue` (only for null/undefined)
- **Conditional:** `condition ? true : false`
- **Lists:** `[1, 2, 3]`, `['Bug', 'Task'].includes(issue.issueType.name)`
- **Objects:** `{ key: value }`, evaluates to Map
- **Variables:** `let x = value;` or `x = value;` (let is optional)
- **Functions:** `x => x * 2` or `(a, b) => { return a + b; }`
- **Template literals:** `` `Issue ${issue.key} has {count} comments` ``
- **Type checking:** `typeof variable` returns type name or "undefined"
- **Indexed access:** `list[0]`, `list[index]`

## Control Flow

```jira-expression
// If statement (else required)
if (condition) {
    return value1;
} else if (condition2) {
    return value2;
} else {
    return value3;
}

// Try-catch
try {
    // expression that may fail
} catch (e) {
    // e.message - error description
    // e.location - where it failed (not for throw)
    throw e; // rethrow
    throw 'custom error'; // custom error
}
```

## Context Variables

Available depending on evaluation context:

- `user` (User) - Current user, `null` if anonymous
- `app` (App) - Connect/Forge app (if from app request)
- `issue` (Issue) - Current issue
- `issues` (List<Issue>) - From JQL query in REST API
- `project` (Project) - Current project
- `sprint` (Sprint) - Current sprint (Jira Software)
- `board` (Board) - Current board (Jira Software)
- `serviceDesk` (ServiceDesk) - Current service desk
- `customerRequest` (CustomerRequest) - Current request
- `transition` (Transition) - In workflow conditions/validators

Check availability: `typeof project != 'undefined'`

## Types Reference

**CRITICAL: Jira Expressions is NOT JavaScript.** Only the properties and methods documented below exist. Standard JavaScript/TypeScript methods that are not listed here (e.g. `startsWith`, `endsWith`, `find`, `findIndex`, `toFixed`, `charAt`, `substring`, `substr`, `at`, `push`, `pop`, `shift`, `unshift`, `splice`, `reverse`, `fill`, `copyWithin`, `Array.from`, `Object.keys`, `Object.values`, `parseInt`, `parseFloat`, `Math.*`, `Number.isNaN`, `Array.isArray`, `toString` on non-Date types, etc.) **DO NOT EXIST** and will cause runtime errors. If the functionality you need is not listed below, you must find an alternative using only documented operations or report that it cannot be done.

### Issue

**Constructors:** `new Issue(id)`, `new Issue(key)` - returns `null` if no access
**Core Properties:**

- Basic: `id`(Number), `key`, `summary`, `description`(RT), `environment`(RT)
- Types: `priority`(IssuePriority), `issueType`(IssueType), `status`(IssueStatus), `resolution`(Resolution), `securityLevel`(SecurityLevel)
- Dates: `created`, `updated`, `resolutionDate`(Date), `dueDate`(CalDate)
- Time tracking: `originalEstimate`, `remainingEstimate`, `timeSpent` (seconds as Number)
- Groovy time-tracking mapping: `getEstimate()` -> `remainingEstimate`, `getOriginalEstimate()` -> `originalEstimate`, `getTimeSpent()` -> `timeSpent`
- Hierarchy: `parent`¹(Issue), `childIssues`¹(List<Issue>), `subtasks`ᴺ¹(List<Issue>)
- People: `assignee`¹, `reporter`¹, `creator`¹ (User)
- Engagement: `votes`¹, `watches`¹(Number), `voters`¹, `watchers`¹(List<User>) - error if disabled
- Metadata: `labels`¹(List<String>), `versions`¹, `fixVersions`¹(List<Version>), `components`¹(List<Component>)
- Content: `attachments`¹(List<Attachment>), `worklogs`¹(List<Worklog>), `comments`ᴺ¹(List<Comment>) - oldest first
- Relations: `links`ᴺ(List<IssueLink>), `changelogs`ᴺ(List<Changelog>) - newest first
- `properties`(EntityProperties)
- **Custom fields:** `issue?.customfield_10010` or `issue['com.app.field-key']` - JSON format. Always guard with `?` after `issue` as the field may not exist on the issue type, and use `?` for property access on the field value (e.g. `issue?.customfield_10010?.value`)

**Functions:** `getNewestChangelog(field, {from?, fromString?, to?, toString?})`

**Jira Software Fields:**

- `isEpic`(Boolean), `epic`ᴺ(Issue), `sprint`ᴺ(Sprint), `closedSprints`ᴺ(List<Sprint>), `flagged`ᴺ(Boolean)
- **Epic-specific:** `name`ᴺ, `done`ᴺ(Boolean), `color`ᴺ('color_1'-'color_9'), `stories`ᴺ(List<Issue>)

**Notes:** Hidden fields return `null`. Parent available in validators for subtasks during creation.

### Project

**Constructor:** `new Project(id/key)` - returns `null` if no access
**Properties:** `id`, `key`, `name`, `style`('next-gen'|'classic'), `projectTypeKey`, `projectCategory`(ProjectCategory), `lead`(User), `avatarUrls`(Map<String,String>), `properties`

### User

**Constructor:** `new User(accountId)` - returns `null` if not found
All properties and methods below are available on **any** User instance: the context `user`, issue fields (`issue.assignee`, `issue.reporter`, `issue.creator`), and users from other types (`comment.author`, `worklog.author`, `changelog.author`, etc.).
**User custom fields** are returned as a raw Map (JSON), not a User instance. To access User methods/properties, construct a User first: `new User(issue?.customfield_10050?.accountId)`. For multi-user custom fields: `issue?.customfield_10051?.map(u => new User(u.accountId))`.
**Properties:**

- `accountId`(String) - always available
- `displayName`¹, `locale`¹, `timeZone`¹ - may be `null` per privacy settings
- `active`¹(Boolean), `avatarUrls`¹(Map)
- `groups`ᴺ, `groupIds`ᴺ(List<String>) - requires admin permission for other users
- `permissions`(UserPermissions), `properties`(EntityProperties)
  **Method:** `getProjectRoles(project)`ᴺ - returns List<ProjectRole>

### Date & Time

**Date** (timestamp with timezone):

- Constructors: `new Date()` (now), `new Date(millis)`, `new Date('2008-09-15T15:53:00+05:00')`
- Convert: `toString()` (user locale), `toISOString()`, `toCalendarDate()`, `toCalendarDateUTC()`
- Math: `plusMonths(n)`, `minusMonths(n)`, `plusDays(n)`, `minusDays(n)`, `plusHours(n)`, `minusHours(n)`, `plusMinutes(n)`, `minusMinutes(n)`
- Compare: `date1 > date2`, `date1 == date2`
- Formats: ISO ('2018-06-29T12:16:37.471Z'), REST API ('2018-06-29T22:16:37.471+1000'), Human ('29/Jun/18 10:16 PM')

**CalendarDate** (date only, no time/timezone):

- Constructors: `new CalendarDate()` (current date), `new CalendarDate('2008-09-15')`
- Limited to date operations only

### Collections

**List:**
These are the **only** List methods available. Methods like `find`, `findIndex`, `push`, `pop`, `shift`, `unshift`, `splice`, `reverse`, `fill`, `at`, `entries`, `keys`, `values`, `forEach`, `Array.from`, `Array.isArray` **do not exist**.

- `length` - number of items
- Transform: `map(fn)`, `flatMap(fn)`, `flatten()`
- Filter: `filter(fn)` (predicate can return any truthy value)
- Test: `every(fn)`, `some(fn)`, `includes(item)`
- Find: `indexOf(item)` - returns -1 if not found
- Slice: `slice(start, end?)` - negative indexes from end
- Combine: `concat(item/list)`
- Aggregate: `reduce(fn, initial?)` - error if empty with no initial
- String: `join(separator?)` - max 10k chars, truncates with '...'
- Sort: `sort((a,b) => a.field < b.field ? -1 : 1)`

**Map:**

- Create: `new Map()` or `{ key: value }`
- Access: `map.key`, `map['key']`, `map.get('key')` - returns `null` if missing
- Update: `set(key, value)` - returns new map
- Iterate: `entries()` - returns List<[String, Any]>

### String

These are the **only** String methods available. Methods like `startsWith`, `endsWith`, `charAt`, `substring`, `substr`, `at`, `trimStart`, `trimEnd`, `search`, `replaceAll`, `normalize`, `localeCompare` **do not exist**.

- `length`, `trim()`
- Pad: `padStart(n, str?)`, `padEnd(n, str?)` - max 100 chars
- Case: `toLowerCase()`, `toUpperCase()`
- Split: `split(separator?)` - returns List<String>
- `repeat(n)` - max 100 repetitions
- `replace(regex, replacement)` - replacement can be function
- Match: `match(regex)` - first match + groups, `matchAll(regex)` - all matches
- Search: `includes(substring)`, `indexOf(substring)`
- `slice(start, end?)` - substring
- Cast: `value + ''` or `` `${value}` ``

### Core Types

**IssuePriority:** `id`, `name`, `description`
**IssueStatus:** `id`, `name`, `description`, `category`(StatusCategory)
**StatusCategory:** `id`, `key`, `name`, `colorName`
**IssueType:** `id`, `name`, `description`, `iconUrl`, `hierarchyLevel`(1=epic, 0=issue, -1=subtask), `properties`
**Resolution:** `id`, `name`, `description`
**SecurityLevel:** `id`, `name`, `description`
**Component:** `id`, `name`
**Version:** `id`, `name`, `description`, `archived`, `released`, `releaseDate`, `startDate`(CalDate)
**ProjectCategory:** `id`, `name`, `description`
**ProjectRole:** `id`, `name`, `description`

### Content Types

**Comment:** `id`, `body`(RichText), `author`(User), `created`, `updated`(Date), `properties`
**RichText:**

- `plainText` - plain text representation
- Constructor: `new RichText(adfMap)` - for multi-line custom fields
- Handle version differences: `typeof value == 'Map' ? new RichText(value).plainText : value`

**Attachment:** `id`, `author`(User), `filename`, `size`(bytes), `mimeType`, `created`(Date)
**Worklog:** `id`, `author`, `updateAuthor`(User), `created`, `updated`, `started`(Date), `timeSpent`(seconds)

### Links & History

**IssueLink:** `id`, `type`(IssueLinkType), `direction`('inward'|'outward'), `outwardIssue`, `inwardIssue`, `linkedIssue`(Issue)
**IssueLinkType:** `id`, `name`, `inward`(label), `outward`(label)
**Changelog:** `id`, `author`(User), `items`(List<ChangelogItem>), `created`(Date)
**ChangelogItem:** `field`, `fieldId`, `from`, `fromString`, `to`, `toString` (all String, can be empty)

### Jira Software

**Sprint:** `id`, `state`('future'|'active'|'closed'), `name`, `goal`, `startDate`, `endDate`, `completeDate`(Date), `properties`
**Board:** `id`, `hasBacklog`ᴺ, `hasSprints`ᴺ, `activeSprints`ᴺ, `futureSprints`ᴺ, `closedSprints`ᴺ(List<Sprint>), `canAdminister`ᴺ(Boolean), `properties`

### Service Management

**ServiceDesk:** `id`, `project`ᴺ(Project)
**CustomerRequest:** `issue`(Issue), `currentStatus`(CustomerRequestStatus), `serviceDesk`ᴺ, `requestType`ᴺ(CustomerRequestType)
**CustomerRequestStatus:** `name`, `category`('new'|'indeterminate'|'done'|'undefined'), `date`
**CustomerRequestType:** `id`

### System Types

**Transition:** `id`, `name`, `from`, `to`(IssueStatus), `hasScreen`(Boolean) - workflow context
**App:**

- Forge: `id`(ARI format), `license`(License), `properties`
- Connect: `key`, `properties`
  **License:** `active`(Boolean)
  **Error:** `message`, `location` (location not available for `throw`)
  **UserPermissions:** `global`ᴺ(List<String>) - admin permission needed for other users

### EntityProperties

Access properties on any entity supporting them:

- Static: `entity.properties.myProperty`
- Computed: `entity.properties['my-property']`
- Method: `entity.properties.get('key')`¹
- List keys: `entity.properties.keys()`ᴺ
- Check updates: `entity.properties.updated()`, `entity.properties.updated('key')`
- Returns: JSON values as Map/List/Boolean/String/Number, `null` if undefined

## Type Conversions

- **Number:** `Number('123')` - returns `NaN` if invalid
- **Boolean:** Truthy/falsy follows jira-expression rules
- **String:** `value + ''` or ` `${value}` ``
- **JSON:** `JSON.stringify(value)`, `JSON.parse(string)`

## Performance & Restrictions

**Expensive operations limit: 10 per expression**

- ¹ = Always 1 operation (even on lists)
- ᴺ = 1 operation per access
- ¹ᴺ = 1 operation only when using `.length`

**Important limits:**

- Unbounded collections process max 1000 items
- After 1000, each item costs 1 operation
- Use `.slice(0, 1000)` to ensure success
- String operations: max 100 chars padding, 100 repetitions
- `join()` result max 10k characters (truncates with '...')

**Best practices:**

- Use context variables instead of loading data
- Limit data sets: `issue.comments.slice(0, 1000).map(...)`
- Check expensive operation markers in docs
- `issue.comments` is ordered oldest first (`[0]` is the oldest comment)

## Common Patterns

```jira-expression
// Check if user commented
issue.comments.some(c => c.author.accountId == user.accountId)

// Count issues by status
issues.reduce((counts, issue) =>
    counts.set(issue.status.name, (counts[issue.status.name] || 0) + 1),
    new Map())

// Recent activity check
issue.updated > new Date().minusDays(7)

// Safe custom field access
issue?.customfield_10010 ?? 'default'

// Handle multi-line fields
let getText = value => typeof value == 'Map' ? new RichText(value).plainText : value;
getText(issue?.customfield_10000)

// Search in custom field JSON
JSON.stringify(issue?.customfield_10000).includes('search text')

// Get linked issues with type
issue.links.map(link => ({
    type: link.type[link.direction],
    issue: link.linkedIssue.key
}))

// Filter by multiple issue types
['Bug', 'Task', 'Story'].includes(issue.issueType.name)

// Check project type safely
typeof project != 'undefined' && project.style == 'next-gen'
```

## Notes

- **This is NOT JavaScript.** Only use methods and properties documented in this reference. If a method is not listed here, it does not exist. Do not use any standard JavaScript built-in methods (String.prototype, Array.prototype, Math, Number, Object, etc.) unless they are explicitly documented above.
- Custom fields return JSON format (same as REST API)
- Hidden fields always return `null`
- Permissions affect data visibility
- Dates rendered in REST API format when returned
- Regex supported in match/replace operations
- Connect apps need asApp() authentication for some contexts
- Jira expressions must always return a boolean, you may not throw or return any other type from a Jira expression.
- **Null safety:** Apply null checks liberally. When checking entities that may not exist (comments, attachments, custom field values, optional users/objects, etc.), always guard with `!= null` checks. For comments and attachments detected during a transition (`id == null`), also verify the body/content is not null (e.g. `c.id == null && c.body != null`).
- **Groovy truth semantics:** Preserve Groovy truth/falsiness behavior from source logic (for example `null`, `false`, `0`, `''`, empty lists/maps are falsey; non-empty values are truthy) unless the source explicitly coerces values differently.
- **Groovy null-ordering semantics for relational operators:** In Groovy ordering comparisons, `null` is lower than non-null values. Preserve this behavior when translating `>`/`<`/`>=`/`<=`.
- **Relational translation rule:** Do not introduce extra required/non-null constraints unless the Groovy source explicitly requires them. Maintain original relational intent and null behavior.
- **Date null handling in Jira Expressions:** Jira Expressions rejects direct Date-vs-null ordering. When source logic compares nullable dates, use explicit branches that emulate Groovy ordering outcomes without changing overall truth conditions.
- **Relational operator fidelity:** If Groovy uses direct relational comparison (for example `value <= 50`) without explicit null guards, preserve that behavior. Do not add non-null requirements unless the Groovy source explicitly enforces required values.
- **Date-null translation rule:** Because Jira Expressions rejects direct Date-vs-null ordering, translate date comparisons with explicit branches that emulate Groovy ordering outcomes while keeping non-date comparisons semantically equivalent.
- **Workflow project context:** In workflow conditions/validators, `project` is the selected issue's project. For issue-scoped checks, prefer `issue.project` to avoid ambiguity.
- **Issue links shape:** `issue.links` is a `List<IssueLink>`; when there are no links, it is an empty list (`.length == 0`).
- **List-valued fields:** For list-valued fields (multi-select, multi-checkbox, multi-user-picker, labels, versions, components, etc.), "required" means `field != null && field.length > 0`.
- **Validator gate semantics:** Preserve fail-closed logic in validators. If the source behaves like `if (gate) { validate } else { true }`, then inside the gate, missing required data must remain a failing condition unless the source explicitly allows it.
- **Do not null-default required inputs:** Do not replace required nullable values with permissive defaults (for example `[]` or `''`) when that would turn failures into passes.
- **Quantifier edge cases:** Remember `every([]) == true` and `some([]) == false`. When translating required checks, ensure empty-list behavior does not accidentally bypass validation.
- **Branch equivalence check:** Before finalizing, silently verify gate=true/gate=false plus missing/invalid/valid input paths to ensure no OR/ternary rewrite broadens pass conditions.
- **String escaping rules:** Jira Expressions string escaping follows JavaScript string-literal rules. Use valid quoted literals, and escape delimiters/backslashes/control characters correctly (for example `'`, `"`, `\\`).
- **Exact-match string literals:** String values are often compared for exact equality. Do not add, remove, normalize, translate, or substitute any character in a source string literal. The only allowed transformation is adding syntactic escaping required to keep the literal valid while preserving the exact runtime string value.
- **Apostrophe quoting rule:** For exact equality comparisons where the literal contains an apostrophe, use double-quoted string literals. Do not emit unescaped apostrophes inside single-quoted literals.
- **Non-English literal audit:** When source strings contain non-English text, diacritics, apostrophes, quotes, or mixed punctuation, do a final silent character-by-character verification pass for each output literal to ensure exact text preservation with valid escaping.
- **Literal fidelity:** Preserve literal text exactly, including straight quotes vs typographic quotes. Never substitute a straight apostrophe (`'`, U+0027) with a curly apostrophe (`’`, U+2019), or vice versa. Do not replace `"` with curly quotes (`“` or `”`).
- **Mandatory final literal check:** For every emitted literal containing non-ASCII characters or apostrophes, verify byte-for-byte that the runtime string value matches the source text exactly (except for required escape syntax in the source code representation).
- **Usernames and user keys do not exist in Jira Cloud.** When the Groovy source code references a username or user key (e.g. `loggedInUser.name == "admin"`, `user.getKey() == "jsmith"`), you must use `user.accountId` instead. Use the original string value from the Data Center code as the accountId value and add a comment noting it will need to be mapped to a real cloud account ID (e.g. `user.accountId == "admin" /* DC username, map to cloud accountId */`).
