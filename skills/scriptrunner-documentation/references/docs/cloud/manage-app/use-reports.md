# Use Reports

- Platform: cloud
- Space: SR4JC
- Hierarchy: manage-app
- Doc ID: doc-sr4jc-355468953
- Source: https://docs.adaptavist.com/sr4jc/latest/manage-app/use-reports

ScriptRunner for Jira Cloud provides you with two reports: Migration and Deprecation. 

## Migration report

If you have yet to complete migrating from ScriptRunner for Jira for Server/DC to Cloud using the [Jira Cloud Migration Assistant](https://docs.adaptavist.com/sr4jc/latest/scriptrunner-migration-to-cloud/migration-checklist), when you navigate to **ScriptRunner > Migration Reports,** you are presented with a landing screen that links to our product documentation.  
![](/sr4jc/files/latest/355468953/355468957/1/1744379786000/check+out+your+migration+reports.jpeg)

Once you have completed your migration from ScriptRunner for Jira for Server/DC to Cloud using the [Jira Cloud Migration Assistant](https://docs.adaptavist.com/sr4jc/latest/scriptrunner-migration-to-cloud/migration-checklist), you can view a migration report that provides information about any items that failed to migrate and the reason for failure.

1.  Navigate to **ScriptRunner > Migration Reports**.
2.  Click on **Migration Reports** in the left-hand menu of your ScriptRunner for Jira Cloud instance, and the _Migration Reports_ screen appears.![](/sr4jc/files/latest/355468953/355468958/1/1744379786000/migration+report+list.jpg)
3.  Click on the **Download Report** link to download a CSV-format copy of the migration report.

### Failed or incompatible migrations

When reviewing the downloaded CSV file data, you may see messages informing you of failed or incompatible migration issues. For example:

Message

Definition

**_Incompatible with Cloud, unable to store_**

It may be the case that a ScriptRunner Server/Data Centre [JQL function](https://docs.adaptavist.com/sr4jc/latest/scriptrunner-migration-to-cloud/platform-differences-between-scriptrunner-for-jira-server-dc-and-jira-cloud/jql-query-comparison) does not have [feature parity](https://docs.adaptavist.com/sr4jc/latest/scriptrunner-migration-to-cloud/feature-parity-and-script-alternatives) in ScriptRunner Cloud, so part of that particular query doesn't work in Cloud. 

**_Failed to update filter_**

Here, an attempt was made to change a migrated filter to make it work in Cloud, but Jira has rejected that filter. There are some specific reasons for this:

-   Jira users who were migrated belong to a group that hasn't been granted product access yet
-   a filter name is duplicated 
-   we have a reference to a filter that wasn't actually migrated 
-   another Jira error message that would be included in the migration report

**_Failed to migrate unsupported in cloud configuration_**

This message can show in the migration report when a given [post function](https://docs.adaptavist.com/display/SR4JC/.Post+Functions+vDraft) is not supported in Cloud. The list of supported functions in Cloud can be found in our [documentation](https://docs.adaptavist.com/sr4jc/latest/scriptrunner-migration-to-cloud/platform-differences-between-scriptrunner-for-jira-server-dc-and-jira-cloud/function-name-differences).

ScriptRunner will automatically remove unsupported ScriptRunner workflow rules from your Cloud instance

## Deprecation reports

You can view a report that runs every 24 hours and highlights any Atlassian deprecations in your instance. To view the report:

1.  Navigate to **ScriptRunner > Deprecation Reports**. 
2.  Click **Deprecation Reports** in the left-hand menu of your ScriptRunner for Jira Cloud instance. You will see tabbed report types from which you can choose, including: **REST Search Endpoints**, **Epic/Parent Link Fields,** **Missing Event Properties,** and **Response Body Links**.  
    ![](/sr4jc/files/latest/355468953/566298267/1/1784039987000/4+deprecation+reports.png)  
    The reports highlight ScriptRunner for Jira Cloud features that contain any Atlassian-deprecated endpoints, fields, or event types that have been detected in your instance. Each report highlights the deprecated script _Name_ and _UUID_. If there are workflow-related scripts, you will also see a _Workflow Name_ link. Similarly, if there are specific _Event types_ in the _Missing Event Properties_ report, you can open the corresponding links to see the details.  
      
    When scripts in your instance match deprecated endpoints, fields, or event types, a red numerical indicator appears on the report tab. As shown in the image above, the _REST Search Endpoints_ report has identified 1 script. Details are provided in the expanded area below, where we can see the related Script Listener.  
    
    No scripts found
    
    If no deprecated endpoints, fields, or event types are found, a message will appear in each report informing you of this.
    
3.  **(Optional)** Click the links provided to go directly to the scripts. You can now modify these scripts as required. Any items listed in the report will remain there until the related script is updated.
4.  **(Optional)** Click **Download CSV** to download a copy of the report.

Details on recommended alternatives for deprecated endpoints, fields, or event types can be found within our [Breaking Changes](https://docs.adaptavist.com/sr4jc/latest/release-notes/breaking-changes) section.
