# Create a New Fix Version of the Selected Project

- Platform: data-center
- Feature: script-console
- Tags: automate, fields
- Language: groovy
- Doc ID: example-dataCenter-basics-create-fix-version-onPrem
- Source: https://examples.scriptrunner.io/scripts/basics-create-fix-version-onPrem

## Overview

Jira uses versions to keep track of updated/different version of software. This script allows users to create a new label 'New Fix Version' for a project they’re working on.

## Example

There’s a problem with a project; however, I've found a solution and want to make sure the issue is associated with a new fix version. I can use this script to create a new fix version for a project I'm working on, and create a label for the new version of fixing.

## Description

#### Overview

Jira uses versions to keep track of updated/different version of software. This script allows users to create a new label 'New Fix Version' for a project they’re working on.

#### Example

 There’s a problem with a project; however, I've found a solution and want to make sure the issue is associated with a new fix version. I can use this script to create a new fix version for a project I'm working on, and create a label for the new version of fixing.

## Script

```groovy
import com.atlassian.jira.component.ComponentAccessor

// the key of the project under which the version will get created
final String projectKey = "JRA"

// the name of the version - required
final String versionName = "1.0.1"

// the start date - optional
final Date startDate = null

// the release date - optional
final Date releaseDate = null

// a description for the new version - optional
final String description = null

// id of the version to schedule after the given version object - optional
final Long scheduleAfterVersion = null

// true if this is a released version
final boolean released = false

def project = ComponentAccessor.projectManager.getProjectObjByKey(projectKey)
assert project : "Could not find project with key $projectKey"

ComponentAccessor.versionManager.createVersion(versionName, startDate, releaseDate, description, project.id, scheduleAfterVersion, released)
```

