# Permissions

- Platform: data-center
- Space: SR4JS
- Hierarchy: get-started
- Doc ID: doc-sr4js-442888940
- Source: https://docs.adaptavist.com/sr4js/latest/get-started/permissions

Groups with the **Jira administrators** or **Jira System administrators** global permission can use and configure **ANY** ScriptRunner feature.

Groups with the **Jira administrators** global permission can create or edit any ScriptRunner feature unless the [Enable System Admin Only Script Edit Permissions](https://docs.adaptavist.com/sr4js/latest/get-started/settings/system-admin-only-script-edit-permission) setting has been enabled. When enabled, this setting gives script editing permission to groups with the **Jira System administrators** global permission **only**. You can further configure this setting to allow specific groups with the **Jira administrator** global permission to edit scripts.

Permission recommendations

For recommendations on mitigating scripting risks, refer to the [Permission recommendations](https://docs.adaptavist.com/sr4js/latest/get-started/settings/system-admin-only-script-edit-permission#permission-recommendations) section in our [Enable System Admin Only Script Edit Permissions](https://docs.adaptavist.com/sr4js/latest/get-started/settings/system-admin-only-script-edit-permission) documentation.

## Other users

The ability to **use** configured Scriptrunner features depends if a user has access to the related content in Jira. For example, if Jira's permissions let a user view/access the content within a given area of Jira, any related ScriptRunner features that execute in that context will run. Check out the [Atlassian documentation](https://confluence.atlassian.com/jirasoftwareserver/permissions-overview-939938996.html) for information on Jira permissions.

## Feature permissions

The following table lists the main ScriptRunner features and details how Jira permissions impact access to the configuration or use of each feature.

 

Feature

Permissions

[Built-in Scripts](https://docs.adaptavist.com/sr4js/latest/features/built-in-scripts)

Groups with the **Jira System administrators** or **Jira administrators** global permission can use and configure these features. 

**Other users** do not have access to use and configure these features.

[Jobs](https://docs.adaptavist.com/sr4js/latest/features/jobs)

[Listeners](https://docs.adaptavist.com/sr4js/latest/features/listeners)

Groups with the **Jira System administrators** or **Jira administrators** global permission can use and configure these features. 

**Other users** do not have access to configure these features but can use them providing they have the Jira permissions to perform the Jira action that triggers them.

  

[Resources](https://docs.adaptavist.com/sr4js/latest/features/resources)

[Mail Handler](https://docs.adaptavist.com/sr4js/latest/features/mail-handler)

[Script Editor](https://docs.adaptavist.com/sr4js/latest/features/script-editor)

Groups with the **Jira System administrators** or **Jira administrators** global permission can use these features. 

**Other users** do not have access to these features.

[Script Console](https://docs.adaptavist.com/sr4js/latest/features/script-console)

[Workflow Conditions, Validators & Functions](https://docs.adaptavist.com/sr4js/latest/features/workflows)

Groups with the **Jira System administrators** or **Jira administrators** global permission can use and configure this feature.

**Other users** do not have access to configure these features.

If a user has permission to view and transition an issue then configured workflow conditions, validators, and post functions will run.

[Rest Endpoints](https://docs.adaptavist.com/sr4js/latest/features/rest-endpoints)

Groups with the **Jira System administrators** or **Jira administrators** global permission can use and configure this feature.

**Other users** do not have access to configure this feature.

The admin configuring the rest endpoint controls who can make a rest call to that endpoint. Admins can define the allowed groups within the script. See the [REST Endpoints](https://docs.adaptavist.com/sr4js/latest/features/rest-endpoints) documentation for more information.

[Script Fields](https://docs.adaptavist.com/sr4js/latest/features/script-fields)

Groups with the **Jira System administrators** or **Jira administrators** global permission can use and configure this feature.

**Other users** do not have access to configure this feature.

If the field has the appropriate Jira context and screen configurations and the user has permission to view an issue, then script fields configured to that issue will display. 

[Behaviours](https://docs.adaptavist.com/sr4js/latest/features/behaviours)

Groups with the **Jira System administrators** or **Jira administrators** global permission can use and configure this feature.

**Other users** do not have access to configure this feature.

Behaviours typically trigger when an issue is created, edited, or transitioned. If a user has permission to create, edit, and transition issues, then behaviours mapped to that issue will run.

[Script Fragments](https://docs.adaptavist.com/sr4js/latest/features/fragments)

Groups with the **Jira System administrators** or **Jira administrators** global permission can use and configure this feature.

**Other users** do not have access to configure this feature.

A script fragment renders new UI elements, hides existing ones, or adds additional js/css to the page. If a user has permission to view the page where the fragment is located, the script fragment runs and either adds or removes the configured elements.

[JQL Functions](https://docs.adaptavist.com/sr4js/latest/features/jql-functions)

**Only** groups with the **Jira System administrators** or **Jira administrators** global permission can create custom JQL functions.

**Other users** can use a number of out-of-the-box JQL functions if they have permission to search for issues (for example if a user has permission to browse projects in Jira they can search for issues). Check out the [Included JQL Functions](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions) page to find out more about ScriptRunner JQL functions. 

If a user does not have permission to see a given project/issue, then the result of a JQL search does not include the restricted projects/issues.
