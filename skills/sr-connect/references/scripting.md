# Writing scripts for ScriptRunner Connect

Load this before writing or editing anything under `scripts/` in a cloned workspace. The runtime is not Node, the clients are typed and thin, and most agent-written failures come from forgetting one of those two facts.

Read first, in the clone: `node_modules/@sr-connect/runtime-types/index.d.ts` for what the runtime provides, the README of each `@sr-connect/*` and `@managed-api/*` package you use, and `ev-params.ts` for the parameters. If the clone has no `node_modules`, the NPM pages carry the same READMEs.

## Runtime

A custom V8 runtime aimed at WinterTC compatibility. ES2020, ESM only, a fresh isolate per invocation. No DOM, no Node standard library, no `require`. `process.env` is an empty object; configuration comes from `context.environment.vars`.

ES2020 bounds the standard library as well as the syntax. Neither the docs nor `@sr-connect/runtime-types` describe `Intl`, `Array`, `String` or `Promise` methods, so treat anything the language added after ES2020 as absent until a probe shows otherwise: `Array.prototype.at`, `Object.hasOwn`, `structuredClone`, `Promise.any`, `String.prototype.replaceAll`, and options an older API gained later. The known case is `Intl.DateTimeFormat`, which takes `dateStyle` but rejects `timeStyle` with `TypeError: Invalid option : option`, an error naming no option. Explicit parts work: `{ timeZone, day, month, year, hour, minute, timeZoneName }`. When a script formats or parses anything beyond a plain method call, probe it with a throwaway script first and note the result in the feedback file.

Each invocation reports its own limits: `context.timeout` in milliseconds and `context.availableMemory` in MB. Read those rather than hard-coding.

| Limit                     | Value                                                                                                                                             |
| ------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------- |
| Invocation duration       | 15 min async, 25 s for a sync HTTP event, 20 s for a waited trigger through the public API's trigger endpoint, which `script trigger --wait` uses |
| Memory                    | 400 MB by default; paid plans can request an 800 MB variant through support                                                                       |
| Chained triggers          | 200 per chain                                                                                                                                     |
| Attachment held in memory | fails above about 100 MB; stream through stored bodies instead                                                                                    |
| Cold start                | 2 to 3 s; enhanced isolation adds 1 to 2 s and makes them more frequent                                                                           |

### Available

| API                                                                                        | Notes                                                                                                                                                                                                  |
| ------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `console`                                                                                  | The whole family: `log`, `debug`, `info`, `warn`, `error`, `trace`, `assert`, `count`, `time`, `timeLog`, `timeEnd`, `group`. Output goes to the invocation log. Objects are formatted by the runtime. |
| `performance.now()`                                                                        | Returns seconds, not milliseconds.                                                                                                                                                                     |
| `crypto.getRandomValues()`                                                                 | Yes. `window.crypto` is the same object; `window` has nothing else.                                                                                                                                    |
| `crypto.subtle`                                                                            | `generateKey`, `importKey`, `exportKey`, `sign`, `verify` only. No `digest`, `encrypt`, `decrypt`, `deriveKey`, `deriveBits`, `wrapKey`, `unwrapKey`. Formats `jwk`, `raw`, `pkcs8`, `spki`.           |
| `fetch` and `Request`, `Response`, `Headers`, `Blob`, `FormData`, `URL`, `URLSearchParams` | Partial and non-standard; see Fetch below. No `File` class.                                                                                                                                            |
| `TextEncoder`, `TextDecoder`                                                               | `TextDecoder` ignores `fatal`; bad sequences become U+FFFD.                                                                                                                                            |
| `btoa`, `atob`                                                                             | Latin-1 binary strings.                                                                                                                                                                                |
| `setTimeout`, `clearTimeout`, `setInterval`, `clearInterval`                               | The invocation stays alive until timers fire or are cleared. Clear an interval before returning or the run times out.                                                                                  |
| `ServiceError`                                                                             | Global. Thrown by the runtime and by managed APIs when a service call fails. Fields `errorCode?: number`, `service?: string`.                                                                          |
| `AbortProcess`                                                                             | Global `Error` subclass. Thrown from a script it is an ordinary uncaught error.                                                                                                                        |
| `Context`                                                                                  | Global type of the second entry-point argument.                                                                                                                                                        |

### Missing

| Missing                                                                                         | Consequence                                                                                                         |
| ----------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------- |
| `Buffer`, `node:*`, `fs`, `http`, `require`                                                     | Packages that touch Node APIs do not run. Use `@sr-connect/convert` for encodings.                                  |
| `crypto.subtle.digest`, `encrypt`, `decrypt`                                                    | Hashing and JWT signing need `jose-browser-runtime`, not `jsonwebtoken`.                                            |
| `fetch` with a `Request` object, `signal`, `redirect`, `credentials`, `mode`, `cache`           | Pass a URL string and `method`, `headers`, `body`, `agent` only.                                                    |
| Streaming bodies                                                                                | The whole response is buffered before the promise resolves.                                                         |
| WebSocket, streams, `structuredClone`, `queueMicrotask`, `AbortController`, `crypto.randomUUID` | Not available. `ulid` from the verified list covers IDs.                                                            |
| `Intl.DateTimeFormat` `timeStyle`, and library additions after ES2020 in general                | `TypeError: Invalid option : option`. Pass explicit date parts; probe before relying on anything newer than ES2020. |
| Unhandled rejection capture                                                                     | A rejection on a promise you did not await is lost silently. Await everything or attach `catch`.                    |

### Runtime V2

