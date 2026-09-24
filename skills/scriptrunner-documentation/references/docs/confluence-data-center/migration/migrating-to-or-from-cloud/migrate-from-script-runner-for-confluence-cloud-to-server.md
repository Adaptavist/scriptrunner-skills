# Migrate from ScriptRunner for Confluence Cloud to Server

- Platform: confluence-data-center
- Space: SR4C
- Hierarchy: Migration > Migrating to or from Cloud
- Doc ID: doc-sr4c-8b939fda-187d-4a35-b7f9-b2b1970c89a5-b640610c1d38bc25
- Source: https://docs.adaptavist.com/sr4c/latest/migration#migrating-to-or-from-cloud--en#migrate-from-scriptrunner-for-confluence-cloud-to-server--en

The process of migrating from Cloud to Server is a more straightforward procedure, but care still has to be taken. All ScriptRunner features in the Cloud version are available in the Server edition.

Warning: If you have any custom scripts, they will have to be rewritten in the migration.

The process for migrsation follows the same general path of discovery, analysis, and implementation. Much of the migration approach for Server to Cloud also applies to Cloud to Server. Follow these general steps for migration:

1.  Find all scripts in ScriptRunner for Confluence Cloud and analyze the functionality.
2.  Port each script from the REST API into the Java API.
