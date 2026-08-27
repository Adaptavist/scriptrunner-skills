# Working with Project Configurator and ScriptRunner for Jira - Asynchronous Exports

- Platform: data-center
- Feature: script-console
- Tags: automate, system, asynchronous
- Language: groovy
- Doc ID: example-dataCenter-project-configurator-asynchronous-export-onPrem
- Source: https://examples.scriptrunner.io/scripts/project-configurator-asynchronous-export-onPrem

## Overview

Asynchronously export the details of selected projects from Jira using Project Configurator.

## Example

As a project developer, I want to copy information about specific projects to another instance. Using this asynchronous
method, I can export the data from one instance in the background, allowing me to continue working whilst the process
completes. I can then use this exported data to import project details into another instance.

## Good to Know

* With the Asynchronous mode, the operation is launched in a background thread. The progress can be queried to,
for example, display a progress bar. When it has finished, it is possible to see the result of the operation and run
tasks, such as sending a notification to the user.
* This script is a basic use case, it does not take into consideration all the operations carried out by the Synchrony.

## Script

```groovy
import com.atlassian.jira.component.ComponentAccessor
import com.awnaba.projectconfigurator.operationsapi.ExportResult
import com.awnaba.projectconfigurator.operationsapi.ProjectConfigExporter
import com.awnaba.projectconfigurator.operationsapi.TaskHelper
import groovy.xml.MarkupBuilder

// Get an instance of the export method
def exporter = ComponentAccessor.getOSGiComponentInstanceOfType(ProjectConfigExporter)
def taskHelper = ComponentAccessor.getOSGiComponentInstanceOfType(TaskHelper)

def stringWriter = new StringWriter()
def content = new MarkupBuilder(stringWriter)

// Define a set to store the keys of all of the projects that we wish to export
def projectKeys = ['DEMO', 'DEMO1'].toSet()

// Define a map to store all of the export options that we require
def exportOptions = [:] as Map<String, String>

// Add values to our exportOptions map
exportOptions.put('filterCFMode', 'filterUnusedCFExtended')
// Options: none, filterUnusedCFExtended, all
exportOptions.put('jiraFilterExportMode', 'none')
// Options: none, global, projects, global-or-projects, shared, all
exportOptions.put('jiraDashboardExportMode', 'none')
// Options: none, global, projects, global-or-projects, shared, all
exportOptions.put('agileBoardsExportMode', 'none')
// Options: none, projects, all

// Try to generate the export safely throwing an exception if generating the export fails.
try {
    // Call the asynchronous export method passing in the export options map and the project keys set as paramaters
    def exportResult = exporter.export(exportOptions, projectKeys)

    // Check if the export completed successfully and if so generate the XML file
    // If the export failed notify the user
    // Possible return codes that can be checked = EXPORT_STARTED, NOT_LOGGED_IN, UNAUTHORIZED, UNLICENSED, NO_PROJECTS,

    //EXPORT_ALREADY_RUNNING
    if ('EXPORT_STARTED' != exportResult.returnCode.toString()) {
        content.html {
            p("The export did not start successfully with a return code of ${exportResult.returnCode}")
        }
        return stringWriter.toString()
        // If the export was successful write the XML out to a file and notify the user where the file is stored
    }
    // Get the task ID of of the export from the Config Op Call Result object
    def taskId = exportResult.taskId

    // Get the task descriptor object for the current task provided by the task helper class
    def taskDescriptor = taskHelper.getTaskState(taskId)

    // Wait until the export task is finished
    while (!taskDescriptor.finished) {
        // Wait 0.5 seconds before getting a new instance of the taskDescriptor
        sleep(500)
        // Get a new instance of the task descriptor
        taskDescriptor = taskHelper.getTaskState(taskId)
    }

    //Return the location to the created export file
    content.html {
        p("Export file created at ${((ExportResult) taskHelper.getResult(taskDescriptor)).exportedResultFile.path}")
    }
    return stringWriter.toString()

// Throw an exception if the XML export file cannot be generated
} catch (IOException e) {
    content.html {
        p('An unexpected error occurred. Please check your atlassian-jira.log for more information')
        p(e)
    }
    return stringWriter.toString()
} catch (InterruptedException e) {
    content.html {
        p('An error occurred while the thread sleep')
        p(e)
    }
    return stringWriter.toString()
}
```

