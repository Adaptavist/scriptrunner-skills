# Take N Comments From Oldest

- Platform: cloud
- Feature: script-console
- Tags: issue, hapi, automate
- Language: groovy
- Doc ID: example-cloud-take-comments-from-oldest-cloud-cloud
- Source: https://examples.scriptrunner.io/scripts/take-comments-from-oldest-cloud-cloud

## Overview

This script demonstrates how to retrieve a specific number of the oldest comments on a Jira work item 
using the Hapi API. The `takeCommentsFromOldest()` method returns the first N comments ordered from 
oldest to newest.

## Example

As a project analyst, I need to review the first 3 comments on a work item to understand how the 
conversation started or how the problem was initially reported.

## Good to Know

- Returns the N oldest comments (oldest first)
- More efficient than getting all comments when you only need a few
- Useful for processing comments in the order they were created

## Script

```groovy
// Get a work item by its key
def workItem = WorkItems.getByKey("TEST-123")

// Get the oldest 3 comments
def oldestComments = workItem.takeCommentsFromOldest(3)

logger.info("Found ${oldestComments.size()} oldest comments:")

oldestComments.each { comment ->
    logger.info("Comment by ${comment.author.displayName}: ${comment.body}")
}
```

