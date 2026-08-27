# Get All Comments From Latest

- Platform: cloud
- Feature: script-console
- Tags: issue, hapi, automate
- Language: groovy
- Doc ID: example-cloud-get-all-comments-from-latest-cloud-cloud
- Source: https://examples.scriptrunner.io/scripts/get-all-comments-from-latest-cloud-cloud

## Overview

This script demonstrates how to retrieve all comments on a Jira work item ordered from newest to oldest 
using the Hapi API. The `getAllCommentsFromLatest()` method returns all comments in reverse 
chronological order.

## Example

As a project manager, I need to review all comments on a work item starting from the most recent to 
understand the conversation flow from the latest updates backwards.

## Good to Know

- Returns all comments in reverse chronological order (newest first)
- Useful when you need to process comments starting from the most recent
- Different from `getComments()` which returns comments oldest first

## Script

```groovy
// Get a work item by its key
def workItem = WorkItems.getByKey("TEST-123")

// Get all comments ordered from latest (newest first)
def allCommentsFromLatest = workItem.getAllCommentsFromLatest()

logger.info("Total comments: ${allCommentsFromLatest.size()}")

allCommentsFromLatest.each { comment ->
    logger.info("Comment by ${comment.author.displayName}: ${comment.body}")
}
```

