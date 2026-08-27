# Update Fields

- Platform: cloud
- Space: SR4JC
- Hierarchy: hapi
- Doc ID: doc-sr4jc-288524084
- Source: https://docs.adaptavist.com/sr4jc/latest/hapi/update-fields

Updating custom fields is a very common task. There are three ways to specify custom field values:

1.  Use textual names for fields to provide readable and simple code. For example, for a select list, you specify the option value.
2.  Use object IDs if you feel concerned about names changing. For instance, in a select list, you can use an option ID.
3.  Use the underlying objects (`[Option](https://docs.atlassian.com/software/jira/docs/api/9.6.0/com/atlassian/jira/issue/customfields/option/Option.html?_ga=2.190126891.1616100431.1676882043-2029362582.1658496808)`, `[Version](https://docs.atlassian.com/software/jira/docs/api/9.6.0/com/atlassian/jira/project/version/Version.html?_ga=2.190126891.1616100431.1676882043-2029362582.1658496808)`). This is useful when copying values from one work item to another.

We also cater for common automation tasks, such as setting an additional fix version or multi-select value without retrieving the current value, adding the new one, and then setting the new list of values.

Custom fields can be set by numeric ID or name. The numeric ID of a custom field is just the number portion of its ID. For example, if the String ID is `customfield_12345`, the numeric ID is `12345`. Use the custom field name for readable and portable scripts. To read the value of a custom field, see the [Reading Custom Field Values](#id-.UpdateFieldsvCurrent-readvalue) section below. 

Using the ID

We recommend that you use the ID if you plan to rename your custom fields or have multiple fields of the same name. 

## Read the value of custom fields

You can use the HAPI shortcut to get the custom field.

```
// by custom field name
workItem.getCustomFieldValue('My text field')
            
// or by custom field ID
workItem.getCustomFieldValue(10146)
```

Using this shortcut means you don't have to use [CustomFieldManager](https://docs.atlassian.com/software/jira/docs/api/latest/com/atlassian/jira/issue/CustomFieldManager.html) to look up the custom field instance first.

![](/sr4jc/files/latest/288524084/322830783/2/1774350450000/Read+the+value+of+custom+fields.png)

#### Caching

It's important to note that a work item's fields are cached when the WorkItem object is first retrieved. Therefore, if you retrieve a custom field value and then update the field, whatever the value was before you updated the field is returned. To ensure the updated value is returned, you can use `refresh()`.

For example, the following logs out null rather than the updated value:

```
def workItem = WorkItems.getByKey('JRA-1')

logger.warn(workItem.getCustomFieldValue('Select List').toString())

workItem.update {
	setCustomFieldValue('Select List', 'First Option')
}

logger.warn(workItem.getCustomFieldValue('Select List').toString()
```

If we add `refresh()` to the `WorkItem` object it returns the expected result of `First Option`:

```
logger.warn(workItem.refresh().getCustomFieldValue('Select List').toString())
```

## Update text fields

In this example, we're using custom field values to add a text field to the work item. Text fields can be set using the following:

```
workItem.update {
	setCustomFieldValue('My text field', 'foo')
}

//or

workItem.update {
	setCustomFieldValue(10104, 'foo')
}
```

![](/sr4jc/files/latest/288524084/322830784/2/1774350582000/Update+text+fields.png)

### Bulk update text fields

In this example, you are working on a product, and you changed its name in the early stages of development. Now you wish to edit the name in the **description** of all work items. You can use a JQL query to bulk update fields, as shown below:

```
WorkItems.search('project = KAN and description ~ hello').each { workItem ->
    workItem.update {
        setDescription('goodbye')
    }
}
```

![](/sr4jc/files/latest/288524084/322830786/2/1774350665000/Bulk+update+text+fields.png)

## Update date and date time fields

In this example, we're setting the due date. Date system fields, such as _due date_ and _Date Picker_ custom fields, can be set as follows:

```
import java.time.LocalDate

def workItemOne = WorkItems.getByKey('JRA-1')
def workItemTwo = WorkItems.getByKey('JRA-2')

workItemOne.update {
	setDueDate('2024-11-27')
    
	// additionally you can use a LocalDate, e.g. for copying from another work item
    setDueDate(workItemTwo.getDueDate().toLocalDate())
            
    // or use a LocalDate object, for instance to set the date to 7 days from now 
    setDueDate(LocalDate.now().plusDays(7))
}
```

![](/sr4jc/files/latest/288524084/524224161/1/1774284618000/image-2026-3-23_17-50-17.png)

### Set a single value

In this example, we're setting a single radio button field. To set a single value (radio buttons and single-select custom fields):

```
workItem.update {
	setCustomFieldValue('My radio buttons', 'Yes')
}
```

![](/sr4jc/files/latest/288524084/322830788/2/1774350746000/Set+a+single+value.png)

### Set multiple values

In this example, we're setting multiple checkbox fields. You can set multiple values as follows:

```
                workItem.update {
                    setCustomFieldValue('My checkboxes', 'Yes', 'Maybe')
                }
```

You can also use the [Groovy spread operator](https://grooovygeorge.wordpress.com/2012/02/03/the-groovy-spread-operator-asterisk/) to list multiple values. The spread operator (\*) allows you to pass elements of a collection as individual arguments to a method. This is particularly useful when you have a list of values. For example:

```
def workItem = WorkItems.getByKey('JRA-1')
def list = ['Yes', 'Maybe']

workItem.update {
    setCustomFieldValue('My checkboxes', *list)
}
```

### ![](/sr4jc/files/latest/288524084/322830789/2/1774350836000/Set+multiple+values.png)

### Add to an existing selected option

In this example, we're adding an extra checkbox value and a fix version. You can add an existing selected option using `add()`. This is also valid in other fields that are a "collection" of objects; for example, **affects/fix versions** and **components**:

```
workItem.update {
	setCustomFieldValue('My checkboxes') {
    	add('Maybe')
	}
            
    setFixVersions {
    	add('v2.0')
	}
}
```

### Remove a selected value

In this example, we're removing the `No` checkbox value. You can remove a selected value if it is present:

```
workItem.update {
    setCustomFieldValue('My checkboxes') {
        remove('No')        
    }
}
```

### ![](/sr4jc/files/latest/288524084/322830781/2/1774350934000/Remove+a+selected+value.png)

### Set values by option name

In this example, we're setting the checkbox 'Yes' and 'Maybe' values by their name. The `add`, `remove`, and `replace` methods have overloads that let you set the "object" rather than the textual name. For example, Version, Option, or the object's name.

To set by option name:

```
workItem.update {
	setCustomFieldValue('My checkboxes') {
    	set('Yes', 'No')
    }            
}
```

![](/sr4jc/files/latest/288524084/524224148/1/1774351010000/set+value+by+option+name.png)

## Clear the value of a custom field on a work item

The `clearCustomField` HAPI function allows you to clear the value of a custom field on a work item. It supports both numerical custom field IDs (`Long`) and field names (`String`) making it flexible for scenarios where the identifier may vary.

To clear the custom field name:

```
WorkItems.getByKey("JRA-1").update {
    clearCustomField("Custom Field Name")
}
```

To clear the custom field ID:

```
WorkItems.getByKey("JRA-1").update {
    clearCustomField(12345L)
}
```

## Skip screen validation on the field set

You can use `setSkipScreenCheck` to ensure the screen check is skipped when setting a field. Use true to allow setting fields not present on the screen, false to enforce screen presence. For example:

```
WorkItems.getByKey("JRA-1").update{
  setSkipScreenCheck(true)     
  setCustomFieldValue(12345, "Value to update") 
}
```

![](/sr4jc/files/latest/288524084/524224147/1/1774351090000/skip+screen+validation+on+the+field+set.png)

  

* * *

## Related Content

-   [Javadocs Groovy Class](https://docs.adaptavist.com/api/javadoc/cloud/scriptrunner/latest/hapi/jira/groovydoc/com/adaptavist/hapi/cloud/jira/issues/IssueImpl.html)
-   [Javadocs methods](https://docs.adaptavist.com/api/javadoc/cloud/scriptrunner/latest/hapi/jira/groovydoc/com/adaptavist/hapi/cloud/jira/issues/delegates/AbstractIssuesDelegate.html#setCustomFieldValue\(java.lang.String,%20java.lang.String\))
