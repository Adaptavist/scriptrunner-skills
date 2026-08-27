# Change Description Label Based on Priority

- Platform: data-center
- Feature: behaviours
- Tags: customise, ui, fields
- Language: groovy
- Doc ID: example-dataCenter-change-description-label-based-on-priority-onPrem
- Source: https://examples.scriptrunner.io/scripts/change-description-label-based-on-priority-onPrem

## Overview

Behaviours define how fields behave for issues in a given project or issue context. Screens enable you to change the
displayed fields when creating and editing an issue, or transitioning a workflow. This script allows you to execute a
behaviour logic inside a specific issue screen, such as a request form.

## Example

I work in Product Support, and customers often report bugs. When a bug is opened, customers can specify the priority.
I can use this behaviour script to modify the Description help text when the "Highest" value is selected, so I can
understand why the priority is so high.

## Good to Know

* If you want behaviours to be active in the customer portal, you must create a Service Desk mapping. Even if you
associate a behaviour with All Issue Types in a project, unless you create a mapping to the Service Desk portal, they
won't be active.
* This scripts needs to be associated with "Priority" field.

## Script

```groovy
import com.onresolve.jira.groovy.user.FieldBehaviours
import com.atlassian.jira.issue.priority.Priority
import groovy.transform.BaseScript

@BaseScript FieldBehaviours fieldBehaviours

if ((getFieldById(fieldChanged).value as Priority)?.name == 'Highest') {
    getFieldById('description')
        .setLabel('Why do you need this and why so important?')
        .setDescription('Please explain why this is Highest priority including details of outage etc.')
} else {
    getFieldById('description')
        .setLabel('Why do you need this?')
        .setDescription('Tell us why you want this.')
}
```

