# Update Multiple Fields

- Platform: cloud
- Feature: listeners
- Tags: issue, hapi, automate, fields
- Language: groovy
- Doc ID: example-cloud-update-multiple-fields-cloud
- Source: https://examples.scriptrunner.io/scripts/update-multiple-fields-cloud

## Overview

This script demonstrates how to update multiple fields on a Jira work item in a single operation. 
It streamlines the process of modifying work item attributes, ensuring that relevant information is kept up to date efficiently.

## Good to Know

Useful when implementing bulk updates or when consolidating multiple changes into a single workflow transition.

## Description

#### Overview
This script demonstrates how to update multiple fields on a Jira work item in a single operation. 
It streamlines the process of modifying work item attributes, ensuring that relevant information is kept up to date efficiently.

#### Good to know
Useful when implementing bulk updates or when consolidating multiple changes into a single workflow transition.

## Script

```groovy
def eventWorkItem = WorkItems.getByKey(issue.key as String)

def toUpdate1CfId = "Custom Field 1"
def toUpdate2CfId = "Custom Field 2"
def toUpdate3CfId = "Custom Field 3"

def tomorrowStr = (new Date() + 1).format("yyyy-MM-dd'T'HH:mm:ssZ", TimeZone.getTimeZone("UTC")) // date format in iso8601

eventWorkItem.update{
    setFixVersions("1.1")
    setComponents("My Component")
    setDescription("A generated description")
    setCustomFieldValue(toUpdate1CfId, "Some text value")
    setCustomFieldValue(toUpdate2CfId, tomorrowStr)
    setCustomFieldValue(toUpdate3CfId, "admin")
}
```

