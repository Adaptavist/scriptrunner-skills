# Example: Get Jira Issue Information on a Confluence Page

- Platform: confluence-cloud
- Space: SR4CC
- Hierarchy: features > macros > custom-macros
- Doc ID: doc-sr4cc-246187358
- Source: https://docs.adaptavist.com/sr4cc/latest/features/macros/custom-macros/example-get-jira-issue-information-on-a-confluence-page

You can create a macro to pull Jira issue information onto your Confluence page.

## Create the macro

1.  Select the **Settings** cog in the top right-hand corner of the screen. 
2.  Select **Macros** under _ScriptRunner_. 
3.  Select **Create Custom Macro**. 
4.  Enter a **Name** to identify the Macro, like _Jira_ _Issue Information_.
5.  Enter an optional **Description**, like _Get the issue ID and issue summary on your Confluence page_. 
6.  Select **Enabled** to allow the macro to be added to pages. 
7.  Select _None_ for **Body Type.** 
8.  Pick _Block_ for **Output Type**.   
    ![](/sr4cc/files/latest/246187358/246187365/1/1710873661000/issue-information-macro.png)
9.  Enter the following script into the **Script to Execute** field: 
    
    ```
def issue = get("/rest/api/3/issue/${parameters.issueID}")
.asObject(Map)
.body
  
String text = "<H1>project name "+issue.fields.project.name+"</H1><br>" +
              "<H3>issue ID ${issue.key} </H3> <br>" +
              "<H3>issue Summary : ${issue.fields.summary} </H3>"
  
return text
```
    
    Access custom field values
    
    If you want to access custom field values from a Jira issue and return the info back on a Confluence page, use the example code below:
    
    ```
String text = "<H1>project name "+issue.fields.project.name+"</H1><br>" +
"<H3>issue ID ${issue.key} </H3> <br>" +
"<H3>issue Summary : ${issue.fields.summary} </H3>" +
"<H3>Multi select custom field value : ${issue.fields.customfield_10073.value} </H3>" +
"<H3>Single Line text custom field value : ${issue.fields.customfield_10082} </H3>"
```
    
      
    
10.  Select **Add Parameter**. 
     1.  When the window appears, fill out the following fields: 
         1.  **Type**: _String_
         2.  **Name**: _issueID_
         3.  **Description ID**: _Issue ID_
     2.  Check the box for **Required**.
     3.  Click **Save**.  
         ![](/sr4cc/files/latest/246187358/246187360/1/1711567840000/edit-macro-parameter.png)  
         
11.  Select **Save**.

The macro immediately appears on the main _Macros_ page:

![](/sr4cc/files/latest/246187358/246187364/1/1710873998000/jira-issue-macro-page.png)

Users in your instance can now add it to Confluence pages. When it's added, the user sees the **issueID** parameter, where they enter the issue ID. 

![](/sr4cc/files/latest/246187358/246187363/1/1710874267000/add-parameter-in-use.png)

Once an issue ID is added to the field and the page is saved, the macro appears like this: 

![](/sr4cc/files/latest/246187358/246187362/1/1710874469000/issue-id-result.png)
