# User(s) Condition

- Platform: data-center
- Space: SR4JS
- Hierarchy: features > workflows > conditions
- Doc ID: doc-sr4js-442885588
- Source: https://docs.adaptavist.com/sr4js/latest/features/workflows/conditions/user-s-condition

The _User(s) condition_ controls whether or not a user/users can transition an issue based on a specified user list.

There are two ways to use this condition, depending on whether you choose to invert the condition or not:

-   **Normal**: The transition is allowed if the current user **is** listed on the condition.  
    
-   **Inverted**: The transition is allowed if the current user **is not** listed on the condition.

For example: 

-   You only want the project manager to be able to move tickets to _To Do_.
-   You have a Bot user on your instance and you want to stop it transitioning a ticket to _Done._

## Use this condition

You can add this condition to any transition except the _Create_ transition.  

1.  Go to **Administration > Issues > Workflows.**
2.  Select **Edit** on the workflow you want to add a condition to. 
3.  Select the transition to which you wish to add a condition.
4.  Under **Options**, select **Conditions.  
    ![Image highlighting the Conditions option](/sr4js/files/latest/442885588/442885590/1/1758746497000/Select_done_transition.png)  
    **
5.  On the _Transition_ page, select **Add condition**.
6.  Select **User(s) condition**.  
    ![](/sr4js/files/latest/442885588/442885592/1/1758746498000/Users_condition_logo.png)  
    
7.  Optional: Enter a note that describes the condition.
8.  Enter at least one **User**.
    
    Users who are listed here can transition the issue unless the **Invert Condition** option has been selected. If the condition is inverted, all users apart from those listed can transition the issue. 
    
9.  Optional: Select **Invert Condition**.
    
    For Jira servers and projects which allow anonymous users to view and transition issues:
    
    -   If the condition is not inverted, anonymous users are always blocked from transitioning the issue.
    -   If the condition is inverted, anonymous users are allowed to transition the issues.
    
10.  Select **Update.**
     
11.  Select **Publish** and choose if you want to save a backup copy of the workflow.  
     ![Image with Publish highlighted](/sr4js/files/latest/442885588/442885589/1/1758746497000/Groups_condition_3.png)
     

  

* * *

## Related content

-   [Conditions Tutorial](https://docs.adaptavist.com/sr4js/latest/features/workflows/workflow-functions-tutorial/conditions-tutorial)
-   [Project Role(s) Condition](https://docs.adaptavist.com/sr4js/latest/features/workflows/conditions/project-role-s-condition)
-   [User in Field(s) Condition](https://docs.adaptavist.com/sr4js/latest/features/workflows/conditions/user-in-field-s-condition)
