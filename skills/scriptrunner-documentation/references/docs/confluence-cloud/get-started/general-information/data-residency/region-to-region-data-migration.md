# Region-to-Region Data Migration

- Platform: confluence-cloud
- Space: SR4CC
- Hierarchy: Get Started > General Information > Data Residency
- Doc ID: doc-sr4cc-276b6f95-8368-4ac5-a991-8ff0b2172702-0f78aa73c51548e3
- Source: https://docs.adaptavist.com/sr4cc/latest/get-started/general-information/data-residency#region-to-region-data-migration--en

Details about data migration.

Atlassian will notify us if the region in which your Confluence Cloud is hosted has changed. To align with this change, we will move your ScriptRunner for Confluence Cloud data to the same geographical region in which your Confluence is hosted.

## Data Migration Timeline

The following outlines the order in which we transfer your data:

1.  All ScriptRunner scripts are migrated first; this should only take a few seconds.
2.  Script and audit logs are migrated second. These are migrated in reverse-chronological order, with the newest logs being moved first. The time taken to migrate logs is dependent on the volume of data; these can take up to a few hours to fully migrate. New script logs and audit log records will appear immediately and are not impacted by the data migration.
3.  Data stored in the previous region will be removed within a few days of data migration.

Note: ScriptRunner settings are stored within Confluence Cloud and don't need moving.
