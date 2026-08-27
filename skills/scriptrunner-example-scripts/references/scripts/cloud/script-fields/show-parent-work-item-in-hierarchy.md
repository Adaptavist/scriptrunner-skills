# Show Parent Work Item in Hierarchy

- Platform: cloud
- Feature: script-fields
- Tags: issue, fields, customise
- Language: groovy
- Doc ID: example-cloud-show-parent-issue-in-hierarchy-cloud
- Source: https://examples.scriptrunner.io/scripts/show-parent-issue-in-hierarchy-cloud

## Overview

This scripted field is designed to display a work item’s parent, where you define what parent means.

## Example

Your team organises their work items into a hierarchy like so:
1. Epic
2. Task
3. Sub-task

This scripted field will display the Epic on the Task and Sub-task work items.

## Good to Know

The field that this script will evaluate should be configured to use a 'paragraph' return type.

## Script

```groovy
// Set your target parent work type (e.g., "Task", "Epic")
final String TARGET_WORK_TYPE = "Epic"
// Set how far up the hierarchy to check
final int MAX_DEPTH = 10

Map findParentOfType(String currentWorkItemKey, String targetType, int maxDepth, int depth = 0) {
    if (depth >= maxDepth) {
        return null
    }

    def workItemResponse = get("/rest/api/3/issue/${currentWorkItemKey}")
            .queryString('fields', 'parent,issuetype,summary,key')
            .asObject(Map)

    if (workItemResponse.status != 200) {
        return null
    }

    def currentWorkItem = workItemResponse.body as Map
    def fields = currentWorkItem.fields as Map

    // Only check the current work item's type if we're not on the first call (depth > 0)
    // This ensures we never return the starting work item, only its parents/ancestors
    if (depth > 0) {
        def workItemType = fields.issuetype as Map

        if (workItemType.name == targetType) {
            return [
                    key: currentWorkItem.key,
                    summary: fields.summary
            ]
        }
    }

    // Check for parent
    def parent = fields.parent as Map

    if (!parent) {
        return null
    }

    // Recurse with the parent's key
    return findParentOfType(parent.key as String, targetType, maxDepth, depth + 1)
}

// Use the current work item from the scripted field binding
def parentWorkItem = findParentOfType(issue.key as String, TARGET_WORK_TYPE, MAX_DEPTH)

if (parentWorkItem) {
    def parentKey = parentWorkItem.key
    def parentSummary = parentWorkItem.summary as String

    return [
            version: 1,
            type   : "doc",
            content: [
                    [
                            type   : "paragraph",
                            content: [
                                    [
                                            type : "text",
                                            text : "${parentKey} - ${parentSummary}",
                                            marks: [
                                                    [
                                                            type : "link",
                                                            attrs: [
                                                                    href: "${baseUrl}/browse/${parentKey}"
                                                            ]
                                                    ]
                                            ]
                                    ]
                            ]
                    ]
            ]
    ]
} else {
    return [
            version: 1,
            type   : "doc",
            content: [
                    [
                            type   : "paragraph",
                            content: [
                                    [
                                            type: "text",
                                            text: "No Parent Found"
                                    ]
                            ]
                    ]
            ]
    ]
}
```

