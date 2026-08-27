# Working with Project Configurator and ScriptRunner for Jira - Synchronous Exports

- Platform: data-center
- Feature: export
- Tags: automate, system, synchronous
- Language: groovy
- Doc ID: example-dataCenter-project-configurator-synchronous-export-onPrem
- Source: https://examples.scriptrunner.io/scripts/project-configurator-synchronous-export-onPrem

## Overview

Synchronously export the details of selected projects from Jira using Project Configurator.

## Example

As a project developer, I want to copy information about specific projects to another instance. Using this synchronous
method, I can export the data from one instance. I can then use this exported data to import project details into another instance.

## Good to Know

* If most of your operations will run in a limited time you might be fine just using this synchronous method.

## Script

```groovy
// Required Imports
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.task.TaskProgressSink
import com.awnaba.projectconfigurator.operationsapi.ProjectConfigExporter
import com.onresolve.scriptrunner.runner.customisers.WithPlugin
import groovy.xml.MarkupBuilder

// The required annotation to enable access to the functionality provided by the plugin within our script.
@WithPlugin('com.awnaba.projectconfigurator.projectconfigurator')

// Get an instance of the export method
def exporter = ComponentAccessor.getOSGiComponentInstanceOfType(ProjectConfigExporter)

def stringWriter = new StringWriter()
def content = new MarkupBuilder(stringWriter)

try {
// Define the project keys to be exported in the set below
    def projectKeys = ['DEMO', 'OTHER'].toSet()

// Define the options for how you want to configure the export.
    def exportOptions = [
        'filterCFMode'           : 'filterUnusedCFExtended', // Options: none, filterUnusedCFExtended, all
        'jiraFilterExportMode'   : 'none', // Options: none, global, projects, global-or-projects, shared, all
        'jiraDashboardExportMode': 'none', // Options: none, global, projects, global-or-projects, shared, all
        'agileBoardsExportMode'  : 'none' // Options: none, projects, all
    ]

// Run the export synchronously using the options specified above
    def export = exporter.exportSynchronous(exportOptions, projectKeys, TaskProgressSink.NULL_SINK)
    def exportFinalResult = export.finalResult
    def exportCall = export.callResult

// Check if the export completed successfully and if so generate the XML file
// If the export failed notify the user
    (exportFinalResult == null || exportFinalResult.returnCode != ProjectConfigExporter.ReturnOpCode.SUCCESS) ?
        content.html { p("The export did not complete successfully: ${exportFinalResult == null ? exportCall.returnCode : exportFinalResult.returnCode}") } :
        // If the export was successful notify the user where the file is stored
        content.html { p("Export file created at $exportFinalResult.exportedResultFile.path") }

    return stringWriter.toString()
} catch (Exception e) {
    content.html {
        p('An unexpected error occurred. Please check your atlassian-jira.log for more information')
        p(e)
    }
    return stringWriter.toString()
}
```