New workspaces run V2. `TextEncoder`/`TextDecoder` use far less memory, and `fastTransfer` appears on `TextDecoder.decode()` and on `@sr-connect/convert`'s buffer functions. With `fastTransfer` the `ArrayBuffer` is passed by reference and your copy becomes invalid afterwards. Leave it off if you still need the buffer.

### Context

```ts
interface Context<EV = any> {
	readonly startTime: number // UNIX ms
	readonly timeout: number // ms the invocation may run
	readonly availableMemory: number // MB
	readonly invocationId: string
	readonly environment: {
		readonly uid: string
		readonly name: string
		readonly vars: EV
	}
	readonly queuedAt?: number // queued invocations only
	readonly queue?: { readonly uid: string; readonly name: string; readonly groupId: string }
	readonly deployment?: { readonly uid: string; readonly version: string; readonly label?: string } // undefined on HEAD
	readonly rootTriggerType: 'EXTERNAL' | 'MANUAL' | 'SCHEDULED' | 'MANUAL_EVENT_LISTENER'
	readonly triggerType: 'EXTERNAL' | 'MANUAL' | 'SCHEDULED' | 'MANUAL_EVENT_LISTENER' | 'CHAINED'
}
```

`EV` is the global interface `ev-params.ts` declares. `triggerType` is `CHAINED` when another script triggered this one; `rootTriggerType` says how the chain started.

## Script shape

Three language modes exist, js, ts and ts-strict. Always work in ts-strict and write as if strict is on regardless. Managed API return types widened with a generic such as `getIssue<null>(...)` only infer as nullable under strict.

A triggerable script exports an unnamed default async function. The platform passes `context` second:

```ts
export default async function (event: IssueCreatedEvent, context: Context<EV>): Promise<void> {
	// logic
}
```

`event` is the typed event for a listener, the payload for a programmatic trigger, `{}` when none was given, `any` for a manual run. A utility script has no default export and exports named functions; any exported function can also be the target of `triggerScript`.

File layout: imports, the entry function, supporting functions in reading order declared with `function`, types last. Shared logic in `scripts/Utils/<Service>.ts`, shared types in `scripts/Utils/Types.ts`. Listener handlers are named `On<Event>.ts`; scheduled jobs after the job, `SyncIssues.ts`. Prefer extending an existing script over adding one. Never edit `scripts/api/**` or `ev-params.ts`; both are generated.

Style:

- No `any` or `unknown` unless the type cannot be written or found in `node_modules`. Inference is fine when the right-hand side is clear.
- Annotate a return type rather than casting at `return`. No temporary variable only to return it.
- `??` over `||`. Options objects inline so the editor can complete them.
- No global mutable state. State that outlives the invocation goes in record storage.
- Do not catch an error only to log it; uncaught errors are logged with a stack trace, mark the run as failed and notify the workspace owner, which is what you want for anything the logic does not account for. Handle the expected cases and let the rest bubble.
- Comment the why. JSDoc where it helps.
- Run the clone's `lint:fix` script rather than fixing style by hand. An unused `context` warning is fine.
- No third-party integration SDKs for a service that has a connector. Use the connector, the Generic connector, or `fetch`.
- No tests unless asked; see `testing.md`.

## Parameters

Configured per environment, read as `context.environment.vars`. The clone's `ev-params.ts` declares the global `EV` interface from the workspace's parameters and is regenerated after every parameter change.

```ts
export default async function (event: any, context: Context<EV>) {
	const baseUrl = context.environment.vars.BASE_URL
	const timeout: number = context.environment.vars.HTTP.TIMEOUT_MS // FOLDER gives one level of nesting
}
```

| Parameter type                                | TypeScript                                                        |
| --------------------------------------------- | ----------------------------------------------------------------- |
| TEXT, PASSWORD, MULTILINE_TEXT, SINGLE_CHOICE | `string` (choice options become a string union in `ev-params.ts`) |
| NUMBER                                        | `number`                                                          |
| BOOLEAN                                       | `boolean`                                                         |
| DATE                                          | ISO 8601 `string`                                                 |
| MULTIPLE_CHOICES, LIST                        | `Array<string>`                                                   |
| MAP                                           | `Record<string, string>`                                          |

Text-like values cap at 4000 characters. Every parameter is declared optional in `ev-params.ts`, `GREETING?: string`, whether or not it is marked required; the one exception is BOOLEAN, which arrives as `false` rather than absent. A required one carries `Required: yes` in its JSDoc, which is where to read which parameters the workspace expects a value for. Requiredness is enforced when a value is saved in the web app, not by the environment, so a required parameter can genuinely be `undefined` at runtime: a copied workspace, a new environment or one set up through the API starts with no value until someone sets it, unless the parameter carries a default value.

So check before use, and fail with a message naming the parameter rather than letting `undefined` travel:

```ts
const baseUrl = context.environment.vars.BASE_URL
if (!baseUrl) throw new Error('Parameter BASE_URL is not set in this environment.')
```

A PASSWORD is never readable in code. The script sees `ENV_VARIABLE_<id>`; the real value is injected into the URL, headers or body of an outbound call whose content type is one of `application/json`, `application/xml`, `application/x-www-form-urlencoded`, `text/plain`, `text/css`, `text/csv`, `text/html`, `text/javascript` or `text/xml`. Any other content type does not get the substitution and the placeholder is sent as it stands. So a PASSWORD cannot be hashed, base64-encoded, concatenated into a Basic credential or passed to `agent`. Store the finished value instead, the complete `Basic ...` string for example, or use TEXT when the code must compute on it.

Every configurable value is a parameter: base URLs, timeouts, retry counts, feature flags, project keys. Never a secret in code. Check `ev-params.ts` before hard-coding; if a parameter does not exist, write against `context.environment.vars.NAME` and create it with `environment-parameter create`.

