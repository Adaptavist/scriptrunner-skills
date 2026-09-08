# Work with Comments

- Platform: data-center
- Space: SR4JS
- Hierarchy: hapi
- Doc ID: doc-sr4js-442888538
- Source: https://docs.adaptavist.com/sr4js/latest/hapi/work-with-comments

![](/sr4js/files/latest/442888538/441364733/1/1750779281000/sr-icon-cloud.png)

**Migrating to Jira Cloud? This feature is available in Cloud. Check out our** **[HAPI Cloud documentation](https://docs.adaptavist.com/sr4jc/latest/hapi/work-with-comments)** **for more details.** 

With HAPI, you can easily add comments to issues and restrict who can see the comments. 

To work with comments in **Jira Service Management** see our [Work with Jira Service Management](https://docs.adaptavist.com/sr4js/latest/hapi/work-with-jira-service-management#comments) page.

## Adding a comment to an existing issue

You can add a comment to an existing issue. For example:

```
            Issues.getByKey('SR-1').addComment('This is a comment')
```

## Adding a comment while updating an issue

You can add a comment while updating an issue. For example:

```
            def issue = Issues.getByKey('SR-1')
        
            issue.update {
                setDescription('I am updating the description')
                setComment('This is a comment')
            }
```

![Image showing how to add a comment while updating an issue with HAPI](/sr4js/files/latest/442888538/442888540/1/1758746948000/Comments_add_comment_while_updating.png)

## Adding a comment while transitioning an issue

You can add a comment while transitioning an issue. In this example we're resolving an issue, setting the resolution, and adding a comment:

```
            def issue = Issues.getByKey('ABC-1')
 
            issue.transition('Resolve Issue') {
                setResolution('Done')
                setComment('resolving this issue')            
            }
```

Check out our [Transitioning Issues](https://docs.adaptavist.com/sr4js/latest/hapi/transition-issues) documentation for more information on transitioning issues.

## Update a comment

You can update an existing comment and the restrictions. For example:

```
            def comment = Issues.getByKey('SR-1').addComment('Original comment')
        
            comment.update {
                setBody('Updated comment')
                setGroupRestriction('jira-administrators')
            }
```

![Image showing a comment being updated](/sr4js/files/latest/442888538/442888551/1/1758746949000/Update_comment_png.png)

## Retrieving comments from an issue

You may want to retrieve comments to, for example, display them in a dashboard or use them in a scripted field.

You can retrieve comments from an issue as follows:

```
def issue = Issues.getByKey('SR-1')

issue.comments
```

### Overriding permissions while retrieving comments

The current user may not have the correct permissions to retrieve all comments from an issue. You can override permissions using `getCommentsOverrideSecurity()`. For example:

```
            def issue = Issues.getByKey('SR-1')
            issue.addComment('Adding a comment')
            
            issue.getCommentsOverrideSecurity()
```

## Setting restrictions 

### Setting group restrictions

You can restrict which groups can see a comment. In this example we're adding a comment to an existing issue and restricting the comment to the "jira-administrators" group:

```
            def issue = Issues.getByKey('SR-1')
  
            issue.update {
                setComment('This is a comment') {
                    setGroupRestriction('jira-administrators')
                }
            }
```

### Setting project role restrictions

You can restrict which project roles can see a comment. In this example we're adding a comment to an existing issue and restricting the comment to the "Administrators" role:

```
            def issue = Issues.getByKey('SR-1')

            issue.update {
                setComment('This is a comment') {
                    setProjectRoleRestriction('Administrators')
                }
            }
```

## Deleting a comment

You can delete a comment from an existing issue using `delete()`. For example:

```
            def comment = Issues.getByKey('SR-1').addComment('Adding a comment')
            comment.delete()
```

A Comment Deleted event is dispatched by default. You can use the closure below make sure this event is not dispatched.

```
            def comment = Issues.getByKey('SR-1').addComment('Adding another comment')
            comment.delete { dispatchEvent = false }
```

### Overwriting permissions while deleting a comment

The current user may not have the correct permissions to delete a comment. You can delete a comment from an existing issue regardless of the permissions of the current user using `deleteOverrideSecurity`. For example:

```
            def comment = Issues.getByKey('SR-1').addComment('Adding a comment')
            comment.deleteOverrideSecurity()
```

## Related content

-   [Javadocs link](https://docs.adaptavist.com/api/javadoc/dc/scriptrunner/8.10.0/hapi/jira/groovydoc/com/adaptavist/hapi/jira/comments/implementation/CommentsImplementation.html)
-   [Transition Issues](https://docs.adaptavist.com/sr4js/latest/hapi/transition-issues)
-   [Work with Jira Service Management](https://docs.adaptavist.com/sr4js/latest/hapi/work-with-jira-service-management)
