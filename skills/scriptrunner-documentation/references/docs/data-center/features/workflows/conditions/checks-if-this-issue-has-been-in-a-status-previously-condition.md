# Checks if this Issue has Been in a Status Previously Condition

- Platform: data-center
- Space: SR4JS
- Hierarchy: features > workflows > conditions
- Doc ID: doc-sr4js-442885380
- Source: https://docs.adaptavist.com/sr4js/latest/features/workflows/conditions/checks-if-this-issue-has-been-in-a-status-previously-condition

This condition checks whether the issue has ever been in the selected status at some point or immediately before the current status (the current status is the status at the start of the transition you're applying this condition to). For example, you could use this condition to ensure a support ticket cannot be closed if it has never been with a customer service agent. This can be particularly useful when you have global transitions.

## Use this condition

1.  Go to **Administration > Issues > Workflows.**
2.  Select **Edit** on the workflow you want to add a condition to. 
3.  Select the transition to which you wish to add a condition.
4.  Under **Options**, select **Conditions.  
    **
5.  On the _Transition_ page, select **Add condition**.
6.  Select **Checks the issue has been in a status previously**.  
    ![](/sr4js/files/latest/442885380/442885401/1/1758746483000/Checks+the+issue+has+been+in+a+status+previously+logo.png)  
    
7.  Select **Add**.
8.  Optional: Enter a note that describes the condition.
9.  Select previous status. This is the status the issue must have been in before the issue is permitted to transition. 
10.  Optional: Select the **Immediately previous only** checkbox. Select this option if you want the condition only to apply when the issue has been in the chosen status immediately before the current status. The current status is the status at the start of the transition you're applying this condition to.
11.  Select **Preview** to see an overview of the change. 
12.  Select **Update**.  
     
13.  Select **Publish** and choose if you want to save a backup copy of the workflow.
     
     You can now test to see if this workflow condition works.
