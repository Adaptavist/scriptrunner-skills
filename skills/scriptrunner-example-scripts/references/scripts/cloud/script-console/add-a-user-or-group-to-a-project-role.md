# Add a user or group to a project role

- Platform: cloud
- Feature: script-console
- Tags: automate, administer, user
- Language: groovy
- Doc ID: example-cloud-Add-user-or-group-to-a-role-cloud
- Source: https://examples.scriptrunner.io/scripts/Add-user-or-group-to-a-role-cloud

## Overview

Add a selected user or a group to a particular project role.

## Example

As a Jira admin, I want to assign the role of jira-core-user to a user from the developer group.

## Good to Know

* This example will work only in Jira Cloud.
* Substitute the following **projectKey**, **roleName**, **groupName** and **accountId** variables with your selected values.

## Script

```groovy
def accountId = '123456:12345a67-bbb1-12c3-dd45-678ee99f99g0'
def groupName = 'jira-core-users'
def projectKey = 'TP'
def roleName = 'Developers'

def roles = get("/rest/api/2/project/${projectKey}/role")
        .asObject(Map).body

String developersUrl = roles[roleName]

assert developersUrl != null

def result = post(developersUrl)
    .header('Content-Type', 'application/json')
    .body([
            user: [accountId],
            group: [groupName]
    ])
    .asString()

assert result.status == 200
result.statusText
```

