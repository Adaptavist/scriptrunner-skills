# Create a Tempo Account

- Platform: data-center
- Feature: script-console
- Tags: automate, issue
- Language: groovy
- Doc ID: example-dataCenter-create-tempo-account-onPrem
- Source: https://examples.scriptrunner.io/scripts/create-tempo-account-onPrem

## Overview

Create a Tempo account (a way to track time across multiple teams and projects) using the Tempo API. 

The current user must have permission to create a Tempo account.

Read more about permissions in Tempo in this [article](https://tempo-io.atlassian.net/wiki/spaces/THC/pages/293863570/Editing+Team+Permissions+-+Tempo+Server).

## Example

I want to automate the creation of Tempo accounts to save time manually creating them, and make issue progress easy to
track. I could, for instance, use this script to trigger a Tempo account creation each time an Epic is created, allowing me to track
the time spent on issue in that Epic.

## Good to Know

* This script requires Tempo Timesheets, Tempo Planner, or Tempo Budgets by Tempo for Jira.
* This creates a *global* account. See [this solution](https://library.adaptavist.com/entity/link-tempo-account) to manage the project associations for an account.

## Script

```groovy
import com.onresolve.scriptrunner.runner.customisers.PluginModule
import com.onresolve.scriptrunner.runner.customisers.WithPlugin
import com.tempoplugin.accounts.account.api.Account
import com.tempoplugin.accounts.account.api.AccountBuilderFactory
import com.tempoplugin.accounts.account.api.AccountService
import com.tempoplugin.platform.api.user.UserAuthenticationContext

@WithPlugin('is.origo.jira.tempo-plugin')

@PluginModule
AccountService accountService

@PluginModule
UserAuthenticationContext userAuthenticationContext

@PluginModule
AccountBuilderFactory accountBuilderFactory

// set the current user to be the account manager, and configures this as a global account
def account = accountBuilderFactory
    .createBuilder('ACME', 'Acme Inc.', userAuthenticationContext.authenticatedUser, Account.Status.OPEN).global(true)
    .build()

accountService.createAccount(account)
```

