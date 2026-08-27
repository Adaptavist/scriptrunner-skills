# Advanced Managed API Concepts

- Platform: connect
- Space: SRC
- Hierarchy: managed-apis
- Doc ID: doc-src-194676098
- Source: https://docs.adaptavist.com/src/latest/managed-apis/advanced-managed-api-concepts

This page details advanced Managed API concepts. 

## Manually construct Managed APIs

If you need to construct the Managed API manually, you can do it as follows:

```
import { JiraCloudApi } from '@managed-api/jira-cloud-v3-sr-connect';

export default async function(event: any, context: Context) {
    const JiraCloud = new JiraCloudApi('API_CONNECTION_ID');

    const issue = await JiraCloud.Issue.getIssue({
        issueIdOrKey: 'ISSUE-1'
    });

    // Do something with the issue
}
```

You'll be required to pass in the API connection ID in the constructor. You can retrieve the ID by navigating to the API connection and extracting the last ID from the URL, which represents the ID for the API connection.

Alternatively, you can pull the `connectionId` from an existing API connection and pass it along. Here's an example that uses the generic connector:

```
import { JiraCloudApi } from '@managed-api/jira-cloud-v3-sr-connect';
import Generic from './api/generic';

export default async function(event: any, context: Context): Promise<void> {
	const JiraCloud = new JiraCloudApi(Generic.connectionId);

	const issue = await JiraCloud.Issue.getIssue({
        issueIdOrKey: 'ISSUE-1'
    });

    // Do something with the issue
}
```

  

Naming convention

The naming convention for Managed API packages is **@managed-api/${PRODUCT\_ID}-${PLATFORM}.** core in the platform name indicates the platform/runtime agnostic version.

## Port ScriptRunner Connect code onto other platforms/runtimes

Writing code in the ScriptRunner Connect platform does not fully lock you in. Although you're using a ScriptRunner Connect-specific version of our Managed APIs, the Managed APIs are designed to be platform/runtime agnostic, which means you can still easily take the code written in ScriptRunner Connect (when considering code that is using Managed APIs) and port it to some other platform/runtime of your choosing. You would need to create your own platform/runtime-specific version of the Managed APIs in the platform/runtime you wish to migrate your code to, if it has not already been created by someone else.

Work smarter  🧠

If you port your ScriptRunner Connect code elsewhere, you'll have to manage authentication and security yourself instead of having ScriptRunner Connect manage those responsibilities for you.

Here's an example of how to create a [Node](https://nodejs.org/)\-specific version of the Managed API if you ever need to move your code into the Node runtime:

```
import { JiraCloudApiCore, Request, Response, Headers } from "@managed-api/jira-cloud-v3-core";
import { PlatformImplementation } from "@managed-api/commons-core";
import fetch from "node-fetch";

export class JiraCloudApi extends JiraCloudApiCore {
    constructor(private baseUrl: string, private authToken: string) {
        super();
    }

    protected getPlatformImplementation(): PlatformImplementation {
        return {
            buffer: {
                encode: (input) => Buffer.from(input, 'utf-8'),
                decode: (input) => Buffer.from(input).toString('utf-8')
            },
            performHttpCall: (request) => this.performHttpCall(request)
        };
    }

    private async performHttpCall(request: Request): Promise<Response> {
        const requestUrl = `${this.baseUrl}${request.url}`; // Substitute base URL
        request.headers.set('Authorization', `Basic ${this.authToken}`); // Substitute auth token
        const response = await fetch(requestUrl, {
            method: request.method,
            headers: request.headers as any,
            body: request.method.toLowerCase() !== 'get' ? Buffer.from((await request.arrayBuffer()) ?? new ArrayBuffer(0)) : undefined
        });

        const apiHeaders = new Headers();
        response.headers.forEach((value, key) => apiHeaders.append(key, value));

        const body = await response.arrayBuffer();

        return super.buildResponse(response.url, response.status, response.statusText, apiHeaders, body);
    }
}
```

Compatibility with newer Node versions

If you're using a newer Node version, you may notice a compilation error around the line that deals with encoding using the Buffer class on line 13. To resolve the issue, you can try extracting the underlying buffer by changing the extraction logic to the following: `Buffer.from(input, 'utf-8').buffer` .

You can then construct the same Managed API from the Jira Cloud API as shown in the example before this one. However, in this case, since we're no longer managing and securing authentication details for you, you would have to pass in the base URL for your instance and the authentication token that will be used to authenticate your requests. Securing the authentication token will now be your concern.
