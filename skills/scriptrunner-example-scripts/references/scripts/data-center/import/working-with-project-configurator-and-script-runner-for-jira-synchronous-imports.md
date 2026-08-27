# Working with Project Configurator and ScriptRunner for Jira - Synchronous Imports

- Platform: data-center
- Feature: import
- Tags: automate, system, synchronous
- Language: groovy
- Doc ID: example-dataCenter-project-configurator-synchronous-import-onPrem
- Source: https://examples.scriptrunner.io/scripts/project-configurator-synchronous-import-onPrem

## Overview

Synchronously import projects detailed in an XML file created by the Jira export functionality using Project Configurator.

## Example

As a project developer, I want to copy information about specific projects to another instance. Using the export method,
I can create an export XML. Using this synchronous method, I can import the XML data from one instance into another.

## Good to Know

* For larger projects, where the import time is long, you should use the asynchronous method instead.
* The 'applyChanges' value must be true for the imported projects to be saved.

## Script

```groovy
// Required Imports
import com.onresolve.scriptrunner.runner.customisers.WithPlugin
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.task.TaskProgressSink
import com.awnaba.projectconfigurator.operationsapi.ProjectConfigImporter
import com.awnaba.projectconfigurator.operationsapi.ConfigOpFullProcessResult
import com.awnaba.projectconfigurator.operationsapi.ConfigImportResult
import com.awnaba.projectconfigurator.operationsapi.ConfigOpCallResult
import groovy.xml.MarkupBuilder

// The required annotation to enable access to the functionality provided by the plugin within our script
@WithPlugin('com.awnaba.projectconfigurator.projectconfigurator')

// Get an instance of the import method
def importer = ComponentAccessor.getOSGiComponentInstanceOfType(ProjectConfigImporter)

def stringWriter = new StringWriter()
def content = new MarkupBuilder(stringWriter)

// Specify the path to the export file
def importFile = '/tmp/import.xml'

// Perform the import if the file is valid
try {
    // Extract the contents of the export file to a String that the import method can use
    def fileContents = new File(importFile).text
    def skipObjects = [] as String[]
    // Define the options for how you want to configure the export.
    def importOptions = [:] as Map<String, Serializable>
    importOptions.put(ProjectConfigImporter.IS_SIMULATION, false)
    importOptions.put(ProjectConfigImporter.CREATE_EXTRA_PROJECTS, false)
    importOptions.put(ProjectConfigImporter.SMART_CF_CONTEXTS, false)
    importOptions.put(ProjectConfigImporter.PUBLISH_DRAFTS, true)
    importOptions.put(ProjectConfigImporter.SKIP_OBJECTS, skipObjects)

    // Construct a new ConfigOpFullProcessResult object which will store the results of the configuration import
    // Requires the following parameters of XML config, applyChanges,createExtraProjects,smartCFContexts,publishDrafts,continueOnDashboardFilterErrors,doNotLoadObjects as well as an instance of the TaskProgressSink object.
    def importResult = importer.importConfigurationSynchronously(fileContents, importOptions, TaskProgressSink.NULL_SINK) as ConfigOpFullProcessResult<ProjectConfigImporter.ReturnCallCode, ? extends ConfigImportResult>

    // Check if the import completed successfully and if so display the results
    def callResult = importResult.callResult as ConfigOpCallResult
    def callReturnCode = callResult.returnCode

// If the import failed notify the user
// Possible return codes that can be checked = IMPORT_STARTED, NOT_LOGGED_IN, UNAUTHORIZED, UNLICENSED, ERROR_READING_CONFIG_FILE, IMPORT_ALREADY_RUNNING
    if (callReturnCode != null && callReturnCode != ProjectConfigImporter.ReturnCallCode.IMPORT_STARTED) {
        return "The import did not launch successfully. Launching failed with a return code of ${callReturnCode}"
        // If the import was successful display the results
    }
    // get the results of the import
    def opCode = importResult.finalResult.returnCode
    def message = opCode == ProjectConfigImporter.ReturnOpCode.SUCCESS ? importResult.finalResult.successMessage : 'Import failed'

    content.html {
        p(opCode.name())
        p(message)
        p(importResult.finalResult.loadTrace.replaceAll('\n', '<br/>'))
    }
    return stringWriter.toString()

// If an invalid file is found print an exception on screen
} catch (FileNotFoundException e) {
    content.html {
        p('You must provide a valid file:')
        p(e)
    }
    return stringWriter.toString()
}
```

