# User in Field(s) Validator

- Platform: data-center
- Space: SR4JS
- Hierarchy: features > workflows > validators
- Doc ID: doc-sr4js-442885763
- Source: https://docs.adaptavist.com/sr4js/latest/features/workflows/validators/user-in-field-s-validator

The _User in field(s) validator_ controls if a user can transition an issue based on whether or not they are added in any specified field(s). If a field contains users, the validator checks if the current user is selected. If the field contains groups, the validator checks if the current user is within any of those selected groups. 

There are two ways to use this validator, depending on if you choose to invert the validator or not:

-   **Normal**: The transition is allowed if the current user **is** listed in at least one of the specified fields.  
    
-   **Inverted**: The transition is allowed if the current user **is not** listed in any of the specified fields.

For example:

-   I have a **Hiring Manager** custom field on my recruitment project. I want to ensure only the hiring manager can transition the recruitment ticket to _Offer Accepted_.
-   I have a **Team Members** multi-user picker field auto-populated with a list of all the users in the reporter's team. I want to restrict these users from transitioning the issue to _Escalated_.
    

## Supported fields

The following fields are supported:

-   **Custom fields** - _user picker,_ _multi-user picker,_ _group picker,_ _multi-group picker._
-   **System fields** - _reporter, assignee, watcher, request participants._ 

## Use this validator

1.  Go to **Administration > Issues > Workflows.**
2.  Select **Edit** on the workflow you want to add this validator to. 
3.  Select the transition to which you wish to add this validator to.
4.  Under **Options**, select **Validators.  
    ![](/sr4js/files/latest/442885763/442885766/1/1758746513000/User_in_field_validator_1.png)  
    **
5.  On the _Transition_ page, select **Add validator**.
6.  Select **User in field(s) validator**.  
    ![Image of the validator selected](/sr4js/files/latest/442885763/442885767/1/1758746513000/User_in_field_v_logo.png)  
    
7.  Optional: Enter a note that describes the validator (this note is for your reference when viewing all validators).
8.  Select one or more **User** **Field(s).** 
    
    Only users added in any of these fields are able to transition the issue. If inverted, users added in the specified fields will not be able to transition the issue. 
    
    If your transition includes a screen, make sure your selected fields are on the transition screen this validator applies to. **This validator will check field values even if they are not on the screen.**
    
9.  Optional: Select **Invert**.
    
    For Jira servers and projects which allow anonymous users to view and transition issues:
    
    -   If the validator is not inverted, anonymous users are always blocked from transitioning the issue.
    -   If the validator is inverted, anonymous users are allowed to transition the issues.
    
10.  Enter an **Error message** to display if the user is/is not in the chosen field(s).Select **Update.**
11.  Select **Publish** and choose if you want to save a backup copy of the workflow.  
     ![Image with Publish highlighted](/sr4js/files/latest/442885763/442885764/1/1758746513000/Groups_condition_3.png)
     

  

* * *

## Related content

-   [Validators Tutorial](https://docs.adaptavist.com/sr4js/latest/features/workflows/workflow-functions-tutorial/validators-tutorial)
-   [Workflows](https://docs.adaptavist.com/sr4js/latest/features/workflows)
-   [Validators](https://docs.adaptavist.com/sr4js/latest/features/workflows/validators)
