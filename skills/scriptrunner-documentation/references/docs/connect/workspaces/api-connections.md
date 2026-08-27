# API Connections

- Platform: connect
- Space: SRC
- Hierarchy: workspaces
- Doc ID: doc-src-194675230
- Source: https://docs.adaptavist.com/src/latest/workspaces/api-connections

API connections allow you to make outbound (egress) external API calls to services you need to talk to. API connections act as a proxy and as an API client. Your requests are internally proxied, where we substitute the base URL and authentication headers, so you don't have to. Most of the time, API connections also expose a [Managed API](https://docs.adaptavist.com/src/latest/managed-apis) that acts as an API client, reducing the need to work directly at the HTTP level; however, you can do so if necessary by calling the fetch function from the API connection.

When you create a new API connection, you'll be asked to select the app you'd like to work with, after which you'll be taken to a new screen where you have to provide the following information:

-   **Path** - The path you can use to import the API connection into your code. The path must be unique in your workspace.
-   **Connector** - The connector that substitutes the base URL and authentication headers when you kick off the API call.

## Import API connection

Once an API connection is created, you can import any API connection you created in any script in your workspace. To do so, you have three options:

-   Click **Import API Connection** and use the UI (located at the script editor's toolbar) to import the API connection
-   Click **Copy** in the resource tree when hovering over an API connection, then paste the statement into your code
    
    While you can paste the import statement in any line as long as you're in the global scope of your script, a useful convention is to place all imports at the top of your script.
    
-   Manually type out the import statement into your code

-   Import syntax for API connections is as follows: "import IMPORT\_NAME from './api/API\_CONNECTION\_PATH'";
    -   For example: "import JiraCloud from './api/jira/cloud'"
-   You can name the import anything you like, as long as the import is unique in your script. For example, instead of using the suggested import name as demonstrated in the example above, you can change it to "import MyJira from './api/jira/cloud'"

## Use the API Connection Import in your code

For example, if you have imported a JiraCloud API Connection, you can then use the API Connection and Managed API as an extension as follows:

```
import JiraCloud from './api/jira/cloud';

export default async function(event: any, context: Context) {
	const issue = await JiraCloud.Issue.getIssue({
		issueIdOrKey: 'ISSUE-1'
	});

	// Do something with the issue
}
```

While also getting suggestions on how to use the API:

![An API screenshot with auto-suggestions shown. ](/src/files/latest/194675230/194675253/1/1695207712000/Screenshot+2022-08-16+at+14.59.38.png)
