# Testing ScriptRunner Connect workspace scripts locally

Load this only when the user has asked for tests. It describes the clone `local-workspace clone` writes and how to run Jest against the scripts in it. The examples were run against a real clone; the scaffold can move, so check the list at the end before writing the first test.

## When to write tests

Do not write tests unless the user asks. A test suite is extra effort that pays off for long-lived or complex integrations, and the user decides whether this workspace is one of those.

When the user asks, settle one question before writing anything. There are two kinds of test and they need different registry code:

- Mocked tests. The script's API connections answer from canned responses you write. No network, no credentials, deterministic, fast.
- Integration tests. The script's API connections forward to the real service through a class you register locally, with credentials you supply. They need a test tenant or a safe partition and they mutate whatever the script mutates.

Ask which one the user wants. If they want both, write the mocked suite first.

## Layout of the clone

```text
ev-params.ts               generated EV interface for the environment parameters
package.json               scripts, dependencies, dev dependencies
pnpm-workspace.yaml        pnpm settings the clone relies on
tsconfig.base.json         shared compiler options
tsconfig.json              the platform project: scripts/ and ev-params.ts
scripts/                   the workspace scripts, one file per script
scripts/api/<name>/index.ts   generated import for each API connection, do not edit
test-payloads/<Listener> (<id>)/<name>.json   event listener test payloads, bare event bodies
node/tsconfig.json         the Node project: everything under node/ plus ev-params.ts
node/jest.config.ts        Jest configuration
node/runtimeMocks.ts       Node replacements for the platform runtime globals
node/apiRegistry.ts        local implementations of API connections
node/global.d.ts           types for the runtime globals the mocks install
node/tests/                your tests go here; empty in a fresh clone
```

### Where tests go

Tests live under `node/tests/` and mirror the path of the script under `scripts/`, with a `.test.ts` suffix.

```text
scripts/OnJiraCloudIssueCreated.ts   ->  node/tests/OnJiraCloudIssueCreated.test.ts
scripts/foo/bar/Utils.ts             ->  node/tests/foo/bar/Utils.test.ts
```

Jest only runs files matching `**/node/tests/**/*.test.ts`. That is deliberate. Helper modules and fixtures can sit anywhere under `node/tests/` without being run as suites. The config says so:

```ts
import type { Config } from 'jest'
import { createDefaultEsmPreset } from 'ts-jest'

export default {
	...createDefaultEsmPreset({
		tsconfig: 'node/tsconfig.json',
	}),
	// Only pick up *.test.ts files, so helper modules and fixtures can live under node/tests/ without being run as suites.
	testMatch: ['**/node/tests/**/*.test.ts'],
} satisfies Config
```

The relative import from a test back to its script gets one `../` deeper for each folder the script sits in. `node/tests/foo/bar/Utils.test.ts` imports `../../../../scripts/foo/bar/Utils`.

### Which TypeScript project applies

There are two projects and they share one base:

```json
{
	"compilerOptions": {
		"target": "ES2020",
		"module": "ESNext",
		"noEmit": true,
		"sourceMap": false,
		"moduleResolution": "bundler",
		"lib": ["ES2020"],
		"strict": true,
		"skipLibCheck": true,
		"esModuleInterop": true
	}
}
```

The root `tsconfig.json` is the platform project. It adds the `@sr-connect/runtime-types` globals and compiles `scripts` and `ev-params.ts`:

```json
{
	"extends": "./tsconfig.base.json",
	"compilerOptions": {
		"types": ["@sr-connect/runtime-types"]
	},
	"include": ["scripts", "ev-params.ts"]
}
```

`node/tsconfig.json` is the Node project. It adds the Jest globals and `@sr-connect/node-runtime-types`, and compiles everything under `node/` plus `ev-params.ts`:

```json
{
	"extends": "../tsconfig.base.json",
	"compilerOptions": {
		"types": ["@types/jest", "@sr-connect/node-runtime-types"]
	},
	"include": ["./", "../ev-params.ts"]
}
```

