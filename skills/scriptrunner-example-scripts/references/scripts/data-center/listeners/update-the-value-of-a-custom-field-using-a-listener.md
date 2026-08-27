# Update the Value of a Custom Field Using a Listener

- Platform: data-center
- Feature: listeners
- Tags: automate, fields
- Language: groovy
- Doc ID: example-dataCenter-update-cf-value-listener-onPrem
- Source: https://examples.scriptrunner.io/scripts/update-cf-value-listener-onPrem

## Overview

Update a *Text custom field* when an issue event is fired.

## Example

I'm a project manager and have created many issues for a project. I want to know which issues have been modified and
when so I can keep track of changes. To do this, I want a field to appear with the value 'modified' when an update is
made. With this listener, when a task is fired by this event, the indicated field is updated with the desired value.

## Good to Know

* Custom field name and value can be customized depends on your needs.
* The code is designed to be used with the `All Issue Events` event.

## Script

```groovy
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.issue.ModifiedValue
import com.atlassian.jira.issue.util.DefaultIssueChangeHolder

// the name of the custom field to update
final customFieldName = 'TextFieldA'

// the new value of the field
final newValue = 'I love Groovy !'

def customFieldManager = ComponentAccessor.customFieldManager
def issue = event.issue

def customField = customFieldManager.getCustomFieldObjects(issue).findByName(customFieldName)
assert customField : "Could not find custom field with name $customFieldName"

customField.updateValue(null, issue, new ModifiedValue(issue.getCustomFieldValue(customField), newValue), new DefaultIssueChangeHolder())
```

