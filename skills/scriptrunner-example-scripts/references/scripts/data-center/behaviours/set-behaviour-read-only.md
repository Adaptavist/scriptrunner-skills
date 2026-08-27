# Set Behaviour Read Only

- Platform: data-center
- Feature: behaviours
- Tags: customise, issue
- Language: groovy
- Doc ID: example-dataCenter-basics-behaviours-set-read-only-onPrem
- Source: https://examples.scriptrunner.io/scripts/basics-behaviours-set-read-only-onPrem

## Overview

*Behaviours* allow you to change how fields behave on issue Create or Update screens.
Using this script, you can set a field as read-only on these screens, so the user cannot edit it.

## Example

As an admin, I want to disable a field temporarily so users can't update it for a specified time.
I use this script to make the field read-only for a set time, after which it is editable again.

## Good to Know

* As an example, the script set as read-only two fields: the default "Due Date" field and a custom field with name "TextField".
* You can use this script as part of a larger script to hide fields based on additional conditions.

## Script

```groovy
import com.atlassian.jira.issue.IssueFieldConstants
import com.onresolve.jira.groovy.user.FieldBehaviours
import groovy.transform.BaseScript

@BaseScript FieldBehaviours fieldBehaviours

final String fieldName = "TextField"

// get field by name and make it read only
getFieldByName(fieldName).setReadOnly(true)

// get field by id and make it read only
getFieldById(IssueFieldConstants.DUE_DATE).setReadOnly(true)
```

