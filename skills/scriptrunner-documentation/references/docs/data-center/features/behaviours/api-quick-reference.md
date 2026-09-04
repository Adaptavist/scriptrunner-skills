# API Quick Reference

- Platform: data-center
- Space: SR4JS
- Hierarchy: features > behaviours
- Doc ID: doc-sr4js-442888265
- Source: https://docs.adaptavist.com/sr4js/latest/features/behaviours/api-quick-reference

## Getting form fields

### **getFieldById(fieldId)**

Get a FormField object to retrieve the value, set the validity, etc.

```
getFieldById("customfield_11111")
getFieldById("summary")
```

### getFieldByName(fieldName)

This is the same as above example but uses the name. 

Multi-language instances

`getFieldByName` is language-specific API. If you have a multi-language instance, we recommend you use `getFieldById` instead.

```
getFieldByName("My Custom Field")
getFieldByName("Description")
```

### getFieldChanged()

Gets the ID of the field that this script is attached to.

```
getFieldById(getFieldChanged())
```

## Common field operations

### formField.getValue()

Gets the value that is current in the form. For certain fields, this does do some conversions.

-   Select fields, radio buttons, checkboxes, etc. the string value will be returned, or a List of string values.
    
-   Versions or Components fields the Version or Component objects(s) will be returned.
    
-   Linked Issues field (id: "issuelinks-issues") will always return an array, even an empty one.
    

### formField.setError(errorStr)

Marks the field as having an error. The error text is shown below the field. The user cannot submit while there are fields with errors.

```
formField.setError("The user selected is not a component lead")
```

### formField.clearError()

Removes the error status from the field. Make sure that if you set an error, you also clear it for valid values.

### formField.setLabel()

Sets a different "name" for the field. This only affects the visual appearance of the field. It doesn’t alter further calls to getFieldByName

```
formField.setLabel('Why is this high priority?')
```

### formField.setRequired(boolean)

Makes this a required field or not.

```
formField.setRequired(true)
```

### formField.setHidden(boolean)

Hides a field, or shows a hidden field. For example when the user selects Other from a select list, display a text field for them to type the value.

```
formField.setHidden(true)
```

### formField.setReadOnly(boolean)

Makes a field read-only (`true`), or writable (`false`).

```
formField.setReadOnly(true)
```

### formField.setFormValue(value)

Sets the value in the form. Unless you also set this to readonly, a user can modify it subsequently.

```
formField.setFormValue("Documentation subtask")
```

