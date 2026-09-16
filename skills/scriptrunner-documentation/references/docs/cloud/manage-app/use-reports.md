# Use Reports

- Platform: cloud
- Space: SR4JC
- Hierarchy: Manage App
- Doc ID: doc-sr4jc-9beb0b41-aced-4fe5-822b-c29e4aab6cee-63614e032e65efc8
- Source: https://docs.adaptavist.com/sr4jc/latest/manage-app/use-reports

ScriptRunner for Jira Cloud provides you with two reports; Migration and Deprecation.

## Migration report

If you have yet to complete migrating from ScriptRunner for Jira for Server/DC to Cloud using the [Jira Cloud Migration Assistant](../script-runner-migration-to-cloud/migration-checklist.md), when you navigate to ScriptRunner > Migration Reports, you are presented with a landing screen that links to our product documentation.

Once you have completed your migration from ScriptRunner for Jira for Server/DC to Cloud using the [Jira Cloud Migration Assistant](../script-runner-migration-to-cloud/migration-checklist.md), you can view a migration report that provides information about any items that failed to migrate and the reason for failure.

1.  Navigate to ScriptRunner > Migration Reports.
2.  Click on Migration Reports in the left-hand menu of your ScriptRunner for Jira Cloud instance and the _Migration Reports_ screen appears.
    
3.  Click on the Download Report link to download a CSV-format copy of the migration report.

### Failed or Incompatible Migrations

When reviewing the downloaded CSV file data, you may see messages informing you of failed or incompatible migration issues. For example:

<table class="table" id="failed-or-incompatible-migrations--en__generated-table-id-1"><caption></caption><colgroup><col><col></colgroup><thead class="thead"><tr class="row"><th class="entry" id="failed-or-incompatible-migrations--en__generated-table-id-1__entry__1">Message</th><th class="entry" id="failed-or-incompatible-migrations--en__generated-table-id-1__entry__2">Definition</th></tr></thead><tbody class="tbody"><tr class="row"><td class="entry" headers="failed-or-incompatible-migrations--en__generated-table-id-1__entry__1 failed-or-incompatible-migrations--en__generated-table-id-1__entry__2 "><em class="ph i"><span class="ph b">Incompatible with cloud, unable to store</span></em>&#10;                            </td><td class="entry" headers="failed-or-incompatible-migrations--en__generated-table-id-1__entry__1 failed-or-incompatible-migrations--en__generated-table-id-1__entry__2 ">It may be the case that a ScriptRunner Server/Data Centre <a class="xref" href="https://docs.adaptavist.com/db/organizations/adaptavist/repositories/master/content/documents/Adaptavist_Content/ScriptRunner/ScriptRunner_for_Jira_Cloud_SR4JC/topics/jql_query_comparison.dita">JQL function</a> does not have <a class="xref" href="../script-runner-migration-to-cloud/feature-parity-and-script-alternatives.md">feature parity</a> in ScriptRunner Cloud so part of that particular query doesn't work in Cloud. </td></tr><tr class="row"><td class="entry" headers="failed-or-incompatible-migrations--en__generated-table-id-1__entry__1 failed-or-incompatible-migrations--en__generated-table-id-1__entry__2 "> <em class="ph i"><span class="ph b">Failed to update filter</span></em>&#10;                            </td><td class="entry" headers="failed-or-incompatible-migrations--en__generated-table-id-1__entry__1 failed-or-incompatible-migrations--en__generated-table-id-1__entry__2 ">&#10;                                <p class="p">Here, an attempt was made to change a migrated filter to make it work in Cloud, but Jira has rejected that filter. There are some specific reasons for this:</p>&#10;                                <ul class="ul"><li class="li">Jira users that were migrated belong to a group that hasn't been granted product access yet</li><li class="li">a filter name is duplicated</li><li class="li">we have a reference to a filter that wasn't actually migrated</li><li class="li">another Jira error message that would be included in the migration report</li></ul>&#10;                            </td></tr><tr class="row"><td class="entry" headers="failed-or-incompatible-migrations--en__generated-table-id-1__entry__1 failed-or-incompatible-migrations--en__generated-table-id-1__entry__2 "> <em class="ph i"><span class="ph b">Failed to migrate unsupported in cloud configuration</span></em>&#10;                            </td><td class="entry" headers="failed-or-incompatible-migrations--en__generated-table-id-1__entry__1 failed-or-incompatible-migrations--en__generated-table-id-1__entry__2 ">This message can show in the migration report when a given <a class="xref" href="https://docs.adaptavist.com/sr4jc/latest/features/workflow-rules/perform-actions">Perform Action</a> is not supported in Cloud. The list of supported functions in Cloud can be found in our <a class="xref" href="../script-runner-migration-to-cloud/feature-parity-and-script-alternatives.md">documentation</a>.<p class="p">ScriptRunner will automatically remove unsupported Scriptrunner workflow rules from your Cloud instance</p></td></tr></tbody></table>

## Deprecation reports

You can view a report that runs every 24 hours and highlights any Atlassian deprecations in your instance. To view the report:

1.  Navigate to ScriptRunner > Deprecation Reports.
2.  Click Deprecation Reports in the left-hand menu of your ScriptRunner for Jira Cloud instance.
    
    You will see tabbed report types from which you can choose, including: REST Search Endpoints, Epic/Parent Link Fields, Missing Event Properties, and Response Body Links.
    
    The reports highlight ScriptRunner for Jira Cloud features that contain any Atlassian-deprecated endpoints, fields, or event types that have been detected in your instance. Each report highlights the deprecated script _Name_ and _UUID_. If there are workflow-related scripts, you will also see a _Workflow Name_ link. Similarly, if there are specific _Event types_ in the _Missing Event Properties_ report, you can open the corresponding links to see the details.
    
    When scripts in your instance match deprecated endpoints, fields, or event types, a red numerical indicator appears on the report tab. As shown in the image above, the _REST Search Endpoints_ report has identified one script. Details are provided in the expanded area below, where we can see the related Script Listener.
    
    Note: No scripts found
    
    If no deprecated endpoints, fields, or event types are found, a message will appear in each report informing you of this.
    
3.  Optional: Click the links provided to go directly to the scripts.
    
    You can now modify these scripts as required. Any items listed in the report will remain there until the related script is updated.
    
4.  Optional: Click Download CSV to download a copy of the report.
