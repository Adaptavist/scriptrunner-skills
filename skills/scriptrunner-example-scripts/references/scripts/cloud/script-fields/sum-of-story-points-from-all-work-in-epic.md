# Sum of story points from all work in epic

- Platform: cloud
- Feature: script-fields
- Tags: issue, hapi, fields, automate
- Language: groovy
- Doc ID: example-cloud-sum-story-points-below-epic-cloud
- Source: https://examples.scriptrunner.io/scripts/sum-story-points-below-epic-cloud

## Overview

An epic can display in a scripted field the sum of the story points from all work that belongs to it.

## Example

An epic contains three work items estimated at 1pt, 3pts and 5pts.
The epic can display in a scripted field the total of the story points of its work items (9pts).

## Good to Know

The scripted field should be of type: number.

## Script

```groovy
def currentWorkItem = WorkItems.getByKey(issue.key as String)
if (currentWorkItem.getWorkType().name == 'Epic') {
    return WorkItems.search("parent='${currentWorkItem.key}'").collect { child ->
        child.getCustomFieldValue('Story Points') ?: 0 // if Story Points is null default to zero
    }.sum()
}
```

