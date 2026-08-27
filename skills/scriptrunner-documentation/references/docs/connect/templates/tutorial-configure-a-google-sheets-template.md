# Tutorial: Configure a Google Sheets Template

- Platform: connect
- Space: SRC
- Hierarchy: templates
- Doc ID: doc-src-194675536
- Source: https://docs.adaptavist.com/src/latest/templates/tutorial-configure-a-google-sheets-template

Follow the steps to configure the _Export users from Jira Cloud to Google Sheets_ template and trigger the resulting script.

1.  Click **Templates** in the left-hand navigation options or start your journey from [here](https://templates.scriptrunnerconnect.com/template/01GB5H96JCR9N251QDQ6C7SA41) (click on **Setup Template** and then skip to step 5 if you select the advanced view, setup guide instructions are not covered here). 
2.  Click **Google Sheets**.  
    ![A screenshot highlighting the path from ](/src/files/latest/194675536/375193931/1/1747770081000/click-to-google-sheets-templates.png)  
    All templates for Google Sheets filter down and appear on the ScriptRunner Connect screen.  
      
    
3.  Click the **Export users from Jira Cloud to Google Sheets** template.   
    A read-only version of the template appears, which includes overview, setup, and usage details.  
      
    
4.  Click **Create a Workspace**.  
    ![The ](/src/files/latest/194675536/194512958/1/1695310140000/click-create-a-workspace-src.png)  
    The _New Workspace_ dialog appears.  
      
    
5.  Review and update the **Workspace name**, **Description**, and **Add to a team** details, then click **Create**.  
    A success message appears, and the template workspace opens in the Resource Manager, where you can configure API connections before you run the script.  
      
    
6.  Create and authorize a new Google Sheets API connector in the workspace.
    1.  Click **New API Connection** for Google Sheets.  
        ![The ](/src/files/latest/194675536/194675527/1/1695216505000/new-API-connection.png)  
        The _Edit API Connection_ dialog appears.  
          
        
    2.  In the **Uses Connector** field dropdown, click **Create New**.  
        The Manage Connector dialog appears.  
          
        
    3.  Enter a name for the connector, then click **Sign in Authorize with Google**.  
        ![The ](/src/files/latest/194675536/194675528/1/1695216505000/click-auth-with-google.png)  
        Google opens a new tab and prompts you to choose an account to grant ScriptRunner Connect the proper permissions.  
          
        
    4.  Choose a Google account to connect to ScriptRunner Connect, then click **Allow**.  
        ![The ](/src/files/latest/194675536/261981364/1/1718049994000/google-auth-light.png)  
        The Google tab closes, a success message appears, and the new Google Sheets API connector is authorized.  
          
        
    5.  Click **Save** to complete the API connector authorization process.   
        The _Manage Connector_ dialog closes.  
          
        
    6.  Click **Save** on the _Edit API Connection_ dialog to add the newly authorized API connection to the workspace.  
        ![The ](/src/files/latest/194675536/194675530/1/1695216505000/add-Google-Sheets-connector.png)  
        A success message appears.  
          
        
7.  Create and authorize a new Jira Cloud connector in the workspace.
    1.  Click **New API Connection** for Jira Cloud.  
        ![The ](/src/files/latest/194675536/194675531/1/1695216505000/click-new-API-connection-Jira.png)  
        The _Edit API Connection_ dialog appears.  
          
        
    2.  In the **Uses Connector** field dropdown, click **Create New**.  
        The _Manage Connector_ dialog appears.  
          
        
    3.  Enter a name for the connector, then click **Authorize**.  
        ![The ](/src/files/latest/194675536/194675532/1/1695216505000/click-auth-jira-cloud.png)  
        A new Atlassian tab opens and prompts you to choose a site (or instance) to authorize and give ScriptRunner Connect proper permissions.  
          
        
    4.  Choose a Jira site (or instance) to connect to ScriptRunner Connect, then click **Accept**.  
        The Atlassian tab closes, and the _Authorize Jira Cloud Site_ dialog appears.  
          
        
    5.  In the **Site** field dropdown, reselect the intended Jira Cloud site or instance, then click **Confirm**.  
        A success message also appears.  
        The _Manage Connector_ screen reappears, and the save option is active.  
          
        
    6.  Click **Save** to complete the Jira Cloud API connector authorization process.   
        The _Manage Connector_ dialog closes.  
          
        
    7.  Click **Save** on the _Edit API Connection_ dialog to add the newly authorized API connection to the workspace.  
        ![The ](/src/files/latest/194675536/194675533/1/1695216506000/add-jira-cloud-api-to-workspace.png)  
        A success message appears.   
          
        
8.  Click **ExportUsers** to view the script, then trigger the script manually by clicking one of the two trigger buttons in the Resource Manager.   
    ![The ](/src/files/latest/194675536/194675534/1/1695216505000/trigger-Google-Sheets-script.png)  
      
    The console log presents the script result. For this tutorial, you can retrieve your Google Sheets data from your Google Drive.  
    ![The console log, showing a successful execution of the script. ](/src/files/latest/194675536/194675535/1/1695216505000/export-success.png)
