# Dynamic Text Field

- Platform: data-center
- Feature: behaviours
- Tags: customise, fields
- Language: groovy
- Doc ID: example-dataCenter-dynamic-text-field-onPrem
- Source: https://examples.scriptrunner.io/scripts/dynamic-text-field-onPrem

## Overview

Create dynamic text field content. Dynamic text field content allow you to specify the content displayed, depending on
which single-select option is picked.

## Example

I am in charge of a support team and want to create a drop-down list that shows products as single-select options. I
need this list to automatically fill the 'platform' field. For example, if I select Jira as a product, it automatically
fills the platform as 'Server' as we do not support Jira Cloud.

## Good to Know

* This script is executed as a Behaviour.
* Single select options and text field content can be customized with needed values.

## Script

```groovy
import com.onresolve.jira.groovy.user.FieldBehaviours
import groovy.transform.BaseScript

@BaseScript FieldBehaviours fieldBehaviours

final singleSelectName = 'Some Single Select'
final textFieldName = 'Some Text Field'

def singleSelect = getFieldByName(singleSelectName)
def singleSelectValue = singleSelect.value

def textField = getFieldByName(textFieldName)

//Set the appropriate value, dependent on the value of the currently selected single select option
switch (singleSelectValue) {
//Change 'Single Select Option...' to match your single select's values.
    case 'Single Select Option 1':
        textField.setFormValue('New value for Single Select Option 1')
        break
    case 'Single Select Option 2':
        textField.setFormValue('New value for Single Select Option 2')
        break
    case 'Single Select Option 3':
        textField.setFormValue('New value for Single Select Option 3')
        break
//Reset to default value if single select option is null or any other option that is not taken care of
    default:
        textField.setFormValue("")
}
```

