# Working with Project Configurator and ScriptRunner for Jira - Asynchronous Imports

- Platform: data-center
- Feature: import
- Tags: automate, system, asynchronous
- Language: groovy
- Doc ID: example-dataCenter-project-configurator-asynchronous-import-onPrem
- Source: https://examples.scriptrunner.io/scripts/project-configurator-asynchronous-import-onPrem

## Overview

Asynchronously import the projects detailed in xml file created by export functionality from Jira using Project Configurator.

## Example

As a project developer, I want to copy information from specific projects to another instance. Using this asynchronous
method, I can import the data from one instance in the background, allowing me to continue working whilst the process
completes. I can get this exported data by executing the export method in another instance.

## Good to Know

* For smaller projects, where the import time is short, you can use the synchronous method.
* You must define your export configuration options.

## Script

```groovy
import com.atlassian.jira.component.ComponentAccessor
import com.awnaba.projectconfigurator.operationsapi.ConfigImportResult
import com.awnaba.projectconfigurator.operationsapi.ProjectConfigImporter
import com.awnaba.projectconfigurator.operationsapi.TaskHelper
import com.onresolve.scriptrunner.runner.customisers.WithPlugin
import groovy.xml.MarkupBuilder

// The required annotation to enable access to the functionality provided by the plugin within our script.
@WithPlugin('com.awnaba.projectconfigurator.projectconfigurator')

// Get an instance of the import method
def importer = ComponentAccessor.getOSGiComponentInstanceOfType(ProjectConfigImporter)

// Specify the path to the export file
def exportFile = '/tmp/export.xml'

def stringWriter = new StringWriter()
def content = new MarkupBuilder(stringWriter)

// Perform the import if the file is valid
try {
    // Generate the string containing the contents of the XML file
    def xmlString = new File(exportFile).text

    // The booleans below allow you to configure the import options you require and match the checkboxes displayed inside the user interface
    // Define the options for how you want to configure the export.
    def skipObjects = [] as String[]
    def importOptions = [:] as Map<String, Serializable>
    importOptions.put(ProjectConfigImporter.IS_SIMULATION, false)
    importOptions.put(ProjectConfigImporter.CREATE_EXTRA_PROJECTS, false)
    importOptions.put(ProjectConfigImporter.SMART_CF_CONTEXTS, false)
    importOptions.put(ProjectConfigImporter.PUBLISH_DRAFTS, true)
    importOptions.put(ProjectConfigImporter.SKIP_OBJECTS, skipObjects)

    // Construct a new ConfigOpCalResult object which will store the results of the configuration import
    // Requires the following parameters of XML config, applyChanges,createExtraProjects,smartCFContexts,publishDrafts,continueOnDashboardFilterErrors,doNotLoadObjects as well as an instance of the TaskProgressSink object.
    def importResult = importer.importConfiguration(xmlString, importOptions)

    // Check if the import started successfully
    if (importResult.returnCode.toString() != 'IMPORT_STARTED') {
        return "The import did not launch successfully with a return code of ${importResult.returnCode}"
    }
    // If the import launched successfully display the import result on screen
    // Get the task ID of of the import from the Config Op Call Result object
    def taskId = importResult.taskId

    //Get a new instance of the task helper class
    def taskHelper = ComponentAccessor.getOSGiComponentInstanceOfType(TaskHelper)

    // Get the task descriptor object for the current task provided by the task helper class
    def taskDescriptor = taskHelper.getTaskState(taskId)

    // Wait until the import task is finished
    while (!taskDescriptor?.finished) {
        // Wait 0.5 seconds before getting a new instance of the taskDescriptor
        sleep(500)
        // Get a new instance of the task descriptor
        taskDescriptor = taskHelper.getTaskState(taskId)
    }

    // Check if the import has completed and if so display the results of the import
    // Get the final import result after it has completed
    def importFinalResult = taskHelper.getResult(taskDescriptor) as ConfigImportResult

    // Get the return code from the import
    def returnCode = importResult.returnCode.toString()

    // Get the import trace to display
    def message = importFinalResult.successMessage

    // If the import failed notify the user
    // Possible return codes that can be checked = ERROR_DURING_IMPORT, SUCCESS
    if (returnCode == 'ERROR_DURING_IMPORT') {
        content.html {
            p('The import did not complete successfully')
            p(message)
        }
        return stringWriter.toString()
        // If the import was successful display the results
    }
    // Return the result of the import on screen
    content.html {
        p(message)
        pre(importFinalResult.loadTrace)
    }
    stringWriter.toString()
}
// If an invalid file is found print an exception on screen
catch (IOException e) {
    content.html {
        p('You must provide a valid file:')
        p(e)
    }
    stringWriter.toString()
}
```

