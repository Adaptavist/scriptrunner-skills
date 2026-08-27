# Add user to space role

- Platform: cloud
- Feature: script-console
- Tags: user, hapi
- Language: groovy
- Doc ID: example-cloud-add-user-to-project-role-cloud
- Source: https://examples.scriptrunner.io/scripts/add-user-to-project-role-cloud

## Overview

You can use this script to add a user to a space role.

## Example

I want to run this script as the Addon user, so that it can be added to the list of Administrator users.

## Good to Know

A first API request retrieves information about the user running the script, from which the accountId is extrapolated.
It comes in handy when running this script in the Script Console as the ScriptRunner Addon user.
A second API request uses the fetched accountId to add it to a specific space role (e.g. the Administrator
role's id is 10002) in a specific space (e.g. space with spaceKey 'TP').

## Script

```groovy
def myself = Users.getLoggedInUser()

def spaceKey = 'TP'
def roleId = '10002'

def result = post("rest/api/3/project/${spaceKey}/role/${roleId}")
    .header('Content-Type', 'application/json')
    .body([
        "user": [myself.accountId]
    ])
    .asObject(Map)

result.body
```

