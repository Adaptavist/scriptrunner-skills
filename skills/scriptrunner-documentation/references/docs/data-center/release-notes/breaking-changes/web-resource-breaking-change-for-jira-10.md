# Web Resource Breaking Change for Jira 10

- Platform: data-center
- Space: SR4JS
- Hierarchy: release-notes > breaking-changes
- Doc ID: doc-sr4js-280527095
- Source: https://docs.adaptavist.com/sr4js/latest/release-notes/breaking-changes/web-resource-breaking-change-for-jira-10

Starting with [Jira 10.0](https://docs.adaptavist.com/sr4js/latest/get-started/update-scriptrunner/compatibility-with-jira), you will no longer be able to configure a custom web resource directory for storing your resource files (such as custom JavaScript or css files). All web resources should now be kept in `web-resources/com.onresolve.jira.groovy.groovyrunner.` This path is located in the Jira **Shared home** directory if you have a shared home directory configured (such as when using clustered configuration). Otherwise it will be in the default home directory. For more information on shared home directory configuration please refer to [Atlassian documentation](https://confluence.atlassian.com/adminjiraserver/jira-application-home-directory-938847746.html).

If you were previously using custom directories for the value of the JVM property named `plugin.resource.directories`, you will have to move your custom resource files to the new ``web-resources/com.onresolve.`jira`.groovy.groovyrunner`` directory.

## Move your scripts

When you upgrade to Jira 10.x and log into ScriptRunner you will receive an action notification if you have any resources in the wrong location:  
![](/sr4js/files/latest/280527095/284328681/1/1725031426000/Web_resources_Jira_1.png)

When you select **Show files to migrate** you are shown a list of all files that must be migrated to the new directory:

![](/sr4js/files/latest/280527095/284328682/1/1725031426000/Web_resource_Jira_2.png)

You can migrate each file as follows:

1.  Locate the file(s) in the current directory/directories that you have configured for the `plugin.resource.directories` property.
2.  Copy the file(s) to the new web resource directory (`web-resources/com.onresolve.jira.groovy.groovyrunner`).
3.  Verify that the file(s) have been copied to the new directory. 
4.  Delete the original file(s) from the old directory.
5.  Once all files have been migrated you can remove the `plugin.resource.directories` entry from your JVM\_REQUIRED\_ARGS or CATALINA\_OPTS values.
