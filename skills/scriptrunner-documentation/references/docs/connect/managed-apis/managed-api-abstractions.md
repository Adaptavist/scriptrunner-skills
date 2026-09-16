# Managed API Abstractions

- Platform: connect
- Space: SRC
- Hierarchy: Managed APIs
- Doc ID: doc-src-22085831-252b-47f4-8b45-f26e4af2dd93-3016378a56a1e298
- Source: https://docs.adaptavist.com/src/latest/managed-apis#managed-api-abstractions--en

Learn about the prerequisites to complete to allow connection to third-part services.

When it comes to connecting to third-party services, two prerequisites must be fulfilled:

-   ScriptRunner Connect must be able to establish a connection. Since ScriptRunner Connect is a SaaS product, the service must be accessible online. If the service is behind a firewall, we have static IP ( 34.251.34.27) assigned to all outgoing (egress) requests, which then can be configured on the firewall level to let the ScriptRunner Connect connections go through.
-   Services must offer HTTP-based APIs for ScriptRunner Connect to be able to talk to. Here is an example of how the error strategy is being used to return a def

## Demo

[Fetch API demo](https://demo.arcade.software/pyCkn5uNI91DnQPc3Aqj?embed&embed_mobile=tab&embed_desktop=inline&show_copy_link=true)

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

When we started calling the function, we were reminded that we were missing an argument:

When we specified the required options argument, we were reminded that we were missing required fields:

Tip: View error messages 👀

Hover over a red squiggly line to reveal the error message.

When we asked for suggestions for what we could specify, we were shown what's possible:

Tip: View all suggestions 👀

Press CTRL+SPACE in the editor to toggle additional suggestions. Not all suggestions appear by default.

And when we were accessing the work item that we received, we were told what was inside:

Note: You can expect the same consistent behavior for all the functions we support in our Managed APIs.

## When to use specific abstraction layers

As a rule of thumb, always start at the highest level and use Managed APIs whenever possible. Drop down to the Managed Fetch API level when the function you're looking for does not exist in the Managed API or if, for whatever reason, you cannot work with the Managed API function. Drop down to the Fetch API level when no connector is available for the service you want to work with.

Tip: Generic connectors FTW 🏆

Consider using a [generic connector](https://docs.adaptavist.com/src/latest/connectors/generic-connector) instead of a raw Fetch API directly. The Fetch API requires you to hardcode authentication credentials, whereas a generic connector lets you define custom headers stored securely, eliminating the need to hardcode credentials.
