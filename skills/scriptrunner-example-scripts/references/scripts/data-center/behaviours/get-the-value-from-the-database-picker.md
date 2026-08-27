# Get the Value from the Database Picker

- Platform: data-center
- Feature: behaviours
- Tags: issue, fields
- Language: groovy
- Doc ID: example-dataCenter-get-the-value-from-the-db-picker-onPrem
- Source: https://examples.scriptrunner.io/scripts/get-the-value-from-the-db-picker-onPrem

## Overview

This sample [behaviour](https://docs.adaptavist.com/display/SR4JS/Behaviours) code provides the ability to get the displayed value from the database picker field and pass it to a text field.

## Example

I am a project manager, and the issues in my Jira instance include a [database picker script field](https://docs.adaptavist.com/display/SR4JS/Database+Picker) that allows me to 
select a customer from our internal customer relationship management (CRM) database. I want to take the value selected from that database picker field and pass it to a text field. 
However, the value returned by the database picker field is the ID of the customer in our CRM, rather than the customer's name.

This script enables me to take the name displayed in the database picker field and paste it into a specified text field.

## Good to Know

In this sample code, the database picker is connected to the local database used by Jira. For more information on how to configure the 
local database connection, please visit this [link](https://docs.adaptavist.com/sr4js/latest/features/resources/local-database-connection)

## Script

```groovy
import com.onresolve.jira.groovy.user.FieldBehaviours
import com.onresolve.scriptrunner.db.DatabaseUtil
import groovy.transform.BaseScript

@BaseScript FieldBehaviours behaviours
final def dbConnectionName = '<DB_CONNECTION_NAME>'
final def fieldName = '<FIELD_NAME>'
final def tableName = '<TABLE_NAME>'
final def columnName = '<COLUMN_NAME>'

def dbPicker = getFieldById(fieldChanged)
def dbPickerValue = dbPicker.value as Integer
def sampleTextField = getFieldByName(fieldName)

def dbResultValue = new StringBuilder()
def output = []

if (dbPicker) {
    DatabaseUtil.withSql(dbConnectionName) { sql ->
        if (dbPicker.value) {
            output = sql.rows("select ${columnName} from ${tableName} where id = ?",  dbPickerValue)
        }
    }

    output.collectEntries {
        it
    }.values().findAll {
        dbResultValue.append(it.toString())
    }
}

sampleTextField.setFormValue(dbResultValue.toString())
```

