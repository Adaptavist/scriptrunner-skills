# Populate Content Dynamically Based on Issue Selected

- Platform: data-center
- Feature: behaviours
- Tags: customise, fields
- Language: groovy
- Doc ID: example-dataCenter-populate-content-dynamically-based-on-issue-selected-onPrem
- Source: https://examples.scriptrunner.io/scripts/populate-content-dynamically-based-on-issue-selected-onPrem

## Overview

*Behaviours* allow you to change how fields behave on issue Create or Update screens.
Using this script, populate field values based on the issue that is selected in an issue picker field.

## Example

As a user, I want to raise a bug through the Service Desk portal related to a feature I requested. Using this script
as part of a behaviour, I can populate all fields relating to the original feature request ticket automatically when
the feature request issue is selected in the 'Related Issue' field.

## Good to Know

* Fields can be customised based on your needs. In this script, the following fields are specified: text, date,
  date-time, single-select, multi-select, and user picker.
* Service Desk request types must have the corresponding fields you want to show in the portal.

## Script

```groovy
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.config.properties.APKeys
import com.atlassian.jira.datetime.DateTimeFormatter as JiraDateTimeFormatter
import com.atlassian.jira.issue.customfields.impl.DateTimeCFType
import com.atlassian.jira.issue.customfields.option.LazyLoadedOption
import com.atlassian.jira.issue.fields.CustomField
import com.atlassian.jira.user.ApplicationUser
import com.onresolve.jira.groovy.user.FieldBehaviours
import groovy.transform.BaseScript
import groovy.transform.Field
import org.apache.log4j.Level
import org.apache.log4j.Logger

import java.sql.Timestamp
import java.time.format.DateTimeFormatter

@BaseScript FieldBehaviours fieldBehaviours
@Field ApplicationUser loggedInUser = ComponentAccessor.jiraAuthenticationContext.loggedInUser

// Set log level
def log = Logger.getLogger(getClass())
log.setLevel(Level.DEBUG)

// Related issue field name
final relatedIssueName = 'Related Issue'

// Related fields names that are going to be automatically filled
final textFieldName = 'TextFieldA'
final dateFieldName = 'DateFieldA'
final dateTimeFieldName = 'DateTimeFieldA'
final singleSelectFieldName = 'SingleSelectFieldA'
final multipleSelectFieldName = 'MultipleSelectFieldA'
final userFieldName = 'UserFieldA'

//Issue picker field and its value is obtained
def issuPickerField = getFieldByName(relatedIssueName)
def issuePickerFieldValue = issuPickerField.value

// If there is no value, all fields are cleared
if (!issuePickerFieldValue) {
    clearSimpleFields('', textFieldName, dateFieldName, dateTimeFieldName, singleSelectFieldName, userFieldName)
    clearSelectFields(singleSelectFieldName, multipleSelectFieldName)
    return
}

log.debug("""
value = ${issuePickerFieldValue}
value type = ${issuePickerFieldValue.getClass()}
""")

// Related issue is obtained
def relatedIssue = ComponentAccessor.issueManager.getIssueByCurrentKey(issuePickerFieldValue as String)

// If there is not related issue, it is not needed to continue
if (!relatedIssue) {
    log.debug("Could not find issue with key $issuePickerFieldValue")
    return
}

log.debug("""
Selected Issue Key = ${relatedIssue.key}
Selected Issue Summary = ${relatedIssue.summary}
""")

// All fields and their related values, on the current create, edit or transition screen, are obtained
def customFieldManager = ComponentAccessor.customFieldManager
def myTextField = customFieldManager.customFieldObjects.find { it.name == textFieldName }
def myDateField = customFieldManager.customFieldObjects.find { it.name == dateFieldName }
def myDateTimeField = customFieldManager.customFieldObjects.find { it.name == dateTimeFieldName }
def mySingleSelectField = customFieldManager.customFieldObjects.find { it.name == singleSelectFieldName }
def myMultipleSelectField = customFieldManager.customFieldObjects.find { it.name == multipleSelectFieldName }
def myUserField = customFieldManager.customFieldObjects.find { it.name == userFieldName }

def relatedCustomTextFieldValue = myTextField ? relatedIssue.getCustomFieldValue(myTextField) : null
def relatedCustomDateFieldValue = myDateField ? relatedIssue.getCustomFieldValue(myDateField) : null
def relatedCustomDateTimeFieldValue = myDateTimeField ? relatedIssue.getCustomFieldValue(myDateTimeField) : null
def relatedCustomSingleSelectFieldValue = mySingleSelectField ? relatedIssue.getCustomFieldValue(mySingleSelectField) : null
def relatedCustomMultipleSelectFieldValues = myMultipleSelectField ? relatedIssue.getCustomFieldValue(myMultipleSelectField) : null
def relatedCustomUserFieldValue = myUserField ? relatedIssue.getCustomFieldValue(myUserField) : null

log.debug("""

Related issue values:

custom Text Field = $relatedCustomTextFieldValue
custom Date Field = $relatedCustomDateFieldValue
custom Date Field Type = ${relatedCustomDateFieldValue.getClass()}
custom Date Time Field = $relatedCustomDateTimeFieldValue
custom Date Time Field Type = ${relatedCustomDateTimeFieldValue.getClass()}
custom Single Select Time Field = $relatedCustomSingleSelectFieldValue
custom Single Select Time Field Type = ${relatedCustomSingleSelectFieldValue.getClass()}
custom Multiple Select Time Field = $relatedCustomMultipleSelectFieldValues
custom Multiple Select Time Field Type = ${relatedCustomMultipleSelectFieldValues.getClass()}
custom User Field = $relatedCustomUserFieldValue
custom User Field Type = ${relatedCustomUserFieldValue.getClass()}
""")

def description = "Defaulted value set from related issue ${relatedIssue.key}"

//Basic Text Field single line is populated
if (relatedCustomTextFieldValue) {
    getFieldByName(textFieldName)
        .setFormValue(relatedCustomTextFieldValue)
        .setDescription(description)
}

// Date Field is populated, if the value is an instance of Timestamp
if (relatedCustomDateFieldValue instanceof Timestamp) {
    getFieldByName(dateFieldName)
        .setFormValue(dateFormatterForUser(relatedCustomDateFieldValue, myDateField, loggedInUser))
        .setDescription(description)
}

// Date Time Field is populated, if the value is an instance of Timestamp
if (relatedCustomDateTimeFieldValue instanceof Timestamp) {
    getFieldByName(dateTimeFieldName)
        .setFormValue(dateFormatterForUser(relatedCustomDateTimeFieldValue, myDateTimeField, loggedInUser))
        .setDescription(description)
}

// Single Select Field is populated
if (relatedCustomSingleSelectFieldValue) {
    // Value obtained is an instance of LazyLoadedOption
    getFieldByName(singleSelectFieldName)
        .setFormValue((relatedCustomSingleSelectFieldValue as LazyLoadedOption).value)
        .setDescription(description)
}

// Multiple Select Field is populated Populate Multiple Select Field
if (relatedCustomMultipleSelectFieldValues) {
    // Values obtained are instance of List<LazyLoadedOption>. In this case is needed to obtain their ID to assign them to the field
    getFieldByName(multipleSelectFieldName)
        .setFormValue((relatedCustomMultipleSelectFieldValues as List<LazyLoadedOption>)*.optionId)
        .setDescription(description)
}

// User Field is populated
if (relatedCustomUserFieldValue instanceof ApplicationUser) {
    getFieldByName(userFieldName)
        .setFormValue((relatedCustomUserFieldValue as ApplicationUser).name)
        .setDescription(description)
}

/** Get the correct format for setting Date fields with behaviours.
 * @param Timestamp inputDate Date field value, as calling issue.getCustomFieldValue on date fields in Jira usually returns a java.sql.Timestamp
 * @param CustomField sourceField Type of date field (Date or a DateTime)
 * @param user Logged in user
 * @return
 */
static String dateFormatterForUser(Timestamp inputDate, CustomField sourceField, ApplicationUser user) {
    // Get the jira time format property key
    def dateFormatProperty = (sourceField.customFieldType instanceof DateTimeCFType) ? APKeys.JIRA_DATE_TIME_PICKER_JAVA_FORMAT : APKeys.JIRA_DATE_PICKER_JAVA_FORMAT
    // Get the formatString so dates can be formatted in the way Jira expects
    def requiredDateFormat = ComponentAccessor.applicationProperties.getDefaultBackedString(dateFormatProperty)
    // Get the Jira DateTimeFormatter so correct locale can be obtained
    def jiraFormatter = ComponentAccessor.getComponent(JiraDateTimeFormatter).forUser(user)
    // Build the formatter object
    def formatterForFieldType = DateTimeFormatter.ofPattern(requiredDateFormat, jiraFormatter.locale)
    // The formatted date string, that can be used to set Date or DateTime, is returned
    formatterForFieldType.format(inputDate.toLocalDateTime())
}

/**
 * Clear all defined fields setting value with the corresponding empty value and description as empty text.
 * @param emptyValue Value to be set
 * @param fieldName Fields names list
 */
void clearSimpleFields(def emptyValue, String... fieldName) {
    fieldName.each {
        getFieldByName(it as String)
            .setFormValue(emptyValue)
            .setDescription('')
    }
}

/**
 * Clear all selected (multi and single) fields setting value as "None" option (depending on the user language).
 * @param fieldName Field names to clear
 */
void clearSelectFields(String... fieldName) {
    def i18nHelper = ComponentAccessor.i18nHelperFactory.getInstance(loggedInUser)
    def noneOption = i18nHelper.getText("common.words.none")
    clearSimpleFields(noneOption, fieldName)
}
```

