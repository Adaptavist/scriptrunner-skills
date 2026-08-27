# Fields

- Platform: cloud
- Space: SR4JC
- Hierarchy: features > workflow-rules > perform-actions
- Doc ID: doc-sr4jc-104376096
- Source: https://docs.adaptavist.com/sr4jc/latest/features/workflow-rules/perform-actions/fields

## Perform Actions rule

A Perform Actions rule field provides additional logic to restrict execution beyond what is achievable using workflow schemes. For example, `issue.fields.summary ==~ /^(?i)foo.**/**` ensures the function only executes if the \*Summary starts with "foo" (case insensitive).

Other examples include:

-   Never Execute: `false`
    
-   Match only a specific issue type: `((Map) issue.fields.issuetype)?.name == 'Task'`
    
-   Ensure that fields are present; in this case, assignee must be set: `issue.fields.assignee != null`
    

As shown in the image below, the area immediately above the code editor provides access to _Example scripts_ and displays the _Script context_ parameters already available in your code. You can also _Load_ and/or edit saved scripts from [Script Manager](https://docs.adaptavist.com/sr4jc/latest/features/script-manager) when using the perform actions rule.

![A screenshot of the Perform Actions rule configuration.](/sr4jc/files/latest/104376096/537855533/1/1778008306000/image+%287%29.png)

## Additional code

The **Additional Code** field allows users to enter a script to run an additional action after a work item is transitioned. For example, you may want to add a comment when a parent work item is transitioned as part of a Perform actions rule: `addComment.body = "$ {issue.key} caused this to be transitioned"`.

The **Additional Code** code editor provides you with the same options as the perform actions **Condition** mentioned above.

## Script context

The _Script Context_ provides a set of parameters/code variables that are automatically injected into your script to provide contextual data for the Perform actions rule. They are also available for the _Condition_ and _Additional Code_ fields.  
To view, click **Script context** and a pop-up modal displays, as shown below:

![](/sr4jc/files/latest/104376096/509345816/1/1770289241000/script+context.png)

The _Script Context_ for Additional Code and Conditions contains:

-   baseUrl - Base URL to make API requests against. This is the URL used for relative request paths. For example, if you make a request to `/rest/api/2/issue` we use the baseUrl to create a full request path.
    
-   logger - Logger to use for debugging purposes.
    
-   issue - Transitioned issue details available as a map. For more details, see [Get Issue REST API Reference](https://developer.atlassian.com/cloud/jira/platform/rest/#api-api-2-issue-issueIdOrKey-get).
    
-   transitionInput - The transition for the work item as a map. For more details, see [Atlassian Connect Workflow Post Function Documentation](https://developer.atlassian.com/cloud/jira/platform/modules/workflow-post-function).
    

## Run as user

Perform actions rules can make requests back to Jira using either the add-on user (_ScriptRunner Add-On User_) or the user that performed the transition that triggered the perform actions rule (_Initiating User_).

When using the _Initiating User_, any action resulting from the rule is registered as performed by them. For example, if a work item is commented on, the comment comes from the _Initiating User_ rather than the _ScriptRunner Add-on User,_ who may have no direct connection to the work item or space affected.

Permissions are always considered when executing actions. The user selected in the **Run as User** field must have the correct permissions to perform the specified action. Typically, the _ScriptRunner Add-on User_ has space admin permissions; however, these can be restricted. The _Initiating User_ may have higher permissions than the _ScriptRunner Add-on User_, depending on their role in the space.

The _ScriptRunner Add-On User_ does not automatically retrieve all linked work items for a workflow action, regardless of user permissions. This behavior is controlled by Atlassian and is expected. When retrieving data, the permissions are based on the _Initiating User_, even when a script is executed by the _ScriptRunner Add-On User._

If your scripts are triggered by events from another add-on, they run as the ScriptRunner Add-on User, even if you set them to run as the current user. This is because it’s not possible to impersonate other add-on users. We assume that a user is an add-on user if their name starts with a prefix ' add-on\_'.
