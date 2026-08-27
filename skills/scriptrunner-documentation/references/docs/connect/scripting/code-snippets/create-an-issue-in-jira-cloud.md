# Create an Issue in Jira Cloud

- Platform: connect
- Space: SRC
- Hierarchy: scripting > code-snippets
- Doc ID: doc-src-194676560
- Source: https://docs.adaptavist.com/src/latest/scripting/code-snippets/create-an-issue-in-jira-cloud

This code snippet creates an issue in Jira Cloud based on a pre-defined project key and issue type.

This code should work for Jira Server and Data Center, too, since the APIs are similar.

```
import JiraCloud from './api/jira/cloud';

const JIRA_PROJECT_KEY = 'ISSUE';
const ISSUE_TYPE_NAME = 'Task';

export default async function (event: any, context: Context): Promise<void> {
	// Find the project to use based on pre-defined project key
	const project = await JiraCloud.Project.getProject({
		projectIdOrKey: JIRA_PROJECT_KEY,
	});

	// Find all the issue types for the given project
	const issueTypes = await JiraCloud.Issue.Type.getTypesForProject({
		projectId: +(project.id ?? 0) // + sign converts the string to number
	});

	// // Find the issue type to use based on pre-defined issue type name
	const issueType = issueTypes.find(it => it.name === ISSUE_TYPE_NAME);
	// Check if the issue type was found
	if (!issueType) {
		// If not, then throw an error
		throw Error('Issue type not found');
	}

	// Create the issue
	const issue = await JiraCloud.Issue.createIssue({
		body: {
			fields: {
				project: {
					id: project.id ?? '0'
				},
				issuetype: {
					id: issueType.id ?? '0'
				},
				summary: 'Hello World'
			}
		}
	});

	// Log out created issue key
	console.log(`Issue created: ${issue.key}`);
}
```

## Related templates

Here are a few more templates that create issues in Jira Cloud:

-   [Sync ServiceNow Incidents with Jira Cloud Issues](https://templates.scriptrunnerconnect.com/template/01GMT114JSESH9PQRYX18X3A8W)
-   [Sync Jira Cloud issues](https://templates.scriptrunnerconnect.com/template/01GYW8F8WHZ8SAFCNVBAQY16D8)
-   [Sync Jira Cloud issues with Jira On-Premise issues](https://templates.scriptrunnerconnect.com/template/01HNFNQMDF7G1N8Y34D2SDPDDD)
-   [Create a Jira Cloud issue when a Salesforce Case status is updated](https://templates.scriptrunnerconnect.com/template/01GYHY0ZYPQSQ0DEZ4FGX1D8JA)
-   [Create a Jira Cloud Issue from Teams](https://templates.scriptrunnerconnect.com/template/01GR1FBDA84D7GC4JKADYB8Q1V)
-   [Create Jira Cloud issue from Slack with a simple slash command](https://templates.scriptrunnerconnect.com/template/01GAV2EZ71F465PD6T49XHFHPA?search=%3Fapps%3DJira%2520Cloud)
-   [Sync Jira Cloud Issues and Salesforce Cases](https://templates.scriptrunnerconnect.com/template/01HZ79YD55DAW6G30AZZBHQR04)
-   [Sync Jira Cloud issues with Trello cards](https://templates.scriptrunnerconnect.com/template/01H57VJ2RRWNBSHEMW78V4WMTY)
