# Simple Scripted Condition

- Platform: data-center
- Space: SR4JS
- Hierarchy: features > workflows > conditions
- Doc ID: doc-sr4js-442885569
- Source: https://docs.adaptavist.com/sr4js/latest/features/workflows/conditions/simple-scripted-condition

Use the _Simple scripted condition_ to run a simple embedded script that determines whether an issue should be permitted to transition to a particular status within a workflow. This built-in condition allows you to write a Groovy script that can evaluate a wide range of conditions based on issue fields, workflow states, project properties, user permissions, and other contextual data. 

This built-in condition is particularly useful for teams with unique process requirements that need to enforce specific criteria for issue lifecycle management.

## Use this condition

1.  Go to **Administration > Issues > Workflows.**
2.  Select **Edit** on the workflow you want to add a condition to. 
3.  Select the transition to which you wish to add a condition.
4.  Under **Options**, select **Conditions.  
    **
5.  On the _Transition_ page, select **Add condition**.
6.  Select **Simple scripted condition**.  
    ![](/sr4js/files/latest/442885569/442885574/1/1758746496000/Simple_scripted_logo.png)  
    
7.  Select **Add**.
8.  Optional: Enter a note that describes the condition. This allows you to identify your workflow condition more easily.
9.  Enter a condition of your choice or enter one of the example scripts displayed further down this page:  
    
    If the script returns `true`, the transition is allowed. If it returns `false` the user will not be allowed to perform the transition.
    
    -   [Examine the issue history and separate duties](#id-.SimpleScriptedConditionv9.x-examine-issue-history)
    -   [Check all sub-tasks are assigned to the current user](#id-.SimpleScriptedConditionv9.x-check-subtasks)
    -   [Check all QA sub-tasks are resolved](#id-.SimpleScriptedConditionv9.x-check-qa-subtasks)
    -   [Check all linked issues are resolved](#id-.SimpleScriptedConditionv9.x-check-linked-issues)
    
10.  Optional: Enter an issue key to preview if the result evaluates `true` or `false`. 
11.  Select **Update**.  
     
12.  Select **Publish** and choose if you want to save a backup copy of the workflow.
     
     You can now test to see if this workflow condition works.
     

## Examples

Each of the examples below is based on specific workflows. **Make sure you adjust the examples appropriately to suit your own workflow/s.**

### Examine the issue history and separate duties

Sometimes you want different people from the same group or role to execute different steps of the workflow. For example, you have a bug validation workflow and you do not want the person that _resolved_ an the issue to _validate_ the fix.

You can put the following code as a condition on the _Validate_ transition, which will prevent the user that transitioned the issue to the _Resolved_ status from validation:

```
import com.atlassian.jira.component.ComponentAccessor
 
def changeHistoryManager = ComponentAccessor.getChangeHistoryManager()
def currentUserKey = ComponentAccessor.getJiraAuthenticationContext().getLoggedInUser()?.key
 
// returns true if there are no transitions to the target state by the current user
!changeHistoryManager.getAllChangeItems(issue).find {
    it.field == "status" &&
        currentUserKey == it.userKey &&
        "Resolved" in it.toValues.values()
}
```

### Check all sub-tasks are assigned to the current user

You can use a condition to check that all sub-tasks are assigned to the current user before the parent task can be transitioned:

```
// Retrieve the current logged in user using a different variable name
def loggedInUser = Users.getLoggedInUser()

// Retrieve all sub-tasks of the current issue
def subTasks = issue.getSubTaskObjects()

// Check if all sub-tasks are assigned to the logged in user
def allAssignedToLoggedInUser = subTasks.every { subTask ->
    subTask.assignee?.username == loggedInUser.username
}

// Return true if all sub-tasks are assigned to the logged in user, false otherwise
return allAssignedToLoggedInUser
```

### Check all QA sub-tasks are resolved

This example is described in more detail on the [Conditions Tutorial](https://docs.adaptavist.com/sr4js/latest/features/workflows/workflow-functions-tutorial/conditions-tutorial) page. 

You can use a condition to check that all QA sub-tasks are resolved before the parent issue can be transitioned:

```
def subTasks = issue.getSubTaskObjects()
  
return !subTasks.any {
    it.issueType.name == "QA" && !it.resolution
}
```

### Check all linked issues are resolved

This example is described in more detail on the [Conditions Tutorial](https://docs.adaptavist.com/sr4js/latest/features/workflows/workflow-functions-tutorial/conditions-tutorial) page. 

You can use a condition to check that all linked issues are resolved before the issue can be transitioned:

```
def passesCondition = true
  
// Get all inward links of the issue
def inwardLinks = issue.getInwardLinks()
  
// Check each inward link for the specified link type and resolution status
inwardLinks.each { link ->
    if (link.issueLinkType.name == "Blocks" && !link.sourceObject.resolution) {
        passesCondition = false
    }
}
 
// The variable passesCondition will be false if there's at least one inward link of type "Blocks" with an unresolved source issue
return passesCondition
```

  

* * *

## Related content

-   [Validators Tutorial](https://docs.adaptavist.com/sr4js/latest/features/workflows/workflow-functions-tutorial/conditions-tutorial)
-   [Workflow Functions Tutorial](https://docs.adaptavist.com/sr4js/latest/features/workflows/workflow-functions-tutorial)
-   [Conditions tutorial](https://docs.adaptavist.com/sr4js/latest/features/workflows/workflow-functions-tutorial/conditions-tutorial)
