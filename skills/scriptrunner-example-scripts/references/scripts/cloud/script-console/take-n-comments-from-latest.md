# Take N Comments From Latest

- Platform: cloud
- Feature: script-console
- Tags: issue, hapi, automate
- Language: groovy
- Doc ID: example-cloud-take-comments-from-latest-cloud-cloud
- Source: https://examples.scriptrunner.io/scripts/take-comments-from-latest-cloud-cloud

## Overview

This script demonstrates how to retrieve a specific number of the most recent comments on a Jira work item 
using the Hapi API. The `takeCommentsFromLatest()` method returns the first N comments ordered from 
newest to oldest.

## Example

As a support agent, I need to see the 5 most recent comments on a work item to quickly understand the 
latest updates without processing the entire comment history.

## Good to Know

- Returns the N most recent comments (newest first)
- More efficient than getting all comments when you only need a few
- Useful for displaying recent activity or processing only the latest updates

## Script

```groovy
// Get a work item by its key
def workItem = WorkItems.getByKey("TEST-123")

// Get the latest 5 comments
def latestComments = workItem.takeCommentsFromLatest(5)

logger.info("Found ${latestComments.size()} latest comments:")

latestComments.each { comment ->
    logger.info("Comment by ${comment.author.displayName}: ${comment.body}")
}
```