Tests compile under the Node project. Two consequences matter:

- Both projects are ES modules. Jest runs in ESM mode through `createDefaultEsmPreset` and `--experimental-vm-modules`. There is no CommonJS anywhere.
- `node/apiRegistry.ts` compiles under both projects, because every generated `scripts/api/<name>/index.ts` imports it and the root project compiles `scripts`. Under the root project the only types are `@sr-connect/runtime-types`, which do not declare `Buffer` or `process`. Anything you put in `apiRegistry.ts` must type-check with the platform types alone: `TextEncoder`, `TextDecoder`, `fetch`, `JSON` and the `@managed-api/commons-core` classes are fine; `Buffer` and `process.env` fail `pnpm typecheck` with TS2591. Keep Node-only code in files under `node/tests/` and inject it from there.

`Context` is a global type in both projects. `EV` comes from `ev-params.ts`, which both projects include. Neither needs an import.

### How the tests run

The scripts in `package.json`:

```json
"scripts": {
    "lint": "eslint",
    "lint:fix": "eslint --fix",
    "typecheck": "tsc -p tsconfig.json && tsc -p node/tsconfig.json",
    "test": "cross-env NODE_OPTIONS=--experimental-vm-modules jest -c=./node/jest.config.ts --no-cache"
}
```

Run `pnpm test`. `npm test` runs the same script. `pnpm typecheck` compiles both projects, tests included, and `pnpm lint` covers `node/tests/**` because `eslint.config.js` matches `**/*.ts` with both tsconfig projects. Run all three before reporting the tests done. Jest prints two `ExperimentalWarning: VM Modules` lines per run. They are expected.

Node 22 or newer is the floor to assume: the CLI that wrote the clone requires it. The toolchain's own floors are lower, and the examples in this file ran on Node 24. `package.json` declares no `engines` field.

Prefer pnpm. The clone ships no lockfile; it ships a `pnpm-workspace.yaml` that does two things pnpm needs: it allows the `unrs-resolver` build script that Jest 30's resolver depends on, and it hoists `@managed-api/*` to the root so the generated `scripts/api/**` files can import `@managed-api/commons-core`, a transitive dependency. Use NPM only when pnpm is not installed.

In ESM mode the `jest` object is not a global. `describe`, `test`, `expect`, `beforeEach` and the rest are, but `jest.spyOn` and friends need `import { jest } from '@jest/globals'`, which the clone ships in `devDependencies`.

Skip the import and the dependency in a test that never touches the `jest` object.

## What runtimeMocks.ts provides

Every test file starts with `import '../runtimeMocks';` adjusted for depth. The module patches globals when it loads, so it has to load before the script under test runs anything. Import order in the test file is enough; ES module imports evaluate in source order.

The file installs four globals and patches a fifth.

`_convert` backs `@sr-connect/convert`. It is a complete implementation on top of `Buffer`.

`_processRecordStorageRequest` backs `@sr-connect/record-storage` with an in-memory store that enforces the platform's rules, so a script that misuses storage fails locally the same way:

- The key is required and must be non-empty after trimming, under 1024 bytes, and match `^[A-Za-z0-9_-]*$`. Whitespace fails the character check.
- Keys are lowercased. `MyKey` and `mykey` are the same record and `getAllKeys` returns lowercased keys.
- `null` and `undefined` are rejected as values. `0`, `false` and `''` are stored, and `exists` reports them as present.
- `teamScope` is only valid with `scope: 'team'` and must be alphanumeric, at most 200 characters.
- Scopes are separate partitions, not nested. A workspace-scope write is invisible to an environment-scope read. Each `teamScope` is its own partition.
- `ttl` expires records. The invocation scope is capped at 20 minutes whether or not a ttl was requested.
- `denyUpdateOverwrite` returns a 400 when the record already exists.

