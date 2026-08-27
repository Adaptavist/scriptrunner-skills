# Re-establish Permission Schemes after migrating to Cloud.

- Platform: cloud
- Feature: script-console
- Tags: administer, hapi, automate, project
- Language: groovy
- Doc ID: example-cloud-bulk-change-projects-permission-scheme-cloud-cloud
- Source: https://examples.scriptrunner.io/scripts/bulk-change-projects-permission-scheme-cloud-cloud

## Overview

After migrating our spaces from Server/DC to Cloud, we must return each space to its original Permissions Scheme.
However, as with on-premise, Jira Cloud does not enable us to do this in bulk.

Out-of-the-box, Jira Cloud can only change the Schemes back one by one. This can be time-consuming if there is a large
number of migrated spaces.

This script automates the process and re-establishes the Permission Scheme that corresponds to each space.

## Example

As a Jira administrator, I want to be able to bulk set the Permission Scheme for each space in my
Jira instance after migrating to Cloud.

## Good to Know

- This script has a counterpart that allows us to [assign a read-only permission scheme to all spaces](https://library.adaptavist.com/entity/updates-all-the-projects-provided-with-a-single-permission-scheme). 
- Executing this script provides us with the map necessary for the other one.
- Since the Permission Scheme IDs can vary in Cloud, you will have to find the ID of each corresponding scheme in Cloud.
- A space cannot be assigned to more than one permission scheme.

## Script

```groovy
// Change the keys with the Permission Scheme IDs (first) and the values with the space keys (second) associated with each Permission Scheme ID.
def spacesForPermissionSchemes = [
    10002: ["SPACE_KEY1", "SPACE_KEY2"],
    10003: ["SPACE_KEY3", "SPACE_KEY4"]
]

// Change the Permission Scheme of each space with the map previously defined.
spacesForPermissionSchemes.each { permissionSchemeId, spaceKey ->
    spaceKey.each { spaceKey ->
        try {
            Spaces.getByKey(spaceKey).update {
                setPermissionSchemeId(permissionSchemeId)
            }
            logger.warn "The Permission Scheme for the space ${spaceKey} has been changed to the Scheme with ID ${permissionSchemeId}"
        } catch (Exception e) {
            logger.error "Failed to update space ${spaceKey} with permission scheme ID ${permissionSchemeId}: ${e.message}"
        }
    }
}
```

