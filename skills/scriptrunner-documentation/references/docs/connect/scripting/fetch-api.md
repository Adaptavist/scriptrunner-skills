# Fetch API

- Platform: connect
- Space: SRC
- Hierarchy: scripting
- Doc ID: doc-src-223118008
- Source: https://docs.adaptavist.com/src/latest/scripting/fetch-api

ScriptRunner Connect offers [Fetch API](https://developer.mozilla.org/en-US/docs/Web/API/Fetch_API) as the lowest level API for making API calls over HTTP. While we recommend using [Managed APIs](https://docs.adaptavist.com/src/latest/managed-apis) if available, Fetch API is a valid alternative if you cannot use Managed APIs for whatever reason. Managed APIs also offer [Managed Fetch API](https://docs.adaptavist.com/src/latest/managed-apis/managed-api-abstractions#managed-fetch-api), which can be combined with the [generic connector](https://docs.adaptavist.com/src/latest/connectors/generic-connector) to great effect.

**Compliance**  
ScriptRunner Connect's Fetch API implementation is not fully compliant with the specification because the Fetch API was originally designed to work in a browser and not in server-side JavaScript runtime, which is where ScriptRunner Connect code is executed.

# Demo

# Fetch options

```
{
	method?: string; // Method for the Fetch call
	headers?: Headers | Record<string, string>; // Headers to be passed along
	body?: Blob | ArrayBuffer | FormData | string | null; // Body to be passed along
	agent?: {
		rejectUnauthorized?: boolean; // Whether to reject invalid HTTPS connection, defaults to true
		ca?: string | ArrayBuffer | (string | ArrayBuffer)[]; // CA certificate to be used with HTTPS connection (must be in PEM format)
		cert: string | ArrayBuffer | (string | ArrayBuffer)[]; // Certificate to be used with HTTPS connection (must be in PEM format)
		key? string | ArrayBuffer | (string | ArrayBuffer)[]; // Private key to be used with HTTPS connection (must be in PEM format)
		passphrase?: string; // Use to decrypt certificates, if certificates are not encrypted, don't specify it
	}
}
```

# Web API-supported classes

The following classes may not be fully compliant per specification. [Contact our team](https://docs.adaptavist.com/src/latest/get-help) if you notice an error or would like to submit a feature request.

-   [Request](https://developer.mozilla.org/en-US/docs/Web/API/Request)
-   [Response](https://developer.mozilla.org/en-US/docs/Web/API/Response)
-   [Headers](https://developer.mozilla.org/en-US/docs/Web/API/Headers)
-   [Blob](https://developer.mozilla.org/en-US/docs/Web/API/Blob)
-   [FormData](https://developer.mozilla.org/en-US/docs/Web/API/FormData)
-   [URL](https://developer.mozilla.org/en-US/docs/Web/API/URL)
-   [URLSearchParams](https://developer.mozilla.org/en-US/docs/Web/API/URLSearchParams)
-   [TextEncoder](https://developer.mozilla.org/en-US/docs/Web/API/TextEncoder)
-   [TextDecoder](https://developer.mozilla.org/en-US/docs/Web/API/TextDecoder)

# Custom headers

ScriptRunner Connect exposes many custom headers with the `x-stitch`  prefix.

## Request headers

-   `**x-stitch-connection-id**`  
    Used internally by Managed APIs to pass along the API connection used with the Managed API call. This value is the UID of the API connection.
-   `**x-stitch-ignore-ssl-check**`  
    Disables check for invalid HTTPS connection and does the same thing as `rejectUnauthorized` when passed along with the `agent` option.

## Response headers

-   **x-stitch-time**  
    Time in milliseconds it took to perform the actual HTTP call, which is more accurate than measuring how long it took to perform the HTTP call from the code.

# Mutual TLS

You can perform [mutual TLS](https://www.cloudflare.com/en-gb/learning/access-management/what-is-mutual-tls/) by passing `ca` , `` cert, `key` `` and ``` `` `passphrase` `` ``` options with the agent option in the fetch call.

**An example  👀**  
[Click here](https://docs.adaptavist.com/src/latest/scripting/code-snippets/perform-mutual-tls) for an example of how to perform mTLS with Fetch API.
