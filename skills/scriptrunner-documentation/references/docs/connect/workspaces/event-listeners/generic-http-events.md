# Generic HTTP Events

- Platform: connect
- Space: SRC
- Hierarchy: workspaces > event-listeners
- Doc ID: doc-src-194675305
- Source: https://docs.adaptavist.com/src/latest/workspaces/event-listeners/generic-http-events

Generic HTTP events allow you to listen to events from services/apps that ScriptRunner Connect officially does not support. Since you can also send back an HTTP response with these events, you can use it for other purposes, such as building your own API endpoints, or building UIs by sending back HTML.

To get started, create a new event listener and select a generic app from the list. You will then be taken to a new screen where you have to insert the following information:

-   **Event Type  
    **You'll get to select between async and sync event types. The main difference between the two is that an async event is processed in a fire-and-forget manner, without you being able to send back an HTTP response. Your script gets invoked when this event gets triggered, but a default HTTP response will be sent back immediately, even while your script is still running. **This should be the preferred option in all cases where you don't need to respond with a specific message**, which should be suitable for most webhooks. Alternatively, you can process your events synchronously, meaning that you can construct and return your custom HTTP response. **A major limitation of this approach is that your script must complete processing the event within 25 seconds.** If you exceed this limitation, your script will time out, and a status code 408 (request timeout) will be returned. Asynchronous events do not share this limitation; they are bound by a regular function timeout limit, which **by default is 15 minutes**. You can use this option when you need to respond with anything specific, such as when building your own APIs or UIs.
-   **Linked Script**  
    The same logic applies to regular [event listeners](https://docs.adaptavist.com/src/latest/workspaces/event-listeners).
-   **URL Path**  
    URL path is a globally unique identifier that makes up your URL. By default, a random path identifier is generated. We recommend using the random identifier. If you do change it to something more predictable, be aware that other people can attempt to guess it, and you may want to implement additional authentication to prevent anonymous access. You can no longer take a URL if someone has already reserved a URL path**.**

In a synchronous event, status code 299 will be returned if the invocation is aborted.

## Scripting

### Incoming request

An event, which will be the HTTP request, will contain the following fields:

```
{
  body?: any; // Request body, in case the request contains JSON content, the body is already parsed JSON object. In case it is text content then the body is string. In case it is binary then it is also string but base64 encoded. If the body is empty then this property is undefined.
  bodyType?: 'base64' | 'text' | 'json'; // Determines in which shape the body is in. If the body is empty then this property is also undefined.
  headers: Record<string, string>; // Headers that were sent with the request.
  method: string; // HTTP request method.
  path: string; // URL path that was used.
  queryString: // Raw query string
  queryStringParams: Record<string, string>; // Parsed record of query string params, if there were any.
  sourceIp: string; // IP of the user/system that triggered the event. Can be used to implement IP allowlist.
}
```

### Body type mapping

The following logic is used to determine the body and bodyType:

-   If the content type is application/json then bodyType is json and body is parsed JSON object, no need to do another JSON.parse on it.
    
-   If the content type is either text/plain, text/html, text/xml, application/xhtml+xml or application/x-www-form-urlencoded then the bodyType is text and the body is string.
    
-   For anything else the bodyType is base64 and the body is base64 encoded string, in which case you have to convert base64 to your desired format if needed. You can use the [@sr-connect/convert](https://www.npmjs.com/package/@sr-connect/convert) utility library to perform various conversions.
    

You should explicitly check for body type and not assume the same logic always determines it, as the mapping logic may be improved over time.

### Outgoing request

When you're using synchronous event processing, you must send back a response, which must be in the following shape:

```
{
	status: number; // Status code of the response.
	body?: string; // Body in plain text of base64 encoded string for sending back binary data.
    headers?: Record<string, string>; // Response headers.
    isBase64?: boolean; // Indicates whether the body is base64 encoded.
}
```

Failing to send back a response in the expected format, which at a minimum needs to include the status code, will result in a 422 (Unprocessable Content) status being sent back instead.

### Convenience functions

You can import the following convenience functions for working with HTTP events from `@sr-connect/generic-app/events/http` :

-   isBase64 – Checks if the request body is base64 encoded
-   isJSON - Checks if the request body is already parsed JSON object
-   isText - Checks if the request is plain text
-   buildPlainTextResponse - For constructing plain text response
-   buildJSONResponse - For constructing JSON response
-   buildHTMLResponse - For constructing HTML response

An example of how to detect the incoming HTTP request body type:

```
import { convertBase64ToText } from '@sr-connect/convert';
import { HttpEventRequest, isBase64, isJSON, isText } from '@sr-connect/generic-app/events/http';

export default async function (event: HttpEventRequest, context: Context): Promise<void> {
	if (isBase64(event)) { // Check if body is base64 encoded
        // Convert base64 to text
        const body = convertBase64ToText(event.body);
    } else if (isText(event)) { // Check if body is string
        // Body is already string, no need for explicit conversion
        const body = event.body;
    } else if (isJSON<MyType>(event)) { // Check if body is already parsed JSON object and optionally specify the type you wish it to be in
        // Body is already object that in a shape of MyType, no need for explicit conversion
        const body = event.body;
    } else {
        // If body was not sent
    }
}

// Shape of my JSON object type
interface MyType {
    prop1: string;
    prop2: number;
    prop3: boolean;
}
```

For more examples, check out templates in ScriptRunner Connect that use the generic app.
