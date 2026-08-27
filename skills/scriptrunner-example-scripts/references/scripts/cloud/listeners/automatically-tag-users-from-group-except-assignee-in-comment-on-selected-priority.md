# Automatically tag users from group except assignee in comment on selected priority

- Platform: cloud
- Feature: listeners
- Tags: automate, user, hapi
- Language: groovy
- Doc ID: example-cloud-Automatically-tag-users-from-group-except-assignee-in-comment-cloud
- Source: https://examples.scriptrunner.io/scripts/Automatically-tag-users-from-group-except-assignee-in-comment-cloud

## Overview

This script shows how to tag users from a group in comment using [Atlassian Document Format (ADF)](https://developer.atlassian.com/cloud/jira/platform/apis/document/structure/).

It also avoid tagging the assignee if the assignee is also in the group.

## Example

As a product manager, I want to ensure all technical leads are notified of all work items in Highest priority by mentioning them in a comment.

They can then decide to watch the work item, participate in the conversation or other actions accordingly.

I also want to avoid tagging the same technical lead if he is already the assignee of the work item.

## Good to Know

* This script should be set as listener for Issue Created and Issue Updated event.
* The listener should also be run as ScriptRunner Add-On User as it requires permissions to retrieve group members.

## Script

```groovy
final GROUP_NAMES = ["jira-space-leads"]

def workItemKey = issue.key
def assignee = issue.fields.assignee

def priorityChange = changelog?.items.find { it['field'] == 'priority' }

if (!priorityChange) {
    logger.info("Priority was not updated")
    return
}
logger.info("Priority changed from {} to {}", priorityChange.fromString, priorityChange.toString)

if (priorityChange.toString == "Highest") {
    def userListFromGroup = []

    GROUP_NAMES.each { groupName ->
        def groupMembers = Groups.getByName(groupName).getMembers()
        userListFromGroup.addAll(groupMembers)
    }

    def tags = userListFromGroup.findAll { user -> user.accountId != assignee.accountId }.collect { user ->
        [
            "type": "mention",
            "attrs": [
                "id": user.accountId,
                "text": "@" + user.displayName,
                "accessLevel": ""
            ]
        ]
    }

    def body = [ "body": [
        "version": 1,
        "type": "doc",
        "content": [
            [
                "type": "paragraph",
                "content": tags + [
                    [
                        "type": "text",
                        "text": " This work item requires your attentions."
                    ]
                ]
            ]
        ]
    ]]

    def postCommentResp = post("/rest/api/3/issue/${workItemKey}/comment")
        .header('Content-Type', 'application/json')
        .body(body)
        .asObject(Map)

    assert postCommentResp.status == 201
}
```

