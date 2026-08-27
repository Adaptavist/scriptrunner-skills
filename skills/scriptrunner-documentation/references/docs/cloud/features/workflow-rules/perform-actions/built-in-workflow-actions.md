# Built-in Workflow Actions

- Platform: cloud
- Space: SR4JC
- Hierarchy: features > workflow-rules > perform-actions
- Doc ID: doc-sr4jc-104376159
- Source: https://docs.adaptavist.com/sr4jc/latest/features/workflow-rules/perform-actions/built-in-workflow-actions

ScriptRunner for Jira Cloud has many built-in workflow actions; each of these is outlined below.

## Add/remove to/from sprint

Using this function, you can either add a work item to an active sprint or remove it from its current sprint after a transition.

For example, on the _Start Progress_ transition, you can apply this workflow action to automatically add the transitioned work item to the current sprint. Although this does not follow scrum methodology, there may be times when the team has finished all work in a sprint, and this workflow action automatically adds work items to the sprint.

1.  Select a transition.
    
2.  Click **Perform actions > Add perform actions rule**.
    
3.  Select **ScriptRunner, perform actions,** and click **Add**.
    
4.  Select the **Add/Remove from Sprint** built-in workflow action.
    
5.  Add a **Description,** for example, _Add Work Item to Sprint_.
    
6.  Check **Enable perform actions** to make it active as soon as creation is finished.
    
