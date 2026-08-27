# Create and Modify JSM Behaviours

- Platform: cloud
- Space: SR4JC
- Hierarchy: features > behaviours
- Doc ID: doc-sr4jc-574260442
- Source: https://docs.adaptavist.com/sr4jc/latest/features/behaviours/create-and-modify-jsm-behaviours

## Create a JSM behaviour

JSM is currently supported in Portal view only. Due to an Atlassian limitation, Agent view is not supported at this time, but will be available soon.

The steps below describe how you can create a new JSM behaviour:

1.  Navigate to **ScriptRunner **>** Behaviours**. You will see a list of any previously created behaviours.  
    ![](/sr4jc/files/latest/574260442/574260456/1/1784296912000/create+jira+behaviour.png)  
    
2.  Click **Create Behaviour** and choose the **JSM Behaviour** option.  
    
    JSM permissions
    
    If you do not have user permissions for the jira-servicemanagement-users group, you will see a warning message displayed:  
    ![](/sr4jc/files/latest/574260442/574260447/1/1784647491000/JSM+permissions.png)
    
    Click **Edit user permissions** to open the Jira admin settings, then add your name to the jira-servicemanagement-users group. Keep in mind that the full group name includes an instance-specific suffix, such as jira-servicemanagement-users-<instance-name>.
    
3.  Enter a name and description for the behaviour. It's good practice to make these as descriptive as possible.  
    
4.  Choose where the behaviour rules will apply from the **Step 1: Location** options:   
    1.  Select the spaces to which the behaviour will be applied from the **Spaces** drop-down list.
    2.  Select the request type to which the behaviour will be applied from the **Request Types** drop-down list.
    3.  Select the view type to which the behaviour will be applied from the **View Types** drop-down list.   
        
        At least one option must be selected from each category, and you have the option to choose _Select all_ if required. 
        
          
        
5.  Determine when the behaviour script will run by choosing the trigger that controls when the script executes from either **On** **load** or **On** **change** (or both) from the **Step 2: Trigger** options.
    
    When
    
    Runs
    
    On load
    
    The script will run when the chosen view type screen initially loads. Choose this option when you want the affected field to populate immediately upon opening the chosen view type screen. 
    
    For example, a field name or description can be changed, or a value can be pre-populated into the field.
    
    On change
    
    The script will run when the specified supported field change happens. You may want to run the script initially when it loads, AND if a change has occurred. Choose this option when you've added a condition to the logic and identified a trigger that will update the affected field. So, if you want to run the script after the user alters a field on the create screen, you should choose the **On change** option.  
      
    For example, initially, you could set the assignee field to Bob, so all new bugs are assigned to them, but if the user changes the priority to High, the assignee would auto-update to Jane.
    
6.  Enter your code within the script box of the **Step 3: Rules** section, as required. Note that you can open the [API documentation](https://docs.adaptavist.com/sr4jc/latest/features/behaviours/behaviours-api) directly from here.   
    
    JSM Behaviours support only one script per Behaviour. If you need to use multiple scripts, you can create a separate Behaviour for each one. This approach makes your Behaviours easier to manage and aligns with our recommended best practice of using one primary use case per Behaviour. Jira Behaviours will soon move to this same single-script model as well.
    
    Alternatively, you can reuse one of the example scripts provided and modify the code as required, ensuring that you:
    
    -   Edit any variables, like custom field names, roles, or groups, in the example code so it's relevant to your instance.
    -   Choose the right time to run your script on load and/or change so that it runs when needed.
    
    To choose an example:   
    1.  Click **Example scripts**, and you are automatically redirected to the [ScriptRunner HQ](https://www.scriptrunnerhq.com/help/example-scripts?ScriptRunner%5BrefinementList%5D%5Bapp%5D%5B0%5D=script-runner-jira&ScriptRunner%5BrefinementList%5D%5Bfeature%5D%5B0%5D=behaviours&ScriptRunner%5BrefinementList%5D%5Bplatform%5D%5B0%5D=cloud) website, where you can view the Behaviours example scripts.
    2.  Choose your preferred script from the examples provided. You also have the option to search for a particular script.  
        
    3.  View the script and click **Copy Cloud script**.
    4.  Return to the script box and paste the copied code into the code editor.  
        
        You can use the **Fullscreen** option to open the code editor in full-screen mode, and click **Exit Fullscreen** to return to the original size.
        
7.  Click **Save and enable** to confirm the configurations for your JSM behaviour, or you can **Cancel**. You also have the option to **Save and disable** the behaviour so that it can be activated another time.  
    

The [Behaviour Logs](https://docs.adaptavist.com/sr4jc/latest/manage-app/review-logs#id-.ReviewLogsvCurrent-BehaviourLogs) allow you to view data related to ScriptRunner for Jira Cloud Behaviours that have run in your Jira instance.

## Modify a Behaviour

Follow the steps below to make changes to existing behaviours in ScriptRunner for Jira Cloud:

1.  Navigate to **ScriptRunner > Behaviours**. A list of previously created behaviours displays, as shown in the example below:  
    ![](/sr4jc/files/latest/574260442/574260448/1/1784542312000/modify+behaviour.png)
2.  Filter the list of behaviours using the options available, including: **Fields**, **Spaces**, **Request Types**, and **View Types**. You can use the search bar to enter a name or UUID, and the list can be sorted by _Name_ and _Jira_ or _JSM_ behaviours_._
3.  Click the **Actions** ellipsis next to your chosen behaviour. From here, you can modify it using the following options:  
    -   _Edit_ - opens the **Edit Behaviour** screen. 
    -   _Copy UUID_ \- copies the UUID, which you can use in the search bar.
    -   _Disable_ - makes the selected behaviour inactive. Disabled behaviours are clearly marked in the list.
    -   _Delete_ - removes the behaviour if it is no longer in use.  
        ![](/sr4jc/files/latest/574260442/574260453/1/1784296913000/list+actions.png)

### Edit a Behaviour  

1.  Click **Edit** from the **Actions** ellipsis next to the behaviour you want to modify.  
    
    Click the Behaviour name to quickly navigate to the **Edit Behaviour** screen without opening the **Actions** ellipsis menu.
    
    The _Edit Behaviour_ screen opens, as shown in the example below:![](/sr4jc/files/latest/574260442/574260444/1/1785336624000/jsm+edit+screen.png)  
    
2.  Scroll through this screen to make your required changes, such as:  
    -   edits to the name and/or description
    -   changes to the selections previously made when creating this behaviour in Step 1 and/or Step 2
    -   editing the script code. JSM Behaviours support only one script per Behaviour. If you need to use multiple scripts, you can create a separate Behaviour for each one.  
        
        It is not possible to convert a JSM Behaviour to a Jira Behaviour when making edits.
        
3.  Click **Save changes** when all modifications are complete. You will see a message confirming that your changes have been successfully saved.

* * *

**Related content:**

-   [Atlassian's UI Modifications Reference Guide](https://developer.atlassian.com/platform/forge/apis-reference/jira-api-bridge/uiModifications/?tabId=1&tab=jira+service+management)
