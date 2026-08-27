# Display the Latest Comment Posted by the Currently Logged In User

- Platform: data-center
- Feature: script-fields
- Tags: fields, user
- Language: groovy
- Doc ID: example-dataCenter-display-latest-comment-on-field-by-currently-logged-in-user-onPrem
- Source: https://examples.scriptrunner.io/scripts/display-latest-comment-on-field-by-currently-logged-in-user-onPrem

## Overview

This is a scripted field that displays the latest comment the current user has added to the ticket.

## Example

When there are multiple users working a single issue, the comments added by each user can be difficult to track. 
This scripted field is used to display the latest comment entered by the current user, i.e. it changes depending on which user is currently viewing the ticket.

## Description

#### Overview
This is a scripted field that displays the latest comment the current user has added to the ticket.
                                
#### Example
When there are multiple users working a single issue, the comments added by each user can be difficult to track. 
This scripted field is used to display the latest comment entered by the current user, i.e. it changes depending on which user is currently viewing the ticket.

## Script

```groovy
import com.atlassian.jira.component.ComponentAccessor

def loggedInUser = ComponentAccessor.jiraAuthenticationContext.loggedInUser
def rendererManager = ComponentAccessor.rendererManager

def commentManager = ComponentAccessor.commentManager
def comments = commentManager.getComments(issue)

def filteredComments = comments.findAll {
    it.authorApplicationUser == loggedInUser
}

if (filteredComments) {
    def latestComment = filteredComments.last()
    rendererManager.getRenderedContent('atlassian-wiki-renderer', "${latestComment.authorApplicationUser.username}\n${latestComment.body}",
                                       issue.issueRenderContext)
}
```

