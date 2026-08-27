# Working with Fetch API

- Platform: connect
- Space: SRC
- Hierarchy: scripting > code-snippets
- Doc ID: doc-src-194676609
- Source: https://docs.adaptavist.com/src/latest/scripting/code-snippets/working-with-fetch-api

[Fetch API](https://developer.mozilla.org/en-US/docs/Web/API/Fetch_API) is used to make HTTP requests. It is based on an [open standard](https://fetch.spec.whatwg.org/) that all modern browsers support, including most server-side and cloud-based JavaScript runtimes, including [ScriptRunner Connect runtime](https://docs.adaptavist.com/src/latest/scripting/runtime).

At this time, ScriptRunner Connect's Fetch API is not 100% standard-compliant. We are missing some features that cannot be supported outside of browser-based environments. However, ScriptRunner Connect supports everything you will probably ever need. ScriptRunner Connect aims to align its Fetch API implementation to match the [standard](https://wintercg.org/) [being developed](https://wintercg.org/) for server-side JavaScript runtimes.

ScriptRunner Connect supports two versions of Fetch API:

-   [Raw Fetch API](https://docs.adaptavist.com/src/managed-apis/managed-api-abstractions#fetch-api), which is more closely aligned with the standard
-   [Managed Fetch API](https://docs.adaptavist.com/src/managed-apis/managed-api-abstractions#managed-fetch-api), which integrates with [ScriptRunner Connect connectors](https://docs.adaptavist.com/src/latest/connectors)

We recommend using Managed Fetch API in conjunction with connectors for increased security, which removes the need to hardcode authentication credentials directly in the code and only to use raw Fetch API level when you can't work with the managed version.

# Making a Raw Fetch Request

To make a fetch request, call the `fetch` function and pass in the URL.

For this example, we're using [https://jsonplaceholder.typicode.com/](https://jsonplaceholder.typicode.com/) anonymous service, which means we can use the raw Fetch API directly.

```
export default async function(event: any, context: Context): Promise<void> {
	const response = await fetch('https://jsonplaceholder.typicode.com/posts');
}
```

You can also pass in the options which accept the `method` , `headers` , and `body`.

Here is an example of how to make a `POST`  request with JSON body:

```
export default async function(event: any, context: Context): Promise<void> {
	const response = await fetch('https://jsonplaceholder.typicode.com/posts', {
		method: 'POST',
		headers: {
			'Content-Type': 'application/json'
		},
		body: JSON.stringify({
			userId: 1,
			id: 1,
			title: 'Test',
			body: 'Hello World'
		})
	});
}
```

# Making a Managed Fetch Request

If you need to work with services that require authentication and you're working with fixed authentication tokens, we encourage you to use the [generic connector](https://docs.adaptavist.com/src/latest/connectors/generic-connector). OAuth-based authentication flows cannot be used with the generic connector because tokens must be rotated and cannot remain static. In this case, OAuth flow needs to be implemented manually using raw Fetch API, whereas [Record Storage](https://docs.adaptavist.com/src/latest/scripting/record-storage) could be used to store sensitive information without needing to hardcode that information directly into the code.

For this example, [jsonplaceholder.typicode.com](http://jsonplaceholder.typicode.com) is still used but through a generic connector. Although this service does not need authentication, the same principles still apply.

The main difference between the raw and managed Fetch API is that you must use a relative URL path with the managed version since the base URL was configured with the generic connector, which will be substituted. The fetch call will include headers that were added with the generic connector.

To use the managed Fetch API:

1.  Configure the generic connector.
2.  Configure the [API connection](https://docs.adaptavist.com/src/latest/workspaces/api-connections) in your workspace.
3.  Import the API connection that targets the generic connector into your code.
4.  From the imported namespace, you can access the `fetch`  function.

Given the path for the API connection that targets the generic connector is `/api/json` , the example above, if using managed Fetch API, would look something like this:

```
// Imports API Connection with path of '/api/json' under the namespace of 'JsonPlaceholder'
import JsonPlaceholder from './api/json';

export default async function(event: any, context: Context): Promise<void> {
	// Calls managed Fetch API from JsonPlaceholder namespace
	const response = await JsonPlaceholder.fetch('/posts', {
		method: 'POST',
		headers: {
			'Content-Type': 'application/json'
		},
		body: JSON.stringify({
			userId: 1,
			id: 1,
			title: 'Test',
			body: 'Hello World'
		})
	});
}
```

# Handling Responses

Every time you make a `fetch` call, you're going to receive a response. A response tells you what happened with the request. And if it did succeed, then you can also extract the body from it, if the body is present.

The following response properties are perhaps the most noteworthy: 

-   `status`  - Represent response status code in numerical form.
-   `statusText` - Represents response status code in human-readable form.
-   `ok` - Represents if the response is OK or not; under the hood, it checks if the response is in the 200 range.
-   `arrayBuffer()` - Function that returns the body as `ArrayBuffer` (raw bytes). Use this when you need to work with binary data directly.
-   `text()` - Function that returns the body as `string`  (text). Use this when you're expecting to work with human-readable data.
-   `json()` - Function that returns the body as a JSON parsed JavaScript object. Use this when you're expecting a JSON object to be returned.

Response handling works the same regardless of whether you're using the raw or the managed Fetch API version. But at this time, the raw Fetch API returns more properties in the response than the managed version, thus making it more closely aligned with the open standard. However, the above properties exist and work the same for both versions.

# An Example

Here is a typical example of making a Fetch API call, checking if the response is OK, and then extracting the body as a JSON object:

```
export default async function(event: any, context: Context): Promise<void> {
	// Fetch posts
	const response = await fetch('https://jsonplaceholder.typicode.com/posts');

	// Check if the response is OK
	if (!response.ok) {
		// If it's not, then throw an error
		throw Error(`Unexpected response code: ${response.status} - ${await response.text()}`);
	}

	// If it's OK, then proceed by getting the JSON object from the body that represents the posts
	const posts = await response.json();

	// And finally print out the posts
	console.log('Posts', posts);
}
```

**Helpful templates** 💡

-   [Use ChatGPT in Slack with a simple slash command](https://templates.scriptrunnerconnect.com/template/01H3BX73PVA1PJPN079C5ZS6XN)  
    This template uses the managed Fetch API call to communicate with ChatGPT.
-   [Ada - OpenAI and ScriptRunner Connect powered Apple shortcut](https://templates.scriptrunnerconnect.com/template/01HKYWCES5DK1Y253K8R31JJWN)  
    This template uses the managed Fetch API call to communicate with ChatGPT.
-   [Send back an image with the Generic HTTP Event](https://templates.scriptrunnerconnect.com/template/01GAV5V540K4E3BMYK87H98G74)  
    This template uses raw Fetch API to fetch a random kitten image.
-   [Manual OAuth 2.0 for Zendesk](https://templates.scriptrunnerconnect.com/template/01HG8FA1N66Q0EJZM4AANB4P04)  
    This template uses Fetch API to establish an OAuth 2.0 connection with Zendesk.

**Helpful code snippets 💡**

-   [Working with attachments](https://docs.adaptavist.com/src/latest/scripting/code-snippets/working-with-attachments)  
    This page contains examples of more advanced use cases of the Fetch API, such as uploading binary data as attachments.
