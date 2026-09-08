# Restricting Priority and Resolution

- Platform: data-center
- Space: SR4JS
- Hierarchy: features > behaviours > behaviours-examples
- Doc ID: doc-sr4js-442889044
- Source: https://docs.adaptavist.com/sr4js/latest/features/behaviours/behaviours-examples/restricting-priority-and-resolution

You can use Behaviours to easily restrict priority and resolution values by workflow transition, project and/or issue type, user groups, user roles, and more.

For example, to optimize workflows, you may want to restrict resolutions based on the workflow transition being completed. As another example, you may want to restrict certain priorities and resolutions to certain roles to make sure some users can't create high-priority issues. 

When restricting resolutions, you can modify your workflow to use the [`jira.field.resolution.include`](https://confluence.atlassian.com/display/JIRA/Workflow+properties) property. However this doesn’t scale well when you have very many workflows. If you do, you should seriously consider writing a script to update all your workflows.

### Restrict by workflow action

You can use Behaviours to restrict what resolutions display based on the workflow transition being completed. In the following example, we have a transition called _Terminate_ and we only want users to be able to use the _Won't Fix_, _Incomplete_, and _Cannot Reproduce_ resolutions when completing this transition. 

1.  From ScriptRunner, navigate to **Behaviours**. 
2.  Select **Create Behaviour**.
3.  Enter a name for the behaviour. In this example we enter `Restricting by workflow action`.
4.  Optional: Enter a description for the behaviour.
5.  Select **Create Mapping**.
6.  Select the project and issue type(s) to map this behaviour to. 
7.  Select **Add Mapping** to confirm the mapping.
8.  Select **Create** to create the behaviour.  
    ![](/sr4js/files/latest/442889044/441364091/1/1731431437000/Restrict_workflow_state_1.png)  
    You're taken to the **Edit Behaviour** screen where you can configure the behaviour further.
9.  Scroll to the **Initialiser** field and select **Create Script**.  
    ![](/sr4js/files/latest/442889044/441364093/1/1731414309000/Restricting_issue_type_2.png)
    
10.  Copy the following code into the inline script editor:  
     
     ```
import static com.atlassian.jira.issue.IssueFieldConstants.RESOLUTION

if (getActionName() == "Terminate") {
    getFieldById(RESOLUTION).setFieldOptions(["Won't Fix", "Incomplete", "Cannot Reproduce"])
}
```
     
     `setFieldOptions` accepts two types of input:
     
     -   **`Iterable`** (preferred): pass a List (or any Iterable) containing the display names of the options to allow. See [API docs](https://docs.adaptavist.com/sr4js/latest/features/behaviours/api-quick-reference#id-.APIQuickReferencev9.x-setFormValue) (setFormValue) for more information.
     -   **`Map`**: pass a Map object, where the keys are the IDs of the priority or resolution (or priority, version, custom field option, etc), and the values are the strings that will be displayed in the UI.
     
11.  Select **Save Changes**.  
     
     You can test to see if this behaviour works by using the _Terminate_ (or equivalent) transition. 
     
     ![](/sr4js/files/latest/442889044/441364090/1/1731431483000/Restrict_workflow_state_2.png)
     

### Restrict Priorities by Group

You use Behaviours to restrict priorities by group. In the following example, we restrict users so only those in the _jira-developers_ group can use the two highest priorities.

1.  From ScriptRunner, navigate to **Behaviours**. 
2.  Select **Create Behaviour**.
3.  Enter a name for the behaviour. In this example we enter `Restrict priorities for none jira-developers`.
4.  Optional: Enter a description for the behaviour.
5.  Select **Create Mapping**.
6.  Select the project and issue type(s) to map this behaviour to. 
7.  Select **Add Mapping** to confirm the mapping.
8.  Select **Create** to create the behaviour.  
    You're taken to the **Edit Behaviour** screen where you can configure the behaviour further.
9.  Scroll to the **Initialiser** field and select **Create Script**.  
    ![](/sr4js/files/latest/442889044/441364093/1/1731414309000/Restricting_issue_type_2.png)
    
10.  Copy the following code into the inline script editor:  
     
     ```
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.issue.fields.config.manager.PrioritySchemeManager

import static com.atlassian.jira.issue.IssueFieldConstants.PRIORITY

def prioritySchemeManager = ComponentAccessor.getComponent(PrioritySchemeManager)

def userUtil = ComponentAccessor.getUserUtil()

def currentUser = ComponentAccessor.jiraAuthenticationContext.getLoggedInUser()
if (!userUtil.getGroupNamesForUser(currentUser.name).contains("jira-developers")) {

    def allowedPriorities = prioritySchemeManager.getOptions(issueContext).findAll {
        it.toInteger() > 2
    }

    getFieldById(PRIORITY).setFieldOptions(prioritySchemeManager.getPrioritiesFromIds(allowedPriorities))
}
```
     
       
     
11.  Select **Save Changes**.  
     
     Test this behaviour by trying to create an issue as a user who is **not** a member of the jira-developer group. You may need to use the [switch user](https://docs.adaptavist.com/sr4js/latest/get-started/settings/switch-user-function) function.
     

  

* * *

## Related content

-   [Behaviours Tutorial](https://docs.adaptavist.com/sr4js/latest/features/behaviours/behaviours-tutorial)
-   [Restricting Issue Types](https://docs.adaptavist.com/sr4js/latest/features/behaviours/behaviours-examples/restricting-issue-types)
-   [Behaviours](https://docs.adaptavist.com/sr4js/latest/features/behaviours)
