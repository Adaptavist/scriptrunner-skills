# Dynamic Date Field

- Platform: data-center
- Feature: behaviours
- Tags: customise, fields
- Language: groovy
- Doc ID: example-dataCenter-dynamic-date-field-onPrem
- Source: https://examples.scriptrunner.io/scripts/dynamic-date-field-onPrem

## Overview

Create dynamic text field content. Dynamic text field content allow you to specify the content displayed, depending on
which single-select option is picked.

## Example

I am in charge of a support team and want to create a drop-down list that shows products as single-select options. I
need this list to automatically fill the 'latest version released' date of this product. For example, if I select Jira
as a product, it automatically fills in latest version released date defined for this product.

## Good to Know

* This script is executed as a Behaviour.
* Single select options and date field content can be customized with needed values.

## Script

```groovy
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.config.properties.APKeys
import com.onresolve.jira.groovy.user.FieldBehaviours
import com.onresolve.jira.groovy.user.FormField
import groovy.transform.BaseScript

import java.time.LocalDateTime
import java.time.LocalTime
import java.time.format.DateTimeFormatter

@BaseScript FieldBehaviours fieldBehaviours

final singleSelectName = 'Some Single Select'
final dateFieldName = 'Some Date Field'

def singleSelect = getFieldByName(singleSelectName)
def singleSelectValue = singleSelect.value
def dateField = getFieldByName(dateFieldName)

//Set the appropriate date value, dependent on the value of the currently selected single select option
switch (singleSelectValue) {
// Change 'Single Select Option...' to match your single select's values.
    case '1':
        setValueToDateField(1, dateField)
        break
    case '2':
        setValueToDateField(2, dateField)
        break
    case '3':
        setValueToDateField(3, dateField)
        break
//Reset to default value if single select option is null or any other option that is not taken care of
    default:
        dateField.setFormValue('')
}

void setValueToDateField(Integer offsetDays, FormField dateField) {
    def currentUser = ComponentAccessor.jiraAuthenticationContext.loggedInUser

    def dateFormatText = ComponentAccessor.applicationProperties.getDefaultBackedString(APKeys.JIRA_DATE_PICKER_JAVA_FORMAT)
    def jiraFormatter = ComponentAccessor.getComponent(com.atlassian.jira.datetime.DateTimeFormatter).forUser(currentUser)

    def dateFieldFormat = DateTimeFormatter.ofPattern(dateFormatText, jiraFormatter.locale)

    def newLocalDateTime = LocalDateTime.now().with(LocalTime.MIN).plusDays(offsetDays)
    dateField.setFormValue(dateFieldFormat.format(newLocalDateTime))
}
```

