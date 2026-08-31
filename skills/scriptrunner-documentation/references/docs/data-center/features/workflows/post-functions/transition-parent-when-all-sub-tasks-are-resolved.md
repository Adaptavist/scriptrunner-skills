# Transition Parent when all Sub-tasks are Resolved

- Platform: data-center
- Space: SR4JS
- Hierarchy: features > workflows > post-functions
- Doc ID: doc-sr4js-442885319
- Source: https://docs.adaptavist.com/sr4js/latest/features/workflows/post-functions/transition-parent-when-all-sub-tasks-are-resolved

Use this post function to transition a parent issue when all sub-tasks are marked as [resolved](https://confluence.atlassian.com/adminjiraserver/defining-resolution-field-values-938847105.html). If all sub-tasks are resolved, the parent issue is transitioned using the chosen action (which should be valid for the current step), and given the chosen resolution. The sub-task can be given any resolution to be considered as resolved. 

You can add this post function to any transition that involves [setting the resolution field](https://confluence.atlassian.com/adminjiraserver/working-with-workflows-938847362.html#:~:text=.-,Set%20the%20resolution%20field,-After%20you%20finish). For example, you don't have to add this post function to the **Resolve issue** transition—you could add it to the **Close issue** or **Done** transition, or any similar transition in your workflow. 

## Use this post function

1.  Go to **Administration > Issues > Workflows.**
2.  Select **Edit** on the workflow you want to add this post function to. 
3.  Select the transition you want to add this post function to.
    
    This is the transition you want the sub-tasks to complete before the parent task can be transitioned. 
    
4.  Under **Options**, select **Post Functions.  
    ![](/sr4js/files/latest/442885319/442885333/1/1758746477000/Subtasks_1.png)  
    **
5.  On the _Transition_ page, select **Add post function**.
6.  Select **Transition parent when all subtasks are resolved**.  
    ![Image selecting this post function](/sr4js/files/latest/442885319/442885341/1/1758746478000/Transition_parent_pf.png)  
    
7.  Select **Add**.
8.  Optional: Enter a note that describes the post function (this note is for your reference when viewing all post functions).
9.  Optional: Enter a condition. If no condition is specified, then this post function will always run.
10.  Choose the parent action. This is the transition you want to move the parent issue through when all sub-tasks are resolved. The transition must be valid for the current step, otherwise the parent issue will not be transitioned.
11.  Choose the resolution. This is the resolution you want to give to the parent issue when all sub-tasks are resolved. 
12.  Select **Preview** to see an overview of the change. 
13.  Select **Add**.  
     ![](/sr4js/files/latest/442885319/442885339/1/1758746478000/Subtasks_3.png)  
     
14.  If applicable, reorder your new post functions using the arrow icons on the right of the function (they can only move one line at a time). Check out our documentation on [Post function order](https://docs.adaptavist.com/sr4js/latest/features/workflows/post-functions/custom-post-functions#post-function-order) for more information. 
     
15.  Select **Publish** and choose if you want to save a backup copy of the workflow.  
     ![](/sr4js/files/latest/442885319/442885335/2/1758746478000/Subtasks_4.png)
     
     You can now test to see if this post function works.
     

  

* * *

## Related content

-   [Post Functions Tutorial](https://docs.adaptavist.com/sr4js/latest/features/workflows/workflow-functions-tutorial/post-functions-tutorial)
-   [Workflows](https://docs.adaptavist.com/sr4js/latest/features/workflows)
-   [All Sub-tasks Resolved Condition](https://docs.adaptavist.com/sr4js/latest/features/workflows/conditions/all-sub-tasks-resolved-condition)
