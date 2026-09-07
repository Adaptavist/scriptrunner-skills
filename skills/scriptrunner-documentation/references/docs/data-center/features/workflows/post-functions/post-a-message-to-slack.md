# Post a Message to Slack

- Platform: data-center
- Space: SR4JS
- Hierarchy: features > workflows > post-functions
- Doc ID: doc-sr4js-442885299
- Source: https://docs.adaptavist.com/sr4js/latest/features/workflows/post-functions/post-a-message-to-slack

The _Post a message to Slack_ post function allows you to send a personalized custom message to your Slack room. For example, you could be notified in a Slack channel when an issue is moved to _Done._

## Message templating

When configuring a message template for what you want to post to Slack, you can use plain text or use the [GString TemplateEngine](https://docs.groovy-lang.org/docs/next/html/documentation/template-engines.html).

The `issue` variable is available for you to use in your template. For example, you can call a property as follows:

```
"Your issue $issue has been updated."
```

You can also do more complex calls to your object by using the [<% %> notation](http://docs.groovy-lang.org/next/html/documentation/template-engines.html#_streamingtemplateengine):

```
"The issue $issue, which is assigned to <% out << issue.assignee %>, was updated."
```

## Use this post function

Make sure you have set up a [Slack connection](https://docs.adaptavist.com/sr4js/latest/features/resources/slack-connection) before you use this post function. 

1.  Go to **Administration > Issues > Workflows.**
2.  Select **Edit** on the workflow you want to add the post function to. 
3.  Select the transition you want to add the post function to. 
4.  Under **Options**, select **Post Functions.  
    ![](/sr4js/files/latest/442885299/442885302/1/1758746476000/Slack_message_1.png)  
    **
5.  On the _Transition_ page, select **Add post function**.
6.  Select **Post a message to Slack**.  
    ![Image selecting this post function](/sr4js/files/latest/442885299/442885312/1/1758746476000/Post_message_pf.png)  
    
7.  Select **Add**.
8.  Optional: Enter a note that describes the post function (this note is for your reference when viewing all post functions).
9.  Enter your bearer token to retrieve a list of target rooms (channels) you can post to. See [Slack connection](https://docs.adaptavist.com/sr4js/latest/features/resources/slack-connection) for more details.
10.  Select the target room (channel) you want to post to.
11.  Optional: Enter a condition. If no condition is specified, then this post function will always run.
12.  Enter a message to send. See [Message templating](#id-.PostaMessagetoSlackv9.x-templating) above for guidance on creating your message template.
13.  Select **Add**.
14.  If applicable, reorder your new post functions using the arrow icons on the right of the function (they can only move one line at a time). Check out our documentation on [Post function order](https://docs.adaptavist.com/sr4js/latest/features/workflows/post-functions/custom-post-functions#post-function-order) for more information.
15.  Select **Publish** and choose if you want to save a backup copy of the workflow.
     
     ![Image with Publish option highlighted](/sr4js/files/latest/442885299/442885307/1/1758746476000/Require_comment_4.png)
     
     You can now test to see if this post function works.
     

  

* * *

## Related content

-   [Post Functions Tutorial](https://docs.adaptavist.com/sr4js/latest/features/workflows/workflow-functions-tutorial/post-functions-tutorial)
-   [Workflows](https://docs.adaptavist.com/sr4js/latest/features/workflows)
-   [Post Functions](https://docs.adaptavist.com/sr4js/latest/features/workflows/post-functions)
