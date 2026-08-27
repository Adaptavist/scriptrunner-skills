# Display Formatted Account Metadata on Jira Issues

- Platform: data-center
- Feature: script-fields
- Tags: automate, issue
- Language: groovy
- Doc ID: example-dataCenter-display-account-info-onPrem
- Source: https://examples.scriptrunner.io/scripts/display-account-info-onPrem

## Overview

Add a ScriptRunner field to Jira issues as an HTML formatted custom field. A scripted field can be used to display
metadata on a selected Tempo account, such as Account Status, Account Lead, and contact information.

## Example

I am a project lead, and I need to review selected accounts, so I know the status of each account, who the account lead
is, and the contact name for each account.
I use this script to display this information on issues so I can conduct my review for reporting and bookkeeping efficiently.

## Good to Know

* This script requires Tempo Timesheets or Tempo Budgets by Tempo for Jira.
* The script only works for screens where the Tempo Account custom field has been added.
* To configure this script: *Create a Custom Script Field* with *Template: HTML* and *Searcher: Free Text Searcher*.

## Script

```groovy
import com.atlassian.jira.component.ComponentAccessor
import groovy.xml.MarkupBuilder
import com.tempoplugin.accounts.account.api.Account
import com.tempoplugin.platform.jira.user.JiraTempoUser

import com.onresolve.scriptrunner.runner.customisers.WithPlugin

@WithPlugin(["com.tempoplugin.tempo-accounts"])

def customFieldManager = ComponentAccessor.customFieldManager
def accountField = customFieldManager.getCustomFieldObjects(issue).find { it.name == "Account" }
def account = issue.getCustomFieldValue(accountField) as Account

// there is no account - nothing to display
if (!account) {
    return null
}

// account info to display
def contact = account.contact as JiraTempoUser
def lead = account.lead as JiraTempoUser

def accountStatus = account.status.toString()
def leadName = lead.applicationUser.displayName
def contactName = contact ? contact.displayName : "n/a"

def statusColor = accountStatus == "OPEN" ? "green" : "red"

def writer = new StringWriter()
def html = new MarkupBuilder(writer)

html.div {
    div(style: 'color: ' + statusColor, accountStatus)
    p("Lead: $leadName")
    p("Contact: $contactName")
}

writer
```

