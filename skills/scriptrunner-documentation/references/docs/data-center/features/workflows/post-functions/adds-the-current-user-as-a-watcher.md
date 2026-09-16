# Adds the current user as a watcher

- Platform: data-center
- Space: SR4JS
- Hierarchy: Features > Workflows > Post Functions
- Doc ID: doc-sr4js-83c221f9-0267-4686-a338-5054dbf08d04-0cc6fd31a70b3245
- Source: https://docs.adaptavist.com/sr4js/latest/features#workflows--en#post-functions--en#adds-the-current-user-as-a-watcher--en

Use the _Adds the current user as a watcher_ post function to add the currently logged-in user as a watcher when they transition the issue. You can apply conditions to this post function so the user is only added as a watcher in specific contexts. For example, you could add a condition so this post function only applies to _Bug_ issues.

## Use this post function

1.  Navigate to Administration > Issues > Workflows.
2.  Select Edit on the workflow you want to add a post function to.
3.  Select the transition to which you wish to add a post function.
4.  Under Options, select Post Functions.
    
5.  On the Transition page, select Add post function.
6.  Select Adds the current user as a watcher.
    
7.  Select Add.
8.  Optional: Enter a note that describes the post function (this note is for your reference when viewing all post functions).
9.  Optional: Enter a condition. An empty condition evaluates the function to `true`.
    
    Tip: Select Example scripts in the script editor to find a selection of example scripts that you can use and adapt.
    
10.  Select Preview to see an overview of the change.
11.  Select Add.
12.  Reorder your new post functions using the arrow icons on the right of the function (they can only move one line at a time). Make sure this post function occurs after the pre-generated post functions.
     
13.  Select Publish and choose if you want to save a backup copy of the workflow.
     

You can now test to see if this workflow condition works.

## Related content

-   [Post Functions Tutorial](https://docs.adaptavist.com/sr4js/latest/features/workflows/workflow-functions-tutorial/post-functions-tutorial)
-   [Adds the Current User as a Watcher Listener](https://docs.adaptavist.com/sr4js/latest/features/listeners/built-in-listeners/adds-the-current-user-as-a-watcher)
-   [Workflows](https://docs.adaptavist.com/sr4js/latest/features/workflows)