What it does not do: `secure` is ignored and values round-trip unencrypted, `getAllKeys` is not paginated, payload size limits are not enforced, rate limiting never happens so the package's 429 retry path never runs, and every invocation in one test process shares the `invocation` scope. The store is a module-level map: tests in one file share it, and each test file gets a fresh copy because Jest gives every file its own module registry. To reset between tests in one file, delete the keys the test wrote, or replace the whole function with `jest.spyOn(global, '_processRecordStorageRequest').mockImplementation(...)`, which the mock's own comment suggests.

`_triggerScript` backs `@sr-connect/trigger`. It logs a `console.warn` saying the call was ignored and resolves with `invocationId: 'MOCK_INVOCATION_ID'`. Nothing is triggered.

`ServiceError` is the platform's error class, same message format including the ` - ScriptRunner Connect Error code: <n>` suffix.

`fetch` is replaced with a wrapper that does what the platform's egress does:

- A request carrying an `x-stitch-connection-id` header and a relative URL is routed to the entry in `API_REGISTRY` whose `connectionId` matches. No match throws `Connection ID ... was passed with the fetch headers, but no matching locally registered API was found in node/apiRegistry.ts`.
- All `x-stitch-*` headers are stripped from the outbound request, for routed and plain calls alike.
- `x-stitch-store-body`, `x-stitch-stored-body-id`, `x-stitch-transform-stored-body` and `x-stitch-drop-body` behave as on the platform, including the form-data and embedded-base64 transforms.
- A GET or HEAD with a body throws `Request with GET/HEAD method cannot have body`.
- A missing content type defaults to `application/json`.
- Every response carries `x-stitch-time` and loses `content-encoding` and `transfer-encoding`.

Validation errors are thrown as plain `Error` where the platform throws `FetchError` or `TypeError` with the same message. Catch by message, not by type. `x-stitch-ignore-ssl-check` is ignored.

Set `SRC_LOG_HTTP_CALLS=true` to write every intercepted call to `http_logs_<timestamp>.json` in the current directory. `.gitignore` already excludes that pattern.

## How API connections are swapped

Each API connection in the workspace has a generated file at `scripts/api/<name>/index.ts`. `<name>` is the connection's path, so a connection named `jira/cloud` lives at `scripts/api/jira/cloud/index.ts` and one named `slack2` at `scripts/api/slack2/index.ts`. The generated file reads:

```ts
import { PlatformImplementation } from '@managed-api/commons-core'
import { JiraCloudApi } from '@managed-api/jira-cloud-v3-sr-connect'
import { API_REGISTRY } from '../../../../node/apiRegistry'

/**
 * Do not modify this file, it is auto-generated.
 */
export default (API_REGISTRY['jira/cloud'] as JiraCloudApi) ??
	new (class extends JiraCloudApi {
		constructor() {
			super('01M0WCN2GPSHC88Q32JTN9R52B')
		}
		protected getPlatformImplementation(): PlatformImplementation {
			throw new Error(
				"API Connection 'jira/cloud' local implementation not found, consider adding the implementation in the `apiRegistry.ts` file.",
			)
		}
	})()
```

Three things follow from it.

The registry key is the connection path exactly as it appears under `scripts/api/`, with no `api/` prefix: `'jira/cloud'`, `'slack2'`.

The entry must be an instance of the connection's Managed API class, because the script calls `JiraCloud.Issue.getIssue(...)` on whatever the registry returns. The registry type enforces the shape:

```ts
import { BaseApiCore } from '@managed-api/commons-core'

export abstract class ManagedApiCore extends BaseApiCore {
	constructor(public connectionId: string) {
		super()
	}
}

export type ApiRegistry = Record<string, ManagedApiCore>
```

So the value extends `BaseApiCore` and carries a `connectionId`. The way to get both is to extend the `*-sr-connect` class the generated file imports, whose constructor takes the connection ID, and override `getPlatformImplementation()`. A plain object with a fake `Issue.getIssue` does not type-check and would not carry the class's error handling either.

