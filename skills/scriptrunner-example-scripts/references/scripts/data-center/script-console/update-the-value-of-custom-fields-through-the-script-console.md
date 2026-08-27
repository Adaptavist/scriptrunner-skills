# Update the Value of Custom Fields through the Script Console

- Platform: data-center
- Feature: script-console
- Tags: administer, fields, hapi
- Language: groovy
- Doc ID: example-dataCenter-basics-updating-customfields-onPrem
- Source: https://examples.scriptrunner.io/scripts/basics-updating-customfields-onPrem

## Overview

Update the value of custom fields. You can edit as many custom fields or system fields as you need. 
This is equivalent to doing an *Edit* operation in the user interface.

## Good to Know

* Multiple different custom field types are demonstrated here including *select lists*, *project pickers*, *user pickers*, *checkboxes*, *radio buttons*, etc.
* This is not the way to update field values in a post-function, for that case use `issue.set { ... }`

## Description

#### Overview
Update the value of custom fields. You can edit as many custom fields or system fields as you need. 
This is equivalent to doing an *Edit* operation in the user interface. 

#### Good to Know

* Multiple different custom field types are demonstrated here including *select lists*, *project pickers*, *user pickers*, *checkboxes*, *radio buttons*, etc.
* This is not the way to update field values in a post-function, for that case use `issue.set { ... }`

## Script

```groovy
// the issue key to update
def issueKey = "SR-1"

Issues.getByKey(issueKey).update {
    // set custom fields with options (select lists, checkboxes, radio buttons)
    setCustomFieldValue('SelectListA', 'BBB')
    setCustomFieldValue('MultiSelectA', 'BBB', 'CCC')
    setCustomFieldValue('RadioButtons', 'Yes')
    setCustomFieldValue('Checkboxes', 'Maybe', 'Yes')

    // cascading select
    setCustomFieldValue('CascadingSelect', 'BBB', 'B2')

    // set text fields
    setCustomFieldValue('TextFieldA', 'New Value')

    // set user fields
    setCustomFieldValue('UserPicker', 'bob')
    setCustomFieldValue('MultiUserPickerA', 'bob', 'alice')

    setCustomFieldValue('GroupPicker', 'jira-users')
    setCustomFieldValue('MultiGroupPicker', 'jira-users', 'jira-administrators')

    // set date, and date-time custom fields
    setCustomFieldValue('First DateTime', '04/Feb/12 8:47 PM')
    // setCustomFieldValue('Date', '04/Feb/12')

    // a "project picker" custom field - provide a project key
    setCustomFieldValue('ProjectPicker', 'SSPA')

    // set custom field of type version
    setCustomFieldValue('SingleVersionPicker', 'Version1')
}
```

