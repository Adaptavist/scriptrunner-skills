# Add a Comment to this Issue

- Platform: data-center
- Space: SR4JS
- Hierarchy: Features > Workflows > Post Functions
- Doc ID: doc-sr4js-a7a1b9c8-6360-4dfa-995f-bab5c0d6f211-5c58a3aed33611f6
- Source: https://docs.adaptavist.com/sr4js/latest/features#workflows--en#post-functions--en#add-a-comment-to-this-issue--en

The _Add a comment to this issue_ post function posts a comment to an issue when it is transitioned.

For example, when a support ticket transitions from _Open_ to _In Progress_, we want a comment to be added to the ticket to let the client know we are working on the issue.

## Use this post function

1.  Go to Administration > Issues > Workflows.
2.  Select Edit on the workflow you want to add a post function to.
3.  Select the transition to which you wish to add a post function.
4.  Under Options, select Post Functions.
    
5.  On the _Transition_ page, select Add post function.
6.  Select Adds a comment to this issue.
    
7.  Select Add.
8.  Optional: Enter a note that describes the post function (this note is for your reference when viewing all post functions).
9.  Optional: Enter a condition. If no condition is specified, then this post function will always run.
10.  Enter the Comment to be added to the ticket after the transition. This can be written in plain text or you can use the [GStringTemplateEngine](http://docs.groovy-lang.org/docs/next/html/documentation/template-engines.html).
11.  Optional: Select to make the comment an Internal Comment. This is only relevant for Jira Service Management projects.
12.  Select Preview to see an overview of the change.
13.  Select Add.
     
14.  If applicable, reorder your new post functions using the arrow icons on the right of the function (they can only move one line at a time).
     
15.  Select Publish and choose if you want to save a backup copy of the workflow.
     

You can now test to see if this post function works.

## Add a custom field value to a comment

When using this function you might want to include a custom field value in the comment. To do so, you could use the following:

```
Field value is ${issue.getCustomFieldValue('TextField')}
```

For example, if we wanted to include a comment with the Epic Link, we could add the following comment to this post function:

```
The issue is part of the ${issue.getCustomFieldValue('Epic Link')} Epic
```

The above comment appears as follows in your post function:

And appears as follows after the transition:

## Related content

-   [Post Functions Tutorial](https://docs.adaptavist.com/sr4js/latest/features/workflows/workflow-functions-tutorial/post-functions-tutorial)
-   [Workflows](https://docs.adaptavist.com/sr4js/latest/features/workflows)
-   [Post Functions](https://docs.adaptavist.com/sr4js/latest/features/workflows/post-functions)
