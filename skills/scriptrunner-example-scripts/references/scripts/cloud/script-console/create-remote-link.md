# Create remote link

- Platform: cloud
- Feature: script-console
- Tags: automate, issue
- Language: groovy
- Doc ID: example-cloud-create-remote-link-cloud
- Source: https://examples.scriptrunner.io/scripts/create-remote-link-cloud

## Overview

This script shows how you can create a remote link on a work item to an external resource such as a design page or a Confluence Page.

## Example

As a project manager when creating tickets for frontend design work I want to add a link to the designs in the external UX design tool.

## Good to Know

* This example could be added to a script listener to add external links onto subtasks which get created when the parent work item is created.

## Script

```groovy
// The url for the link
def linkURL = "<LinkURLHere>"

// the title for the link
def linkTitle = "<LinkTitleHere>"

// The work item key
def workItemKey = "<WorkItemKeyHere>"

// Create the link on the specified work item
post("/rest/api/2/issue/${workItemKey}/remotelink")
        .header("Content-Type", "application/json")
        .body([
        object: [
                title:linkTitle,
                url:linkURL
        ]

])
        .asObject(String)
```