The entry must exist before the script module is first evaluated. `BaseApiCore`'s constructor calls `getPlatformImplementation()` immediately, so when the key is missing the fallback class throws while `scripts/api/<name>/index.ts` is being imported, and any test importing that script fails at load with `local implementation not found`. Registering in `apiRegistry.ts` at module level satisfies this for every test. Registering from a test at runtime works only if the test assigns into `API_REGISTRY` before it `await import(...)`s the script.

Always override `getPlatformImplementation()` in the class you register. The `*-sr-connect` default implementation performs its call through the global `fetch` with a relative URL and the `x-stitch-connection-id` header. Under `runtimeMocks.ts` that call is routed straight back to the registry entry with that connection ID, which is the same instance, which calls `fetch` again. Your override replaces `performHttpCall` with either canned responses or an absolute-URL call to a real server, and neither goes back through the router.

Two constraints on the class body:

- Do not name your method `performHttpCall`. The `*-sr-connect` class declares a private one and TypeScript refuses a subclass that redeclares it, TS2415. Any other name works.
- `getPlatformImplementation()` runs inside `super()`, before your own constructor fields are assigned. Read fields like a base URL inside the function that handles the request, never in the body of `getPlatformImplementation()` itself.

`buildResponse(url, status, statusText, headers, body)` is a protected method on every Managed API core class and returns the `Response` the layer expects. `headers` is the `Headers` class from `@managed-api/commons-core`, not the web one; its constructor accepts a plain record.

## Building a Context

The scaffold ships no `getContext` helper. Write one in the test file, or in a shared module under `node/tests/` if several tests need it. `Context<EV>` is declared by `@sr-connect/node-runtime-types` and needs these fields:

```ts
function getContext(vars: EV): Context<EV> {
	return {
		startTime: Date.now(),
		timeout: 900_000,
		availableMemory: 400,
		invocationId: 'TEST_INVOCATION_ID',
		triggerType: 'MANUAL',
		rootTriggerType: 'MANUAL',
		environment: {
			uid: 'TEST_ENVIRONMENT_UID',
			name: 'Test',
			vars,
		},
		// Only for an invocation that came off an event queue:
		// queuedAt: Date.now() - 5_000,
		// queue: { uid: 'TEST_QUEUE_UID', name: 'orders', groupId: 'TEST-1' },
		// Only when the script runs from a deployment:
		// deployment: { uid: 'TEST_DEPLOYMENT_UID', version: '1.0.0' },
	}
}
```

`triggerType` is one of `EXTERNAL`, `MANUAL`, `SCHEDULED`, `MANUAL_EVENT_LISTENER`, `CHAINED`; `rootTriggerType` is the same set without `CHAINED`. `vars` must satisfy the `EV` interface in `ev-params.ts`, so read that file and pass the parameters the script under test reads. Every member there is optional (BOOLEAN aside), which is deliberate: a test that omits one exercises the unset case the environment can genuinely be in.

## Intercepting console output

Scripts report through `console.log`. Spy on it per test and restore afterwards so one test's spy does not leak into the next:

```ts
let logged: string[] = []

beforeEach(() => {
	logged = []
	jest.spyOn(console, 'log').mockImplementation((...args: unknown[]) => {
		logged.push(args.map(String).join(' '))
	})
})

afterEach(() => {
	jest.restoreAllMocks()
})
```

`args.map(String)` matters because scripts log numbers and objects, not only strings. Objects render as `[object Object]` through `String`; use `JSON.stringify` in the mapper when a test needs to assert on one.

## Example: a script with one mocked API connection

The script under test, `scripts/OnJiraCloudIssueCreated.ts`, as the clone holds it:

