# Trim Whitespace from Custom Field Names

- Platform: data-center
- Feature: script-console
- Tags: automate, issue
- Language: groovy
- Doc ID: example-dataCenter-trim-space-from-custom-field-names-onPrem
- Source: https://examples.scriptrunner.io/scripts/trim-space-from-custom-field-names-onPrem

## Overview

Trim leading and trailing space from custom field names.

## Example

As a Jira admin, I want to fix custom field names that were created with a leading or trailing space. This is to avoid
any potential issues when referring to a field with unknown whitespace. I can use this script to remove the leading or
trailing whitespace from all of my custom fields, meaning I do not have to edit each affected field manually.

## Good to Know

* This may break any saved JQL filters that reference these fields. See https://jira.atlassian.com/browse/JRASERVER-61048.

## Script

```groovy
import com.atlassian.jira.component.ComponentAccessor

def customFieldManager = ComponentAccessor.customFieldManager
customFieldManager.customFieldObjects.each {
    if (it.name != it.name.trim()) {
        log.warn("Modifying field with leading or trailing whitespace: '${it.name}'")

        // Update the field - to preview only comment out the following line
        customFieldManager.updateCustomField(it.idAsLong, it.name.trim(), it.description, it.customFieldSearcher)
    }
}
```

