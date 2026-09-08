# Field-Level Permissions

- Platform: data-center
- Space: SR4JS
- Hierarchy: features > behaviours > behaviours-examples
- Doc ID: doc-sr4js-442888949
- Source: https://docs.adaptavist.com/sr4js/latest/features/behaviours/behaviours-examples/field-level-permissions

We've made it easy for you to specify field permissions. In the example below, we show you how to make a field mandatory if the priority field is set to _High_ or _Highest_. We also have an example on the [Behaviours Tutorial](https://docs.adaptavist.com/sr4js/latest/features/behaviours/behaviours-tutorial) page that shows you how to [make a field read-only unless a user is in a specific role](https://docs.adaptavist.com/sr4js/latest/features/behaviours/behaviours-tutorial#examples).

## Make a field mandatory if the priority field is a set value 

This example shows you how to make a field mandatory if the priority field is a set value. 

Behaviours only function on the _Create Issue_, _Update/Edit Issue_, _Assign Issue_, and _Workflow Transition_ screens (see [Behaviour Limitations](https://docs.adaptavist.com/sr4js/latest/features/behaviours/behaviour-limitations)). In the example below, we're adding a server-side script to a field, meaning the behaviour will run every time the field is updated.

### Scenario

To manage their high-priority issues more effectively, Great Adventure wants the _Justification_ field to be mandatory if the priority is set to _High_ or _Highest_. 

If you want to test this example, [add a Text Field (multi-line) custom field](https://confluence.atlassian.com/adminjiraserver0905/adding-custom-fields-1207177580.html#Addingcustomfields-Creatinganewcustomfield) named `Justification`.

1.  From ScriptRunner, navigate to **Behaviours**. 
2.  Select **Create Behaviour**.
3.  Enter a name for the behaviour. In this case we enter `Make Justification mandatory when high priority`.
4.  Optional: Enter a description for the behaviour.
5.  Select **Create Mapping**.
6.  Then select the project and issue type(s) to map this behaviour to. In this case we chose the **Great Adventure VTD** project and **All issue types**.
7.  Select **Add Mapping** to confirm the mapping.
8.  Select **Create** to create the behaviour.  
    ![](/sr4js/files/latest/442888949/442888959/2/1758746983000/Behaviour_tutorial_1.png) You're taken to the **Edit Behaviour** screen where you can configure the behaviour further.
    
9.  Scroll to the **Add Field** field, select the **Priority** field, and then select **Add**.  
    We now need to add a server-side script to the field for it to show the additional text field when someone selects _High_ or _Highest_.
10.  Select **Create Script.  
     ![](/sr4js/files/latest/442888949/442888969/1/1758746984000/Behaviour_priority_add.png)  
     **
     
11.  Copy/paste the following code into the the inline script editor:  
     
     ```
import com.atlassian.jira.issue.priority.Priority

def priorityField = getFieldById("priority")
def justificationField = getFieldByName("Justification")

if (((Priority) priorityField.value).name in ["High", "Highest"]) {
    justificationField.setRequired(true)
    justificationField.setHelpText("Please explain why this issue is the priority you selected.")
} else {
    justificationField.setRequired(false)
    justificationField.setHelpText("")
}
```
     
12.  Select **Save Changes**. 
     
     You can now test to see if this behaviour works!
     

* * *

## Related content

-   [Behaviours Examples](https://docs.adaptavist.com/sr4js/latest/features/behaviours/behaviours-examples)
-   [Using Behaviours Video](https://docs.adaptavist.com/sr4js/latest/training/course-introduction-to-scriptrunner-for-jira-data-center-server/1-2-video-using-behaviours-in-scriptrunner-for-jira-data-center-server)
-   [Behaviours Tutorial](https://docs.adaptavist.com/sr4js/latest/features/behaviours/behaviours-tutorial)
