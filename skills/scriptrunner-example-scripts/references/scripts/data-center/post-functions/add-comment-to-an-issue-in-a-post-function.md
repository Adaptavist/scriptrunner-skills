# Add Comment to an Issue in a Post Function

- Platform: data-center
- Feature: post-functions
- Tags: automate, workflow, user, hapi
- Language: groovy
- Doc ID: example-dataCenter-add-comment-post-function-onPrem
- Source: https://examples.scriptrunner.io/scripts/add-comment-post-function-onPrem

## Overview

Configure a post function to add a comment to an issue when a workflow transition occurs. 

Note that this approach works well in post-functions, because the behaviour is the same as if the end-user had entered 
the comment into the transition form. The comment will be included in any email notifications.

The post-function should be placed before the system post-functions that save and reindex the issue. 
In contexts other than post-functions, you can use `issue.addComment(...)`.

## Example

I work in support and when an issue transitions from 'open' to 'in progress', I want a comment to be automatically added to the ticket to let our customer know we are working on their issue.

## Good to Know

Specify issue values using the [Groovy string interpolation](http://docs.groovy-lang.org/docs/next/html/documentation/template-engines.html#_simpletemplateengine).

## Script

```groovy
issue.set {
    setComment("""
        The comment, which can include values from the issue, eg the assignee: ${issue.assignee?.displayName ?: 'Unassigned'}

        You can also include *markdown*.
    """)
}
```

