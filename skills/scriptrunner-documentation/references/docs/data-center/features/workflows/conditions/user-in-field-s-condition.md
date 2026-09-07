# User in Field(s) Condition

- Platform: data-center
- Space: SR4JS
- Hierarchy: features > workflows > conditions
- Doc ID: doc-sr4js-442885604
- Source: https://docs.adaptavist.com/sr4js/latest/features/workflows/conditions/user-in-field-s-condition

The _User in field(s) condition_ controls if a user can transition an issue based on whether or not they are in any specified field(s). If a field contains users, the condition checks if the current user is selected. If the field contains groups, the condition checks if the current user is within any of those selected groups. 

There are two ways to use this condition, depending on whether you choose to invert the condition or not:

-   **Normal**: The transition is allowed if the current user **is** listed in at least one of the specified fields.  
    
-   **Inverted**: The transition is allowed if the current user **is not** listed in any of the specified fields.

For example:

-   I have a **Hiring Manager** custom field on my recruitment project. I want to ensure only the hiring manager can transition the recruitment ticket to _Offer Accepted_.
-   I have a **Team Members** multi-user picker field auto-populated with a list of all the users in the reporter's team. I want to restrict these users from transitioning the issue to _Escalated_.
    

## Supported fields

The following fields are supported:

-   **Custom fields** - _user picker,_ _multi-user picker,_ _group picker,_ _multi-group picker._
-   **System fields** - _reporter, assignee, watcher, request participants._ 

## Use this condition

You can add this condition to any transition except the _Create_ transition.  

1.  Go to **Administration > Issues > Workflows.**
2.  Select **Edit** on the workflow you want to add a condition to. 
3.  Select the transition to which you wish to add a condition.
4.  Under **Options**, select **Conditions.  
    ![Image highlighting the Conditions option](/sr4js/files/latest/442885604/442885608/1/1758746499000/Select_done_transition.png)  
    **
5.  On the _Transition_ page, select **Add condition**.
6.  Select **User in field(s) condition**.  
    ![](/sr4js/files/latest/442885604/442885610/1/1758746499000/User_in_field_logo.png)  
    
7.  Optional: Enter a note that describes the condition.
    
8.  Enter one or more **User** ****F**ield(s).** 
    
    Only users added in any of these fields are able to transition the issue. If inverted, users added in the specified fields will not be able to transition the issue. 
    
    Make sure your selected fields are on the screen for the project(s) your condition applies. **This condition function will check field values even if they are not on the screen.**
    
9.  Optional: Select **Invert Condition**.
    
    For Jira servers and projects which allow anonymous users to view and transition issues:
    
    -   If the condition is not inverted, anonymous users are always blocked from transitioning the issue.
    -   If the condition is inverted, anonymous users are allowed to transition the issues.
    
10.  Select **Update.**
     
11.  Select **Publish** and choose if you want to save a backup copy of the workflow.  
     ![Image with Publish highlighted](/sr4js/files/latest/442885604/442885605/1/1758746499000/Groups_condition_3.png)

  

* * *

## Related content

-   [Conditions Tutorial](https://docs.adaptavist.com/sr4js/latest/features/workflows/workflow-functions-tutorial/conditions-tutorial)
-   [Project Role(s) Condition](https://docs.adaptavist.com/sr4js/latest/features/workflows/conditions/project-role-s-condition)
-   [User(s) Condition](https://docs.adaptavist.com/sr4js/latest/features/workflows/conditions/user-s-condition)
