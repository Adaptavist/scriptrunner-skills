# Set the Value of Date or Date-Time Fields

- Platform: data-center
- Feature: behaviours
- Tags: customise, issue, fields
- Language: groovy
- Doc ID: example-dataCenter-set-date-field-value-onPrem
- Source: https://examples.scriptrunner.io/scripts/set-date-field-value-onPrem

## Overview

*Behaviours* allow you to change how fields behave on issue Create or Update screens.
Use this script to set a Date or Date-time field value with the format required by Jira.

## Example

As a support engineer, I want users to be able to see the latest date an issue will be resolved.
I can use this script to automatically set a Date or Date-time field to show a specific date, for instance, two weeks from the creation date.

## Good to Know

* Set up this script as an initialiser.
* The dates are converted accordingly from a base time zone to the user time zone.
* The user locale is taken into account to show the date in the format required by Jira.

## Script

```groovy
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.config.properties.APKeys
import com.atlassian.jira.datetime.DateTimeFormatter as JiraDateTimeFormatter
import com.atlassian.jira.issue.customfields.impl.DateTimeCFType
import com.atlassian.jira.issue.fields.CustomField
import com.onresolve.jira.groovy.user.FieldBehaviours
import org.apache.log4j.Logger
import org.apache.log4j.Level
import groovy.transform.BaseScript
import java.time.LocalDate
import java.time.LocalDateTime
import java.time.ZoneId
import java.time.temporal.TemporalAccessor
import java.time.format.DateTimeFormatter

@BaseScript FieldBehaviours fieldBehaviours

// Set log level
def log = Logger.getLogger(getClass())
log.setLevel(Level.DEBUG)

// The date & date time field names to set a value
final dateFieldName = "DateFieldA"
final dateTimeFieldName = "DateTimeFieldA"

// Get the components
def customFieldManager = ComponentAccessor.customFieldManager
def authenticationContext = ComponentAccessor.jiraAuthenticationContext
// Get the Jira date time formatter for the logged in user, so we can get the correct locale and user timezone
def userFormatter = ComponentAccessor.getComponent(JiraDateTimeFormatter).forUser(authenticationContext.loggedInUser)

// Get the date & date time field objects
def dateField = customFieldManager.getCustomFieldObjectsByName(dateFieldName).first()
def dateTimeField = customFieldManager.getCustomFieldObjectsByName(dateTimeFieldName).first()

// Set the wanted dates params for values, format pattern and timezone to interpret the dates in
final timeZoneId = ZoneId.systemDefault()
final dateFormatter = DateTimeFormatter.ofPattern('yyyy/MM/dd')
final dateTimeFormatter = DateTimeFormatter.ofPattern('yyyy/MM/dd HH:mm:ss')
final wantedDateAsText = '2020/11/28'
final wantedDateTimeAsText = '2020/11/01 12:12:00'

// Parse the dates as interpreted in the chosen time zone and convert to the user time zone, to make sure the user sees the date in his time zone
def userTimeZoneId = userFormatter.zone.toZoneId()
def wantedDate = LocalDate.parse(wantedDateAsText, dateFormatter)
    .atStartOfDay(timeZoneId)
    .withZoneSameInstant(userTimeZoneId)
def wantedDateTime = LocalDateTime.parse(wantedDateTimeAsText, dateTimeFormatter)
    .atZone(timeZoneId)
    .withZoneSameInstant(userTimeZoneId)

// Populate the fields
getFieldByName("DateFieldA").setFormValue(getJiraDateFormattedForUser(wantedDate, dateField, userFormatter))
getFieldByName("DateTimeFieldA").setFormValue(getJiraDateFormattedForUser(wantedDateTime, dateTimeField, userFormatter))

/**
 * Get the date or date time values in the format expected by Jira an behaviours for fields
 * @param inputDate The input date or date time to format
 * @param sourceField The field object in which the value will be set
 * @param dateTimeFormatter the Jira's date time formatter to extract the user's locale info
 * @return The formatted date time
 */
static String getJiraDateFormattedForUser(TemporalAccessor inputDate, CustomField sourceField, JiraDateTimeFormatter dateTimeFormatter) {
    // Get the Jira date format property key depending on the field type (date or date time)
    def dateFormatPatternProperty = (sourceField.customFieldType in DateTimeCFType) ? APKeys.JIRA_DATE_TIME_PICKER_JAVA_FORMAT : APKeys.JIRA_DATE_PICKER_JAVA_FORMAT
    // Get the format string, so we can format dates how Jira expects
    def dateFormatPattern = ComponentAccessor.applicationProperties.getDefaultBackedString(dateFormatPatternProperty)
    // Build the formatter object
    def formatterForFieldType = DateTimeFormatter.ofPattern(dateFormatPattern, dateTimeFormatter.locale)
    // Return the formatted date string that can be used to set date or date time fields
    formatterForFieldType.format(inputDate)
}
```