## API connections and Managed APIs

An API connection is the workspace-level proxy a script imports; a connector supplies its credentials per environment; a Managed API is the typed client generated for it. Managed APIs are thin: request and response shapes are one to one with the vendor API, nothing unified, nothing post-processed. What they add is types, discoverability and error handling with a pluggable strategy.

### Three tiers

Use the highest that can do the job.

Managed API method:

```ts
import JiraCloud from './api/jira/cloud'

const issue = await JiraCloud.Issue.getIssue({ issueIdOrKey: 'ISSUE-1' })
console.log(issue.fields.reporter.displayName)
```

Managed fetch on the connection, base URL and auth supplied, you check status and parse:

```ts
const response = await JiraCloud.fetch(`/rest/api/3/issue/${issueKey}`)
if (!response.ok) {
	throw Error(`Unexpected response: ${response.status}`)
}
const issue = await response.json()
```

Global `fetch`, full URL, your own headers. Only when no connector exists, and even then prefer a Generic connector so the credential stays out of code.

Before dropping a tier, look harder: read `node_modules/@managed-api/<service>-core/` and its README, try sibling groups such as `Issue`, `IssueAttachment` and `IssueComment`, the verb variants `get`, `create`, `update`, `delete`, `list`, `search`, and the `All` group that holds every method.

### Imports and packages

```ts
import JiraCloud from './api/jira/cloud'
```

Relative path to the generated module under `scripts/api/`, PascalCase name, no `/index` suffix. Runtime package `@managed-api/<service>[-v<N>]-sr-connect`, types and core `@managed-api/<service>[-v<N>]-core`, shared errors and helpers `@managed-api/commons-core`. Examples: `@managed-api/jira-cloud-v3-sr-connect`, `@managed-api/slack-sr-connect`, `@managed-api/generic-sr-connect`.

Never guess a parameter shape. Request interfaces such as `EditIssueRequest` are in `node_modules/@managed-api/<service>-core/types/<group>.d.ts`.

### Calls

`Service.Group.method(options)`. Path and query parameters at the root of the options object, body under `body`. When vendor docs say "parameters" without saying which, check `body`. Do not add headers the client already sets, auth and content type included.

```ts
await JiraCloud.Issue.updateIssue({
	issueIdOrKey: 'ISSUE-1',
	body: { fields: { summary: 'New summary' } },
})
```

Pagination: walk every page with the vendor's own paging fields, `startAt`, `maxResults`, `next` or a cursor, unless told otherwise, and warn the user when that means many calls.

### Errors

All from `@managed-api/commons-core`: `UnexpectedError` for a JSON parse failure and the like, and `HttpError` with `.response`, parent of `BadRequestError` 400, `UnauthorizedError` 401, `ForbiddenError` 403, `NotFoundError` 404, `TooManyRequestsError` 429, `ServerError` 5xx. Services may add their own, `SlackError` from `@managed-api/slack-core/common` because Slack reports validation failures in the body.

```ts
import { HttpError, UnexpectedError } from '@managed-api/commons-core'

try {
	const issue = await JiraCloud.Issue.getIssue({ issueIdOrKey: 'ISSUE-1' })
} catch (e) {
	if (e instanceof HttpError) {
		console.error('Jira answered', e.response.status)
	} else if (e instanceof UnexpectedError) {
		throw e
	} else {
		throw e
	}
}
```

`errorStrategy` in the options handles an error before it is thrown; a handler's return value becomes the method's return value. Handlers from most to least specific: `handleHttp400Error`, `401`, `403`, `404`, `429`, `handleHttp5xxError`, `handleHttpAnyError`, `handleUnexpectedError`, `handleAnyError`. The names are the members of `BaseErrorStrategyHandlers` in `node_modules/@managed-api/commons-core/index.d.ts`; read them there before writing one, since a misspelt member is a TS2353 listing the whole union. A handler must return a value; `null` is fine, `undefined` is not. Two special returns: `retry(delayMs?)` and `continuePropagation(skipStrategy?)`. Widen the return type so the fallback is typed:

```ts
import { continuePropagation, getRetryErrorHandler, retry } from '@managed-api/commons-core'

const issue = await JiraCloud.Issue.getIssue<null>({
	issueIdOrKey: 'ISSUE-1',
	errorStrategy: {
		handleHttp404Error: () => null,
		handleHttp429Error: (error, attempt) =>
			attempt < 3 ? retry(1000 + (attempt - 1) * 2000) : continuePropagation(),
	},
})

// the same retry as a helper: total attempts, first delay, increase per attempt
errorStrategy: {
	handleHttp429Error: getRetryErrorHandler(3, 1000, 2000)
}
```

Builder form: `errorStrategy: b => b.http404Error(() => null).retryOnRateLimiting(20)`, or `new ErrorStrategyBuilder()` from `@managed-api/<service>-core/builders/errorStrategy`. `Service.setGlobalErrorStrategy({...})` applies to every call through that import; the default global strategy already retries 429s and setting your own replaces it, so re-add retry if you still want it. Do not use a strategy to throw custom errors; handle the expected cases, a 404 fallback or a 429 retry, and let the rest bubble.

### GraphQL services, monday.com

The options carry `args` for query arguments and `fields` for the selection: `true` for a leaf, `{ fields: {...} }` for a nested object, which may take its own `args`. The response type is inferred from `fields`, so you can only read what you asked for. Results are under `response.data`. For hand-written GraphQL use `fetch` or `gql-query-builder`.

```ts
const response = await Monday.Board.getBoards({
	args: { ids: [123] },
	fields: { name: true, items_page: { fields: { items: { fields: { id: true, name: true } } } } },
})
```

### A Managed API on a Generic connector