```ts
import JiraCloud from './api/jira/cloud'
import { IssueCreatedEvent } from '@sr-connect/jira-cloud/events'
import { sum } from './foo/bar/Utils'

/**
 * Entry point to Issue Created event
 *
 * @param event Object that holds Issue Created event data
 * @param context Object that holds function invocation context data
 */
export default async function (event: IssueCreatedEvent, context: Context<EV>): Promise<void> {
	console.log(sum(2, 3))

	const issue = await JiraCloud.Issue.getIssue({
		issueIdOrKey: 'EL-68',
	})

	console.log('5', issue.fields?.summary)
}
```

The registry with a mock for its one connection, `node/apiRegistry.ts`. The two exported declarations at the top are the scaffold's; the class and the entry are what you add. The switch routes on method and path and throws for anything the test did not anticipate, so an unexpected call fails loudly instead of returning nothing:

```ts
import {
	BaseApiCore,
	Headers as ApiHeaders,
	PlatformImplementation,
	Request as ApiRequest,
} from '@managed-api/commons-core'
import { JiraCloudApi } from '@managed-api/jira-cloud-v3-sr-connect'

export abstract class ManagedApiCore extends BaseApiCore {
	constructor(public connectionId: string) {
		super()
	}
}

export type ApiRegistry = Record<string, ManagedApiCore>

class JiraCloudApiMock extends JiraCloudApi {
	constructor() {
		super('LOCAL_JIRA_CLOUD')
	}

	protected getPlatformImplementation(): PlatformImplementation {
		return {
			buffer: {
				encode: (input) => new TextEncoder().encode(input).buffer as ArrayBuffer,
				decode: (input) => new TextDecoder().decode(new Uint8Array(input)),
			},
			performHttpCall: (request) => this.respond(request),
		}
	}

	private async respond(request: ApiRequest) {
		switch (`${request.method} ${request.url}`) {
			case 'GET /rest/api/3/issue/EL-68':
				return super.buildResponse(
					request.url,
					200,
					'OK',
					new ApiHeaders({ 'content-type': 'application/json' }),
					JSON.stringify({ key: 'EL-68', fields: { summary: 'Test issue summary' } }),
				)
			case 'GET /rest/api/3/issue/EL-404':
				return super.buildResponse(
					request.url,
					404,
					'Not Found',
					new ApiHeaders({ 'content-type': 'application/json' }),
					JSON.stringify({
						errorMessages: ['Issue does not exist or you do not have permission to see it.'],
					}),
				)
			default:
				throw new Error(`No mock implementation for ${request.method} ${request.url}`)
		}
	}
}

export const API_REGISTRY: ApiRegistry = {
	'jira/cloud': new JiraCloudApiMock(),
}
```

The test, `node/tests/OnJiraCloudIssueCreated.test.ts`. The first assertion follows whatever the `sum` helper of the example workspace returns:

```ts
import '../runtimeMocks'
import { jest } from '@jest/globals'
import onIssueCreated from '../../scripts/OnJiraCloudIssueCreated'
import { IssueCreatedEvent } from '@sr-connect/jira-cloud/events'

function getContext(vars: EV): Context<EV> {
	return {
		startTime: Date.now(),
		timeout: 900_000,
		availableMemory: 400,
		invocationId: 'TEST_INVOCATION_ID',
		triggerType: 'MANUAL',
		rootTriggerType: 'MANUAL',
		environment: {
			uid: 'TEST_ENVIRONMENT_UID',
			name: 'Test',
			vars,
		},
	}
}

let logged: string[] = []

beforeEach(() => {
	logged = []
	jest.spyOn(console, 'log').mockImplementation((...args: unknown[]) => {
		logged.push(args.map(String).join(' '))
	})
})

afterEach(() => {
	jest.restoreAllMocks()
})

test('logs the summary of EL-68', async () => {
	const event = { issue: { key: 'EL-68' } } as unknown as IssueCreatedEvent

	await onIssueCreated(event, getContext({ FOLDER: { BOOLEAN: true }, LIST: [] }))

	expect(logged).toEqual(['6', '5 Test issue summary'])
})
```

