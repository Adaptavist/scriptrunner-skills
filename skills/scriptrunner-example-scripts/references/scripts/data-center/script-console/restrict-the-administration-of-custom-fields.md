# Restrict the Administration of Custom Fields

- Platform: data-center
- Feature: script-console
- Tags: customise, fields
- Language: groovy
- Doc ID: example-dataCenter-restrict-custom-field-access-onPrem
- Source: https://examples.scriptrunner.io/scripts/restrict-custom-field-access-onPrem

## Overview

This script allows you to change the permission of a custom field to restrict who can edit it.

## Example

I am a project manager, and in my team, many developers work on one issue at a time. I have several custom fields
and I want to restrict access to these so only users in the Administrator role can update them.
Using this script, I can set permissions on each of my custom fields.

## Good to Know

The following three access levels are available:
* **LOCK** No user can edit the field's configuration.
* **SYSTEM_ADMIN_LVL** Only system administrators can edit the field's configuration.
* **ADMIN_LVL** System administrators or administrators can edit the field's configuration.

## Script

```groovy
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.config.managedconfiguration.ManagedConfigurationItemBuilder
import com.atlassian.jira.config.managedconfiguration.ManagedConfigurationItemService

import static com.atlassian.jira.config.managedconfiguration.ConfigurationItemAccessLevel.*

// the name of the custom field
final customFieldName = 'TextFieldA'

def customField = ComponentAccessor.customFieldManager.customFieldObjects.findByName(customFieldName)
assert customField: "Could not find custom field with name $customFieldName"

def managedConfigurationItemService = ComponentAccessor.getComponent(ManagedConfigurationItemService)
def field = managedConfigurationItemService.getManagedCustomField(customField)

def managedField = ManagedConfigurationItemBuilder
    .builder(field)
    .setManaged(true)
    .setConfigurationItemAccessLevel(ADMIN)
    .build()

def outcome = managedConfigurationItemService.updateManagedConfigurationItem(managedField)
assert outcome.valid: outcome.errorCollection
```

