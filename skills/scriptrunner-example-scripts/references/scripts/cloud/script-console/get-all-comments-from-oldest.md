# Get All Comments From Oldest

- Platform: cloud
- Feature: script-console
- Tags: issue, hapi, automate
- Language: groovy
- Doc ID: example-cloud-get-all-comments-from-oldest-cloud-cloud
- Source: https://examples.scriptrunner.io/scripts/get-all-comments-from-oldest-cloud-cloud

## Overview

This script demonstrates how to retrieve all comments on a Jira work item ordered from oldest to newest 
using the Hapi API. The `getAllCommentsFromOldest()` method returns all comments in chronological 
order, which is the same as `getComments()` but with an explicit name.

## Example

As a project manager, I need to review all comments on a work item in chronological order to understand 
the full conversation history from the beginning.

## Good to Know

- Returns all comments in chronological order (oldest first)
- This is the default ordering and mirrors the behavior of `getComments()`
- Useful for processing comments in the order they were created

## Script

```groovy
// Get a work item by its key
def workItem = WorkItems.getByKey("TEST-123")

// Get all comments ordered from oldest (oldest first)
def allCommentsFromOldest = workItem.getAllCommentsFromOldest()

logger.info("Total comments: ${allCommentsFromOldest.size()}")

allCommentsFromOldest.each { comment ->
    logger.info("Comment by ${comment.author.displayName}: ${comment.body}")
}
```

