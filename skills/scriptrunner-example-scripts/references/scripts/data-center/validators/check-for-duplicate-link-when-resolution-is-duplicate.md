# Check for Duplicate Link when Resolution is Duplicate

- Platform: data-center
- Feature: validators
- Tags: automate, workflow
- Language: groovy
- Doc ID: example-dataCenter-duplicate-check-onPrem
- Source: https://examples.scriptrunner.io/scripts/duplicate-check-onPrem

## Overview

This ScriptRunner validator checks that you have a duplicate link on an issue that you are trying to give a
Duplicate resolution to. If you don't have a Duplicate issue linked, an error is shown.

## Example

As a project manager, I want to ensure the Duplicate resolution is used correctly, and that I do not forget to add a
duplicate link when I transition an issue with the Duplicate resolution value. This validator script stops
the transition of a duplicated issue is there is no Duplicate issue link.

## Good to Know

* You can customize the error message you will see during the setup.
* You should set this up as a Simple Scripted validator.
* You can choose the action to execute the validator script.

## Script

```groovy
import com.atlassian.jira.component.ComponentAccessor

issue.resolution?.name == 'Duplicate' && ComponentAccessor.issueLinkManager.getOutwardLinks(issue.id)*.issueLinkType.name.contains('Duplicate')
```

