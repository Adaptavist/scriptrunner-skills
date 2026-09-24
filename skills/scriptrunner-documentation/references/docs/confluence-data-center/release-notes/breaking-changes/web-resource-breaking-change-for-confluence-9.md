# Web Resource Breaking Change for Confluence 9

- Platform: confluence-data-center
- Space: SR4C
- Hierarchy: Release Notes > Breaking changes
- Doc ID: doc-sr4c-c23aa90d-bb1b-41ea-9851-f1fcd475e8a5-09175c59bedabe8e
- Source: https://docs.adaptavist.com/sr4c/latest/release-notes/breaking-changes#web-resource-breaking-change-for-confluence-9--en

Information about using web resources in Confluence 9.

Starting with [Confluence 9.0](https://docs.adaptavist.com/sr4c/latest/get-started/update/compatibility-with-confluence), you will no longer be able to configure a custom web resource directory for storing your resource files (such as custom JavaScript or css files). All web resources should now be kept in `web-resources/com.onresolve.confluence.groovy.groovyrunner.` This path is located in the Confluence Shared home directory if you have a shared home directory configured (such as when using clustered configuration). Otherwise it will be in the default home directory. For more information on shared home directory configuration please refer to [Atlassian documentation](https://confluence.atlassian.com/doc/confluence-home-and-other-important-directories-590259707.html).

If you were previously using custom directories for the value of the JVM property named `plugin.resource.directories`, you will have to move your custom resource files to the new `web-resources/com.onresolve.confluence.groovy.groovyrunner` directory.

## Move your scripts

When you upgrade to Confluence 9.x and log into ScriptRunner you will receive an action notification if you have any resources in the wrong location:

When you select Show files to migrate you are shown a list of all files that must be migrated to the new directory:

You can migrate each file as follows:

1.  Locate the file(s) in the current directory/directories that you have configured for the `plugin.resource.directories` property.
2.  Copy the file(s) to the new web resource directory ( `web-resources/com.onresolve.confluence.groovy.groovyrunner`).
3.  Verify that the file(s) have been copied to the new directory.
4.  Delete the original file(s) from the old directory.
5.  Once all files have been migrated you can remove the `plugin.resource.directories` entry from your JVM\_REQUIRED\_ARGS or CATALINA\_OPTS values.
