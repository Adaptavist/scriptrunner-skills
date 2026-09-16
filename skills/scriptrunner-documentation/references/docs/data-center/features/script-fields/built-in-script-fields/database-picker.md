# Database Picker

- Platform: data-center
- Space: SR4JS
- Hierarchy: Features > Script fields > Built-In Script Fields
- Doc ID: doc-sr4js-cd6ed1d0-5a16-41c1-ae70-1e3a88d3c481-e47871ea9865c2fe
- Source: https://docs.adaptavist.com/sr4js/latest/features#script-fields--en#built-in-script-fields--en#database-picker--en

The _Database Picker_ scripted field displays database records returned by a pre-configured SQL query from a [connected database](https://docs.adaptavist.com/sr4js/latest/features/resources).

## Database picker examples

Examples include:

-   A field to select a customer from your internal customer relationship management database.
-   A field to select the relevant sales contract from a contracts database, for implementation of a new feature.

1.  From ScriptRunner, navigate to Script Fields. The _Script Fields_ page shows all currently configured scripted fields.
    
    Note: Scripted fields can also be created through Admin > Custom Fields however, they cannot be configured there. For simplicity, navigate to the ScriptRunner _Scripted Fields_ page as outlined above.
    
2.  Click Create Script Field > Database Picker.
    
    Warning: Before creating a _Database Picker_ scripted field, you must set up a connection to the target database in the [Resources](https://docs.adaptavist.com/sr4js/latest/features/resources) tab.
    
3.  Enter a Field Name. This is the name of the field created.
4.  Add a Field Description.
5.  Enter a Note for the field (optional).
6.  Select a database connection in the Connection field. Configure database connections under the [Resources](https://docs.adaptavist.com/sr4js/latest/features/resources) tab.
7.  Two SQL queries are required: a search query and a validation query. Both queries require a unique identifier for the database record being used (such as the [primary key](https://www.w3schools.com/sql/sql_primarykey.asp)).
    
    Tip: This identifier should not change. If you are querying a single table, it most likely has a primary key set up. Often, this is called ID and will be an auto-incrementing number.
    
    Warning: The primary key is stored as a string in a `varchar` column in the connected database, allowing ScriptRunner to handle both strings and numbers as keys. However, if the primary key is a number, it must be `cast` from a string to a number in queries.
    
    -   The Retrieval/Validation SQL query validates the input and retrieves a display value when viewing the issue.
    -   The Search SQL query is used to search the typeahead when creating, editing, or searching issues.
        
        Tip: We strongly suggest using the Preview function to check SQL queries.
        
8.  Check the Multiple checkbox for a multi-select field. Leave unchecked for a single-select field.
9.  Enter a Preview Issue Key and click Preview. The preview runs the Retrieval/Validation SQL and Search SQL queries for the issue provided. Use the preview to check for errors in your queries.
10.  After confirming the queries work as expected, click Add.

## Accessing display value

Database picker fields selected values are stored as a unique identifier for the related database entry.

If you want to obtain the display value of a database picker in plain text programmatically, you can use the methods shown in the script below:

```
import com.atlassian.jira.util.velocity.CommonVelocityKeys
import com.atlassian.jira.component.ComponentAccessor

def issue = Issues.getByKey("FOO-1")
def fieldName = "My Db Values Picker"

def customFieldManager = ComponentAccessor.customFieldManager
def fieldLayoutManager = ComponentAccessor.fieldLayoutManager

def dbPicker = customFieldManager.getCustomFieldObjectsByName(fieldName).first()
def fieldLayoutItem = fieldLayoutManager.getFieldLayout(issue).getFieldLayoutItem(dbPicker.id)

def displayParameters = [(CommonVelocityKeys.TEXT_ONLY): true]
def textDisplayValue = dbPicker.getViewHtml(fieldLayoutItem, null, issue, displayParameters as Map)
textDisplayValue?.trim()
```
