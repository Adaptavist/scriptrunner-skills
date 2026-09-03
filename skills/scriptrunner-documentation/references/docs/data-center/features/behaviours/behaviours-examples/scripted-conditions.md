# Scripted Conditions

- Platform: data-center
- Space: SR4JS
- Hierarchy: features > behaviours > behaviours-examples
- Doc ID: doc-sr4js-442888205
- Source: https://docs.adaptavist.com/sr4js/latest/features/behaviours/behaviours-examples/scripted-conditions

The following script is a collection of example conditions that can be used with Behaviours. These conditions demonstrate various ways to dynamically control field properties based on different criteria such as user roles, custom field values, and workflow states. To use one of these conditions in a Behaviour script, select the relevant part of the code and adapt it to your specific needs.

Further details on the following API can be found on the [Behaviours API Quick Reference](https://docs.adaptavist.com/sr4js/latest/features/behaviours/api-quick-reference) page.

```
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.security.roles.ProjectRoleManager

// Get the current user
def currentUser = ComponentAccessor.getJiraAuthenticationContext().getLoggedInUser()
// Get the changed field
def exampleField = getFieldById(getFieldChanged())

if (currentUser == underlyingIssue.reporterUser && currentUser == underlyingIssue.assignee) { // <1>
    exampleField.setHidden(true)
} else {
    exampleField.setHidden(false)
}

if (ComponentAccessor.getGroupManager().getGroupsForUser(currentUser)?.find { it.name == "jira-administrators" }) { // <2>
    exampleField.setAllowInlineEdit(true) // only available in Initialiser
} else {
    exampleField.setAllowInlineEdit(false) // only available in Initialiser
}

def projectRoleManager = ComponentAccessor.getComponent(ProjectRoleManager)
def devProjectRole = projectRoleManager.getProjectRole("Developers")
if (currentUser.key == "luke" || projectRoleManager.isUserInProjectRole(currentUser, devProjectRole, underlyingIssue.getProjectObject())) { // <3>
    exampleField.setError("You are either Luke or you belong to Developers project role and you cannot edit the field")
    exampleField.setReadOnly(true)
} else {
    exampleField.clearError()
    exampleField.setReadOnly(false)
}

if (currentUser == underlyingIssue.projectObject.getProjectLead()) { // <4>
    exampleField.setDescription("Current User is project lead")
} else {
    exampleField.clearHelpText()
}

def cf = ComponentAccessor.getCustomFieldManager().getCustomFieldObjectByName("Multi User Picker CF")
if (currentUser == underlyingIssue.getCustomFieldValue(cf) || currentUser in underlyingIssue.getCustomFieldValue(cf)) { // <5>
    getFieldById("description").setFormValue("Current user is member of the Multi User Picker custom field")
} else {
    getFieldById("description").setFormValue("Current user is not member of the Multi User Picker custom field")
}

def cf2 = ComponentAccessor.getCustomFieldManager().getCustomFieldObjectByName("Single Group Picker CF")
def groupsToCompare = underlyingIssue.getCustomFieldValue(cf2) as ArrayList
if (ComponentAccessor.getGroupManager().getGroupsForUser(currentUser.key)?.disjoint(groupsToCompare)) { // <6>
    exampleField.setRequired(true)
} else {
    exampleField.setRequired(false)
}

if (getActionName() == "Start Progress" || getDestinationStepName() == "Done") { // <7>
    exampleField.setRequired(true)
} else {
    exampleField.setRequired(false)
}
```

**Line 9:** If the **current user is the reporter** AND the **current user is the current assignee** make the changed field hidden, else shown

**Line 15:** If the **current user in group 'jira-administrators'** allow the inline edit of the changed field

**Line 23:** If the **current user is 'luke'** or the **current user in the project role 'Developers'** make the changed field read-only and show an error message, else clear the error and make the field editable again

**Line 31:**  If the **current user is Project Lead** add a description at the changed field, else clear the description

**Line 37:** If the **current user is in the user custom field value** add a default value in the description

**Line 44:** If the **current user is in the group custom field value** then make the changed field required, else optional.

**Line 52:** If **workflow Action is 'Start Progress'** or **workflow Step is 'Done'** then make the changed field required, else optional.

# Examples

Check out the following examples to see how conditions could be used in a Behaviour:

-   [Field-Level Permissions](https://docs.adaptavist.com/sr4js/latest/features/behaviours/behaviours-examples/field-level-permissions)
-   [Modify Field Descriptions](https://docs.adaptavist.com/sr4js/latest/features/behaviours/behaviours-examples/modify-field-descriptions)
-   [Restricting Issue Types](https://docs.adaptavist.com/sr4js/latest/features/behaviours/behaviours-examples/restricting-issue-types)

## Non-scripted conditions

Behaviours allow you to add conditions without writing code. When adding a field to a behaviour, you can select **Add new condition**. Here you can choose whether the behaviour will run or not when the condition you set is true. You can set then a condition to further define the field you are configuring.

![](/sr4js/files/latest/442888205/441364095/1/1731586485000/Non_scripted_condition_example.png)

* * *

## Related content

-   [Behaviours API Quick Reference](https://docs.adaptavist.com/sr4js/latest/features/behaviours/api-quick-reference)
-   [Behaviour Limitations](https://docs.adaptavist.com/sr4js/latest/features/behaviours/behaviour-limitations)
-   [Behaviours](https://docs.adaptavist.com/sr4js/latest/features/behaviours)
