# Get fields, Resolutions, and Work Types from Jira

- Platform: cloud
- Feature: script-console
- Tags: automate, workflow, fields, issue
- Language: groovy
- Doc ID: example-cloud-working-with-issue-information-cloud
- Source: https://examples.scriptrunner.io/scripts/working-with-issue-information-cloud

## Overview

Use ScriptRunner for Jira to get field, work type, and resolution information.
Using this script, you can get the ID and use it to update other work item information.

## Example

I am a ScriptRunner user and I want to implement a new script. To create this script I need to know the IDs of the
fields in Jira. With this script I can get the IDs by adding the names of these fields to the script.

## Good to Know

* The IssueTypes, Field or Resolutions names must be written as a list of strings as shown in the script.
  * If the element name does not exist, you will not get any value for it.

## Script

```groovy
// Name of the elements for which you want to get the id
def workTypesNames = ['Story']
def fieldNames = ['Summary']
def resolutionNames = ['Done']

// Elements information maps
def workTypesMap = getWorkTypeIdsFromNames(workTypesNames)
def fieldsMap = getFieldIdsFromNames(fieldNames)
def resolutionsMap = getResolutionsFromNames(resolutionNames)

"WorkTypes: ${workTypesMap} - Fields: ${fieldsMap} - Resolutions: ${resolutionsMap}"

Map<String, String> getWorkTypeIdsFromNames(Collection<String> workTypesNames) {
    def result = workTypesNames.collectEntries { workTypeName ->
        def workTypeObject = get('/rest/api/2/issuetype')
                .asObject(List)
                .body.find {
            (it as Map).name == workTypeName
        } as Map

        workTypeObject ? [(workTypeName.toString()): workTypeObject.id] : [:]
    }
    result as Map<String, String>
}

Map<String, String> getFieldIdsFromNames(Collection<String> fieldNames) {
    def result = fieldNames.collectEntries { fieldName ->
        def customFieldObject = get('/rest/api/2/field')
                .asObject(List)
                .body.find {
            (it as Map).name == fieldName
        } as Map

        customFieldObject ? [(fieldName.toString()): customFieldObject.id] : [:]
    }
    result as Map<String, String>
}

Map<String, String> getResolutionsFromNames(Collection<String> resolutionNames) {
    def result = resolutionNames.collectEntries { resolutionName ->
        def resolutionObject = get('/rest/api/2/resolution')
                .asObject(List)
                .body.find {
            (it as Map).name == resolutionName
        } as Map

        resolutionObject ? [(resolutionName.toString()): resolutionObject.id] : [:]
    }
    result as Map<String, String>
}
```

