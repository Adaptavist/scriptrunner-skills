# Custom Post Functions

- Platform: data-center
- Space: SR4JS
- Hierarchy: features > workflows > post-functions
- Doc ID: doc-sr4js-549617737
- Source: https://docs.adaptavist.com/sr4js/latest/features/workflows/post-functions/custom-post-functions

Use the _Custom script post-function_ to run a custom script after the transition has been validated. This is where you can pass on a message to a downstream system, send custom notifications, modify the issue, and more.

Most of our built-in post functions can be customized with code. If you can use one of our [available ScriptRunner workflow post functions](https://docs.adaptavist.com/sr4js/latest/features/workflows/workflow-functions-tutorial#post-functions) over the _Custom script post-function_, you should.

If you need help writing your script, check out the [Scripting tips](https://docs.adaptavist.com/sr4js/latest/best-practices/write-code/scripting-tips) page.

## Recommendations for writing a custom post function

Post functions are executed after a transition has been completed. They are meant for performing actions on the transitioned issue or related tasks that don't require user interaction. For example, you can use a custom post function to update the transitioned issue, create or update related issues, and send notifications or emails. However, there are limitations to custom post functions, some of which can impact performance. We therefore recommend the following:

-   **Keep it simple**: Avoid complex operations that could delay the transition or require user input. If complex searches or operations are required, use a [scheduled job](https://docs.adaptavist.com/sr4js/latest/features/jobs) or a [listener](https://docs.adaptavist.com/sr4js/latest/features/listeners) instead of a post function.
    
-   **Optimize searches**: If a search is necessary, narrow down the search criteria as much as possible to minimize performance impact.
    
-   **Avoid loops with `Issues.search()`**: Instead of using `Issues.search()` in loops, perform the search once and store the results for further processing.
    
-   **Use efficient retrieval methods**: Consider alternative methods to retrieve related issues, such as direct ID lookups or JQL queries with specific issue keys.
    
-   **Use bulk operations**: For tasks involving multiple issues, use bulk operations or batching to improve performance (refer to our [Built-In Scripts](https://docs.adaptavist.com/sr4js/latest/features/built-in-scripts) for examples).
    
-   **Test thoroughly**: Always test scripts in a non-production environment to ensure they behave as expected and don't negatively impact system performance.
    
-   **Use logging**: Implement appropriate logging to aid in debugging and understanding script behavior, but be mindful of excessive logging that could impact performance.
    
-   **Monitor and optimize**: Regularly review and optimize your custom post functions to ensure they continue to perform efficiently as your Jira instance grows.
    
-   **Avoid calling `issue.transition()` on the current issue inside a post-function:** Doing so may cause the current status to not update correctly. See our [Transition issues](https://docs.adaptavist.com/sr4js/latest/hapi/transition-issues#known-limitation-when-transitioning-from-a-post-function) page for more details. 

## Post function order

**The order of post functions in a Jira workflow transition is important** and should follow the logical sequence of operations that need to occur during a transition. Any updates to the issue should be made before the issue is saved and reindexed, and any additional transitions should happen after the main transition events have been fired and processed.

**Update description example**

If you have a post function that changes the description of the issue, for example `issue.setDescription("A new description")`, it should be placed **before** the _Update change history for an issue and store the issue in the database_ step. If you place the function after the issue has been saved, the changes won't be made in the database or recorded in the change history. This means that the change never occurred from the perspective of other users and the system.

**_Fast-track transition an issue_ example**

_Fast-track transition an issue_ should be placed **after** the _Fire Event_ step. If you fast-track an issue to another status before firing the event, the notifications might not reflect the intermediate transition. By placing the fast-track transition after the event firing, you ensure that the issue's history and notifications accurately reflect the sequence of transitions that the issue went through.

## Use this post function

1.  Go to **Administration > Issues > Workflows.**
2.  Select **Edit** on the workflow you want to add a post function to. 
3.  Select the transition to which you wish to add a post function to.
4.  Under **Options**, select **Post Functions.  
    ![](/sr4js/files/latest/549617737/549617739/1/1772038928000/custom_post_function_1.png)  
    **
5.  On the _Transition_ page, select **Add post function**.
6.  Select **Custom script post-function**.  
    ![Image selecting this post function](/sr4js/files/latest/549617737/549617745/1/1772038929000/Custom_script_pf.png)  
    
7.  Select **Add**.
8.  Optional: Enter a note that describes the post function (this note is for your reference when viewing all post functions).
9.  Enter an **Inline script** of your choice or enter one of the [example scripts](#id-.CustomPostFunctionsv10.17.0-examples) displayed further down this page. 
10.  Select **Preview** to see an overview of the change. 
11.  Select **Add**.  
     
12.  If applicable, reorder your new post functions using the arrow icons on the right of the function (they can only move one line at a time). 
     
13.  Select **Publish** and choose if you want to save a backup copy of the workflow.  
     ![](/sr4js/files/latest/549617737/549617741/1/1772038928000/Add_comment_5.png)
     
     You can now test to see if this post function works.
     

### Examples

Each of the examples below is based on specific workflows and project types. **Make sure you adjust the examples appropriately to suit your workflow/s.**

-   [Add a generated comment](#id-.CustomPostFunctionsv10.17.0-append-comment)
-   [Auto-add reviewers based on request type](#id-.CustomPostFunctionsv10.17.0-auto-add-reviewers)
-   [Auto close sub-tasks](#id-.CustomPostFunctionsv10.17.0-close-subtasks)
-   [Set issue field](#id-.CustomPostFunctionsv10.17.0-set-issue-fields)
-   [Get workflow steps](#id-.CustomPostFunctionsv10.17.0-get-workflow-steps)
-   [Assign to a random member of a role](#id-.CustomPostFunctionsv10.17.0-assign-to-random-role)
-   [Display a message to the user](#id-.CustomPostFunctionsv10.17.0-display-message)

### Add a generated comment 

You can automatically add a generated comment on a transition. In this example, we add a comment if a user resolved an issue that has unresolved subtasks:

```
if (issue.subTaskObjects.any { !it.resolution }) {
    issue.addComment('I resolved this issue even though there were unresolved sub-tasks...') {
        setDispatchEvent(false)
    }
}
```

### **Auto-add reviewers based on request** type

This example is specific to [Jira Service Management projects with approvals](https://confluence.atlassian.com/adminjiraserver/configuring-jira-service-management-approvals-938847527.html) and is added to the **Create issue** workflow transition. 

You can automatically add reviewers to tasks depending on the request type. In this example, a purchase over $100 needs to be cleared by one department, and a travel request needs to be cleared by your manager:

If you use this example on the **Create issue** workflow transition, it is important that this is the **FIRST** post-function to execute. See the [Post function order](#id-.CustomPostFunctionsv10.17.0-post-function-order) section for more information. 

**

```
/*This is a map of request-Type -> Request Reviewers*/
def requestTypeToApprovers = [
    "Purchase over \$100": ["financeTeamUser", "lineManagerUser"],
    "Travel request"     : ["travelTeamUser", "lineManagerUser"]
]

if (issue.issueType.name == "Service Request with Approvals") {
    def requiredApproverNames = requestTypeToApprovers[issue.requestType?.name]

    if (requiredApproverNames) {

        issue.set {
            setCustomFieldValue('Approvers') {
                requiredApproverNames.each {
                    add(it)
                }
            }
        }
    }
}
```







**

### Auto close sub-tasks

You automatically resolve sub-tasks. In this example, we _Resolve_ all currently open sub-tasks when the parent task is transitioned to _Resolved_. 

```
def subTasks = issue.subTaskObjects
subTasks.each { subTask ->
    if (subTask.status.name == "Open") {
        subTask.transition('Resolve Issue') {
            setResolution('Done')
        }
    }
}
```

### Set issue fields

You can automatically set some issue fields, such as components, versions, custom, and system fields. The following example covers these areas:

You can only use this method to update issue fields if your script post-function comes before the standard function _Update change history for an issue and store the issue in the database_. See the [Post function order](#id-.CustomPostFunctionsv10.17.0-post-function-order) section for more information. 

```
import java.time.LocalDate

issue.set {
    setFixVersions('1.1')
    setComponents('MyComponent')

    // a text field
    setCustomFieldValue('TextFieldA', "Some text value")

    // a date time field - add 7 days to current datetime
    setCustomFieldValue('Date Picker') {
        set(get().plusDays(7))
    }

    // checkboxes, radio buttons, single and multi selects
    setCustomFieldValue('Checkboxes', 'Yes')

    // a user custom field
    setCustomFieldValue('UserPicker', 'admin')

    // system fields
    setDescription("A generated description")

    // set due date to tomorrow
    setDueDate {
        set(LocalDate.now().plusDays(1))
    }
}
```

### Get workflow steps

#### Get the current action name

You may want to get the current action ID or name for a number of reasons, for example for tracking or auditing purposes, you may want to log the action name each time the post function runs. 

You can use the following code to get the **ID** of the workflow action:

```
transientVars["actionId"]
```

You can use the following code to get the **name** of the workflow action:

```
import com.atlassian.jira.component.ComponentAccessor

def workflow = ComponentAccessor.getWorkflowManager().getWorkflow(issue)
def wfd = workflow.getDescriptor()
def actionName = wfd.getAction(transientVars["actionId"] as int).getName()
log.debug("Current action name: $actionName")
```

#### Get the previous and destination steps

The placement of your custom function is relative to the built-in post functions that update the issue in the database and reindex affects how you retrieve the current and destination steps. If your function is positioned before these system post functions, it will see the issue's state before the transition. If it's after, it will see the state as updated by the transition.

You can use the following code to return the **current** status:

```
issue.status.name
```

You can use the following code to get the **destination** step:

```
import com.atlassian.jira.component.ComponentAccessor
import com.opensymphony.workflow.spi.Step

def step = transientVars["createdStep"] as Step
def stepId = step.getStepId()
def status = ComponentAccessor.getConstantsManager().getStatus(stepId as String)

log.debug(status.name)
```

### Assign an issue to a random member of a role

You may want to automatically assign an issue to a random member of a role. For example, you want to assign a _Developers_ role member to an issue after it transitions from _Under Review_ to _Investigate_. You can use the following code to assign an issue to a random member in the _Developers_ role:

This is similar to the [Assign to First Member of Role](https://docs.adaptavist.com/sr4js/latest/features/workflows/post-functions/assign-to-first-member-of-role) post function.

```
import com.atlassian.jira.security.roles.ProjectRoleManager
import com.atlassian.jira.component.ComponentAccessor

def roleName = "Developers"

def projectRoleManager = ComponentAccessor.getComponent(ProjectRoleManager)

def role = projectRoleManager.getProjectRole(roleName)
def actors = projectRoleManager.getProjectRoleActors(role, issue.getProjectObject())
def roleUsers = actors.getUsers()

def randomIndex = new Random().nextInt(roleUsers.size() - 1)

def randomUser = roleUsers.getAt(randomIndex)

issue.setAssignee(randomUser)
```

### Display a message to the user

Use `UserMessageUtil` to show a banner notification in the Jira UI after a transition. It is best suited for situations where the user is viewing an issue directly and triggers a transition from the issue view; for example, clicking a transition button on the issue page.

#### Message types

Four types are available depending on the nature of the message:

```
import com.onresolve.scriptrunner.runner.util.UserMessageUtil

UserMessageUtil.success("Issue reassigned to the reporter.")  // 🟢 green  — action completed
UserMessageUtil.info("SLA timer has started.")                // 🔵 blue   — neutral information
UserMessageUtil.warning("Retrofit codes required.")           // 🟡 yellow — user action needed
UserMessageUtil.error("Could not notify downstream system.")  // 🔴 red    — something went wrong
```

#### Best practices for `UserMessageUtil`

We recommend the following best practices:

-   Use `UserMessageUtil` when you know the user will be transitioning from the issue view and want a lightweight, non-intrusive notification.
-   For transitions that may happen from the board or **Create** dialogue, use `issue.addComment()` instead. Comments are written directly to the issue and are always visible regardless of how the transition was triggered.
-   For the most reliable experience, combine both: `UserMessageUtil` for users on the issue view, and a comment as a fallback.

The following example reassigns the issue to the reporter on transition. It displays a notification if the user has the issue open, and adds a comment to the issue as a fallback so there is always a visible record of the action regardless of how the transition was triggered.

```
import com.onresolve.scriptrunner.runner.util.UserMessageUtil

issue.set {
    setAssignee(issue.reporter)
}

UserMessageUtil.success("Issue reassigned to ${issue.reporter?.displayName}.")

issue.addComment("🔄 Automatically reassigned to reporter on transition to In Progress.") {
    setDispatchEvent(false)
}
```

  

* * *

## Related content

-   [Post Functions Tutorial](https://docs.adaptavist.com/sr4js/latest/features/workflows/workflow-functions-tutorial/post-functions-tutorial)
-   [Post Functions](https://docs.adaptavist.com/sr4js/latest/features/workflows/post-functions)
-   [Workflow Functions Tutorial](https://docs.adaptavist.com/sr4js/latest/features/workflows/workflow-functions-tutorial)
