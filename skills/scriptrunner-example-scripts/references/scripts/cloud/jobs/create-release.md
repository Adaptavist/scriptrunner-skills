# Create Release

- Platform: cloud
- Feature: jobs
- Tags: automate, project
- Language: groovy
- Doc ID: example-cloud-create-release-cloud
- Source: https://examples.scriptrunner.io/scripts/create-release-cloud

## Overview

This example shows you can create a new release for a version.

## Example

I am in charge of setting up Jira spaces. The current team release software on a weekly basis, this script allows
me to version the jira space once a week. This is inline with our release cycle

## Description

#### Overview

This example shows you can create a new release for a version.

#### Example

I am in charge of setting up Jira spaces. The current team release software on a weekly basis, this script allows
me to version the jira space once a week. This is inline with our release cycle

## Script

```groovy
import java.util.Calendar

def now = Calendar.getInstance()
def version = String.format("%d-%02d-%02d", now.get(Calendar.YEAR), now.get(Calendar.MONTH), now.get(Calendar.DAY_OF_MONTH))

post("/rest/api/2/version")
        .header('Content-Type', 'application/json')
        .body([
                name: "Version ${version}",
                archived: false,
                released: true,
                releaseDate: version,
                project: "EXAMPLE"
        ])
        .asString()
```

