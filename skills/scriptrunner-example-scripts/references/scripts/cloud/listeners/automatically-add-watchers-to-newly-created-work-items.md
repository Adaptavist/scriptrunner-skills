# Automatically add Watchers to Newly Created Work Items

- Platform: cloud
- Feature: listeners
- Tags: automate, issue
- Language: groovy
- Doc ID: example-cloud-add-watchers-to-newly-created-issues-cloud
- Source: https://examples.scriptrunner.io/scripts/add-watchers-to-newly-created-issues-cloud

## Overview

Watching helps users stay up-to-date with the progress of a work item from the point of discovery to resolution. Enter a
user name into this script to automatically add the user as a watcher when a new work item is created.

## Example

I am a project manager, and I want to ensure the technical lead is watching all work items in their sprint so they can keep
informed throughout a work items progress. I can use this script to automatically add that user as a watcher on all new
work items created.

## Good to Know

* This script can bet set as a listener for `Issue Created` event.
* Add as many user names as required by adding them to `userNames`.
* Users are only added if they are assignable to the work item.
* To retrieve the user name:
  * Navigate to the _People_ section (`https://********.atlassian.net/people/`) and select a user. The name is displayed
  in the page.

## Script

```groovy
final workItemKey = issue.key

def result = get('/rest/api/2/user/assignable/search')
    .queryString('issueKey', "${workItemKey}")
    .header('Content-Type', 'application/json')
    .asObject(List)

assert result.status == 200

def usersAssignableToWorkItem = result.body as List<Map>

// A valid user name and an invalid one will try to be added
def userNames = ['valid-user-name', 'not-user-name']

usersAssignableToWorkItem.forEach { Map user ->
    def displayName = user.displayName as String
    if (displayName in userNames) {
        def accountId = user.accountId
        def watcherResp = post("/rest/api/2/issue/${workItemKey}/watchers")
            .header('Content-Type', 'application/json')
            .body("\"${accountId}\"")
            .asObject(List)

        if (watcherResp.status == 204) {
            logger.info("Successfully added ${displayName} as watcher of ${workItemKey}")
        } else {
            logger.error("Error adding watcher: ${watcherResp.body}")
        }
    } else {
        logger.error("The ${displayName} user has not been added as a watcher")
    }
}
```

