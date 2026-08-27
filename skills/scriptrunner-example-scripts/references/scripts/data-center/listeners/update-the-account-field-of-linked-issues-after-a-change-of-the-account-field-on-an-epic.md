# Update the Account Field of Linked Issues after a Change of the Account Field on an Epic

- Platform: data-center
- Feature: listeners
- Tags: automate, issue
- Language: groovy
- Doc ID: example-dataCenter-sync-account-to-issue-links-onPrem
- Source: https://examples.scriptrunner.io/scripts/sync-account-to-issue-links-onPrem

## Overview

Update the Account field for linked issues of an epic once the epic account field is altered.
This script is triggered when the Tempo Account field on an epic is changed. When triggered, the script retrieves
the value of the altered Tempo Account field and applies the updated value to all linked issues of the epic (epic link),
and all subtasks of the linked issues (only when "inherit from parent" is used on the subtask).
The script checks if the linked issues (where the Tempo Account value is being updated) belongs to a Jira project
linked to the new Tempo Account.

Create a *Custom Listener* that listens for `Issue Updated` events.

## Example

I need to change the Tempo account associated with an epic. I have many issued in the epic and want my Jira issues to
be updated with the new account automatically so I don't have to manually update them all. I can use this script to
update all issues in the epic to show the new Tempo account.

## Good to Know

* This script requires Tempo Timesheets, Tempo Planner, or Tempo Budgets by Tempo for Jira.
* If the validation fails, the script collects the issues that could not be updated. Users of the script can optionally
send this information to the interested parties, for example, post an update to [Slack](https://library.adaptavist.com/entity/send-custom-notification-to-slack),
or an [Email](https://docs.atlassian.com/software/jira/docs/api/7.2.1/com/atlassian/jira/mail/Email.html) using the Jira API.
* Associate this script with the `Issue Updated` event listener.

## Script

```groovy
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.issue.MutableIssue
import com.atlassian.jira.event.type.EventDispatchOption
import com.onresolve.scriptrunner.runner.customisers.PluginModule
import com.onresolve.scriptrunner.runner.customisers.WithPlugin
import com.tempoplugin.accounts.account.api.AccountService
import com.tempoplugin.accounts.account.api.Account

@WithPlugin(["com.tempoplugin.tempo-accounts"])

@PluginModule
AccountService accountService

def issue = event.issue
def sendMail = false

// The issue is not an Epic, nothing to do here
if (issue.issueType.name != "Epic") {
    return
}

def loggedInUser = ComponentAccessor.jiraAuthenticationContext.loggedInUser
def change = event.changeLog.getRelated("ChildChangeItem")?.find { it.field == "Account" }

// a field other than the Account field updated, nothing to do here
if (!change) {
    return
}

def customFieldManager = ComponentAccessor.customFieldManager
def accountField = customFieldManager.getCustomFieldObjects(issue).find { it.name == "Account" }
def account = issue.getCustomFieldValue(accountField) as Account

def issuesWithMisconfigurationAccount = []

// Update the Account of all issues linked via Epic Link
ComponentAccessor.issueLinkManager.getLinkCollection(issue, loggedInUser, false).getOutwardIssues("Epic-Story Link").each {
    def linkedIssue = it as MutableIssue

    def accountsRegisteredForProject = (accountService.getAccountsByProject(linkedIssue.projectObject.id).returnedValue as List<Account>)*.key
    def globalAccounts = (accountService.globalAccounts.returnedValue as List<Account>)*.key

    // if the account is configured for the target issue or it is a global account then update
    if (account.key in accountsRegisteredForProject || account.key in globalAccounts) {
        linkedIssue.setCustomFieldValue(accountField, account)
        ComponentAccessor.issueManager.updateIssue(loggedInUser, linkedIssue, EventDispatchOption.ISSUE_UPDATED, sendMail)
    }
    else {
        // else store the issue key to a list so later we can inform the user for which issues the account field was not updated
        issuesWithMisconfigurationAccount << linkedIssue.key
    }
}
```

