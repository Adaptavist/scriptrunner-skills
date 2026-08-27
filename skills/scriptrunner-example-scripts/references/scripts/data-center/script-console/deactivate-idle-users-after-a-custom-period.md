# Deactivate Idle Users After a Custom Period

- Platform: data-center
- Feature: script-console
- Tags: automate, user
- Language: groovy
- Doc ID: example-dataCenter-deactivate-inactive-users-after-custom-period-onPrem
- Source: https://examples.scriptrunner.io/scripts/deactivate-inactive-users-after-custom-period-onPrem

## Overview

Running this script from the *Script Console* to deactivate users that have been inactive for the set time period.

## Example

Over time employees move teams or move to different parts of the business, meaning they are taking up user licenses
that they no longer need. As a Jira Administrator, I want to keep my license cost under control and ensure I remove
inactive users from my Jira instance. I can use this script to deactivate users who have been inactive on the instance
for the period I have set (for example, 30 days).

## Good to Know

* You can set the *numOfDays* value with the number of days that you can limit it.
* This script deactivates users, not remove them.
* This script does not consider inactive users.

## Script

```groovy
import com.atlassian.jira.bc.JiraServiceContextImpl
import com.atlassian.jira.bc.user.UserService
import com.atlassian.jira.bc.user.search.UserSearchParams
import com.atlassian.jira.bc.user.search.UserSearchService
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.user.ApplicationUser
import com.atlassian.crowd.embedded.api.CrowdService
import groovy.xml.MarkupBuilder

import java.time.LocalDateTime
import java.time.Instant
import java.time.ZoneId

def crowdService = ComponentAccessor.getComponent(CrowdService)

// Number of days the user was not logged in Date
def numOfDays = 100
def dateLimit = LocalDateTime.now().minusDays(numOfDays)

// Search all active users
UserSearchParams.Builder paramBuilder = UserSearchParams.builder()
    .allowEmptyQuery(true)
    .includeActive(true)
    .includeInactive(false)

def jiraServiceContext = new JiraServiceContextImpl(ComponentAccessor.jiraAuthenticationContext.loggedInUser)
def allActiveUsers = ComponentAccessor.getComponent(UserSearchService).findUsers(jiraServiceContext, '', paramBuilder.build())

// Users which last activity is before than limit date
def usersToDelete = allActiveUsers.findAll { user ->
    def userWithAtributes = crowdService.getUserWithAttributes(user.username)
    def lastLoginMillis = userWithAtributes.getValue('login.lastLoginMillis')

    if (lastLoginMillis?.number) {
        def lastLogin = Instant.ofEpochMilli(Long.parseLong(lastLoginMillis)).atZone(ZoneId.systemDefault()).toLocalDateTime()
        if (lastLogin.isBefore(dateLimit)) {
            user
        }
    }
}

if (!usersToDelete) {
    return 'No Idle users found'
}

def stringWriter = new StringWriter()
def content = new MarkupBuilder(stringWriter)

content.html {
    p('Follow users deactivated ') {
        ul {
            usersToDelete.each {
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

