# Link a Tempo Account

- Platform: data-center
- Feature: script-console
- Tags: automate, issue
- Language: groovy
- Doc ID: example-dataCenter-link-tempo-account-onPrem
- Source: https://examples.scriptrunner.io/scripts/link-tempo-account-onPrem

## Overview

Create a Tempo account (a way to track time across multiple teams and projects) using the Tempo API, 
and creates associations to a project. Repeat calling `accountLinkService.addLink` to create as many project associations as you need. 

The current user must have permission to create a Tempo account.

Read more about permissions in Tempo in this [article](https://tempo-io.atlassian.net/wiki/spaces/THC/pages/293863570/Editing+Team+Permissions+-+Tempo+Server).

## Good to Know

* This script requires Tempo Timesheets, Tempo Planner, or Tempo Budgets by Tempo for Jira.

## Description

#### Overview

Create a Tempo account (a way to track time across multiple teams and projects) using the Tempo API, 
and creates associations to a project. Repeat calling `accountLinkService.addLink` to create as many project associations as you need. 

The current user must have permission to create a Tempo account.

Read more about permissions in Tempo in this [article](https://tempo-io.atlassian.net/wiki/spaces/THC/pages/293863570/Editing+Team+Permissions+-+Tempo+Server).

#### Good to Know

* This script requires Tempo Timesheets, Tempo Planner, or Tempo Budgets by Tempo for Jira.

## Script

```groovy
import com.adaptavist.hapi.jira.projects.Projects
import com.onresolve.scriptrunner.runner.customisers.PluginModule
import com.onresolve.scriptrunner.runner.customisers.WithPlugin
import com.tempoplugin.accounts.account.api.Account
import com.tempoplugin.accounts.account.api.AccountBuilderFactory
import com.tempoplugin.accounts.account.api.AccountService
import com.tempoplugin.accounts.link.api.AccountLink
import com.tempoplugin.accounts.link.api.AccountLinkService
import com.tempoplugin.platform.api.user.UserAuthenticationContext

@WithPlugin('is.origo.jira.tempo-plugin')

@PluginModule
AccountService accountService

@PluginModule
UserAuthenticationContext userAuthenticationContext

@PluginModule
AccountBuilderFactory accountBuilderFactory

@PluginModule
AccountLinkService accountLinkService

def accountTemplate = accountBuilderFactory
    .createBuilder('CYBER', 'Cyberdyne Systems', userAuthenticationContext.authenticatedUser, Account.Status.OPEN)
    .build()

def account = accountService.createAccount(accountTemplate).get()

def associatedProjectId = Projects.getByKey('SR').id
def accountLink = new AccountLink.Builder(
    AccountLink.ScopeType.PROJECT, associatedProjectId, account.id, AccountLink.LinkType.MANUAL
).build()

accountLinkService.addLink(accountLink, account)
```

