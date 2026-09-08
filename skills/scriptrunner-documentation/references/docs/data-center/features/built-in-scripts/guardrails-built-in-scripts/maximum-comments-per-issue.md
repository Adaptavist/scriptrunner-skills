# Maximum Comments Per Issue

- Platform: data-center
- Space: SR4JS
- Hierarchy: features > built-in-scripts > guardrails-built-in-scripts
- Doc ID: doc-sr4js-442887623
- Source: https://docs.adaptavist.com/sr4js/latest/features/built-in-scripts/guardrails-built-in-scripts/maximum-comments-per-issue

Use this built-in script to find issues with more comments than the guardrail, and delete comments that exceed the threshold. View the [Atlassian documentation](https://confluence.atlassian.com/adminjiraserver/jira-software-guardrails-1141488685.html#JiraSoftwareguardrails-Comments) on the recommended maximum number of comments per issue.

![Image of this built in script](/sr4js/files/latest/442887623/442887631/1/1758746866000/Max_comments_per_issue.png)

## Reporting

This built-in script returns all issues with more comments than the threshold configured for your Jira instance (**General Configuration → Advanced Settings** - available from Jira 9.1, with the key **jira.safeguards.issue.comments**). If this threshold is not set, or your Jira instance is before 9.1, then it uses the Atlassian recommended figure of 1,000 comments. 

You can choose to search on all projects or restrict to one or more projects.

Select **Preview** to display issues that exceed the comment count threshold.

## Deleting Comments

Comments are permanently deleted. You cannot get them back without restoring the database.

If this built-in script finds issues with a comment count that exceeds the threshold, you are provided with the option to delete the _oldest comments_. For example, if an issue has 1,010 comments and **Max comments** is set to _1000_, the oldest 10 comments are deleted. 

![Image showing the results](/sr4js/files/latest/442887623/442887632/1/1758746866000/Max_comments_delete.png)

### Selective deletion using the comment filter

You may have thousands of comments, and some are more valuable than others. For example, some comments have been added by a bot, or some are old and no longer have value. You can target these types of comments using the **Comment filter.**

This is a Groovy script that is executed for each comment on each selected issue - it is passed the `[com.atlassian.jira.issue.comments.Comment](https://docs.atlassian.com/software/jira/docs/api/latest/com/atlassian/jira/issue/comments/Comment.html)` object in the script binding. The script should return a truthy value (the comment will be deleted) or a falsey value (the comment will be retained).

Select the **Example scripts** button for examples that show targeting comments based on their author or creation date. You can combine multiple criteria.

In the following example, we have set the threshold to 1, and will only delete comments authored by _anuser:_

![Image showing this built in script filled in](/sr4js/files/latest/442887623/442887633/1/1758746867000/max_comments_example.png)

When you use a filter, such as the case above, the comment count may still be over the threshold after deleting.

## Running this built-in script

1.  From ScriptRunner, navigate to **Built-in Scripts** **→ Guardrails: Maximum comments per issue.** 
2.  Enter a custom number under **Max comments**, or leave as the preset value.
3.  Select the project you wish to search, or leave the **Project** field blank to search all projects.
4.  If you wish to filter comments, enter a script into the **Comment filter** script console. You can select **Example scripts** to display examples that target comments based on their author or creation date.
5.  Select **Preview** to display the number of comments that exceed the threshold you have set.
6.  Select the **Delete** button if you wish to delete the selected comments. 
    
    Comments are permanently deleted. You cannot get them back without restoring the database.
    
    ![Image of the results](/sr4js/files/latest/442887623/442887632/1/1758746866000/Max_comments_delete.png)
    

## Tips

### Run the script multiple times

You may decide that there are differing degrees of importance for comments, for example _bot_ comments over one year old have no value, comments over two years old by non-bot users have slightly more value. If this is the case, run the script multiple times with different conditions to bring the comments under the threshold. For example, run with the condition for _bot_ comments first, then run again with the condition for comments over two years old.

### Test on your non-production instance first

Be sure to test first on a copy of your production instance. This is a destructive operation, there is no "undo" button.

### Want to delete all comments that fulfil a filter?

If you wish to delete all comments that fulfil the filter, regardless of whether they are over the threshold of 1,000, just reduce the threshold number to zero or one.

### Revisit this cleanup activity

After cleaning up your instance of issues with many comments, you may wish to revisit this cleanup activity, for example on a quarterly basis. Also, consider setting _[safeguards](https://confluence.atlassian.com/jiracore/configure-safeguards-1107628196.html)_ where you can block user groups from creating comments over the threshold.