When the connector for an app is Generic, because of custom credentials or an unusual host, add the app's `@managed-api/*-sr-connect` package through the package manager and construct the client from the connection's ID:

```ts
import { JiraCloudApi } from '@managed-api/jira-cloud-v3-sr-connect'
import Generic from './api/generic'

const JiraCloud = new JiraCloudApi(Generic.connectionId)
const issue = await JiraCloud.Issue.getIssue({ issueIdOrKey: 'ISSUE-1' })
```

## OAuth without a bespoke connector

The Generic connector holds fixed credentials only. For an app that needs OAuth 2.0 with rotating tokens, build the flow in the workspace:

1. Parameters: client ID as TEXT, client secret as PASSWORD if it is only ever placed verbatim into the token request; as TEXT with `--masked` if the app wants it base64-encoded or otherwise computed. Redirect URI and scopes as TEXT.
2. Callback: a Generic event listener, sync, that receives the authorization code on its `webhookUrl`, exchanges it for tokens, stores them, and returns a small HTML page saying so. Give the user its URL to complete consent once.
3. Tokens: record storage with `secure: true`, `workspace` scope. Store access token, refresh token and expiry.
4. Refresh on demand: before each call read the token, refresh when it is expired or the call answered 401, store the new pair, retry once. On-demand beats a scheduled refresh; a schedule fails silently between runs.
5. Calls: `fetch` with the bearer header from storage, or a Generic connector with no auth and the header added per call.
6. Several workspaces sharing one token: `team` scope with a `teamScope` partition, and the refresh must then live in one place, usually a scheduled trigger in a dedicated workspace, because consumers cannot coordinate refreshes.

## Event listeners in code

Events for an app live in `@sr-connect/<app>/events`, named `<Action>Event`. The library arrives when a listener for the app is created; look under `node_modules/@sr-connect/<app>/events/` for the types. Working from a clone, re-clone after adding an event listener or an API connection, `local-workspace clone --force` in the directory, so `package.json` picks up the new packages, then install again.

```ts
import { IssueCreatedEvent } from '@sr-connect/jira-cloud/events'

export default async function (event: IssueCreatedEvent, context: Context<EV>) {
	console.log('Issue created', event.issue.key)
}
```

Some apps expose only a generic event and the app decides the fields; say so to the user.

### Check the input first

A listener script opens by narrowing the event to what the integration is for and returning early otherwise, with one log line saying why. The field is whatever scopes the work: the project key, the repository, the board, the table, the channel. Two reasons. The app may deliver more than the event you registered for: GitHub sends `ping` to every new webhook and a GitHub App webhook adds its own events, a Marketplace webhook sends every Marketplace event, Zendesk's trigger method sends whatever the trigger matched, a Jira webhook without a JQL filter fires for every project. And a vendor-side filter, where the app offers one, is configuration a person can loosen later without touching the code. Ask for the vendor filter too, because it cuts invocations and logs; the check in the script is what keeps the integration correct. Read the scoping value from a parameter, never a literal.

```ts
import { IssueCreatedEvent } from '@sr-connect/jira-cloud/events'

export default async function (event: IssueCreatedEvent, context: Context<EV>) {
	const projectKey = context.environment.vars.PROJECT_KEY
	// Unset is a configuration fault, not an event to ignore: without this the comparison
	// below is false for every event and the integration silently does nothing.
	if (!projectKey) throw new Error('Parameter PROJECT_KEY is not set in this environment.')

	if (event.issue.fields.project.key !== projectKey) {
		console.log('Ignoring issue', event.issue.key, 'outside project', projectKey)
		return
	}
	// the work
}
```

An app listener's event is the request body and nothing else: no headers, no sender address. So a vendor's webhook secret or signature cannot be checked in the script, and no check goes in. For Jira Cloud, Jira Service Management Cloud, Microsoft Teams, Zoom, and Slack through its connector, the platform verifies the signature before the script runs; for the other apps the mechanism goes unchecked. Only a Generic listener hands the script `headers` and `sourceIp`, which is what the recipe below checks with `x-shared-secret`; a signature would be verified there with `crypto.subtle` against a masked TEXT parameter. Do not move an integration to a Generic listener for security on your own; `references/cli-workflow.md` says under Hardening when to offer it.

### Two-way syncs and the service user

An integration that listens to an app and also writes to it hears its own writes. Left alone the two sides answer each other forever, and nothing in the platform stops it: the loop ends at the team's monthly execution limit, capped at 500,000 on a plan that reports unlimited, by which time both systems hold the damage and the logs are 500,000 rows deep. Treat loop prevention as part of the design of every cyclic integration, not as hardening added later.

The check that holds is the actor. Every write the integration makes is authenticated as the account that authorized the connector, the service user, so a script ignores any event that account caused and acts only on events caused by somebody else. Read the actor from the event, `event.user.accountId` and its equivalents, and return early with one log line when it matches.

Resolve the service user's identity at runtime rather than storing it in a parameter, because re-authorizing a connector can change it and a stale value re-opens the loop silently. Call the app's own current-user endpoint through the same API connection the writes go through, Jira Cloud's `/rest/api/3/myself`, GitHub's `/user`, Slack's `auth.test`, and cache the answer in record storage with a TTL so it costs one call an hour rather than one an event.

```ts
const SERVICE_USER_KEY = 'service-user-id'

async function serviceUserId(): Promise<string> {
	const cached = await getRecordValue<string>(SERVICE_USER_KEY)
	if (cached) return cached
	// The Managed API's own current-user method where it has one; managed fetch otherwise.
	const response = await JiraCloud.fetch('/rest/api/3/myself')
	if (!response.ok) throw Error(`Cannot read the service user: ${response.status}`)
	const me = (await response.json()) as { accountId: string }
	// A re-authorized connector can be a different account, so this is cached, never configured.
	await setRecordValue(SERVICE_USER_KEY, me.accountId, { ttl: 3600 })
	return me.accountId
}
```