The `vars` object matches the example clone's `ev-params.ts`. Read the actual clone's file and pass what the script under test reads.

A 404 from the mock surfaces to the script as a `NotFoundError` from `@managed-api/commons-core`, unless the script's error strategy handles it. Test the failure path by asserting the rejection:

```ts
test('a missing issue rejects', async () => {
	const { default: JiraCloud } = await import('../../scripts/api/jira/cloud/index')
	await expect(JiraCloud.Issue.getIssue({ issueIdOrKey: 'EL-404' })).rejects.toThrow()
})
```

## Example: the same connection against a real server

The scaffold supports this. The registered class forwards each request to a real base URL with real credentials instead of answering from a switch. Two placement rules come from the type-check constraint above: the class reads nothing from `process.env`, and it lives under `node/tests/` rather than in `apiRegistry.ts`, so the root project never compiles it. The test constructs it with credentials from the environment and registers it before importing the script.

`node/tests/support/JiraCloudLive.ts`:

```ts
import { Headers as ApiHeaders, PlatformImplementation, Request as ApiRequest } from '@managed-api/commons-core'
import { JiraCloudApi } from '@managed-api/jira-cloud-v3-sr-connect'

export class JiraCloudLive extends JiraCloudApi {
	constructor(
		private baseUrl: string,
		private email: string,
		private apiToken: string,
	) {
		super('LIVE_JIRA_CLOUD')
	}

	protected getPlatformImplementation(): PlatformImplementation {
		return {
			buffer: {
				encode: (input) => new TextEncoder().encode(input).buffer as ArrayBuffer,
				decode: (input) => new TextDecoder().decode(new Uint8Array(input)),
			},
			performHttpCall: (request) => this.forward(request),
		}
	}

	private async forward(request: ApiRequest) {
		const url = new URL(request.url, this.baseUrl)
		const response = await fetch(url, {
			method: request.method,
			headers: {
				...Object.fromEntries(request.headers),
				Authorization: `Basic ${Buffer.from(`${this.email}:${this.apiToken}`).toString('base64')}`,
			},
			body: ['GET', 'HEAD'].includes(request.method) ? undefined : await request.arrayBuffer(),
		})
		return super.buildResponse(
			url.toString(),
			response.status,
			response.statusText,
			new ApiHeaders(Object.fromEntries(response.headers)),
			await response.arrayBuffer(),
		)
	}
}
```

The absolute URL and the missing `x-stitch-connection-id` header are what keep this call out of the router; `runtimeMocks.ts` passes it through to the real `fetch`, and `SRC_LOG_HTTP_CALLS=true` records it.

`node/tests/OnJiraCloudIssueCreated.live.test.ts`. The suite skips itself when the credentials are not set, so `pnpm test` stays green on a machine without them:

```ts
import '../runtimeMocks'
import { API_REGISTRY } from '../apiRegistry'
import { JiraCloudLive } from './support/JiraCloudLive'

const { JIRA_BASE_URL, JIRA_EMAIL, JIRA_API_TOKEN } = process.env
const describeLive = JIRA_BASE_URL && JIRA_EMAIL && JIRA_API_TOKEN ? describe : describe.skip

describeLive('OnJiraCloudIssueCreated against a real Jira', () => {
	beforeAll(() => {
		API_REGISTRY['jira/cloud'] = new JiraCloudLive(JIRA_BASE_URL!, JIRA_EMAIL!, JIRA_API_TOKEN!)
	})

	test('reads EL-68', async () => {
		const { default: JiraCloud } = await import('../../scripts/api/jira/cloud/index')
		const issue = await JiraCloud.Issue.getIssue({ issueIdOrKey: 'EL-68' })
		expect(issue.key).toBe('EL-68')
	})
})
```

The `await import(...)` inside the test is what makes the runtime registration work: a static import at the top of the file would evaluate `scripts/api/jira/cloud/index.ts` before `beforeAll` runs. If `apiRegistry.ts` already registers a mock under the same key, the assignment in `beforeAll` replaces it for this file only, since each test file gets its own module instances.

