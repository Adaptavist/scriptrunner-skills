# Add the current user as a watcher

- Platform: cloud
- Feature: listeners
- Tags: automate, issue, hapi
- Language: groovy
- Doc ID: example-cloud-add-current-user-as-a-watcher-cloud
- Source: https://examples.scriptrunner.io/scripts/add-current-user-as-a-watcher-cloud

## Overview

Checks the list of users assignable to a work item and compares them with the current logged-in user. 
If the current user is assignable, they are automatically added as a watcher on the work item.

## Example

I am a project manager, and I want to ensure I stay updated on the progress of work items I can be assigned to. 
I can use this script to automatically add myself as a watcher whenever I create or access a work item.

## Good to Know

* The script only works if the current user is assignable on the work item. If they’re not, they won’t be added as a watcher.

## Script

```groovy
final workItemKey = issue.key
def currentUser = Users.getLoggedInUser()

def watcherResp = post("/rest/api/2/issue/${workItemKey}/watchers")
    .header('Content-Type', 'application/json')
    .body("\"${currentUser.accountId}\"")
    .asObject(List)

if (watcherResp.status == 204) {
    logger.info("Successfully added ${currentUser.displayName} as watcher of ${workItemKey}")
} else {
    logger.error("Error adding watcher: ${watcherResp.body}")
}
```

