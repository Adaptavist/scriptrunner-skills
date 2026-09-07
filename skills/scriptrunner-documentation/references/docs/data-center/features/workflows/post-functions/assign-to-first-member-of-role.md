# Assign to First Member of Role

- Platform: data-center
- Space: SR4JS
- Hierarchy: features > workflows > post-functions
- Doc ID: doc-sr4js-442885869
- Source: https://docs.adaptavist.com/sr4js/latest/features/workflows/post-functions/assign-to-first-member-of-role

The _Assign to first member of role_ post function automatically assigns an issue to the first member of a user role after it transitions. For example, you want to assign a _Tester_ role member to an issue after it transitions from _In Development_ to _In Test_.

This post function selects the first person in alphabetical order from the chosen role. If you want to randomize who is selected, you should use the example provided on the [custom post function](https://docs.adaptavist.com/sr4js/latest/features/workflows/post-functions/custom-post-functions#assign-to-random-role) page.

## Use this post function

1.  Go to **Administration > Issues > Workflows.**
2.  Select **Edit** on the workflow you want to add this post function to. 
3.  Select the transition you want to add this post function to. 
4.  Under **Options**, select **Post Functions.  
    ![](/sr4js/files/latest/442885869/442885875/1/1758746526000/Add_first_role_member_1.png)  
    **
5.  On the _Transition_ page, select **Add post function**.
6.  Select **Assign to first member of role**.  
    ![Image selecting this post function](/sr4js/files/latest/442885869/442885885/1/1758746527000/Assign_first_member_pf.png)  
    
7.  Select **Add**.
8.  Optional: Enter a note that describes the post function (this note is for your reference when viewing all post functions).
9.  Optional: Enter a condition. If no condition is specified, then this post function will always run. 
10.  Select the **Role** of the user to assign. The first person alphabetically in this role is assigned when the issue transitions.
11.  Select **Preview** to see an overview of the change. 
12.  Select **Add**.  
     ![](/sr4js/files/latest/442885869/442885872/1/1758746526000/Assign_first_member_role_3.png)
13.  If applicable, reorder your new post functions using the arrow icons on the right of the function (they can only move one line at a time). Check out our documentation on [Post function order](https://docs.adaptavist.com/sr4js/latest/features/workflows/post-functions/custom-post-functions#post-function-order) for more information.
14.  Select **Publish** and choose if you want to save a backup copy of the workflow.
     
     ![](/sr4js/files/latest/442885869/442885878/1/1758746526000/Assign_first_member_role_4.png)
     
     You can now test to see if this post function works.
     

* * *

## Related content

-   [Post Functions Tutorial](https://docs.adaptavist.com/sr4js/latest/features/workflows/workflow-functions-tutorial/post-functions-tutorial)
-   [Workflows](https://docs.adaptavist.com/sr4js/latest/features/workflows)
-   [Post Functions](https://docs.adaptavist.com/sr4js/latest/features/workflows/post-functions)
