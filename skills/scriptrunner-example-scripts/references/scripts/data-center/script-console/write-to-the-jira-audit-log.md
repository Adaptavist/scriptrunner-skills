# Write to the Jira Audit Log

- Platform: data-center
- Feature: script-console
- Tags: administer, system, reporting
- Language: groovy
- Doc ID: example-dataCenter-write-to-audit-log-onPrem
- Source: https://examples.scriptrunner.io/scripts/write-to-audit-log-onPrem

## Overview

Write a record to the audit log.

## Example

As a developer, I want to check the result of a script execution. To do this, I can create a record with the
information in the audit log using this script.

## Good to Know

* To create a *Record* you must first create a *RecordRequest*.
* You must specify *the category of Record*. You can see the types of categories available in the
`com.atlassian.jira.auditing.AuditingCategory` file.

## Script

```groovy
import com.atlassian.jira.auditing.*
import com.atlassian.jira.component.ComponentAccessor

final customFieldName = 'GroupPicker'

def auditingManager = ComponentAccessor.getComponent(AuditingManager)
def fields = ComponentAccessor.customFieldManager.getCustomFieldObjectsByName(customFieldName)

assert fields // Failed to find any fields with this name

def field = fields.first()

def record = new RecordRequest(AuditingCategory.FIELDS, 'Foo bar...')
    .withChangedValues(
        new ChangedValueImpl('A Name', 'Previous value', 'New value'),
        new ChangedValueImpl('Another name', 'I used to be...', 'And I\'m now...'),
    )
    .forObject(AssociatedItem.Type.CUSTOM_FIELD, field.name, field.id) // adding an object is optional...

auditingManager.store(record)
```