When the app exposes no such endpoint, probe the connector while building and confirm what you found with the user. When neither is possible, ask, and say plainly what a wrong answer costs: the integration filters nothing, every write is heard back, and the run stops only at the monthly limit. A user who does not know which account authorized the connector is not guessing on your behalf; `connector get` reports the host it points at and the web application's connector page names the account.

Where the event carries no actor at all, the fallback is a marker the other side can recognize, a field the integration owns, a record in storage keyed by the object it just wrote and compared on the way back in, or a comparison that makes a write a no-op when the value already matches. State which one you used in the workspace README, under Considerations.

### Generic HTTP events

`@sr-connect/generic-app/events/http`. Async handlers return `Promise<void>` and the caller gets a default response at once, carrying the invocation ID. Sync handlers return `Promise<HttpEventResponse>` within 25 seconds; 408 past that, 299 on abort, 422 on a malformed response. Prefer async unless the caller needs the answer. The URL path is globally unique; use a random one and add your own check, a shared secret header or an IP allowlist on `sourceIp`, because the endpoint is otherwise anonymous.

```ts
import {
	HttpEventRequest,
	HttpEventResponse,
	buildJSONResponse,
	isBase64,
	isJSON,
	isText,
} from '@sr-connect/generic-app/events/http'
import { convertBase64ToText } from '@sr-connect/convert'

export default async function (event: HttpEventRequest, context: Context<EV>): Promise<HttpEventResponse> {
	if (event.headers['x-shared-secret'] !== context.environment.vars.WEBHOOK_SECRET) {
		return { ...buildJSONResponse({ error: 'unauthorized' }), status: 401 }
	}
	if (isJSON<Payload>(event)) {
		// event.body is Payload
	} else if (isText(event)) {
		// event.body is string
	} else if (isBase64(event)) {
		const text = convertBase64ToText(event.body)
	}
	return buildJSONResponse({ ok: true })
}
```

Request shape: `method`, `path`, `queryString`, `queryStringParams`, `headers`, `bodyType?: 'base64' | 'text' | 'json'`, `body?`, `sourceIp`. JSON content types parse to an object, text types to a string, everything else to base64. Response shape: `status`, `headers?`, `body?`, `isBase64?`. Helpers: `isJSON<T>`, `isText`, `isBase64`, `buildJSONResponse`, `buildPlainTextResponse`, `buildHTMLResponse`. Each builder takes one argument, the body, and returns status 200 with the matching `Content-Type` header; none takes a status. For any other status, spread the builder's result and override `status`, as the 401 above does, or write the response object by hand. Do not modify an existing generic-listener script unless the intent is clear; you cannot see what calls it.

## Scheduled triggers in code

An ordinary entry point with `event: any` and `context.triggerType === 'SCHEDULED'`. UTC, 15-minute floor, not minute-accurate. Six-field CRON, seconds first: `0 0 2 * * *` is daily at 02:00 UTC. Keep the run idempotent and store progress in record storage so a missed or doubled run does no harm.

## Record storage

Key-value storage with JSON serialization. No atomic operations: two invocations writing one key overwrite each other.

```ts
import { createRecordStorage, getRecordValue, setRecordValue } from '@sr-connect/record-storage'

// standalone, environment scope
await setRecordValue('last-sync', { at: Date.now(), count: 42 })
const lastSync = await getRecordValue<{ at: number; count: number }>('last-sync')

// instance with shared options
const secrets = createRecordStorage({ scope: 'workspace', secure: true })
await secrets.setValue('oauth-tokens', tokens)
```

`new RecordStorage(options)` is exported too and builds the same instance as `createRecordStorage(options)`. Existing
workspace code often uses the class; leave it alone rather than rewriting it to the factory.

| Function                               | Instance      | Does                                            |
| -------------------------------------- | ------------- | ----------------------------------------------- |
| `getRecordValue(key, options?)`        | `getValue<T>` | value, or `undefined` when absent               |
| `setRecordValue(key, value, options?)` | `setValue`    | write, overwriting unless `denyUpdateOverwrite` |
| `recordValueExists(key, options?)`     | `valueExists` | existence without the body                      |
| `deleteRecordValue(key, options?)`     | `deleteValue` | idempotent                                      |
| `getKeysOfAllRecords(options?)`        | `getAllKeys`  | one page: `{ keys, lastEvaluatedKey? }`         |

Options: `scope`, one of `environment` by default, `workspace`, `team` and `invocation`; `teamScope`, a partition inside `team`, alphanumeric, up to 200 characters and strongly recommended with `team`; `ttl` in seconds, after which the record reads as absent; `secure`, an extra encryption layer that is slower; `denyUpdateOverwrite`; and `retryOn429`, on by default with one log line per retry. Per-call options override instance options. `invocation` scope is auto-deleted and its TTL is capped at 20 minutes.

Keys: letters, digits, underscore, dash. Under 1024 bytes. Case-insensitive; listings come back lower-cased. A `:`, `/`, `.` or space fails with HTTP 400 `Key can only contain alphanumeric characters, underscores and dashes.` Namespace with `_` or `-`: `mr-summary_${id}`.

Values: any JSON-serializable object, string, number, boolean or array. Not `undefined`, `null` or a function. A `Date` comes back as a string, a `Map` or `Set` as `{}`.

