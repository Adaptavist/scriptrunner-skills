# Archive This Issue

- Platform: data-center
- Space: SR4JS
- Hierarchy: Features > Workflows > Post Functions
- Doc ID: doc-sr4js-26a5adcc-10e6-42aa-8821-b7666869de31-0ee3f415100bf9a4
- Source: https://docs.adaptavist.com/sr4js/latest/features#workflows--en#post-functions--en#archive-this-issue--en

The _Archive this issue_ post-function automatically archives an issue when when it is transitioned. You can add a condition to define specific criteria that must be met for the post function to archive an issue. For example, if an issue is in the _Resolve Issue_ transition, and is given the Resolution of _Duplicate_, you may want the issue to be archived.

## Use this post function

1.  Navigate to Administration > Issues > Workflows.
2.  Select Edit on the workflow you want to add this post function to.
3.  Select the transition you want to add this post function to.
4.  Under Options, select Post Functions.
    
5.  On the Transition page, select Add post function.
6.  Select Archive this issue.
    
7.  Select Add.
8.  Optional: Enter a note that describes the post function (this note is for your reference when viewing all post functions).
9.  Optional: Enter a condition. For example, to archive issues in the Resolve Issue transition that are given the Resolution of Duplicate you would enter `issue.resolution.name == 'Duplicate'`. If no condition is specified, then this post function will always run.
    
10.  Select Preview to see an overview of the change.
11.  Select Add.
12.  If applicable, reorder your new post functions using the arrow icons on the right of the function (they can only move one line at a time). Check out our documentation on [Post function order](https://docs.adaptavist.com/sr4js/latest/features/workflows/post-functions/custom-post-functions#post-function-order--en) for more information.
13.  Select Publish and choose if you want to save a backup copy of the workflow.
     

You can now test to see if this post function works.

Tip: Restoring archived issues

See the [Atlassian documentation](https://confluence.atlassian.com/adminjiraserver/archiving-an-issue-968669980.html) for details on how to restore archived issues.

## Related content

-   [Post Functions Tutorial](https://docs.adaptavist.com/sr4js/latest/features/workflows/workflow-functions-tutorial/post-functions-tutorial)
-   [Workflows](https://docs.adaptavist.com/sr4js/latest/features/workflows)
-   [Post Functions](https://docs.adaptavist.com/sr4js/latest/features/workflows/post-functions)
