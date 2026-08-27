# Inactive Users Report

- Platform: data-center
- Feature: script-console
- Tags: automate, user
- Language: groovy
- Doc ID: example-dataCenter-inactive-users-report-onPrem
- Source: https://examples.scriptrunner.io/scripts/inactive-users-report-onPrem

## Overview

Display the number of inactive users belonging to a given directory and group.

## Example

I am a project manager and have a large group of users and have run out of available users on my licence.
I can run this script to see a report of how many users in the group are inactive.

## Good to Know

* This script is run in the Script Console.
* This script shows:
  - Users belonging to the given directory,
  - Users belonging to the given directory and have never logged in,
  - Users belonging to the given directory and in the given group,
  - Users belonging to the given directory and in the given group and have never logged in.

## Script

```groovy
import com.atlassian.crowd.manager.directory.DirectoryManager
import com.atlassian.jira.bc.security.login.LoginService
import com.atlassian.jira.bc.user.search.UserSearchParams
import com.atlassian.jira.bc.user.search.UserSearchService
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.user.UserFilter
import groovy.xml.MarkupBuilder

final directoryToCheck = 'Jira Internal Directory'
final groupName = 'jira-users'

def loginManager = ComponentAccessor.getComponent(LoginService)
def directoryManager = ComponentAccessor.getComponent(DirectoryManager)
def groupManager = ComponentAccessor.groupManager
def userSearchService = ComponentAccessor.getComponent(UserSearchService)

def internalDirectoryId = directoryManager.findAllDirectories()?.find { it.name.toString().toLowerCase() == directoryToCheck.toLowerCase() }?.id
def jiraUsersGroup = groupManager.getGroup(groupName)

// Get all users that belong to JIRA Internal Directory
def allowEmptyQuery = true
def includeActive = true
def includeInactive = false
def canMatchEmail = false
def userFilter = null
def projectIds = null

def allUserParams = new UserSearchParams(allowEmptyQuery, includeActive, includeInactive, canMatchEmail, userFilter as UserFilter, projectIds as Set<Long>)
def allInternalDirectoryUsers = userSearchService.findUsers('', allUserParams).findAll { it.directoryId == internalDirectoryId }

// Get all the users that belong to JIRA Internal Directory and have never logged in
def internalDirectoryUsersNeverLoggedIn = allInternalDirectoryUsers?.findAll {
    !loginManager.getLoginInfo(it.username).lastLoginTime
}

// Get all the users that belong to JIRA Internal Directory and to jira-users group
def internalUsersBelongToGroup = allInternalDirectoryUsers?.findAll { groupManager.isUserInGroup(it, jiraUsersGroup) }

// Get all the users that belong to JIRA Internal Directory and to jira-users group and have never logged in
def jiraUsersHaveNeverLoggedIn = internalDirectoryUsersNeverLoggedIn?.findAll {
    groupManager.isUserInGroup(it, jiraUsersGroup)
}

def stringWriter = new StringWriter()
def content = new MarkupBuilder(stringWriter)

content.html {
    p("Users in Jira Internal Directory: ${allInternalDirectoryUsers?.size()}")
    p("Users in Jira Internal Directory and have never logged in: ${internalDirectoryUsersNeverLoggedIn?.size()}")
    p("Users in Jira Internal Directory and in jira-users group: ${internalUsersBelongToGroup?.size()}")
    p("Users in Jira Internal Directory and in jira-users group and have never logged in: ${jiraUsersHaveNeverLoggedIn?.size()}")
}

stringWriter.toString()
```