Every operation throws `ServiceError` on a bad key, a failed call, a too-large value, exhausted capacity, or an existing record under `denyUpdateOverwrite`. Fail closed: never wrap a storage call in a `catch` that returns the "proceed" value, because an idempotency guard whose `catch` says "allowed" cannot tell an outage from a key it can never write. Do not default to `team` scope unless the user asks.

Listing keys, continue on `lastEvaluatedKey` and never on the page size, a page can be empty with more to follow:

```ts
let lastEvaluatedKey: string | undefined
do {
	const page = await getKeysOfAllRecords({ lastEvaluatedKey })
	// page.keys
	lastEvaluatedKey = page.lastEvaluatedKey
} while (lastEvaluatedKey)
```

## Triggering scripts

```ts
import { triggerScript } from '@sr-connect/trigger'

const { invocationId } = await triggerScript('ProcessData', {
	functionName: 'processChunk',
	payload: { issueKey: 'ABC-1' },
})
```

Schedules a separate invocation of the named script in the same environment and resolves once it is scheduled; the caller never sees the callee's return value. Await it anyway. Options: `functionName`, the default export when omitted; `payload`, sent as JSON, `{}` when omitted, a `Date` arriving as a string; and `retryOn429`. Runs the deployed version, or the draft when nothing is deployed or the chain started from a manual run. Throws when the script is missing in the environment, the payload is too large, the chain exceeds 200, the team is at its invocation limit, or a 429 persists. A `functionName` the script does not export fails the callee, so look in its logs. Use it to chain batches past the 15-minute cap with progress in record storage, and to parallelize CPU-bound work, since `Promise.all` only parallelizes I/O.

When you need the return value, or need to run a script in another environment, workspace or team, use the CLI's `script trigger`, the REST API's trigger endpoint: `--wait` returns the value, capped at 20 seconds. Such a run counts as a manual run, so it is never queued and fails outright on a quota breach.

## Convert

`@sr-connect/convert`, in every workspace. Import functions singly, or the `Convert` namespace where the same functions drop the prefix, `Convert.textToBase64`.

```ts
convertBase64ToBuffer(base64: string): Uint8Array;
convertBase64ToText(base64: string, encoding?: TextEncoding): string;
convertBufferToBase64(buffer: ArrayBuffer, fastTransfer?: boolean): string;
convertBufferToText(buffer: ArrayBuffer, encoding?: TextEncoding, fastTransfer?: boolean): string;
convertTextToBase64(text: string, encoding?: TextEncoding): string;
convertTextToBuffer(text: string, encoding?: TextEncoding): Uint8Array;
convertTextToText(text: string, sourceEncoding: TextEncoding, targetEncoding?: TextEncoding): string;
convertArrayBufferToFormDataBuffer(...chunks: FormDataChunk[]): BufferedFormData; // { arrayBuffer, contentType }
```

Encodings default to `utf8`; `utf-16le` and `base64url` are among the options. `fastTransfer` consumes the buffer you pass.

## Fetch

`fetch<T>(url: string, init?)` returns `Promise<Response<T>>`. Not spec-compliant:

- URL string only. Options `method`, `headers`, `body`, `agent`.
- `body`: `string`, `ArrayBuffer`, `ArrayBufferView` or `FormData`. Not `Blob`; pass `blob.arrayBufferSync()`. `FormData` sets the multipart content type for you.
- A non-2xx status does not reject; check `response.ok`. A network failure rejects with `ServiceError` whose `service` is `Fetch`.
- The body can be read once. `response.json<J>()` takes a type parameter.
- `Response.redirected` is always false, `url` empty, `type` `default`.
- `Headers` is case-sensitive and response headers are lower-case, so read `response.headers.get('content-type')`.
- `URL` properties are snapshots; mutating `searchParams` does not update `href`. Build the string and construct again.

Request headers the platform understands:

| Header                                                                               | Effect                                                                                                                                    |
| ------------------------------------------------------------------------------------ | ----------------------------------------------------------------------------------------------------------------------------------------- |
| `x-stitch-ignore-ssl-check`                                                          | Same as `agent.rejectUnauthorized: false`                                                                                                 |
| `x-stitch-store-body: true`                                                          | Store the response body server-side instead of returning it; the response carries `x-stitch-stored-body-id`. Implies `x-stitch-drop-body` |
| `x-stitch-stored-body-id`                                                            | On a later request, send the stored body as the request body                                                                              |
| `x-stitch-transform-stored-body`                                                     | `form-data` (default) or `embedded-base64`                                                                                                |
| `x-stitch-stored-body-form-data-file-name`, `-file-identifier`, `-additional-fields` | Multipart file name (default `file`), field name (default `file`; ServiceNow wants `uploadFile`), extra fields as `key:value;foo:bar;`    |
| `x-stitch-drop-body: true`                                                           | Send no body, for a service without `HEAD`                                                                                                |

Response header `x-stitch-time` is the milliseconds the remote call took. Never set `x-stitch-connection-id` yourself; managed APIs do.

### Mutual TLS and custom CAs

`agent: { rejectUnauthorized?, ca?, cert, key?, passphrase? }`, PEM strings or ArrayBuffers, arrays allowed; an indented template literal is fine, lines are trimmed. Setting `ca` replaces the default roots entirely. Keep certificates and keys in record storage with `secure: true`, or in a TEXT parameter under 4000 characters. A PASSWORD parameter does not work here, since it is only injected into HTTP bodies and headers.

### Signing a JWT

No `subtle.digest`, so use `jose-browser-runtime` from the package manager. It is what the docs use; it is not on the verified list.

