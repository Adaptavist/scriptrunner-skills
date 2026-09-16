# Troubleshoot ScriptRunner Migration

- Platform: data-center
- Space: SR4JS
- Hierarchy: ScriptRunner Migration > ScriptRunner Migration to Cloud
- Doc ID: doc-sr4js-effed8ca-8080-432b-8f4e-0791ff7fd08c-66973ab51ce5abe4
- Source: https://docs.adaptavist.com/sr4js/latest/scriptrunner-migration/scriptrunner-migration-to-cloud/troubleshoot-scriptrunner-migration

CAUTION: Feature Differences

ScriptRunner for Jira Cloud does not have the same feature set as the Server/Data Center version. Our [Feature Parity table](feature-parity-and-script-alternatives.md) provides information about each individual ScriptRunner for Server/Data Center feature's parity. We also provide details on workaround script/function alternatives where there is currently no parity with Cloud.

Tip: Try our migration tools!

The ScriptRunner Migration Suite is a suite of tools that helps you plan, analyse, convert and deploy scripts with confidence, significantly reducing the manual migration effort. It supports (not replaces) your expertise. The suite is made up of three tools:

-   [ScriptRunner Migration Analyse and Assess Tool](../../../migration-suite/script-runner-migration-suite-web-app/script-runner-migration-analyse-and-assess-tool.md): Use this tool to review your ScriptRunner Data Center scripts and configurations for risks and cloud readiness.
-   [The ScriptRunner Migration Agent](../../../migration-suite/script-runner-migration-suite-web-app/script-runner-migration-agent.md): Use our specialised AI chat agent to create, convert, and optimise scripts, or you can use it to answer a variety of different questions about ScriptRunner.
-   [ScriptRunner Dev and Deployment Tool](../../../migration-suite/uncategorized/s/script-runner-dev-and-deployment-tool.md): Use this tool to organise and deploy ScriptRunner Cloud scripts. It is focused on making it easier and faster for consultants and developers to migrate, test, and deploy scripts from ScriptRunner DC to Cloud.

