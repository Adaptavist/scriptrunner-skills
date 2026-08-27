# Copy Versions from one Space to Another

- Platform: cloud
- Feature: script-console
- Tags: automate
- Language: groovy
- Doc ID: example-cloud-copy-project-versions-cloud
- Source: https://examples.scriptrunner.io/scripts/copy-project-versions-cloud

## Overview

Bulk copy all versions from a source space to a destination space.

## Example

As a project manager, I want to apply the same versions to different spaces.
I can copy all versions existing in a source space to a destination space.

## Good to Know

* Versions with the same name should not already exist in the destination space.
* You can fine-tune the versions and data to copy based on specific logic. Check the versions properties at
  the REST API [documentation](https://developer.atlassian.com/cloud/jira/platform/rest/v2/api-group-project-versions/#api-group-project-versions).

## Script

```groovy
// Specify the master space  to get the versions form
final sourceSpaceKey = 'SRC'

// Specify the key of the space to copy the version to
final destinationSpaceKey = 'DST'

// Get the space versions
def versions = get("/rest/api/2/project/${sourceSpaceKey}/versions")
    .header('Content-Type', 'application/json')
    .asObject(List).body as List<Map>

// Loop over each version returned and create a version in the new space
def successStatusByVersionId = versions.collectEntries { version ->
    // Copy the version and specify the destination space
    def versionCopy = version.subMap(['name', 'description', 'archived', 'released', 'startDate', 'releaseDate', 'project'])
    versionCopy['project'] = destinationSpaceKey

    // Make the rest call to create the version
    logger.info("Copying the version with id '${version.id}' and name '${version.name}'")
    def createdVersionResponse = post('/rest/api/2/version')
        .header('Content-Type', 'application/json')
        .body(versionCopy)
        .asObject(Map)

    // Log out the versions copied or which failed to be copied
    if (createdVersionResponse.status == 201) {
        logger.info("Version with id '${version.id}' and name '${version.name}' copied. New id: ${createdVersionResponse.body.id}")
    } else {
        logger.warn("Failed to copy version with id '${version.id}' and name '${version.name}'. ${createdVersionResponse.status}: ${createdVersionResponse.body}")
    }

    [(version.id): (createdVersionResponse.status == 201)]
}

"Status by source version id (copied?): ${successStatusByVersionId}"
```