```ts
import { importPKCS8, SignJWT } from 'jose-browser-runtime'

const privateKey = await importPKCS8(privateKeyPem, 'RS256')
const jwt = await new SignJWT({ scope: 'read' })
	.setProtectedHeader({ alg: 'RS256' })
	.setIssuedAt()
	.setIssuer('urn:example:issuer')
	.setAudience('urn:example:audience')
	.setExpirationTime('2h')
	.sign(privateKey)
```

The private key comes from record storage or an environment parameter, never from source.

### Attachments and large bodies

Managed API attachment methods take `content` as `string` or `ArrayBuffer`:

```ts
const image = await (await fetch(url)).arrayBuffer()
await JiraCloud.Issue.Attachment.addAttachments({
	issueIdOrKey: 'ISSUE-1',
	body: [{ fileName: 'image.jpg', content: image }],
})
```

Through fetch, build the multipart body with the convert helper so the bytes are copied once; `Blob` and `FormData` copy several times:

```ts
import { Convert } from '@sr-connect/convert'

const form = Convert.arrayBufferToFormDataBuffer({ fileName: 'image.jpg', value: image })
await JiraCloud.fetch(`/rest/api/3/issue/${issueKey}/attachments`, {
	method: 'POST',
	body: form.arrayBuffer,
	headers: { 'X-Atlassian-Token': 'no-check', 'Content-Type': form.contentType },
})
```

Above about 100 MB the body will not fit in memory. Let the platform store and stream it; only the ID passes through the script. Works with `fetch` and the connection's `.fetch`, not with managed API methods:

```ts
const download = await JiraCloud.fetch(attachment.content, { headers: { 'x-stitch-store-body': 'true' } })
const storedBodyId = download.headers.get('x-stitch-stored-body-id')
if (!download.ok || !storedBodyId) {
	throw Error(`Download failed: ${download.status}`)
}
await JiraCloud.fetch(`/rest/api/3/issue/${issueKey}/attachments`, {
	method: 'POST',
	headers: {
		'X-Atlassian-Token': 'no-check',
		'x-stitch-stored-body-id': storedBodyId,
		'x-stitch-stored-body-form-data-file-name': attachment.filename,
	},
})
```

Base64 variant: `x-stitch-transform-stored-body: embedded-base64` and a body of your own with the marker `[storedBodyBase64]` exactly once. In `form-data` mode any body you pass is ignored.

## Packages

| Kind                                  | Pattern                                                     |
| ------------------------------------- | ----------------------------------------------------------- |
| Managed API, runtime build            | `@managed-api/<service>[-v<N>]-sr-connect`                  |
| Managed API, types and core           | `@managed-api/<service>[-v<N>]-core`                        |
| Shared managed API errors and helpers | `@managed-api/commons-core`                                 |
| App events                            | `@sr-connect/<app>`, types under `@sr-connect/<app>/events` |
| Generic HTTP events                   | `@sr-connect/generic-app/events/http`                       |

Those are shapes, not a way to derive a name. The two families spell the same app differently and neither follows
the app's display name, so a name guessed from the pattern is often a 404 and `package add` takes the string you
give it with no suggestion. Read the name out of this table, verified against the registry on 2026-09-13. An
empty events cell means the app publishes no event library and its listener, if it has one, is a generic HTTP
listener.

| App                         | Events library                      | Managed API, runtime build                                          |
| --------------------------- | ----------------------------------- | ------------------------------------------------------------------- |
| AWS                         |                                     | `@managed-api/aws-v1-sr-connect`                                    |
| Azure DevOps                | `@sr-connect/azure-devops`          | `@managed-api/azure-devops-v72-sr-connect`                          |
| Bitbucket Cloud             | `@sr-connect/bitbucket-cloud`       | `@managed-api/bitbucket-cloud-v2-sr-connect`                        |
| Bitbucket On-Premise        | `@sr-connect/bitbucket-on-premise`  | `@managed-api/bitbucket-on-premise-v1-sr-connect`                   |
| Confluence Cloud            |                                     | `@managed-api/confluence-cloud-v2-sr-connect`                       |
| Confluence On-Premise       | `@sr-connect/confluence-on-premise` | `@managed-api/confluence-on-prem-v7-sr-connect`                     |
| Generic                     | `@sr-connect/generic-app`           | `@managed-api/generic-sr-connect`                                   |
| GitHub                      | `@sr-connect/github`                | `@managed-api/github-sr-connect`                                    |
| GitLab                      | `@sr-connect/gitlab`                | `@managed-api/gitlab-v4-sr-connect`                                 |
| Google Calendar             |                                     | `@managed-api/google-calendar-v3-sr-connect`                        |
| Google Sheets               |                                     | `@managed-api/google-sheets-v4-sr-connect`                          |
| Jira Cloud                  | `@sr-connect/jira-cloud`            | `@managed-api/jira-cloud-v3-sr-connect`                             |
| Jira On-Premise             | `@sr-connect/jira-on-premise`       | `@managed-api/jira-on-prem-v8-sr-connect`                           |
| JSM Cloud                   |                                     | `@managed-api/jira-service-management-cloud-sr-connect`             |
| JSM Cloud Assets            |                                     | `@managed-api/jira-service-management-cloud-assets-sr-connect`      |
| JSM On-Premise              |                                     | `@managed-api/jira-service-management-on-premise-v4-sr-connect`     |
| JSM On-Premise Assets       |                                     | `@managed-api/jira-service-management-on-premise-assets-sr-connect` |
| Microsoft Teams             | `@sr-connect/microsoft`             | `@managed-api/microsoft-graph-v1-sr-connect`                        |
| monday.com                  | `@sr-connect/monday`                | `@managed-api/monday-v2025-07-sr-connect`                           |
| NetSuite                    | `@sr-connect/netsuite`              | `@managed-api/netsuite-v1-sr-connect`                               |
| Opsgenie                    | `@sr-connect/opsgenie`              | `@managed-api/opsgenie-sr-connect`                                  |
| Salesforce                  | `@sr-connect/salesforce`            | `@managed-api/salesforce-v57-sr-connect`                            |
| ServiceNow                  | `@sr-connect/servicenow`            | `@managed-api/service-now-sr-connect`                               |
| Slack                       | `@sr-connect/slack`                 | `@managed-api/slack-sr-connect`                                     |
| Statuspage                  | `@sr-connect/statuspage`            | `@managed-api/statuspage-v1-sr-connect`                             |
| Tempo Cloud                 |                                     | `@managed-api/tempo-cloud-v4-sr-connect`                            |
| Tempo Planner On-Premise    |                                     | `@managed-api/tempo-planner-on-premise-v1-sr-connect`               |
| Tempo Timesheets On-Premise |                                     | `@managed-api/tempo-timesheets-on-premise-v4-sr-connect`            |
| Trello                      |                                     | `@managed-api/trello-sr-connect`                                    |
| Zendesk                     | `@sr-connect/zendesk`               | `@managed-api/zendesk-v2-sr-connect`                                |
| Zoom                        | `@sr-connect/zoom`                  | `@managed-api/zoom-v2-sr-connect`                                   |

