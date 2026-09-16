# Permissions

- Platform: cloud
- Space: SR4JC
- Hierarchy: Get Started
- Doc ID: doc-sr4jc-ff81a2a6-cf3e-461b-a19d-db4131cd9921-bad9c887b1edc53c
- Source: https://docs.adaptavist.com/sr4jc/latest/get-started/permissions

## Permissions categories

You must have Administrator rights to use ScriptRunner for Jira Cloud. You can refer to Atlassian's [documentation](https://support.atlassian.com/jira-software-cloud/docs/how-do-jira-permissions-work/#Permissionsoverview-Typesofpermissions) on permissions for Cloud.

ScriptRunner for Jira Cloud classifies users into the following categories:

-   Global Administrator (permits ability to read and write work items)
-   Space Administrator
-   Browse Jira

## Feature permissions

The table below lists the main ScriptRunner for Jira Cloud features and details the permissions required to use each feature:

| Feature | Global Admin Permission | Space Admin Permission | Browse Jira Permission | Notes |
| --- | --- | --- | --- | --- |
| Enhanced Search |  |  |  | ScriptRunner Admin user needs Browse User and Groups Global Permission |
| Browse |  |  |  |  |
| Script Console |  |  |  |  |
| Built in Scripts |  |  |  |  |
| Script Listeners |  |  |  |  |
| Workflows Page |  |  |  |  |
| Scheduled Jobs |  |  |  |  |
| Escalation Services |  |  |  |  |
| Scripted Fields |  |  |  |  |
| Behaviours |  |  |  |  |
| Script Variables |  |  |  |  |
| Script Fragments |  |  |  |  |
| Execution History |  |  |  |  |
| Migration Reports |  |  |  |  |
| Logs |  |  |  |  |
| Audit Logs |  |  |  |  |
| Settings |  |  |  |  |
| Workflow Perform Actions |  |  |  | Space Admins can view workflows and see any ScriptRunner workflow functions within them, but cannot open them for viewing or editing, as they are only accessible to Global Admins. |
| Workflow Restrict Transitions and Validate Details |  |  |  | Space Admins can view workflows and see any ScriptRunner workflow functions within them, but cannot open them for viewing or editing, as they are only accessible to Global Admins. |
| JQL Keyword Sync |  |  |  |  |

Note: Add-on User Permissions

The add-on user is the user who is created for the add-on app and has permissions granted for that add-on.

The add-on user is automatically generated upon ScriptRunner installation and added to the Atlassian-addon-group permission group.

Scripts written for [Scripted Fields](../features/scripted-fields.md) are always executed as the add-on user and, as such, will have the correct set of permissions granted. However, if the permission schemes are changed for the Atlassian-addon-group, then there is a possibility that Scripted Fields will not work as intended.
