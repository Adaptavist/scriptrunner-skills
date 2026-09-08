# Update Fields

- Platform: data-center
- Space: SR4JS
- Hierarchy: hapi
- Doc ID: doc-sr4js-442885046
- Source: https://docs.adaptavist.com/sr4js/latest/hapi/update-fields

![](/sr4js/files/latest/442885046/441364729/1/1750778288000/sr-icon-cloud.png)

**Migrating to Jira Cloud? This feature is available in Cloud. Check out our** **[HAPI Cloud documentation](https://docs.adaptavist.com/sr4jc/latest/hapi/update-fields)** **for more details.** 

Updating custom fields is a very common task. There are three ways to specify custom field values:

1.  Use textual names for fields, for readable and simple code. For example, for a select list you specify the option value.
2.  Use object IDs if you feel concerned about names changing. For instance, in a select list you can use an option ID.
3.  Use the underlying objects (`[Option](https://docs.atlassian.com/software/jira/docs/api/9.6.0/com/atlassian/jira/issue/customfields/option/Option.html?_ga=2.190126891.1616100431.1676882043-2029362582.1658496808)`, `[Version](https://docs.atlassian.com/software/jira/docs/api/9.6.0/com/atlassian/jira/project/version/Version.html?_ga=2.190126891.1616100431.1676882043-2029362582.1658496808)`) - this is useful when copying values from one issue to another.

We also cater for common automation tasks, such as setting an additional fix version or multi-select value without retrieving the current value, adding the new one, and then setting the new list of values.

In addition to the examples provided on this page, check out our [Example script](https://www.scriptrunnerhq.com/help/example-scripts/basics-updating-customfields-onPrem) on updating the value of custom fields.

## Custom fields

Custom fields can be set by numeric ID or name. The numeric ID of a custom field is just the number portion of its ID. For example, if the String ID is `customfield_12345`, the numeric ID is `12345`. Use the custom field name for readable and portable scripts. To read the value of a custom field, see the [Reading Custom Field Values](#id-.UpdateFieldsv9.x-customfields) section below. 

Using the ID

We recommend that you use the ID if you like to rename your custom fields or have multiple fields of the same name. 

Check out our video on [how to use custom fields with HAPI](https://www.youtube.com/watch?v=ImfRP2gAzGs). 

## Reading the value of custom fields

You can use the HAPI shortcut to get custom field values:

```
            // by custom field name
            issue.getCustomFieldValue('My text field')
            
            // or by custom field ID
            issue.getCustomFieldValue(10146)
```

Using this shortcut means you don't have to use [CustomFieldManager](https://docs.atlassian.com/software/jira/docs/api/latest/com/atlassian/jira/issue/CustomFieldManager.html) to look up the custom field instance first.

![Reading the value of custom fields with HAPI](/sr4js/files/latest/442885046/442885050/1/1758746445000/Update_fields_reading_custom_values.png)

### Caching

It's important to note that an issue's fields are cached when the `I``ssue` object is first retrieved. Therefore, if you retrieve a custom field value and then update the field, whatever the value was before you updated the field is returned. To ensure the updated value is returned you can use `refresh()`.

For example, the following logs out null rather than the updated value:

```
def issue = Issues.getByKey('JRA-1')

log.warn(issue.getCustomFieldValue('Select List'))

issue.update {
	setCustomFieldValue('Select List', 'First Option')
}

log.warn(issue.getCustomFieldValue('Select List'))
```

If we add `refresh()` to the `Issue` object it returns the expected result of `First Option`:

```
log.warn(issue.refresh().getCustomFieldValue('Select List (multiple choices) example'))
```

## Updating text fields

Text fields can be set using the following:

In this example we're using custom field values to add a text field to the issue.

```
            issue.update {
                setCustomFieldValue('My text field', 'foo')
            
                // or 
                setCustomFieldValue(10104, 'foo')
            }
```

![Image showing how you update text fields using HAPI](/sr4js/files/latest/442885046/442885049/1/1758746445000/Update_fields_text_fields.png)

A second option allows for greater flexibility when updating a field. Supply a closure with instructions on exactly how to update the field. You can use one or many of these instructions within the closure. In this example we're using methods to update various parts of the issue description:

```
            issue.update {
                setDescription {
                    set('Greenhopper is a tool for Agile software development')
            
                    // add to the existing value
                    append('this will be added to the end')
            
                    // prepend to the existing value
                    prepend('this will be added to the beginning')
            
                    // replace all instances of the first string with the second
                    replace('Greenhopper', 'Jira Software')
                }
            }
```

This option can be used on all _string_ fields. For example **description**,  **environment**,  **summary**, short and long text custom fields, etc.

### Bulk updating text fields

You can use a JQL query to bulk update fields, as shown below:

In this example you are working on a product, and you changed its name in the early stages of development. Now you wish to edit the name in the **description** of all issues.

```
            Issues.search('project = ABC and description ~ Marathon').each { issue ->
                issue.update {
                    setDescription {
                        replace('Marathon', 'Snickers')
                    }
                }
            }
```

![Image showing how you bulk update fields with HAPI](/sr4js/files/latest/442885046/442885048/1/1758746445000/Update_fields_update_text_fields.png)

Check out [Search for issues](https://docs.adaptavist.com/sr4js/latest/hapi/search-for-issues) for more information on searching for issues and running JQL queries. 

## Update date and date time fields

Date system fields, such as _due date_ and _Date Picker_ custom fields, can be set as follows:

In this example we're setting the due date.

```
            issue.update {
                setDueDate('21/Nov/2022')
            
                // additionally you can use a Timestamp, e.g. for copying from another issue
                setDueDate {
                    set(otherIssue.dueDate)
                }
            
                // or use a LocalDate object, for instance to set the date to 7 days from now 
                setDueDate {
                    set(LocalDate.now().plusDays(7))
                }
            }
```

![Image showing how you update the date and time using HAPI](/sr4js/files/latest/442885046/442885047/1/1758746445000/Update_fields_update_due_date.png)

The actual date format depends on your server locale. Find the expected format by running this script in the console:

```
            import com.atlassian.jira.component.ComponentAccessor
            import com.atlassian.jira.util.DateFieldFormat
            
            ComponentAccessor.getComponent(DateFieldFormat).getFormatHint()
```

### Adjusting existing dates

You can easily adjust existing dates by utilizing the setter that takes a closure. Calling `get()` returns the current set time or date time if one is set or _now_ if none is set. This is returned as a `LocalDateTime` or `LocalDate`. You can adjust the existing date as follows:

In this example we're adding 7 days to the existing due date. If the current due date is empty, the current date will be used as the one to add 7 days to.

```
            issue.update {
                setDueDate {
                    set(get().plusDays(7))
                }
            }
```

_Date Time Picker_ custom fields are almost the same, except they have overloads taking a [LocalDateTime](https://docs.oracle.com/javase/8/docs/api/java/time/LocalDateTime.html) rather than a `LocalDate`.

## Updating options, versions, and component fields

There are several types of fields that work with [`Option`](https://docs.atlassian.com/software/jira/docs/api/latest/com/atlassian/jira/issue/customfields/option/Option.html), including single and multi-select fields, radio buttons, and checkboxes.

Working with post-functions

When updating fields in a post-function you need to use `set {...}`  instead of `update {...}`. Read more about why on the [Update Issues](https://docs.adaptavist.com/sr4js/latest/hapi/update-issues#transitions) page. 

### Setting a single value

To set a single value (radio-buttons, and single-select custom fields):

In this example we're setting a single radio button field.

```
                issue.update {
                    setCustomFieldValue('My radio buttons', 'Yes')
                }
```

![Image showing how to set a single field value with HAPI](/sr4js/files/latest/442885046/442885053/1/1758746445000/Update_fields_set_single_value.png)

### Setting multiple values

You can set multiple values as follows:

In this example we're setting multiple checkbox fields.

```
                issue.update {
                    setCustomFieldValue('My checkboxes', 'Yes', 'Maybe')
                }
```

You can also use the [Groovy spread operator](https://grooovygeorge.wordpress.com/2012/02/03/the-groovy-spread-operator-asterisk/) to list multiple values. The spread operator (\*) allows you to pass elements of a collection as individual arguments to a method. This is particularly useful when you have a list of values. For example:

```
def issue = Issues.getByKey('JRA-1')
def list = ['Yes', 'Maybe']

issue.update {
    setCustomFieldValue('My checkboxes', *list)
}
```

The groovy spread operator also works for [Assets](https://docs.adaptavist.com/sr4js/latest/hapi/work-with-assets-insight). 

### Adding to an existing selected option

You can add an existing selected option using `add()`. This is also valid on other fields that are a "collection" of object; for example **affects/fix versions** and **components**:

In this example we're adding an additional checkbox value and adding a fix version.

```
            issue.update {
                setCustomFieldValue('My checkboxes') {
                    add('Maybe')
                }
            
                setFixVersions {
                    add('v2.0')
                }
            }
```

![Image showing how you add to an existing selected option using HAPI](/sr4js/files/latest/442885046/442885052/1/1758746445000/Update_fields_add_to_existing_option.png)

### Removing a selected value

Similarly, you can remove a selected value if it is present or replace one with another:

In this example we're removing the `No` checkbox value and replacing the `Maybe` value with `Yes`.

```
            issue.update {
                setCustomFieldValue('My checkboxes') {
                    remove('No')
            
                    replace('Maybe', 'Yes')
                }
            }
```

### Setting values by option ID

The `add`, `remove`, and `replace` methods have overloads which let you set the "object" rather than the textual name. For example Version, Option, or the object's ID.

To set by option ID:

In this example we're setting the checkbox 'Yes' and 'Maybe' values by their ID.

```
            issue.update {
                setCustomFieldValue('My checkboxes') {
                    set(10012L, 10014L)
                }
            }
```

## Setting user fields

User fields have similar methods as above. The assignee field has a couple of special methods:

In this example we're unassigning someone from an issue, or we're automatically assigning someone to the issue.

```
            issue.update {
                setAssignee {
                    // this is the same as setAssignee(null), but the following line is more expressive
                    unassigned()
            
                    // set "automatic" assignee - again, more expressive than setAssignee('-1')
                    automatic()
                }
            }
```

![Image setting user fields using HAPI](/sr4js/files/latest/442885046/442885051/1/1758746445000/Update_fields_set_user_field.png)

  

* * *

## Related content

-   [Javadocs link](https://docs.adaptavist.com/api/javadoc/dc/scriptrunner/8.10.0/hapi/jira/groovydoc/com/adaptavist/hapi/jira/issues/delegate/IssueUpdateDelegate.html)
-   [Update Issues](https://docs.adaptavist.com/sr4js/latest/hapi/update-issues)
-   [Transition Issues](https://docs.adaptavist.com/sr4js/latest/hapi/transition-issues)
