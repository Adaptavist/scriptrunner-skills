# Clear Field(s)

- Platform: data-center
- Space: SR4JS
- Hierarchy: Features > Workflows > Post Functions
- Doc ID: doc-sr4js-a7be89d5-a623-42ba-9796-18c7504bae00-c861de7f3913c60f
- Source: https://docs.adaptavist.com/sr4js/latest/features#workflows--en#post-functions--en#clear-fields--en

The _Clear field(s)_ post function clears the selected fields when an issue is transitioned to another status.

For example, after an issue transitions from _In Development_ to _With QA,_ you may want to clear the _Time Estimate_ field so the new team can add an accurate time estimation for this stage.

This post function should be positioned before any other field update post functions. For example, if you have the [Set Issue Security](https://docs.adaptavist.com/sr4js/latest/features/workflows/post-functions/set-issue-security), or [Assign to Last Role Member](https://docs.adaptavist.com/sr4js/latest/features/workflows/post-functions/assign-to-last-role-member) post function on the same transition, these should trigger after the Clear Field(s) post function.

## Use this post function

1.  Navigate to Administration > Issues > Workflows.
2.  Select Edit on the workflow you want to add this post function to.
3.  Select the transition you want to add this post function to.
4.  Under Options, select Post Functions.
    
5.  On the Transition page, select Add post function.
6.  Select Clear field(s).
    
7.  Select Add.
8.  Optional: Enter a note that describes the post function (this note is for your reference when viewing all post functions).
9.  Optional: Enter a condition. For example, you can enter a condition to make sure the field(s) only clear when the user transitioning an issue is part of a certain group. If no condition is specified, then this post function will always run.
10.  Select the field(s) you want to clear when an issue is transitioned.
     
11.  Select Preview to see an overview of the change.
12.  Select Add.
13.  If applicable, reorder your new post functions using the arrow icons on the right of the function (they can only move one line at a time).
     
     Tip: This post function should be positioned before any other field update post functions. Check out our documentation on [Post function order](https://docs.adaptavist.com/sr4js/latest/features/workflows/post-functions/custom-post-functions#post-function-order--en) for more information.
     
14.  Select Publish and choose if you want to save a backup copy of the workflow.
     

You can now test to see if this post function works.

## Related content

-   [Post Functions Tutorial](https://docs.adaptavist.com/sr4js/latest/features/workflows/workflow-functions-tutorial/post-functions-tutorial)
-   [Workflows](https://docs.adaptavist.com/sr4js/latest/features/workflows)
-   [Post Functions](https://docs.adaptavist.com/sr4js/latest/features/workflows/post-functions)
