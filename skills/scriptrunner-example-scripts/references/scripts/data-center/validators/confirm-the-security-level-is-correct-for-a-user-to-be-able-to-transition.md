# Confirm the Security Level is Correct for a User to Be Able to Transition

- Platform: data-center
- Feature: validators
- Tags: automate, workflow, user
- Language: groovy
- Doc ID: example-dataCenter-verify-security-level-onPrem
- Source: https://examples.scriptrunner.io/scripts/verify-security-level-onPrem

## Overview

A *Simple Script Validator* enforces the security level of an issue to private when the reporter's domain
is *adaptavist.com*.

## Example

I am a Project Manager. I want the reporting users with a certain domain to be able to transition only tasks
with a certain security level.

## Good to Know

* You can choose the domain of the users affected by the validator.
* You can choose the *Issue Security Level* name of the issues that users can transition.
* For the script to work correctly, all the available corresponding permission settings for the *Issue Security Level*
field are required.

## Script

```groovy
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.issue.security.IssueSecurityLevelManager

def reporterDomain = issue.reporter.emailAddress.split('@').last()

// if the reporter domain is adaptavist.com then the issue should be private
if (reporterDomain == 'adaptavist.com') {
    def securityLevelManager = ComponentAccessor.getComponent(IssueSecurityLevelManager)
    def securityLevelId = issue.securityLevelId

    return securityLevelId ? securityLevelManager.getIssueSecurityName(securityLevelId) == 'Private' : false
}

true
```

