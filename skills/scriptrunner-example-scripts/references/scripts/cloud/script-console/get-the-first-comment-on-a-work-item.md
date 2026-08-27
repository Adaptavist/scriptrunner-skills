# Get the First Comment on a Work Item

- Platform: cloud
- Feature: script-console
- Tags: issue, hapi, automate
- Language: groovy
- Doc ID: example-cloud-get-first-comment-on-issue-cloud-cloud
- Source: https://examples.scriptrunner.io/scripts/get-first-comment-on-issue-cloud-cloud

## Overview

This script demonstrates how to retrieve the first (oldest) comment on a Jira work item using the Hapi API. 
The `getFirstComment()` method returns the initial comment, which is useful when you need to see 
how a conversation started or retrieve the original context.

## Example

As a project manager, I need to review the first comment on work items to understand the original 
problem statement or request. This is helpful for tracking how work items evolve over time or 
understanding the initial context.

## Good to Know

- Returns null if the work item has no comments
- The comment object includes all standard comment properties (body, author, dates, etc.)
- This is more efficient than getting all comments when you only need the first one

## Script

```groovy
// Get a work item by its key
def workItem = WorkItems.getByKey("TEST-123")

// Get the first (oldest) comment
def firstComment = workItem.getFirstComment()

if (firstComment) {
    logger.info("First comment by ${firstComment.author.displayName}: ${firstComment.body}")
} else {
    logger.info("No comments found on this work item")
}
```

