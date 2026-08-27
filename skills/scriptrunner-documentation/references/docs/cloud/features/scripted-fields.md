# Scripted Fields

- Platform: cloud
- Space: SR4JC
- Hierarchy: features
- Doc ID: doc-sr4jc-101629523
- Source: https://docs.adaptavist.com/sr4jc/latest/features/scripted-fields

![](/sr4jc/files/latest/101629523/403866188/1/1751971172000/sr-migrate+%281%29.png)

**Migrating from ScriptRunner for Jira Server/DC to Cloud?** **Learn more in our** **[Feature Parity](https://docs.adaptavist.com/sr4jc/latest/scriptrunner-migration-to-cloud/feature-parity-and-script-alternatives#script-fields)** **overview.**

## Before you start

[![](/sr4jc/files/latest/101629523/335381512/1/1741081600000/sr-icon-power.png)](https://www.scriptrunnerhq.com/help/example-scripts?ScriptRunner%5BrefinementList%5D%5Bapp%5D%5B0%5D=script-runner-jira&ScriptRunner%5BrefinementList%5D%5Bfeature%5D%5B0%5D=script-fields&ScriptRunner%5BrefinementList%5D%5Bplatform%5D%5B0%5D=cloud)

  

[![](/sr4jc/files/latest/101629523/335381513/1/1741081600000/Copy+of+sr-icon-mortar-board.png)](https://youtu.be/vzILSc8W9b8?si=_geBeggUANECSfT-)

Visit ScriptRunner HQ to see example scripts. 

  

Watch our Scripted Fields demo video.

[ScriptRunner HQ](https://www.scriptrunnerhq.com/help/example-scripts?ScriptRunner%5BrefinementList%5D%5Bapp%5D%5B0%5D=script-runner-jira&ScriptRunner%5BrefinementList%5D%5Bfeature%5D%5B0%5D=script-fields&ScriptRunner%5BrefinementList%5D%5Bplatform%5D%5B0%5D=cloud)

  

[Demo video](https://www.youtube.com/watch?v=t3gnI11MBOU)

  

Groovy Scripts

Remember, our scripts are written in Groovy! Check out our page on [Scripting in ScriptRunner for Jira Cloud](https://docs.adaptavist.com/sr4jc/latest/get-started/scripting-in-scriptrunner-for-jira-cloud) for tips.

  

## What are Scripted Fields?

You can use ScriptRunner for Jira Cloud's _Scripted Fields_ to customise how the information for a work item is displayed_._ They enable you to display information that would otherwise be unavailable for a work item by calculating or amalgamating data from one or more existing fields. Check out our [examples](https://docs.adaptavist.com/sr4jc/latest/features/scripted-fields/example-scripted-fields) for more details.

Scripted Fields appear on your screens when you assign their associated custom fields to the relevant screen.

Add-on User

All scripted fields are executed as the **add-on user**. The add-on user is the user who is created for the add-on app and has permissions granted for that add-on. The add-on user is automatically generated upon [ScriptRunner installation](https://docs.adaptavist.com/sr4jc/latest/get-started/installation) and added to the Atlassian-addon-group permission group. You can refer to Atlassian's [documentation](https://support.atlassian.com/jira-software-cloud/docs/how-do-jira-permissions-work/#Permissionsoverview-Typesofpermissions) on permissions for Cloud.

Scripts written for Scripted Fields are **always executed as the add-on user** and, as such, will have the correct set of permissions granted. However, if the permission schemes are changed for the Atlassian-addon-group, then there is a possibility that Scripted Fields will not work as intended. 

## How to use Scripted Fields

Scripted Fields that trigger Script Listeners, and vice versa

Scripted Fields on work items are updated after a script is executed, triggering an `issue_updated` webhook event in Jira. This event is sent to ScriptRunner but does not cause the script to run again or trigger any associated script listeners configured for work item update events.

[Script Listeners](https://docs.adaptavist.com/sr4jc/latest/features/script-listeners) that update work items will trigger an `issue_updated` webhook event in Jira which is then sent to ScriptRunner. If scripted fields are configured for the updated work items, they execute once, updating the work item and triggering another `issue_updated` webhook event without the need for any further processing.

Scripted Fields are a type of calculated field, allowing you to display a calculated custom field using ScriptRunner scripts that run when a work item is viewed. It's good practice to keep these scripts as simple as possible to reduce loading time. The Scripted Fields feature allows you to update work items in bulk.

Currently, scripted field **results are only updated when viewing a work item** **and also when a work item that contains a scripted field is updated**. This means that they must be reloaded or modified as they do not update dynamically. Please keep this in mind when using scripted fields in JQL filters.

Scripted Fields work by using the same process as other scripts, such as **[Script Listeners](https://docs.adaptavist.com/sr4jc/latest/features/script-listeners)**, where you write code that executes REST API calls to either the Jira Cloud Rest API or your own external REST API call.
