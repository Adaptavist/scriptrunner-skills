# Release 8.x

- Platform: data-center
- Space: SR4JS
- Hierarchy: release-notes
- Doc ID: doc-sr4js-348418783
- Source: https://docs.adaptavist.com/sr4js/latest/release-notes/release-8-x

Feature Release Summary

You can explore all the feature releases we’ve introduced to ScriptRunner for Jira, starting from version 7.0.0 onwards, on the [Feature Release Summary](https://docs.adaptavist.com/display/_PK/SR4JS/release-summary) page. This page is designed to assist you in finding the ideal version to upgrade to, all while catching up on any enhancements you might have missed since your last update.

Try our migration tools!

The ScriptRunner Migration Suite is a suite of tools that helps you plan, analyse, convert and deploy scripts with confidence, significantly reducing the manual migration effort. It supports (not replaces) your expertise. The suite is made up of three tools: 

-   [ScriptRunner Migration Analyse and Assess Tool](https://docs.adaptavist.com/sms/latest/scriptrunner-migration-suite-web-app/scriptrunner-migration-analyse-and-assess-tool): Use this tool to review your ScriptRunner Data Center scripts and configurations for risks and cloud readiness.
-   [The ScriptRunner Migration Agent](https://docs.adaptavist.com/sms/latest/scriptrunner-migration-suite-web-app/scriptrunner-migration-agent): Use our specialised AI chat agent to create, convert, and optimise scripts, or you can use it to answer a variety of different questions about ScriptRunner.
-   [ScriptRunner Dev and Deployment Tool](https://docs.adaptavist.com/sms/latest/scriptrunner-dev-and-deployment-tool): Use this tool to organise and deploy ScriptRunner Cloud scripts. It is focused on making it easier and faster for consultants and developers to migrate, test, and deploy scripts from ScriptRunner DC to Cloud.

If you have any questions, need help, or would like to request access, the quickest way to get assistance is through our [dedicated support portal](https://the-adaptavist-group-support.atlassian.net/servicedesk/customer/portal/1069/user/login?destination=portal%2F1069).

## 8.66.0

14 Aug 2026 

### Copy Field Value post function bug fixed

We’ve fixed an issue where the **Copy Field Value** post function did not copy values from a parent issue onto a sub-task field (for example, copying **Epic Name** to **Summary**). The post function now correctly updates and re-indexes the target sub-task, and parent/sub-task copies work as expected.

### Fields API visibility bug fixed

We’ve fixed an issue where the `/rest/scriptrunner-jira/1.0/fields` REST endpoint returned the names and IDs of all custom fields in the instance to any authenticated user, including fields outside their normal access. The response is now scoped to only return field metadata that is visible to the calling user.

### Security update

We’ve made targeted security improvements in this release as part of our ongoing hardening work. For more details on how we handle security and vulnerability management, see our [Vulnerabilities and Security](https://docs.adaptavist.com/sr4js/latest/get-started/vulnerabilities-and-security) documentation.

## 8.65.0

04 Aug 2026 

### Third-party dependencies updated to remove CVEs

We’ve updated third‑party dependencies within ScriptRunner to address known CVEs (Common Vulnerabilities and Exposures). These changes are part of our ongoing hardening work and do not indicate that your instance was exposed to security issues. For more details on how we handle security and vulnerability management, see our [Vulnerabilities and Security](https://docs.adaptavist.com/sr4js/latest/get-started/vulnerabilities-and-security) documentation.

## 8.64.0

17 Jul 2026 

### Behaviours loading bug fixed

We’ve fixed an issue where, on some instances, the **Behaviours** admin page failed to load with a 500 error due to XML parser and classloader conflicts. Behaviour configurations are now parsed correctly, and the Behaviours page loads as expected.

### Groovy custom field type-checking bug fixed

We’ve fixed an issue where `GroovyCustomField` could throw type-checking errors when the field value was a collection of non-issue objects (for example, users). The field now correctly handles collections by checking the element types before treating them as issues.

## 8.62.2 (Server only)

26 Jun 2026 

### Security improvement

In this release, we’ve strengthened security around core ScriptRunner endpoints. We’re always working to make ScriptRunner as safe as possible, and this update is part of that ongoing effort.

## 8.62.1

24 Jun 2026 

### Security improvement

In this release, we’ve strengthened security around core ScriptRunner endpoints. We’re always working to make ScriptRunner as safe as possible, and this update is part of that ongoing effort.

## 8.60.0

08 May 2026 

### Script export improvement: saved JQL filters

Saved JQL filters that use ScriptRunner JQL functions are now included in the [Script export](https://docs.adaptavist.com/sr4js/latest/features/script-registry#exporting-your-scripts). These filters are listed in the main **Output.csv** file, and each one is also exported as a .json file in the **jqlFunctionFilters** folder. Saved filters that do not use ScriptRunner JQL functions are excluded from the export.

### Script export bug fixed

We’ve fixed an issue where the [Script export](https://docs.adaptavist.com/sr4js/latest/features/script-registry#exporting-your-scripts) omitted Groovy source files from ScriptRunner script plugins. Plugin-backed scripts are now correctly included in the export.

### Behaviours bug fixed

We’ve fixed an issue where Behaviours mapped to fields (for example, setting **Description** to read-only) would trigger only for the first issue opened from a board. When navigating between issues on a board, the Behaviour now runs reliably for each issue.

## 8.59.0

01 Apr 2026 

### Script export bug fixed

We've fixed an issue with script export where a single invalid workflow (for example, a transition pointing to a nonexistent step) caused workflow configuration export to fail for all workflows, resulting in an `IllegalStateException`/`CacheException`. Export now skips only the invalid workflow and succeeds for the rest.

### JQL custom function bug fixed

We’ve fixed an issue where custom JQL functions were not immediately available on all nodes after being scanned on a single node. Custom JQL functions scanned on one node are now propagated correctly, allowing end users to use them across the entire cluster without additional steps.

## 8.58.0

27 Feb 2026 

### Behaviours bug fixed

We’ve resolved a bug related to Behaviours and Jira quick actions/keyboard shortcuts. Fields set to **read-only** via a server-side Behaviour are now correctly enforced, even when accessed through shortcuts and even if the field has no value. Previously, if a field had no value, it remained editable via shortcuts even when configured as read-only.

### Script Fields bugs fixed

We’ve resolved a bug where Script Fields that return a parent issue could cause a `JsonMarshallingException` when creating subtasks or accessing issues via the REST API. Previously, creating a subtask or requesting an issue JSON in these configurations could result in an error or a broken response, even though the subtask was created successfully.

## 8.57.0

28 Jan 2026 

There are only core component changes in ScriptRunner for Jira 8.57.0, so we do not have any new features or bug fixes to report.

## 8.56.0

11 Dec 2025 

### Instance audit enhancement

We've improved the performance of our [Instance Audit](https://docs.adaptavist.com/sr4js/latest/features/built-in-scripts/instance-audit) feature, ensuring faster and more reliable operation on larger Jira instances.

### Behaviours bug fixed

We’ve resolved an issue where Behaviours did not execute correctly on the full-screen **Create Issue** page (`CreateIssue.jspa`), so field options such as **Issue Type** were not filtered when the project was selected.

## 8.55.0

26 Nov 2025 

### Script export improvements

We've made the following improvements to our [Script export](https://docs.adaptavist.com/sr4js/latest/features/script-registry#exporting-your-scripts) feature:

-   **ScriptRunner metadata is now included**. The export now contains the ScriptRunner version, ScriptRunner app key, and Jira (host application) version. This information is stored in a .json file in the **Instance information** folder.
-   **Legacy and duplicate workflow functions are now exported**. Previously, these workflow functions were not included and would be missing from the export. They now appear alongside all other workflow functions.

### Behaviours bug fixed

We've resolved an issue with the Behaviours feature where our [Dynamic form](https://docs.adaptavist.com/sr4js/latest/best-practices/dynamic-forms) multi-select option did not work as expected.

## 8.54.0

14 Nov 2025

### New feature: Script export is now available for ScriptRunner 8.x

Previously, this built-in script was only compatible with ScriptRunner 9.19+ and 10.0+. 

We've introduced an export feature in ScriptRunner. This feature allows you to export all scripts and configurations from your instance via the Script Registry, with the exception of ScriptRunner JQL function information.

In this context, "scripts" encompass a broader range of elements than typical custom script files. Specifically, we include:

-   All scripts within your [script roots](https://docs.adaptavist.com/sr4js/latest/best-practices/write-code/script-roots).
-   All configured custom and built-in Jobs, Listeners, Fields, Behaviours, UI Fragments, REST Endpoints, Resources, and Workflow functions.
-   Custom fields.

See the [Script Registry](https://docs.adaptavist.com/sr4js/latest/features/script-registry#exporting-your-scripts) page for more information on this feature.

Thinking of migrating to Cloud?

This feature will help you analyze your instance and scripts in preparation for [migration to Cloud](https://docs.adaptavist.com/sr4js/latest/scriptrunner-migration/migrating-to-cloud).

### New feature: Instance Audit built-in script is now available for ScriptRunner 8.x 

Previously, this built-in script was only compatible with ScriptRunner 9.25+ and 10.1+. 

We've created a new built-in script that enables you to quickly assess the current state of your Jira environment for easy cleanup, instance optimization, and migration preparation. You can also use the **Export report** button to download CSV files containing more information on users, projects, custom fields, and workflow functions. See the [Instance Audit](https://docs.adaptavist.com/sr4js/9.x/features/built-in-scripts/instance-audit) documentation for more details. 

![GIF of the instance audit feature](/sr4js/files/latest/348418783/465439068/1/1762774973000/Instance_audit.gif)

### Behaviours bug fixed

We've resolved a conflict between `setFieldOptions` and `setFormValue` for cascading fields in the JSM Portal.

### Security improvement

In this release, we addressed known Common Vulnerabilities and Exposures (CVEs). We want to emphasize that this update doesn't mean your instance was vulnerable to security issues. We're always working to make ScriptRunner as safe as possible, and this update is part of that ongoing effort. Check out our page on [Vulnerabilities and Security](https://docs.adaptavist.com/sr4js/latest/get-started/vulnerabilities-and-security) for more details on how we scan for vulnerabilities and common security concerns.

## 8.53.0

03 Sept 2025 

There are only core component changes in ScriptRunner for Jira 8.53.0, so we do not have any new features or bug fixes to report.

## 8.52.0

20 Aug 2025 

### Switch User feature update

In response to new Atlassian security requirements, we've removed the Switch User function from the User Management page and the user _More_ dropdown. The [Switch User](https://docs.adaptavist.com/sr4js/latest/features/built-in-scripts/switch-user) function is now exclusively available as a built-in script.

### Behaviours bug fixed

We've resolved a bug related to our Behaviours feature where `setFieldOptions` only worked for the last system field when multiple server-side scripts were created for system fields (such as Priority, Affects Version/s, Issue Type, etc.).

### Security improvements

We've made a couple of security improvements in this release:

-   We have implemented a security improvement to our switch user feature. This update strengthens our protection against potential unauthorized account access.

-   We've addressed a known Common Vulnerabilities and Exposures (CVE).

We want to emphasize that this update doesn't mean your instance was vulnerable to security issues. We're always working to make ScriptRunner as safe as possible, and this update is part of that ongoing effort. Check out our page on [Vulnerabilities and Security](https://docs.adaptavist.com/sr4js/latest/get-started/vulnerabilities-and-security) for more details on how we scan for vulnerabilities and common security concerns.

## 8.51.0

23 Jul 2025 

### New documentation: Migration checklist

We've created a [Migration Checklist](https://docs.adaptavist.com/spaces/SR4JS/pages/396296893/.Migration+Checklist+v9.21.0) to help you get started with migration from ScriptRunner for Jira DC to ScriptRunner for Jira Cloud. 

### Bugs fixed

We've resolved multiple bugs in this release:

-   Behaviours bug: Restrictions on the **Priority** field in the JSM portal now function as intended.
-   _Clones an Issue and Links_ post function bug: The author/uploader name is now included on Attachments in cloned issues.

### Security improvement

In this release, we've focused on improving the security of ScriptRunner for Jira by addressing known Common Vulnerabilities and Exposures (CVEs). We want to emphasize that this update doesn't mean your instance was vulnerable to security issues. We're always working to make ScriptRunner as safe as possible, and this update is part of that ongoing effort. Check out our page on [Vulnerabilities and Security](https://docs.adaptavist.com/sr4js/latest/get-started/vulnerabilities-and-security) for more details on how we scan for vulnerabilities and common security concerns.

## 8.49.0

25 Jun 2025 

### Script Registry bug fixed

The Script Registry now correctly displays all workflow functions with scripts for each transition. Previously, only one function was shown per transition, even when multiple were set up.

## 8.48.0

11 Jun 2025 

### Bug fixed: Reindexing error following Portfolio upgrade

We've resolved a bug affecting users with issues created before a Portfolio upgrade. The issue caused errors during reindexing but has now been fixed.

### Security improvement

We've improved the security of ScriptRunner for Jira by addressing a known Common Vulnerabilities and Exposure (CVE). We want to emphasize that this update doesn't mean your instance was vulnerable to security issues. We're always working to make ScriptRunner as safe as possible, and this update is part of that ongoing effort. Check out our page on [Vulnerabilities and Security](https://docs.adaptavist.com/sr4js/latest/get-started/vulnerabilities-and-security) for more details on how we scan for vulnerabilities and common security concerns.

## 8.47.0

28 May 2025 

### Bugs fixed

We have resolved the following bugs in this release:

-   Behaviours bug: We've resolved a bug related to our Behaviours feature where `setFieldOptions()` did not work correctly for Component fields on the JSM portal.
-   Common-runtime module bug: We resolved an issue where ScriptRunner's `common-runtime` module interfered with fields from other plugins.

## 8.46.0

15 May 2025 

### Behaviours bug fixed

We've resolved a bug related to our Behaviours feature. Previously, when used together, `setFieldOptions` clashed with `setFormValue` for multi-select fields. This issue is now resolved. 

### httpmime version update

`httpmime` version has been updated to version 4.5.14 to match the `httpclien`t version. Previously, ScriptRunner for Jira had `httpclient` version 4.5.14 and `httpmime` version 4.3.1.

### Vulnerability scanner updates

We have updated and added new vulnerability scanners to reduce discrepancies in your vulnerability reports. This is an internal feature and does not require any action from you.

## 8.45.0

16 Apr 2025 

There are only core component changes in ScriptRunner for Jira 8.45.0, so we do not have any new features or bug fixes to report.

## 8.44.0

02 Apr 2025 

### Behaviours bug fixed

We've resolved a bug related to our Behaviours feature. This issue affected the setting of values in the JSM portal as `setFieldOptions` clashed with `setFormValue` when used together.

### Active Objects initialization error fixed

When starting or restarting a Jira instance, the following error appeared in some server logs:

```
[com.onresolve.scriptrunner.runner.util.AOPropertyPersister] Exception thrown during AO initialization:
java.lang.IllegalStateException: Unable to register initialization of Active Objects
```

This issue has now been fixed and the above error should no longer display.

### Listeners bugs fixed

We've resolved a number of bugs related to our Listeners feature. ScriptRunner encountered errors when interacting with custom listeners triggered by events from third-party plugins. Specifically, these issues occurred during the creation, modification, or execution of such listeners. Examples of events that caused errors include the following:

-   `ApprovalRequestedEvent` 
    
-   `InsightObjectAsyncEvent` and its subclasses
    
-   `TestExecutionChangedEvent`
    

The bugs that caused the errors are now fixed and custom listeners should now work as expected. 

## 8.43.0

19 Mar 2025 

### Behaviours bug fixed

We've resolved a bug related to our Behaviours feature. This issue affected the setting of field options for cascading fields in the JSM portal.

## 8.42.0

05 Mar 2025

### Behaviours bugs fixed

We've resolved multiple bugs related to our Behaviours feature. These issues affected the setting of values in certain multi-user picker fields, such as Approvers, when using a language other than English. The fields should now work as expected. If you experience any problems, please contact our support team.

### Documentation update: Removal of legacy versions

In the next few weeks, we will be phasing out all 6.x.x and 7.x.x versions of our documentation from public access. While this change is not expected to impact most users, we recommend taking the following actions:

-   Review your bookmarks: If you have any saved links to our documentation, please verify that they don’t point to versions that will be removed.
-   Update your references: Ensure that you’re using the most current documentation version for your needs.

If you have any concerns, please contact our [support team](https://www.scriptrunnerhq.com/help/support).

## 8.41.0

20 Feb 2025 

This has not been released for Server.

### Product update

There are only core component changes in ScriptRunner for Jira 8.41.0, so we do not have any new features or bug fixes to report.

### **Library update: Example scripts have moved to ScriptRunner HQ**

Adaptavist Library has been renamed to [Example Scripts](https://www.scriptrunnerhq.com/help/example-scripts) and all scripts have been moved to their new home on the [ScriptRunner HQ](https://www.scriptrunnerhq.com/) website. These example scripts now live alongside the tutorials, case studies and other content designed to help you get the most from ScriptRunner. For more information, check out our [blog](https://www.scriptrunnerhq.com/inspiration/blog/example-scripts-on-scriptrunner-website) on this update.

This update does not affect in-app example scripts, which will continue to function as usual.

## 8.40.0

05 Feb 2025 

There are only core component changes in ScriptRunner for Jira 8.40.0, so we do not have any new features or bug fixes to report.

## 8.39.0

22 Jan 2025 

### Security improvement

In this release, we've focused on improving the security of ScriptRunner for Jira by addressing a known Common Vulnerabilities and Exposure (CVE). We want to emphasize that this update doesn't mean your instance was vulnerable to security issues. We're always working to make ScriptRunner as safe as possible, and this update is part of that ongoing effort. Check out our page on [Vulnerabilities and Security](https://docs.adaptavist.com/sr4js/latest/get-started/vulnerabilities-and-security) for more details on how we scan for vulnerabilities and common security concerns.

### New: In-app feedback

In this release, we have introduced a new feedback system to improve the way we gather user insights. You may encounter notifications linking to surveys, which offer a convenient method to share your thoughts about the product.

The notifications will not appear:

-   If you've [disabled in-app communications](https://docs.adaptavist.com/sr4js/latest/get-started/settings/in-app-communications) in ScriptRunner.
-   If you're using an evaluation license.
-   If your instance is isolated from the internet. 

## 8.38.0

30 Dec 2024 

### Resources update

We have removed some visibility of passwords within [Resources](https://docs.adaptavist.com/sr4js/latest/features/resources). This change is designed to enhance security by preventing credentials from being viewed by other Jira administrators.

### Security improvement

We've improved the security of ScriptRunner for Jira by addressing known Common Vulnerabilities and Exposures (CVEs). We want to emphasize that this update doesn't mean your instance was vulnerable to security issues. We're always working to make ScriptRunner as safe as possible, and this update is part of that ongoing effort. Check out our page on [Vulnerabilities and Security](https://docs.adaptavist.com/sr4js/latest/get-started/vulnerabilities-and-security) for more details on how we scan for vulnerabilities and common security concerns.

### Behaviours bug fixed

Previously, when customers submitted requests through the customer portal, Behaviours did not function as intended. This issue has been resolved and Behaviours now operate correctly within the customer portal.

## 8.36.0

30 Oct 2024 

**Bugs fixed**

In this release, we focused on fixing bugs to improve your experience of ScriptRunner for Jira Server/Data Center. See the Jira issue in the table below for more detailed information:

-   SRJIRA-7589 - Behaviours is not triggered when clearing the Assets field value (platform 6)

## 8.35.0

17 Oct 2024 

**Bugs fixed**

In this release, we've focused on fixing bugs to improve your experience of ScriptRunner for Jira Server/Data Center. See the Jira issue below for more detailed information.

-   SRPLAT-1209 - Setting REST endpoint package to scan to empty value does not work

## 8.34.0

07 Aug 2024 

### Chrome and Edge v127 Behaviours issue fixed

Google Chrome (v127) and Microsoft Edge (v127) deprecated Mutation Events which impacted several Behaviour methods and caused some Behaviours to break. We have fixed this issue.

**Recommendations**

We recommend you upgrade to ScriptRunner version 8.34.0 where possible. If you are experiencing difficulties but cannot upgrade, workarounds are available. Please reference [SRJIRA-7385](https://assist.adaptavist.com/browse/SRJIRA-7385) or reach out to our [support team](https://the-adaptavist-group-support.atlassian.net/servicedesk/customer/portal/21) who will be happy to assist.

### **Switch user vulnerability fixed**

We have patched a vulnerability related to the _Switch User_ feature.

**New features**

-   SRJIRA-7385 - Mutation Events was deprecated in Edge/Chrome 127 breaking Behaviour

## 8.33.0

25 Jul 2024 

**Bugs fixed**

In this release, we focused on fixing bugs to improve your experience of ScriptRunner for Jira Data Center. For more detailed information, see the Jira issue in the table below.

-   SRJIRA-7047 - MailHandler uses removed constructor for NonQuotedCommentHandler

## 8.32.0

10 Jul 2024 

### Compatibility with Jira 9.17 (with known issue)

We are now compatible with Jira 9.17, however we have a known issue when running ScriptRunner with Jira Service Desk 5.17. An issue may occur if you have a script that amends an Assets custom field and performs an approval. The Assets field will update successfully, however the approval will be unsuccessful. We are working on this issue and you can track our progress [here](https://assist.adaptavist.com/browse/SRJIRA-7356). 

### New: Example script

We've created a new [Example script](https://www.scriptrunnerhq.com/help/example-scripts/set-field-value-from-user-property-behaviours-onPrem) that allows you to set the field value from a user property. You can also find this script through the [Example Scripts](https://docs.adaptavist.com/sr4js/latest/get-started/example-scripts) modal. 

### UI improvement: Workflow functions

We've updated our workflow functions to include the ScriptRunner logo so you can easily identify ScriptRunner workflow functions within Jira. 

![Image showing the scriptrunner logo next to workflow functions](/sr4js/files/latest/348418783/443370465/1/1720178149000/Workflows_logo.png)

**New features**

-   SRJIRA-7280 - Example script (Scripted Fields): Set Field Value From User Property
-   SRJIRA-7187 - ScriptRunner Icon in Workflow Functions List

**Bugs fixed**

In this release, we've also focused on fixing bugs to improve your experience of ScriptRunner for Jira Server/Data Center. See the Jira issues in the table below for more detailed information.

-   SRJIRA-7298 - Behaviour does not work on customer portal if Share With or js-share-with-organisation-picker dropdown shown
    

## 8.31.0

26 Jun 2024

### New: Example scripts

We've created two new [Example scripts](https://www.scriptrunnerhq.com/help/example-scripts) that you can use in your instance:

-   **Set field value from user property using Behaviours**: Use this script in Behaviours to automatically set a custom field value based on the assignee's email.
-   **Search and link issues**: Use this script to search for issues via a JQL query and link them to an issue.

You can also find this script through the [Example Scripts](https://docs.adaptavist.com/sr4js/latest/get-started/example-scripts) modal. 

**New features**

-   SRJIRA-7182 - Example script (Behaviour): Set Field Value From User Property
-   SRJIRA-7181 - Example Script: Search and Link Issues

**Bugs fixed**

In this release, we've also focused on fixing bugs to improve your experience of ScriptRunner for Jira Server/Data Center. See the Jira issues in the table below for more detailed information.

-   SRJIRA-7295 - Fragment Locator "See More Fragments" Button Not Redirecting
-   SRJIRA-3095 - Issue with Exocet integration

## 8.30.0

12 Jun 2024 

**Bugs fixed**

In this release, we've focused on fixing bugs to improve your experience of ScriptRunner for Jira Server/Data Center. See the Jira issues in the table below for more detailed information.

-   SRJIRA-7293 - getBinding()?.customField?.name shows compilation error on Scripted Fields Docs page
-   SRJIRA-6907 - Issue Archiving Job is archiving approximately half the issues in JQL query

## 8.29.0

29 May 2024 

### Compatibility with Jira 9.16.x

ScriptRunner for Jira is now compatible with Jira 9.16.x. ScriptRunner version 8.28.1 is also compatible with Jira 9.16.x.

**Bugs fixed**

In this release, we've also focused on fixing bugs to improve your experience of ScriptRunner for Jira Server/Data Center. See the Jira issue in the table below for more detailed information.

-   SRJIRA-7164 - Setting the Cascade Select List to required doesn't seem to work on JSM

## 8.28.1 

15 May 2024 

### Compatibility with Jira 9.15.x

ScriptRunner for Jira is now compatible with Jira 9.15.x. 

## 8.28.0 

15 May 2024 

**Bugs fixed**

In this release, we focused on fixing bugs to improve your experience of ScriptRunner for Jira Server/Data Center. See the Jira issue in the table below for more detailed information.

-   SRJIRA-7205 - The Server-Side Behaviour doesn't seem to work for the Approver field on the JSM Portal
    

## 8.27.0 

01 May 2024 

### New: Example script

We've created a new [Example script](https://www.scriptrunnerhq.com/help/example-scripts/remove-unused-workflow-schemes-onPrem) that allows you to remove unused workflow schemes. You can also find this script through the [Example Scripts](https://docs.adaptavist.com/sr4js/latest/get-started/example-scripts) modal. 

**New features**

-   SRPLAT-2428 - Update Empty State Images for Dark Mode Compatability
-   SRJIRA-7096 - Add a library script to remove unused workflow schemes

  

**Bugs fixed**

In this release, we've also focused on fixing bugs to improve your experience of ScriptRunner for Jira Server/Data Center. See the Jira issues in the table below for more detailed information.

-   SRJIRA-7159 - disableTab()/enableTab() Methods Affects the Wrong Tab When There are Hidden Tabs
    
-   SRJIRA-6996 - Field(s) required built in validator doesn't work for Attachments on Create transition
    
-   SRJIRA-6853 - Behaviour setFieldOption for multi select elements does not reset to default value
    
      
    

## 8.26.0 

18 Apr 2024 

### Fragments improvements

We have made the following improvements to UI Fragments:

-   Updated the UI so fragment locations appear as buttons.
    
    Currently, this update only applies to UI Fragments that have related binding information. 
    
-   Added the ability to [create a UI fragment directly from fragment locations](https://docs.adaptavist.com/display/_PK/SR4JS/script-fragments#create-from-location) that appear as buttons. 
-   Added the _copy_ function to fragment locations that appear as buttons. 

Your browser does not support the HTML5 video element

### New: Example script

We've created a new Example script that allows you to [remove unused screens](https://www.scriptrunnerhq.com/help/example-scripts/remove-unused-screens-onPrem). You can also find this script through the [Example Scripts](https://docs.adaptavist.com/sr4js/latest/get-started/example-scripts) modal. 

**New features**

-   SRPLAT-2395 - All Users: Enabled Locator: New Button
-   SRJIRA-7156 - UX: Menu item for create multiple fragments
-   SRJIRA-7149 - Create Fragment from Location
-   SRJIRA-7101 - Add library script to remove unused screens

**Bugs fixed**

In this release, we've also focused on fixing bugs to improve your experience of ScriptRunner for Jira Server/Data Center. See the Jira issues in the table below for more detailed information.

-   SRJIRA-7018 - Asset Object actions modules (for Automation for Jira) are not loaded after the system restarts
    
-   SRJIRA-2890 - {CURSOR} tag in template comments can cause the following line break to be selected
    
      
    

## 8.25.0 

08 Apr 2024 

### Fragments improvements

We have made the following improvements to Fragments:

-   Updated the name to UI Fragments to better reflect its purpose. 
-   Updated the UI Fragments view page so your UI fragments are easier to recognize and navigate.

### New: Example scripts

We've created two new example scripts:

-   [Remove unused screen schemes from your instance](https://www.scriptrunnerhq.com/help/example-scripts/remove-unused-screen-schemes-onPrem)
-   [Remove all unused issue type screen schemes](https://www.scriptrunnerhq.com/help/example-scripts/remove-unused-issue-type-screen-schemes-onPrem)

You can also find these scripts through the [Example Scripts](https://docs.adaptavist.com/sr4js/latest/get-started/example-scripts) modal. 

### Documentation update: Improved workflow functions tutorials

We've improved the [Workflow Functions Tutorial](https://docs.adaptavist.com/sr4js/latest/features/workflows/workflow-functions-tutorial) pages with more examples with easy step-by-step instructions. 

**New features**

-   SRPLAT-2415 - Rename "Fragments" to "UI Fragments" in SR tabs section
-   SRJIRA-7100 - Add a library script to remove unused screen schemes
-   SRJIRA-7099 - Add a library script to remove unused issue type screen schemes
-   SRJIRA-7041 - Add last modified/modified by fields to fragments view table

**Bugs fixed**

In this release, we've also focused on fixing bugs to improve your experience of ScriptRunner for Jira Server/Data Center. See the Jira issue in the table below for more detailed information.

-   SRPLAT-2379 - Script Editor layout is broken for Jobs/Listeners/Macros when Expanded and switched from Inline to File
-   SRPLAT-2372 - ExecutionError: java.lang.StackOverflowError
-   SRJIRA-7019 - Behaviour initializer doesn't take effect in the customer portal if an Asset field is mapped to the behaviour

## 8.24.0

20 Mar 2024 

### Fragments update

You can now copy the location path of a fragment from the binding information window when the [fragment locator](https://docs.adaptavist.com/sr4js/latest/features/fragments#fragment-locator) is turned on. Check out our documentation for more information on [script fragment locations](https://docs.adaptavist.com/sr4js/latest/features/fragments/fragment-locations). 

This feature is location-dependent, as not all locations have binding variables associated with them. 

![](/sr4js/files/latest/348418783/443370468/1/1710511900000/Copy_fragment_location.gif)

### New support portal

Our Adaptavist Support Portal moved! Visit the new location [here](https://the-adaptavist-group-support.atlassian.net/servicedesk/customer/portal/21). Please update your bookmarks.

Visit [this page](https://docs.adaptavist.com/log-in-to-the-tag-support-portal) for help logging into the portal.

**New features**

-   SRPLAT-2396 - All Users: Enabled Locator: Binding Information

**Bugs fixed**

In this release, we've focused on fixing bugs to improve your experience of ScriptRunner for Jira Server/Data Center. See the Jira issue in the table below for more detailed information.

-   SRJIRA-6843 - 'Security Level' field default value is not preserved when Behaviour is enable

## 8.23.0

07 Mar 2024 

### Compatibility with Jira 9.14.x

ScriptRunner for Jira is now compatible with Jira 9.14.x. 

**New features**

-   SRJIRA-7074 - Prepare for compatibility with Jira 9.14

**Bugs fixed**

In this release, we've focused on fixing bugs to improve your experience of ScriptRunner for Jira Server/Data Center. See the Jira issue in the table below for more detailed information.

-   SRJIRA-6981 - Behaviour setRequired() message still shows even the Multiple User Picker field has value during creation in Customer Portal
    

## 8.22.0

21 Feb 2024

### Compatibility with Jira 9.13.x

ScriptRunner for Jira is now compatible with Jira 9.13.x. 

### Documentation update: new ScriptRunner JQL AI

If you're not sure where to start with JQL Functions or are in need of a quick search filter, try out our new [ScriptRunner JQL AI](https://docs.adaptavist.com/pages/viewpage.action?pageId=230983407#id-.JQLFunctionsv8.22.0-sr-jql-ai). With this tool, you can simply type in what you would like to search for, and it will provide you with your search in JQL format. 

### Documentation update: new custom script field example

We've created a new custom script field example for you to use and follow. With this custom script field you can [show the work remaining in all issues in an epic](https://docs.adaptavist.com/sr4js/latest/features/script-fields/custom-script-field/custom-script-field-examples#work-remaining-epic).

## 8.21.0

08 Feb 2024 

### Script editor refresh

The [Example Scripts](https://docs.adaptavist.com/sr4js/latest/get-started/example-scripts) modal is now accessible on the _Script Editor_ page using the ![](/sr4js/files/latest/348418783/443370470/1/1706795508000/Example_scripts_button.png) button. In addition, we have moved the _Help_ and _Fullscreen_ buttons so they sit above the code editor for easy accessibility. 

![](/sr4js/files/latest/348418783/443370471/1/1706790412000/Script_editor_refresh.png)

We have also made the type checking dialog more prominent so you can easily see when there is an error with your code. 

**Bugs fixed**

In this release, we've focused on fixing bugs to improve your experience of ScriptRunner for Jira Server/Data Center. See the Jira issues in the table below for more detailed information.

-   SRPLAT-2382 - Errors binding events in 'Send Email' Listener
-   SRPLAT-2366 - Prevent unauthorised user redirection form our SR switchuser-endsession endpoint
-   SRJIRA-7021 - Behaviour Initialiser/Server-side scripts on Customer Portal are not triggered when there's Asset Object field(Multiple OR/AND Option to add all objects enabled)
-   SRJIRA-7015 - setFormValue() Not Working on Asset Field in JSM Portal
-   SRJIRA-6988 - Behaviour read-only on 'Project' field is updatable if clicked on the icon
-   SRJIRA-6983 - Simple asset updates cause Asset Triggers to throw exceptions when a field value changed Automation rule is enabled
-   SRJIRA-6947 - Read-only Asset field still allows delete from field
-   SRJIRA-6919 - Behaviour does not trigger when pressing Asset Object's Add All button in Customer Portal

## 8.20.0

24 Jan 2024 

### New _Duplicate_ feature for Fragments

You can now duplicate a script fragment from a fragment's ellipsis menu. Check out the [Script Fragments](https://docs.adaptavist.com/sr4js/latest/features/fragments#duplicate) page for more information. 

![](/sr4js/files/latest/348418783/443370472/1/1705571690000/Duplicate_fragment_video.gif)

### Vendors API update

We've listened to feedback about our [Vendors API](https://docs.adaptavist.com/sr4js/latest/integrations/vendors-api) and have implemented some changes:

-   We've added support for asynchronous Promises in Vendors API `getValue()`
-   We've added `isPopulated` optional method to API, to determine if the field is populated with data, and inform ScriptRunner of mandatory fields not filled in.

### Documentation update: new _Feature Release Summary_ page

We've created a new [Feature Release Summary](https://docs.adaptavist.com/sr4js/latest/release-notes/feature-release-summary) page, where you can explore all the feature releases we've introduced to ScriptRunner for Jira, starting from version 7.0.0 onwards. This hub is designed to assist you in finding the ideal version to upgrade to, all while catching up on any enhancements you might have missed since your last update.

**New features**

-   SRJIRA-6944 - Duplicate a Fragment

**Bugs fixed**

In this release, we've focused on fixing bugs to improve your experience of ScriptRunner for Jira Server/Data Center. See the Jira issues in the table below for more detailed information.

-   SRJIRA-6995 - Select List (cascading) is not set-able in Customer Portal
-   SRJIRA-6949 - Compilation errors in Custom JQL Function Examples
-   SRJIRA-6939 - Add support for asynchronous Promises in VendorsAPI getValue()
-   SRJIRA-5280 - JQL sorting of key does not work in Issue Picker Script Field

## 8.19.0

10 Jan 2024 

### Compatibility with Jira 9.12.0

We have fixed the bug where users are unable to set values on user multi-picker fields, such as the _Approvers_ field, using Behaviours. ScriptRunner for Jira is now fully compatible with Jira 9.12.0.

**Bug fixed**

-   SRJIRA-6976 - Unable to set values on user multi-picker fields using behaviours in Jira > 9.12.0 in Service Desk context
    

## 8.18.0

13 Dec 2023 

### Compatibility with Jira 9.12.0 (with known bug)

ScriptRunner for Jira is now compatible with Jira 9.12.0. We are aware of a bug where users are unable to set values on the _Approvers_ field using Behaviours. This issue occurs on the Service Desk portal.

If you don't use this functionality, there are no known compatibility issues with ScriptRunner on Jira 9.12.0.

We will endeavor to fix this bug as soon as possible. If you have any issues you believe to be related to this bug, please don’t hesitate to [contact our support team](https://the-adaptavist-group-support.atlassian.net/servicedesk/customer/portal/21).

### Fragment locator update

The fragment locator on the _[Script Fragments](https://docs.adaptavist.com/sr4js/latest/features/fragments)_ page has been updated to a toggle button for better visibility. Previously the locator was a clickable link.

![](/sr4js/files/latest/348418783/443370474/1/1701864350000/Fragment_enable_disable.png)

### New web panel example script

A new example script is available for when you create a [web panel fragment](https://docs.adaptavist.com/sr4js/latest/features/fragments/web-panel). This new script provides you with a simple example of a colored banner. 

![](/sr4js/files/latest/348418783/443370473/1/1701864995000/Example_script.png)

### Documentation update: new _Script Fragments_ tutorial

We have created a new _[Script Fragments](https://docs.adaptavist.com/display/_PK/SR4JS/fragments-tutorial)_ [tutorial](https://docs.adaptavist.com/display/_PK/SR4JS/fragments-tutorial) that guides you through key terms and some easy-to-follow _Script Fragment_ examples. 

**New features**

-   SRJIRA-6955 - Compatibility with Jira 9.12.0
-   SRJIRA-6954 - Update A4J titles
-   SRJIRA-6945 - Make enabling Fragment locator prominent
-   SRJIRA-6943 - Add a snippet to Fragments Script Examples Modal

## 8.17.0

29 Nov 2023 

### **New _Example scripts_ modal**

The _Example scripts_ modal is your go-to destination for finding basic script examples (formerly snippets) and [Example scripts](https://www.scriptrunnerhq.com/help/example-scripts) without having to leave the ScriptRunner app. This modal replaces the **Show snippet** section.

To access this modal, you can select the **Example Scripts** button in any code editor within ScriptRunner. Learn more about this new modal on the [Example Scripts](https://docs.adaptavist.com/sr4js/latest/get-started/example-scripts) page.

![](/sr4js/files/latest/348418783/443370476/1/1700484536000/In+app+Library1920x1080_30fps75pc.gif)

### **Code editor refresh**

In addition to the new _Example Scripts_ modal we have redesigned the code editor so it’s even more user-friendly. We have moved the **Help**, **Expand editor** and **Fullscreen** buttons so they sit above the code editor and are easily accessible. We've also made the type checking dialog more prominent so you can easily see when there is an error with your code. 

![](/sr4js/files/latest/348418783/443370479/1/1698314855000/Code_editor_refresh.png)

### Fragment location removed

The fragment location `null/system.admin.header.pageactions` has been removed. If you update to version 8.17.0 and you're using this location in a fragment, you will need to update the fragment location to s`ystem.admin.header.pageactions`.

### Fragment locator available in more places

You can now enable/disable the fragment locator from within a script fragment. Previously you could only enable/disable the fragment locator from the _Fragments_ feature page. 

![](/sr4js/files/latest/348418783/443370475/1/1701166795000/Fragment_locations.png)

**New features**

-   SRJIRA-6705 - Locator available from create/edit screen

**Bugs fixed**

In this release, we've focused on fixing bugs to improve your experience of ScriptRunner for Jira Server/Data Center. See the Jira issues in the table below for more detailed information.

-   SRJIRA-6931 - Library script breaks when project group permission uses the Anyone on the web group name
-   SRJIRA-6891 - Clean up list of fragment locations
-   SRJIRA-4864 - Configuration Exporter Built-in Script doesn't export Escalation Jobs
-   SRJIRA-4704 - Select2 based fields are not getting disabled on IE11 in ServiceDesk
-   SRJIRA-4175 - Validator "Has not run yet" when using old workflow

## 8.16.0

15 Nov 2023 

### Behaviours bug fixed

We have fixed a bug (SRJIRA-6929) related to the Behaviours mapping issue that has impacted ScriptRunner for Jira versions 8.12.0 to 8.15.0. If you upgrade and encounter any problems with behaviours, please don't hesitate to [contact our support team](https://the-adaptavist-group-support.atlassian.net/servicedesk/customer/portal/21).

### Update: Vendors API

The getting value now works with all fields with our [Vendors API](https://docs.adaptavist.com/sr4js/latest/integrations/vendors-api). Previously this value did not work with some vendor API text fields. 

**Additional bugs fixed**

In this release, we have also focused on fixing bugs to improve your experience of ScriptRunner for Jira Server/Data Center. See the Jira issues in the table below for more detailed information.

-   SRJIRA-6929 - Behaviours Upgrade Task does not adequately clear cache in some instances
    
-   SRJIRA-6842 - The Behaviour is not working for the Cascading List on the Portal page for JSM 5.10.0 and above
    
-   SRJIRA-5694 - Incorrect result in subscription email using search filter with JQL issueFunction in addedAfterSprintStart()
    
-   SRJIRA-5373 - clearError() not working when apply setFieldOptions() on checkbox field
    
-   SRJIRA-53 52 - Behaviour getValue() does not detect value in the field
    
-   SRJIRA-5033 - Mapping issue when applying Readonly on Priority field 
    
-   SRJIRA-4439 - Wrong icon for epic and story types in Behaviours
    
-   SRJIRA-4432 - Behavior's script does not work if one of the field is set to Required in field Configuration
    

## 8.15.0

01 Nov 2023 

### 8.12.1 bug fixed

We are pleased to inform you that we have now resolved the Behaviours mappings bug in version 8.12.1 of ScriptRunner for Jira. Please note:

-   If you have already upgraded to version 8.12.1, or 8.14.0, and your behaviours are functioning properly, you can now proceed with confidence to upgrade to version 8.15.0.
-   However, if you upgraded to version 8.12.1, or 8.14.0, and are still experiencing any issues with your behaviours please contact our support team. We will guide you through resolving this issue.
-   If you have been using ScriptRunner for Jira 8.11.0 or earlier, you should be able to upgrade to 8.15.0 without issue. We have conducted thorough regression testing prior to this release, but if you do encounter any problems with behaviours after the upgrade, please don’t hesitate to [contact our support team](https://the-adaptavist-group-support.atlassian.net/servicedesk/customer/portal/21).

**Additional updates**

-   SRJIRA-5882 Update 'Adding organizations when a Service Management issue gets created' documentation script
    

**Bugs fixed**

In this release, we've focused on fixing bugs to improve your experience of ScriptRunner for Jira Server/Data Center. See the Jira issues in the table below for more detailed information.

-   SRJIRA-6902 - Behaviours ID Migration Upgrade may break mappings due to case sensitivity
    
-   SRJIRA-6855 - Server-side Behaviour scripts are not executing when required Single Select List custom field values are changed in the JSM Service Desk Portal
    
-   SRJIRA-4960 - Some Web Panels are still visible even if the condition is false
    
-   SRJIRA-4002 - Search Template for Database Picker missing
    

## 8.14.0

18 Oct 2023 

8.12.1 Bug Fix Update (1st November 2023)

We are pleased to inform you that we have now resolved the Behaviours mappings bug in version 8.12.1 of ScriptRunner for Jira. For more information please see the the [release notes for 8.15.0](https://docs.adaptavist.com/sr4js/8.15.0/release-notes/release-8-x).

### New: Vendors API

We have developed a new API for Atlassian Marketplace Vendors to use with their custom Jira fields to make them compatible with our DC [Behaviours](https://docs.adaptavist.com/sr4js/latest/features/behaviours) feature. Find out more details on the [Vendors API](https://docs.adaptavist.com/sr4js/latest/integrations/vendors-api) page.

This is not a feature you'll be able to see in the app directly. This feature will let plugin creators define their fields in a ScriptRunner-compatible way which allows your Behaviours to interact with their fields. 

### HAPI breaking changes

We have moved the location of a number of exceptions which may cause a breaking change for you if you have used them in a script. Find out more details in the [HAPI Changelog](https://docs.adaptavist.com/sr4js/latest/release-notes/hapi-changelog#8140). 

### New documentation: Fragment locations

We've created the following new pages on Fragment locations to make it easier for you to understand, and identify, web item and web panel locations:

-   [Script Fragment Locations](https://docs.adaptavist.com/sr4js/latest/features/fragments/fragment-locations)
-   [Web Item Locations](https://docs.adaptavist.com/sr4js/latest/features/fragments/fragment-locations/web-item-locations)
-   [Web Panel Locations](https://docs.adaptavist.com/sr4js/latest/features/fragments/fragment-locations/web-panel-locations)

  

-   SRJIRA-6703 - Improve visibility of fragment locations
-   SRJIRA-2139 - Document setAllowInlineEdit

**Bugs fixed**

In this release, we've focused on fixing bugs to improve your experience of ScriptRunner for Jira Server/Data Center. See the Jira issues in the table below for more detailed information.

-   SRJIRA-6757 - If a project has more than 100 versions, and a Version field is filtered via Behaviour to only display version(s) that are not immediately visible in the Version drop down, e.g. the 101st version, the Version field becomes empty
-   SRJIRA-5525 - Delete action on the scripted workflows page errors on successful deletion
-   SRJIRA-5438 - Behaviour read-only trigger for Projects outside the mapping
-   SRJIRA-5434 - Copied workflow shows the same execution history as source despite changes
-   SRJIRA-5162 - Insight Object/s field not searchable by typing and the position of cursor is indented after setFormValue(null)
-   SRJIRA-3975 - Release page thrown error after enable Fragment Locator
-   SRJIRA-3671 - Create a subtask on post function copying all fields

## 8.12.1

11 Oct 2023 

8.12.1 Bug Fix Update (1st November 2023)

We are pleased to inform you that we have now resolved the Behaviours mappings bug in version 8.12.1 of ScriptRunner for Jira. For more information please see the the [release notes for 8.15.0](https://docs.adaptavist.com/sr4js/8.15.0/release-notes/release-8-x).

We are pleased to inform you that we have now resolved the bug in the Behaviours update task in version 8.12.0 of ScriptRunner for Jira. Please note:

-   If you have already upgraded to version 8.12.0 and your behaviours are functioning properly, you can now proceed with confidence to upgrade to version 8.12.1.
-   However, if you upgraded to version 8.12.0 and are still experiencing any issues with your behaviours please contact our support team. We will guide you through resolving this issue.
-   If you have been using ScriptRunner for Jira 8.11.0 or earlier, you should be able to upgrade to 8.12.1 without issue. We have conducted thorough regression testing prior to this release, but if you do encounter any problems with behaviours after the upgrade, please don’t hesitate to [contact our support team](https://the-adaptavist-group-support.atlassian.net/servicedesk/customer/portal/21).

## 8.12.0

20 Sept 2023 

8.12.1 Bug Fix Update (1st November 2023)

We are pleased to inform you that we have now resolved the Behaviours mappings bug in version 8.12.1 of ScriptRunner for Jira. For more information please see the the [release notes for 8.15.0](https://docs.adaptavist.com/sr4js/8.15.0/release-notes/release-8-x).

### New Automation for Jira actions and triggers (Beta)

We've developed new actions and triggers for you to use in Automation for Jira:

-   [Create Asset (action)](https://docs.adaptavist.com/display/_PK/SR4JS/create-asset)
-   [Update Asset (action)](https://docs.adaptavist.com/display/_PK/SR4JS/update-asset)
-   [Asset Object Created (trigger)](https://docs.adaptavist.com/display/_PK/SR4JS/asset-object-created)
-   [Asset Object Updated (trigger)](https://docs.adaptavist.com/display/_PK/SR4JS/asset-object-updated)

With these actions and triggers, we've provided a simple way for you to work with Assets (Insight) in Automation for Jira rules. 

### Update to Behaviours configuration

We have updated Behaviours to use a new unique identifier. This change mainly impacts users who **migrate behaviours** using the [migration guide](https://docs.adaptavist.com/sr4js/latest/features/behaviours/migrating-behaviours) or a third party tool.

If you upgrade to this release (8.12.0) and migrate Behaviours, you must make sure the Jira version you are migrating the Behaviours to has the same version of ScriptRunner. In addition, if you downgrade after upgrading to 8.12.0, your Behaviours will stop working. As always, we recommend validating upgrades in your test environment first.

**Bugs fixed**

In this release, we've focused on fixing bugs to improve your experience of ScriptRunner for Jira Server/Data Center. See the Jira issues in the table below for more detailed information.

-   SRJIRA-6827 - \`multiValueDelimiter = '<br />'\` causes "Broken custom field" when previewing only
-   SRJIRA-6791 - When a Behaviour Initialiser is added to filter the Issue Picker, it appears that the Parent Link from Advanced Roadmaps is not able to display the linked issue.
-   SRJIRA-5300 - Behaviours' getValue() fails to retrieve Insight Referenced Objects field on Customer Portal
-   SRJIRA-5238 - Behaviour setHelpText is not working when added to a server-side script of a checkbox field
-   SRJIRA-4518 - Simple Scripted Validator - Cascading Selects throws errors
-   SRJIRA-4462 - if you Hide some development-integration locations with the "Hide system or plugin UI element" fragment it breaks the versions page
-   SRJIRA-4122 - When editing an existing ticket changing Cog Configure Field Options from All to Custom vice-versa Causes value in Read-Only field to go missing
-   SRJIRA-3836 - Dialog too small with Database picker

## 8.11.0

07 Sept 2023 

### New Automation for Jira actions (Beta)

We've developed new actions for you to use in Automation for Jira:

-   [Lookup Asset (Insight) Object](https://docs.adaptavist.com/display/_PK/SR4JS/lookup-asset-object)
-   [Lookup Asset (Insight) Objects from AQL (IQL)](https://docs.adaptavist.com/display/_PK/SR4JS/lookup-asset-object-aql)

With these actions, we've provided a simple way for you to work with Assets (Insight) while creating rules in Automation for Jira. 

### **Behaviour bug fixed**

We have fixed a bug ([SRJIRA-6796](https://assist.adaptavist.com/browse/SRJIRA-6796)) that caused our Behaviours feature to work incorrectly in the Jira Service Desk portal when triggering off of a Select list.

**Bugs fixed**

In this release, we've focused on fixing bugs to improve your experience of ScriptRunner for Jira Server/Data Center. See the Jira issues in the table below for more detailed information.

-   SRJIRA-6825 - NPE when using hapi to set a project picker field during issue creation
-   SRJIRA-6804 - On JSM 5.10.1, a Server-Side Behaviour for a List cannot make a hidden field visible or required
-   SRJIRA-6802 - On the JSM 5.10.1, when a Behaviour to filter the Single-Select List is added, it makes the List uneditable and displays like a Multi-Line Text Field
-   SRJIRA-6796 - Behaviour in Servicedesk Portal Jira 9.10 is not working/trigger when the Select List (single/multiple choice) field value changes.
-   SRJIRA-6668 - The Linked Issues field incorrectly triggers behaviours default values warning popup 
-   SRJIRA-5993 - Web Item is not showing nested Web Section 
-   SRJIRA-5610 - setReadOnly not working properly with Visual mode for multiline text field 
-   SRJIRA-5078 - Behaviour setFormValue() doesn’t work for (Wiki Style Renderer) Multi-line Text field if transition made from Kanban Board
-   SRJIRA-5025 - "You have temporary access to administrative functions." link still showing after Switch User from Built-in Script
-   SRJIRA-4579 - Behaviour - database picker field script doesn't run on field changed after multiple refresh page
-   SRJIRA-4244 - When an Issue and its Links are Cloned - Additional issue actions: issue is null 
-   SRJIRA-3825 - autocomplete suggestions appear below the window

## 8.10.0

23 Aug 2023 

### HAPI update

We've developed HAPI updates for retrieving user date information and linking/unlinking issues with the issue type ID. Find out more details in the [HAPI Changelog](https://docs.adaptavist.com/sr4js/latest/release-notes/hapi-changelog#8110). 

**New features**

-   SRJIRA-6671 - Ability to link/unlink with an issue type ID
-   SRJIRA-6622 - HAPI feature request - to be able to get the Application Users creation date

## 8.9.0

09 Aug 2023 

### User interface update to Listeners, Jobs, and Fragments

The **Note** field has been updated to **Name** for Listeners, Jobs, and Fragments. We have also made the **Name** field more prominent on the main pages for Listeners, Jobs, and Fragments, so you can easily identify your configurations. 

**New features**

-   SRPLAT-2297 - Changes to the Notes field

**Bugs fixed**

In this release, we've focused on fixing bugs to improve your experience of ScriptRunner for Jira Server/Data Center. See the Jira issues in the table below for more detailed information.

-   SRJIRA-6651 - Asset Reference Object field in portal does not trigger behavior on value change
-   SRJIRA-5386 - Behaviour Comment field set to required not working properly in Jira Service Management Project when the condition run in specific Workflow action
-   SRJIRA-4452 - Problem in Rendering the Scripted Field on the Dashboard Gadget if Specific Issue Type(s) are selected in the Scripted Field's Custom Field Configuration
-   SRJIRA-4124 - Custom Web Item firing twice when invoked from the Issue Panel on a Kanban board

## 8.8.1

31 Jul 2023

**Bugs fixed**

-   SRJIRA-6787 - 500 errors when both automation for jira and automation for jira lite is installed
-   SRJIRA-5282 - Behaviour hidden function doesn't work initially on comment field
-   SRJIRA-5065 - Incorrect Warning message displayed in when set templates in the description field for two issue types in Visual mode using Behaviour
-   SRJIRA-4727 - Unable to create issue via Confluence if epic link is set to required using simple scripted validator
-   SRJIRA-3742 - Scripted Fields using "Number Field" Template do not show decimal values correctly in French Profiles

## 8.8.0

26 Jul 2023 

### Script plugins update

We've done some work on the infrastructure supporting [script plugins](https://docs.adaptavist.com/sr4js/latest/best-practices/write-code/create-a-script-plugin). As part of this, [resources](https://docs.adaptavist.com/sr4js/latest/features/resources) can now be exported and worked on in a script plugin. We are aiming to get closer to feature completion in the coming months.

### Dynamic forms update

You can use [`optionsGenerator`](https://docs.adaptavist.com/sr4js/latest/best-practices/dynamic-forms#optionsgenerator) within the select list annotation to customize your own list options. This is useful if you can't find a dynamic form annotation that is suitable for your purpose.

### New HAPI code helper

We've added a HAPI code helper, also known as a linter, that detects where your scripts can be simplified with HAPI code and suggests an alternative. Find out more details, and information about how to enable/disable this feature, on the [HAPI Code Helper](https://docs.adaptavist.com/sr4js/latest/get-started/settings/hapi-code-helper) page.

### Documentation update: HAPI examples

We've created multiple new examples that incorporate HAPI in the scripts, ready for you to explore and customize to your Jira instance. Visit the new [HAPI examples](https://docs.adaptavist.com/sr4js/latest/hapi/hapi-examples) page to find out more. 

**Bugs fixed**

-   SRPLAT-2310 - @Select annotation should not default to first option
-   SRPLAT-2309 - allow @Select annotation to take a closure to generate options
-   SRPLAT-2116 - CodeEditor doesn't load because of wrong MIME type
-   SRJIRA-6747 - setOrganizations doesn't have add/remove/replace functionality
-   SRJIRA-3992 - Require a comment on transition validator does not display error message on Service Desk Projects

## 8.7.1

21 Jul 2023 

### Jira compatibility

ScriptRunner for Jira is now compatible with Jira 9.10. 

## 8.7.0

12 Jul 2023 

### Dynamic forms update

The workflow scheme picker field, which allows workflow selection, has been added as a dynamic form field. Check out the [Dynamic Forms](https://docs.adaptavist.com/sr4js/latest/best-practices/dynamic-forms) page for more information. 

### HAPI update

We've developed HAPI updates for using dot notation with Assets/Insight. We have also developed HAPI for working with issue, entity, and user properties. Find out more details in the [HAPI Changelog](https://docs.adaptavist.com/sr4js/latest/release-notes/hapi-changelog#870). 

### Bugs fixed

In this release, we've focused on fixing bugs to improve your experience of ScriptRunner for Jira Server/Data Center. See the Jira issues in the table below for more detailed information.

**New features**

-   SRJIRA-6699 - Making behaviour works on insight field even the current user has no access to the object schema
-   SRJIRA-6678 - Add 'Workflow Scheme Pickers' to Dynamic Forms

**Bugs fixed**

-   SRJIRA-6729 - support dotted notation when retrieving attribute values
-   SRJIRA-6713 - add HAPI propertyset support for AppUser
-   SRJIRA-6468 - Creating issues with constrained create issue dialog no longer triggers page auto-refresh
-   SRJIRA-5512 - Behaviour unable to set a value on a Component field after calling setFieldOptions on it on ScriptRunner 6.30.0+
-   SRJIRA-5376 - Copy project-specific dashboard and filters doesn't copy dashboards
-   SRJIRA-5346 - Using Behaviour, the Warning message gets thrown when switching Issue Type
-   SRJIRA-5150 - Warning flag displayed without switches the project/issue type
-   SRJIRA-4995 - UserMessageUtil does not show flag message on Listener Event "ProjectRoleUpdatedEvent"
-   SRJIRA-4922 - Behaviour setFormValue on the User Picker custom field cause issue creation stuck
-   SRJIRA-4106 - Behavior Cursor Jumping Between Fields

## 8.6.0

28 Jun 2023 

### Dynamic forms update

The permission scheme picker field, which allows scheme selection, has been added as a dynamic form field. Check out the [Dynamic Forms](https://docs.adaptavist.com/sr4js/latest/best-practices/dynamic-forms) page for more information. 

### HAPI update

You can now reindex issues with HAPI. Check out the [Reindex Issues](https://docs.adaptavist.com/sr4js/latest/hapi/reindex-issues) documentation to learn more about reindexing issues.

**New features**

-   SRJIRA-6679 - Add 'Permission Scheme Pickers' to Dynamic Forms
    
-   SRJIRA-5844 - Ability to access the FieldScreenLayoutItemCreatedEvent through via a custom listener
    

### Bugs fixed

In this release, we've focused on fixing bugs to improve your experience of ScriptRunner for Jira Server/Data Center. See the Jira issues in the table below for more detailed information.

**Bugs fixed**

-   SRJIRA-6701 - IssuesIterator toString only works as designed when there are exactly 10 issues
-   SRJIRA-6135 - Built-in Field(s) required condition documentation link not pointing to the correct URL
-   SRJIRA-5851 - setFormValue does not remove manually added issue links
-   SRJIRA-5838 - Column in HTML export for database picker field showing ID instead of selected title
-   SRJIRA-5669 - Behaviour initialiser shows previously edited initialiser script from another Behaviour
-   SRJIRA-5639 - Behaviour setLabel is not working for 'Issue Type' field in edit screen
-   SRJIRA-5638 - Behaviour setFormValue is not working on 'Customer Request Type' field from JSM
-   SRJIRA-5623 - setReadOnly not working properly with Visual mode for Description field
-   SRJIRA-5596 - Fragment for Board Context menu item always fire twice
-   SRJIRA-5479 - When viewing a listener script in full screen, autocomplete suggestion does not appear below cursor
-   SRJIRA-5342 - Web Item Fragment REST Endpoint run twice in Issue detail view
-   SRJIRA-5177 - Read-only userpicker can be edited after set with empty value using Behaviour
-   SRJIRA-4497 - Behaviours display wrong mapping
-   SRJIRA-4369 - Guide example for "Checking sibling subtasks" simple scripted validator is incorrect
-   SRJIRA-4348 - Disabled workflow condition "return false" is true when in "Any of" group
-   SRJIRA-4205 - getValue() return null when a number field value has comma
-   SRJIRA-4084 - Low readability of readonly fields in Chrome, Safari

## 8.5.0

14 Jun 2023 

### New built-in Listener

There is a new **Execution failure notifier** you can use to listen for script execution failures in your instance and to notify you of the failure. Check out the [Execution Failure Notifier](https://docs.adaptavist.com/sr4js/latest/features/listeners/built-in-listeners/execution-failure-notifier) page for more information.

### HAPI update

We've developed HAPI updates for creating an issue and Assets. Find out more details in the [HAPI Changelog](https://docs.adaptavist.com/sr4js/latest/release-notes/hapi-changelog#850). 

### Bugs fixed

In this release, we've focused on fixing bugs to improve your experience of ScriptRunner for Jira Server/Data Center. See the Jira issues in the tables below for more detailed information.

**New Features**

-   SRJIRA-6670 - Ability to create an issue with issue type ID

  

**Bugs Fixed**

-   SRPLAT-2116 - CodeEditor doesn't load because of wrong MIME type
-   SRJIRA-6683 - ability to count the results of an Assets AQL/IQL query efficiently
-   SRJIRA-6681 - retrieving custom fields for @CustomFieldPicker is very slow
-   SRJIRA-6674 - Inline edit of IssueType or Label field with Behaviour doesn't switch to appropriate tab in edit screen
-   SRJIRA-6672 - myProjects JQL function does not see uptodate role info due to Jira bug
-   SRJIRA-6278 - "Clones an issue, and links" Listener bypasses required fields
-   SRJIRA-6210 - Insight custom field (multiple) read-only not working
-   SRJIRA-6092 - Getting error when using 'Constrained create issue dialog' in Board Issue detail view
-   SRJIRA-5704 - Script Listener event classes not recognized in Script Registry cause false checkerrors
-   SRJIRA-5686 - Behaviour "secure/CreateIssueDetails.jspa" screen error, stops behaviour(s) from loading
-   SRJIRA-4407 - Restricting Issue Type does not work on pop-up create screen
-   SRJIRA-4276 - Restricting issue Types with behaviours impacts "Move" Issue page when you choose a different Project

## 8.4.0

01 Jun 2023 

### Documentation updates

We've identified another breaking change in Groovy 4 that can impact those who use the `@Grab` annotation to import certain external libraries. The [Groovy 4 Breaking Change for Grab Annotations](https://docs.adaptavist.com/sr4js/latest/release-notes/breaking-changes/groovy-4-breaking-change-for-grab-annotations) page has more information on this breaking change and solutions on how to fix it. 

[Visit the new Vulnerabilities and Security](https://docs.adaptavist.com/sr4js/latest/get-started/vulnerabilities-and-security) to inform you on how we scan for vulnerabilities and common security concerns.  

### New bugs fixed

In this release, we've focused on fixing bugs to improve your experience of ScriptRunner for Jira Server/Data Center. See the Jira issues in the table below for more detailed information.

**Bugs Fixed**

-   SRPLAT-2293 - reduce number of files written to classes directory
-   SRPLAT-2234 - Empty result set in Local DB connection test return NullPointerException
-   SRJIRA-6645 - SQL result shows "null" after clicking the "Preview" button
-   SRJIRA-6606 - Slow load times when clicking on issues after searching
-   SRJIRA-6553 - Script file is not changed if user does not click outside of the field
-   SRJIRA-6496 - Inconsistent override warning flag behaviours when conditioned on a select field
-   SRJIRA-6493 - Select list conversion behaviour convertToSingleSelect not clearing the field
-   SRJIRA-6481 - Behaviours can't set values of single-select lists that use the autocompleterenderer
-   SRJIRA-6456 - Calling Behaviour methods on 'Issue Type' system field will not disable its inline editing
-   SRJIRA-6355 - Components setFormValue is not working properly with huge Components list
-   SRJIRA-6287 - Error on method builder() while using data (Third party app: Extension for Jira Service Management) from Bundled Fields with Script Console
-   SRJIRA-5161 - Using behaviour to set field to be read-only, required and with help text causes error
-   SRJIRA-5144 - Behaviour setRequired does not work if field's display name on Customer Portal has double quotation marks
-   SRJIRA-4108 - Database Picker doesn't work in JSD Portal when the zoom is applied
-   SRJIRA-3631 - StoreException is thrown with Behaviour in the Comment field for JSD
-   SRJIRA-3493 - Limiting Issue Types with behaviour does not work for several browsers
-   SRJIRA-2830 - Using Quick Actions/Keyboard Shortcuts (e.g: "." or "gg") circumvents the Read-Only attributes of Behaviours
-   SRJIRA-2735 - Attempted inline edit of field with behaviour opens edit screen but doesn't switch to appropriate tab

## 8.3.0

17 May 2023 

### HAPI update

You can now update comments using HAPI. Check out the [Work with Comments](https://docs.adaptavist.com/sr4js/latest/hapi/work-with-comments) page to learn more about what you can do with comments.

### Snippets are now available for a custom script field

You will now see snippets when adding or updating a [custom script field](https://docs.adaptavist.com/sr4js/latest/features/script-fields/custom-script-field). You can use these snippets to help you develop a script for a script field.

![](/sr4js/files/latest/348418783/443370469/1/1710258116000/Scripted_field_snippets.gif)

### New bugs fixed

In this release, we've focused on fixing bugs to improve your experience of ScriptRunner for Jira Server/Data Center. See the Jira issues in the table below for more detailed information.

**New Features**

-   SRJIRA-6545 - Updates for comments

**Bugs Fixed**

-   SRJIRA-6571 - Inconsistent setFormValue on Text Fields with Text Effects
-   SRJIRA-6560 - Keyboard shortcuts are enabled even when a Custom Web Item AUI dialog is open
-   SRJIRA-6273 - Close brackets are missing in Docs Script Field Example Script 
-   SRJIRA-5435 - Fix Version/s field that has been set as read-only via Behaviour remain editable

## 8.2.1

04 May 2023 

**Bugs Fixed**

-   SRPLAT-2289 - The 'Script Root' window in Script Editor cannot vertically scroll at version 8.0.0
-   SRJIRA-6608 - STC error shows for valid arguments with Multi Select fields

## 8.2.0

03 May 2023 

### New bugs fixed

In this release, we've focused on fixing bugs to improve your experience of ScriptRunner for Jira Server/Data Center. See the Jira issues in the table below for more detailed information.

**Bugs Fixed**

-   SRPLAT-2280 - Spread operator shows STC errors for varargs methods
    
-   SRJIRA-6640 - Read Only Component still allows delete from field
    
-   SRJIRA-6629 - Workflow crashing when you cancel on edit workflow screen
    
-   SRJIRA-6605 - Behaviour for a Multi Picker field still allows you to delete values with Read Only enabled
    
-   SRJIRA-6599 - Behaviours server-side script automatically set Priority field value
    
-   SRJIRA-6494 - Readonly Labels Field can be modified
    
-   SRJIRA-6477 - Behaviour Priority setFieldOptions changes the existing value in Edit Screen
    
-   SRJIRA-6467 - setError() do not persists if user move away from Edit screen (Issue Detail View)
    
-   SRJIRA-6215 - Custom Picker set to Multiple Option returns a NullPointerException if the options are cleared from the view screen.
    

## 8.1.0

19 Apr 2023 

### HAPI update

We've developed HAPI updates for comments and Assets. We've also simplified some examples for accessing links or attachments during a workflow transition. Find out more details in the [HAPI Changelog](https://docs.adaptavist.com/sr4js/latest/release-notes/hapi-changelog#810). 

### New bugs fixed

In this release, we've focused on fixing bugs to improve your experience of ScriptRunner for Jira Server/Data Center. See the Jira issues in the tables below for more detailed information.

**New Features**

-   SRJIRA-6546 - Ability to delete a comment

**Bugs Fixed**

-   SRPLAT-2282 - 3.0.1-b10 version of javax.el has CVE
    
-   SRPLAT-2281 - IllegalAccessException within DiagnosticsExecutionHandlerImpl
    
-   SRPLAT-2278 - Remove the errors if the script executes successfully
    
-   SRPLAT-2274 - allow rest endpoints to handle file uploads
    
-   SRJIRA-6614 - Behaviours: Using a server-side script on the Priority field to set the priority field causes an infinite loop
    
-   SRJIRA-6604 - type-safe way of retrieving Assets attribute values
    
-   SRJIRA-6570 - Execution history for Workflow scripts is not showing in the Workflow view
    
-   SRJIRA-6314 - Behaviours stopped react to Insight Fields on Customer Portal with JSM 5.2.0
    
-   SRJIRA-6165 - Behaviour does not set Insight Field as ReadOnly in Customer Portal
    

## 8.0.0

05 Apr 2023 

### Groovy 4 update

We have updated ScriptRunner for Jira Server/Data Center to Groovy 4!

Our primary motivator for this update is to provide support for JDK 17. Groovy 3 doesn't support JDK 17, and with Jira 9.5.0 and Confluence 8.0 being JDK 17 compatible, an upgrade to Groovy 4 is necessary.

So, apart from JDK 17 compatibility, what comes with this update and how will it benefit you? 

#### New features in Groovy 4

The following are the most significant new features that have been added in Groovy 4 :

-   [Switch expressions](https://groovy-lang.org/releasenotes/groovy-4.0.html#Groovy4.0-switch-expressions) which, unlike switch statements, are optimised towards branches that handle one case and break out rather than fall through to the next case.
-   [Sealed types](https://groovy-lang.org/releasenotes/groovy-4.0.html#Groovy4.0-sealed-types)
-   [Records](https://groovy-lang.org/releasenotes/groovy-4.0.html#Groovy4.0-new-records)
-   [Ranges have been enhanced](https://groovy-lang.org/releasenotes/groovy-4.0.html#_enhanced_ranges) with support for ranges open on the left, for example, `3<..5`, or both sides, for example, `0<..<3`
-   [Support for annotating generic types](https://groovy-lang.org/releasenotes/groovy-4.0.html#_jsr308_improvements_incubating), for example `List<@IntRange(min = 0, max = 10) Integer>`

Please have a look at the [Groovy 4 Release Notes](https://groovy-lang.org/releasenotes/groovy-4.0.html) for a complete list of new features.

#### Breaking changes in Groovy 4

Groovy 4 contains a number of breaking changes. The ones which are the most significant, and likely to affect ScriptRunner users, are listed below. Please have a look at the [Groovy 4 Release Notes](https://groovy-lang.org/releasenotes/groovy-4.0.html) for a complete list of breaking changes.

##### 1) Changes to the resolution of properties with both a getter and isser returning different types

An isser is a method to retrieve boolean properties. Instead of the method name starting with `get` (as is common for accessor methods), it starts with `is`. See [the JavaBean Properties tutorial](https://docs.oracle.com/javase/tutorial/javabeans/writing/properties.html) for more information.

For properties that have a getter and an isser returning different types (for example, [JiraAuthenticationContext#getLoggedInUser](https://docs.atlassian.com/software/jira/docs/api/latest/com/atlassian/jira/security/JiraAuthenticationContext.html#getLoggedInUser--) and [JiraAuthenticationContext#isLoggedInUser](https://docs.atlassian.com/software/jira/docs/api/latest/com/atlassian/jira/security/JiraAuthenticationContext.html#isLoggedInUser--)) when accessing the property, instead of calling one of the methods (for example, `jiraAuthenticationContext.loggedInUser`), the getter is called in Groovy 3 but the isser is called in Groovy 4 - see [GROOVY-10821](https://issues.apache.org/jira/projects/GROOVY/issues/GROOVY-10821). You don't need to worry about updating scripts with the `loggedInUser` property on `JiraAuthenticationContext` as we have included a patch (see more below).

###### ScriptRunner for Jira patch

For backward compatibility reasons, ScriptRunner ships with a patch to keep the old Groovy 3 behaviour for two conflicting Jira API properties commonly used in customer scripts:

-   The `loggedInUser` property on `JiraAuthenticationContext` 
-   The `created` property on `Issue`

We've included this patch as these properties will likely be heavily used in users' scripts. This means you do not need to change any code using these properties.

###### Solution for other properties

From Groovy 4 if you have custom classes, or are using external classes that implement conflicting isser and getter methods, and you are using the property syntax to get the getter value, you must re-write the logic to use the getter method directly.  

For example, this class demonstrates conflicting isser and getter methods:  

```
class GetterIsser {
  String getSomething() { 'yes' }
  boolean isSomething() { false }
}
 
def myClass = new GetterIsser()
 
myClass.something // used to return 'yes', as of Groovy 4 will return false
```

From Groovy 4, this should be written as:

```
class GetterIsser {
  String getSomething() { 'yes' }
  boolean isSomething() { false }
}
 
def myClass = new GetterIsser()
 
myClass.getSomething() // will return 'yes'
```

##### 2) Legacy package removal

Groovy 3 provided duplicate versions of numerous classes (in old and new packages) to allow Groovy users to migrate towards the new [JPMS](https://www.oracle.com/corporate/features/understanding-java-9-modules.html) compliant package names - see [the section about it in Groovy 3 Release Notes](http://groovy-lang.org/releasenotes/groovy-3.0.html#Groovy3.0releasenotes-Splitpackages) for more details. Groovy 4 no longer provides the duplicate legacy classes.

For backwards compatibility reasons ScriptRunner still ships with deprecated version of `groovy.util.XmlSlurper` and `groovy.xml.XmlParser`. **We recommend you don't use these legacy classes going forward and use their equivalents that can be found in `groovy.xml` package.**

##### 3) Changes related to how Groovy code accesses private fields from within closures

Groovy developers are currently attempting to improve how its code accesses private fields in certain scenarios, where such access is expected but problematic. For example, within closure definitions where subclasses or inner classes are involved ([GROOVY-5438](https://issues.apache.org/jira/browse/GROOVY-5438)). You may notice breakages in Groovy 4 code in such scenarios until they fix this issue.

##### 4) Change to `intersect`() default Groovy method

`intersect()` default Groovy method used to draw elements from the second argument passed to it, but now it draws elements from the first argument passed to it - see [GROOVY-10275](https://issues.apache.org/jira/browse/GROOVY-10275).

##### 5) Error message for users using `@Grab` to import certain libraries

There has been a breaking change for users using `@Grab` to import certain libraries. Check out the [Groovy 4 Breaking Change for Grab Annotations](https://docs.adaptavist.com/sr4js/latest/release-notes/breaking-changes/groovy-4-breaking-change-for-grab-annotations) page for more information on this breaking change and solutions on how to fix it. 

### Deprecated SrSpecification class removed

Authors of [Script Plugins](https://docs.adaptavist.com/sr4js/latest/best-practices/write-code/create-a-script-plugin) may be used to writing tests which extend the deprecated `com.onresolve.scriptrunner.canned.common.admin.SrSpecification` class. This class has been removed. Authors of tests for their scripts should extend the `spock.lang.Specification` class directly. The [Test Runner Built-in Script](https://docs.adaptavist.com/sr4js/latest/best-practices/write-and-run-tests#running-tests) should still pick up tests as normal.

### HAPI update

We've made a breaking change related to retrieving the customer request type. Find out more details in the [HAPI Changelog](https://docs.adaptavist.com/sr4js/latest/release-notes/hapi-changelog#800). 

**New Features**

-   SRPLAT-2179 - Support for JDK 17

**Bugs Fixed**

-   SRPLAT-2267 - Marking closing bracket in editor not working
    
-   SRPLAT-2262 - The last couple of lines are not visible when the code editor is in the maximised mode
    
-   SRJIRA-6582 - cannot get customer request type name
    
-   SRJIRA-6581 - attribute name completions missing from \`asset.getAttributeValue\`
    
-   SRJIRA-6548 - HAPI workflow validation errors are being suppressed
    
-   SRJIRA-6442 - Database/LDAP Picker shows an error when the projects are filtered in the Context and the user has no Browse Projects permission for that project
