# A console script for removing inactive users from the board administrators

- Platform: data-center
- Feature: script-console
- Tags: administer
- Language: groovy
- Doc ID: example-dataCenter-remove-disabled-board-admin-onPrem
- Source: https://examples.scriptrunner.io/scripts/remove-disabled-board-admin-onPrem

## Overview

When a user is made inactive they will not automatically be removed as a Jira Software board administrator.

This console script removes them. 

It's not possible to have no administrators for a board. 
Therefore, you must provide this script with a user to add as an administrator if removing all inactive board administrators leaves the board with no administrators.

## Description

#### Overview

When a user is made inactive they will not automatically be removed as a Jira Software board administrator.

This console script removes them. 

It's not possible to have no administrators for a board. 
Therefore, you must provide this script with a user to add as an administrator if removing all inactive board administrators leaves the board with no administrators.

## Script

```groovy
import com.atlassian.greenhopper.model.rapid.BoardAdmin
import com.atlassian.greenhopper.service.rapid.view.BoardAdminService
import com.atlassian.greenhopper.service.rapid.view.RapidViewService
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.user.ApplicationUser
import com.atlassian.jira.user.util.UserManager
import com.onresolve.scriptrunner.canned.util.OutputFormatter
import com.onresolve.scriptrunner.parameters.annotation.UserPicker
import com.onresolve.scriptrunner.runner.customisers.JiraAgileBean
import com.onresolve.scriptrunner.runner.customisers.PluginModule

@JiraAgileBean
RapidViewService rapidViewService

@JiraAgileBean
BoardAdminService boardAdminService

@PluginModule
UserManager userManager

@UserPicker(label = "Replacement User",
    description = "If deleting inactive users would leave no administrators, provide a user that will become the administrator")
ApplicationUser replacementUser

def currentUser = ComponentAccessor.jiraAuthenticationContext.getLoggedInUser()

assert replacementUser: 'Please provide a user that will be used if only inactive users are admins for a board'

def replacementBoardAdmin = BoardAdmin.builder().type(BoardAdmin.Type.USER).key(replacementUser.key).build()

List<String> boardChanges = []

rapidViewService.getRapidViews(currentUser).get().each { board ->

    def boardAdmins = boardAdminService.getBoardAdmins(board)

    def disabledUsers = boardAdmins.findAll {
        it.type == BoardAdmin.Type.USER
    }.findAll {
        def boardAdmin = userManager.getUserByKey(it.key)
        !boardAdmin.active
    }

    if (disabledUsers) {
        boardChanges << "Removing users: ${disabledUsers*.key.join(', ')} from board: ${board.name}".toString()

        def newAdmins = (boardAdmins - disabledUsers).collect {
            BoardAdmin.builder().type(it.type).key(it.key).build()
        } ?: [replacementBoardAdmin]

        boardAdminService.updateBoardAdmins(board, currentUser, newAdmins)
    }
}

OutputFormatter.markupBuilder {
    if (boardChanges) {
        ul {
            boardChanges.each {
                li(it)
            }
        }
    } else {
        p('No changes to be made')
    }
}
```

