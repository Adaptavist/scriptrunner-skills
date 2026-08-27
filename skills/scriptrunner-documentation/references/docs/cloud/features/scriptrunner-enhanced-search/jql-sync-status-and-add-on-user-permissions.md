# JQL Sync Status and Add-on User Permissions

- Platform: cloud
- Space: SR4JC
- Hierarchy: features > scriptrunner-enhanced-search
- Doc ID: doc-sr4jc-138938371
- Source: https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/jql-sync-status-and-add-on-user-permissions

To enable some of the functionality provided by the ScriptRunner Enhanced Search feature, extra data is added to issues (in hidden properties) to allow for faster searches. The ScriptRunner app needs to read and then write to Jira issues to perform the _syncing_ of metadata.

It is worth noting that sync status is cached for up to 10 minutes. For up-to-date results, go to the JQL Keywords Sync page via **Settings** > **Apps** > **JQL Keywords Sync**.

## JQL sync status

When ScriptRunner Enhanced Search for Jira Cloud is installed, an administrator **must** perform an [initial synchronisation](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-keywords-synchronization) before the [ScriptRunner Enhanced Search JQL keywords](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-keywords) work in Jira's native JQL search. Note that initial synchronization is also required after [migrating](https://docs.adaptavist.com/display/SR4JC/.Migrate+from+ScriptRunner+for+Jira+Server+to+Cloud+vDraft) from ScriptRunner for Jira Server to Cloud.

![](/sr4jc/files/latest/138938371/169347976/1/1680864727000/fully+synced.jpg)

The _JQL Sync Status_, which is always visible from the Enhanced Search editor, indicates the current status of the syncing. The table below describes what each status represents:

**Status**

**Description**

FULLY SYNCED

The information used by Enhanced Search to run enhanced queries has been updated for all projects.

SYNC IN PROGRESS

An administrator has triggered syncing of all issues.

NOT SYNCED

Syncing of issues is disabled, or Enhanced Search has just been installed and a sync has not yet been started. An administrator needs to turn on syncing to ensure the Enhanced Search functions have the information they need. 

PARTIALLY SYNCED

