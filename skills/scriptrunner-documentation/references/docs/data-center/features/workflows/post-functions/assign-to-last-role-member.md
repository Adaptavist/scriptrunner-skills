# Assign to Last Role Member

- Platform: data-center
- Space: SR4JS
- Hierarchy: features > workflows > post-functions
- Doc ID: doc-sr4js-442885899
- Source: https://docs.adaptavist.com/sr4js/latest/features/workflows/post-functions/assign-to-last-role-member

The _Assign to last role member_ post function assigns the issue to the last user assigned to that issue with a specific role. For example, **Developer A** finishes working on an issue and marks it as _Ready to Test_. After it transitions, the issue is automatically assigned to **Tester B**. **Tester B** rejects the issue, and it returns to the development team. The last user assigned in the development role is re-assigned to the issue (**Developer A**). The developer can then fix the issue and transition it back to the QA team. When they do, the issue is re-assigned to **Tester B** (the last user in the tester role).

## Use this post function

1.  Go to **Administration > Issues > Workflows.**
2.  Select **Edit** on the workflow you want to add this post function to. 
3.  Select the transition you want to add this post function to. 
4.  Under **Options**, select **Post Functions.  
    ![](/sr4js/files/latest/442885899/442885901/1/1758746528000/Add_first_role_member_1.png)  
    **
5.  On the _Transition_ page, select **Add post function**.
6.  Select **Assign to last role member**.  
    ![Image selecting this post function](/sr4js/files/latest/442885899/442885918/1/1758746529000/Assign_last_member_pf.png)  
    
7.  Select **Add**.
8.  Optional: Enter a note that describes the post function (this note is for your reference when viewing all post functions).
9.  Optional: Enter a condition. If no condition is specified, then this post function will always run. 
10.  Select the **Role** of the user to assign. The last user assigned from this role is re-assigned when the issue transitions.  
     
     If an issue has never had a user assigned to it, it will remain unassigned. In addition, if an issue has never been assigned to a user with the given _Role_, the _Assignee_ will not be modified.
     
11.  Optional: Check the following options:
     
     1.  **Include Reporter** to include the reporter in the list of assignees available to re-assign.
     2.  **Include Current Assignee** to include the current assignee in the list of assignees available to re-assign.
     3.  **Force Assignment** to assign a user even if an assignee has been specified in the transition screen.  
         
         The issue will only reassign to these users if the following are true:
         
         -   There are no previous assignees with the correct role. Previously assigned users take priority.
         -   The reporter/current assignee have the desired role.
         
           
         
12.  Select **Preview** to see an overview of the change. 
13.  Select **Add**.  
     ![](/sr4js/files/latest/442885899/442885910/1/1758746529000/Assign_to_last_role_member.png)
     
14.  If applicable, reorder your new post functions using the arrow icons on the right of the function (they can only move one line at a time). Check out our documentation on [Post function order](https://docs.adaptavist.com/sr4js/latest/features/workflows/post-functions/custom-post-functions#post-function-order) for more information.
     
15.  Select **Publish** and choose if you want to save a backup copy of the workflow.
     
     ![](/sr4js/files/latest/442885899/442885904/1/1758746528000/Assign_first_member_role_4.png)
     
     You can now test to see if this post function works.
     

* * *

## Related content

-   [Post Functions Tutorial](https://docs.adaptavist.com/sr4js/latest/features/workflows/workflow-functions-tutorial/post-functions-tutorial)
-   [Workflows](https://docs.adaptavist.com/sr4js/latest/features/workflows)
-   [Post Functions](https://docs.adaptavist.com/sr4js/latest/features/workflows/post-functions)
