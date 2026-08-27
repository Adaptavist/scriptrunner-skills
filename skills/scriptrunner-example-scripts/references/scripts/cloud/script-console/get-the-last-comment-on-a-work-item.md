# Get the Last Comment on a Work Item

- Platform: cloud
- Feature: script-console
- Tags: issue, hapi, automate
- Language: groovy
- Doc ID: example-cloud-get-last-comment-on-issue-cloud-cloud
- Source: https://examples.scriptrunner.io/scripts/get-last-comment-on-issue-cloud-cloud

## Overview

This script demonstrates how to retrieve the most recent comment on a Jira work item using the Hapi API. 
The `getLastComment()` method returns the latest comment, which is useful when you only need 
the most recent update or response.

## Example

As a developer, I need to check the latest comment on a work item to see if there are any new updates 
or instructions. This is particularly useful in automated workflows where you need to react to 
the most recent comment.

## Good to Know

- Returns null if the work item has no comments
- The comment object includes all standard comment properties (body, author, dates, etc.)
- This is more efficient than getting all comments when you only need the latest one

## Script

```groovy
// Get a work item by its key
def workItem = WorkItems.getByKey("TEST-123")

// Get the most recent comment
def lastComment = workItem.getLastComment()

if (lastComment) {
    logger.info("Last comment by ${lastComment.author.displayName}: ${lastComment.body}")
} else {
    logger.info("No comments found on this work item")
}
```

