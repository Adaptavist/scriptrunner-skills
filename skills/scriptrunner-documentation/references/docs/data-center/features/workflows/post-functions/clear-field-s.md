# Clear Field(s)

- Platform: data-center
- Space: SR4JS
- Hierarchy: features > workflows > post-functions
- Doc ID: doc-sr4js-442885216
- Source: https://docs.adaptavist.com/sr4js/latest/features/workflows/post-functions/clear-field-s

The _Clear field(s)_ post function clears the selected fields when an issue is transitioned to another status.

For example, after an issue transitions from _In Development_ to _With QA,_ you may want to clear the _Time Estimate_ field so the new team can add an accurate time estimation for this stage. 

This post function should be positioned before any other field update post functions. For example, if you have the [Set Issue Security](https://docs.adaptavist.com/sr4js/latest/features/workflows/post-functions/set-issue-security), or [Assign to Last Role Member](https://docs.adaptavist.com/sr4js/latest/features/workflows/post-functions/assign-to-last-role-member) post function on the same transition, these should trigger after the Clear Field(s) post function.

## Use this post function

1.  Go to **Administration > Issues > Workflows.**
2.  Select **Edit** on the workflow you want to add this post function to. 
3.  Select the transition you want to add this post function to.
4.  Under **Options**, select **Post Functions.  
    ![](/sr4js/files/latest/442885216/442885224/1/1758746469000/Clear_fields_1.png)  
    **
5.  On the _Transition_ page, select **Add post function**.
6.  Select **Clear field(s)**.  
    ![Image selecting this post function](/sr4js/files/latest/442885216/442885225/1/1758746469000/Clear_fields_pf.png)  
    
7.  Select **Add**.
8.  Optional: Enter a note that describes the post function (this note is for your reference when viewing all post functions).
9.  Optional: Enter a condition. For example, you can enter a condition to make sure the field(s) only clear when the user transitioning an issue is part of a certain group. If no condition is specified, then this post function will always run. 
10.  Select the field(s) you want to clear when an issue is transitioned.   
     ![](/sr4js/files/latest/442885216/442885222/1/1758746469000/CLear_fields_3.png) 
11.  Select **Preview** to see an overview of the change.
12.  Select **Add**.
13.  If applicable, reorder your new post functions using the arrow icons on the right of the function (they can only move one line at a time).  
     
     This post function should be positioned before any other field update post functions. Check out our documentation on [Post function order](https://docs.adaptavist.com/sr4js/latest/features/workflows/post-functions/custom-post-functions#post-function-order) for more information.
     
14.  Select **Publish** and choose if you want to save a backup copy of the workflow.
     
     ![](/sr4js/files/latest/442885216/442885221/1/1758746469000/Clear_fields_4.png)
     
     Test your post function
     
     You can now test to see if this post function works.
     

  

* * *

## Related content

-   [Post Functions Tutorial](https://docs.adaptavist.com/sr4js/latest/features/workflows/workflow-functions-tutorial/post-functions-tutorial)
-   [Workflows](https://docs.adaptavist.com/sr4js/latest/features/workflows)
-   [Post Functions](https://docs.adaptavist.com/sr4js/latest/features/workflows/post-functions)
