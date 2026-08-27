# Troubleshoot ScriptRunner Migration

- Platform: cloud
- Space: SR4JC
- Hierarchy: scriptrunner-migration-to-cloud
- Doc ID: doc-sr4jc-284330262
- Source: https://docs.adaptavist.com/sr4jc/latest/scriptrunner-migration-to-cloud/troubleshoot-scriptrunner-migration

Feature Differences

ScriptRunner for Jira Cloud **does not have the same feature set** as the Server/Data Center version.  Our [Feature Parity table](https://docs.adaptavist.com/sr4jc/latest/scriptrunner-migration-to-cloud/feature-parity-and-script-alternatives) provides information about each individual ScriptRunner for Server/Data Center feature's parity. We also provide details on workaround script/function alternatives where there is currently no parity with Cloud.

Try our migration tools!

The ScriptRunner Migration Suite is a suite of tools that helps you plan, analyse, convert and deploy scripts with confidence, significantly reducing the manual migration effort. It supports (not replaces) your expertise. The suite is made up of three tools: 

-   [ScriptRunner Migration Analyse and Assess Tool](https://docs.adaptavist.com/sms/latest/scriptrunner-migration-suite-web-app/scriptrunner-migration-analyse-and-assess-tool): Use this tool to review your ScriptRunner Data Center scripts and configurations for risks and cloud readiness.
-   [The ScriptRunner Migration Agent](https://docs.adaptavist.com/sms/latest/scriptrunner-migration-suite-web-app/scriptrunner-migration-agent): Use our specialised AI chat agent to create, convert, and optimise scripts, or you can use it to answer a variety of different questions about ScriptRunner.
-   [ScriptRunner Dev and Deployment Tool](https://docs.adaptavist.com/sms/latest/scriptrunner-dev-and-deployment-tool): Use this tool to organise and deploy ScriptRunner Cloud scripts. It is focused on making it easier and faster for consultants and developers to migrate, test, and deploy scripts from ScriptRunner DC to Cloud.

If you have any questions, need help, or would like to request access, the quickest way to get assistance is through our [dedicated support portal](https://the-adaptavist-group-support.atlassian.net/servicedesk/customer/portal/1069/user/login?destination=portal%2F1069).

Jira's Parent field

If you've renamed or customized the **Epic Link** default field in your Jira instance, you may notice issues with epic-related queries in [ScriptRunner Enhanced Search](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search), such as:

-   Failures with getting automatic syncing and the most up-to-date results.
    
-   Epic-related [JQL functions](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-functions) (e.g., `epicsOf, linkedIssuesOf`) not returning expected results.
    

Atlassian has deprecated the **Epic Link** field and now recommends using the **Parent** property to link to epics. Since the **Epic Link** field was customizable, any epic fields that you have renamed or customized are no longer supported in JQL queries.

You can use this section to learn about some known issues and common issues surrounding migrations to ScriptRunner for Jira Cloud from Server and understand how to use reports if you encounter a failed migration.

## Common Issues with ScriptRunner Enhanced Search Server to Cloud Filter Migration

### My filter has not migrated to the ScriptRunner Enhanced Search for Jira Cloud app

Filters will not migrate from Server to the ScriptRunner Enhanced Search for Jira Cloud app for the following reasons:

-   The filter does **not** contain any ScriptRunner Enhanced Search for Jira Cloud [JQL functions](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-functions) or [keywords](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-keywords).
    
    -   These filters will remain as Jira filters, and not be migrated to the ScriptRunner Enhanced Search app.
        
-   The filter contains nested functions such as, `issueFunction in linkedIssuesOf(issueFunction in epicsOf(project=TEST))`
    
    -   ScriptRunner Enhanced Search for Jira Cloud does not currently support nested Enhanced Search functions, as outlined in our [Feature Parity table](https://docs.adaptavist.com/sr4jc/latest/scriptrunner-migration-to-cloud/feature-parity-and-script-alternatives). However, if you would like to request this feature, you can add your request to our nolt board [here](https://scriptrunner-for-jira-cloud.nolt.io/ "https://scriptrunner-for-jira-cloud.nolt.io/").
        
-   The filter contains any Enhanced Search functions or keywords that are not compatible with the Cloud version.
    
    -   Refer to [Feature Parity and Script Alternatives](https://docs.adaptavist.com/sr4jc/latest/scriptrunner-migration-to-cloud/feature-parity-and-script-alternatives) for details on which specific functions or keywords are not compatible.
        
-   The filter owner does not exist or does not have the correct [permissions](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/jql-sync-status-and-add-on-user-permissions). 
    
    -   Ensure that you have migrated your users successfully.
        

When migrating to Cloud using the [Jira Cloud Migration Assistant](https://docs.adaptavist.com/sr4jc/latest/scriptrunner-migration-to-cloud/migration-checklist#id-.MigrationChecklistvDraft-MigrateScriptRunnerwithJiraCloudMigrationAssistant), it is important to note that even if equivalent functions exist, filters that contain invalid or unparseable Jira Cloud JQL will not be normalized and may cause errors in Enhanced Search. 

For example, a JQL query in Jira Data Center that escapes double quotes using backslashes, such as `issueFunction in issuesInEpics("\"project\" = \"SLASH\""),` is valid in Jira Data Center but can cause issues during migration to Jira Cloud. To avoid problems during migration, we recommend the following:

-   Update these queries prior to migration by replacing escaped double quotes with a Jira Cloud-compatible format (for example, using single quotes where applicable). 
-   If the filter owners cannot be migrated, transfer ownership of the filters in your Jira Data Center instance before completing the migration.
-   Ensure that the original filter owner in Jira Cloud is an active user with access to the Jira Cloud instance, as well as to any groups or projects with which the filters are shared.

### Enhanced Search filters are not syncing or displaying the correct issue results after migration

#### Filter owners must be given access to the instance

The filter owner user must have access to the Cloud instance to sync Enhanced Search filters. If the user does not have access, the filter will not sync. To ensure that filters are automatically synced and can return the correct results, ensure that all your filter owner users are given access to the ScriptRunner Enhanced Search for Jira Cloud instance. You can find out more information in [Atlassian's documentation](https://support.atlassian.com/migration/docs/migrate-users-and-groups/). 

#### Filter owners must be given access to any groups and projects they share their filters with

If a filter is shared with a group or project in Jira, but the filter owner cannot access that group in the target instance, the filter may not be synced. Users should be given the required access, or the filters should be updated to reference the correct groups or projects that are accessible to the filter owner.

#### Filters must have been used in the last two months

Atlassian stores a property against all Jira filters, called `approximateLastUsed`. This is a timestamp indicating when the filter was last evaluated, meaning the last time the filter was used to execute a search and generate results. If a filter's timestamp exceeds two months, we do not sync that filter. The filter will be synced again only when it is used, and Atlassian updates the `approximateLastUsed` timestamp to ensure optimal filter syncing performance on your instance.

## Why do I see _“Your query may take some time”_ when performing a search?

Cloud infrastructure is very different to Server infrastructure, so it is not possible to compute queries in Cloud in the same way as in Server environments. This means, if you use a search query that requires fetching data from a very high volume of issues, your query may not complete.

If your search takes longer than two minutes to process, it will time out. Complex search queries can take much longer to complete in Cloud than in the Server environment. This two minute searching limit is in place to ensure optimal performance and to cause minimal disruption to your instance.

To prevent your search timing out, it is important to narrow your JQL query scope to ensure that issue results can be processed within two minutes. This can easily be done by narrowing the JQL query scope in your ScriptRunner Enhanced Search function by project, for example:

`issueFunction in linkedIssuesOf(“project in (TEST, TEST2) and status in ('In Progress')“)`

We have provided some [Tips for Writing JQL Queries](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-queries/tips-for-writing-jql-queries) for your reference. If you are still having trouble crafting your Enhanced Search query, you can contact us via the [Adaptavist Product Support Portal](https://the-adaptavist-group-support.atlassian.net/servicedesk/customer/portal/19). 

## Why do I see the _“Field 'issueFunction' does not exist or you do not have permission to view it”_ error message in Jira?

You cannot successfully execute a search with the Enhanced Search JQL functions directly into the Jira issue search page. 

-   Jira's built-in search does not support the advanced JQL functions provided by Enhanced Search.
-   If you try to copy-paste an Enhanced Search query into the standard Jira search bar, it will not work because the native JQL engine does not recognise those functions.

![](/sr4jc/files/latest/284330262/335380537/1/1740650339000/error+message+field+issue1.png)

ScriptRunner Enhanced Search for Jira Cloud [JQL functions](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-functions) must be executed in a search from **within** the Enhanced Search app as they cannot be used directly in the Jira issue search page (also known as the Issue Navigator).

![](/sr4jc/files/latest/284330262/335380538/1/1740049284000/troubleshoot+migrate.png)

You can still use the Enhanced Search filter within other parts of Jira, for example as a board filter, but it must be created and managed from within the ScriptRunner Enhanced Search for Jira Cloud app itself.

We are actively working on a solution to enable the use of ScriptRunner Enhanced Search JQL functions in the native Jira issue search page, with availability planned for 2026.

## Migration Reports

If you have yet to complete migrating from ScriptRunner for Jira for Server/DC to Cloud using the [Jira Cloud Migration Assistant](https://docs.adaptavist.com/sr4jc/latest/scriptrunner-migration-to-cloud/migration-checklist), when you navigate to **ScriptRunner → Migration Reports,** you are presented with a landing screen that links to our product documentation.  
![](/sr4jc/files/latest/284330262/335380541/1/1739977614000/check+out+your+migration+reports.jpeg)

Once you have completed your migration from ScriptRunner for Jira for Server/DC to Cloud using the [Jira Cloud Migration Assistant](https://docs.adaptavist.com/sr4jc/latest/scriptrunner-migration-to-cloud/migration-checklist), you can view a migration report that provides information about any items that failed to migrate and the reason for failure.

1.  Navigate to **ScriptRunner → Migration Reports**.
2.  Click on **Migration Reports** in the left-hand menu of your ScriptRunner for Jira Cloud instance and the _Migration Reports_ screen appears.![](/sr4jc/files/latest/284330262/335380542/1/1739977614000/migration+report+list.jpg)
3.  Click on the **Download Report** link to download a CSV-format copy of the migration report.

### Failed or Incompatible Migrations

When reviewing the downloaded CSV file data, you may see messages informing you of failed or incompatible migration issues. For example:

Message

Definition

**_Incompatible with cloud, unable to store_**

It may be the case that a ScriptRunner Server/Data Centre [JQL function](https://docs.adaptavist.com/sr4jc/latest/scriptrunner-migration-to-cloud/platform-differences-between-scriptrunner-for-jira-server-dc-and-jira-cloud/jql-query-comparison) does not have [feature parity](https://docs.adaptavist.com/sr4jc/latest/scriptrunner-migration-to-cloud/feature-parity-and-script-alternatives) in ScriptRunner Cloud so part of that particular query doesn't work in Cloud. 

**_Failed to update filter_**

Here, an attempt was made to change a migrated filter to make it work in Cloud, but Jira has rejected that filter. There are some specific reasons for this:

-   Jira users that were migrated belong to a group that hasn't been granted product access yet
-   a filter name is duplicated 
-   we have a reference to a filter that wasn't actually migrated 
-   another Jira error message that would be included in the migration report

**_Failed to migrate unsupported in cloud configuration_**

This message can show in the migration report when a given [post function](https://docs.adaptavist.com/sr4jc/latest/features/workflow-rules/perform-actions) is not supported in Cloud. The list of supported functions in Cloud can be found in our [documentation](https://docs.adaptavist.com/sr4jc/latest/scriptrunner-migration-to-cloud/platform-differences-between-scriptrunner-for-jira-server-dc-and-jira-cloud/function-name-differences).

ScriptRunner will automatically remove unsupported Scriptrunner workflow rules from your Cloud instance

## Pitfalls

There are some pitfalls, or known issues, you should be aware of when migrating from ScriptRunner for Jira Server/Data Center to Cloud.

For example, there may be instances where a JQL function on a server needs to be converted to a Cloud JQL keyword.

### Asynchronous Event Processing

Asynchronous execution of functions and events means that any updates performed by scripts will happen after the page loads for the user. However, ScriptRunner has a feature that will notify users when issues have been updated. The order of event processing is not preserved, so when multiple scripts are triggered from the same event the ordering is arbitrary and will likely not be consistent.

### Event Triggering

Updates made in scripts will cause events to be fired. This means that Script Listeners need to check values before updating them as the script may trigger due to a previous invocation of the same script.

### Edit Screen

When using the edit issue API, fields must be visible on the Edit screen for the issue to be modified.

## Cloud Logs

Logging in scripts is very helpful when debugging. For Cloud scripts, anything printed to stdout using `println` or a `[logger.info](http://logger.info)('message')` call will be available on the [Logs](https://docs.adaptavist.com/sr4jc/latest/manage-app/review-logs#script%20logs) page. You'll find these in the [Execution History](https://docs.adaptavist.com/sr4jc/latest/manage-app/execution-history) of [Script Listeners](https://docs.adaptavist.com/sr4jc/latest/features/script-listeners) and [Workflow Functions](https://docs.adaptavist.com/sr4jc/latest/features/workflow-rules). Using assertions can also help when debugging and diagnosing the behavior of scripts.
