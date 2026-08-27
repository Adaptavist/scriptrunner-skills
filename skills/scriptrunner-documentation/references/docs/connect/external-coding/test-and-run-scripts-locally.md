# Test and Run Scripts Locally

- Platform: connect
- Space: SRC
- Hierarchy: external-coding
- Doc ID: doc-src-409796921
- Source: https://docs.adaptavist.com/src/latest/external-coding/test-and-run-scripts-locally

Normally, once you've uploaded code, you'll run it inside the ScriptRunner web app. However, there are situations where you may want to run scripts locally in the [Node](https://nodejs.org/) runtime; for example, when developing automated tests or you wish to test the script locally in the local Node runtime, although we recommend keep using our [ScriptRunner Connect runtime](https://docs.adaptavist.com/src/latest/scripting/runtime) by triggering the scripts via our web UI to avoid added complexity that is necessary to have the connectors mocked locally.

## Location of locally run code 📁

Any code you intend to run locally in the [Node](https://docs.adaptavist.com/spaces/SRC/pages/426967973/.External+Coding+vDraft_01#id-.ExternalCodingvDraft_01-ScriptRunnerConnectruntimevsNoderuntime) [runtime](https://docs.adaptavist.com/spaces/SRC/pages/426967973/.External+Coding+vDraft_01#id-.ExternalCodingvDraft_01-ScriptRunnerConnectruntimevsNoderuntime) should be placed in the `node` folder. This folder is pre-configured to use Node-specific runtime types.

## Connectors mocking

By default, [API Connections](https://docs.adaptavist.com/src/latest/workspaces/api-connections) and their paired [managed APIs](https://docs.adaptavist.com/src/latest/managed-apis) are found in the `scripts/api` folder. However, this setup does not run locally. To run managed APIs locally, you'll need to mock them. Do not add your local implementations directly to the `scripts/api` folder, as this code is generated and will be overwritten when changes are made to API Connections in the ScriptRunner Connect web app. Instead, use the API registry file located at `node/apiRegistry.ts` to contain any locally managed API mocks for running scripts in the Node runtime.

### Implement Node-specific Managed APIs

To call real API endpoints locally, implement managed APIs that work in the Node runtime, as explained on our [Advanced Managed API Concepts](https://docs.adaptavist.com/src/latest/managed-apis/advanced-managed-api-concepts) page.

You must implement your own authentication logic instead of relying on [ScriptRunner Connect's connectors](https://docs.adaptavist.com/src/latest/connectors).

 Here is an example implementation of [Jira Cloud's Managed API](https://www.npmjs.com/package/@managed-api/jira-cloud-v3-core) that uses the [API keys](https://support.atlassian.com/atlassian-account/docs/manage-api-tokens-for-your-atlassian-account/) authentication method locally:

```
import {
    PlatformImplementation,
    Request,
    Response as CommonsResponse,
    Headers as CommonsHeaders,
    BaseApiCore,
} from '@managed-api/commons-core';
import { JiraCloudApiCore } from '@managed-api/jira-cloud-v3-core';

export class JiraCloudApi extends JiraCloudApiCore {
    constructor(
        private baseUrl: string,
        private email: string,
        private apiToken: string,
    ) {
        super();
    }

    protected getPlatformImplementation(): PlatformImplementation {
        return {
            buffer: {
                encode: (input) => Buffer.from(input, 'utf-8'),
                decode: (input) => Buffer.from(input).toString('utf-8'),
            },
            performHttpCall: (request) => this.performHttpCall(request),
        };
    }

    private async performHttpCall(request: Request): Promise<CommonsResponse> {
        const requestUrl = `${this.baseUrl}${request.url}`; // Substitute base URL
        request.headers.set('Authorization', `Basic ${btoa(`${this.email}:${this.apiToken}`)}`); // Substitute auth token

        const requestHeaders = new Headers();
        request.headers.forEach((value, key) => requestHeaders.append(key, value));

        const response = await fetch(requestUrl, {
            method: request.method,
            headers: requestHeaders,
            body:
                request.method.toLowerCase() !== 'get'
                    ? Buffer.from((await request.arrayBuffer()) ?? new ArrayBuffer(0))
                    : undefined,
        });

        const responseHeaders = new CommonsHeaders();
        response.headers.forEach((value, key) => responseHeaders.append(key, value));

        const body = await response.arrayBuffer();

        return super.buildResponse(response.url, response.status, response.statusText, responseHeaders, body);
    }
}
```

Newer Node version compatibility

With a newer Node version, the code above may yield a compilation error on line 22. Although it should still work if you run it to fix the error, you can try changing the encoding to: `Buffer.from(input, 'utf-8').buffer`. However, be aware that we've encountered an issue where this change may cause unexpected behavior (appearing to be a bug in Node's implementation). If you're noticing that your request bodies are starting to pass along gibberish instead of your requested content, then revert the change and simply ignore the compilation error, or try upgrading Node.

To register this implementation with the API registry, add the following code in `node/apiRegistry.ts`:

```
export const API_REGISTRY: ApiRegistry = {
    'api/jira/cloud': new JiraCloudApi('https://myInstance.atlassian.net', 'user@domain.com', 'API_KEY'),
};
```

API registry structure

The API registry accepts key-value pairs of locally managed API implementations. 

-   Key: API Connection's import path.
-   Value: Managed API class containing your local implementation. 

### Mock implementation of the managed API

If you don't need to make API calls to real endpoints, you can mock the implementation of the managed APIs.  
Here's an example of how to mock an endpoint for [reading an issue from Jira Cloud](https://developer.atlassian.com/cloud/jira/platform/rest/v3/api-group-issues/#api-rest-api-3-issue-issueidorkey-get):

```
import {
    PlatformImplementation,
    Request,
    Response as CommonsResponse,
    Headers as CommonsHeaders,
    BaseApiCore,
} from '@managed-api/commons-core';
import { JiraCloudApiCore } from '@managed-api/jira-cloud-v3-core';

export class JiraCloudApiMock extends JiraCloudApiCore {
    constructor() {
        super();
    }

    protected getPlatformImplementation(): PlatformImplementation {
        return {
            buffer: {
                encode: (input) => Buffer.from(input, 'utf-8'),
                decode: (input) => Buffer.from(input).toString('utf-8'),
            },
            performHttpCall: (request) => this.performHttpCall(request),
        };
    }

    private async performHttpCall(request: Request): Promise<CommonsResponse> {
        switch (request.url) {
            case '/rest/api/3/issue/ISSUE-1':
                return super.buildResponse(
                    request.url,
                    200,
                    'OK',
                    new CommonsHeaders(),
                    JSON.stringify({
                        fields: {
                            summary: 'HELLO WORLD!!!',
                        },
                    }),
                );
            default:
                throw Error(`No mock implementation found for: ${request.url}`);
        }
    }
}

export const API_REGISTRY: ApiRegistry = {
    'api/jira/cloud': new JiraCloudApiMock(),
};
```

### Runtime additions

Some [ScriptRunner Connect runtime](https://docs.adaptavist.com/src/latest/scripting/runtime) features aren't available in Node. Use `node/runtimeMocks.ts` as defaults and modify as needed.

Import runtime mocks in your local code

To apply runtime mocks in your local scripts, import the `runtimeMocks.ts` file into your local script as follows: `import './path/to/runtimeMocks'`.  
Do not import `runtimeMocks.ts` directly into your script files, as this logic does not exist in the ScriptRunner Connect runtime. Instead, import it into the local script file in the `node` folder that you use to call functions from the `scripts` folder.

Continue reading for examples on how to do this for automated tests.

## Automated tests 🧪

The remote workspace file system is pre-configured to run local automated tests using [Jest](https://jestjs.io/). Simply place your test files in the `node/tests` folder and run the command `npm run test`.  
If you use Yarn, execute `yarn test` instead.

Required imports

Ensure that all your test files import both the `runtimeMocks.ts` file and the Jest globals:

```
import '../runtimeMocks';
import { jest } from '@jest/globals';
```

  

### Example

Click here to see our example.

Here's an example of a simple script named `TestableScript.ts` located in the `scripts` folder:

```
import JiraCloud from './api/jira/cloud';

export default async function (event: any, context: Context<EV>): Promise<void> {
    const summary = await getIssueSummary(context.environment.vars.ISSUE_KEY);

    console.log(summary);
}

export async function getIssueSummary(issueKey: string) {
    const issue = await JiraCloud.Issue.getIssue({
        issueIdOrKey: issueKey,
    });

    return issue.fields?.summary;
}
```

And here is a [Jest](https://jestjs.io/) test for it, located in `node/test/TriggerScript.ts`:

```
import '../runtimeMocks';
import { jest } from '@jest/globals';
import DefaultFunction, { getIssueSummary } from '../../scripts/TestableScript';

// Array for intercepted console.log messages
let interceptedConsoleLogs: string[] = [];

// Function for getting mocked Context object
export function getContext(ev: EV): Context<EV> {
    return {
        availableMemory: 400,
        invocationId: 'INVOCATION_ID',
        triggerType: 'MANUAL',
        rootTriggerType: 'MANUAL',
        startTime: Date.now(),
        timeout: 900000,
        environment: {
            uid: 'ENVIRONMENT_UID',
            name: 'Default',
            vars: ev,
        },
    };
}

beforeAll(() => {
    // Mock all console.log methods to intercept messages and store them
    jest.spyOn(console, 'log').mockImplementation((...args) => interceptedConsoleLogs.push(args.join(' ')));
});

describe('Test script', () => {
    const issueKey = 'ISSUE-1';
    const expectedSummary = 'Test summary';

    test('Expect getIssueSummary function to return expected issue summary', async () => {
        const issueSummary = await getIssueSummary(issueKey);

        expect(issueSummary).toBe(expectedSummary);
    });

    test('Expect default function to have printed out issue summary', async () => {
        interceptedConsoleLogs = [];

        await DefaultFunction(
            {},
            getContext({
                ISSUE_KEY: issueKey,
            }),
        );

        expect(interceptedConsoleLogs[0]).toBe(expectedSummary);
    });
});

afterAll(() => {
    jest.clearAllMocks();
});
```

  

## HTTP Logs

With the inclusion of `runtimeMocks` you can also enable logging of intercepted HTTP calls for debugging purposes. To do that set the `SRC_LOG_HTTP_CALLS` environment variable to `true` in your local setup, which will then result in creating `http_logs_<timestamp>.json` files at the root of your workspace project every time you run your script. This file is structured very similarly to how our web-based [HTTP logging](https://docs.adaptavist.com/src/latest/observability/http-logs) works.

## Executing scripts directly in Node

You can also run your scripts directly from Node. To do that, we recommend installing the `[tsx](https://www.npmjs.com/package/tsx)` package. Do not try to run your scripts directly with the tsx, as you'll need to provide the logic that calls your entry functions from a separate file. Place that file in the `node` folder and run that file instead as follows: `npx tsx ./node/yourFile.ts` . 

### Example

Click here to see our example

```
import './runtimeMocks';

import DefaultFunction from '../scripts/YourScript';

(async () => {
	await DefaultFunction(
		{},
		{
			availableMemory: 400,
			invocationId: 'INVOCATION_ID',
			triggerType: 'MANUAL',
			rootTriggerType: 'MANUAL',
			startTime: Date.now(),
			timeout: 900000,
			environment: {
				uid: 'ENVIRONMENT_UID',
				name: 'Default',
				vars: {},
			},
		},
	);
})().catch((e) => console.error(e));
```

Providing runtime mocks

Do not forget to import `runtimeMocks` file at the top of this file!

  

### Node types

Our predefined packages do not include types for the Node, but they will be transiently included through other packages. However, we recommend explicitly providing the types matching with your Node version. For example if your node version is `24.0.0`  which you can check by running `node -v`. You can install the types by running `npm install --save-dev @types/node@24.0.0`.

Mismatching version

Sometimes there might not be `@types/node` release for the exact Node version you're using. In this case install the next closest version.
