# Deactivate Idle Users

- Platform: data-center
- Feature: script-console
- Tags: automate, user
- Language: groovy
- Doc ID: example-dataCenter-deactivate-inactive-users-onPrem
- Source: https://examples.scriptrunner.io/scripts/deactivate-inactive-users-onPrem

## Overview

Running this script from the *Script Console* deactivates users that have never logged in.

## Example

I want to deactivate all users in my Jira instance who have never logged in to keep my instance tidy and our license costs under control.
Running the following script from the Script Console will deactivate users that have never logged in, keeping your instance tidy and your license costs under control.

## Description

#### Overview

Running this script from the *Script Console* deactivates users that have never logged in.

#### Example

I want to deactivate all users in my Jira instance who have never logged in to keep my instance tidy and our license costs under control.
Running the following script from the Script Console will deactivate users that have never logged in, keeping your instance tidy and your license costs under control.

## Script

```groovy
import com.atlassian.crowd.manager.directory.DirectoryManager
import com.atlassian.jira.bc.JiraServiceContextImpl
import com.atlassian.jira.bc.user.UserService
import com.atlassian.jira.bc.user.search.UserSearchParams
import com.atlassian.jira.bc.user.search.UserSearchService
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.security.login.LoginManager
import com.atlassian.jira.user.ApplicationUser
import groovy.xml.MarkupBuilder

final directoryToCheck = 'JIRA Internal Directory'

def loginManager = ComponentAccessor.getComponent(LoginManager)
def directoryManager = ComponentAccessor.getComponent(DirectoryManager)

UserSearchParams.Builder paramBuilder = UserSearchParams.builder()
    .allowEmptyQuery(true)
    .includeActive(true)
    .includeInactive(false)

def jiraServiceContext = new JiraServiceContextImpl(ComponentAccessor.jiraAuthenticationContext.loggedInUser)

def allActiveUsers = ComponentAccessor.getComponent(UserSearchService).findUsers(jiraServiceContext, '', paramBuilder.build())
def internalDirectoryId = directoryManager.findAllDirectories()?.find { it.name.toLowerCase() == directoryToCheck.toLowerCase() }?.id

def idleUsers = allActiveUsers.findAll { user ->
    user.directoryId == internalDirectoryId && !loginManager.getLoginInfo(user.username)?.lastLoginTime
}

if (!idleUsers) {
    return 'No Idle users found'
}

def stringWriter = new StringWriter()
def content = new MarkupBuilder(stringWriter)

content.html {
    p('Follow users deactivated ') {
        ul {
            idleUsers.each {
                user -> deactivateUser(user)
            }*.username?.each { deactivated ->
                li(deactivated)
            }
        }
    }
}

stringWriter.toString()

def deactivateUser(ApplicationUser user) {
    def userService = ComponentAccessor.getComponent(UserService)
    def updateUser = userService.newUserBuilder(user).active(false).build()
    def updateUserValidationResult = userService.validateUpdateUser(updateUser)

    if (!updateUserValidationResult.valid) {
        log.error "Update of ${user.name} failed. ${updateUserValidationResult.errorCollection}"
        return
    }

    userService.updateUser(updateUserValidationResult)
    log.info "${updateUser.name} deactivated"
}
```

