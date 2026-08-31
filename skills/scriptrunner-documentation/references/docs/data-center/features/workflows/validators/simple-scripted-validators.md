# Simple Scripted Validators

- Platform: data-center
- Space: SR4JS
- Hierarchy: features > workflows > validators
- Doc ID: doc-sr4js-442885726
- Source: https://docs.adaptavist.com/sr4js/latest/features/workflows/validators/simple-scripted-validators

Use the _Simple scripted validator_ to run a simple embedded script that determines whether an issue should be permitted to transition to a particular status within a workflow. This validator allows you to write a Groovy script that can evaluate a wide range of conditions based on issue fields, workflow states, project properties, user permissions, and other contextual data. If validation fails, you can provide a custom error message that explains why the transition is not allowed. 

This validator is particularly useful for teams with unique process requirements that need to enforce specific criteria for issue lifecycle management.

## Use this validator

1.  Go to **Administration > Issues > Workflows.**
2.  Select **Edit** on the workflow you want to add this validator to. 
3.  Select the transition you want to add this validator to.
4.  Under **Options**, select **Validators.  
    **
5.  On the _Transition_ page, select **Add validator**.
6.  Select **Simple scripted validator**.  
    ![Image of the validator selected](/sr4js/files/latest/442885726/442885761/1/1758746511000/Simple_scripted_v_logo.png)  
    
7.  Select **Add**.
8.  Optional: Enter a note that describes the validator. This allows you to identify your workflow validator more easily.
    