7.  Add additional Groovy code in the **Conditions** field that returns a boolean value determining the condition for which the work item is added/removed to/from sprint. See [Restrict Transitions](https://docs.adaptavist.com/sr4jc/latest/features/workflow-rules/restrict-transitions) for examples.
    
8.  Select the **Action** you want to trigger after transition (either **Add to Sprint** or **Remove from Sprint**).
    
9.  Choose the **Board Name**. The function picks the first active sprint from that board.
    
10.  Pick the user to run the script as in **Run As**. See [Run as User](https://docs.adaptavist.com/sr4jc/latest/features/workflow-rules/perform-actions/fields#id-.FieldsvCurrent-Runasuser) for more information.
     
11.  Click **Add**.
     

See the available Script Context for **Condition** and **Additional Code** fields in the [Script Context](https://docs.adaptavist.com/sr4jc/latest/features/workflow-rules/perform-actions/fields#id-.FieldsvCurrent-Scriptcontext) section.

## Assign Work Item

_Assign Work Item_ takes the item and assigns it to the last assignee with a specified role or from a user group. You must specify either a space role or a user group. If both are defined, the space role is used, and the user group is skipped.

For example, a developer finishes working on a work item and marks it as _Ready to Test_. After the work item is transitioned, it is automatically assigned to a tester. The tester rejects the work item, and it returns to the development team. The last user assigned to the development role is reassigned to the work item. The dev can then fix the work item and transition it back to the QA team. When they do, the work item is reassigned to the same tester (the last user in the tester role).

1.  Select a transition.
    
2.  Click **Perform actions > Add perform actions rule**.
    
3.  Select **ScriptRunner perform actions,** and click **Add**.
    
4.  Select the **Assign Work Item** built-in workflow action.
    
5.  Add a **Description,** for example, _Assign to last developer_.
    
6.  Check **Enable perform actions** to make it active as soon as creation is finished.
    
7.  Add additional Groovy code in the **Conditions** field that returns a boolean value determining the condition for which the work item is assigned. See [Restrict Transitions](https://docs.adaptavist.com/sr4jc/latest/features/workflow-rules/restrict-transitions) for examples.
    
8.  Either select a **Space Role** (for example, **Developer**) or **User Group**. The last user with this role/in this user group is selected after the work item has transitioned.
    
9.  Pick the user to run the script as in **Run As**. See [Run as User](https://docs.adaptavist.com/sr4jc/latest/features/workflow-rules/perform-actions/fields#id-.FieldsvCurrent-Runasuser) for more information.
    
10.  Click **Add**.
     

See the available Script Context for **Condition** and **Additional Code** fields in the [Script Context](https://docs.adaptavist.com/sr4jc/latest/features/workflow-rules/perform-actions/fields#id-.FieldsvCurrent-Scriptcontext) section.

## Clone Work Item

Known issue error for the Clone Issue Post Function

Expand to read more details...

**Work Item Description:** When cloning a work item with attachments in the rich text field, you may encounter an error if you _have enabled_ [Atlassian's new transition experience](https://community.atlassian.com/forums/Jira-articles/Now-GA-try-the-new-issue-transition-experience-in-Jira/ba-p/2734436). Read more in our [Breaking Changes](https://docs.adaptavist.com/sr4jc/latest/release-notes/breaking-changes/compatibility-of-atlassian-s-new-transition-experience-with-jira-expressions) documentation. For example:

```
2025-03-14 18:34:49.554 WARN - POST request to /rest/api/3/issue returned an error code: status: 400 - Bad Request
body: {errorMessages=[], errors={description=We don't recognise the format of a file you added or the data in it. Remove and try again.}}
```

This is a known issue related to an Atlassian bug ([JRACLOUD-93305](https://jira.atlassian.com/browse/JRACLOUD-93305)). Below is a workaround to mitigate its impact by clearing the field or replacing the content manually.

**Workaround:** We recommend checking the field value's **format type (**`Map` **or** `String`**)** before clearing or setting it. This ensures that both sets of users, those who have/do not have the new transition experience enabled, are supported. For example, we can use the Description field as shown below:

```
def originalDescription = issue.fields.description

if (originalDescription instanceof Map) { // New experience (ADF)
    issueInput.fields.description = new groovy.json.JsonSlurper().parseText("""
      Your ADF format
    """)
} else if (originalDescription instanceof String) { // Old experience (plain text)
    issueInput.fields.description = "Your plain text value"
}
```

We recommend this approach as necessary due to the following reasons:

-   For users of the new transition experience, **API** **v3** (`/rest/api/3/issue`) expects the description in **ADF** (Atlassian Document Format) and will fail if a plain string is passed.
    
-   For users of the old transition experience, **API v2** (`/rest/api/2/issue`) expects the description in **plain text** and will fail if ADF is passed.
    

Rather than leaving blank content, you can include custom content using Atlassian’s [ADF Builder Playground](https://developer.atlassian.com/cloud/jira/platform/apis/document/playground/ "https://developer.atlassian.com/cloud/jira/platform/apis/document/playground/") to enter values in the editor and generate content in ADF format. Since it outputs JSON, you can directly parse it in the console, similar to this [Scripted Fields](https://docs.adaptavist.com/sr4jc/latest/features/scripted-fields#return-types:~:text=appears%20as%20follows%3A-,JSON%20notations,-Atlassian%E2%80%99s%20Document%20Format) example:

```
issueInput.fields.description = new groovy.json.JsonSlurper().parseText("""
Your ADF
""")
```

  

_Clone Work Item_ creates a clone of a selected work item and optionally links the two items. Specify the target space, work type, link type, and link direction (between the source work item and the clone). For example, you have a ticket for a potential new hire. When this ticket transitions to _Hired_ you want to automatically clone the work item to the IT board so the team can set up their login details.

An epic workflow action can be cloned; however, the work items contained within that epic are not cloned. You will, therefore, need to recreate any associated items.

It is possible to override `issueInput` with a new structure by setting `issueInput` from additional code; however, this is not recommended.

1.  Select a transition.
    
2.  Click **Perform actions > Add perform actions rule**.
    
3.  Select **ScriptRunner perform actions**, and click **Add**.
    
4.  Select the **Clone Work Item** built-in workflow action.
    
5.  Add a **Description,** for example, _Create IT ticket_.
    
6.  Check **Enable perform action** to make it active as soon as creation is finished.
    
7.  Add additional Groovy code in the **Conditions** field that returns a boolean value determining the condition for which the work item is cloned. See [Restrict Transitions](https://docs.adaptavist.com/sr4jc/latest/features/workflow-rules/restrict-transitions) for examples.
    
8.  Select an **Work Type** for the cloned work item. Leave this field blank to make the cloned work item the same type as the source work item.
    
9.  Select a **Target Space**; this is the space the new cloned work item is assigned to. Leave this field blank to clone the work item to the same space as the source item.
    
10.  Pick the user to run the script as in **Run As**. See [Run as User](https://docs.adaptavist.com/sr4jc/latest/features/workflow-rules/perform-actions/fields#id-.FieldsvCurrent-Runasuser) for more information.
     
11.  Select a link type under **Link Name**. The source work item and the clone are linked using this link type. Leave blank for no link.
     
12.  Select the **Link Direction** between the source work item and the clone.
     
13.  In the **Additional Code** field, modify the `issueInput` structure before it is used as the POST body  `/rest/api/2/issue` to create the work item. For example, add a label, set an assignee, or update the summary of the clone.
     
14.  Click **Add**.
     

See the available Script Context for **Condition** and **Additional Code** fields in the [Script Context](https://docs.adaptavist.com/sr4jc/latest/features/workflow-rules/perform-actions/fields#id-.FieldsvCurrent-Scriptcontext) section.

### Supported field types

The Clone Work Item function only copies Jira system fields and any custom fields that have the following types:

-   Checkbox
    
-   Date picker
    
-   Date time picker
    
-   Labels
    
-   Number field
    
-   Radio button
    
-   Select list
    
-   Multi-select list
    
-   Single text field
    
-   Multi-row text field
    
-   URL field
    
-   User picker
    
-   Group picker
    
-   Multi-select group picker
    
-   Space picker
    
-   Multi-select user picker
    
-   Version picker
    
-   Multi-select version picker
    

Fields created by other plugins might not be supported. However, it is possible to add additional code to the configuration to include them.

## Create sub-task

Create a sub-task for the work item being transitioned. Specify the sub-task type and title, along with executing additional code. Additional code has `issueInput` bound as the structure that is used in the post to `/rest/api/2/issue` to create the sub-task. Overriding `issueInput` is possible by setting `issueInput` as part of the script.

For example, a ticket needs to be checked by several departments before it is considered _Done_. Using this workflow action, you can automatically create sub-tasks for these departments when a ticket is created.

1.  Select a transition.
    
2.  Click **Perform actions > Add perform actions rule**.
    
3.  Select **ScriptRunner Perform actions** and click **Add**.
    
4.  Select the **Create Sub-task** built-in workflow action.
    
5.  Add a **Description,** for example, _Department sub-tasks_.
    
6.  Check **Enable Perform actions rule** to make it active as soon as creation is finished.
    
7.  Add additional Groovy code in the **Conditions** field that returns a boolean value determining the condition for which the sub-task is created. See [Restrict Transitions](https://docs.adaptavist.com/sr4jc/latest/features/workflow-rules/restrict-transitions) for examples.
    
8.  Enter a short **Sub-task Summary**.
    
9.  Select the sub-task **I****ssue Type**
    
10.  Pick the user to run the script as in **Run As**. See [Run as User](https://docs.adaptavist.com/sr4jc/latest/features/workflow-rules/perform-actions/fields#id-.FieldsvCurrent-Runasuser) for more information.
     
11.  In the **Additional Code** field, modify the sub-task structure before it is used as the POST body to /rest/api/2/issue to create the sub-task.
     
12.  Click **Add**.
     

See the available Script Context for **Condition** and **Additional Code** fields in the [Script Context](https://docs.adaptavist.com/sr4jc/latest/features/workflow-rules/perform-actions/fields#id-.FieldsvCurrent-Scriptcontext) section.

### Create sub-task example

Here is the code we run under the hood in the provided function, modified so you can run it in the script console:

```
// Here we specify and retrieve the details of the parent work item
// If you copied this code into a Perform actions rule or an item-related Script Listener you could remove
// the first 5 lines of code as an work item variable would already be available to your script
def parentKey = 'DEMO-1'
def issueResp = get("/rest/api/2/issue/${parentKey}")
        .asObject(Map)
assert issueResp.status == 200
def issue = issueResp.body as Map

// We retrieve all issue types
def typeResp = get('/rest/api/2/issuetype')
        .asObject(List)
assert typeResp.status == 200
def issueTypes = typeResp.body as List<Map>

// Here we set the basic subtask work item details
def summary = "Subtask summary"
def issueType = "Sub-task"
def issueTypeId = issueTypes.find { it.subtask && it.name == issueType }?.id

assert issueTypeId : "No subtasks issue type found called '${issueType}'"

def createDoc = [
        fields: [
                project: (issue.fields as Map).project,
                issuetype: [
                        id: issueTypeId
                ],
                parent: [
                        id: issue.id
                ],
                summary: summary
        ]
]

// Now we create the subtask
def resp = post("/rest/api/2/issue")
        .header("Content-Type", "application/json")
        .body(createDoc)
        .asObject(Map)
def subtask = resp.body
assert resp.status >= 200 && resp.status < 300 && subtask && subtask.key != null

subtask
```

## Fast-track transition work item

Use _Fast-track Transition Work Item_ to immediately transition an item if the provided condition is true. Transitions are specified by name and must be valid for the work item that is to be transitioned.

Due to limitations in the Jira REST API, it is not possible to validate transition names until execution.

For example, all work items that have the item priority _Major_ should be escalated to get additional sign-off after creation.

1.  Select a transition.
    
2.  Click **Perform actions > Add Perform actions rule**.
    
3.  Select **ScriptRunner perform actions** and click **Add**.
    
4.  Select the **Fast-track Transition Work Item** built-in workflow action.
    
5.  Add a **Description,** for example, _Requires Additional Approval_.
    
6.  Check **Enable perform action** to make it active as soon as creation is finished.
    
7.  Add additional Groovy code in the **Conditions** field that returns a boolean value determining the condition for which the work item is transitioned. See [Restrict Transitions](https://docs.adaptavist.com/sr4jc/latest/features/workflow-rules/restrict-transitions) for examples.
    
8.  Enter a comment to add during the transition in **Transition Comment**.
    
    A comment is only added if the transition allows adding a comment.
    
9.  Enter a **Transition ID**. This is the ID of the transition you wish to perform on the work item.
    
    The transition ID is found on the _Edit_ page of a workflow. It is the number in brackets after the transition name. For example, the ID for the transition _OPEN (1)_ is 1.
    
10.  Alternatively to using the **Transition ID**, you can specify a **Transition Name**. TIP: It is recommended that a transition ID be used instead of the transition name because, in some cases, it is not possible to find the transition ID by name (for example, if the _Hide From User_ Condition is configured on the transition).
     
11.  Pick the user to run the script as in **Run As**. See [Run as User](https://docs.adaptavist.com/sr4jc/latest/features/workflow-rules/perform-actions/fields#id-.FieldsvCurrent-Runasuser) for more information.
     
12.  In the **Additional Code** field, modify the `transition` structure before it is used as the PUT body  `/rest/api/2/issue/<[issue.id](http://issue.id)>/transition` to modify the work item when transitioned.
     
13.  Click **Add**.

See the available Script Context for **Condition** and **Additional Code** fields in the [Script Context](https://docs.adaptavist.com/sr4jc/latest/features/workflow-rules/perform-actions/fields#id-.FieldsvCurrent-Scriptcontext) section.

## Modify work item

Update the work item, or perform any action on the item after a transition. TIP: Cancel an update by setting `issueInput` to `null`. Cancelling an update allows you to use this workflow action in a similar way to a script listener.

1.  Select a transition.
    
2.  Click **Perform actions > Add perform actions rule**.
    
3.  Select **ScriptRunner Perform actions** and click **Add**.
    
4.  Select the **Modify Work Item** built-in workflow action.
    
5.  Add a **Description,** for example, _Change assignee when approved_.
    
6.  Check **Enable perform actions** to make the function active as soon as creation is finished.
    
7.  Add additional Groovy code in the **Conditions** field that returns a boolean value determining the condition for which the work item is modified. See [Restrict Transitions](https://docs.adaptavist.com/sr4jc/latest/features/workflow-rules/restrict-transitions) for examples.
    
8.  Pick the user to run the script as in **Run As**. See [Run as User](https://docs.adaptavist.com/sr4jc/latest/features/workflow-rules/perform-actions/fields#id-.FieldsvCurrent-Runasuser) for more information.
    
9.  Modify the `issueInput` structure in **Additional Code** before it is used as the POST body to `/rest/api/2/issue/<issue id>/notify` to modify the work item.
    
    Running as the add-on user adds `overrideScreenSecurity=true` as a query parameter to allow editing fields that are not on the screen.
    

See the available Script Context for **Condition** and **Additional Code** fields in the [Script Context](https://docs.adaptavist.com/sr4jc/latest/features/workflow-rules/perform-actions/fields#id-.FieldsvCurrent-Scriptcontext) section.

## Run script

Run arbitrary code after a transition.

1.  Select a transition.
    
2.  Click **Perform actions > Add perform actions rule**.
    
3.  Select **ScriptRunner Perform actions** and click **Add**.
    
4.  Select the **Run Script** built-in workflow action.
    
5.  Add a **Description**.
    
6.  Check **Enable Perform actions** to make this function active as soon as creation is finished.
    
7.  Add additional Groovy code in the **Conditions** field that returns a boolean value determining the condition for which the script is run. See [Restrict Transitions](https://docs.adaptavist.com/sr4jc/latest/features/workflow-rules/restrict-transitions) for examples.
    
8.  Pick the user to run the script as in **Run As**. See [Run as User](https://docs.adaptavist.com/sr4jc/latest/features/workflow-rules/perform-actions/fields#id-.FieldsvCurrent-Runasuser) for more information.
    
9.  In the **Code** field, add the code to run when the condition is true. For example, link a work item, update a work item, or add a comment.
    
10.  Click **Add**.
     

See the available Script Context for **Condition** and **Additional Code** fields in the [Script Context](https://docs.adaptavist.com/sr4jc/latest/features/workflow-rules/perform-actions/fields#id-.FieldsvCurrent-Scriptcontext) section.

## Send notification

Generate an email notification to send to a number of users and/or groups, including Watchers, Voters, the Reporter, and Assignee.

The notify API, which this script uses, contains a validation rule preventing users from notifying themselves. This means that the execution fails if the user being notified is the same user who executed the script.

1.  Select a transition.
    
2.  Click **Perform actions > Add Perform actions rule**.
    
3.  Select **ScriptRunner Perform actions** and click **Add**.
    
4.  Select the **Send Notification** built-in workflow aciton.
    
5.  Add a  **Description,** for example, _Notify when work starts_.
    
6.  Check **Enable Perform actions** to make this function active as soon as creation is finished.
    
7.  Add additional Groovy code in the **Conditions** field that returns a boolean value determining the condition for which the notification is sent. See [Restrict Transitions](https://docs.adaptavist.com/sr4jc/latest/features/workflow-rules/restrict-transitions) for examples.
    
8.  Specify who receives the notification:
    
    1.  Select the users to notify. Check to notify watchers, voters, the reporter, or assignee.
        
    2.  Choose users to send the notification to in the **Users** field.
        
    3.  Enter the **Groups** to send the notification to.
        
        Specify a minimum of one recipient.
        
9.  Enter the notification **Subject**.
    
10.  Enter the notification body as Groovy code in **Message**.
     
     Use the **Email Template** example as a starting point. You can also create the message template in HTML, for example:
     
     ```
"<p>Hi <strong>" + (issue.fields.reporter?.displayName ?: "User") + "</strong>,</p>" +
"<p>Your issue <strong>" + issue.key + "</strong> has been updated.</p>"
```
     
       
     
11.  Pick the user to run the script as in **Run As**. See [Run as User](https://docs.adaptavist.com/sr4jc/latest/features/workflow-rules/perform-actions/fields#id-.FieldsvCurrent-Runasuser) for more information.
12.  Modify the `notification` structure in **Additional Code** before it is used as the POST body  `/rest/api/2/issue/<issue id>/notify` to send the notification. You can refer to [Atlassian's REST API](https://developer.atlassian.com/cloud/jira/platform/rest/v2/api-group-issues/#api-rest-api-2-issue-issueidorkey-notify-post) for more information. An example of modifying the notification structure is shown below:
     
     ```
notification.subject = "This is the issue key: ${issue.key}"
```
     
     This example forces the removal of the hardcoded value entered by the user on the **Subject** field, and sends an email with the current work item's key in the subject as “This is the item key: TEST-123”.
     
13.  Click **Add**.
     

See the available Script Context for **Condition** and **Additional Code** fields in the [Script Context](https://docs.adaptavist.com/sr4jc/latest/features/workflow-rules/perform-actions/fields#id-.FieldsvCurrent-Scriptcontext) section.

The following is an example of constructing an email from the work item details.

Use the following in the **Condition** field to specify that the work item must have an assignee:

* * *

```
issue.fields.assignee != null
```

* * *

Enter the following into the **Message** field to retrieve the value for the 'TextFieldB' custom field and construct the notification body:

```
def fields = get('/rest/api/2/field')
        .asObject(List)
        .body as List<Map>

defcustomFieldId = fields.find { it.name == 'TextFieldB' }.id as String
defcustomFieldValue = (issue.fields[customFieldId] as Map)?.value

"""Dear ${issue.fields.assignee?.displayName},

The ${issue.fields.issuetype.name} ${issue.key} with priority ${issue.fields.priority?.name} has been assigned to you.

Description: ${issue.fields.description}

Custom field value: ${customFieldValue}

Regards,
${issue.fields.reporter?.displayName}"""
```

**Line 5:** Retrieve the custom field ID for the 'TextFieldB' custom field.

## Transition parent work item

Transition the parent work item of a sub-task.

This workflow action is only valid for sub-tasks and will not work on parent work items or items with no sub-tasks.

The specified transition is performed on the parent of the sub-task when a condition is met. As with _Fast-Track Transition Item_, the transition name is provided and not validated.

1.  Select a transition.
    
2.  Click **Perform actions > Add perform actions rule**.
    
3.  Select **ScriptRunner Perform actions** and click **Add**.
    
4.  Select the **Transition Parent Item** built-in workflow action.
    
5.  Add a **Description,** for example, _Transition parent when done_.
    
6.  Check **Enable Perform Actions rule** to make it active as soon as creation is finished.
    
7.  Add additional Groovy code in the **Conditions** field that returns a boolean value determining the condition for which the work item is transitioned. See [Restrict Transitions](https://docs.adaptavist.com/sr4jc/latest/features/workflow-rules/restrict-transitions) for examples.
    
8.  Enter a comment to add during the transition in **Transition Comment**.
    
    A comment is only added if the transition allows adding a comment.
    
9.  Enter a **Transition ID**. This is the ID of the transition you wish to perform on the parent work item.
    
    The transition ID is found on the _Edit_ page of a workflow. It is the number in brackets after the transition name. For example, the ID for the transition _OPEN (1)_ is 1.
    
10.  Alternatively to using the **Transition ID**, you can specify a **Transition Name**. TIP: It is recommended that a transition ID be used instead of the transition name because, in some cases, it is not possible to find the transition ID by name (for example, if the _Hide From User_ Condition is configured on the transition).
     
11.  Pick the user to run the script as in **Run As**. See [Run as User](https://docs.adaptavist.com/sr4jc/latest/features/workflow-rules/perform-actions/fields#id-.FieldsvCurrent-Runasuser) for more information.
     
12.  In the **Additional Code** field, modify the `transition` structure before it is used as the PUT body  `/rest/api/2/issue/<[issue.id](http://issue.id)>/transition` to modify the work item when transitioned.
     
13.  Click **Add**.
     

See the available Script Context for **Condition** and **Additional Code** fields in the [Script Context](https://docs.adaptavist.com/sr4jc/latest/features/workflow-rules/perform-actions/fields#id-.FieldsvCurrent-Scriptcontext) section.