If you have any questions, need help, or would like to request access, the quickest way to get assistance is through our [dedicated support portal](https://the-adaptavist-group-support.atlassian.net/servicedesk/customer/portal/1069).

Tip: Jira's Parent field

If you've renamed or customized the Epic Link default field in your Jira instance, you may notice issues with epic-related queries in [ScriptRunner Enhanced Search](https://docs.adaptavist.com/db/organizations/adaptavist/repositories/master/content/documents/Adaptavist_Content/ScriptRunner/ScriptRunner_for_Jira_Cloud_SR4JC/topics/scriptrunner_enhanced_search.dita), such as:

-   Failures with getting automatic syncing and the most up-to-date results.
-   Epic-related [JQL functions](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-functions) (e.g., `epicsOf, linkedIssuesOf`) not returning expected results.

Atlassian has deprecated the Epic Link field and now recommends using the Parent property to link to epics. Since the Epic Link field was customizable, any epic fields that you have renamed or customized are no longer supported in JQL queries.

You can use this section to learn about some known issues and common issues surrounding migrations to ScriptRunner for Jira Cloud from Server and understand how to use reports if you encounter a failed migration.

## Common Issues with Script Runner Enhanced Search Server to Cloud Filter Migration

### My filter has not migrated to the ScriptRunner Enhanced Search for Jira Cloud app

Filters will not migrate from Server to the ScriptRunner Enhanced Search for Jira Cloud app for the following reasons:

-   The filter does not contain any ScriptRunner Enhanced Search for Jira Cloud [JQL functions](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-functions) or [keywords](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-keywords).
    
    -   These filters will remain as Jira filters, and not be migrated to the ScriptRunner Enhanced Search app.
-   The filter contains nested functions such as, `issueFunction in linkedIssuesOf(issueFunction in epicsOf(project=TEST))`
    
    -   ScriptRunner Enhanced Search for Jira Cloud does not currently support nested Enhanced Search functions, as outlined in our [Feature Parity table](feature-parity-and-script-alternatives.md). However, if you would like to request this feature, you can add your request to our nolt board [here](https://scriptrunner-for-jira-cloud.nolt.io/).
-   The filter contains any Enhanced Search functions or keywords that are not compatible with the Cloud version.
    
    -   Refer to [Feature Parity and Script Alternatives](feature-parity-and-script-alternatives.md) for details on which specific functions or keywords are not compatible.
-   The filter owner does not exist or does not have the correct [permissions](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/jql-sync-status-and-add-on-user-permissions).
    
    -   Ensure that you have migrated your users successfully.

CAUTION: When migrating to Cloud using the [Jira Cloud Migration Assistant](https://docs.adaptavist.com/sr4js/latest/scriptrunner-migration/scriptrunner-migration-to-cloud/migration-checklist#migrate-scriptrunner-with-jira-cloud-migration-assistant--en), it is important to note that even if equivalent functions exist, filters that contain invalid or unparseable Jira Cloud JQL will not be normalized and may cause errors in Enhanced Search. For example, a JQL query in Jira Data Center that escapes double quotes using backslashes, such as `issueFunction in issuesInEpics("\"project\" = \"SLASH\""),` is valid in Jira Data Center but can cause issues during migration to Jira Cloud. To avoid problems during migration, we recommend the following:

-   Update these queries prior to migration by replacing escaped double quotes with a Jira Cloud-compatible format (for example, using single quotes where applicable).
-   If the filter owners cannot be migrated, transfer ownership of the filters in your Jira Data Center instance before completing the migration.
-   Ensure that the original filter owner in Jira Cloud is an active user with access to the Jira Cloud instance, as well as to any groups or projects with which the filters are shared.

### Enhanced Search filters are not syncing or displaying the correct issue results after migration

#### Filter owners must be given access to the instance

The filter owner user must have access to the Cloud instance to sync Enhanced Search filters. If the user does not have access, the filter will not sync. To ensure that filters are automatically synced and can return the correct results, ensure that all your filter owner users are given access to the ScriptRunner Enhanced Search for Jira Cloud instance. You can find out more information in [Atlassian's documentation](https://support.atlassian.com/migration/docs/migrate-users-and-groups/).

#### Filter owners must be given access to any groups and projects they share their filters with

If a filter is shared with a group or project in Jira, but the filter owner cannot access that group in the target instance, the filter may not be synced. Users should be given the required access, or the filters should be updated to reference the correct groups or projects that are accessible to the filter owner.

#### Filters must have been used in the last two months

Atlassian stores a property against all Jira filters, called `approximateLastUsed`. This is a timestamp indicating when the filter was last evaluated, meaning the last time the filter was used to execute a search and generate results. If a filter's timestamp exceeds two months, we do not sync that filter. The filter will be synced again only when it is used, and Atlassian updates the `approximateLastUsed` timestamp to ensure optimal filter syncing performance on your instance.

## Why do I see "Your query may take some time" when performing a search?

Cloud infrastructure is very different to Server infrastructure, so it is not possible to compute queries in Cloud in the same way as in Server environments. This means, if you use a search query that requires fetching data from a very high volume of issues, your query may not complete.

If your search takes longer than two minutes to process, it will time out. Complex search queries can take much longer to complete in Cloud than in the Server environment. This two minute searching limit is in place to ensure optimal performance and to cause minimal disruption to your instance.

To prevent your search timing out, it is important to narrow your JQL query scope to ensure that issue results can be processed within two minutes. This can easily be done by narrowing the JQL query scope in your ScriptRunner Enhanced Search function by project, for example:

`issueFunction in linkedIssuesOf("project in (TEST, TEST2) and status in ('In Progress')")`

We have provided some [Tips for Writing JQL Queries](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/troubleshoot-scriptrunner-enhanced-search/query-writing-recommendations) for your reference. If you are still having trouble crafting your Enhanced Search query, you can contact us via the [Adaptavist Product Support Portal](https://the-adaptavist-group-support.atlassian.net/servicedesk/customer/portal/19).

## Why do I see the "Field 'issueFunction' does not exist or you do not have permission to view it" error message in Jira?

You cannot successfully execute a search with the Enhanced Search JQL functions directly into the Jira issue search page.

-   Jira's built-in search does not support the advanced JQL functions provided by Enhanced Search.
-   If you try to copy-paste an Enhanced Search query into the standard Jira search bar, it will not work because the native JQL engine does not recognise those functions.

ScriptRunner Enhanced Search for Jira Cloud [JQL functions](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-functions) must be executed in a search from within the Enhanced Search app as they cannot be used directly in the Jira issue search page (also known as the Issue Navigator).

You can still use the Enhanced Search filter within other parts of Jira, for example as a board filter, but it must be created and managed from within the ScriptRunner Enhanced Search for Jira Cloud app itself.

Note: We are actively working on a solution to enable the use of ScriptRunner Enhanced Search JQL functions in the native Jira issue search page, with availability planned for 2026.

## Migration Reports

If you have yet to complete migrating from ScriptRunner for Jira for Server/DC to Cloud using the [Jira Cloud Migration Assistant](https://docs.adaptavist.com/sr4js/latest/scriptrunner-migration/scriptrunner-migration-to-cloud/migration-checklist#migrate-scriptrunner-with-jira-cloud-migration-assistant--en), when you navigate to ScriptRunner → Migration Reports, you are presented with a landing screen that links to our product documentation.

Once you have completed your migration from ScriptRunner for Jira for Server/DC to Cloud using the [Jira Cloud Migration Assistant](https://docs.adaptavist.com/sr4js/latest/scriptrunner-migration/scriptrunner-migration-to-cloud/migration-checklist#migrate-scriptrunner-with-jira-cloud-migration-assistant--en), you can view a migration report that provides information about any items that failed to migrate and the reason for failure.

1.  Navigate to ScriptRunner > Migration Reports.
2.  Click on Migration Reports in the left-hand menu of your ScriptRunner for Jira Cloud instance and the _Migration Reports_ screen appears.
    
3.  Click on the Download Report link to download a CSV-format copy of the migration report.

### Failed or Incompatible Migrations

When reviewing the downloaded CSV file data, you may see messages informing you of failed or incompatible migration issues. For example:

<table class="table" id="failed-or-incompatible-migrations--en__generated-table-id-1"><caption></caption><colgroup><col><col></colgroup><thead class="thead"><tr class="row"><th class="entry" id="failed-or-incompatible-migrations--en__generated-table-id-1__entry__1">Message</th><th class="entry" id="failed-or-incompatible-migrations--en__generated-table-id-1__entry__2">Definition</th></tr></thead><tbody class="tbody"><tr class="row"><td class="entry" headers="failed-or-incompatible-migrations--en__generated-table-id-1__entry__1 failed-or-incompatible-migrations--en__generated-table-id-1__entry__2 "><em class="ph i"><span class="ph b">Incompatible with cloud, unable to store</span></em>&#10;                            </td><td class="entry" headers="failed-or-incompatible-migrations--en__generated-table-id-1__entry__1 failed-or-incompatible-migrations--en__generated-table-id-1__entry__2 ">It may be the case that a ScriptRunner Server/Data Centre <a class="xref" href="https://docs.adaptavist.com/db/organizations/adaptavist/repositories/master/content/documents/Adaptavist_Content/ScriptRunner/ScriptRunner_for_Jira_Cloud_SR4JC/topics/jql_query_comparison.dita">JQL function</a> does not have <a class="xref" href="feature-parity-and-script-alternatives.md">feature parity</a> in ScriptRunner Cloud so part of that particular query doesn't work in Cloud. </td></tr><tr class="row"><td class="entry" headers="failed-or-incompatible-migrations--en__generated-table-id-1__entry__1 failed-or-incompatible-migrations--en__generated-table-id-1__entry__2 "> <em class="ph i"><span class="ph b">Failed to update filter</span></em>&#10;                            </td><td class="entry" headers="failed-or-incompatible-migrations--en__generated-table-id-1__entry__1 failed-or-incompatible-migrations--en__generated-table-id-1__entry__2 ">&#10;                                <p class="p">Here, an attempt was made to change a migrated filter to make it work in Cloud, but Jira has rejected that filter. There are some specific reasons for this:</p>&#10;                                <ul class="ul"><li class="li">Jira users that were migrated belong to a group that hasn't been granted product access yet</li><li class="li">a filter name is duplicated</li><li class="li">we have a reference to a filter that wasn't actually migrated</li><li class="li">another Jira error message that would be included in the migration report</li></ul>&#10;                            </td></tr><tr class="row"><td class="entry" headers="failed-or-incompatible-migrations--en__generated-table-id-1__entry__1 failed-or-incompatible-migrations--en__generated-table-id-1__entry__2 "> <em class="ph i"><span class="ph b">Failed to migrate unsupported in cloud configuration</span></em>&#10;                            </td><td class="entry" headers="failed-or-incompatible-migrations--en__generated-table-id-1__entry__1 failed-or-incompatible-migrations--en__generated-table-id-1__entry__2 ">This message can show in the migration report when a given <a class="xref" href="https://docs.adaptavist.com/sr4jc/latest/features/workflow-rules/perform-actions">Perform Action</a> is not supported in Cloud. The list of supported functions in Cloud can be found in our <a class="xref" href="feature-parity-and-script-alternatives.md">documentation</a>.<p class="p">ScriptRunner will automatically remove unsupported Scriptrunner workflow rules from your Cloud instance</p></td></tr></tbody></table>

## Pitfalls

There are some pitfalls, or known issues, you should be aware of when migrating from ScriptRunner for Jira Server/Data Center to Cloud.

For example, there may be instances where a JQL function on a server needs to be converted to a Cloud JQL keyword.

### Asynchronous Event Processing

Asynchronous execution of functions and events means that any updates performed by scripts will happen after the page loads for the user. However, ScriptRunner has a feature that will notify users when issues have been updated. The order of event processing is not preserved, so when multiple scripts are triggered from the same event the ordering is arbitrary and will likely not be consistent.

### Event Triggering

Updates made in scripts will cause events to be fired. This means that Script Listeners need to check values before updating them as the script may trigger due to a previous invocation of the same script.

### Edit Screen

When using the edit issue API, fields must be visible on the Edit screen for the issue to be modified.

## Cloud Logs

Logging in scripts is very helpful when debugging. For Cloud scripts, anything printed to stdout using `println` or a `[logger.info](http://logger.info/) ('message')` call will be available on the [Logs](https://docs.adaptavist.com/sr4jc/latest/manage-app/review-logs#script-logs--en) page. You'll find these in the [Execution History](../../../cloud/manage-app/execution-history.md) of [Script Listeners](../../../cloud/features/script-listeners.md) and [Workflow Rules](../../../cloud/features/workflow-rules.md). Using assertions can also help when debugging and diagnosing the behavior of scripts.
