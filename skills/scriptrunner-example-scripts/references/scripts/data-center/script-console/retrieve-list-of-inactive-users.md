# Retrieve List of Inactive Users

- Platform: data-center
- Feature: script-console
- Tags: workflow
- Language: groovy
- Doc ID: example-dataCenter-retrieve-list-of-inactive-users-onPrem
- Source: https://examples.scriptrunner.io/scripts/retrieve-list-of-inactive-users-onPrem

## Overview

Retrieve an immutable list of inactive users from all projects, 
and convert to a List<Strings> for ammendability functionality purposes.

## Example

As a Jira administrator, I would like to identify and remove all inactive users across all projects I oversee. 
This script allows me to generate a list of all inactive users.  
I can then use that list in conjunction with the Remove Users from Project Role script to remove all of the inactive users in the list I generated.

## Description

#### Overview
Retrieve an immutable list of inactive users from all projects, 
and convert to a List<Strings> for ammendability functionality purposes.

#### Example
As a Jira administrator, I would like to identify and remove all inactive users across all projects I oversee. 
This script allows me to generate a list of all inactive users.  
I can then use that list in conjunction with the Remove Users from Project Role script to remove all of the inactive users in the list I generated.

## Script

```groovy
import com.atlassian.jira.bc.user.search.UserSearchParams
import com.atlassian.jira.bc.user.search.UserSearchService
import com.atlassian.jira.component.ComponentAccessor

def userSearchService = ComponentAccessor.getComponent(UserSearchService)

final def limitValue = '<SPECIFY_VALUE>'
//Build a search with 100,000 results where users are inactive
def userSearchBuilder = new UserSearchParams.Builder(limitValue)
def userSearchParams = userSearchBuilder.allowEmptyQuery(true)
        .includeActive(false)
        .includeInactive(true)
        .limitResults(limitValue)
        .build()

//Retrieve immutableList of Inactive Users
def inactiveUsers = userSearchService.findUsers('', userSearchParams)

//You can convert immutableList inactiveUsers, to a List<String> with below
//which is useful for method like ProjectRoleService.removeActorsFromProjectRole()
def usersToRemove = [] as List<String>
inactiveUsers.each {
    usersToRemove.add(it.key.toString())
}
```

