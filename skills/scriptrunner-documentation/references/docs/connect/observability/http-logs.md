# HTTP Logs

- Platform: connect
- Space: SRC
- Hierarchy: observability
- Doc ID: doc-src-194676679
- Source: https://docs.adaptavist.com/src/latest/observability/http-logs

HTTP logs allow you to peek under the hood to troubleshoot when you need to debug and investigate certain API call failures. Whenever a script finishes executing, a corresponding log message appears in the console log with a link to download the logs for all HTTP calls made during the script invocation. Alternatively you can also browse the HTTP logs from the [Script Invocation Logs](https://docs.adaptavist.com/src/latest/observability/script-invocation-logs).

**Log retention  🪵**

HTTP logs are kept for six months and then deleted from ScriptRunner Connect.

## HTTP log structure

```
{
	fetchId: number; // We count each HTTP call you're making, starting from 0 and increment each time.
	connectionId?: string; // API connection ID that was used, empty if raw Fetch API was used.
	originalDuration: number; // Time in milliseconds how long it took to get a response.
	duration: number; // Time in milliseconds how long it took to process the entire HTTP call (overhead).
	request: {
		url: string; // URL of the request, relative URL in case when Managed API or Managed Fetch call was used.
		method: string; // HTTP method.
		headers: Record<string, string>; // HTTP headers.
		responseBody: 'fetch' | 'skip'; // Flag that indicates whether the response body was asked to be fetched.
		time: string; // Timestamp when request was initiated in ISO time.
		body?: {
			size: number; // Size of the body in bytes.
			truncated: boolean; // Whether the body is truncated in the log, anything larger than 1KB gets truncated.
			text: string; // Body content in string format (might be truncated).
		}
	},
	response: {
		status: number; // Response status code.
		time: // Timestamp when response arrived in ISO time.
		headers: Record<string, string>; // Response headers.
		body: {
			size: number; // Size of the body in bytes.
			truncated: boolean; // Whether the body is truncated in the log, anything larger than 1KB gets truncated.
			text: string; // Body content in string format (might be truncated).
		}
	}
}
```

## Additional system headers

To make troubleshooting easier, ScriptRunner Connect adds the following additional system headers to the response:

-   **x-stitch-fetch-id** - Fetch ID, which is also exposed in the **fetchId** field at the top level.
-   **x-stitch-fetch-time** - Time, in milliseconds, it took to get a response; this info is also exposed in the duration field at the top level.
-   **x-stitch-proxied-url** - Final URL that the request was sent to, which only appears following successful API calls. If issues with the API connection exist, this header does not appear.
-   **x-stitch-rate-limit -** This header is set to `true`  if your external API call was rate limited by ScriptRunner Connect rather than by the destination you were trying to call.
