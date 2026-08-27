# Export Structure Views and Custom Fields to a File

- Platform: data-center
- Feature: rest-endpoints
- Tags: administer, reporting
- Language: groovy
- Doc ID: example-dataCenter-structure-export-views-to-file-onPrem
- Source: https://examples.scriptrunner.io/scripts/structure-export-views-to-file-onPrem

## Overview

*Structure for Jira* allows you to create structures to organise issues and projects.
This script downloads a summary of the custom fields and structure views in the instance
so that you can restore them in another.

## Example

As a Jira administrator, I want to create a new Jira instance with the same structure views (and custom fields) as my current instance.
Using this script, I can backup the configuration of my current Jira instance (with structure views and custom fields) to a file so that I can replicate it on my new instance.

## Good to Know

* This script requires the [Structure for Jira plugin](https://marketplace.atlassian.com/apps/34717/structure-project-management-at-scale).
* Apart from being downloaded, the backup file is saved in the Jira export directory as well.

## Script

```groovy
import com.atlassian.jira.component.ComponentAccessor
import com.onresolve.scriptrunner.runner.customisers.PluginModule
import com.onresolve.scriptrunner.runner.customisers.WithPlugin
import com.onresolve.scriptrunner.runner.rest.common.CustomEndpointDelegate
import com.atlassian.jira.config.util.JiraHome
import groovy.transform.BaseScript
import org.apache.log4j.Level
import com.almworks.jira.structure.api.StructureComponents
import com.almworks.jira.structure.api.util.StructureUtil
import org.apache.log4j.Logger

import javax.ws.rs.core.MediaType
import javax.ws.rs.core.MultivaluedMap
import javax.ws.rs.core.Response

@BaseScript CustomEndpointDelegate delegate

@WithPlugin("com.almworks.jira.structure")
@PluginModule
StructureComponents structureComponents

// Set log level to INFO (default for REST endpoints is WARN)
def log = Logger.getLogger(getClass())
log.setLevel(Level.INFO)

def viewManager = structureComponents.viewManager
def jiraHome = ComponentAccessor.getComponent(JiraHome)

// The requesting user must be in one of these groups
final allowedGroups = ['jira-administrators']
getStructureViewsBackup(httpMethod: "GET", groups: allowedGroups) { MultivaluedMap queryParams, String body ->
    // Create the file to export in the Jira export directory
    def exportFile = new File(jiraHome.exportDirectory, 'structure_export.txt')
    exportFile.withPrintWriter { pw ->
        // Print custom fields id and name in a section
        pw.println('------- Custom Fields\n')
        def customFields = ComponentAccessor.customFieldManager.customFieldObjects
        customFields.each { field ->
            pw.println("id: ${field.id}, name: ${field.name}")
        }

        // Print structure views id, owner and JSON specification
        pw.println('\n------- Structure Views\n')
        def views = viewManager.getViews(null)
        views.each { view ->
            def spec = StructureUtil.toJson(view.specification)
            pw.println("id: ${view.id}, owner: ${view.owner}, spec:\n${spec}\n")
        }
    }

    log.info("Export file generated at export directory, path: '${exportFile.absolutePath}'")
    Response.ok(exportFile, MediaType.APPLICATION_OCTET_STREAM_TYPE)
        .header('Content-Disposition', "attachment; filename=\"${exportFile.name}\"")
        .build()
}
```

