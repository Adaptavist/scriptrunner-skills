# Tutorial: Configure a Google Sheets Template

- Platform: connect
- Space: SRC
- Hierarchy: Templates
- Doc ID: doc-src-21b6b375-5702-4d11-9141-d34a61383239-15bc7c84224535b1
- Source: https://docs.adaptavist.com/src/latest/templates#tutorial-configure-a-google-sheets-template--en

Follow the steps to configure the _Export users from Jira Cloud to Google Sheets_ template and trigger the resulting script.

1.  Click Templates in the left-hand navigation options or start your journey from [here](https://templates.scriptrunnerconnect.com/template/01GB5H96JCR9N251QDQ6C7SA41) (click on Setup Template and then skip to step 5 if you select the advanced view, setup guide instructions are not covered here).
2.  Click Google Sheets.
    
    All templates for Google Sheets filter down and appear on the ScriptRunner Connect screen.
    
3.  Click the Export users from Jira Cloud to Google Sheets template.
    
    A read-only version of the template appears, which includes overview, setup, and usage details.
    
4.  Click Create a Workspace.
    
    The _New Workspace_ dialog appears.
    
5.  Review and update the Workspace name, Description, and Add to a team details, then click Create.
    
    A success message appears, and the template workspace opens in the Resource Manager, where you can configure API connections before you run the script.
    
6.  Create and authorize a new Google Sheets API connector in the workspace.
    1.  Click New API Connection for Google Sheets.
        
        The _Edit API Connection_ dialog appears.
        
    2.  In the Uses Connector field dropdown, click Create New.
        
        The Manage Connector dialog appears.
        
    3.  Enter a name for the connector, then click Sign in Authorize with Google.
        
        Google opens a new tab and prompts you to choose an account to grant ScriptRunner Connect the proper permissions.
        
    4.  Choose a Google account to connect to ScriptRunner Connect, then click Allow
        
        The Google tab closes, a success message appears, and the new Google Sheets API connector is authorized.
        
    5.  Click Save to complete the API connector authorization process.
        
        The _Manage Connector_ dialog closes.
        
    6.  Click Save on the _Edit API Connection_ dialog to add the newly authorized API connection to the workspace.
        
        A success message appears.
        
7.  Create and authorize a new Jira Cloud connector in the workspace.
    1.  Click New API Connection for Jira Cloud.
        
        The _Edit API Connection_ dialog appears.
        
    2.  In the Uses Connector field dropdown, click Create New.
        
        The _Manage Connector_ dialog appears.
        
    3.  Enter a name for the connector, then click Authorize.
        
        A new Atlassian tab opens and prompts you to choose a site (or instance) to authorize and give ScriptRunner Connect proper permissions.
        
    4.  Choose a Jira site (or instance) to connect to ScriptRunner Connect, then click Accept.
        
        The Atlassian tab closes, and the _Authorize Jira Cloud Site_ dialog appears.
        
    5.  In the Site field dropdown, reselect the intended Jira Cloud site or instance, then click Confirm.
        
        A success message also appears. The _Manage Connector_ screen reappears, and the save option is active.
        
    6.  Click Save to complete the Jira Cloud API connector authorization process.
        
        The _Manage Connector_ dialog closes.
        
    7.  Click Save on the _Edit API Connection_ dialog to add the newly authorized API connection to the workspace.
        
        A success message appears.
        
8.  Click ExportUsers to view the script, then trigger the script manually by clicking one of the two trigger buttons in the Resource Manager.
    
    The console log presents the script result. For this tutorial, you can retrieve your Google Sheets data from your Google Drive.
