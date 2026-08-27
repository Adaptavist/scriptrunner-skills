# Example Behaviour Scripts

- Platform: cloud
- Space: SR4JC
- Hierarchy: features > behaviours > example-behaviour
- Doc ID: doc-sr4jc-469401614
- Source: https://docs.adaptavist.com/sr4jc/latest/features/behaviours/example-behaviour/example-behaviour-scripts

You can find some helpful example Behaviour scripts below. There are also many more example scripts available that can be accessed on our [ScriptRunner HQ website](https://www.scriptrunnerhq.com/help/example-scripts?ScriptRunner%5BrefinementList%5D%5Bapp%5D%5B0%5D=script-runner-jira&ScriptRunner%5BrefinementList%5D%5Bfeature%5D%5B0%5D=behaviours&ScriptRunner%5BrefinementList%5D%5Bplatform%5D%5B0%5D=cloud).

## Dynamically show or hide a field

In this example, when the Department field is selected and the Finance option is chosen, the line manager field is hidden, and the ticket category field is shown. When the HR option is selected, the ticket category field is hidden, and the line manager field is shown. When the Product option is selected, both fields are hidden.

```
const departmentField = getFieldById('customfield_10035');
const ticketCategoryField = getFieldById('customfield_10037');
const lineManagerField = getFieldById('customfield_10036');
const changedField = getChangeField();

switch (changedField.getName()) {
    case 'Department':
        switch (changedField.getValue().value) {
            case 'Finance':
                lineManagerField.setVisible(false);
                ticketCategoryField.setVisible(true);
                break;
            case 'HR':
                ticketCategoryField.setVisible(false);
                lineManagerField.setVisible(true);
                break;
            case 'Product':
                ticketCategoryField.setVisible(false);
                lineManagerField.setVisible(false);
                break;
        }
        break;
}
```

## Limit work item types based on user role

This script will limit the user's ability to create work items to a specific subset of work types if they belong to a certain group.

```
 // Note: You should run this script by selecting "On load" in the check box above.

 const context = await getContext();
 const spaceId = context.extension.project.id;

 const spaceRoles = await makeRequest(`/rest/api/3/project/${ spaceId }/roledetails?currentMember=true`);
 const spaceRoleNames = spaceRoles.body.map(role => role.name);

 const workItemTypeField = getFieldById("issuetype");
 const allowedWorkItemTypeIds = ['10133', '10134']; // IDs for Story and Task

 if (spaceRoleNames.includes('Developers')) {
     workItemTypeField.setOptionsVisibility(allowedWorkItemTypeIds, true);

     if (!allowedWorkItemTypeIds.includes(workItemTypeField.getValue()?.id)) {
         workItemTypeField.setValue("10133"); // Default to Story if the current value is not allowed
     }
 }
```

## Make a request to a Jira API

This example shows how you can call a Jira API to search for a user and assign the work item to that user.

```
 const assigneeName = 'Demo User';

const res = await makeRequest(`/rest/api/3/user/search?query=${assigneeName}`);

const assigneeAccountId = res.body[0].accountId;
getFieldById("assignee").setValue(assigneeAccountId);
```

## Make the field read-only based on user groups

This script shows how you can get the user groups that the current logged-in user is a member of, and how to make fields read-only if the user is a member of a specific group.

```
const ticketDepartment = getFieldById("customfield 10205")
const userRegion = getFieldById("customfield 10206")
const ticketCat = getFieldById("customfield 10207")
const priority = getFieldById("priority")

const group = "Example Group";

const user = await makeRequest("/rest/api/2/myself");
if (user) {
    const { accountId } = user.body;
    const userGroups = await makeRequest ("/rest/api/2/user/groups?accountId=" + accountId);
    if (userGroups) {
        const groupNames = userGroups.body.map(({ name }) => name);
        if (groupNames.includes(group)) {
            ticketDepartment.setVisible(false)
            userRegion.setVisible(false)
            ticketCat.setVisible(false)

            priority.setReadOnly(true)
        }
    }
}
```

## Set the description text below a field on the create screen

With this script, you can add some custom help text below a field to explain further context to users about what the field is for, then use the _setDescription()_ method provided by behaviours.

```
getFieldById("summary").setDescription("Please describe the work item in less than 25 words");
```

## Show or hide fields conditionally based on the selection in another field

With this script, when a selection is made on a select field. It will show or hide another field based on the selection made.

```
// Retrieve the 'Opportunity' drop-down field and other relevant fields
const opportunityField = getFieldById("customfield_10057");  // Replace with your actual custom field ID
const contractValueField = getFieldById("customfield_10061"); // Field for 'Contract value'
const lossReasonField = getFieldById("customfield_10060");    // Field for 'Loss reason'

// Get the current selected value from the 'Opportunity' field
const opportunityValue = opportunityField.getValue()?.value;

// Control visibility based on the selected value
if (opportunityValue === 'Won') {
    // If 'Won' is selected, show the 'Contract value' field and hide 'Loss reason'
    contractValueField.setVisible(true);
    lossReasonField.setVisible(false);
} else if (opportunityValue === 'Lost') {
    // If 'Lost' is selected, show the 'Loss reason' field and hide 'Contract value'
    contractValueField.setVisible(false);
    lossReasonField.setVisible(true);
} else {
    // If neither 'Won' nor 'Lost' is selected, hide both fields
    contractValueField.setVisible(false);
    lossReasonField.setVisible(false);
}
```
