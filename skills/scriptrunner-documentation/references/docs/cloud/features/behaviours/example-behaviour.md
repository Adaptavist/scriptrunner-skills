# Example Behaviour

- Platform: cloud
- Space: SR4JC
- Hierarchy: Features > Behaviours
- Doc ID: doc-sr4jc-f5a7062e-1ee5-4bae-98d6-2a1d2a91aea0-1df1a462b51eeafe
- Source: https://docs.adaptavist.com/sr4jc/latest/features/behaviours#example-behaviour--en

Tip: Example scripts

You can find many example Behaviours scripts in the [Example scripts](https://www.scriptrunnerhq.com/help/example-scripts) section of the [ScriptRunner website](https://www.scriptrunnerhq.com/).

Note: If you are setting a field value that is in Atlassian Doc Format, you can use the [ADF builder tool](https://developer.atlassian.com/cloud/jira/platform/apis/document/playground/) provided by Atlassian and refer to their [documentation](https://developer.atlassian.com/cloud/jira/platform/apis/document/structure/?_ga=2.116963205.265153314.1664180857-1688501704.1660815719) for more details.

## Example Behaviour Scripts

You can find some helpful example Behaviour scripts below. There are also many more example scripts available that can be accessed on our [ScriptRunner HQ website](https://www.scriptrunnerhq.com/help/example-scripts?ScriptRunner%5BrefinementList%5D%5Bapp%5D%5B0%5D=script-runner-jira&ScriptRunner%5BrefinementList%5D%5Bfeature%5D%5B0%5D=behaviours&ScriptRunner%5BrefinementList%5D%5Bplatform%5D%5B0%5D=cloud).

### Dynamically show or hide a field

In this example, when the _Department_ field is selected and the _Finance_ option is chosen, the line manager field is hidden, and the ticket category field is shown. When the _HR_ option is selected, the ticket category field is hidden, and the line manager field is shown. When the _Product_ option is selected, both fields are hidden.

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

### Limit work item types based on user role

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

### Make a request to a Jira API

This example shows how you can call a Jira API to search for a user and assign the work item to that user.

```
 const assigneeName = 'Demo User';
 
const res = await makeRequest(`/rest/api/3/user/search?query=${assigneeName}`);
 
const assigneeAccountId = res.body[0].accountId;
getFieldById("assignee").setValue(assigneeAccountId);
```

### Make the field read-only based on user groups

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

### Set the description text below a field on the create screen

With this script, you can add some custom help text below a field to explain further context to users about what the field is for, then use the _setDescription()_ method provided by behaviours.

Use the _setDescription()_ method provided by behaviours to add custom help text below a field.

```
getFieldById("summary").setDescription("Please describe the work item in less than 25 words");
```

### Show or hide fields conditionally based on the selection in another field

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

## Change field name for Jira Example

This example shows you how to change the name displayed for a specific field within the work item creation screen. In this example, the field entitled Summary is changed to Ticket Title in response to a particular team's preferences.

Follow the steps below to create the behaviour:

1.  Open the _Behaviours_ tab and click Create Behaviour.
    
    You will see the _Create Behaviour_ screen displayed:
    
2.  Choose the Jira Behaviour option.
3.  Enter a name and description for the behaviour. It's good practice to make these as descriptive as possible.
4.  Scroll down to the _Behaviour Mapping_ section and select the relevant space to which this behaviour will be mapped from the _Spaces_ drop-down. For this example, choose the Docs space.
5.  Select the work type that will be associated with the behaviour from the _Work Types_ drop-down. For this example, choose the Task work item type.
6.  Scroll down to the _Behaviours Scripts_ section and click Add Script.
    
    The _Add Field Script_ pop-up window is displayed, where you can add the behaviour script:
    
7.  Define _when_ the script should run. This can be when the work item creation screen loads initially and/or in response to a field change. For the purpose of this example, check the On load option so that the Summary field is renamed to Ticket Title when the work item creation screen loads.
    
    | When | Runs |
    | --- | --- |
    | On load | The script will run when the create screen initially loads. Choose this option when you want the affected field to populate immediately upon opening the create screen.<br>For example, a field name or field description is changed, or a value is pre-populated into the field. |
    | On change | The script will run when the specified supported field change happens.You should choose this option when you've added a restrict transition to the logic and identified a trigger that will update the affected field. |
    
8.  Choose Create from the view type options of Create, View/Edit, or Transition to run the script on. Refer to the [Behaviours Supported Fields and Products](https://docs.adaptavist.com/sr4jc/latest/features/behaviours/behaviours-supported-fields-and-products) details, as not all field types are supported.
9.  Enter your code within the script box, as required. Note that you can open the [API documentation](https://docs.adaptavist.com/sr4jc/latest/features/behaviours/behaviours-api) directly from here.
    
    Alternatively, you can reuse one of the many example scripts provided and modify the code as required, ensuring that you:
    
    -   Edit any variables, like custom field names, roles, or groups, in the example code so it's relevant to your instance.
    -   Choose the right time to run your script on load and/or change so that it runs when needed.
    
    To choose an example:
    
    1.  Click Example scripts, and you are automatically redirected to the [ScriptRunner HQ website](https://www.scriptrunnerhq.com/help/example-scripts?__hstc=61790195.dc865c37e20bd115fe7ef340c103a316.1727432789496.1757052734380.1757057082801.507&__hssc=61790195.43.1757057082801&__hsfp=173020142&_gl=1*1fyspf7*_gcl_aw*R0NMLjE3NTI1NzYxMzkuQ2owS0NRanctTmZEQmhEeUFSSXNBRC1JTGVEamRsNHFfRFZDdklFSzBkcjhaX1hPSmpvZTJaaTVtLThNQ3kzbXN1X0V2UUNENE14cFN4c2FBbkhSRUFMd193Y0I.*_gcl_au*MzIzNDM2MjIxLjE3NTE4NzUwMTE.*_ga*MTYzNDU5NTExMC4xNzI3NDMyNzkw*_ga_C6V1F2HSMM*czE3NTcwNTcwODAkbzUyMyRnMSR0MTc1NzA2MTQyNiRqNTkkbDAkaDExMDk2NjUwNTY.), where you can view the Behaviours example scripts.
    2.  Choose your preferred script from the examples provided. You also have the option to search for a particular script.
    3.  Open the script and click Copy Cloud script.
    4.  Return to the script box and paste the copied code into the code editor.
    
10.  Click Save Script once you have confirmed the parameters as `getFieldById("summary").setName("Ticket Title")`;.
11.  Click Save and enable to confirm the configurations for your behaviour.
     
     Now that you have created the behaviour to run when the screen loads, you will see the field entitled Summary change to Ticket Title when you create new tasks within the Docs space in your Jira instance.
     
12.  Refresh your screen and click Create to see the behaviour in action.
     
     You are returned to the _Create work item_ screen, where you will see your changes, as shown below:
     
     If you wish to revert to the original Summary field name, click Disable from the ellipsis menu next to your chosen behaviour, as shown below:
     

## Change the Visibility of the Priority Field for Jira Example

You can use the Behaviours feature to control who can see or edit the Priority field based on their user permissions. For example, if you want only Space Managers to change the field, you can configure the behaviour to hide the field from all other users.

To do so, follow the steps below:

1.  Navigate to ScriptRunner > Behaviours.
2.  Click Create Behaviour and the following screen appears:
    
3.  Choose Jira Behaviour.
4.  Enter a name and description for the behaviour. In this example, we use _Hide the priority field from users with certain permissions_ and _Hide the priority field from anyone who does not have that permission_.
    
5.  Select the Spaces and Work Types to which the behaviour will be applied (or mapped).
    
    Tip: You cannot simultaneously select all spaces and all work types. See our [Behaviour Limitations](https://docs.adaptavist.com/sr4jc/latest/features/behaviours/behaviours-limitations) for more details.
    
6.  Click Add Script.
    
    You will see the _Add Field Script_ pop-up window appear, where you can add the behaviour script.
    
7.  Choose to run the script On Load and for the View/Edit view type.
8.  Click Example Scripts, and you are automatically redirected to the [ScriptRunner HQ](https://www.scriptrunnerhq.com/help/example-scripts?__hstc=61790195.da95f02d1ae0d1d31a393cdad208fa8e.1751962752113.1753699681099.1753779400943.54&__hssc=61790195.13.1753779400943&__hsfp=4179679497) website .
    
    There, you will find a variety of examples available.
    
9.  Filter or search to find the [Change the visibility of the priority field](https://www.scriptrunnerhq.com/help/example-scripts/Show-Priority-To-Users-In-Specific-Group-cloud) example script, and click Copy Cloud Script.
10.  Paste the copied code into your script editor, as shown below:
     
11.  Click Save Script and then Save and enable.

Now that you have created the behaviour, you will see that the Priority field is only visible to the Space Managers when creating an issue in Jira.

## Make Fields Editable Based on Role for Jira Example

You can use the Behaviours feature to control field editability based on user roles. For example, as a Space Manager, you may want fields to be editable for users with the Developer role but read-only for those with the Administrator role. To achieve this, you'll need to check which space roles the logged-in user belongs to, then configure the behaviour to make fields editable for Developers and read-only for Administrators.

To do so, follow the steps below:

1.  Navigate to ScriptRunner > Behaviours.
2.  Click Create Behaviour and the following screen appears:
    
3.  Choose Jira Behaviour.
4.  Enter a name and description for the behaviour. In this example, we use _Make fields editable_ and _Make fields editable for a particular role_.
5.  Select the Spaces and Work types to which the behaviour will be applied (or mapped).
    
    Tip: You cannot simultaneously select all space and all work types. See our [Behaviour Limitations](https://docs.adaptavist.com/sr4jc/latest/features/behaviours/behaviours-limitations) for more details.
    
6.  Click Add Script.
    
    You will see the _Add Field Script_ pop-up window appear, where you can add the behaviour script.
    
7.  Choose to run the script On Change and for the View/Edit view type.
8.  Click Example Scripts, and you are automatically redirected to the [ScriptRunner HQ](https://www.scriptrunnerhq.com/help/example-scripts?__hstc=61790195.da95f02d1ae0d1d31a393cdad208fa8e.1751962752113.1753699681099.1753779400943.54&__hssc=61790195.16.1753779400943&__hsfp=4179679497) website.
    
    There, you will find a variety of examples available.
    
9.  Filter or search to find the [Make Fields Editable to only users in a certain role](https://www.scriptrunnerhq.com/help/example-scripts/Restrict-Field-Actions-To-Certain-Roles-cloud) example script, and click Copy Cloud Script.
10.  Paste the copied code into your script editor, as shown below:
     
11.  Click Save Script and then Save and enable.
     
     Now that you have created the behaviour, it automatically checks the currently logged-in user's space roles and adjusts field permissions, making fields editable for Developers and read-only Administrators.
     

## Auto-assign High Priority Work Items for Jira Example

You can use the Behaviours feature to automatically set the Assignee field when the Priority field is set to high and clear it for any other value. For example, as a Space Manager, you might want all high-priority work items to be assigned to the technical lead.

To do so, follow the steps below:

1.  Navigate to ScriptRunner > Behaviours.
2.  Click Create Behaviour and the following screen appears:
    
    For this example, we use _Auto-assign high priority work items_ and _Automatically assigns the work item to a specific user when the priority is high_.
    
3.  Choose Jira Behaviour.
4.  Enter a name and description for the behaviour. For this example, we use _Auto-assign high priority work items_ and _Automatically assigns the work item to a specific user when the priority is high_.
5.  Select the Spaces and Work types to which the behaviour will be applied (or mapped).
    
    Tip: You cannot simultaneously select all spaces and all work types. See our [Behaviour Limitations](https://docs.adaptavist.com/sr4jc/latest/features/behaviours/behaviours-limitations) for more details.
    
6.  Click Add Script.
    
    You will see the _Add Field Script_ pop-up window appear, where you can add the behaviour script.
    
7.  Choose to run the script On Change and for the Create View.
8.  Click Example Scripts, and you are automatically redirected to the [ScriptRunner HQ](https://www.scriptrunnerhq.com/help/example-scripts?__hstc=61790195.da95f02d1ae0d1d31a393cdad208fa8e.1751962752113.1753699681099.1753779400943.54&__hssc=61790195.13.1753779400943&__hsfp=4179679497) website .
    
    There, you will find a variety of examples available.
    
9.  Filter or search to find the [Set the assignee field when the priority is set to High](https://www.scriptrunnerhq.com/help/example-scripts/set-the-assignee-field-when-the-priority-is-set-to-high-cloud) example script, and click Copy Cloud Script.
10.  Paste the copied code into your script editor, as shown below:
     
11.  Click Save Script and then Save and enable.
     
     Now that you have created the behaviour, you will see that a high-priority field will be assigned only to the Space Manager when creating a story in Jira.
     

## Show Warnings or Restrict Options for JSM Example

Use this example script to create a Behaviour that shows a warning or restricts the options available based on a selection in a select field. You will create a Behaviour that shows a warning or restricts the options based on the selections made in the Transport and Level fields.

Follow the steps below to create this behaviour:

1.  Navigate to ScriptRunner > Behaviours.
2.  Click Create Behaviour.
3.  Choose the JSM Behaviour option.
    
    Tip:
    
    If you do not have user permissions for the jira-servicemanagement-users group, you will see a warning message displayed:
    
    Click Edit user permissions to open the Jira admin settings, then add your name to the jira-servicemanagement-users group. Keep in mind that the full group name includes an instance-specific suffix, such as jira-servicemanagement-users-<instance-name>.
    
4.  Enter a name and description for the behaviour. In this example, we use _Show warning or restrict options based on fields_.
5.  Choose where the behaviour rules will apply from the Step 1: Location options.
    
    1.  Select the spaces to which the behaviour will be applied from the list of available Spaces.
    2.  Select the request type to which the behaviour will be applied from the list of available Request Types
    3.  Select the view type to which the behaviour will be applied from the list of available View Types.
    
    Tip:
    
    JSM is currently supported in Portal view only. Due to an Atlassian limitation, Agent view is not supported at this time, but will be available soon.
    
6.  Determine when the behaviour script will run by choosing the trigger that controls when the script executes from the Step 2: Trigger options. For this example, choose the On change trigger event so that the script runs when the specified change occurs
7.  Scroll to the script editor of the Step 3: Rules section, as required. Note that you can open the [API documentation](https://docs.adaptavist.com/sr4jc/latest/features/behaviours/behaviours-api) directly from here.
8.  Click Example Scripts, and you are automatically redirected to the [ScriptRunner HQ](https://www.scriptrunnerhq.com/help/example-scripts?__hstc=61790195.da95f02d1ae0d1d31a393cdad208fa8e.1751962752113.1753699681099.1753779400943.54&__hssc=61790195.16.1753779400943&__hsfp=4179679497) website.
    
    There, you will find a variety of examples available.
    
9.  Filter or search to find the [Show warning or restrict options based on fields](https://www.scriptrunnerhq.com/help/example-scripts/show-warning-or-restrict-options-based-on-fields-cloud) example script, and click Copy Cloud Script.
10.  Paste the copied code into your script editor, as shown below:
     
     Tip: Remember to replace the custom field IDs in the script with the field IDs from your Jira instance.
     
11.  Click Save and enable.

## Prefill Fields with User Information and Dates for JSM Example

Use this example to understand how to automatically populate fields in a Behaviour when creating or editing a work item.

In this example, you create a Behaviour that pre-fills:

-   a user picker field with the current user
-   a date field with today's date

Follow the steps below to create this behaviour:

1.  Navigate to ScriptRunner > Behaviours.
2.  Click Create Behaviour.
3.  Choose the JSM Behaviour option.
    
    Tip:
    
    If you do not have user permissions for the jira-servicemanagement-users group, you will see a warning message displayed:
    
    Click Edit user permissions to open the Jira admin settings, then add your name to the jira-servicemanagement-users group. Keep in mind that the full group name includes an instance-specific suffix, such as jira-servicemanagement-users-<instance-name>.
    
4.  Enter a name and description for the behaviour. In this example, we use __Pre-fill fields with user information for JSM__.
5.  Choose where the behaviour rules will apply from the Step 1: Location options.
    
    1.  Select the spaces to which the behaviour will be applied from the list of available Spaces.
    2.  Select the request type to which the behaviour will be applied from the list of available Request Types
    3.  Select the view type to which the behaviour will be applied from the list of available View Types.
    
    Tip:
    
    JSM is currently supported in Portal view only. Due to an Atlassian limitation, Agent view is not supported at this time, but will be available soon.
    
6.  Determine when the behaviour script will run by choosing the trigger that controls when the script executes from the Step 2: Trigger options. For this example, choose the On change trigger event so that the script runs when the specified change occurs
7.  Scroll to the script editor of the Step 3: Rules section, as required. Note that you can open the [API documentation](https://docs.adaptavist.com/sr4jc/latest/features/behaviours/behaviours-api) directly from here.
8.  Click Example Scripts, and you are automatically redirected to the [ScriptRunner HQ](https://www.scriptrunnerhq.com/help/example-scripts?__hstc=61790195.da95f02d1ae0d1d31a393cdad208fa8e.1751962752113.1753699681099.1753779400943.54&__hssc=61790195.16.1753779400943&__hsfp=4179679497) website.
    
    There, you will find a variety of examples available.
    
9.  Filter or search to find the [Pre-fill fields with user information and dates cloud](https://www.scriptrunnerhq.com/help/example-scripts/prefill-fields-with-user-info-and-dates-cloud) example script, and click Copy Cloud Script.
10.  Paste the copied code into your script editor, as shown below:
     
     Tip: Remember to replace the custom field IDs in the script with the field IDs from your Jira instance.
     
11.  Click Save and enable.

## Dynamically Update Priority for Incidents Summary for JSM Example

Use this example to create a Behaviour that automatically assigns the highest priority to incidents whose summary contains urgent keywords, such as 'outage' or 'system down'.

The script checks the Summary field for such critical keywords and does the following:

-   If a keyword is found, it sets Priority to highest and makes the field read-only.
-   If no keyword is found, it keeps Priority editable and sets it to medium when no priority has been selected.

Follow the steps below to create this behaviour:

1.  Navigate to ScriptRunner > Behaviours.
2.  Click Create Behaviour.
3.  Choose JSM Behaviour.
    
    Tip:
    
    If you do not have user permissions for the jira-servicemanagement-users group, you will see a warning message displayed:
    
    Click Edit user permissions to open the Jira admin settings, then add your name to the jira-servicemanagement-users group. Keep in mind that the full group name includes an instance-specific suffix, such as jira-servicemanagement-users-<instance-name>.
    
4.  Enter a name and description for the behaviour. In this example, we use __Dynamically update priority for incidents based on summary for JSM__.
5.  Choose where the behaviour rules will apply from the Step 1: Location options.
    
    1.  Select the spaces to which the behaviour will be applied from the list of available Spaces.
    2.  Select the request type to which the behaviour will be applied from the list of available Request Types
    3.  Select the view type to which the behaviour will be applied from the list of available View Types.
    
    Tip:
    
    JSM is currently supported in Portal view only. Due to an Atlassian limitation, Agent view is not supported at this time, but will be available soon.
    
6.  Determine when the behaviour script will run by choosing the trigger that controls when the script executes from the Step 2: Trigger options. For this example, choose the On change trigger event so that the script runs when the specified change occurs
7.  Scroll to the script editor of the Step 3: Rules section, as required. Note that you can open the [API documentation](https://docs.adaptavist.com/sr4jc/latest/features/behaviours/behaviours-api) directly from here.
8.  Click Example Scripts, and you are automatically redirected to the [ScriptRunner HQ](https://www.scriptrunnerhq.com/help/example-scripts?__hstc=61790195.da95f02d1ae0d1d31a393cdad208fa8e.1751962752113.1753699681099.1753779400943.54&__hssc=61790195.16.1753779400943&__hsfp=4179679497) website.
    
    There, you will find a variety of examples available.
    
9.  Filter or search to find the [Dynamically update priority for incidents based on summary for JSM](https://www.scriptrunnerhq.com/help/example-scripts/priority-based-on-summary-cloud) example script, and click Copy Cloud Script.
10.  Paste the copied code into your script editor, as shown below:
     
     Tip: Remember to replace the custom field IDs in the script with the field IDs from your Jira instance.
     
11.  Click Save and enable.

## Example Videos of Behaviours

We have included some example videos of Behaviour functionality. To help you understand the ScriptRunner for Jira Cloud Behaviours feature, you can also watch our [Behaviours: Dynamic Field Control & Customization](../../training/video-playlist-script-runner-for-jira-cloud-demo/behaviours-dynamic-field-control-and-customization.md) video playlist.

### How to pre-fill a template in a field

We have many [demo videos](https://www.youtube.com/playlist?list=PLnsCytbU4bI6SwVAp1DJlzua9vk1oLQ-G) aimed at helping you understand how the Behaviours feature works in ScriptRunner for Jira Cloud. Here's one of our Behaviours demo videos outlining how to pre-fill a template on a field:[Media](https://www.youtube.com/embed/watch?v=Kr6ru70Dmpc&list=PLnsCytbU4bI6SwVAp1DJlzua9vk1oLQ-G&index=5)

### Behaviours on screen tabs

One of our recent enhancements for Behaviours on ScriptRunner for Jira Cloud includes the addition of Behaviours on screen tabs. You can check out our doc for more information and watch the video below to understand how this works:[Behaviours API](https://docs.adaptavist.com/sr4jc/latest/features/behaviours/behaviours-api)[Media](https://www.youtube.com/embed/7VVvJ1l5IbI?si=9PtQmaL-t4Ikmkkm)