9.  Enter a condition of your choice or enter one of the [example scripts](http://docs.adaptavist.com#examples) displayed further down this page.
    
    If the script returns `true`, the transition is allowed. If it returns `false`, the user will not be allowed to perform the transition, and an error message will appear.
    
10.  Enter an error message. This message displays to the user if the condition returns as `false`. 
     
11.  Optional: Select the field you want the error message to display against. Leave this option empty if you want the error to display at the top of a transition screen or as a pop-up.
     
     If the transition you are adding this validator to has a [screen](https://confluence.atlassian.com/adminjiraserver0820/defining-a-screen-1095777068.html) applied to it, make sure the field you select is on the transition screen.
     
12.  Select **Update**.  
     
13.  Select **Publish** and choose if you want to save a backup copy of the workflow.
     
     You can now test to see if this workflow condition works.
     

## Examples

Each of the examples below is based on specific workflows. **Make sure you adjust the examples appropriately to suit your workflow/s.**

-   [Require a fix version if the resolution value is fixed](#id-.SimpleScriptedValidatorsv9.x-require-fix)
-   [Check the resolution value](#id-.SimpleScriptedValidatorsv9.x-check-resolution)
-   [Require a comment](#id-.SimpleScriptedValidatorsv9.x-require)
-   [Require a comment when the assignee is changed](#id-.SimpleScriptedValidatorsv9.x-require-comment-assignee)
-   [Make sure an option is selected for a custom field](#id-.SimpleScriptedValidatorsv9.x-select-option)
-   [Make sure no other sub-tasks have the same value for a custom field on issue creation](#id-.SimpleScriptedValidatorsv9.x-check-subtasks)
-   [Check for attachments](#id-.SimpleScriptedValidatorsv9.x-check-attachments)
-   [Check the status or properties of sub-tasks](#id-.SimpleScriptedValidatorsv9.x-check-subtasks-2)
    
-   [Check linked issues](#id-.SimpleScriptedValidatorsv9.x-check-linked-issues)
-   [Check the values of a cascading select field](#id-.SimpleScriptedValidatorsv9.x-cascading-select)

### Require a fix version if the resolution value is fixed

You can use the following script to make sure that when a user sets the resolution to _Fixed_, they also have to add the correct **Fix Version:  
**

Make sure the transition includes a _Resolve Issue_ screen (or similar) that includes both the _Resolution_ and _Fix version_.  A step-by-step walkthrough of this example is available on the [Validators Tutorial](https://docs.adaptavist.com/sr4js/latest/features/workflows/workflow-functions-tutorial/validators-tutorial) page. 

```
issue.resolution.name != "Fixed" || issue.fixVersions
```

The above example could be set up as follows:

![Image showing the completed validator](/sr4js/files/latest/442885726/442885742/1/1758746509000/Fix_version_4.png)

When a fix version is not provided, the error appears as follows:

![Image showing the error message displaying](/sr4js/files/latest/442885726/442885740/1/1758746509000/Fix_version_6.png)

### Check the resolution value

You can use the following script to validate that a particular resolution value is chosen:

```
issue.resolution?.name == 'Not an Issue'
```

 You might want to combine this validator with a [check on the action name](https://docs.adaptavist.com/sr4js/latest/features/workflows/post-functions/custom-post-functions#check-action-name).

The above example could be set up as follows:

![](/sr4js/files/latest/442885726/442885752/1/1758746510000/Check_resolution_value.png)

When a fix version is not provided, the error appears as follows:

![](/sr4js/files/latest/442885726/442885753/1/1758746510000/Check_resolution_value_2.png)

### Require a comment

You can use the following script to make sure a comment is added when the resolution of _Won’t Fix_ is selected:

Make sure the transition includes a _Resolve Issue_ screen (or similar) that includes the _Resolution_. Comments are automatically included in transition screens. 

```
issue.resolution?.name != "Won't Fix" || transientVars["comment"]
```

The above example could be set up as follows:

![](/sr4js/files/latest/442885726/442885730/1/1758746508000/Require_comment_validator.png)

When _Won't fix_ is selected, and a comment isn't provided, the error appears as follows:

![](/sr4js/files/latest/442885726/442885754/1/1758746510000/Require_comment_validator_3.png)

### Require a comment when the assignee is changed

You can check for changed fields by calling methods on `originalIssue`. This is the issue as it was before modifications made (during this transition) were applied.

You can use the following script to make sure a comment is added when the assignee is changed during a transition:

Make sure the transition includes a screen that includes the _Assignee_ field. Comments are automatically included in transition screens. 

```
originalIssue.assigneeId == issue.assigneeId || transientVars["comment"]
```

The above example could be set up as follows:

![](/sr4js/files/latest/442885726/442885743/1/1758746509000/Assignee_validator_change.png)

When the assignee is changed and a comment isn't provided, the error appears as follows:

![](/sr4js/files/latest/442885726/442885757/1/1758746511000/Assignee_validator_change_2.png)

### Make sure an option is selected for a custom field

For the following examples, make sure the transition you're applying the validator to includes a screen with the appropriate fields. 

-   Multiselect values are a collection of [`Option`](https://docs.atlassian.com/DAC/javadoc/jira/reference/com/atlassian/jira/issue/customfields/option/Option.html) objects.
-   `cfValues` is a map-like structure where you can get the value of any custom field on the object. Note that the keys are the field _name_ and not the _id_.

You can use the following script to make sure a certain option is selected from a multi-select custom field:

```
def values = cfValues['My Multi Select']
return values && (values*.value as Collection<String>).contains('A field value')
```

You can use the following script to make sure an option is selected for a single-select or radio button field:

```
cfValues['My Single Select']?.value == "A field value"
```

You can use the following script as a more complex example, where if the user sets the select-list field _Demo_ to _No_, you require them to fill in a text field _Reason for no demo_:

```
cfValues['Demo']?.value != 'No' || cfValues['Reason for No Demo']
```

You can use the following script to make sure a custom field has a value:

If this condition returns `null` or an empty value, it will be evaluated as `false` and your chosen error will display.

```
cfValues['Custom Field Name']
```

### Make sure no other sub-tasks have the same value for a custom field on issue creation

You can use the following script to make sure, on the creation of a sub-task, that none of the other sub-tasks of the parent issue have the same value for a particular custom field:

```
if (!issue.isSubTask()) {
    return true
}

def parent = issue.parentObject
def selectedValue = issue.getCustomFieldValue('SelectListA')

!parent.subTaskObjects.any { subtask ->
    subtask.getCustomFieldValue('SelectListA') == selectedValue
}
```

The above example could be set up as follows:

![](/sr4js/files/latest/442885726/442885745/1/1758746509000/Subtask_example_1.png)

When the option selected is the same as another sub-task for the parent issue, the error appears as follows:

![](/sr4js/files/latest/442885726/442885744/1/1758746509000/Subtask_example_2.png)

You can put any amount of code in the _Condition_ field. If you don’t explicitly include a `return`, the result of the last statement executed defines whether the validator accepts or rejects the transition.

### Check for attachments

You can use the following script to check that at least one PDF file is attached:

```
issue.getAttachments().find { it.filename.endsWith(".pdf") }
```

The attachment must have existed before the transition was applied to the issue. If you have the _Attachments_ field on the screen, you cannot get newly added attachments in this way.

If your workflow requires specific attachments at certain stages, your validator can either:

-   tell the user to cancel, add the attachment, and try again (or remove the Attachments field from the screen)
    
-   use a [different method to get newly added attachments](https://docs.adaptavist.com/sr4js/latest/features/workflows/validators/validating-attachments-links-in-transitions).
    

The above example could be set up as follows:

![](/sr4js/files/latest/442885726/442885747/1/1758746509000/Attachments_1.png)

When the transition is attempted without a PDF attachment associated with an issue, the error appears as follows:

![](/sr4js/files/latest/442885726/442885755/1/1758746510000/Attachments_error.png)

### Check the status or properties of sub-tasks

The following script examples can be used to check the status or properties of sub-tasks relative to their parent issue during a transition.

#### Make sure all subtasks are resolved

You can use the following script to make sure that all subtasks of an issue are resolved:

```
issue.subTaskObjects.every { it.resolution }
```

#### Make sure at least one subtask is resolved

You can use the following script to make sure there is at least one subtask is resolved:

```
!issue.subTaskObjects || issue.subTaskObjects.any { it.resolution }
```

#### Make sure the issue has at least one subtask which is _In Progress_

You can use the following script to make sure the issue has at least one subtask which is _In Progress_:

```
issue.subTaskObjects.any { it.status.name == "In Progress" }
```

To check custom field values of subtasks, `cfValues` is not available, so you must use custom field manager to get hold of the custom field object, as shown in [Make sure no other sub-tasks have the same value for a custom field on issue creation](#id-.SimpleScriptedValidatorsv9.x-check-subtasks).

#### Check properties of the parent issue

For subtasks, you can check properties of the parent by using `parentObject`.

You can use the following script to make sure the parent is _In Progress_:

```
!issue.isSubTask() || issue.parentObject.status.name == "In Progress"
```

The first clause is unnecessary if you are applying this validator only to a subtask type(s). However, if you apply the validator to all tasks, the first clause is there to prevent a `NullPointerException` if the script is run on an issue that is not a sub-task, as standard issues do not have a `parentObject`.

### Check linked issues

You can use `issueLinkManager` to retrieve all outward links. For example, you could use the following to check that the issue has at least one outward _Duplicate_ link:

```
issueLinkManager.getOutwardLinks(issue.id)*.issueLinkType.name.contains('Duplicate')
```

You could expand on this example and use it practically. For example, you can use the following script to make sure an issue has at least one outward _Duplicate_ link when the resolution is set to _Duplicate_:

For the following examples, make sure the transition you're applying the validator to includes a screen with the _Resolution_ field included. 

```
issue.resolution.name != "Duplicate" ||
    issueLinkManager.getOutwardLinks(issue.id)*.issueLinkType.name.contains('Duplicate')
```

The above example could be set up as follows:

![](/sr4js/files/latest/442885726/442885749/1/1758746510000/Linked_issues_1.png)

When the transition is resolved as _Duplicate_ and a duplicate issue is not linked, the error appears as follows:

![](/sr4js/files/latest/442885726/442885746/1/1758746509000/Linked_issues_2.png)

If you have the _Issue Links_ field on a form and want to validate links that occur during this transition, check out the examples on the [Validating Attachments/Links in Transitions](https://docs.adaptavist.com/sr4js/latest/features/workflows/validators/validating-attachments-links-in-transitions) page.

### Check the values of a cascading select field

A cascading select field allows users to select a value from a parent drop-down and a related value from a child drop-down. In the following example scripts, `cfValues` is a map-like structure that holds the current values of custom fields.

You can use the following script to check that both drop-downs of a cascading select are filled:

```
cfValues["CascadingSelect"]?.keySet()?.size() == 2
```

You can use the following script to check that the first dropdown of a cascading select is _AAA_ and the second is _a1_:

```
import com.atlassian.jira.issue.customfields.option.LazyLoadedOption

cfValues['CascadingSelect'].values().collect { (it as LazyLoadedOption).value } == ['AAA', 'A1']
```

You can use the following script to check the first option of the cascading select is _AAA_:

```
cfValues["CascadingSelect"]?.get(null)?.value == "AAA"
```

You can use the following script to check the second option of the cascading select is _a1_:

```
cfValues["CascadingSelect"]?.get("1")?.value == "A1"
```

The first example above could be set up as follows:

![](/sr4js/files/latest/442885726/442885750/1/1758746510000/Cascading_select_1.png)

When the transition is attempted and the cascading select does not have both drop-down options filled, the error appears as follows:

![](/sr4js/files/latest/442885726/442885741/1/1758746509000/Cascading_select_2.png)

* * *

## Related content

-   [Validators Tutorial](https://docs.adaptavist.com/sr4js/latest/features/workflows/workflow-functions-tutorial/conditions-tutorial)
-   [Workflow Functions Tutorial](https://docs.adaptavist.com/sr4js/latest/features/workflows/workflow-functions-tutorial)
-   [Conditions tutorial](https://docs.adaptavist.com/sr4js/latest/features/workflows/workflow-functions-tutorial/conditions-tutorial)
