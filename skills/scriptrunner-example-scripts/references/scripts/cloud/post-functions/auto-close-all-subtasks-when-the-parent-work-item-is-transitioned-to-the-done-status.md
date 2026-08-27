# Auto close all subtasks when the parent work item is transitioned to the Done status

- Platform: cloud
- Feature: post-functions
- Tags: workflow, automate, issue, hapi
- Language: groovy
- Doc ID: example-cloud-close-all-subtasks-when-parent-issue-moved-to-done-cloud
- Source: https://examples.scriptrunner.io/scripts/close-all-subtasks-when-parent-issue-moved-to-done-cloud

## Overview

Automatically close all subtasks when the  parent work item is transitioned to the Done status to keep your Jira instance in a clean state.

## Example

As a product manager, I do not want any subtasks left open on closed tickets, in order to keep my backlog of work items clean and up to date.

## Good to Know

* In the script on line *5* enter in the ID for the Global done transition in your subtasks workflow.
* Note this transition must be valid to be run in the UI otherwise the script will not be able to run it.  

* The work items are returned by the JQL defined in line *1* of the script and narrow down what types of subtasks are returned if you wish to by updating this JQL.

## Script

```groovy
// Get all subtasks below a work item
def jqlQuery = "parent=${issue.key}"

// Specify the name below for the global Done transition
def doneTransitionName = "Done"

// Get all subtask work items for the current work item
def allSubtasks = WorkItems.search(jqlQuery)

/**
 * You can also get the subtasks for the desired work item in the following way
 *
 * def allSubtasks = WorkItems.getByKey(issue.key).getSubtasks()
 */

// Iterate over each subtask returned
allSubtasks.each { subtask ->
    subtask.transition(doneTransitionName)
}
```

