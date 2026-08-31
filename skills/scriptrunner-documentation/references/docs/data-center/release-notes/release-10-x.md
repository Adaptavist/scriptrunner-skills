# Release 10.x

- Platform: data-center
- Space: SR4JS
- Hierarchy: release-notes
- Doc ID: doc-sr4js-443373539
- Source: https://docs.adaptavist.com/sr4js/latest/release-notes/release-10-x

Feature Release Summary

You can explore all the feature releases we’ve introduced to ScriptRunner for Jira, starting from version 7.0.0 onwards, on the [Feature Release Summary](https://docs.adaptavist.com/display/_PK/SR4JS/release-summary) page. This page is designed to assist you in finding the ideal version to upgrade to, all while catching up on any enhancements you might have missed since your last update.

Try our migration tools!

The ScriptRunner Migration Suite is a suite of tools that helps you plan, analyse, convert and deploy scripts with confidence, significantly reducing the manual migration effort. It supports (not replaces) your expertise. The suite is made up of three tools: 

-   [ScriptRunner Migration Analyse and Assess Tool](https://docs.adaptavist.com/sms/latest/scriptrunner-migration-suite-web-app/scriptrunner-migration-analyse-and-assess-tool): Use this tool to review your ScriptRunner Data Center scripts and configurations for risks and cloud readiness.
-   [The ScriptRunner Migration Agent](https://docs.adaptavist.com/sms/latest/scriptrunner-migration-suite-web-app/scriptrunner-migration-agent): Use our specialised AI chat agent to create, convert, and optimise scripts, or you can use it to answer a variety of different questions about ScriptRunner.
-   [ScriptRunner Dev and Deployment Tool](https://docs.adaptavist.com/sms/latest/scriptrunner-dev-and-deployment-tool): Use this tool to organise and deploy ScriptRunner Cloud scripts. It is focused on making it easier and faster for consultants and developers to migrate, test, and deploy scripts from ScriptRunner DC to Cloud.

If you have any questions, need help, or would like to request access, the quickest way to get assistance is through our [dedicated support portal](https://the-adaptavist-group-support.atlassian.net/servicedesk/customer/portal/1069/user/login?destination=portal%2F1069).

## 10.17.0

25 Aug 2026 

### Compatibility with Jira 11.3.10

We are now compatible with Jira 11.3.10. 

## 10.16.0

14 Aug 2026 

### Copy Field Value post function bug fixed

We’ve fixed an issue where the **Copy Field Value** post function did not copy values from a parent issue onto a sub-task field (for example, copying **Epic Name** to **Summary**). The post function now correctly updates and re-indexes the target sub-task, and parent/sub-task copies work as expected.

### Fields API visibility bug fixed

We’ve fixed an issue where the `/rest/scriptrunner-jira/1.0/fields` REST endpoint returned the names and IDs of all custom fields in the instance to any authenticated user, including fields outside their normal access. The response is now scoped to only return field metadata that is visible to the calling user.

### Security update

We’ve made targeted security improvements in this release as part of our ongoing hardening work. For more details on how we handle security and vulnerability management, see our [Vulnerabilities and Security](https://docs.adaptavist.com/sr4js/latest/get-started/vulnerabilities-and-security) documentation.

## 10.15.0

04 Aug 2026 

### Reindex logging and issue-link index bug fixed

We've fixed an issue where full or background reindexing logged `Invalid use of RequestCache` error messages from ScriptRunner's issue-link indexer. Issue links are now indexed using a proper Jira thread-local context, avoiding these errors.

### Scripted fields in Jira Issues macro bug fixed

We’ve fixed an issue where scripted fields appeared blank in the Confluence **Jira Issues** macro, even though they displayed correctly in Jira. This was caused by Jira’s tightened Velocity method allowlist blocking certain methods used when rendering scripted fields. Scripted fields now render as expected in the Jira Issues macro.

### Database Picker validation bug fixed

We’ve fixed an issue where Database Picker fields could not be previewed or saved when using stricter JDBC drivers (for example, Databricks JDBC v3), causing `INVALID_PARAMETER_MARKER_VALUE.INVALID_DATA_TYPE` errors. Database Picker validation now binds parameters in a driver‑compatible way, so fields can be created and previewed successfully with these drivers.

### Behaviours cascading select bug fixed

We’ve fixed an issue where JSM cascading select fields controlled by Behaviours could intermittently fail to set child values or update dependent fields after a parent change. Cascading selects now update reliably when the parent value changes.

### Third-party dependencies updated to remove CVEs

We’ve updated third‑party dependencies within ScriptRunner to address known CVEs (Common Vulnerabilities and Exposures). These changes are part of our ongoing hardening work and do not indicate that your instance was exposed to security issues. For more details on how we handle security and vulnerability management, see our [Vulnerabilities and Security](https://docs.adaptavist.com/sr4js/latest/get-started/vulnerabilities-and-security) documentation.

## 10.14.0

17 Jul 2026 

### Database Picker gadgets bug fixed

We’ve fixed an issue where Database Picker script fields could not be used in statistical gadgets such as **Pie Chart** and **Two Dimensional Filter Statistics**, resulting in 500 errors about missing field indexers. Multiple Database Picker fields (including those with multiple values) now work as expected in these gadgets.

### Behaviours loading bug fixed

We’ve fixed an issue where, on some instances, the **Behaviours** admin page failed to load with a 500 error due to XML parser and classloader conflicts. Behaviour configurations are now parsed correctly, and the Behaviours page loads as expected.

### Groovy custom field type-checking bug fixed

We’ve fixed an issue where `GroovyCustomField` could throw type-checking errors when the field value was a collection of non-issue objects (for example, users). The field now correctly handles collections by checking the element types before treating them as issues.

### Compatibility with Jira 11.3.8

We are now compatible with Jira 11.3.8. 

## 10.12.0

24 Jun 2026 

### Security improvement

In this release, we’ve strengthened security around core ScriptRunner endpoints. We’re always working to make ScriptRunner as safe as possible, and this update is part of that ongoing effort.

### Compatibility with Jira 11.3.7

We are now compatible with Jira 11.3.7. 

## 10.11.1

18 May 2026 

### Insight events fix rolled back

We’ve temporarily reverted the Insight events fix introduced in 10.11.0, as this caused an OSGi bundling error that prevented the plugin from being enabled. 

## 10.11.0

18 May 2026 

### Compatibility with Jira 11.3.6

We are now compatible with Jira 11.3.6. 

### `UserMessageUtil` bug fixed

We’ve fixed an issue where messages created with `UserMessageUtil` weren't displayed until the page was refreshed because the relevant Jira events weren't firing. `UserMessageUtil` messages now appear correctly when triggered, without requiring a full page reload. See our [custom post function documentation](https://docs.adaptavist.com/sr4js/latest/features/workflows/post-functions/custom-post-functions#display-a-message-to-the-user) for more information on `UserMessageUtil`. 

### Database picker bug fixed

We've fixed an issue where multi-select database picker fields did not render their values correctly in **Column view**. Multi-selection database picker fields now display their selected values as expected.

### Insight event scripts bug fixed

We’ve fixed an issue where scripts importing Insight event classes, such as `InsightObjectEvent` or `InsightObjectUpdatedEvent`, failed to compile and run when those types were used explicitly. These scripts now save and execute correctly.

## 10.9.0

08 May 2026 

### Script export improvement: saved JQL filters

Saved JQL filters that use ScriptRunner JQL functions are now included in the [Script export](https://docs.adaptavist.com/sr4js/latest/features/script-registry#exporting-your-scripts). These filters are listed in the main **Output.csv** file, and each one is also exported as a .json file in the **jqlFunctionFilters** folder. Saved filters that do not use ScriptRunner JQL functions are excluded from the export.

### Behaviours bug fixed

We’ve fixed an issue where certain Behaviours saved in older ScriptRunner versions (using a `<parameters>{}</parameters>` configuration) caused the Behaviours page to fail to load after upgrading to Jira 10. These legacy configurations are now handled correctly during upgrade, so the Behaviours page loads as expected without requiring manual edits.

### HAPI bug fixed

We’ve fixed an issue in Jira Service Management where HAPI sometimes resolved request types using the service desk ID instead of the portal ID. In projects where these IDs differ, this could result in request types from the wrong project being displayed when setting or suggesting a **Request Type**. Request types are now consistently resolved by portal ID, ensuring the correct project’s request types are used.

### Script export bug fixed

We’ve fixed an issue where the [Script export](https://docs.adaptavist.com/sr4js/latest/features/script-registry#exporting-your-scripts) omitted Groovy source files from ScriptRunner script plugins. Plugin-backed scripts are now correctly included in the export.

## 10.8.0

01 Apr 2026 

### Script export bug fixed

We've fixed an issue with script export where a single invalid workflow (for example, a transition pointing to a nonexistent step) caused workflow configuration export to fail for all workflows, resulting in an `IllegalStateException`/`CacheException`. Export now skips only the invalid workflow and succeeds for the rest.

### JQL custom function bug fixed

We’ve fixed an issue where custom JQL functions were not immediately available on all nodes after being scanned on a single node. Custom JQL functions scanned on one node are now propagated correctly, allowing end users to use them across the entire cluster without additional steps.

## 10.7.0

27 Feb 2026 

### Behaviours bugs fixed

We’ve resolved multiple bugs related to our Behaviours feature:

-   Behaviours now execute correctly when creating issues via the `.../secure/CreateIssue.jspa` URL. Previously, changing a project on this URL did not trigger a Behaviour correctly.
    
-   Fields set to **read-only** via a server-side Behaviour are now correctly enforced when accessed using Jira quick actions/keyboard shortcuts (`gg` or `.`). Previously, if a field had no value, it remained editable via shortcuts even when configured as read-only.
    

## 10.6.0

11 Feb 2026 

### Compatibility with Jira 11.3.2

We are now compatible with Jira 11.3.2. 

### Script Fields bug fixed

We've resolved a bug related to our [Script Fields](https://docs.adaptavist.com/sr4js/latest/features/script-fields) feature. Script Fields using the **Duration** template now correctly display the formatted duration value. Previously, the literal text `$DateUtils.formatDurationPretty($value)` was shown instead of the actual duration.

## 10.5.0

28 Jan 2026 

### Compatibility with Jira 11.3

We are now compatible with Jira 11.3.x. 

## 10.4.0

11 Dec 2025 

### Compatibility with Jira 11.2

We are now compatible with Jira 11.2.x. 

### Instance audit enhancement

We've improved the performance of our [Instance Audit](https://docs.adaptavist.com/sr4js/latest/features/built-in-scripts/instance-audit) feature, ensuring faster and more reliable operation on larger Jira instances.

## 10.3.0

26 Nov 2025 

### Compatibility with Jira 11.1

We are now compatible with Jira 11.1.x. 

### Script export improvements

We've made the following improvements to our [Script export](https://docs.adaptavist.com/sr4js/latest/features/script-registry#exporting-your-scripts) feature:

-   **ScriptRunner metadata is now included**. The export now contains the ScriptRunner version, ScriptRunner app key, and Jira (host application) version. This information is stored in a .json file in the **Instance information** folder.
-   **Legacy and duplicate workflow functions are now exported**. Previously, these workflow functions were not included and would be missing from the export. They now appear alongside all other workflow functions.

## 10.2.0

14 Nov 2025 

### Instance audit bugs fixed

We have resolved bugs related to our [Instance Audit](https://docs.adaptavist.com/sr4js/latest/features/built-in-scripts/instance-audit) feature:

-   The **App custom fields** count displays correctly in the audit summary. Previously, the **App custom fields** count did not display as expected.
-   The **Export Report** button creates a download file as expected. Previously, in some unique instances of Jira, this button did not generate a CSV download file.  

### Script export bugs fixed

We've resolved the multiple bugs related to our [Script export](https://docs.adaptavist.com/sr4js/latest/features/script-registry#exporting-your-scripts) feature:

-   The **Export active scripts Only** option now works as expected for all features. Previously, it did not export behaviours and listeners as expected. 
-   Resource names now display in the export. Previously, the names of resources did not display. 

## 10.1.0

29 Oct 2025 

### Instance Audit built-in script is now available for ScriptRunner 10.x 

Previously, this built-in script was only compatible with ScriptRunner 9.25+.

Our Instance Audit built-in script enables you to quickly assess the current state of your Jira environment for easy cleanup, instance optimisation, and migration preparation. You can also use the **Export report** button to download CSV files containing more information on users, projects, custom fields, and workflow functions. See the [Instance Audit](https://docs.adaptavist.com/sr4js/9.x/features/built-in-scripts/instance-audit) documentation for more details. 

![GIF of the instance audit feature](/sr4js/files/latest/443373539/454394666/1/1761300346000/Instance_audit.gif)

## 10.0.0

02 Oct 2025 

### Compatibility with Jira 11 (with OpenSearch exception)

ScriptRunner for Jira is now compatible with [Jira 11](https://confluence.atlassian.com/jirasoftware/jira-software-11-0-x-release-notes-1587939582.html). For guidance on Jira 11 upgrade best practices and compatibility information, refer to our [Compatibility with Jira](https://docs.adaptavist.com/sr4js/latest/get-started/update-scriptrunner/compatibility-with-jira) page.

#### OpenSearch exception

Atlassian introduced a new [OpenSearch opt-in feature](https://confluence.atlassian.com/jirasoftware/jira-software-11-0-x-release-notes-1587939582.html#JiraSoftware11.0.xreleasenotes-opensearch-eap) in Jira 11. ScriptRunner for Jira is not currently compatible with this feature. To maintain ScriptRunner functionality, we recommend that you **do not opt into OpenSearch**. We are working on compatibility and will provide an update when support becomes available.

### Backward compatibility

ScriptRunner 10.0.0 will only support Jira 11.0 and above and will not be backwards compatible with earlier Jira versions. Critical bugs and security fixes will continue to be released for ScriptRunner 9.x.x and 8.x.x. We recommend users on older versions of Jira or ScriptRunner plan their upgrade to ensure access to the latest features, performance improvements, and security enhancements. We recommend following our [Compatibility with Jira](https://docs.adaptavist.com/sr4js/latest/get-started/update-scriptrunner/compatibility-with-jira) page for information and recommendations on how to upgrade.

### Breaking changes

There are some key breaking changes you should be aware of when upgrading to Jira 11:

-   **`TrustedRequestFactory` removed in Jira 11**: `com.atlassian.sal.api.net.TrustedRequestFactory` has been removed and will no longer work. Instead, use the HAPI class `com.adaptavist.hapi.platform.oauth.OAuthRequestSigner` to construct HTTP requests. See our [Work with OAuthRequestSigner](https://docs.adaptavist.com/sr4js/latest/hapi/work-with-oauthrequestsigner) HAPI documentation for examples. 
    
-   **Search API upgrade**: Several methods from the current API have been removed. Lucene-specific API and components have been removed in favor of the platform-agnostic search API. 
    
-   **Spring and Jakarta upgrade**: Jira has upgraded to Spring 6.x and Jakarta EE 10.
    
-   **jQuery upgrade**: Jira has upgraded to jQuery 3 from version 2.
    

Scripts using upgraded or removed APIs may fail. For full details on all breaking changes and guidance on updating your scripts, see the [breaking changes](https://docs.adaptavist.com/sr4js/latest/release-notes/breaking-changes#version10) documentation.
