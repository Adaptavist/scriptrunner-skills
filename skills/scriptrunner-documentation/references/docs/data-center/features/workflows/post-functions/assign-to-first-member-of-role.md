# Assign to First Member of Role

- Platform: data-center
- Space: SR4JS
- Hierarchy: Features > Workflows > Post Functions
- Doc ID: doc-sr4js-128380d8-7f15-490f-b925-03aaa93b39af-d36021bb1b01463c
- Source: https://docs.adaptavist.com/sr4js/latest/features#workflows--en#post-functions--en#assign-to-first-member-of-role--en

The _Assign to first member of role_ post function automatically assigns an issue to the first member of a user role after it transitions. For example, you want to assign a _Tester_ role member to an issue after it transitions from _In Development_ to _In Test_.

Note: This post function selects the first person in alphabetical order from the chosen role. If you want to randomize who is selected, you should use the example provided on the [custom post function](https://docs.adaptavist.com/sr4js/latest/features/workflows/post-functions/custom-post-functions#assign-an-issue-to-a-random-member-of-a-role--en) page.

## Use this post function

1.  Navigate to Administration > Issues > Workflows.
2.  Select Edit on the workflow you want to add this post function to.
3.  Select the transition you want to add this post function to.
4.  Under Options, select Post Functions.
    
5.  On the Transition page, select Add post function.
6.  Select Assign to first member of role.
    
7.  Select Add.
8.  Optional: Enter a note that describes the post function (this note is for your reference when viewing all post functions).
9.  Optional: Enter a condition. If no condition is specified, then this post function will always run.
10.  Select the Role of the user to assign. The first person alphabetically in this role is assigned when the issue transitions.
11.  Select Preview to see an overview of the change.
12.  Select Add.
     
13.  If applicable, reorder your new post functions using the arrow icons on the right of the function (they can only move one line at a time). Check out our documentation on [Post function order](https://docs.adaptavist.com/sr4js/latest/features/workflows/post-functions/custom-post-functions#post-function-order--en) for more information.
14.  Select Publish and choose if you want to save a backup copy of the workflow.
     

You can now test to see if this post function works.

## Related content

-   [Post Functions Tutorial](https://docs.adaptavist.com/sr4js/latest/features/workflows/workflow-functions-tutorial/post-functions-tutorial)
-   [Workflows](https://docs.adaptavist.com/sr4js/latest/features/workflows)
-   [Post Functions](https://docs.adaptavist.com/sr4js/latest/features/workflows/post-functions)
