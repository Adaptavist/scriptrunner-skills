# Example: Get Jira Issue Information on a Confluence Page

- Platform: confluence-cloud
- Space: SR4CC
- Hierarchy: Features > Macros > Custom Macros
- Doc ID: doc-sr4cc-f434c6ed-8731-46c9-b70e-dcb602777e8d-5e73fc15544b1449
- Source: https://docs.adaptavist.com/sr4cc/latest/features/macros/custom-macros#example-get-jira-issue-information-on-a-confluence-page--en

Information on creating a macro that will pull Jira issue information onto a specified Confluence page.

You can create a macro to pull Jira issue information onto your Confluence page.

## Create the macro

1.  Select Create Custom Macro.
2.  Enter a Name to identify the Macro, like _Jira_ _Issue Information_.
3.  Enter an optional Description, like _Get the issue ID and issue summary on your Confluence page_.
4.  Select Enabled to allow the macro to be added to pages.
5.  Select _None_ for Body Type.
6.  Pick _Block_ for Output Type.
    
7.  Enter the following script into the Script to Execute field:
    
    ```
    def issue = get("/rest/api/3/issue/${parameters.issueID}")
    .asObject(Map)
    .body
      
    String text = "<H1>project name "+issue.fields.project.name+"</H1><br>" +
                  "<H3>issue ID ${issue.key} </h2> <br>" +
                  "<H3>issue Summary : ${issue.fields.summary} </h2>"
      
    return text
    ```
    
    Note: Access custom field values
    
    If you want to access custom field values from a Jira issue and return the info back on a Confluence page, use the example code below:
    
    ```
    String text = "<H1>project name "+issue.fields.project.name+"</H1><br>" +
    "<H3>issue ID ${issue.key} </H3> <br>" +
    "<H3>issue Summary : ${issue.fields.summary} </H3>" +
    "<H3>Multi select custom field value : ${issue.fields.customfield_10073.value} </H3>" +
    "<H3>Single Line text custom field value : ${issue.fields.customfield_10082} </H3>"
    ```
    
8.  Select Add Parameter.
    
    -   When the window appears, fill out the following fields:
        1.  Type: _String_
        2.  Name: _issueID_
        3.  Description ID: _Issue ID_
    -   Check the box for Required.
        
    -   Click Save.
        
    

The macro immediately appears on the main _Macros_ page:

Users in your instance can now add it to Confluence pages. When it's added, the user sees the issueID parameter, where they enter the issue ID.

Once an issue ID is added to the field and the page is saved, the macro appears like this:
