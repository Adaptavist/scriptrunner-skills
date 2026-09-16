# Create a Sub-task

- Platform: data-center
- Space: SR4JS
- Hierarchy: Features > Workflows > Post Functions
- Doc ID: doc-sr4js-6c4db1b7-b605-4e73-a4fa-13380d372d22-a568090b43e7be73
- Source: https://docs.adaptavist.com/sr4js/latest/features#workflows--en#post-functions--en#create-a-sub-task--en

The _Create a sub-task_ post function creates a sub-task after an issue has been transitioned. For example, you have an issue type that requires approval from three different departments. You could use this post function multiple times to automatically create three sub-tasks, one for each approval, whenever an issue is moved through an _Approval Required_ transition (or equivalent). If you want to further automate your workflow, you could also use the [Transition Parent when all Sub-tasks are Resolved](https://docs.adaptavist.com/sr4js/latest/features/workflows/post-functions/transition-parent-when-all-sub-tasks-are-resolved) post function.

## Subtask action

If a parent issue already has a matching sub-task, you can use the Subtask Action option to update the action of the matching sub-task rather than creating a new sub-task. For example, a department must approve the parent issue and the sub-task represents their approval. The department rejects the approval. They move the parent issue back a step in the workflow so more work can be done, and move the sub-task to _Done_. When the parent issue is ready for approval again and moved through the approval transition, instead of making a new sub-task for this department to complete, the sub-task previously marked as _Done_ (or equivalent) is reopened.

If the Subtask Action is left blank a new sub-task is created every time the parent issue is moved through the selected transition.

## Use this post function

1.  Navigate to Administration > Issues > Workflows.
2.  Select Edit on the workflow you want to add this post function to.
3.  Select the transition you want to add this post function to.
4.  Under Options, select Post Functions.
    
5.  On the Transition page, select Add post function.
6.  Select Create a sub-task.
    
7.  Select Add.
8.  Optional: Enter a note that describes the post function (this note is for your reference when viewing all post functions).
9.  Optional: Enter a condition.
10.  Select a target issue type.
11.  Optional: enter a sub-task summary. Leave this option blank if you want the sub-task to inherit the summary from the parent task.
12.  Choose which fields you want to copy to the sub-task — All, None, or Custom.
13.  Enter a user you want this post function to run as. Leave this option blank if you want this post function to run as the current logged in user performing the transition.
14.  Optional: Enter any additional actions you want to occur.
     
     Tip: To disable or selectively copy links, use the same method as described in the [Clones an Issue and Links](https://docs.adaptavist.com/sr4js/latest/features/workflows/post-functions/clones-an-issue-and-links) documentation.
     
15.  Optional: Set a sub-task action. If a matching sub-task already exists, this is the transition you want to move it through. Leave this option blank if you want to create a new sub-task every time the parent issue is moved through the selected transition.
16.  Select Preview to see an overview of the change.
17.  Select Add.
     
18.  If applicable, reorder your new post functions using the arrow icons on the right of the function (they can only move one line at a time).
     
     Tip: This post function should be placed after the Re-index an issue to keep indexes in sync with the database post function. If you don't do this, the parent issue will not be indexed correctly. Check out our documentation on [Post function order](https://docs.adaptavist.com/sr4js/latest/features/workflows/post-functions/custom-post-functions#post-function-order--en) for more information.
     
19.  Select Publish and choose if you want to save a backup copy of the workflow.

You can now test to see if this post function works.

## Related content

-   [Post Functions Tutorial](https://docs.adaptavist.com/sr4js/latest/features/workflows/workflow-functions-tutorial/post-functions-tutorial)
-   [Workflows](https://docs.adaptavist.com/sr4js/latest/features/workflows)
-   [Post Functions](https://docs.adaptavist.com/sr4js/latest/features/workflows/post-functions)
