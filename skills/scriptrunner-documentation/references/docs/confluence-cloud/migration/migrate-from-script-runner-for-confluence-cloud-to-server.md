# Migrate from ScriptRunner for Confluence Cloud to Server

- Platform: confluence-cloud
- Space: SR4CC
- Hierarchy: Migration
- Doc ID: doc-sr4cc-113d5457-8d92-4d06-a98f-5f0fd03b1604-3acdf10f31767e89
- Source: https://docs.adaptavist.com/sr4cc/latest/migration/migrate-from-scriptrunner-for-confluence-cloud-to-server

Warning: If you have any custom scripts, they will have to be rewritten in the migration.

The process of migrating from Cloud to Server is a more straight forward procedure, but care still has to be taken. All ScriptRunner features in the Cloud version are available in the Server edition. The process for migration follows the same general path of discovery, analysis, and implementation. Much of the migration approach for Server to Cloud also applies to Cloud to Server. Follow these general steps for migration:

1.  Find all scripts in ScriptRunner for Confluence Cloud and analyse the functionality.
2.  Port each script from the REST API into the Java API.

The ScriptRunner for Confluence Server documentation has examples and guides for implementing scripts.
