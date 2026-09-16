# Tutorial: Configure a Slack Template

- Platform: connect
- Space: SRC
- Hierarchy: Templates
- Doc ID: doc-src-319a892c-f9b9-43b3-972d-81cee271b979-73bb1ee28a0f56bd
- Source: https://docs.adaptavist.com/src/latest/templates#tutorial-configure-a-slack-template--en

Follow the steps to configure the _Create Jira Cloud issue from Slack using a simple Slack command_ template and trigger the resulting script.

1.  Click Templates in the left-hand navigation options or start your journey from [here](https://templates.scriptrunnerconnect.com/template/01GAV2EZ71F465PD6T49XHFHPA) (click on Setup Template and then skip to step 5 if you select the advanced view, setup guide instructions are not covered here).
2.  Click Slack.
    
    All templates for Slack filter down and appear on the ScriptRunner Connect screen.
    
3.  Click the Create Jira Cloud issue from Slack using a simple Slack command template
    
    A read-only version of the template appears, which includes overview, setup, and usage details.
    
4.  Click Create a Workspace.
    
    The _New Workspace_ dialog appears.
    
5.  Review and update the Workspace name, Description, and Add to a team details, then click Create.
    
    A success message appears, and the template workspace opens in the Resource Manager, where you can configure API connections and event listeners before you run the script.
    
6.  Create and authorize a new Jira Cloud API connector in the workspace.
    1.  Click New API Connection for Jira Cloud.
        
        The _Edit API Connection_ dialog appears.
        
    2.  In the Uses Connector field dropdown, click Create New.
        
        The _Manage Connector_ dialog appears.
        
    3.  Enter a name for the connector, then click Authorize.
        
        A new Atlassian tab opens and prompts you to choose a site (or instance) to authorize and give ScriptRunner Connect proper permissions.
        
    4.  Choose a Jira Cloud site (or instance) to connect to ScriptRunner Connect, then click Accept.
        
        The Atlassian tab closes, and the _Authorize Jira Cloud Site_ dialog appears in ScriptRunner Connect.
        
    5.  In the Site field dropdown, reselect the intended Jira Cloud site or instance, then click Confirm.
        
        The _Manage Connector_ screen reappears, and the save option is active.
        
    6.  Click Save to complete the API connector authorization process.
        
        The _Manage Connector_ dialog closes.
        
    7.  Click Save on the _Edit API Connection_ dialog to add the newly authorized API connection to the workspace.
        
        A success message appears.
        
7.  Configure a Slack API connector in the workspace.
    1.  Click New API Connection for Slack.
        
        The _Edit API Connection_ dialog appears.
        
    2.  In the Uses Connector field dropdown, click Create New.
        
        The _Manage Connector_ dialog appears.
        
    3.  Enter a name for the Slack API connector, then click Configure.
        
        The _Configure Connector_ wizard appears.
        
    4.  Complete the wizard steps in ScriptRunner Connect, then click Done to close the wizard.
        
        The _Configure Connector_ wizard closes, the _Manage Connector_ screen reappears, and the save option is active.
        
    5.  Click Save to complete the API connector authorization process.
        
        The _Manage Connector_ dialog closes.
        
    6.  Click Save on the _Edit API Connection_ dialog to add the newly authorized API connection to the workspace.
        
        A success message appears.
        
8.  Configure a Slack event listener in the workspace.
    1.  Click Slash Command for Slack in the Event Listeners section of the Resource Manager.
        
        The _Edit Event Listener_ dialog appears.
        
    2.  Ensure the first two fields are as follows:
        
        1.  Listener Event Type is set to _Slash Command_
        2.  UsesExistingScript is set to _OnCreateIssueSlackSlashCommand_
        
    3.  In the Uses Connector field dropdown, select the Slack connector you created in Step 7, then click Save.
        
        The _Event Listener Setup Instructions for Slack_ wizard appears.
        
    4.  Complete the wizard steps in ScriptRunner Connect to create a slash command, then click Done to close the wizard.
        
        The _Edit Event Listener_ dialog reappears in ScriptRunner Connect, and the new slash command is complete.
        
9.  Click the OnCreateIssueSlackSlashCommand script.
    
    Important: ReadMe! 👀
    
    If you ever find yourself lost in a template-setup process, review the ReadMe information for high-level details on how to succeed.
    
10.  Highlight _PROJECT_ in the JIRA\_PROJECT\_KEY parameter, and replace it with the project key of the Jira Cloud instance you want the Slack slash command to create new issues within.
     
     You can also change the Jira issue type via the ISSUE\_TYPE\_NAME parameter.
     
11.  Click Save in the Resource Manager to save the script changes.
12.  Navigate to Slack, and invite the new Slack bot to your desired Slack channel.
     1.  In the Slack channel, type `@` followed by the name you gave to the Jira Cloud API connector in Step 6c.
     2.  Then press Enter.
13.  Test the script by using the new slash command.
     1.  In the same Slack channel, type a slash followed by the name of the slash command you defined in Step 8d (wizard Step 4).
     2.  After the slash-command name, type a name for the new Jira Cloud issue you want to create.
         
         For example: `/createissue Test the pay feature`
         
     3.  Press Enter.
         
         The new issue appears in the Jira Cloud project you defined in Step 10.
         
         The ScriptRunner Connect console log presents the script result. For this tutorial, that includes the newly created Jira Cloud issue key.
