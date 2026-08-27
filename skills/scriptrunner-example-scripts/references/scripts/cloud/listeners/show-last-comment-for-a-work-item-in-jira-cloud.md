# Show Last Comment for a Work Item in Jira Cloud

- Platform: cloud
- Feature: listeners
- Tags: automate, issue, hapi
- Language: groovy
- Doc ID: example-cloud-show-last-comment-issue-cloud-cloud
- Source: https://examples.scriptrunner.io/scripts/show-last-comment-issue-cloud-cloud

## Overview

This script populates a custom field with the last comment posted on a work item.

## Example

As a developer working on a new space with a large number of work items, I must ensure I'm working with the most
up-to-date information. Therefore, it's useful to have the latest comment readily available, so I don't have to spend 
time navigating the comment history and potentially work from out of date information. Using this script, I can display
the most recent comment in a custom field where it is easily visible.

## Good to Know

* The custom field should be a 'Text Field (paragraph)', as it has the same characters limit as a comment
* The script is added as a listener for the `Comment Created` event.

## Script

```groovy
final lastCommentFieldName = 'Last Comment'
def myWorkItem = WorkItems.getByKey(issue.key)

myWorkItem.update {
    setCustomFieldValue(lastCommentFieldName, myWorkItem.getComments().last().body)
}
```

