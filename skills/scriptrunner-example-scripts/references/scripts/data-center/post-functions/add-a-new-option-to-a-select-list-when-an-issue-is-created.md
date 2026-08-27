# Add a new option to a select list when an issue is created

- Platform: data-center
- Feature: post-functions
- Tags: automate, issue, fields, hapi
- Language: groovy
- Doc ID: example-dataCenter-update-select-list-options-from-new-client-request-onPrem
- Source: https://examples.scriptrunner.io/scripts/update-select-list-options-from-new-client-request-onPrem

## Overview

Use this script in a Custom script post-function to take the value of a Text Field when a user creates an issue, and add it to the available options for a Select List field.

## Example

When an order comes through from a new client we collect the necessary information, including the company name, in a "New Client" request.
Then, when the client requests a service, we fill out a "Service" request and choose the client's company from a "Company" select list field.
To minimize manual effort, we take the company name from the "New Client" request and automatically create a new option under our "Company" select list field.

## Good to Know

This script also sorts the list based on the option values.

## Script

```groovy
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.issue.context.IssueContext

def optionsManager = ComponentAccessor.getOptionsManager()

def companyName = issue.getCustomFieldValue('Company Name')
if (!companyName) {
    return
}

def companyField = ComponentAccessor.customFieldManager.getCustomFieldObjects().find { it.name == 'Company' }
def fieldConfig = companyField.getRelevantConfig(IssueContext.GLOBAL)
def options = optionsManager.getOptions(fieldConfig)

if (options.any { it.value == companyName }) {
    return
}

options.addOption(null, companyName)

// Get a fresh copy of the options object, as the one we have won't have been updated when we added the company name
optionsManager.getOptions(fieldConfig).sortOptionsByValue(null)
```

