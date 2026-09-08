# Adds a Comment to Linked Issues when this Issue is Transitioned

- Platform: data-center
- Space: SR4JS
- Hierarchy: features > workflows > post-functions
- Doc ID: doc-sr4js-442885794
- Source: https://docs.adaptavist.com/sr4js/latest/features/workflows/post-functions/adds-a-comment-to-linked-issues-when-this-issue-is-transitioned

Use _Adds a Comment to Linked Issues when this Issue is Transitioned_ to automatically add a custom comment to linked issues after the selected issue is transitioned. For example, you can use this post function if you want to add a comment on a service desk request when the development issue that **causes** the request has been transitioned to _Done_. 

## Build a comment

When writing a comment, you can include static text (text that doesn't change) and dynamic content (text that changes based on the issue's properties or context). Below are some examples of how to write a comment with dynamic content.

**Reference the current issue key:**

```
This is a comment related to issue ${issue.key}.
```

**Reference the current issue summary:**

```
The issue titled '${issue.summary}' has been updated.
```

**Reference the current issue resolution:**

For this example to work as expected, make sure the post function sits after the post function that updates the resolution of the issue. Check out our documentation on [Post function order](https://docs.adaptavist.com/sr4js/latest/features/workflows/post-functions/custom-post-functions#post-function-order) for more information. 

```
The issue has been resolved with the resolution: <% out << issue.resolution?.name %>.
```

**Reference the assignee's display name:**

```
The issue is now assigned to <% out << issue.assignee?.displayName %>.
```

## Use this post function

1.  Go to **Administration > Issues > Workflows.**
2.  Select **Edit** on the workflow you want to add a post function to. 
3.  Select the transition to which you wish to add a post function to.
4.  Under **Options**, select **Post Functions.  
    ![](/sr4js/files/latest/442885794/442885799/1/1758746519000/custom_post_function_1.png)  
    **
5.  On the _Transition_ page, select **Add post function**.
6.  Select **Adds a comment to linked issues when this issue is transitioned**.  
    ![Image selecting this post function](/sr4js/files/latest/442885794/442885802/1/1758746520000/Add_comment_linked_issues_pf.png)  
    
7.  Select **Add**.
8.  Optional: Enter a note that describes the post function (this note is for your reference when viewing all post functions).
9.  Optional: Enter a condition, for example, `issue.issueType.name == 'Bug'`. If no condition is specified, then this post function will always run.
10.  Select the **Issue Link Type**.
11.  Enter the comment to post on linked issues in the **Comment** field.
12.  Select **Add**.
13.  If applicable, reorder your new post functions using the arrow icons on the right of the function (they can only move one line at a time). Check out our documentation on [Post function order](https://docs.adaptavist.com/sr4js/latest/features/workflows/post-functions/custom-post-functions#post-function-order) for more information.
14.  Select **Publish** and choose if you want to save a backup copy of the workflow.
     
     ![Image with Publish option highlighted](/sr4js/files/latest/442885794/442885798/1/1758746519000/Require_comment_4.png)
     
     You can now test to see if this post function works.
     

  

* * *

## Related content

-   [Post Functions Tutorial](https://docs.adaptavist.com/sr4js/latest/features/workflows/workflow-functions-tutorial/post-functions-tutorial)
-   [Workflows](https://docs.adaptavist.com/sr4js/latest/features/workflows)
-   [Post Functions](https://docs.adaptavist.com/sr4js/latest/features/workflows/post-functions)
