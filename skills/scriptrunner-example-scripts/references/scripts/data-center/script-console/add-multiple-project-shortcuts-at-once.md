# Add Multiple Project Shortcuts at once

- Platform: data-center
- Feature: script-console
- Tags: project
- Language: groovy
- Doc ID: example-dataCenter-add-multiple-project-shortcuts-at-once-onPrem
- Source: https://examples.scriptrunner.io/scripts/add-multiple-project-shortcuts-at-once-onPrem

## Overview

This script can add one or multiple URLs, either from internal or external resources, to the Project Shortcuts section in one go.

## Example

As a project administrator, I have many reference URLs which I would like to add to the Project Shortcuts section. 
Adding them one by one is a little time consuming. This script saves time and effort by adding all my shortcuts in one go.

## Description

#### Overview
This script can add one or multiple URLs, either from internal or external resources, to the Project Shortcuts section in one go.  
                              
#### Example
As a project administrator, I have many reference URLs which I would like to add to the Project Shortcuts section. 
Adding them one by one is a little time consuming. This script saves time and effort by adding all my shortcuts in one go.

## Script

```groovy
import groovy.json.JsonOutput
import groovyx.net.http.ContentType
import groovyx.net.http.HttpResponseDecorator
import groovyx.net.http.RESTClient

//Set the base JIRA URL e.g. http://localhost:8080/
final def baseUrl = "<JIRA_URL>"
//Set the Project Key
final def projectKey = '<PROJECT_KEY>'
//Set the Username
final def username = '<USERNAME>'
//Set the Password
final def password = '<PASSWORD>'

final def shortcutsPath = "rest/projects/1.0/project/${projectKey}/shortcut"

def headers = ['Authorization': "Basic ${"${username}:${password}".bytes.encodeBase64()}",
               'X-ExperimentalApi': 'opt-in', 'Accept': 'application/json'] as Map

def client = new RESTClient(baseUrl)
client.setHeaders(headers)

//Specify the Project Shortcut's Name and URL only. Leave an empty value for Icon as shown below
def shortcutUrls = [
        ['name': 'Adaptavist', 'url': 'https://www.adaptavist.com', 'icon': ''],
        ['name': 'Adaptavist Docs', 'url': 'https://docs.adaptavist.com', 'icon': ''],
        ['name': 'Adaptavist Library', 'url': 'https://library.adaptavist.com', 'icon': ''],
        ['name': 'Atlassian Community', 'url': 'https://community.atlassian.com', 'icon': ''],
        ['name': 'Groovy Documentation', 'url': 'https://groovy-lang.org/documentation.html', 'icon': '']
]

shortcutUrls.each {
    def jsonOutput = JsonOutput.toJson(it)

    client.post(path: shortcutsPath, queryString: '', contentType: ContentType.JSON, body: jsonOutput)

    client.handler.success = { HttpResponseDecorator response, json ->
        json
    }
    client.handler.failure = { HttpResponseDecorator response ->
        log.error response.entity.content.text
    }
}
```