Run it with the credentials in the environment:

```sh
JIRA_BASE_URL=https://<site>.atlassian.net JIRA_EMAIL=me@example.com JIRA_API_TOKEN=... pnpm test
```

Never write credentials into the repository or into `apiRegistry.ts`. Ask the user for a test tenant before running anything that mutates.

## Practices that hold

- Export the logic you want to test as named functions beside the default export, and test those directly. The default export gets one or two tests that run the whole entry point with a Context and an event.
- Use the event listener test payloads as event fixtures. Each file under `test-payloads/<Listener> (<id>)/` is the bare event body the listener would deliver, so it loads straight into the event type:

    ```ts
    import { readFileSync } from 'node:fs'
    import { IssueCreatedEvent } from '@sr-connect/jira-cloud/events'

    const event: IssueCreatedEvent = JSON.parse(
    	readFileSync(
    		new URL(
    			'../../test-payloads/JiraCloud→IssueCreated (01M0WBJPB31K2090ZNHSVE79BJ)/Default.json',
    			import.meta.url,
    		),
    		'utf8',
    	),
    )
    ```

    The folder name contains a `→` and a space; keep the path verbatim.

- Make the mock's default branch throw. A script that calls an endpoint the test did not anticipate should fail on that call, not later on an `undefined` field.
- Cover the failure paths the script handles: a 404, a 5xx, a rejected fetch. Put each behind its own path in the mock's switch.
- Assert on intercepted console output only for what the script promises to report. Restore the spy in `afterEach`.
- Do not `jest.mock` the API connection module. ESM has no hoisting for it, and the registry already does the job in a way `pnpm typecheck` verifies.
- Do not import `runtimeMocks.ts` from anything under `scripts/`. It does not exist on the platform.
- Leave `scripts/api/**` alone. The CLI regenerates those files.
- Run `pnpm typecheck && pnpm lint && pnpm test` before telling the user the tests are done. The Prettier rules apply to tests: tabs, width 120, single quotes.

## Verify before trusting

Scaffolds move. Before writing the first test, check these in the actual clone:

- `node/jest.config.ts` exists and its `testMatch` still points at `node/tests/**/*.test.ts`. If it changed, put tests where it points.
- `package.json`'s `test` script still passes `-c=./node/jest.config.ts` and `NODE_OPTIONS=--experimental-vm-modules`. If the ESM flag is gone, the `jest` global may be back and the `@jest/globals` import unnecessary.
- The environment parameters file is spelled `ev-params.ts` at the root and both tsconfigs include it. Read its `EV` interface to see which fields the Context can carry; they are all optional, so the compiler will not tell you which ones a test needs.
- `node/tsconfig.json` lists `@types/jest` and `@sr-connect/node-runtime-types`. If `Context` fails to resolve, that line is the first place to look.
- `node/apiRegistry.ts` still exports `API_REGISTRY` and `ApiRegistry`, and the generated `scripts/api/<name>/index.ts` still reads `API_REGISTRY['<name>']`. The key you register must match that string.
- The Managed API package for each connection, in `scripts/api/<name>/index.ts`'s import line, and its version in `package.json`. Extend that class, at that version.
- `node/runtimeMocks.ts`'s header comment. It lists what the mocks ignore, and that list changes.
- `node_modules` is installed and `@managed-api/commons-core` resolves from the root. If it does not, the install was not done with pnpm or `pnpm-workspace.yaml`'s `publicHoistPattern` is gone.
- Which lockfile the install left behind: `pnpm-lock.yaml` for pnpm, `package-lock.json` for NPM. The clone ships neither. Run the scripts with the package manager that installed rather than mixing.
- `@jest/globals` and `@types/node` are in `devDependencies`. Without the first, a test importing it fails `pnpm typecheck`; without the second, `runtimeMocks.ts` may resolve two copies of the fetch types and fail the same way.
