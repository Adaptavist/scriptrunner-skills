# Delete Group(s) in Jira

- Platform: data-center
- Feature: script-console
- Tags: administer
- Language: groovy
- Doc ID: example-dataCenter-basics-delete-group-onPrem
- Source: https://examples.scriptrunner.io/scripts/basics-delete-group-onPrem

## Overview

This script is to remove a list of empty groups using Script Console.

## Example

As a Jira admin, I want to remove empty groups.

## Good to Know

* If you want to remove only one group, only add one group in myGroupList variable.
* If you want to remove all groups including non-empty groups, you need to exclude the script from line 19 until 25.

## Script

```groovy
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.bc.group.search.GroupPickerSearchService
import com.atlassian.crowd.embedded.core.util.StaticCrowdServiceFactory

// List of groups that will be removed
final def myGroupList = ['group1', 'group2', 'group3']

def crowdService = StaticCrowdServiceFactory.crowdService
def groupSearch = ComponentAccessor.getComponent(GroupPickerSearchService)
def groupManager = ComponentAccessor.groupManager

for (def group : myGroupList) {
    // Check whether the group exists
    if (!groupManager.allGroupNames.contains(group)) {
        log.warn "Group $group does not exist"
        continue
    }

    // Check if group is not empty
    if (groupManager.getUserNamesInGroup(group).size() != 0) {
        log.warn "Group $group is not empty"
        continue
    }

    // Remove the group and return the status
    def removeStatus = crowdService.removeGroup(groupSearch.getGroupByName(group))

    if (removeStatus) {
        log.warn "Removed group $group"
    }
}
```

