# Validate the User Group of the Assignee

- Platform: data-center
- Feature: validators
- Tags: automate, workflow, user
- Language: groovy
- Doc ID: example-dataCenter-validate-user-group-onPrem
- Source: https://examples.scriptrunner.io/scripts/validate-user-group-onPrem

## Overview

A *Simple Scripted Validator* that enforces the *Assignee* to be a member of a specific group.

## Example

I am a project manager with a large team. I want only certain members of my team to be able to transition issues to
the *Done* state. I can add these users to a user group. Then, with this script, I can specify that only users
belonging to that user group can transition issues to *Done*.

## Good to Know

* You can choose the user group name that containing the users with permission to transition.
* The users that are not in the user group with permission can't to transition the issue to any state.

## Script

```groovy
import com.atlassian.jira.component.ComponentAccessor

// the name of the group you want to check
final String groupName = 'jira-developers'

issue.assignee ? ComponentAccessor.groupManager.isUserInGroup(issue.assignee, groupName) : false
```

