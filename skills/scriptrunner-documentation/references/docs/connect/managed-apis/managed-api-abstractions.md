# Managed API Abstractions

- Platform: connect
- Space: SRC
- Hierarchy: managed-apis
- Doc ID: doc-src-194675629
- Source: https://docs.adaptavist.com/src/latest/managed-apis/managed-api-abstractions

When it comes to connecting to third-party services, two prerequisites must be fulfilled:

-   ScriptRunner Connect must be able to establish a connection. Since ScriptRunner Connect is a SaaS product, the service must be accessible online. If the service is behind a firewall, we have static IP (**34.251.34.27**) assigned to all outgoing (egress) requests, which then can be configured on the firewall level to let the ScriptRunner Connect connections go through.
-   Services must offer HTTP-based APIs for ScriptRunner Connect to be able to talk to. Here is an example of how the error strategy is being used to return a def

## Demo

## Fetch API

On the lowest level, we have [Fetch API](https://developer.mozilla.org/en-US/docs/Web/API/Fetch_API), a general-purpose HTTP Client that can be used to talk to any service as long as the two prerequisites are fulfilled.

Here is an example of how to make an API call to Jira Cloud to fetch a work item and print out the reporter's display name:

```
export default async function(event: any, context: Context) {
	const user = 'me@example.com';
	const apiToken = 'API_TOKEN';
	const instance = 'instance';
	const issueKey = 'ISSUE-1';

	// Fetch the issue
	const response = await fetch(`https://${instance}.atlassian.net/rest/api/3/issue/${issueKey}`, {
		headers: {
			'Authorization': `Basic ${btoa(`${user}:${apiToken}`)}`
		}
	});

	// Check if the response is OK (within 200 range)
    if (!response.ok) {
        // If not then throw an error
        throw Error(`Unexpected response: ${response.status}`); 
    }

    // If it is OK, then read the body as JSON
    const issue = await response.json();

	// And then print out the reporter's display name
    console.log(issue.fields.reporter.displayName);
}
```

## Managed Fetch API

In the previous example, we made a raw HTTP request to Jira Cloud to fetch the work item we were interested in. However, this is insecure since we hardcoded our credentials directly into the code. If the connector exists for the service you need to talk to, you should always use it. In the following example, we'll also be using a Fetch API, but this time we'll be using it via the connector, so we wouldn't have to hardcode our credentials into the code and wouldn't need to specify the base URL, nor can we, and must use a relative URL since the connector will be substituting this information for us.

```
// Import Jira Cloud API Connection
import JiraCloud from './api/jira/cloud';

export default async function(event: any, context: Context) {
	const issueKey = 'ISSUE-1';

	// Fetch the issue
	const response = await JiraCloud.fetch(`/rest/api/3/issue/${issueKey}`);

	// Check if the response is OK (within 200 range)
    if (!response.ok) {
        // If not then throw an error
        throw Error(`Unexpected response: ${response.status}`); 
    }

    // If it is OK, then read the body as JSON
    const issue = await response.json();

	// And then print out the reporter's display name
    console.log(issue.fields.reporter.displayName);
}
```

## Managed API

However, if the function exists at the Managed API level, we can achieve the same result much more easily without having to construct the URL, check if the response is correct, and parse it into JSON manually. Doing the same thing as above can be achieved with Managed API as follows:

```
// Import Jira Cloud API Connection
import JiraCloud from './api/jira/cloud';

export default async function(event: any, context: Context) {
    // Fetch the issue
	const issue = await JiraCloud.Issue.getIssue({
        issueIdOrKey: 'ISSUE-1'
    });

	// And then print out the reporter's display name
    console.log(issue.fields.reporter.displayName);
}
```

While this was more straightforward, we were still assisted by IntelliSense when we were accessing this API. When we navigated into the Issue (Work item) group, we were shown all the functions and sub-groups that exist on the Issue level:  
![Code editor showing JavaScript for fetching a Jira issue using JiraCloud API. The autocomplete dropdown lists methods, with ](/src/files/latest/194675629/194675624/1/1695217232000/Screenshot+2022-08-09+at+16.52.19.png)

When we started calling the function, we were reminded that we were missing an argument:  
![](/src/files/latest/194675629/194675625/1/1695217232000/Screenshot+2022-08-09+at+16.54.46.png)

When we specified the required options argument, we were reminded that we were missing required fields:  
![Code snippet showing a function to fetch a Jira Cloud issue with a TypeScript error highlighted. The error message suggests a missing argument.](/src/files/latest/194675629/194675626/1/1695217232000/Screenshot+2022-08-09+at+16.55.53.png)

**View error messages  👀**

Hover over a red squiggly line to reveal the error message.

When we asked for suggestions for what we could specify, we were shown what's possible:  
![JavaScript code snippet showing Jira Cloud API integration. A dropdown suggests properties like ](/src/files/latest/194675629/194675627/1/1695217232000/Screenshot+2022-08-09+at+17.01.56.png)

**View all suggestions  👀**

Press **CTRL+SPACE** in the editor to toggle additional suggestions. Not all suggestions appear by default.

And when we were accessing the work item that we received, we were told what was inside:

![Code editor showing JavaScript for Jira Cloud API connection. A list of reporter field options is displayed, including accountId and displayName.](/src/files/latest/194675629/194675628/1/1695217232000/Screenshot+2022-08-09+at+16.58.58.png)

You can expect the same consistent behavior for all the functions we support in our Managed APIs.

## When to use specific abstraction layers

As a rule of thumb, always start at the highest level and use Managed APIs whenever possible. Drop down to the Managed Fetch API level when the function you're looking for does not exist in the Managed API or if, for whatever reason, you cannot work with the Managed API function. Drop down to the Fetch API level when no connector is available for the service you want to work with.

**Generic connectors FTW 🏆**

Consider using a [generic connector](https://docs.adaptavist.com/src/latest/connectors/generic-connector) instead of a raw Fetch API directly. The Fetch API requires you to hardcode authentication credentials, whereas a generic connector lets you define custom headers stored securely, eliminating the need to hardcode credentials.
