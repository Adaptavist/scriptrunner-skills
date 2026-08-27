# Error Handling

- Platform: connect
- Space: SRC
- Hierarchy: managed-apis
- Doc ID: doc-src-194675679
- Source: https://docs.adaptavist.com/src/latest/managed-apis/error-handling

## Demo

## Reactive error handling

By default, if something goes wrong, the following errors will be thrown:

-   **UnexpectedError** - Thrown when something unexpected happens, which is usually unrecoverable. For example, a JSON parsing error in a place where JSON was expected, but the server sent back something else.
-   **HttpError** - Thrown when the response status code was not in the 200 range (OK). You can expect to read the original response from that error type. You can access the response from the response property. Following are sub-types of HttpError, which you can catch instead if you're interested in one of the more specific HTTP errors:
    -   **BadRequestError** - Thrown when the response was 400.
    -   **UnauthorizedError** - Thrown when the response was 401.
    -   **ForbiddenError** - Thrown when the response was 403.
    -   **NotFoundError** - Thrown when the response was 404.
    -   **TooManyRequestsError** - Thrown when the response was 429.
    -   **ServerError** - Thrown when the response was in the 500 range.

Sometimes additional errors may be thrown, as well.

For example, when working with Slack, a **SlackError** may be thrown because Slack mostly does not use HTTP status codes for validation (the exception being 429 for indicating rate limiting) but uses its own custom validation schema.

Here is an example of how to catch errors using an instance of keyword check to check the type of the error:

```
import { HttpError, UnexpectedError } from "@managed-api/commons-core";
import JiraCloud from "./api/jira/cloud";

export default async function (event: any, context: Context) {
	try {
		const issue = await JiraCloud.Issue.getIssue({
			issueIdOrKey: 'ISSUE-1'
		});

		// Do something with the issue
	} catch (e) {
		if (e instanceof UnexpectedError) {
			// Do something when unexpected error happens
		} else if (e instanceof HttpError) {
			// Log out the error in case it was HTTP error
			console.error(e);
		} else {
			// Anything else that may have thrown explicitly by the user
		}
	}
}
```

If you let the error propagate or print it out manually, you'll get a stack trace that you can use to trace the source of the error. Stack traces are printed from the inside out, meaning that your script function calls are usually on the bottom end.

Running the example above would print the following into the console:

![Alt text: ](/src/files/latest/194675679/194675676/1/1695218144000/Screenshot+2022-08-17+at+16.54.22.png)

We can see that the first three lines reference the internals of Managed API, where the error originated from, but if we look at the last line we can see that the function call that resulted in this error was kicked off by a script called _ManualTest_ at line 6 and column 16.

If you're interested in any specific HTTP errors, you can catch that error directly. With the example above, we could catch NotFoundError directly if we're only interested in the 404 error:

```
import { NotFoundError } from "@managed-api/commons-core";
import JiraCloud from "./api/jira/cloud";

export default async function (event: any, context: Context) {
	try {
		const issue = await JiraCloud.Issue.getIssue({
			issueIdOrKey: 'ISSUE-1'
		});

		// Do something with the issue
	} catch (e) {
		if (e instanceof NotFoundError) {
			// Log out the error in case it was HTTP error
			console.error(e);
		} else {
			// Anything else that may have thrown explicitly by the user
		}
	}
}
```

Some products may throw custom errors only relevant when working with these products that you can also catch. Here is an example of how to catch `SlackError` which is thrown if something goes wrong in Slack:

```
import Slack from './api/slack';
import { SlackError } from '@managed-api/slack-core/common';

export default async function(event: any, context: Context): Promise<void> {
	try {
		await Slack.Chat.postMessage({
			body: {
				channel: 'CHANNEL',
				text: 'TEXT'
			}
		})
	} catch (e) {
		if (e instanceof SlackError) {
			// Do something when Slack error occurs
		}
	}	
}
```

## Pre-emptive error handling

Sometimes it can feel cumbersome to deal with the error if it has already been thrown. To avoid that, the **errorStrategy** field can be used to provide an error-handling strategy. If used, it will prevent errors from being thrown if a matching error strategy is found; if not, the error will be thrown. Pre-emptive error handling can become handy in numerous situations. For example, if you receive an error informing you that the resource was not found (404), you may want to provide an error-handling strategy to return a default value instead. Or when your request is rate limited (429), you may simply want to retry the request without manually catching the error and calling the function again.

Error strategy exposes the number of callback functions that will be invoked if the implementation is specified. If the implementation is found, then the returned value from the callback will be returned from the main ManagedAPI function. These callback functions will provide the original response as the first parameter and the number of times the function has been (re)tried as the second parameter. 

You must always return something from the callback function, returning undefined is not allowed. However, you can return null if you want to indicate that nothing was returned.

The following functions can also be returned to indicate special behavior (importable from @managed-api/commons-core package):

