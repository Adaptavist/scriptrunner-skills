# Managed APIs

- Platform: connect
- Space: SRC
- Hierarchy: n/a
- Doc ID: doc-src-194675601
- Source: https://docs.adaptavist.com/src/latest/managed-apis

Managed API is an abstraction, an API Client, that we offer for the apps and services we support building integrations with. The primary purpose of Managed APIs is to increase developer experience by powering the [IntelliSense](https://code.visualstudio.com/docs/editor/intellisense) of our online editor, to reduce the need to work on the lower HTTP/REST level, and to reduce the need to rely heavily on third-party API documentation.

**What Managed APIs attempt to achieve**

-   Managed APIs try to be an abstraction to increase developer experience and productivity when working with third-party APIs. Developer experience is boosted by providing TypeScript type definitions for third-party APIs so our code editor could provide [IntelliSense](https://code.visualstudio.com/docs/editor/intellisense) assistance powered by these types.
    
-   Managed APIs try to offer built-in discoverability.
    
-   Managed APIs across the apps and services we support attempt to be as consistent as possible, but exceptions can be made where necessary.
    
-   Managed APIs also try to perform common error checks with a flexible interface to define your own error-handling logic.

**What Managed APIs try to avoid**

-   Managed APIs try to be relatively thin abstractions. Managed APIs try not to come up with a single unified API that abstracts away all inner workings of underlying APIs but aims to provide consistent access patterns and assistance for the data that needs to be sent (request) and for data that is coming back (response).
    
-   Managed APIs try not to pre-process requests or post-process responses for unification or consistency reasons, data that needs to be sent and data that is coming back is almost always a one-to-one match compared to original (service level) APIs. Additional abstractions might be provided for common use cases that are considered difficult to work with.

## Video walkthrough: How to set up a Managed API in ScriptRunner Connect
