# Migrating to Data Center

- Platform: confluence-data-center
- Space: SR4C
- Hierarchy: Migration
- Doc ID: doc-sr4c-5314ea5e-12a2-40ea-a495-3396768c8e11-853b259fd35cefc1
- Source: https://docs.adaptavist.com/sr4c/latest/migration#migrating-to-data-center--en

Information on migrating from ScriptRunner for Confluence Cloud to Data Center.

There are two main migration types:

-   Non-clustered
-   Clustered

## Non-clustered

Migrating from Server to a non-clustered Data Center instance requires you to update your platform from a Server license to a Data Center license.

With regards to ScriptRunner, the only change required is to update ScriptRunner to a Data Center license. You should request a Data Center license from the vendor/partner before beginning any migration.

Please [contact us](https://www.adaptavist.com/contact) if you have questions about this.

## Clustered

As well as the steps required for a non-clustered instance, a clustered setup requires you to move your home directory to a shared location that all nodes can access. The process of moving your home directory is described in [Atlassian's guide](https://confluence.atlassian.com/doc/set-up-a-confluence-data-center-cluster-982322030.html). When following Atlassian's guide for ScriptRunner, you must also include the `scripts` and the `scriptrunner` directory when completing step 2 (Create a shared home directory) of the _Set up and configure your cluster_ section.

## Additional considerations

### Additional script roots

If you have custom script roots configured and are moving to a clustered Data Center setup, you need to make sure your custom script roots are available to all nodes in the cluster.

### ScriptRunner features and inline scripts

If you follow the Atlassian Data Center migration process, the database that all nodes use should remain the same. ScriptRunner feature configurations and inline scripts are stored in the database, so are not impacted by the migration and should be available on all nodes automatically.

Note: To maintain execution history for a clustered Data Center setup, you must move the `<platformHome>/scriptrunner` directory to the shared drive.

For more complex migration cases, or for help getting a Data Center license, please [contact us](https://www.adaptavist.com/contact).
