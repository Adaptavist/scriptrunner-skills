# Select Tempo Account Automatically at Issue Creation

- Platform: data-center
- Feature: listeners
- Tags: automate, fields
- Language: groovy
- Doc ID: example-dataCenter-select-tempo-account-at-issue-creation-onPrem
- Source: https://examples.scriptrunner.io/scripts/select-tempo-account-at-issue-creation-onPrem

## Overview

Automatically fill the Tempo Account field when an issue is created, based on the Tempo Account associated with the
issue epic.
This script is triggered when an issue is created. When triggered, the script retrieves the Tempo Account value of the
associated epic.
Once the Account field is updated, a comment is attached to the issue, detailing that the Tempo Account has been
assgined automatically.

Add this script to a *Custom Listener* that listens for `Issue Created` event.

## Example

As a project manager, I can create epics and assign a Tempo Account to them. As a developer, I can create issues
related to the epics my project manager has created, but I do not want to assign Tempo Account manually.
I can use this script to assign Tempo Account automatically when an issue belonging to an epic is created.

## Good to Know

* This script requires Tempo Planner by Tempo for Jira.
* Issue created needs to have an epic related.
* Epic needs to have a Tempo Account assigned.
* Automatic comment can be customized.

## Script

```groovy
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.issue.ModifiedValue
import com.atlassian.jira.issue.util.DefaultIssueChangeHolder
import com.onresolve.scriptrunner.runner.customisers.PluginModule
import com.onresolve.scriptrunner.runner.customisers.WithPlugin
import com.tempoplugin.accounts.account.api.Account
import com.tempoplugin.accounts.account.api.AccountService

@WithPlugin("com.tempoplugin.tempo-accounts")

@PluginModule
AccountService accountService

def issue = event.issue
// The issue is an Epic, nothing to do here
if (issue.issueType.name == "Epic") {
    return
}
// Epic is obtained throughout epic link
def loggedInUser = ComponentAccessor.jiraAuthenticationContext.loggedInUser
def issueLinkManager = ComponentAccessor.issueLinkManager
def epicLink = issueLinkManager.getLinkCollection(issue, loggedInUser, false).getInwardIssues("Epic-Story Link")
// There is no epic link, nothing to do here
if (!epicLink || epicLink.empty) {
    return
}

def epic = epicLink.first()
// There is no epic, nothing to do here
if (!epic) {
    return
}
// Account field from epic link is obtained
def customFieldManager = ComponentAccessor.customFieldManager
def epicAccountField = customFieldManager.getCustomFieldObjects(epic).find { it.name == "Account" }
def epicAccount = epic.getCustomFieldValue(epicAccountField) as Account
// Related epic has no account defined, nothing to do here
if (!epicAccount) {
    return
}
// Account field from issue is obtained
def issueAccountField = customFieldManager.getCustomFieldObjects(issue).find { it.name == "Account" }
def selectedAccountOnIssue = issue.getCustomFieldValue(issueAccountField) as Account
def accountsRegisteredForProject = (accountService.getAccountsByProject(issue.projectObject.id).returnedValue as List<Account>)*.key
def globalAccounts = (accountService.globalAccounts.returnedValue as List<Account>)*.key

// If the account is configured for the target issue or it is a global account then update
if (epicAccount.key in accountsRegisteredForProject || epicAccount.key in globalAccounts) {
    issueAccountField.updateValue(null, issue, new ModifiedValue(selectedAccountOnIssue, epicAccount), new DefaultIssueChangeHolder())
    // A custom comment is added to the issue in order to notify that the issue account has been changed automatically
    def commentManager = ComponentAccessor.commentManager
    def body = "The Tempo Account was changed ${!selectedAccountOnIssue || selectedAccountOnIssue?.id == -1 ? '' : "from ${selectedAccountOnIssue} "}to ${epicAccount} by the Scriptrunner validation script"
    commentManager.create(issue, loggedInUser, body, false)
}
```

