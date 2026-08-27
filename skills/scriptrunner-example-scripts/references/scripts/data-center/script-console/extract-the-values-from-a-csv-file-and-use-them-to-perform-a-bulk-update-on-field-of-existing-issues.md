# Extract the values from a CSV file and use them to perform a bulk update on field of existing issues.

- Platform: data-center
- Feature: script-console
- Tags: issue, fields
- Language: groovy
- Doc ID: example-dataCenter-bulk-update-the-field-values-on-existing-issues-using-csv-onPrem
- Source: https://examples.scriptrunner.io/scripts/bulk-update-the-field-values-on-existing-issues-using-csv-onPrem

## Overview

To extract the values from a CSV file and perform a bulk update on fields of existing issues that are listed in the CSV.

## Example

You can use this sample script if there are many issues already created in a particular project and you want to update the value of certain fields, either on all or multiple issues.

## Good to Know

If you want to perform the bulk update on the fields using the CSV file, you will need to make sure that the leftmost column in the CSV file is the issue key.

## Script

```groovy
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.issue.ModifiedValue
import com.atlassian.jira.issue.util.DefaultIssueChangeHolder

//Modify the Project Key to match your project
final def projectKey = '<PROJECT_KEY>'

//Modify the File Path and File Name according to your environment
final def csvFileFullName = '<FULL_PATH_TO_CSV_FILE>'

def projectManager = ComponentAccessor.projectManager
def issueManager = ComponentAccessor.issueManager
def customFieldManager = ComponentAccessor.customFieldManager

def project = projectManager.getProjectByCurrentKey(projectKey)
def issues = issueManager.getIssueObjects(issueManager.getIssueIdsForProject(project.id))

//Modify the field names according to the field(s) you want to update
def field1 = customFieldManager.getCustomFieldObjectsByName('Field 1').first()
def field2 = customFieldManager.getCustomFieldObjectsByName('Field 2').first()

//Path to the CSV file
def file = new File(csvFileFullName)

def list = [] as ArrayList<Map>

//The value from the CSV file is extracted and added to a List of Maps
file.eachLine {
    def column = it.split(',')
    def mapInput = [:] as Map

    //The first column points to the issue's key
    mapInput.put('Key', column[0])

    //Subsequent columns point to the values that are to be passed to the fields
    mapInput.put('Field1', column[1])
    mapInput.put('Field2', column[2])
    list.add(mapInput)
}

//Sort the List of Issues ane iterate through it
issues.sort().each { issue ->
    //Iterate the List of Maps and pass the value into the Custom Fields.
    list.each { data ->
        if (data.get('Key') == issue.key) {
            field1.updateValue(null, issue, new ModifiedValue(issue.getCustomFieldValue(field1), data.get('Field1')), new DefaultIssueChangeHolder())
            field2.updateValue(null, issue, new ModifiedValue(issue.getCustomFieldValue(field2), data.get('Field2')), new DefaultIssueChangeHolder())
        }
    }
}
```

