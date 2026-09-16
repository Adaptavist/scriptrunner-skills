# Tutorial: Configure a Confluence Cloud Template

- Platform: connect
- Space: SRC
- Hierarchy: Templates
- Doc ID: doc-src-843b3aba-7a97-49c9-a160-0be677e81153-a9cdf136de3182f2
- Source: https://docs.adaptavist.com/src/latest/templates#tutorial-configure-a-confluence-cloud-template--en

Follow the steps to configure and run the _Create a Confluence Cloud Page When a Jira Issue is Created_ template.

Important: Admins only!

You must have admin privileges to set up the webhook in your Jira Cloud instance (Step 8).

1.  Click Templates in the left-hand navigation options.
    
    Tip: Shortcut for advanced users ⚡
    
    Alternatively, you can [open the template](https://templates.scriptrunnerconnect.com/template/01GDJJX056X5PD33A919GXAD4R), click Setup Template > Advanced view, and skip to Step 5 in this task if you select the advanced view, setup guide instructions are not covered here.
    
2.  Click Confluence Cloud.
    
    All templates for Confluence Cloud filter down and appear on the ScriptRunner Connect screen.
    
3.  Click the Create a Confluence Cloud Page When a Jira Issue is Created template.
    
    A read-only version of the template appears, which includes overview, setup, and usage details.
    
4.  Click Use Template.
    
    The _New Workspace_ dialog appears.
    
5.  Review and update the Workspace name, Description, and Select editor type, then click Create.
    
    A success message appears, and the template workspace opens in the Resource Manager, where you can configure API connections before you run the script.
    
6.  Create and authorize a new Confluence Cloud connector in the workspace.
    1.  Click New API Connection for Confluence Cloud.
        
        The _Edit API Connection_ dialog appears.
        
    2.  In the Uses Connector field dropdown, click Create New.
        
        The _Manage Connector_ dialog appears.
        
    3.  Enter a name for the connector, then click Authorize.
        
        A new Atlassian tab opens and prompts you to choose a site (or instance) to authorize and give ScriptRunner Connect proper permissions.
        
    4.  Choose a Confluence site (or instance) to connect to ScriptRunner Connect, then click Accept.
        
        The Atlassian tab closes, and the _Authorize Confluence Cloud Site_ dialog appears.
        
    5.  In the Site field dropdown, reselect the intended Confluence Cloud site or instance, then click Confirm.
        
        The _Manage Connector_ screen reappears, and the save option is active.
        
    6.  Click Save to complete the API connector authorization process.
        
        The _Manage Connector_ dialog closes.
        
    7.  Click Save on the _Edit API Connection_ dialog to add the newly authorized API connection to the workspace.
        
        A success message appears.
        
7.  Configure a Jira Cloud event listener in the workspace.
    1.  Click the Event Listener for Jira Cloud.
        
        The _Edit Event Listener_ dialog appears.
        
    2.  Ensure the first two fields are as follows:
        
        1.  Listener Event Type is set to _Issue Created_
        2.  UsesExistingScript is set to _OnJiraCloudIssueCreated_
        
    3.  In the Uses Connector field dropdown, click Create New.
        
        The _Manage Connector_ dialog appears.
        
        Note: Does your Jira Cloud event listener already exist?
        
        If the event listener you want to use already exists, select it and skip to Step 7h.
        
    4.  Enter a name for the connector, then click Authorize.
        
        A new Atlassian tab opens and prompts you to choose a site (or instance) to authorize and give ScriptRunner Connect proper permissions.
        
    5.  Choose a Confluence site (or instance) to connect to ScriptRunner Connect, then click Accept.
        
        The Atlassian tab closes, and the _Authorize Confluence Cloud Site_ dialog appears.
        
    6.  In the Site field dropdown, reselect the intended Confluence Cloud site or instance (if necessary), then click Confirm.
        
        A success message appears. The _Manage Connector_ screen reappears with a service URL, and the save option is active.
        
    7.  Click Save to complete the event listener authorization process.
        
        A success message appears.
        
    8.  Click Save to save the event listener to the workspace.
        
        Instructions to set up the webhook in Jira Cloud appear on the screen.
        
8.  Set up the Jira Cloud webhook by following the instructions in ScriptRunner Connect, then return to ScriptRunner Connect and click Done.
    
    The webhook is complete.
    
    Note: ReadMe! 👀
    
    If you ever find yourself lost in a template-setup process, review the ReadMe information for high-level details on how to succeed.
    
9.  Click the OnJiraCloudIssueCreated script.
    
10.  Highlight _TEST_ in the CONFLUENCE\_PAGE parameter, and replace it with the Confluence page key of the parent page you want the new pages to be created under.
     
     Tip: Copying the Confluence Cloud page key 🔑
     
     In Confluence Cloud, the page key is a string of numbers (and sometimes other characters) in the URL before the page title. Only copy the numbers and characters between the slashes.
     
11.  Click Save in the Resource Manager to save the script changes.
     
     Now a new Confluence child page will be created in your desired Confluence space each time a Jira ticket is created in the connected Jira instance.
     
     Tip: Make it your own! 🪄
     
     You can edit the script to further define and customize which details from the Jira ticket are collected onto the Confluence page.
