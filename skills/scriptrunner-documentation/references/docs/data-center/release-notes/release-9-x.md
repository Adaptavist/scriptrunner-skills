# Release 9.x

- Platform: data-center
- Space: SR4JS
- Hierarchy: release-notes
- Doc ID: doc-sr4js-273486314
- Source: https://docs.adaptavist.com/sr4js/latest/release-notes/release-9-x

Feature Release Summary

You can explore all the feature releases we’ve introduced to ScriptRunner for Jira, starting from version 7.0.0 onwards, on the [Feature Release Summary](https://docs.adaptavist.com/display/_PK/SR4JS/release-summary) page. This page is designed to assist you in finding the ideal version to upgrade to, all while catching up on any enhancements you might have missed since your last update.

Try our migration tools!

The ScriptRunner Migration Suite is a suite of tools that helps you plan, analyse, convert and deploy scripts with confidence, significantly reducing the manual migration effort. It supports (not replaces) your expertise. The suite is made up of three tools: 

-   [ScriptRunner Migration Analyse and Assess Tool](https://docs.adaptavist.com/sms/latest/scriptrunner-migration-suite-web-app/scriptrunner-migration-analyse-and-assess-tool): Use this tool to review your ScriptRunner Data Center scripts and configurations for risks and cloud readiness.
-   [The ScriptRunner Migration Agent](https://docs.adaptavist.com/sms/latest/scriptrunner-migration-suite-web-app/scriptrunner-migration-agent): Use our specialised AI chat agent to create, convert, and optimise scripts, or you can use it to answer a variety of different questions about ScriptRunner.
-   [ScriptRunner Dev and Deployment Tool](https://docs.adaptavist.com/sms/latest/scriptrunner-dev-and-deployment-tool): Use this tool to organise and deploy ScriptRunner Cloud scripts. It is focused on making it easier and faster for consultants and developers to migrate, test, and deploy scripts from ScriptRunner DC to Cloud.

If you have any questions, need help, or would like to request access, the quickest way to get assistance is through our [dedicated support portal](https://the-adaptavist-group-support.atlassian.net/servicedesk/customer/portal/1069/user/login?destination=portal%2F1069).

## 9.41.0

14 Aug 2026 

### Copy Field Value post function bug fixed

We’ve fixed an issue where the **Copy Field Value** post function did not copy values from a parent issue onto a sub-task field (for example, copying **Epic Name** to **Summary**). The post function now correctly updates and re-indexes the target sub-task, and parent/sub-task copies work as expected.

### Fields API visibility bug fixed

We’ve fixed an issue where the `/rest/scriptrunner-jira/1.0/fields` REST endpoint returned the names and IDs of all custom fields in the instance to any authenticated user, including fields outside their normal access. The response is now scoped to only return field metadata that is visible to the calling user.

### Security update

We’ve made targeted security improvements in this release as part of our ongoing hardening work. For more details on how we handle security and vulnerability management, see our [Vulnerabilities and Security](https://docs.adaptavist.com/sr4js/latest/get-started/vulnerabilities-and-security) documentation.

## 9.40.0

04 Aug 2026 

### Database Picker validation bug fixed

We’ve fixed an issue where Database Picker fields could not be previewed or saved when using stricter JDBC drivers (for example, Databricks JDBC v3), causing `INVALID_PARAMETER_MARKER_VALUE.INVALID_DATA_TYPE` errors. Database Picker validation now binds parameters in a driver‑compatible way, so fields can be created and previewed successfully with these drivers.

### Behaviours cascading select bug fixed

We’ve fixed an issue where JSM cascading select fields controlled by Behaviours could intermittently fail to set child values or update dependent fields after a parent change. Cascading selects now update reliably when the parent value changes.

### Third-party dependencies updated to remove CVEs

We’ve updated third‑party dependencies within ScriptRunner to address known CVEs (Common Vulnerabilities and Exposures). These changes are part of our ongoing hardening work and do not indicate that your instance was exposed to security issues. For more details on how we handle security and vulnerability management, see our [Vulnerabilities and Security](https://docs.adaptavist.com/sr4js/latest/get-started/vulnerabilities-and-security) documentation.

## 9.39.0

17 Jul 2026 

### Behaviours loading bug fixed

We’ve fixed an issue where, on some instances, the **Behaviours** admin page failed to load with a 500 error due to XML parser and classloader conflicts. Behaviour configurations are now parsed correctly, and the Behaviours page loads as expected.

### Groovy custom field type-checking bug fixed

We’ve fixed an issue where `GroovyCustomField` could throw type-checking errors when the field value was a collection of non-issue objects (for example, users). The field now correctly handles collections by checking the element types before treating them as issues.

### Execution history status colours bug fixed

We’ve fixed an issue where execution history entries showed blue/grey icons instead of green for success and red for failure. Execution history now displays the correct status colours again.

## 9.37.0

01 Jul 2026 

### Performance groundwork for web fragments

We’ve made internal improvements to how ScriptRunner refreshes web fragments in Jira 10, laying the foundation for better performance on large clustered instances. These changes are behind the scenes and do not alter existing behaviour for customers. See the [Troubleshooting Fragments](https://docs.adaptavist.com/sr4js/latest/get-help/troubleshooting/troubleshooting-fragments) page for more details. 

## 9.36.1

26 Jun 2026 

### App enablement bug fixed

We’ve fixed an issue where ScriptRunner was disabled for some users after upgrading, and only became enabled again after clearing the plugin cache and restarting Jira. This was caused by a logging configuration problem and is unrelated to the previous security upgrade.

## 9.36.0

24 Jun 2026 

### Security improvement

In this release, we’ve strengthened security around core ScriptRunner endpoints. We’re always working to make ScriptRunner as safe as possible, and this update is part of that ongoing effort.

### Reduced ClassNotFoundException logging 

We’ve fixed an issue where `ClassNotFoundException` messages for `com.atlassian.jira.search.issue.index.indexers.FieldIndexer` were written to the Jira logs when accessing ScriptRunner. These unnecessary log entries are no longer produced, making log files cleaner and easier to analyse.

### ScriptRunner samples REST endpoint bug fixed

We’ve fixed an issue where installing the latest `adaptavistlabs/scriptrunner-samples` on Jira 10 could fail to create the `rest/scriptrunner/latest/custom/currentTime` REST endpoint as defined in `scriptrunner.yaml`, particularly on clustered instances. The sample REST endpoint now installs and registers correctly on Jira 10.

## 9.34.0

08 May 2026 

### Script export improvement: saved JQL filters

Saved JQL filters that use ScriptRunner JQL functions are now included in the [Script export](https://docs.adaptavist.com/sr4js/latest/features/script-registry#exporting-your-scripts). These filters are listed in the main **Output.csv** file, and each one is also exported as a .json file in the **jqlFunctionFilters** folder. Saved filters that do not use ScriptRunner JQL functions are excluded from the export.

### Script export bug fixed

We’ve fixed an issue where the [Script export](https://docs.adaptavist.com/sr4js/latest/features/script-registry#exporting-your-scripts) omitted Groovy source files from ScriptRunner script plugins. Plugin-backed scripts are now correctly included in the export.

### Behaviours bug fixed

We’ve fixed an issue where certain Behaviours saved in older ScriptRunner versions (using a `<parameters>{}</parameters>` configuration) caused the Behaviours page to fail to load after upgrading to Jira 10. These legacy configurations are now handled correctly during upgrade, so the Behaviours page loads as expected without requiring manual edits.

### HAPI bug fixed

We’ve fixed an issue in Jira Service Management where HAPI sometimes resolved request types using the service desk ID instead of the portal ID. In projects where these IDs differ, this could result in request types from the wrong project being displayed when setting or suggesting a **Request Type**. Request types are now consistently resolved by portal ID, ensuring the correct project’s request types are used.

## 9.33.0

01 Apr 2026 

### Script export bug fixed

We've fixed an issue with script export where a single invalid workflow (for example, a transition pointing to a nonexistent step) caused workflow configuration export to fail for all workflows, resulting in an `IllegalStateException`/`CacheException`. Export now skips only the invalid workflow and succeeds for the rest.

### JQL custom function bug fixed

We’ve fixed an issue where custom JQL functions were not immediately available on all nodes after being scanned on a single node. Custom JQL functions scanned on one node are now propagated correctly, allowing end users to use them across the entire cluster without additional steps.

### Behaviours bug fixed

We’ve fixed an issue where Behaviours that dynamically filter the **Issue Type** field (for example, to hide certain parent types in specific projects) caused an error on the **Create Issue** dialog when opened from a board. Behaviours that modify the Issue Type field during initialisation now work correctly without triggering this error.

## 9.32.0

27 Feb 2026 

### Behaviours bugs fixed

We’ve resolved multiple bugs related to our Behaviours feature:

-   Behaviours now execute correctly when creating issues via the `.../secure/CreateIssue.jspa` URL. Previously, changing a project on this URL did not trigger a Behaviour correctly.
    
-   Fields set to **read-only** via a server-side Behaviour are now correctly enforced when accessed using Jira quick actions/keyboard shortcuts (`gg` or `.`). Previously, if a field had no value, it remained editable via shortcuts even when configured as read-only.
    

### Scripted picker fields bug fixed

We’ve resolved a bug affecting scripted picker fields used in the Pie Chart gadget. Scripted pickers (such as Database Picker or Issue Picker fields) can now be used as the gadget’s statistic type without errors. Previously, configuring a Pie Chart to use these fields caused the gadget to fail to load, displaying an error instead of the chart.

## 9.31.0

11 Feb 2026 

### Script Fields bugs fixed

We've resolved multiple bugs related to our [Script Fields](https://docs.adaptavist.com/sr4js/latest/features/script-fields) feature:

-   Script Fields using the **Duration** template now correctly display the formatted duration value. Previously, the literal text `$DateUtils.formatDurationPretty($value)` was shown instead of the actual duration.
    
-   Calculated Script Fields using the **Issue(s)** template and **Issue Key** searcher can now return multiple `Issue` objects as expected. Previously, ScriptRunner threw a `MissingMethodException` when a collection of issues was returned, and the field was accessed via the REST API, preventing the field from rendering.
    
-   Script Fields using the **Issue(s)** template that return a parent issue no longer cause errors when creating a sub-task, even when no searcher is configured. Previously, creating a sub-task in this scenario displayed an error message resembling a loop, although the sub-task was created successfully.
    
-   Script Fields that return a parent issue no longer cause a `JsonMarshallingException` when creating a sub-task, even if the field has a global context and is not added to any screens. Previously, creating a sub-task resulted in this error, but the sub-task was created successfully.
    

## 9.30.0

28 Jan 2026 

There are only core component changes in ScriptRunner for Jira 9.30.0, so we do not have any new features or bug fixes to report.

## 9.29.0

11 Dec 2025 

### Instance audit enhancement

We've improved the performance of our [Instance Audit](https://docs.adaptavist.com/sr4js/latest/features/built-in-scripts/instance-audit) feature, ensuring faster and more reliable operation on larger Jira instances.  

## 9.28.0

26 Nov 2025 

### Script export improvements

We've made the following improvements to our [Script export](https://docs.adaptavist.com/sr4js/latest/features/script-registry#exporting-your-scripts) feature:

-   **ScriptRunner metadata is now included**. The export now contains the ScriptRunner version, ScriptRunner app key, and Jira (host application) version. This information is stored in a .json file in the **Instance information** folder.
-   **Legacy and duplicate workflow functions are now exported**. Previously, these workflow functions were not included and would be missing from the export. They now appear alongside all other workflow functions.

## 9.27.0

14 Nov 2025 

### Instance audit bugs fixed

We have resolved bugs related to our [Instance Audit](https://docs.adaptavist.com/sr4js/latest/features/built-in-scripts/instance-audit) feature:

-   The **App custom fields** count displays correctly in the audit summary. Previously, the **App custom fields** count did not display as expected.
-   The **Export Report** button creates a download file as expected. Previously, in some unique instances of Jira, this button did not generate a CSV download file.  

### Script export bugs fixed

We've resolved the multiple bugs related to our [Script export](https://docs.adaptavist.com/sr4js/latest/features/script-registry#exporting-your-scripts) feature:

-   The **Export active scripts Only** option now works as expected for all features. Previously, it did not export behaviours and listeners as expected. 
-   Resource names now display in the export. Previously, the names of resources did not display. 

## 9.26.0

29 Oct 2025 

### Behaviours bugs fixed

We've resolved the multiple bugs related to our Behaviours feature:

-   The `setFormValue()` function now works correctly in the JSM portal for select lists. Previously, this function did not set the value as expected. 
-   The **Readonly** option for fields now works as expected. Previously, field options could be deleted even when the field was set to read-only. 

### Database picker bug fixed

We've resolved a bug related to our _Database Picker_ script field. Multi-select database picker fields now properly display selected values in column view, ensuring consistent rendering across all view types.

## 9.25.0

08 Oct 2025 

### New Instance Audit built-in script

We've created a new built-in script that enables you to quickly assess the current state of your Jira environment for easy cleanup, instance optimization, and migration preparation. You can also use the **Export report** button to download CSV files containing more information on users, projects, custom fields, and workflow functions. See the [Instance Audit](https://docs.adaptavist.com/sr4js/9.x/features/built-in-scripts/instance-audit) documentation for more details. 

![GIF of the instance audit feature](/sr4js/files/latest/273486314/448135356/1/1759221162000/Instance_audit.gif)

This built-in script is currently compatible with ScriptRunner 9.25+ (for Jira 10/Platform 7). It is not yet available for ScriptRunner 10.x (which is compatible with Jira 11/Platform 8). We are working on compatibility and will provide an update when it becomes available.

## 9.24.0

03 Sept 2025 

There are only core component changes in ScriptRunner for Jira 9.24.0, so we do not have any new features or bug fixes to report.

### **Advanced Notice for Documentation Versions Removal**

On September 17, 2025, we will be removing legacy versions of the documentation. This change is part of our efforts to simplify the customer experience and align with wider industry practices. From September 17 onward, there will be two versions of documentation:

-   The previous version: As of September 17, that will be 8.x. All documentation updates that happened from 8.0 to 8.52 and beyond will be available in 8.x.
-   The latest version: As of September 17, that will be version 9.24. All documentation changes that happened from 9.0 to 9.24 and beyond when we release in the future will be available in the latest version.

If you have a link saved with a version number, you will be redirected to 8.x or the latest version. If you have any questions or concerns, please [contact us](https://the-adaptavist-group-support.atlassian.net/servicedesk/customer/portal/21/user/login?destination=portal%2F21).

## 9.23.0

20 Aug 2025 

### **Advanced Notice for Documentation Versions Removal**

On September 17, 2025, we will be removing legacy versions of the documentation. This change is part of our efforts to simplify the customer experience and align with wider industry practices. From September 17 onward, there will be two versions of documentation:

-   The previous version: As of September 17, that will be 8.x. All documentation updates that happened from 8.0 to 8.52 and beyond will be available in 8.x.
-   The latest version: As of September 17, that will be version 9.24. All documentation changes that happened from 9.0 to 9.24 and beyond when we release in the future will be available in the latest version.

If you have a link saved with a version number, you will be redirected to 8.x or the latest version. If you have any questions or concerns, please [contact us](https://the-adaptavist-group-support.atlassian.net/servicedesk/customer/portal/21/user/login?destination=portal%2F21).

### Export scripts feature update: Custom fields support

Custom fields are now supported by the export scripts feature. Your export now features an **Instance information** folder, which includes a .json file dedicated to custom fields. This file lists all custom fields on your instance, providing details such as the custom field name, type, and ID. See the [Script Registry](https://docs.adaptavist.com/spaces/SR4JS/pages/426968415/.Script+Registry+v9.23.0) page for more information on this feature.

### Switch User feature update

In response to new Atlassian security requirements, we've removed the Switch User function from the User Management page and the user _More_ dropdown. The [Switch User](https://docs.adaptavist.com/sr4js/latest/features/built-in-scripts/switch-user) function is now exclusively available as a built-in script.

### Behaviours bug fixed

We've resolved a bug related to our Behaviours feature where `setFieldOptions` only worked for the last system field when multiple server-side scripts were created for system fields (such as Priority, Affects Version/s, Issue Type, etc.).

### Compatibility with Jira 10.7.4 (with known issue)

We are now compatible with Jira 10.7.4. However, we have a known issue where multiple database pickers are experiencing issues with stattable gadgets. **This is an outstanding known [compatibility issue with Jira 10.7.1](#id-.Release9.xv9.x-compatibility-issue-920).**

### Security improvements

We've made a couple of security improvements in this release:

-   We have implemented a security improvement to our switch user feature. This update strengthens our protection against potential unauthorized account access.

-   We've addressed a known Common Vulnerabilities and Exposures (CVE).

We want to emphasize that this update doesn't mean your instance was vulnerable to security issues. We're always working to make ScriptRunner as safe as possible, and this update is part of that ongoing effort. Check out our page on [Vulnerabilities and Security](https://docs.adaptavist.com/sr4js/latest/get-started/vulnerabilities-and-security) for more details on how we scan for vulnerabilities and common security concerns.

## 9.22.0

06 Aug 2025

### Compatibility with Jira 10.7.2

We fixed a known issue with compatibility with Jira 10.7.2 (see [9.21.0 release notes](#id-.Release9.xv9.x-compatibility-issue-921) for more details). Behaviours applied to _the Due Date_ field now behave as expected in the Jira create/edit issue dialog box.

## 9.21.0

23 Jul 2025 

### New documentation: Migration checklist

We've created a [Migration Checklist](https://docs.adaptavist.com/sr4js/latest/scriptrunner-migration/migrating-to-cloud/migration-checklist) to help you get started with migration from ScriptRunner for Jira DC to ScriptRunner for Jira Cloud. 

### Behaviours bugs fixed

We've resolved the multiple bugs related to our Behaviours feature:

-   The `setRequired()` function now works correctly in the JSM portal for Jira 10.x.x and ScriptRunner 9.x.x.
-   Restrictions on the **Priority** field in the JSM portal now function as intended.
-   We've resolved the conflict between `setFieldOptions` and `setFormValue` for Asset Object fields in the JSM Portal.

### Compatibility with Jira 10.7.2 (with known issue)

We are now compatible with Jira 10.7.2. However, we have two known issues:

-   Multiple database pickers are experiencing issues with stattable gadgets. This is an outstanding known compatibility issue with Jira 10.7.1.
-   Behaviours applied to _the Due Date_ field do not behave as expected in the Jira create/edit issue dialog box.

### Compatibility with Jira 10.7.1

We fixed a known issue with compatibility with Jira 10.7.1 (see [9.20.0 release notes](#id-.Release9.xv9.x-compatibility-issue-920) for more details). The following JQL functions should now work as expected:

-   `AddedAfterSprintStart`
-   `CompleteAfterSprintStart`
-   `IncompleteAfterSprintStart`
-   `RemovedAfterSprintStart`

### Security improvement

In this release, we've focused on improving the security of ScriptRunner for Jira by addressing known Common Vulnerabilities and Exposures (CVEs). We want to emphasize that this update doesn't mean your instance was vulnerable to security issues. We're always working to make ScriptRunner as safe as possible, and this update is part of that ongoing effort. Check out our page on [Vulnerabilities and Security](https://docs.adaptavist.com/sr4js/latest/get-started/vulnerabilities-and-security) for more details on how we scan for vulnerabilities and common security concerns.

## 9.20.0

09 Jul 2025 

### Export scripts feature update: Workflow functions support

Workflow function configurations are now supported by the export scripts feature. See the [Script Registry](https://docs.adaptavist.com/sr4js/latest/features/script-registry) page for more information on this feature.

### New feature: Inbox

We have introduced a new Inbox feature in ScriptRunner. When enabled, it displays notifications about breaking changes, migrations, recommended upgrades, new releases, and other important updates. When disabled, no information displays in the inbox. See the [In-App Communications](https://docs.adaptavist.com/sr4js/latest/get-started/settings/in-app-communications) page for information on how to enable/disable this feature.  

In the previous version of ScriptRunner we incorrectly stated that the Inbox feature was released. It is actually introduced in this version, and the release notes have been updated accordingly.

### Compatibility with Jira 10.7.1 (with known issue)

We are now compatible with Jira 10.7.1. However, we have two known issues:

-   Multiple database pickers are experiencing issues with stattable gadgets.
-   The following JQL functions may not work as expected:
    -   `AddedAfterSprintStart`
    -   `CompleteAfterSprintStart`
    -   `IncompleteAfterSprintStart`
    -   `RemovedAfterSprintStart`

We're actively working on both of these issues and aim to provide solutions in an upcoming release.

### Behaviours bug fixed

We've resolved a bug related to our Behaviours feature where `setFieldOptions()` did not work correctly for Component fields on the JSM portal.

## 9.19.0

25 Jun 2025 

### New feature: Export scripts

We've introduced a new export feature in ScriptRunner. This feature allows you to export all scripts and configurations from your instance via the Script Registry, with the exception of Workflow scripts and ScriptRunner JQL function information.

In this context, "scripts" encompass a broader range of elements than typical custom script files. Specifically, we include:

-   All scripts within your [script roots](https://docs.adaptavist.com/sr4js/latest/best-practices/write-code/script-roots).
-   All configured custom and built-in Jobs, Listeners, Fields, Behaviours, UI Fragments, REST Endpoints.

See the [Script Registry](https://docs.adaptavist.com/sr4js/latest/features/script-registry) page for more information on this feature.

Thinking of migrating to Cloud?

This feature will help you analyze your instance and scripts in preparation for migration to Cloud.

### Documentation update: Jira 11 search API migration guide

In Jira Data Center version 10.4, Atlassian has introduced a new Search API, marking a significant overhaul of the search functionality by transitioning from Lucene to OpenSearch. Some of your scripts may break when Jira 11 is released. To avoid any downtime in your scripts when you upgrade to Jira 11, we recommend you use our [Jira 11 Search API Upgrade Guide](https://docs.adaptavist.com/sr4js/latest/release-notes/breaking-changes/jira-11-search-api-upgrade-guide) to upgrade any affected scripts.

This guide is still a work in progress and may be updated in the coming weeks. We recommend you to bookmark the guide and check back regularly for the most up-to-date information.

### Script Registry bug fixed

The Script Registry now correctly displays all workflow functions with scripts for each transition. Previously, only one function was shown per transition, even when multiple were set up.

## 9.18.0

11 Jun 2025 

### Security Improvement

In this release, we've focused on improving the security of ScriptRunner for Jira by addressing a known Common Vulnerabilities and Exposure(CVE). We want to emphasize that this update doesn't mean your instance was vulnerable to security issues. We're always working to make ScriptRunner as safe as possible, and this update is part of that ongoing effort. Check out our page on [Vulnerabilities and Security](https://docs.adaptavist.com/sr4js/latest/get-started/vulnerabilities-and-security) for more details on how we scan for vulnerabilities and common security concerns.

## Update: Jira (10.3.4) Bug affecting HAPI

05 Jun 2025

This bug has now been fixed. To avoid this issue, please upgrade your Jira instance to an appropriate fix version. See [JSDSERVER-16263](https://jira.atlassian.com/browse/JSDSERVER-16263) for more details.

Affected Jira versions (10.3.4) and all ScriptRunner versions.

There is a bug in Jira that is affecting HAPI. When using `issueInputParameters.setSkipScreenCheck(true)` and certain custom field types, a `NullPointerException` occurs. We are working with Atlassian to resolve this bug (see [JSDSERVER-16263](https://jira.atlassian.com/browse/JSDSERVER-16263)), but we have a temporary workaround that can be applied in certain instances so that you can continue to use HAPI. Please note that updates to any field not on the relevant screen will be silently dropped, so this workaround is not suitable for all cases.

To check to see if you are affected, look for an `NullPointerException` with `convertToSimpleEntry` (line 2 below): 

```
java.lang.NullPointerException
	at com.atlassian.jira.web.action.issue.util.JiraFieldParamHelper.convertToSimpleEntry(JiraFieldParamHelper.java:92)
	at com.atlassian.jira.web.action.issue.util.JiraFieldParamHelper.lambda$convertToParam$0(JiraFieldParamHelper.java:54)
	at com.atlassian.jira.web.action.issue.util.JiraFieldParamHelper.convertToParam(JiraFieldParamHelper.java:56)
```

In every `update` and `transition` closure that is affected, add `setSkipScreenCheck(false)` (shown in line 3 here):

```
Issues.getByKey('JRA-1').update {
    summary = 'Updated summary'
    setSkipScreenCheck(false)
}
```

Updates to any field not on the relevant screen will be silently dropped, so this workaround is not suitable for all cases.

## 9.17.0

28 May 2025 

### Behaviours bug fixed

We've resolved a bug related to our Behaviours feature where `setFieldOptions()` did not work correctly for Select List (cascading) fields on the JSM portal.

### Documentation enhancement

We’ve updated our [Rewriting Scripts for Cloud Hints and Tips](https://docs.adaptavist.com/sr4js/latest/scriptrunner-migration/migrating-to-cloud/rewriting-scripts-for-cloud-hints-and-tips) page. This page provides step-by-step instructions, best practice tips, and examples to support your migration from Scriptrunner for Jira Server/Data Center to ScriptRunner for Jira Cloud.

## 9.16.0

15 May 2025 

### Bugs fixed

We have resolved the following bugs in this release:

-   Behaviours bug: We fixed a conflict between `setFieldOptions` and `setFormValue` for multi-select fields.
-   Common-runtime module bug: We resolved an issue where ScriptRunner's `common-runtime` module interfered with fields from other plugins.
-   `httpmime` version update: `httpmime` version has been updated to version 4.5.14 to match the `httpclien`t version. Previously, ScriptRunner for Jira had `httpclient` version 4.5.14 and `httpmime` version 4.3.1.

### Vulnerability scanner updates

We have updated and added new vulnerability scanners to reduce discrepancies in your vulnerability reports. This is an internal feature and does not require any action from you.

## 9.15.0

06 May 2025 

### Compatibility with Jira 10.6

We are now compatible with Jira 10.6. However, we have a known issue where custom group fields aren't properly indexed, causing inconsistent results when used in JQL queries. Atlassian is working on a fix, and we expect this issue to be resolved in a future release.

### Security Improvement

In this release, we've focused on improving the security of ScriptRunner for Jira by addressing a known Common Vulnerabilities and Exposure (CVE). We want to emphasize that this update doesn't mean your instance was vulnerable to security issues. We're always working to make ScriptRunner as safe as possible, and this update is part of that ongoing effort. Check out our page on [Vulnerabilities and Security](https://docs.adaptavist.com/sr4js/latest/get-started/vulnerabilities-and-security) for more details on how we scan for vulnerabilities and common security concerns.

## 9.14.0

16 Apr 2025 

There are only core component changes in ScriptRunner for Jira 9.14.0, so we do not have any new features or bug fixes to report.

## 9.13.0

02 Apr 2025 

### Jira compatibility

ScriptRunner for Jira is now compatible with Jira 10.5.x.

### Behaviours bugs fixed

We've resolved bugs related to our Behaviours feature. `setFieldOptions()` previously caused the following issues:

-   Disrupted `setFormValue()` in the JSM portal.
-   Caused errors when creating or editing issues in a Kanban board. 

These bugs are now fixed. 

## 9.12.0

19 Mar 2025 

### Behaviours bug fixed

We've resolved a bug related to our Behaviours feature. This issue affected the setting of field options for radio buttons and checkboxes on the JSM portal.

## 9.11.0

05 Mar 2025 

### Security Improvement

In this release, we've focused on improving the security of ScriptRunner for Jira by addressing a known Common Vulnerabilities and Exposure (CVE). We want to emphasize that this update doesn't mean your instance was vulnerable to security issues. We're always working to make ScriptRunner as safe as possible, and this update is part of that ongoing effort. Check out our page on [Vulnerabilities and Security](https://docs.adaptavist.com/sr4js/latest/get-started/vulnerabilities-and-security) for more details on how we scan for vulnerabilities and common security concerns.

### Behaviours bug fix

We have fixed a bug related to our Behaviours feature. Previously checkboxes and radio buttons weren't being hidden properly. This bug has been fixed, and these fields now function as intended, hiding correctly when specified.

### Documentation update: Removal of legacy versions

In the next few weeks, we will be phasing out all 6.x.x and 7.x.x versions of our documentation from public access. While this change is not expected to impact most users, we recommend taking the following actions:

-   Review your bookmarks: If you have any saved links to our documentation, please verify that they don’t point to versions that will be removed.
-   Update your references: Ensure that you’re using the most current documentation version for your needs.

If you have any concerns, please contact our [support team](https://www.scriptrunnerhq.com/help/support).

## 9.10.0

20 Feb 2025 

### Jira compatibility

ScriptRunner for Jira is now compatible with Jira 10.4.x.

### **Library update: Example scripts have moved to ScriptRunner HQ**

Adaptavist Library has been renamed to [Example Scripts](https://www.scriptrunnerhq.com/help/example-scripts) and all scripts have been moved to their new home on the [ScriptRunner HQ](https://www.scriptrunnerhq.com/) website. These example scripts now live alongside the tutorials, case studies and other content designed to help you get the most from ScriptRunner. For more information, check out our [blog](https://www.scriptrunnerhq.com/inspiration/blog/example-scripts-on-scriptrunner-website) on this update.

This update does not affect in-app example scripts, which will continue to function as usual.

## 9.9.0

05 Feb 2025 

There are only core component changes in ScriptRunner for Jira 9.9.0, so we do not have any new features or bug fixes to report.

## 9.8.0

22 Jan 2025 

### Security improvement

In this release, we've focused on improving the security of ScriptRunner for Jira by addressing known Common Vulnerabilities and Exposures (CVEs). We want to emphasize that this update doesn't mean your instance was vulnerable to security issues. We're always working to make ScriptRunner as safe as possible, and this update is part of that ongoing effort. Check out our page on [Vulnerabilities and Security](https://docs.adaptavist.com/sr4js/latest/get-started/vulnerabilities-and-security) for more details on how we scan for vulnerabilities and common security concerns.

### New: In-app feedback

In this release, we have introduced a new feedback system to improve the way we gather user insights. You may encounter notifications linking to surveys, which offer a convenient method to share your thoughts about the product.

The notifications will not appear:

-   If you've [disabled in-app communications](https://docs.adaptavist.com/sr4js/latest/get-started/settings/in-app-communications) in ScriptRunner.
-   If you're using an evaluation license.
-   If your instance is isolated from the internet. 

### New: HAPI documentation

We have created a new page that explains how to [Simplify Current Scripts with HAPI](https://docs.adaptavist.com/sr4js/latest/hapi/simplify-current-scripts-with-hapi). The guidance explains why it's useful to simplify your scripts with HAPI, how to find scripts that can be simplified, and examples of simplified scripts. 

## 9.7.0

16 Dec 2024 

### Jira compatibility

ScriptRunner for Jira is now compatible with Jira 10.3.0.

### Behaviours bug fixed

Previously, when customers submitted requests through the customer portal, Behaviors did not function as intended. This issue has been resolved, and Behaviors now operate correctly within the customer portal.

## 9.6.0

27 Nov 2024 

### Security Improvement

In this release, we've focused on improving the security of ScriptRunner for Jira by addressing a known Common Vulnerabilities and Exposure (CVE). We want to emphasize that this update doesn't mean your instance was vulnerable to security issues. We're always working to make ScriptRunner as safe as possible, and this update is part of that ongoing effort. Check out our page on [Vulnerabilities and Security](https://docs.adaptavist.com/sr4js/latest/get-started/vulnerabilities-and-security) for more details on how we scan for vulnerabilities and common security concerns.

## 9.5.0

14 Nov 2024 

### Configuration Manager for Jira (CMJ) compatibility

ScriptRunner for Jira is now compatible with [Configuration Manager for Jira](https://marketplace.atlassian.com/apps/1211611/configuration-manager-for-jira-cmj?hosting=datacenter&tab=overview) following the Jira 10.0 upgrade. 

### Jira compatibility

ScriptRunner for Jira is now compatible with Jira 10.1.x.

## 9.4.0

30 Oct 2024 

### Resources update

We have removed some visibility of passwords within [Resources](https://docs.adaptavist.com/sr4js/latest/features/resources). This change is designed to enhance security by preventing credentials from being viewed by other Jira administrators. See [SRPLAT-2672](https://assist.adaptavist.com/browse/SRPLAT-2672) for more details.

## 9.3.0

16 Oct 2024

### Jira 10.0 compatibility

We're now compatible with all versions of Jira 10.0. See SRJIRA-7537 for more information. 

### Tempo compatibility

We are happy to confirm that ScriptRunner for Jira Data Center (version 9.1.1 onwards) is compatible with [Tempo](https://docs.adaptavist.com/sr4js/latest/integrations/other-apps/tempo) version 18.0.0-jira-10. 

**New features**

-   SRPLAT-2645 - HAPI Linter: Top 10 methods for autosuggestion
-   SRJIRA-7537 - Make ScriptRunner for Jira Data Center compatible with Jira 10.0.0
-   SRJIRA-7388 - Add method to recalculate Scripted Field value upon calling

**Bugs fixed**

-   SRPLAT-1209 - Setting REST endpoint package to scan to empty value does not work
-   SRJIRA-7547 - Behaviour: setFormValue() doesn't work for User Picker (Multiple Users) fields in Service Desk Portal when using Deutsch (Deutschland) - V8
-   SRJIRA-7546 - When language is Polish, Behaviour setRequired() message still shows even the Multiple User Picker field has value during creation in Customer Portal - Version 8
-   SRJIRA-7412 - Behaviours is not triggered when clearing the Assets field value 
-   SRJIRA-7170 - When language is Polish, Behaviour setRequired() message still shows even the Multiple User Picker field has value during creation in Customer Portal - V9

## 9.2.0

02 Oct 2024 

There are only core component changes in ScriptRunner for Jira 9.2.0, so we do not have any new features or bug fixes to report.

### Upcoming Resources update

In a forthcoming release, we will be removing the visibility of passwords within [Resources](https://docs.adaptavist.com/sr4js/latest/features/resources). This change is designed to enhance security by preventing credentials from being viewed by other Jira administrators.

## 9.1.1

### Compatibility with Jira 10

ScriptRunner for Jira is now compatible with Jira 10. See the [Compatibility with Jira](https://docs.adaptavist.com/sr4js/latest/get-started/update-scriptrunner/compatibility-with-jira) page for more information on Jira 10 best practices on upgrading your instance.

### Breaking changes

There are some key breaking changes you should be aware of when upgrading to Jira 10:

-   Third-party library/API removal
-   JDK has been updated. The minimum supported version of the JDK is now JDK 17. 
-   Fragments updates (see more below)

See the [breaking changes](https://docs.adaptavist.com/sr4js/latest/release-notes/breaking-changes#version9) page for the full details of all breaking changes related to this upgrade. 

### Fragments updates

To adhere to Jira 10, [UI Fragments](https://docs.adaptavist.com/sr4js/latest/features/fragments) had the following changes: 

-   [Raw XML Module Breaking Change](https://docs.adaptavist.com/sr4js/latest/release-notes/breaking-changes/raw-xml-module-breaking-change-for-jira-10): Fragment XML conditions scripts and web panel class scripts are now provided via XML parameters and are no longer directly set as the `condition class` element attribute or the web panel class element attribute value. The previous formats no longer work in Jira 10 versions of ScriptRunner. You can use the [Raw XML Module Breaking Change](https://docs.adaptavist.com/sr4js/latest/release-notes/breaking-changes/raw-xml-module-breaking-change-for-jira-10) guide to help you convert your scripts to the new fragment XML parameters format. Major changes include: 
    -   Format of the XML condition class attribute and user scripts now added as parameters
    -   Format of the XML Web Panel class attribute and user scripts now added as parameters

Related documentation changes appear on [Raw XML Module Built-In Script](https://docs.adaptavist.com/sr4js/latest/features/fragments/raw-xml-module-built-in-script).

-   [Web Panel Breaking Change/Deprecation for Jira 10](https://docs.adaptavist.com/sr4js/latest/release-notes/breaking-changes/web-panel-breaking-change-deprecation-for-jira-10): If you used a **`com.atlassian.plugin.web.model.WebPanel`** class implementation for the p`rovider class/script` of your [web panels](https://docs.adaptavist.com/sr4js/latest/features/fragments/web-panel), the way this is processed will be different after upgrading to Jira 10. Check out the [Web Panel Breaking Change/Deprecation for Jira 10](https://docs.adaptavist.com/sr4js/latest/release-notes/breaking-changes/web-panel-breaking-change-deprecation-for-jira-10) guide to learn how to update scripts. Major changes include: 
    -   The `writeHtml` method is now ignored
    -   The Atlassian `com.atlassian.plugin.web.model.WebPanel` interface is deprecated and has moved to a new location
-   [Web Resource Breaking Change](https://docs.adaptavist.com/sr4js/latest/release-notes/breaking-changes/web-resource-breaking-change-for-jira-10): If you have files in `plugin.resource.directories` you will have to move them to `web-resources/com.onresolve.jira.groovy.groovyrunner`. Check out the [Web Resource Breaking Change](https://docs.adaptavist.com/sr4js/latest/release-notes/breaking-changes/web-resource-breaking-change-for-jira-10) page to learn more.
-   [Web Item Provider Built-In Script](https://docs.adaptavist.com/sr4js/latest/features/fragments/built-in-fragments/web-item-provider-built-in-script): Major changes include:
    
    -   The feature will only function once Jira releases the new fragment API updates (Estimated to be available from Jira 10.1.0/10.0.2). SRPLAT-2596
    -   The `com.atlassian.plugin.web.api.model.WebFragmentBuilder` API has moved to `com.atlassian.plugin.web.model.WebFragmentBuilder`. Any scripts using the old API import will need to be updated to the new location. (Once updated, your scripts will no longer show a red line under the old import; however, you cannot verify the fix fully until Atlassian releases the API mentioned in the SRPLAT-2596.)

### Backward compatibility

ScriptRunner 9.1.1 will only support Jira 10.0 and above and will not be backwards compatible with earlier Jira versions. Critical bugs and security fixes will continue to be released for ScriptRunner 8.x.x. We recommend users on older versions of Jira or ScriptRunner plan their upgrade to ensure access to the to ensure access to the latest features, performance improvements, and security enhancements. We recommend following our [Compatibility with Jira](https://docs.adaptavist.com/sr4js/latest/get-started/update-scriptrunner/compatibility-with-jira) page for information and recommendations on how to upgrade.

### Tempo compatibility

ScriptRunner for Jira Data Center is currently not compatible with [Tempo](https://docs.adaptavist.com/sr4js/latest/integrations/other-apps/tempo) after the Jira 10.0 upgrade. We aim to be compatible with Tempo soon.

**Bugs fixed**

-   SRPLAT-2630 - Script compilation can leak file handles
