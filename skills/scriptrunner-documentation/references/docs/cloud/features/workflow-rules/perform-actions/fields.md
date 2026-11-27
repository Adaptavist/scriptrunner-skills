# Fields

- Platform: cloud
- Space: SR4JC
- Hierarchy: Features > Workflow Rules > Perform Actions
- Doc ID: doc-sr4jc-d7058e75-e51f-4ef9-8c00-2a6aa1e86e92-7c395e7c6aa01b15
- Source: https://docs.adaptavist.com/sr4jc/latest/features/workflow-rules#perform-actions--en#fields--en

## Perform Actions rule

A Perform actions rule field provides additional logic to restrict execution beyond what is achievable using workflow schemes. For example, `issue.fields.summary ==~ /^(?i)foo.**/` ensures the function only executes if the _Summary starts with "foo" (case insensitive)._

Other examples include:

-   Never Execute: `false`
-   Match only a specific issue type: `((Map) issue.fields.issuetype)?.name == 'Task'`
-   Ensure that fields are present; in this case, assignee must be set: `issue.fields.assignee != null`

As shown in the image below, the area immediately above the code editor provides access to _Example scripts_ and displays the _Script context_ parameters already available in your code. You can also Load and/or Edit saved scripts from [Script Manager](../../script-manager.md) when using a Perform actions rule.

## Additional code

The Additional Code field allows users to enter a script to run an additional action after a Work item is transitioned. For example, you may want to add a comment when a parent Work item is transitioned as part of a Perform actions rule: `addComment.body = "$ {issue.key} caused this to be transitioned"`.

The Additional Code code editor provides you with the same options as the Perform actions Condition mentioned above.

## Script context

The _Script Context_ provides a set of parameters/code variables that are automatically injected into your script to provide contextual data for the Perform actions rule. They are also available for the _Condition_ and _Additional Code_ fields. To view, click Script context and a pop-up modal displays, as shown below:

The _Script Context_ for Additional Code and Conditions contains:

-   baseUrl - Base URL to make API requests against. This is the URL used for relative request paths. For example, if you make a request to `/rest/api/2/issue` we use the baseUrl to create a full request path.
-   logger - Logger to use for debugging purposes.
-   issue - Transitioned issue details available as a map. For more details, see [Get Issue REST API Reference](https://developer.atlassian.com/cloud/jira/platform/rest/#api-api-2-issue-issueIdOrKey-get).
-   transitionInput - The transition for the Work item as a map. For more details, see [Atlassian Forge Workflow Post Function Documentation](https://developer.atlassian.com/platform/forge/manifest-reference/modules/jira-workflow-post-function/).

## Run as user

Perform actions rules can make requests back to Jira using either the add-on user _(ScriptRunner Add-On User)_ or the user that performed the transition that triggered the Perform actions rule _(Initiating User)_.

When using the _Initiating User_, any action resulting from the rule is registered as performed by them. For example, if a Work item is commented on, the comment comes from the _Initiating User_ rather than the _ScriptRunner Add-on User,_ who may have no direct connection to the Work item or space affected.

Permissions are always considered when executing actions. The user selected in the Run as User field must have the correct permissions to perform the specified action. Typically, the _ScriptRunner Add-on User_ has space admin permissions; however, these can be restricted. The _Initiating User_ may have higher permissions than the _ScriptRunner Add-on User_, depending on their role in the space.

Note: The _ScriptRunner Add-On User_ does not automatically retrieve all linked Work items for a workflow action, regardless of user permissions. This behavior is controlled by Atlassian and is expected. When retrieving data, the permissions are based on the _Initiating User_, even when a script is executed by the _ScriptRunner Add-On User._

Note: If your scripts are triggered by events from another add-on, they run as the ScriptRunner Add-on User, even if you set them to run as the current user. This is because it's not possible to impersonate other add-on users. We assume that a user is an add-on user if their name starts with a prefix `add-on_`.
