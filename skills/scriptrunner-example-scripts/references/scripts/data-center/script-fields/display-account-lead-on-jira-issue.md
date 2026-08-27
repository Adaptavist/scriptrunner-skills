# Display Account Lead on Jira Issue

- Platform: data-center
- Feature: script-fields
- Tags: automate, issue, hapi
- Language: groovy
- Doc ID: example-dataCenter-display-account-lead-onPrem
- Source: https://examples.scriptrunner.io/scripts/display-account-lead-onPrem

## Overview

Adds a ScriptRunner custom field which displays the Tempo account name, based on the Account custom field.

## Example

I want to find out who the account lead is for a specific account. I have selected the account from the list of
available Tempo accounts, so I can contact them about a problem I have found.
This script allows me to find out the name of this person, so I can resolve the issue quickly and efficiently.

## Good to Know

* This script requires Tempo Timesheets or Tempo Budgets by Tempo for Jira.
* To configure this script: *Create a Custom Script Field* with *Template: User Picker (single user)* and *Searcher: User Picker Searcher*

![Getting the fieldConfigId](https://gist.githubusercontent.com/jechlin-adaptavist/5bff3fbd8a840aa01b0e5f66da8c1c61/raw/b17f5374f33a62371133348008b142698074ddf6/tempo-account-lead-config.png)

## Script

```groovy
import com.adaptavist.hapi.jira.users.Users
import com.onresolve.scriptrunner.runner.customisers.WithPlugin
import com.tempoplugin.accounts.account.api.Account

@WithPlugin(["com.tempoplugin.tempo-accounts"])

def account = issue.getCustomFieldValue('Account') as Account

def username = account?.tempoLead?.username

username ?
    Users.getByName(username) :
    null
```

