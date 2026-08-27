# Identify the Groups of a User

- Platform: data-center
- Feature: script-console
- Tags: user
- Language: groovy
- Doc ID: example-dataCenter-identify-user-groups-onPrem
- Source: https://examples.scriptrunner.io/scripts/identify-user-groups-onPrem

## Overview

This script displays the groups a user belongs to separated by commas.

## Example

As a Jira administrator, I want to know the groups of several users.
Using this script, I am able to view all the groups of a user at a glance.
In the same way, I can use this script as part of a larger script, to identify the groups of a user and apply additional logic depending on them.

## Description

#### Overview

This script displays the groups a user belongs to separated by commas.

#### Example

As a Jira administrator, I want to know the groups of several users.
Using this script, I am able to view all the groups of a user at a glance.
In the same way, I can use this script as part of a larger script, to identify the groups of a user and apply additional logic depending on them.

## Script

```groovy
import com.atlassian.jira.component.ComponentAccessor

def groupManager = ComponentAccessor.groupManager
def loggedInUser = ComponentAccessor.jiraAuthenticationContext.loggedInUser

final username = loggedInUser.username

def groupNames = groupManager.getGroupNamesForUser(username)

"The groups for user '${username}' are: ${groupNames.join(', ')}"
```

