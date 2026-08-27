# Remove Project Shortcuts

- Platform: data-center
- Feature: script-console
- Tags: project
- Language: groovy
- Doc ID: example-dataCenter-remove-project-shortcuts-onPrem
- Source: https://examples.scriptrunner.io/scripts/remove-project-shortcuts-onPrem

## Overview

You can use this script to remove multiple project shortcuts in one go. The script also includes an example of how it 
can be adapted to remove project shortcuts one at a time.

## Example

As a project administrator, one of my tasks is to perform project housekeeping. We currently have a lot of links in 
the Project Shortcuts section that are no longer relevant. I would like to remove all those links and replace them 
with links that are useful. This script performs the first step of that.

## Good to Know

Once you have used this script to remove links from the Project Shortcuts section, you can use 
the [Add Multiple Project Shortcuts to a Project at once](https://library.adaptavist.com/entity/add-multiple-project-shortcuts-at-once) script to 
replace them with relevant links.

## Script

```groovy
import groovyx.net.http.HttpResponseDecorator
import groovyx.net.http.RESTClient
import static groovyx.net.http.ContentType.JSON

//Set the base JIRA URL e.g. https://localhost:8080/
final def baseUrl = '<JIRA_URL>'
//Set the Project Key
final def projectKey = '<PROJECT_KEY>'
//Set the Username
final def username = '<USERNAME>'
//Set the Password
final def password = '<PASSWORD>'

final def endpoint = "rest/projects/1.0/project/${projectKey}/shortcut"

def headers = ['Authorization': "Basic ${"${username}:${password}".bytes.encodeBase64()}",
               'X-ExperimentalApi': 'opt-in', 'Accept': 'application/json'] as Map

def http = new RESTClient(baseUrl)
http.setHeaders(headers)

def resp = http.get(path: endpoint) as HttpResponseDecorator

def ids = resp.data['id'] as List<String>

ids.each {
    http.delete(contentType: JSON, path: "${endpoint}/${it}")
}

/*
If you want to remove one Project Shortcut at a time you can include an if condition into the ids iteration to filter
out the specific id as shown below:

    ids.each {
        if(it == '1') {
            http.delete(contentType: JSON, path: "${endpoint}/${it}")
        }
    }
*/
```

