# Restrict Field Option Based on Group for JSM Example

- Platform: cloud
- Space: SR4JC
- Hierarchy: features > behaviours > example-behaviour
- Doc ID: doc-sr4jc-578720458
- Source: https://docs.adaptavist.com/sr4jc/latest/features/behaviours/example-behaviour/restrict-field-option-based-on-group-for-jsm-example

Use this example to create a Behaviour that verifies whether the current user belongs to a specific group. If the user is not in that group, a field option is hidden, so it is only visible to group members. For example, you can make an additional **Impact** field option available only to users in the team-leads group.

Follow the steps below to create this behaviour:

1.  Navigate to **ScriptRunner > Behaviours**.
2.  Click **Create Behaviour**.
3.  Choose the **JSM Behaviour** option.  
    
    If you do not have user permissions for the jira-servicemanagement-users group, you will see a warning message displayed:  
    ![](/sr4jc/files/latest/578720458/578720460/1/1786374533000/JSM+permissions.png)
    
    Click **Edit user permissions** to open the Jira admin settings, then add your name to the jira-servicemanagement-users group. Keep in mind that the full group name includes an instance-specific suffix, such as jira-servicemanagement-users-<instance-name>.
    
      
    
4.  Enter a name and description for the behaviour. In this example, we use _Restrict field option based on the group for JSM_.
5.  Choose where the behaviour rules will apply from the **Step 1: Location** options.  
    1.  Select the spaces to which the behaviour will be applied from the list of available **Spaces**.
    2.  Select the request type to which the behaviour will be applied from the list of available **Request Types**.
    3.  Select the view type to which the behaviour will be applied from the list of available **View Types**.  
        
        JSM is currently supported in Portal view only. Due to an Atlassian limitation, Agent view is not supported at this time, but will be available soon.
        
6.  Determine when the behaviour script will run by choosing the trigger that controls when the script executes from the **Step 2: Trigger** options. For this example, choose the **On** **change** trigger event so that the script runs when the specified change occurs.
7.  Scroll to the script editor of the **Step 3: Rules** section, as required. Note that you can open the [API documentation](https://docs.adaptavist.com/sr4jc/latest/features/behaviours/behaviours-api) directly from here. 
8.  Click **Example Scripts**, and you are automatically redirected to the [ScriptRunner HQ](https://www.scriptrunnerhq.com/help/example-scripts?__hstc=61790195.da95f02d1ae0d1d31a393cdad208fa8e.1751962752113.1753699681099.1753779400943.54&__hssc=61790195.16.1753779400943&__hsfp=4179679497) website**.** There, you will find a variety of examples available.
    
9.  Filter or search to find the [Restrict field option based on the group](https://www.scriptrunnerhq.com/help/example-scripts/restrict-field-option-based-on-group-cloud) example script, and click **Copy Cloud Script**.
    
10.  Paste the copied code into your script editor, as shown below:  
     ![](/sr4jc/files/latest/578720458/578720461/1/1786006447000/step3+rules+ex.jpg)  
     
     Remember to replace the custom field IDs in the script with the field IDs from your Jira instance.
     
11.  Click **Save and enable**.