-   **retry(delay: number)** - Tells the error handler to retry the request. Delay (optional) is measured in milliseconds and defaults to 0.
-   **continuePropagation(skipErrorStrategyPropagation?: boolean)** - Asks the error handler to continue propagating the error, if skipErrorStrategyPropagation (optional, defaults to false) parameter is set to true then the error handler propagation is skipped entirely and the actual error will be thrown immediately. Continue reading about error propagation.

By default, the following error handlers are available:  

-   **handleAnyError** - Handles any error
-   **handleUnexpectedError** - Handles unexpected error
-   **handleAnyHttpError** - Handles any HTTP error
-   **handleHttp400Error** - Handles Bad Request (400) HTTP error
-   **handleHttp401Error** - Handles Unauthorized (401) HTTP error
-   **handleHttp403Error** - Handles Forbidden (403) HTTP error
-   **handleHttp404Error** - Handles Not Found (404) HTTP error
-   **handleHttp429Error** - Handles Too Many Requests (you are being rate limited) (429) error
-   **handleHttp5xxError** - Handles 500 range HTTP errors

Error handlers are hierarchical, meaning that if a more concrete error handler exists it will be invoked, but if a more concrete one is not found, then a less concrete one will be looked for and invoked if found. For example, if a server rate limits the request and sends back 429 response then the order of error handlers that will be looked for will be as follows: handleHttp429Error, handleHttpAnyError, handleAnyError. The first one found will be invoked, but if none are found, then TooManyRequestError (a sub-type of HttpError) will be thrown.

Here is an example of how the error strategy is being used to return a default value of null when 404 is returned:

```
import JiraCloud from './api/jira/cloud';

export default async function(event: any, context: Context) {
    // Optional generic type can be used on the function level to indicate additional possible return types, 
    // in our case we're specifying null because when 404 happens then null is returned instead
    const issue = await JiraCloud.Issue.getIssue<null>({ 
        issueIdOrKey: 'ISSUE-1',
        errorStrategy: {
            handleHttp404Error: () => null // In case of 404 return null instead
        }
    });

    if (issue) {
        // Do something if issue exists
    } else {
        // Do something if issue does not exist (404)
    }
}
```

Specifying additional non-default return types that you are expecting to be returned from the error strategy is a good practice.

For example, if we don't specify the possible return type of null, the editor won't be able to provide the correct type inference for us. It only knows what is expected in case of a default behavior:  
![Code snippet for an asynchronous function in JavaScript that imports JiraCloud. It handles an issue retrieval with a strategy for 404 errors.](/src/files/latest/194675679/194675677/1/1695218144000/Screenshot+2022-08-10+at+15.29.07.png)

However, if we did specify the additional generic type to indicate that we're possibly expecting more than the default behavior, in case of our example, possibly returning null as well, the editor can make use of this information and assist us when it comes to working with the response type:

![Code snippet showing a JavaScript function to handle Jira API calls. Includes comments and conditional logic for handling HTTP 404 errors gracefully.](/src/files/latest/194675679/194675678/1/1695218144000/Screenshot+2022-11-11+at+14.36.04.png)

Appending API call return types with `null` or `undefined` by using function generic types only gets inferred if the workspace scripting mode is turned into TypeScript Strict mode. In other modes, TypeScript is not forcing users to perform potential `null` or `undefined` checks and hence is ignoring these possible types.

For safety reasons, it is recommended to use TypeScript Strict mode.

Some Managed APIs may expose additional error handler functions if it is appropriate for the service. For example, Slack's Managed API exposes handleSlackError handler that exclusively deals with Slack-specific errors which are not making use of regular HTTP error codes.

Here's an example of how to make use of Slack's specific error handler:

```
import Slack from "./api/slack";

export default async function(event: any, context: Context) {
    // Although we're not making any use of the response, then still specifying possible non-default return types is a good practice
    await Slack.Chat.postMessage<null>({
        body: {
            channel: 'INVALID_CHANNEL',
        },
        errorStrategy: {
            handleSlackError: (error) => {
                console.error(`Slack error: ${error.message}`);
                return null;
            }
        }
    });
}
```

If you were to run this script, and given that the channel did not exist, we would be getting "Slack error: channel\_not\_found" printed out to console, because the channel didn't exist, Managed API was throwing SlackError which we then pre-emptively handled with the error strategy.

In the next example, we can see how to use retry and continuePropagation functions to implement re-try logic when the request is rate-limited (429). The logic will retry up to three times, initially wait for one second before retrying, and increase the delay by two seconds for each subsequent retry:

```
import { continuePropagation, retry } from '@managed-api/commons-core';
import JiraCloud from './api/jira/cloud';

export default async function(event: any, context: Context) {
    const issue = await JiraCloud.Issue.getIssue({ 
        issueIdOrKey: 'ISSUE-1',
        errorStrategy: {
            handleHttp429Error: (error, attempt) => attempt < 3 ? retry(1000 + ((attempt - 1) * 2000)) : continuePropagation() // Retry logic
        }
    });
    
    // Do something with the issue
}
```

