# Permissions

- Platform: cloud
- Space: SR4JC
- Hierarchy: get-started
- Doc ID: doc-sr4jc-171279615
- Source: https://docs.adaptavist.com/sr4jc/latest/get-started/permissions

## Permissions categories

You must have Administrator rights to use ScriptRunner for Jira Cloud. You can refer to Atlassian's [documentation](https://support.atlassian.com/jira-software-cloud/docs/how-do-jira-permissions-work/#Permissionsoverview-Typesofpermissions) on permissions for Cloud.

ScriptRunner for Jira Cloud classifies users into the following categories:

-   Global Administrator (permits ability to read and write work items)
-   Space Administrator
-   Browse Jira

## Feature permissions

The table below lists the main ScriptRunner for Jira Cloud features and details the permissions required to use each feature:

Feature                                        

Global Admin Permission

Space Admin Permission

Browse Jira Permission

Notes

Enhanced Search

  

  

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

ScriptRunner Admin user needs Browse User and Groups Global Permission

Browse

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

  

  

  

Script Console

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

  

  

  

Built in Scripts

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

  

  

  

Script Listeners

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

  

  

  

Workflows Page

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

  

  

  

Scheduled Jobs

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

  

  

  

Escalation Services

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

  

  

  

Scripted Fields

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

  

  

  

Behaviours

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

  

  

  

Script Variables

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

  

  

  

Script Fragments

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

  

  

  

Execution History

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

  

  

  

Migration Reports

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

  

  

  

Logs

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

  

  

  

Audit Logs

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

  

  

  

Settings

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

  

  

  

Workflow Perform Actions

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

  

Space Admins can view workflows and see any ScriptRunner workflow functions within them, but cannot open them for viewing or editing, as they are only accessible to Global Admins. 

Workflow Restrict Transitions and Validate Details

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

  

Space Admins can view workflows and see any ScriptRunner workflow functions within them, but cannot open them for viewing or editing, as they are only accessible to Global Admins. 

JQL Keyword Sync

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

  

  

  

Add-on User Permissions

The add-on user is the user who is created for the add-on app and has permissions granted for that add-on. The add-on user is automatically generated upon ScriptRunner installation and added to the Atlassian-addon-group permission group.

Scripts written for [Scripted Fields](https://docs.adaptavist.com/sr4jc/latest/features/scripted-fields) are always executed as the add-on user and, as such, will have the correct set of permissions granted. However, if the permission schemes are changed for the Atlassian-addon-group, then there is a possibility that Scripted Fields will not work as intended.
