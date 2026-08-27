# Trim Whitespace from Custom Field Option Values

- Platform: data-center
- Feature: script-console
- Tags: automate, issue
- Language: groovy
- Doc ID: example-dataCenter-trim-space-from-custom-field-options-onPrem
- Source: https://examples.scriptrunner.io/scripts/trim-space-from-custom-field-options-onPrem

## Overview

Trim leading and trailing space from custom field option values.

## Example

As a Jira admin, I want to fix custom field options that were created with a leading or trailing space. This is to
avoid any potential issues when referring to a field option with unknown whitespace. I can use this script to remove
the leading or trailing whitespace from all of my custom field options, meaning I do not have to edit each affected
option manually.

## Good to Know

* This may break any saved JQL filters that reference these field values. See https://jira.atlassian.com/browse/JRASERVER-61048.

## Script

```groovy
import com.atlassian.jira.component.ComponentAccessor

def optionsManager = ComponentAccessor.optionsManager

optionsManager.allOptions.findAll {
    it.value != it.value.trim()
}.each {
    optionsManager.setValue(it, it.value.trim())
}
```

