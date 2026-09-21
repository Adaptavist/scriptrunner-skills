# Generic Connector

- Platform: connect
- Space: SRC
- Hierarchy: Connectors
- Doc ID: doc-src-393bf9bb-4c24-4b19-a51c-62328c99aaf6-f438b8fa717674c4
- Source: https://docs.adaptavist.com/src/latest/connectors#generic-connector--en

Create a generic connector to connect to any third-party APIs you need.

Out-of-the-box, ScriptRunner Connect offers many connectors that make it easy to call third-party APIs. However, sometimes you may need to connect to something ScriptRunner Connect does not support. ScriptRunner Connect can connect to anything as long as the following prerequisites are fulfilled:

-   Connection to the third-party service can be established. Behind the firewall, services may need to be configured to let the connection from the ScriptRunner Connect side through by either allowlisting our static IP or setting up a reverse proxy in a less restricted network.
-   Third-party service has an HTTP-based API that can be called.

The most straightforward way to call a third-party API is to use [Fetch API](https://developer.mozilla.org/en-US/docs/Web/API/Fetch_API). However, most of the time you'll also need to authenticate the request, and hardcoding credentials directly into the 'fetch' call is a bad practice. To circumvent the need to hardcode any credentials in the code, ScriptRunner Connect offers a concept of the _generic connector_. The generic connector works with the base URL of the service you want to work with and one or more HTTP headers that need to be passed along with each API request.

Usually, these headers are related to authentication, but technically can be anything that you don't want to repeat or expose in your code.

Once the generic connector has been configured, you can import it like any other API connection and use it in the code.

Note: Generic API connections only expose a 'fetch' function, which you can use like any other [Managed API Fetch call](https://docs.adaptavist.com/src/latest/workspaces/package-manager#managed-apis--en).

## Authentication options

When configuring a Generic connector, you may choose one of the following authentication methods:

-   None
    -   Enter only a base URL.
-   Basic authentication
    -   Enter a base URL, and authentication details: username and password.
-   Custom headers
    -   Enter a base URL, and define one or more HTTP headers.
-   OAuth 2.0
    -   Select this option to learn about manually building an OAuth 2.0 authentication.

Tip: Custom headers

Custom headers may be added when using the _None_ or _Basic_ authentication method.

## Example

Even though ScriptRunner Connect comes with a bespoke Connector for Jira Cloud, we could also, for example, use the generic connector to connect to Jira Cloud. First, we need to grab the [API Key](https://support.atlassian.com/atlassian-account/docs/manage-api-tokens-for-your-atlassian-account/) from Atlassian, and then we can configure a generic connector.

### Create a Connector

#### Example

Even though ScriptRunner Connect comes with a bespoke Connector for Jira Cloud, we could also, for example, use the generic connector to connect to Jira Cloud. First, we need to grab the [API Key](https://support.atlassian.com/atlassian-account/docs/manage-api-tokens-for-your-atlassian-account/) from Atlassian, and then we can configure a generic connector.

To create a custom connector:

1.  From the _Connectors_ page, select Create Connector.
2.  Select the Generic HTTP connector from the listed options.
    
3.  Provide a Connector name which will appear in the _Connectors_ section in ScriptRunner Connect.
    1.  Click Continue.
4.  Select Basic authentication from the _Authentication type_ dropdown options.
    
5.  Provide the URL for your Jira instance in the Base URL text box.
6.  Click Add Basic Authentication.
    
    1.  Provide the Username and Password associated with your instance.
    2.  Click Apply.
7.  Click Save Connector.
    
    Your generic connection is completed, and a success message is shown.
    

### Make the API call

Once the generic connector is configured, we can make an API call in the code.

For this example, let's fetch an issue from Jira Cloud:

```
import JiraCloud from './api/generic';
 
export default async function(event: any, context: Context): Promise<void> {
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

Sometimes you may want to use alternative authentication schemes to what ScriptRunner Connect offers. For example, you may want to connect to Jira Cloud using the API key as shown above, but would also like to use managed API rather than a low-level fetch API.

To achieve this, you can construct the managed API manually and use it with the generic connector:

```
import { JiraCloudApi } from '@managed-api/jira-cloud-v3-sr-connect';
import JiraCloudGeneric from './api/generic';
 
export default async function(event: any, context: Context): Promise<void> {
 // Construct Managed API manually by pulling `connectionId` from the Generic API Connection and then pass it into Managed API constructor
    const JiraCloud = new JiraCloudApi(JiraCloudGeneric.connectionId);
 
 // Fetch the issue
    const issue = await JiraCloud.Issue.getIssue({
        issueIdOrKey: 'EL-66'
    });
 
 // And then print out the reporter's display name
    console.log(issue.fields.reporter.displayName);
}
```

### Import Managed API manually

When you use managed APIs via API connections, the construction of the managed API is taken care of for you, which also means you won't have to import them manually. However, when you need to construct it manually, you also need to import them manually. You can find all the [managed APIs](https://www.npmjs.com/search?q=%40managed-api) here, and the ones you need to use include the `sr-connect` postfix. The convention for the managed API class is `{ProductName}Api` (for example, `JiraCloudApi`).

You can use [UNPKG](https://unpkg.com/) to browse the content of managed APIs if you need to find out the class name you need to import. For example, browsing Jira Cloud's managed API [index.d.ts](https://unpkg.com/browse/@managed-api/jira-cloud-v3-stitch-it@0.12.0/index.d.ts) file reveals this information. We aim to make this information more transparent in the future.

You can also use the import-suggestions feature to manually pull in the managed API if you know the import name:
