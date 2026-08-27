# Set the List Value according to the Workflow Name

- Platform: data-center
- Feature: behaviours
- Tags: workflow, issue, fields, project
- Language: groovy
- Doc ID: example-dataCenter-set-list-value-according-to-workflow-name-onPrem
- Source: https://examples.scriptrunner.io/scripts/set-list-value-according-to-workflow-name-onPrem

## Overview

The Behaviour Initializer is used to set the option on a Single Select List according to the project's workflow name
which is retrieved using the [REST Endpoint](https://library.adaptavist.com/entity/get-the-name-of-the-workflow).

## Example

In this example, when an issue is either being created or edited, the Behaviour Initializer automatically sets the value 
of a Single Select List based on the project's workflow name that is obtained from the REST Endpoint.

## Description

#### Overview
The Behaviour Initializer is used to set the option on a Single Select List according to the project's workflow name
which is retrieved using the [REST Endpoint](https://library.adaptavist.com/entity/get-the-name-of-the-workflow).
                                
#### Example
In this example, when an issue is either being created or edited, the Behaviour Initializer automatically sets the value 
of a Single Select List based on the project's workflow name that is obtained from the REST Endpoint.

## Script

```groovy
import com.atlassian.jira.component.ComponentAccessor
import com.onresolve.jira.groovy.user.FieldBehaviours
import groovy.transform.BaseScript

@BaseScript FieldBehaviours behaviours
def listName = '<LIST_NAME>'
def workflowName = '<WORKFLOW_NAME>'
def listOption = '<LIST_OPTION_VALUE>'

def sampleList = getFieldByName(listName)
sampleList.setFormValue(null)

def applicationProperties = ComponentAccessor.applicationProperties

def project = issueContext.projectObject

final def baseUrl = applicationProperties.getString('jira.baseurl')

def hostUrl = "${baseUrl}/rest/scriptrunner/latest/custom/getWorkflowNames?projectKey=${project.key}".toString()

def response = hostUrl.toURL().text

def workflowResult = response[1..response.length() - 2]

if (workflowResult == workflowName) {
    sampleList.setFormValue(listOption)
}
```

