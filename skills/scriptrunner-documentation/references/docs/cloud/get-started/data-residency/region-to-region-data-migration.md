# Region-to-Region Data Migration

- Platform: cloud
- Space: SR4JC
- Hierarchy: get-started > data-residency
- Doc ID: doc-sr4jc-115709161
- Source: https://docs.adaptavist.com/sr4jc/latest/get-started/data-residency/region-to-region-data-migration

If you change the region in which your Jira Cloud is hosted, you can also choose to move ScriptRunner to the same region (if supported). Atlassian will then notify us of the request, and we will move your ScriptRunner for Jira Cloud data to the same geographical region in which your Jira is hosted.

For more information on Data Residency and what it means for you, see our [Data Residency](https://docs.adaptavist.com/sr4jc/latest/get-started/data-residency) documentation.

Advance Notice: Connect Data Residency Customer Rollout

Refer to [Atlassian's blog](https://community.developer.atlassian.com/t/advance-notice-connect-data-residency-customer-rollout/66930/1) to find out details regarding realm pinning and realm migration including the proposed timelines.

## Data Migration Timeline

The following outlines the order in which we transfer your data: 

1.  All ScriptRunner scripts are migrated first; this should only take a few seconds. 
2.  Script and audit logs are migrated second. These are migrated in reverse-chronological order, with the newest logs being moved first. The time taken to migrate logs is dependent on the volume of data; these can take up to a few hours to fully migrate. New script logs and audit log records will appear immediately and are not impacted by the data migration.
3.  Data stored in the previous region will be removed within a few days of data migration.
    

ScriptRunner settings are stored within Jira Cloud and don’t need moving.
