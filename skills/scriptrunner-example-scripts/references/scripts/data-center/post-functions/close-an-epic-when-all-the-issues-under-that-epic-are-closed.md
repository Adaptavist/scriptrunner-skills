# Close an Epic when all the Issues Under that Epic are Closed

- Platform: data-center
- Feature: post-functions
- Tags: workflow, issue, automate, hapi
- Language: groovy
- Doc ID: example-dataCenter-transition-epic-when-children-closed-onPrem
- Source: https://examples.scriptrunner.io/scripts/transition-epic-when-children-closed-onPrem

## Overview

Transition an epic to Closed using a post function on the Closed workflow step which fires when all child issues are closed.

## Example

I work in a software project using epics to organise the tasks. 
I want to close an epic when all tasks are complete, so I do not have to do this manually. 
I can use this script as a post function to close an epic when the last child issue has been completed.

## Description

#### Overview

Transition an epic to Closed using a post function on the Closed workflow step which fires when all child issues are closed.

#### Example

I work in a software project using epics to organise the tasks. 
I want to close an epic when all tasks are complete, so I do not have to do this manually. 
I can use this script as a post function to close an epic when the last child issue has been completed.

## Script

```groovy
def epicIssue = issue.epic

if (!epicIssue) {
    return
}

// Find all unresolved stories
def openStories = epicIssue.stories.findAll { !it.resolution }

// If there are still open stories (except the one in transition) - then do nothing
if (openStories.size() > 1) {
    return
}

epicIssue.transition('Done') {
    setComment('This Epic closed automatically because all the issues in this Epic are closed.')
}
```

