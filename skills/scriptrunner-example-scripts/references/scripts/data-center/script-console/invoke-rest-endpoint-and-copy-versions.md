# Invoke REST endpoint and copy versions

- Platform: data-center
- Feature: script-console
- Tags: project
- Language: groovy
- Doc ID: example-dataCenter-invoke-rest-endpoint-and-copy-versions-onPrem
- Source: https://examples.scriptrunner.io/scripts/invoke-rest-endpoint-and-copy-versions-onPrem

## Overview

This ScriptRunner console script is used to invoke the [REST endpoint](https://library.adaptavist.com/entity/copy-versions-from-one-project-to-another), copy the 
project versions from the source project, and save it in the destination project.

## Example

The list of versions from the source project is invoked using the REST endpoint. Once the versions are obtained,
they are added to the destination project. When viewing the versions in the destination project, you can see
the list of versions added from the source project.

## Description

#### Overview

This ScriptRunner console script is used to invoke the [REST endpoint](https://library.adaptavist.com/entity/copy-versions-from-one-project-to-another), copy the 
project versions from the source project, and save it in the destination project.
                              
#### Example

The list of versions from the source project is invoked using the REST endpoint. Once the versions are obtained,
they are added to the destination project. When viewing the versions in the destination project, you can see
the list of versions added from the source project.

## Script

```groovy
import com.atlassian.jira.component.ComponentAccessor
import groovy.json.JsonSlurper

def projectManager = ComponentAccessor.projectManager

def versionManager = ComponentAccessor.versionManager

//Specify the base url for your Jira Instance
def baseUrl = '<BASE_URL_FOR_JIRA_INSTANCE>'

//Specify the project key for the destination project
final def projectKey = '<PROJECT_KEY>'

final def startDate

final def releaseDate

final def description

final def scheduleAfterVersion

final boolean released = false

def project = projectManager.getProjectObjByKey(projectKey)

def hostUrl = "${baseUrl}/rest/scriptrunner/latest/custom/getVersions"

def response = hostUrl.toURL().text

def json = new JsonSlurper().parseText(response)

def artifacts = json.collect().sort()

artifacts.each {
    versionManager.createVersion(it.toString(), startDate, releaseDate, description, project.id, scheduleAfterVersion, released)
}
```

