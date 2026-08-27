# Set Form Field Values from Issue in Picker

- Platform: data-center
- Feature: behaviours
- Tags: customise, issue, fields
- Language: groovy
- Doc ID: example-dataCenter-set-form-fields-from-issue-picker-onPrem
- Source: https://examples.scriptrunner.io/scripts/set-form-fields-from-issue-picker-onPrem

## Overview

*Behaviours* allow you to change how fields behave on issue create or update screens.
Use this script to populate the values of a new issue with the values of an issue selected in an single-select issue picker field.

## Example

As a support engineer, I create development issues associated with problems reported by users.
Some field values are replicated between the created development issue and the user request.
This script allows me to set the values automatically, saving me the time of manually copying it across.

## Good to Know

* Associate this script with a single-select issue picker field.

## Script

```groovy
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.config.properties.APKeys
import com.atlassian.jira.datetime.DateTimeFormatter
import com.atlassian.jira.issue.customfields.impl.DateTimeCFType
import com.atlassian.jira.issue.fields.CustomField
import com.onresolve.jira.groovy.user.FieldBehaviours
import org.apache.log4j.Logger
import org.apache.log4j.Level
import groovy.transform.BaseScript

import java.sql.Timestamp
import java.text.SimpleDateFormat

@BaseScript FieldBehaviours fieldBehaviours

// Set the log level
def log = Logger.getLogger(getClass())
log.setLevel(Level.DEBUG)

// The issue picker field name param and also the field this behaviour is connected to in the behaviour
final issuePickerFieldName = "Related Issue"
// The fields to populate name params
final textFieldName = 'TextFieldA'
final dateFieldName = 'DateFieldA'
final dateTimeFieldName = 'DateTimeFieldA'

def issuePickerField = getFieldByName(issuePickerFieldName)
def issuePickerFieldValue = issuePickerField.value

//If there is no value, do nothing
if (!issuePickerFieldValue) {
    return
}

log.debug("""Value = ${issuePickerFieldValue}
Value Type = ${issuePickerFieldValue.class}""")

def relatedIssue = ComponentAccessor.issueManager.getIssueByCurrentKey(issuePickerFieldValue as String)
if (!relatedIssue) {
    log.error("Could not find issue with key $issuePickerFieldValue")
    return
}

log.debug("""Selected Issue Key = ${relatedIssue.key}
Selected Issue Summary = ${relatedIssue.summary}""")

def customFieldManager = ComponentAccessor.customFieldManager
// Find the fields on the current [create/edit/transition] screen and populate its fields with values from the selected issue
def myTextField = customFieldManager.getCustomFieldObjectsByName(textFieldName)[0]
def myDateField = customFieldManager.getCustomFieldObjectsByName(dateFieldName)[0]
def myDateTimeField = customFieldManager.getCustomFieldObjectsByName(dateTimeFieldName)[0]

// Get the values from the picked issue fields if they exist
def relatedCustomTextFieldValue = (myTextField ? relatedIssue.getCustomFieldValue(myTextField) : null) as String
def relatedCustomDateFieldValue = (myDateField ? relatedIssue.getCustomFieldValue(myDateField) : null) as Timestamp
def relatedCustomDateTimeFieldValue = (myDateTimeField ? relatedIssue.getCustomFieldValue(myDateTimeField) : null) as Timestamp

log.debug("""Related issue values:
summary = ${relatedIssue.summary}
custom Text Field = ${relatedCustomTextFieldValue}
custom Date Field = ${relatedCustomDateFieldValue}
custom Date Field Type = ${relatedCustomDateFieldValue.class}
custom Date Time Field = ${relatedCustomDateTimeFieldValue}
custom Date Time Field Type = ${relatedCustomDateTimeFieldValue.class}""")

// Populate basic TextField single line
getFieldByName("TextFieldA")
    .setFormValue(relatedCustomTextFieldValue)
    .setDescription("Defaulted value set from related issue ${relatedIssue.key} ")

// Populate Date Field
getFieldByName("DateFieldA")
    .setFormValue(dateFormatterForUser(relatedCustomDateFieldValue, myDateField))
    .setDescription("Defaulted value set from related issue ${relatedIssue.key} ")

// Populate DateTime Field
getFieldByName("DateTimeFieldA")
    .setFormValue(dateFormatterForUser(relatedCustomDateTimeFieldValue, myDateTimeField))
    .setDescription("Defaulted value set from related issue ${relatedIssue.key} ")

/**
 * Used to get the correct format for setting date or date time fields with behaviours
 *
 * @param inputDate The input date to format
 * @param sourceField The custom field where the input date comes from
 * @return The formatted date
 */
static String dateFormatterForUser(Timestamp inputDate, CustomField sourceField) {
    //Get the jira time format property key
    def dateFormatProperty = (sourceField.customFieldType instanceof DateTimeCFType) ?
        APKeys.JIRA_DATE_TIME_PICKER_JAVA_FORMAT : APKeys.JIRA_DATE_PICKER_JAVA_FORMAT
    //Get the formatString so we can format dates how Jira expects
    def requiredDateFormat = ComponentAccessor.applicationProperties.getDefaultBackedString(dateFormatProperty)
    //Get the Jira DateTimeFormatter so we can get the correct locale associated with the user
    def user = ComponentAccessor.jiraAuthenticationContext.loggedInUser
    def jiraFormatter = ComponentAccessor.getComponent(DateTimeFormatter).forUser(user)
    //Build the formatter object
    def formatterForFieldType = new SimpleDateFormat(requiredDateFormat, jiraFormatter.locale)
    //Return the formatted date string that can be used to set Date or DateTime fields
    formatterForFieldType.format(inputDate)
}
```