Obviously writing out re-try logic like that is exhaustive so you can just use getRetryErrorHandler(total = 5, delay = 0, delayIncrease = 1000) convenience function that encapsulates the same logic as follows:

```
import { getRetryErrorHandler } from '@managed-api/commons-core';
import JiraCloud from './api/jira/cloud';

export default async function(event: any, context: Context) {
    const issue = await JiraCloud.Issue.getIssue({ 
        issueIdOrKey: 'ISSUE-1',
        errorStrategy: {
            handleHttp429Error: getRetryErrorHandler(3, 1000, 2000) // Same retry logic as above
        }
    });

    // Do something with issue
}
```

Error strategy also allows you to use a builder for building the error strategy that comes with some convenience functions. For example, retry logic could be specified as following as well (including the case for 404):

```
import JiraCloud from './api/jira/cloud';

export default async function(event: any, context: Context) {
    const issue = await JiraCloud.Issue.getIssue<string>({
        issueIdOrKey: 'ISSUE-1',
        errorStrategy: builder => builder
            .http404Error(() => 'Hello World') // Return default value when Issue is not found (404)
            .retryOnRateLimiting(20) // Retry up to 20 times when request is being rate limited
    });

    // Do something with the issue
}
```

If for some reason you would like to construct the error strategy prior to calling the function and also use the builder to do so you can achieve it as following:

```
import { ErrorStrategyBuilder } from "@managed-api/slack-core/builders/errorStrategy";
import JiraCloud from './api/jira/cloud';

export default async function(event: any, context: Context) {
    const errorStrategy = new ErrorStrategyBuilder()
        .http404Error(() => null)
        .retryOnRateLimiting(20)
        .build();

    const issue = await JiraCloud.Issue.getIssue({
        issueIdOrKey: 'ISSUE-1',
        errorStrategy
    });

    if (issue) {
        // Do something if issue exists
    } else {
        // Do something if issue does not exist (404)
    }
}
```

### Global Settings

To avoid having to specify common error strategy logic on each function call individually, you can leverage a global error strategy where you can specify common behavior on the Managed API instance level, where all functions that are invoked via the same instance will inherit the error strategy you specified on the global level. For example, it is useful to specify global behavior for handling re-trying logic when API requests are being rate-limited.

For example:

```
import { getRetryErrorHandler } from "@managed-api/commons-core";
import JiraCloud from './api/jira/cloud';

export default async function(event: any, context: Context) {
    JiraCloud.setGlobalErrorStrategy({
        handleHttp429Error: getRetryErrorHandler(20)
    });

    const issue = await JiraCloud.Issue.getIssue({
        issueIdOrKey: 'ISSUE-1'
    });

    // Do something with the issue
}
```

Or if you would like to use a builder pattern:

```
import JiraCloud from './api/jira/cloud';

export default async function(event: any, context: Context) {
    JiraCloud.setGlobalErrorStrategy(builder => builder.retryOnRateLimiting(20));

    const issue = await JiraCloud.Issue.getIssue({
        issueIdOrKey: 'ISSUE-1'
    });

    // Do something with the issue
}
```

Or, if you would like to use the error strategy builder manually and construct the error strategy object prior to setting it:

```
import { ErrorStrategyBuilder } from '@managed-api/jira-cloud-v3-core/builders/errorStrategy';
import JiraCloud from './api/jira/cloud';

export default async function(event: any, context: Context) {
    const errorStrategy = new ErrorStrategyBuilder()
        .retryOnRateLimiting(20)
        .build();

    JiraCloud.setGlobalErrorStrategy(errorStrategy);

    const issue = await JiraCloud.Issue.getIssue({
        issueIdOrKey: 'ISSUE-1'
    });

    // Do something with the issue
}
```

You also have the option to overwrite specific error strategy behavior on the function level. However it will only overwrite a specific error handler callback function but will still inherit other behaviors from the global level. For example, if you have a global behavior specified to re-try on HTTP 429 and then you specify local (function level) behavior to return something else when HTTP 404 is returned, then re-try logic is still applied from the global level.

By default, Managed APIs come with sensible default options for re-trying requests so you don't have to specify that logic explicitly, but you can optionally disable any default behaviors by specifying global error strategy as either null or undefined. Also, when specifying your global error strategy, you will be overwriting default behavior, so keep in mind to provide re-try logic explicitly if needed.

For example, you can disable the default global settings as follows:

```
import JiraCloud from './api/jira/cloud';

export default async function(event: any, context: Context) {
    JiraCloud.setGlobalErrorStrategy(null);

    const issue = await JiraCloud.Issue.getIssue({
        issueIdOrKey: 'ISSUE-1'
    });

    // Do something with the issue
}
```
