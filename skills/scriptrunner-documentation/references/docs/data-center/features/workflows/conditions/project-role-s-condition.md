# Project Role(s) Condition

- Platform: data-center
- Space: SR4JS
- Hierarchy: features > workflows > conditions
- Doc ID: doc-sr4js-442885532
- Source: https://docs.adaptavist.com/sr4js/latest/features/workflows/conditions/project-role-s-condition

Use the _Project role(s)_ condition to control whether or not a user can transition an issue based on their [project role memberships](https://confluence.atlassian.com/adminjiraserver/managing-project-role-membership-938847171.html).

There are two ways to use this condition, depending on whether you choose to invert the condition or not:

-   **Normal:** The transition is allowed if the current user **is** a member of any project role(s) specified.  
    
-   **Inverted:** The transition is allowed if the current user **is not** a member of any project role(s) specified. 

For example: 

-   You only want members of the _Developers_ project role to be able to transition a ticket to _In progress._
-   You do not want members of the _Project Managers_ role to be able to transition a ticket to _To do._

## Use this condition

You can add this condition to any transition except the _Create_ transition.  

1.  Go to **Administration > Issues > Workflows.**
2.  Select **Edit** on the workflow you want to add a condition to. 
3.  Select the transition to which you wish to add a condition.
4.  Under **Options**, select **Conditions.  
    ![Image highlighting the Conditions option](/sr4js/files/latest/442885532/442885535/1/1758746493000/Select_done_transition.png)  
    **
5.  On the _Transition_ page, select **Add condition**.
6.  Select **Project role(s) condition**.  
    ![](/sr4js/files/latest/442885532/442885536/1/1758746493000/Project_roles_logo.png)
    
7.  Optional: Enter a note that describes the condition.
8.  Enter the **Project roles** you want to use to restrict the transition.
    
    Users who are members of at least one of these project roles can transition the issue, unless the **Invert condition** option has been selected. If the condition is inverted, all users apart from those who are members of at least one of these project roles can transition the issue. 
    
9.  Optional: Select **Invert Condition**.
    
    For Jira servers and projects which allow anonymous users to view and transition issues:
    
    -   If the condition is not inverted, anonymous users are always blocked from transitioning the issue.
    -   If the condition is inverted, anonymous users are allowed to transition the issues.
    
10.  Select **Update.**
     
11.  Select **Publish** and choose if you want to save a backup copy of the workflow.  
     ![Image with Publish highlighted](/sr4js/files/latest/442885532/442885534/1/1758746493000/Groups_condition_3.png)
     
       
     

* * *

## Related content

-   [Conditions Tutorial](https://docs.adaptavist.com/sr4js/latest/features/workflows/workflow-functions-tutorial/conditions-tutorial)
-   [Group(s) Condition](https://docs.adaptavist.com/sr4js/latest/features/workflows/conditions/group-s-condition)
-   [Simple Scripted Condition](https://docs.adaptavist.com/sr4js/latest/features/workflows/conditions/simple-scripted-condition)
