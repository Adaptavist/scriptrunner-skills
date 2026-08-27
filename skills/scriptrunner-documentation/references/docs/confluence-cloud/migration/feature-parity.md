# Feature Parity

- Platform: confluence-cloud
- Space: SR4CC
- Hierarchy: migration
- Doc ID: doc-sr4cc-114205229
- Source: https://docs.adaptavist.com/sr4cc/latest/migration/feature-parity

ScriptRunner for Confluence Data Center and ScriptRunner for Confluence Cloud do not have the exact same set of features. Our development teams are working hard on providing feature parity for you to support you during a migration to Cloud. The following tables outline current features available in ScriptRunner for Data Center, followed by parity information and alternatives available in Cloud.

If there is something you'd like to see in Cloud, please let us know [here](https://www.scriptrunnerhq.com/help/support) or vote using the _**Vote Here!**_ buttons in the tables.

Key

Definition

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

Full feature parity.

**◐**

Partial feature parity. Possible workarounds available.

**ALT**

No feature parity, but alternatives are available.

**X**

The feature is not applicable in the Cloud environment.

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

No feature parity is currently available and no possible workarounds are available.

## Quick Links

-   [Built-In Scripts for Confluence Administration](#id-.FeatureParityvCurrent-bisca)
-   [Built-In Scripts for Space Administration](#id-.FeatureParityvCurrent-bissa)
-   [CQL Functions](#id-.FeatureParityvCurrent-functions)
-   [Script Fragments](#id-.FeatureParityvCurrent-fragments)
-   [Jobs](#id-.FeatureParityvCurrent-jobs)
-   [Listeners](#id-.FeatureParityvCurrent-listeners)
-   [Macros](#id-.FeatureParityvCurrent-macros)
-   [Resources](#id-.FeatureParityvCurrent-resources)
-   [Rest API](#id-.FeatureParityvCurrent-rest)
-   [Rest Endpoints](#id-.FeatureParityvCurrent-endp)
-   [Script Console](#id-.FeatureParityvCurrent-console)
-   [Script Editor](#id-.FeatureParityvCurrent-editor)
-   [Script Variables](#id-.FeatureParityvCurrent-variables)
-   [Scripting Features](#id-.FeatureParityvCurrent-script)
-   [Search Features](#id-.FeatureParityvCurrent-search)
-   [Settings](#id-.FeatureParityvCurrent-settings)

## Built-In Scripts (Confluence Administration)

Server/DC Feature

Cloud Parity

Parity Notes/Alternatives

Add/Remove Watchers

**ALT**

Although the Add/Remove Watchers built-in script is not currently available in ScriptRunner for Confluence Cloud, you can add and remove watchers per page based on different triggers using Confluence Automation. 

🚀 If you'd like to add and remove watchers in bulk, [Vote Here!](https://scriptrunner-for-confluence-cloud.nolt.io/7)

Bulk Delete Attachments

**![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)**

![](/files/112159817/386531344/1/1749453095000/sr-icon-cloud.png)Cloud documentation link: [Bulk Delete Attachments](https://docs.adaptavist.com/display/_PK/SR4CC/bulk-delete-attachments)

The feature functions the same between Data Center and Cloud, but there are some differences you should know before migration:

-   Cloud: 
    -   The **Space Selector** field allows more specific selections.
-   Data Center:
    -   You can refine scripts with attachment age.
    -   There are built-in notification abilities.
    -   You can preview script results.

Bulk Delete Attachment Versions

**![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)**

🚀 If you'd like to see this feature added to ScriptRunner for Confluence Cloud, [Vote Here!](https://jira.atlassian.com/browse/CONFCLOUD-17020)

Bulk Delete Comments

**![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)**

![](/files/112159817/386531344/1/1749453095000/sr-icon-cloud.png)Cloud documentation link: [Bulk Delete Comments](https://docs.adaptavist.com/display/_PK/SR4CC/bulk-delete-comments-from-one-or-more-pages)

The feature functions the same between Data Center and Cloud, but there are some differences you should know before migration: 

-   Cloud: 
    -   The **Space Selector** field allows more specific selections.
    -   Static options for the **Comment Age** field.
-   Data Center:
    -   Customized options for the **Comment Age** field.
    -   There are built-in notification abilities.
    -   You can preview script results.

Bulk Purge Trash

**![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)**

![](/files/112159817/386531344/1/1749453095000/sr-icon-cloud.png)Cloud documentation link: [Bulk Purge Trash](https://docs.adaptavist.com/display/_PK/SR4CC/bulk-purge-trash)

The feature functions the same between Data Center and Cloud, except you can preview script results in Data Center.

Change Content Author

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

🚀 If you'd like to see this feature added to ScriptRunner for Confluence Cloud, [Vote Here!](https://scriptrunner-for-confluence-cloud.nolt.io/9)

Clear Groovy Class Loader

**X**

This feature is not needed in ScripRunner for Confluence Cloud because containers do not affect each other the same way they do in Data Center.

Configuration Exporter

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

This feature is not available in ScriptRunner for Confluence Cloud due to Cloud API limitations. 

Convert Absolute Links to Confluence Links

**X**

This feature is not needed in ScriptRunner for Confluence Cloud because smart IDs are used, so links do not need to be converted.

Copy Pages

**![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)**

![](/files/112159817/386531344/1/1749453095000/sr-icon-cloud.png)Cloud documentation link: [Copy Page Tree](https://docs.adaptavist.com/display/_PK/SR4CC/copy-page-tree)

The feature functions the same between Data Center and Cloud, but there are some differences you should know before migration:

-   Cloud: 
    -   The **Space Selector** field allows more specific selections.
    -   The **Title Replace** field looks different in Cloud and Data Center, but they function the same.
-   Data Center:
    -   You can add suffixes to page titles.
    -   You can copy inline and page comments.
    -   You can add custom code transforms
    -   There are built-in notification abilities.
    -   You can preview script results.

Copy Space

**![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)**

![](/files/112159817/386531344/1/1749453095000/sr-icon-cloud.png)Cloud documentation link: [Copy Space](https://docs.adaptavist.com/display/_PK/SR4CC/copy-space)

The feature functions the same between Data Center and Cloud, but there are some differences you should know before migration:

-   Cloud:
    -   You can copy attachments and labels.
-   Data Center:
    -   You can copy inline and page comments.
    -   There are built-in notification abilities.
    -   You can preview script results.

Delete Pages

**![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)**

![](/files/112159817/386531344/1/1749453095000/sr-icon-cloud.png)Cloud documentation link: [Delete Page Tree](https://docs.adaptavist.com/display/_PK/SR4CC/delete-page-tree)

The feature functions the same between Data Center and Cloud, but there are some differences you should know before migration:

-   Cloud: 
    -   The **Space Selector** field allows more specific selections.
-   Data Center: 
    -   You can preview script results.

List Scheduled Jobs

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

🚀 If you'd like to see this feature added to ScriptRunner for Confluence Cloud, [Vote Here!](https://scriptrunner-for-confluence-cloud.nolt.io/10)

Manage Labels

**![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)**

![](/files/112159817/386531344/1/1749453095000/sr-icon-cloud.png)Cloud documentation link: [Bulk Add or Remove Labels on One or More Pages](https://docs.adaptavist.com/display/_PK/SR4CC/bulk-add-remove-labels-on-one-or-more-pages) and [Rename Labels](https://docs.adaptavist.com/display/_PK/SR4CC/rename-labels)

In ScriptRunner for Confluence Data Center, the _Bulk Add or Remove Labels_ and _Rename Labels_ scripts were consolidated into _Manage Labels_. In ScriptRunner for Confluence Cloud, you can use the original _Bulk Add or Remove Labels_ and _Rename Labels_ scripts for the same results. 

Rename Pages

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

🚀 If you'd like to see this feature added to ScriptRunner for Confluence Cloud, [Vote Here!](https://jira.atlassian.com/browse/CONFCLOUD-74287)

Script Registry

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

🚀 If you'd like to see this feature added to ScriptRunner for Confluence Cloud, [Vote Here!](https://scriptrunner-for-confluence-cloud.nolt.io/8)

Space Statistics

**ALT**

Although the _Space Statistics_ script is not available in ScriptRunner for Confluence Cloud, you can get the same information provided by the script when using [Mission Control](https://www.atlassian.com/software/confluence/mission-control) and [Analytics](https://support.atlassian.com/confluence-cloud/docs/view-analytics-to-see-how-content-is-performing/), which is available in Confluence Premium and Enterprise tiers.

Switch to a Different User

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

This feature is not available in ScriptRunner for Confluence Cloud due to API limitations.

Test Runner

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

This feature is not available in ScriptRunner for Confluence Cloud due to API limitations.

Update Macro

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

We are researching implementing this macro in ScriptRunner for Confluence Cloud. 

🚀 If you'd like to see this feature added to ScriptRunner for Confluence Cloud, [Vote Here!](https://scriptrunner-for-confluence-cloud.nolt.io/15)

Update Page Restrictions

**ALT**

The _Update Page Restrictions_ script updates restrictions for a page and all of its children. Although we are working on full parity, it is not available yet. You can use the [Restrict Page Tree by User Group Example Script](https://www.scriptrunnerhq.com/help/example-scripts/restrict-pageTree-by-user-group-cloud) to edit restrictions on a per page basis.

View Server Log Files

**ALT**

This feature is not needed in ScriptRunner for Confluence Cloud because server log files are not used. However, you can look at [Script Logs](https://docs.adaptavist.com/display/_PK/SR4CC/script-logs) for information related to your recent executions.

XPath Search in Pages

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

_XPath Search in Pages_ is not available in ScriptRunner for Confluence Cloud because Confluence Cloud does not provide access to XML content, which is required for executing XPath queries. 

🚀If you'd like a similar feature, you can [Vote Here!](https://scriptrunner-for-confluence-cloud.nolt.io/11)

## Built-In Script (Space Administration)

Server/DC Feature

Cloud Parity

Parity Comments/Alternatives

Add/Remove Watchers

**ALT**

Although the _Add/Remove Watchers_ built-in script is not currently available in ScriptRunner for Confluence Cloud, you can add and remove watchers per page based on different triggers using Confluence Automation. 

🚀 If you'd like to add and remove watchers in bulk, [Vote Here!](https://scriptrunner-for-confluence-cloud.nolt.io/7)

Bulk Delete Attachments

**![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)**

![](/files/112159817/386531344/1/1749453095000/sr-icon-cloud.png)Cloud documentation link: [Bulk Delete Attachments](https://docs.adaptavist.com/display/_PK/SR4CC/space-admin-bulk-delete-attachments)

The feature functions the same between Data Center and Cloud, but there are some differences you should know before migration:

-   Cloud: 
    -   The **Space Selector** field allows more specific selections.
-   Data Center:
    -   You can refine scripts with attachment age.
    -   There are built-in notification abilities.
    -   You can preview script results.

Bulk Delete Attachment Versions

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

🚀 If you'd like to see this feature added to ScriptRunner for Confluence Cloud, [Vote Here!](https://jira.atlassian.com/browse/CONFCLOUD-17020)

Bulk Delete Comments

**![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)**

![](/files/112159817/386531344/1/1749453095000/sr-icon-cloud.png)Cloud documentation link: [Bulk Delete Comments From One or More Pages](https://docs.adaptavist.com/display/_PK/SR4CC/space-admin-bulk-delete-comments)

The feature functions the same between Data Center and Cloud, but there are some differences you should know before migration:

-   Cloud: 
    -   The **Space Selector** field allows more specific selections.
    -   Static options for the **Comment Age** field.
-   Data Center:
    -   Customized options for the **Comment Age** field.
    -   There are built-in notification abilities.
    -   You can preview script results.

Bulk Purge Trash

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![](/files/112159817/386531344/1/1749453095000/sr-icon-cloud.png)Cloud documentation link: [Bulk Purge Trash](https://docs.adaptavist.com/display/_PK/SR4CC/space-admin-bulk-purge-trash)

The feature functions the same between Data Center and Cloud, except you can preview script results in Data Center.

Change Content Authors

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

🚀 If you'd like to see this feature added to ScriptRunner for Confluence Cloud, [Vote Here!](https://scriptrunner-for-confluence-cloud.nolt.io/9)

Copy Pages

**![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)**

![](/files/112159817/386531344/1/1749453095000/sr-icon-cloud.png)Cloud documentation link: [Copy Page Tree](https://docs.adaptavist.com/display/_PK/SR4CC/space-admin-copy-page-tree)

The feature functions the same between Data Center and Cloud, but there are some differences you should know before migration:

-   Cloud: 
    -   The **Space Selector** field allows more specific selections.
    -   The **Title Replace** field looks different in Cloud and Data Center, but they function the same.
-   Data Center:
    -   You can add suffixes to page titles.
    -   You can copy inline and page comments.
    -   You can add custom code transforms
    -   There are built-in notification abilities.
    -   You can preview script results.

Copy Space

**![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)**

![](/files/112159817/386531344/1/1749453095000/sr-icon-cloud.png)Cloud documentation link: [Copy Space](https://docs.adaptavist.com/display/_PK/SR4CC/space-admin-copy-space)

The feature functions the same between Data Center and Cloud, but there are some differences you should know before migration:

-   Cloud:
    -   You can copy attachments and labels.
-   Data Center:
    -   You can copy inline and page comments.
    -   There are built-in notification abilities.
    -   You can preview script results.

Delete Pages

**![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)**

![](/files/112159817/386531344/1/1749453095000/sr-icon-cloud.png)Cloud documentation link: [Delete Page Tree](https://docs.adaptavist.com/display/_PK/SR4CC/space-admin-delete-page-tree)

The feature functions the same between Data Center and Cloud, but there are some differences you should know before migration:

-   Cloud: 
    -   The **Space Selector** field allows more specific selections.
-   Data Center: 
    -   You can preview script results.

Manage Labels

**![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)**

![](/files/112159817/386531344/1/1749453095000/sr-icon-cloud.png)Cloud documentation link: [Bulk Add/Remove Labels on One or More Pages](https://docs.adaptavist.com/display/_PK/SR4CC/space-admin-bulk-add-remove-labels-on-one-or-more-scripts) and [Rename Labels](https://docs.adaptavist.com/display/_PK/SR4CC/space-admin-rename-labels)

In ScriptRunner for Confluence Data Center, the _Bulk Add or Remove Labels_ and _Rename Labels_ scripts were consolidated into _Manage Labels_. In ScriptRunner for Confluence Cloud, you can use the original _Bulk Add or Remove Labels_ and _Rename Labels_ scripts for the same result. 

Rename Pages

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

🚀 If you'd like to see this feature added to ScriptRunner for Confluence Cloud, [Vote Here!](https://jira.atlassian.com/browse/CONFCLOUD-74287)

Space Statistics

**ALT**

Although the _Space Statistics_ script is not available in ScriptRunner for Confluence Cloud, you can get the same information provided by the script when using [Mission Control](https://www.atlassian.com/software/confluence/mission-control) and [Analytics](https://support.atlassian.com/confluence-cloud/docs/view-analytics-to-see-how-content-is-performing/), which is available in Confluence Premium and Enterprise tiers.

Update Page Restrictions

****ALT****

The _Update Page Restrictions_ script updates restrictions for a page and all of its children. Although we are working on full parity, it is not available yet. You can use the [_Restrict Page Tree by User Group_ Example Script](https://www.scriptrunnerhq.com/help/example-scripts/restrict-pageTree-by-user-group-cloud) to edit restrictions on a per page basis.

## CQL Functions

Server/DC Feature

Cloud Parity

Parity Notes/Alternatives

Custom CQL Function

**◐**

Although this feature is not available in Cloud, you can configure a [Custom Macro](https://docs.adaptavist.com/sr4cc/current/features/macros/custom-macros) to function the same way as a Data Center [Custom CQL Function](https://docs.adaptavist.com/sr4c/latest/features/cql-functions). You can put the same code written for a CQL function into a Custom Macro and use the macro parameters to provide advanced searches for content in Confluence.  
For example, check out the Custom Macro example [CQL Function - Search all pages that contain a specific label](https://docs.adaptavist.com/sr4cc/current/features/macros/custom-macros/example-cql-function-search-all-pages-that-contain-a-specific-label). 

## Fragments

Since the Data Center and Cloud UIs and APIs are different, using _Script Fragments_ differs between the two platforms. Although there are comparable fragment types, they function differently. Please review the ScriptRunner for Confluence Cloud _[Script Fragments](https://docs.adaptavist.com/display/_PK/SR4CC/script-fragments)_ documentation to understand the differences.

The _[General Page Fragments](https://docs.adaptavist.com/display/_PK/SR4CC/script-fragments#general)_ type is exclusive to ScriptRunner for Confluence Cloud.

Server/DC Feature

Cloud Parity

Parity Notes/Alternatives

Hide UI Element

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

This feature is not available in ScriptRunner for Confluence Cloud due to API limitations.

Web Item

**◐**

![](/files/112159817/386531344/1/1749453095000/sr-icon-cloud.png)Cloud documentation link: [Web Item Fragments](https://docs.adaptavist.com/display/_PK/SR4CC/script-fragments#item) and [General Page Fragments](https://docs.adaptavist.com/display/_PK/SR4CC/script-fragments#general)

The same type of fragment exists in ScriptRunner for Confluence Cloud, but there are some differences you should know before migration:

-   **Location/Section** field
    -   In Cloud, the **Location** field determines where the fragment appears on the screen. This is referred to as the "section" in Data Center.
    -   In Cloud, there is one location available for web item fragments. There are more locations available in Data Center because it has more extension points.
-   **Condition** field
    -   In Data Center, you can set **Conditions** when the web item fragment appears using a script. This is not yet available in Cloud. Right now, conditions are pre-set to always appear.   
        🚀 If you'd like to be able to set conditions, [Vote Here!](https://scriptrunner-for-confluence-cloud.nolt.io/16)
-   **Key** field
    -   In Data Center, you can set the **Key** of the web item fragment. In Cloud, it is generated for you.
-   The **Do What** field
    -   In Data Center, you can set what you want the fragment to do when selected (for example, you can choose **Navigate to a link** or **Run code and show a flag**). In Cloud, this is set in the source code that you link to the fragment in the **Source** and **URL** field(s).
-   Other fields
    -   The **Name**, **Menu Text**, and **Weight** fields are possible in Cloud. We are researching implementing these fields in ScriptRunner for Confluence Cloud. We will add voting buttons here when voting is available.

Web Panel

**◐**

![](/files/112159817/386531344/1/1749453095000/sr-icon-cloud.png)Cloud documentation link: [Web Panel Fragments](https://docs.adaptavist.com/display/_PK/SR4CC/script-fragments#panel)

The same type of fragment exists in ScriptRunner for Confluence Cloud, but there are some differences you should know before migration:

-   **Location/Section** field
    -   In Cloud, the **Location** field determines where the fragment appears on the screen. This is referred to as the "section" in Data Center.
    -   In Cloud, there is one location available for web panel fragments. There are more locations available in Data Center because it has more extension points.
-   **Condition** field
    -   In Data Center, you can set **Conditions** when the web panel fragment appears using a script. This is not yet available in Cloud. Right now, conditions are pre-set to always appear.  
        🚀 If you'd like to be able to set conditions, [Vote Here!](https://scriptrunner-for-confluence-cloud.nolt.io/16)
-   **Key** field
    -   In Data Center, you can set the **Key** of the web panel fragment. In Cloud, it is generated for you.
-   The **Do What** field
    -   In Data Center, you can set what you want the fragment to do when selected (for example, you can choose **Navigate to a link** or **Run code and show a flag**). In Cloud, this is set in the source code that you link to the fragment in the **Source** and **URL** field(s).
-   Other fields
    -   The **Name**, **Menu Text**, and **Weight** fields are possible in Cloud. We are researching implementing these fields in ScriptRunner for Confluence Cloud. We will add voting buttons here when voting is available.
    -   The **Do What** field is available in Data Center.

Install Web Resource

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

It is not possible to install custom web resources for specific Confluence Cloud elements because Atlassian controls this presentation layer.

It is not possible to install alternative web resources for specific Confluence elements. Atlassian controls this presentation layer.

Web Section

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

🚀 We are researching implementing this feature in ScriptRunner for Confluence Cloud. We will add a voting button here when voting is available.

XML Module Item

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

This feature is not available in ScriptRunner for Confluence Cloud due to API limitations.

Fragment Locator

**ALT**

Although the Fragment Locator is not provided in ScriptRunner for Confluence Cloud, you can use [Extension Point Finder for Confluence](https://marketplace.atlassian.com/apps/1230671/extension-point-finder-for-confluence?tab=overview&hosting=cloud), an Atlassian app, to locate fragment locations in Cloud.

## Jobs

Server/DC Feature

Cloud Parity

Parity Notes/Alternatives

Bulk Delete Attachments

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

  

Bulk Purge Trash

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

  

Custom Scheduled Job

**![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)**

![](/files/112159817/386531344/1/1749453095000/sr-icon-cloud.png)Cloud documentation link: [Script Jobs](https://docs.adaptavist.com/display/_PK/SR4CC/script-jobs)

The feature functions the same between Data Center and Cloud, but Cloud has a minimum interval of one hour and scripts have a 60-second limitation. When you rewrite your Data Center scripts for Cloud, they must adhere to these limitations.

CQL Escalation Service

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![](/files/112159817/386531344/1/1749453095000/sr-icon-cloud.png)Cloud documentation link: [CQL Script Job](https://docs.adaptavist.com/sr4cc/current/features/cql-script-jobs)

In ScriptRunner for Confluence Cloud, this is a seperate feature is named _[CQL Script Job](https://docs.adaptavist.com/sr4cc/current/features/cql-script-jobs)_ and a CQL query is required for the script to run. In Data Center, this is a built-in job but it is a separate feature in Cloud, as you can see from the ScriptRunner navigation in Cloud: 

![](/files/112159817/386531345/1/1749453096000/jobs.png)

Data Center and Cloud have different APIs for scripts but the same API for CQL queries. You cannot copy and paste CQL statements from Data Center to Cloud; they must be adapted.

Manage Labels

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

  

Old Content Notifier

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

  

Prune Old Page Versions

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

  

Update Page Restrictions

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

  

## Listeners

**Event Parity**

The Confluence events for Data Center and Cloud differ. Check out [Confluence Events Parity](https://docs.adaptavist.com/sr4c/latest/migration/migrating-to-from-cloud/feature-parity/confluence-events-parity) for more information. 

**Workaround for built-in listeners**

The following built-in listeners (marked with **ALT** in the chart) do not exist in ScriptRunner for Confluence Cloud. However, you can achieve the same results by writing your own script using the [_Custom Event Listener_](https://docs.adaptavist.com/sr4cc/current/features/script-listeners) feature:

-   _Add/Remove Watchers Listener_
-   _Inherit Parent Permissions for New Pages_
-   _Send Custom Email_

Please ensure it fits into the 60-second time limitation and had Cloud API availability. 

Server/DC Feature

Cloud Parity

Parity Notes/Alternatives

Add/Remove Watchers Listener

**ALT**

See note above for workaround.

Custom Event Listener

**![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)**

![](/files/112159817/386531344/1/1749453095000/sr-icon-cloud.png)Cloud documentation link: [Script Listeners](https://docs.adaptavist.com/display/_PK/SR4CC/script-listeners)

The feature functions the same between Data Center and Cloud, but Cloud scripts have a 60-second limitation.

Inherit Parent Permissions for New Pages

**ALT**

See note above for workaround.

Manage Labels

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

  

Send Custom Email

**ALT**

The Cloud API does not allow you to email external email addresses, but you can notify users, groups, or user fields (such as assignee or reporter) from your Confluence Cloud instance. 

See note above for workaround.

Update Page Restrictions

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

  

## Macros

A note about built-in macros

In ScriptRunner for Confluence Data Center, the following built-in macros can be disabled and enabled by the administrator: 

-   _Add Label_
-   _Choose Label_
-   _Page Info_

In ScriptRunner for Confluence Cloud, they cannot be disabled and are always enabled.

Server/DC Feature

Cloud Parity

Parity Notes/Alternatives

Add Label

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![](/files/112159817/386531344/1/1749453095000/sr-icon-cloud.png)Cloud documentation link: [Add Label](https://docs.adaptavist.com/display/_PK/SR4CC/add-label)

This macro is always enabled in ScriptRunner for Confluence Cloud. Please see the note above for more information.

Choose Label

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![](/files/112159817/386531344/1/1749453095000/sr-icon-cloud.png)Cloud documentation link: [Choose Label](https://docs.adaptavist.com/display/_PK/SR4CC/choose-label)

This macro is always enabled in ScriptRunner for Confluence Cloud. Please see the note above for more information.

CQL Search

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

  

Create Page

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

Out-of-the-box Confluence Cloud offers the [_Create from Template_ macro](https://support.atlassian.com/confluence-cloud/docs/insert-the-create-from-template-macro/), which displays a button on a page linked to a specific template. You can use this in place of the _Create Page_ macro.

Custom Macro

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![](/files/112159817/386531344/1/1749453095000/sr-icon-cloud.png)Cloud documentation link: [Custom Macro](https://docs.adaptavist.com/display/_PK/SR4CC/custom-macros)

You can create _Custom Macros_ in ScriptRunner for Confluence Cloud; however, they currently cannot contain dynamic content like they can in Data Center.

🚀 If you'd like to use dynamic content in _Custom Macros_, [Vote Here!](https://scriptrunner-for-confluence-cloud.nolt.io/14)

Include Versions

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

Out-of-the-box Confluence Cloud offers the _[Include Page](https://support.atlassian.com/confluence-cloud/docs/insert-the-include-page-macro/)_ macro, which allows you to display the content from the most recent version of the page. Using the Include Versions macro, Data Center allows you to display the content from historical versions of the page.

🚀 If you'd like to display content from historical versions of the page, [Vote Here!](https://scriptrunner-for-confluence-cloud.nolt.io/12)

Include Reports

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

This relies on the _Include Versions_ macro functionality, explained in the cell above. Vote on that macro below if you'd like this feature.

Markdown

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

🚀 If you'd like to see this feature, [Vote Here!](https://scriptrunner-for-confluence-cloud.nolt.io/13)

Mughsot Gallery

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

Out-of-the-box Confluence Cloud offers the [_Profile Picture_ macro](https://support.atlassian.com/confluence-cloud/docs/insert-the-profile-picture-macro/) to show the picture of a user and the [_User List_ macro](https://confluence.atlassian.com/doc/user-list-macro-139546.html) to show the members of a user group. You can use these two macros in place of the _Mugshot Gallery_ macro.

Page Info

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![](/files/112159817/386531344/1/1749453095000/sr-icon-cloud.png)Cloud documentation link: [Page Info](https://docs.adaptavist.com/display/_PK/SR4CC/page-info)

The feature functions the same between Data Center and Cloud, but Data Center supports the _Tiny URL_ value for the **Information Type** field.

This macro is always enabled in ScriptRunner for Confluence Cloud. Please see the note above for more information.

Versions History

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

Out-of-the-box Confluence Cloud offers the [_Change History_ macro](https://support.atlassian.com/confluence-cloud/docs/insert-the-change-history-macro/), which shows the history of updates made to a page including version number, author, date, and comment. You can use this in place of the _Versions History_ macro.

## Resources

Server/DC Feature

Cloud Parity

Parity Notes/Alternatives

Database Connection

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

  

LDAP Connection

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

  

Local Database Connection

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

  

Slack Connection

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

  

## REST API

Server/DC Feature

Cloud Parity

Parity Notes/Alternatives

Rest API

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

  

## REST Endpoints

Sever/DC Feature

Cloud Parity

Parity Notes/Alternatives

Custom REST Endpoints

**◐**

There are two options to use Custom REST Endpoint functionality:

-   [ScriptRunner Connect](https://docs.adaptavist.com/src/current): You can find the web triggers/webhooks functionality in ScriptRunner Connect via [Generic HTTP Events](https://docs.adaptavist.com/src/current/workspaces/event-listeners/generic-http-events).
-   ScriptRunner for Confluence Cloud: You can use a workaround by creating an [Event Listener](https://docs.adaptavist.com/display/_PK/SR4CC/script-listeners) triggered by an event from an external system.

Future development

Further development for Custom REST Endpoints is being considered by Atlassian. Learn more [from Atlassian here](https://developer.atlassian.com/platform/forge/rest-apis-for-forge-apps/). The two paths are:  

-   Web triggers: For connecting external systems that want to push data into Cloud and be notified of events wiht a fixed output response.
    
-   REST Endpoints: For REST use cases where data is submitted and recieved back, data will be extracted from the host application.
    

## Script Console

Server/DC Feature

Cloud Parity

Parity Notes/Alternatives

Script Console

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![](/files/112159817/386531344/1/1749453095000/sr-icon-cloud.png)Cloud documentation link: [Script Console](https://docs.adaptavist.com/display/_PK/SR4CC/script-console)

The feature functions the same between Data Center and Cloud, but Cloud scripts have a 60-second limitation. When you rewrite your Data Center scripts for Cloud, they must adhere to these limitations.

## Script Editor

Server/DC Feature

Cloud Parity

Parity Notes/Alternatives

Script Editor

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

  

## Script Variables

This feature is only available in ScriptRunner for Confluence Cloud.

## Scripting Features

Server/DC Feature

Cloud Parity

Parity Notes/Alternatives

CQL Autocomplete

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

  

Example Scripts Modal

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![](/files/112159817/386531344/1/1749453095000/sr-icon-cloud.png)Cloud documentation link: [Example Scripts](https://docs.adaptavist.com/display/_PK/SR4CC/example-scripts)

HAPI

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![](/files/112159817/386531344/1/1749453095000/sr-icon-cloud.png)Cloud documentation link: [HAPI](https://docs.adaptavist.com/display/_PK/SR4CC/hapi)

## Search Features

Server/DC Feature

Cloud Parity

Parity Notes/Alternatives

Custom Search Fields

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

In ScriptRunner for Confluence Data Center, this feature was called _Custom Search Extractors_ prior to 7.7.0.

Enhanced Search

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

  

## Settings

Server/DC Feature

Cloud Parity

Parity Notes/Alternatives

Configure Space Admin Built-In Script Permissions

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

  

Enable Anonymous Analytics

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

  

Enable Switch to a Different User Script

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

  

Enable System Admin Only Script Edit Permissions

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

  

Opt Out of In-App Communications

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

  

Space Admin Permissions

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![](/files/112159817/386531344/1/1749453095000/sr-icon-cloud.png)Cloud documentation link: [Built-in Scripts Space Admin Permissions](https://docs.adaptavist.com/display/_PK/SR4CC/settings)