This indicates that there are some projects that Enhanced Search cannot synchronise, which is due to missing privileges required to read and write issues. See [below](#id-.JQLSyncStatusandAddonUserPermissionsvCurrent-PartiallySyncedStatus) for further details.

LOADING

The information required to display the status is being fetched. This may take a few minutes if you have many projects.

There may be a delay in the correct display of the PARTIALLY SYNCED / FULLY SYNCED status on the Enhanced Search page in the event of changes to the project privilege settings. This is due to the caching of the privilege data.

## Partially synced status

The first step in investigating the cause of a Partially Synced status is to visit the JQL Keywords Sync page. As an administrator, you can either navigate to **Settings >** **Apps** > **JQL Keywords Sync** or click the **JQL Sync Status** label:

![](/sr4jc/files/latest/138938371/169347975/1/1680865101000/partially+synced.jpg)

The project table lists privilege issues per project on the JQL Keywords Sync page, as shown below:

![](/sr4jc/files/latest/138938371/138938373/1/1652704042000/ES+-+sync+table.jpg)

Having identified a project and understood the associated warnings, it is also worth determining if the project is [Company Managed or Team Managed](https://support.atlassian.com/jira-service-management-cloud/docs/how-can-i-tell-if-im-in-a-classic-and-next-gen-project/).

## Fixing permission warnings

The table below lists permission warnings that may be shown, along with details on what the warning means and options for updating the relevant permissions.

Warning

Company/Team Managed

Description

**Please check that the add-on user has the ‘edit issues’ permission for this project.**

Company-Managed projects

In order to synchronise keywords, the add-on user needs to write extra information onto issues and therefore needs the ‘edit issues' permission.

This permission can be granted by editing the _Project Permission Scheme_ associated with the project. One approach would be to grant _Edit Issues_ to the ‘atlassian-addons-admin’ role.

See: [Jira documentation on Permission Schemes](https://support.atlassian.com/jira-cloud-administration/docs/manage-project-permissions/ "https://support.atlassian.com/jira-cloud-administration/docs/manage-project-permissions/")

**Please check the add-on user is associated with a project role that has 'Browse Projects' permission.**

Company-Managed projects

The add-on user needs _Browse Projects_ to list the issues within a project.

This permission can be granted by editing the _Project Permission Scheme_ associated with the project. One approach would be to grant _Browse Projects_ to the ‘atlassian-addons-admin’ role.

See: [Jira documentation on Permission Schemes](https://support.atlassian.com/jira-cloud-administration/docs/manage-project-permissions/ "https://support.atlassian.com/jira-cloud-administration/docs/manage-project-permissions/")

Team-Managed projects

In the first instance, check the _project access level_ for your project.

See: [Team-managed project permissions](https://support.atlassian.com/jira-software-cloud/docs/next-gen-permissions/ "https://support.atlassian.com/jira-software-cloud/docs/next-gen-permissions/")

**The add-on does not appear to match any member of the \[Level Name\] level of the issue security scheme.**

Company-Managed projects

This message is only shown for company-managed projects that also have issue-level security in place. Issue-level security can ‘hide’ issues from the add-on user if it is not granted for all levels you have created.

Ideally, the ‘atlassian-addons-admin’ role should be granted for each level of your scheme.

See: [Configuring Issue Security Schemes](https://support.atlassian.com/jira-cloud-administration/docs/configure-issue-security-schemes/ "https://support.atlassian.com/jira-cloud-administration/docs/configure-issue-security-schemes/")

**Please check the add-on permissions - it was not possible to retrieve the members of the Issue Security Scheme.**

Company-Managed projects

This message is only shown for company-managed projects that also have issue-level security. It does not necessarily indicate a syncing problem - only that the add-on user doesn’t have a full view of the permissions in place.

The ‘Administer Jira’ (global permission) is required to retrieve issue security scheme members. The add-on user has this permission by default through the 'atlassian-addons-admin' role.

See: [Managing Global Permissions](https://support.atlassian.com/jira-cloud-administration/docs/manage-global-permissions/ "https://support.atlassian.com/jira-cloud-administration/docs/manage-global-permissions/")

**Please check your Issue Level Security Scheme setup - no Security Level members could be found.**

Company-Managed projects

This message is only shown for company-managed projects that also have issue-level security. It does not necessarily indicate a syncing problem - only that the add-on user doesn’t have a full view of the permissions in place. It may be shown while issue-level security is being configured.

Check that the project is using the correct issue security scheme and that the scheme levels are set up correctly.

See: [Configuring Issue Security Schemes](https://support.atlassian.com/jira-cloud-administration/docs/configure-issue-security-schemes/ "https://support.atlassian.com/jira-cloud-administration/docs/configure-issue-security-schemes/")

**The add-on may be granted access to Security Level \[Level Name\] based on a Group, but this could not be checked as the permission to see groups has not been granted.**

Company-Managed projects

This message is only shown for company-managed projects that also have issue-level security. It does not necessarily indicate a syncing problem - only that the add-on user could not check if it is a group used by the security scheme.

Only permission to access Jira is required - so this error is unlikely to be shown.

**The add-on may be granted access to Security Level \[Level Name\] based on a Project Role, but this could not be checked as the permission to see project roles has not been granted.**

Company-Managed projects

This message is only shown for company-managed projects that also have issue-level security. It does not necessarily indicate a syncing problem - only that the add-on user could not check if it is in a role used by the security scheme.

In order to access Project roles, the add-on requires either ‘Administer Jira’ (global permission) or ‘Administer Projects’ (project permission)

See: [Configuring Issue Security Schemes](https://support.atlassian.com/jira-cloud-administration/docs/configure-issue-security-schemes/ "https://support.atlassian.com/jira-cloud-administration/docs/configure-issue-security-schemes/")

## Add-on user

The add-on user is the user created for the add-on (ie ScriptRunner or Enhanced Search), which has the permissions granted for the add-on. The add-on user should have the same account ID for all instances.

-   For [Enhanced Search for Jira Cloud](https://docs.adaptavist.com/es/latest/get-started/overview), the ID is “5d51aee1dbb98c0d9c22cfe3”.
-   For [ScriptRunner for Jira Cloud's Enhanced Search](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search) feature, the ID is “557058:d2e5bd5c-dc49-41eb-a6f0-5e01093666c1”.

* * *

## Related Content

-   [ScriptRunner Enhanced Search JQL Keywords Synchronization](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-keywords-synchronization)
-   [ScriptRunner Enhanced Search JQL Functions](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-functions)
-   [ScriptRunner Enhanced Search JQL Keywords](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-keywords)