The traps worth naming, because each one looks like a typo and is not: ServiceNow is `servicenow` in the events
family and `service-now` in the Managed API one; Jira On-Premise is `jira-on-premise` against `jira-on-prem`;
Microsoft Teams is `microsoft` against `microsoft-graph-v1`; and Tempo Planner On-Premise is `v1` where its
Timesheets sibling is `v4`. The `-core` package for types is the runtime name with `-sr-connect` replaced by
`-core`, so `@managed-api/service-now-core`.

An app can publish more than one Managed API. Jira Cloud also has `@managed-api/jira-software-cloud-sr-connect`,
which a workspace can carry beside the main one. `package list` reports what a given workspace actually has, and
`package list-npm-versions <name>` answers whether a name exists at all without credentials or an instance, which
is how to check a name this table does not carry.

Always present: `@sr-connect/runtime-types`, which supplies the globals and `Context` with no import, `@sr-connect/convert`, `@sr-connect/record-storage`, `@sr-connect/trigger`. For local Node runs, `@sr-connect/node-runtime-types` declares `Context` alone and is wired through `node/tsconfig.json`.

Event libraries and managed API packages arrive in `package.json` when the listener or API connection is created; `package add` brings one in by hand, which is how a Managed API class becomes available for a Generic connection.

Third-party packages must be added through `package add` before a script can import them; installing locally only serves local tooling, which belongs in `devDependencies`. ESM imports only. Add `@types/<name>` beside a package without its own types. The runtime is not Node, so prefer isomorphic packages built on web standards; see https://wintertc.org.

Verified third-party packages, from the product's package manager. A pinned version is known to work; unpinned means latest. Anything else is unverified and may not run.

| Package                         | Version       | Use                             |
| ------------------------------- | ------------- | ------------------------------- |
| `dayjs`                         | latest        | dates                           |
| `validator`, `@types/validator` | latest        | string validation               |
| `ulid`                          | 2.4.0         | sortable unique IDs             |
| `fast-xml-parser`               | 4.5.3         | XML                             |
| `gql-query-builder`             | latest        | hand-built GraphQL              |
| `yaml`                          | 2.6.1         | YAML                            |
| `entities`                      | latest        | HTML entities                   |
| `promise-throttle-all`          | latest        | concurrency limit over promises |
| `slack-block-builder`           | latest        | Slack Block Kit                 |
| `chai`, `@types/chai`           | 6.0.1, latest | assertions                      |

After writing something complex by hand, offer to replace it with one of these.

## Logging and troubleshooting

`console.*` writes to the invocation log and the runtime formats objects, so pass them as arguments, never `JSON.stringify`: `console.log('User:', user)`. One entry per fact, label first when there are more than three fields. Log sparingly; 1,000 lines per invocation is the cap. Uncaught errors get a stack trace for free; unawaited rejections get nothing.

Where to look: the invocation log for the thrown error and console output; the HTTP log for every outbound request and response with `x-stitch-time`; the audit log for configuration changes; then replay the invocation or fire a test payload to reproduce with known input. `console.time`/`timeEnd` measure your own code in milliseconds; `performance.now()` is in seconds.

## Workspace README

Write it for the person who sets up and runs the integration in the product, not for a developer. No implementation detail, no local tooling, no mention of the CLI or of an agent. Script names without `scripts/` and without `.ts`, the way the product shows them. Keep an existing README's structure and add missing sections. Add the changelog only on a later significant change.

Pinned packages is the one section a later reader cross-references against `package list`. Every package held below latest goes in it with the version and the reason, whether the verified table above pins it or the user asked for it. Omit the section when nothing is pinned.

```markdown
# Integration name

## Overview

What is integrated, what triggers it, what it does, why.

## Setup

### Connectors

Required connectors by name and app.

### API connections

Each connection and the connector it links to.

### Event listeners

Each listener, its connector, the script it runs, the webhook to register on the app side.

### Scheduled triggers

Each trigger, its script, the recommended schedule; schedules run in UTC.

### Parameters

Every parameter with type, description, an example value, any security note.

## Usage

How to trigger it, how to verify it worked, how to test.

## Considerations

Rate limits, data volume, security, known limitations. Omit if empty.

### Pinned packages

Each package held at a version other than latest, the version, and why. Omit if none.

## Troubleshooting

Where to look in the product's logs, common configuration mistakes, checks on the app side.

## Changelog

### YYYY-MM-DD

One entry per day.
```
