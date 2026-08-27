# Tutorial: Configure a Confluence Cloud Template

- Platform: connect
- Space: SRC
- Hierarchy: templates
- Doc ID: doc-src-194675500
- Source: https://docs.adaptavist.com/src/latest/templates/tutorial-configure-a-confluence-cloud-template

Follow the steps to configure and run the _Create a Confluence Cloud Page When a Jira Issue is Created_ template.

**Admins only!**

You must have admin privileges to set up the webhook in your Jira Cloud instance (Step 8).

1.  Click **Templates** in the left-hand navigation options.  
    
    **Shortcut for advanced users ⚡**
    
    Alternatively, you can [open the template](https://templates.scriptrunnerconnect.com/template/01GDJJX056X5PD33A919GXAD4R), click **Setup Template** **\> Advanced view**, and skip to Step 5 in this task if you select the advanced view, setup guide instructions are not covered here. 
    
2.  Click **Confluence Cloud**.  
    ![The ](/src/files/latest/194675500/375193928/2/1747770253000/confluence-cloud-templates.png)  
    All templates for Confluence Cloud filter down and appear on the ScriptRunner Connect screen.  
      
    
3.  Click the **Create a Confluence Cloud Page When a Jira Issue is Created** template.   
    A read-only version of the template appears, which includes overview, setup, and usage details.  
      
    
4.  Click **Use** **Template**.  
    ![The ](/src/files/latest/194675500/375193929/1/1746561062000/click-use-template.png)  
    The _New Workspace_ dialog appears.  
      
    
5.  Review and update the **Workspace name**, **Description**, and **Select editor type**, then click **Create**.  
    A success message appears, and the template workspace opens in the Resource Manager, where you can configure API connections before you run the script.  
      
    
6.  Create and authorize a new Confluence Cloud connector in the workspace.
    1.  Click **New API Connection** for Confluence Cloud.  
        ![A ](/src/files/latest/194675500/194675487/1/1695216328000/cc-tutorial-new-API-connection.png)  
        The _Edit API Connection_ dialog appears.  
          
        
    2.  In the **Uses Connector** field dropdown, click **Create New**.  
        The _Manage Connector_ dialog appears.  
          
        
    3.  Enter a name for the connector, then click **Authorize**.  
        ![The ](/src/files/latest/194675500/194675488/1/1695216328000/cc-tutorial-manage-connector.png)  
        A new Atlassian tab opens and prompts you to choose a site (or instance) to authorize and give ScriptRunner Connect proper permissions.  
          
        
    4.  Choose a Confluence site (or instance) to connect to ScriptRunner Connect, then click **Accept**.  
        The Atlassian tab closes, and the _Authorize Confluence Cloud Site_ dialog appears.  
          
        
    5.  In the **Site** field dropdown, reselect the intended Confluence Cloud site or instance, then click **Confirm**.  
        ![The ](/src/files/latest/194675500/194675489/1/1695216328000/cc-tutorial-confirm-new-API.png)  
        The _Manage Connector_ screen reappears, and the save option is active.  
          
        
    6.  Click **Save** to complete the API connector authorization process.   
        ![The ](/src/files/latest/194675500/194675490/1/1695216328000/cc-tutorial-save-manage-connector.png)   
        The _Manage Connector_ dialog closes.
    7.  Click ****Save**** on the _Edit API Connection_ dialog to add the newly authorized API connection to the workspace.  
        ![The ](/src/files/latest/194675500/194675491/1/1695216328000/cc-tutorial-save-API-connection.png)  
        A success message appears.
7.  Configure a Jira Cloud event listener in the workspace.
    1.  Click the **Event Listener** for Jira Cloud.  
        ![The Jira Cloud ](/src/files/latest/194675500/194675492/1/1695216328000/cc-tutorial-event-listener.png)  
        The _Edit Event Listener_ dialog appears.  
          
        
    2.  Ensure the first two fields are as follows:
        1.  **Listener Event Type** is set to _Issue Created_
        2.  **UsesExistingScript** is set to _OnJiraCloudIssueCreated  
              
            _
    3.  In the **Uses Connector** field dropdown, click **Create New**.  
        The _Manage Connector_ dialog appears.
        
        **Does your Jira Cloud event listener already exist?**
        
        If the event listener you want to use already exists, select it and skip to Step 7h.
        
    4.  Enter a name for the connector, then click **Authorize**.  
        ![The ](/src/files/latest/194675500/194675493/1/1695216327000/cc-tutorial-authorize-JC-connector.png)  
        A new Atlassian tab opens and prompts you to choose a site (or instance) to authorize and give ScriptRunner Connect proper permissions.  
          
        
    5.  Choose a Confluence site (or instance) to connect to ScriptRunner Connect, then click **Accept**.  
        The Atlassian tab closes, and the _Authorize Confluence Cloud Site_ dialog appears.  
          
        
    6.  In the **Site** field dropdown, reselect the intended Confluence Cloud site or instance (if necessary), then click **Confirm**.  
        A success message appears. The _Manage Connector_ screen reappears with a service URL, and the save option is active.  
          
        
    7.  Click **Save** to complete the event listener authorization process.  
        A success message appears.  
          
        
    8.  Click **Save** to save the event listener to the workspace.  
        ![The ](/src/files/latest/194675500/194675494/1/1695216327000/cc-tutorial-save-JC-event-listener.png)  
        Instructions to set up the webhook in Jira Cloud appear on the screen.  
          
        
8.  Set up the Jira Cloud webhook by following the instructions in ScriptRunner Connect, then return to ScriptRunner Connect and click **Done**.   
    ![The Event Listener setup instructions for Jira Cloud.](/src/files/latest/194675500/194675495/1/1695216327000/cc-tutorial-webhook-instructions.png)  
    The webhook is complete. 
    
    **ReadMe! 👀**  
    If you ever find yourself lost in a template-setup process, review the ReadMe information for high-level details on how to succeed.  
    ![The ](/src/files/latest/194675500/194675496/1/1695216327000/cc-tutorial-readme.png)
    
9.  Click the **OnJiraCloudIssueCreated** script.  
    ![The ](/src/files/latest/194675500/194675497/1/1695216327000/cc-tutorial-click-script.png)  
      
    
10.  Highlight _TEST_ in the CONFLUENCE\_PAGE parameter, and replace it with the Confluence page key of the parent page you want the new pages to be created under.  
     ![The ](/src/files/latest/194675500/194675498/1/1695216327000/cc-tutorial-script-TEST.png)
     
     **Copying the Confluence Cloud page key 🔑**
     
     In Confluence Cloud, the page key is a string of numbers (and sometimes other characters) in the URL before the page title. Only copy the numbers and characters between the slashes.   
     ![The page key highlighted in the URL.](/src/files/latest/194675500/194675499/1/1695216328000/cc-tutorial-page-key.png)
     
11.  Click **Save** in the Resource Manager to save the script changes.Now a new Confluence child page will be created in your desired Confluence space each time a Jira ticket is created in the connected Jira instance.  
     
     **Make it your own! 🪄**
     
     You can edit the script to further define and customize which details from the Jira ticket are collected onto the Confluence page.