-   For "picker" fields you need to provide the ID of the option.
-   For Assets fields you need to provide object key. See [Work with Assets / Insight](https://docs.adaptavist.com/sr4js/latest/hapi/work-with-assets-insight) for more information on Assets. 
-   For single-selects, radio buttons, multi-selects, checkboxes, project, issuetype, version, components and cascading select fields, you can provide a string matching the option label.

You cannot set a value that could not exist, for instance an option that is not valid for that select list, or a component not valid for the current project. If you do this, we will log a warning in the application log. Hence it's a good idea to keep an on the application log (`atlassian-jira.log` , when developing your behaviours).

Alternatively, you can use the actual [Option](https://docs.atlassian.com/DAC/javadoc/jira/reference/com/atlassian/jira/issue/customfields/option/Option.html) objects, or ProjectComponent, Version, Project, Resolution, which may be more useful if you are copying an existing issue. 

For multi-selects and checkboxes, this should be a list of items, eg `formField.setFormValue(["Yes", "Maybe"])` 

See [setting field defaults](https://docs.adaptavist.com/sr4js/latest/features/behaviours/behaviours-examples/setting-field-defaults) for examples of setting values for other field types.

### formField.setFieldOptions(Iterable)

Sets the possible options for a select or multi select list. The value must be permissible for the field.

```
def customField = customFieldManager.getCustomFieldObject(getFieldChanged())
def config = customField.getRelevantConfig(getIssueContext())
def options = optionsManager.getOptions(config)

formField.setFieldOptions(options.findAll {it.value in ['foo', 'bar']})
```

### formField.setDescription()

Sets the description for a form field.

```
formField.setDescription("Start typing to get a list of possible users")
```

## Information about the current Issue

### getIssueContext()

Getting the current issue type and project. Returns an [com.atlassian.jira.issue.context.IssueContext](https://docs.atlassian.com/software/jira/docs/api/latest/com/atlassian/jira/issue/context/IssueContext.html).

```
def issueTypeName = getIssueContext().issueType.name
def projectKey = getIssueContext().projectObject.name
```

### getRequestTypeName()

Get the RequestType name. If this behaviour is not running in a Service Management portal, this will return `null`.

```
if (getRequestTypeName() == 'IT Help')
```

## Workflow information

### getActionName()

Returns the name of the current action if the issue is undergoing a workflow action, null otherwise.

### getAction()

Returns an ActionDescriptor object if the issue is undergoing a workflow action, null for Edit, Assign, etc.

### getDestinationStepName()

Returns the name of the destination step if the issue is undergoing a workflow action, null otherwise.

### getDestinationStep()

Returns an StepDescriptor object for the destination step if the issue is undergoing a workflow action.

## Operations on tabs

For the following methods you can supply either the position of the tab (the leftmost one is at index **0**), the tab name, or a `FieldScreenTab`.

### hideTab(Integer tabIdx / String name, FieldScreenTab tab)

Hide a tab entirely. Has an optional second parameter: specifying `false` will show the tab.

```
hideTab(1) // hides the second tab
// or
hideTab("Testing Instructions")
// or
def tab = getFieldScreen().tabs.find {it.isContainsField("summary")}
hideTab(tab)
```

### showTab(Integer tabIdx / String name, FieldScreenTab tab)

Shows a tab that was previously hidden by `hideTab`.

```
showTab(1) // shows the second tab

// you can also use
hideTab(1, false)
```

### disableTab(Integer tabIdx / String name, FieldScreenTab tab)

_Disables_ a tab - the user can see that the tab exists but cannot switch to it. This may be less confusing than hiding a tab, depending on your requirements. Has an optional second parameter, specifying `false` will enable the tab.

```
disableTab(1) // disables the second tab
```

### enableTab(Integer tabIdx / String name, FieldScreenTab tab)

Enables a tab that was previously disabled by `disableTab`.

```
enableTab(1) // enables the second tab

// you can also use
disableTab(1, false)
```

### switchTab(Integer tabIdx / String name, FieldScreenTab tab)

Switches to a tab. The primary use case for this is to control which tab is displayed when hiding or disabling a tab. If you don’t use `switchTab` the tab will switch to the left-most unhidden, and enabled tab

```
hideTab(0)    // hides the first tab
switchTab(2)  // switches to the third tab
```

## Other field operations

### formField.setHelpText(helpText)

Deprecated. 

`setHelpText`  sets an error message under the field, in the same way that `setError`  does. However,  `setError` prevents the form from being submitted, until `clearError`  is called on the field. Using `setHelpText`  makes it appear the field is in an error state, but the user is allowed to submit the form.

Because of this ambiguity, `setHelpText`  is deprecated and should not be used.

To set explanatory text, use `setDescription`.  If you wish to show something that looks like an error message (but does not prevent the form being submitted), you can use a CSS class or styles:

```
getFieldById('duedate').setDescription('<div class="error">foo foo</div>')
```

Add help text under a field, in response to other form events. This is useful to explain to users why fields have become mandatory. To unset it use `clearHelpText()` or `setHelpText("")`.

```
formField.setHelpText("You must enter a value for this field if you select priority Blocker")
```

### formField.setAllowInlineEdit(boolean)

Allows you to enable and disable a field so it can/cannot be edited from the issue _View_ screen. This API should only be applied to an initialiser script. Any field with a _Behaviour_ configured will have the inline edit disabled by default, which forces the user to click the pencil icon to open the edit modal form.

If you allow the inline edit of a field with a _Behaviour_ configured then a user will be able to alter the field's value on the issue _View_ screen without any of your _Behaviour_ restrictions.

**`formField.setAllowInlineEdit(true``)`**

You can use `setAllowInlineEdit(true)` to enable the inline editing of a field from the issue _View_ screen. You can use this method to override the default behaviour of a field and allow inline editing of any field that has a _Behaviour_ configured to it. 

**`formField.setAllowInlineEdit(false)`**

You can use `setAllowInlineEdit(false)` to disable the inline editing of a field from the issue _View_ screen. You will rarely use this independently, as this is the default mode for a form field with a _Behaviour_ configured to it. However, you may want to use this to disable inline editing of a field conditionally after using the above method to enable it. For example, you only want to allow inline editing for a given issue type out of several issue types that your _Behaviour_ applies to.

This method only controls the field on the issue _View_ screen. To prevent a field being edited within the create, edit or transition screens use the `[setReadOnly](#id-.APIQuickReferencev9.x-setreadonly)` method.

## Miscellaneous

### getRequest()

Gets the [servlet request](https://docs.oracle.com/javaee/7/api/javax/servlet/http/HttpServletRequest.html) that corresponds with this request for an initialiser, or a field-changed validator.

You might use this to get the IP address of the client, or headers that would let you determine the end-user’s browser.

### getResponse()

Gets the [servlet response](https://docs.oracle.com/javaee/7/api/javax/servlet/http/HttpServletResponse.html). There is probably no cause to use this.

### setConfigParam()

Sets a specific configuration parameter.
