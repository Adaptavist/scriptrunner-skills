# Add/Remove from/to active sprint

- Platform: data-center
- Space: SR4JS
- Hierarchy: features > workflows > post-functions
- Doc ID: doc-sr4js-442885784
- Source: https://docs.adaptavist.com/sr4js/latest/features/workflows/post-functions/add-remove-from-to-active-sprint

The _Add/remove from sprint_ post function has two complementary parts - you can either add an issue to an active sprint or remove an issue from its current sprint. For example, you can add this post function to a transition, such as _Start Progress_, and configure it to automatically add the issue to the currently active sprint. This practice does not align with traditional Scrum methodology, where sprints are planned in advance, and changes during the sprint are minimized. However, in practice, teams may need to adapt and add work to an active sprint, especially if they complete their commitments early.

In this post function you can set the following:

-   **Condition:** You can enter a condition to define specific criteria that must be met for the post function to execute its action. If no condition is specified, then this post function will always run. If you need help writing your condition, check out the [Scripting tips](https://docs.adaptavist.com/sr4js/latest/best-practices/write-code/scripting-tips) page.
-   **Action:** You can choose whether you want to add or remove issues from a sprint during the chosen workflow transition. 
-   **Board name:** You can specify the name of the board that has the sprint you want to add the issue to. The function will then select the first active sprint from that board to add the issue to. If you choose to remove issue/s from a sprint, no board name is required because you're clearing the sprint association.
-   **Permissions (Act as other user):** To change an issue's sprint, a user must have the _[Schedule Issues](https://confluence.atlassian.com/servicemanagementserver/permissions-overview-939937277.html#Schedule%20Issues:~:text=of%20an%20issue.-,Schedule%20Issues,-Service%20Desk%20Customer)_ permission. The function provides an _Act as other user_ option to determine how the permission is handled:  
    -   **No**: The function will run with the permissions of the current user. Choose this if all your users have the _Schedule Issues_ permission or if you want the function to be ignored for users without permission.
    -   **Yes**: The function will run as if another specified user, who has the _Schedule Issues_ permission, performed the action. This is useful if you want to ensure the action always occurs, regardless of the current user's permissions.
-   **Specified user/s (Return user to execute as):** If you select _Yes_ for the _Act as other user_ option, you must enter a user who will be recorded as having made the change. **The sprint change will appear in the issue's history as if the specified user added the issue to the sprint, which can be essential for maintaining an accurate audit trail.**

## Use this post function

1.  Go to **Administration > Issues > Workflows.**
2.  Select **Edit** on the workflow you want to add a post function to. 
3.  Select the transition you want to add a post function to.
4.  Under **Options**, select **Post Functions.  
    ![](/sr4js/files/latest/442885784/442885786/1/1758746517000/Comment_to_issue_1.png)  
    **
5.  On the _Transition_ page, select **Add post function**.
6.  Select **Add/remove from sprint**.  
    ![Image selecting this post function](/sr4js/files/latest/442885784/442885792/1/1758746518000/Add_remove_sprint_pf.png)  
    
7.  Select **Add**.
8.  Optional: Enter a note that describes the post function (this note is for your reference when viewing all post functions).
9.  Optional: Enter a condition. If no condition is specified, then this post function will always run.
10.  Select whether you want to add or from issues to/from a sprint.
11.  If you chose **Add to sprint** in the previous step, choose a board to add the issue/s to. If you chose **Remove from sprint** in the previous step, it is not necessary to select a board name. 
12.  Select whether you want to act as another user.
13.  If you chose **Yes** in the previous step, enter a user who will be recorded as having made the change. In the example shown, we enter the project lead:
     
     ```
issue.projectObject.projectLead
```
     
     ![](/sr4js/files/latest/442885784/442885790/1/1758746517000/Add_remove_from_to_active_sprint.png)
     
14.  Select **Preview** to see an overview of the change. 
15.  Select **Add**.
     
16.  If applicable, reorder your new post functions using the arrow icons on the right of the function (they can only move one line at a time). Check out our documentation on [Post function order](https://docs.adaptavist.com/sr4js/latest/features/workflows/post-functions/custom-post-functions#post-function-order) for more information. 
     
17.  Select **Publish** and choose if you want to save a backup copy of the workflow.  
     ![](/sr4js/files/latest/442885784/442885788/1/1758746517000/Add_comment_5.png)
     
     You can now test to see if this post function works.
     

  

* * *

## Related content

-   [Post Functions Tutorial](https://docs.adaptavist.com/sr4js/latest/features/workflows/workflow-functions-tutorial/post-functions-tutorial)
-   [Workflows](https://docs.adaptavist.com/sr4js/latest/features/workflows)
-   [Post Functions](https://docs.adaptavist.com/sr4js/latest/features/workflows/post-functions)
