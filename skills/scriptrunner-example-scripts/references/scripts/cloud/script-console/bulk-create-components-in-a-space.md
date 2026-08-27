# Bulk Create Components in a Space

- Platform: cloud
- Feature: script-console
- Tags: manage, hapi
- Language: groovy
- Doc ID: example-cloud-bulk-create-components-in-a-project-cloud
- Source: https://examples.scriptrunner.io/scripts/bulk-create-components-in-a-project-cloud

## Overview

You can use this script to automatically insert Components inside a space.

## Example

As admin, I would like to bulk add [Components](https://confluence.atlassian.com/adminjiraserver/managing-components-938847187.html)
to a space.

## Good to Know

* You must specify your own 'components', 'accountId', and 'projKey'.
* You can change the 'assigneeType' from 'PROJECT_DEFAULT' to other parameters such as 'COMPONENT_LEAD'
, 'PROJECT_LEAD' or 'UNASSIGNED' depending on your default assignee configuration.

## Script

```groovy
def projKey = '<YOUR_PROJ_KEY>'
def components = ['User Interface (UI)', 'Database', 'API', 'Security', 'Analytics', 'Messaging', 'Infrastructure', 'Company Website / Blog', 'YouTube Videos', 'Web Advertising', 'Partner Websites', 'Networking', 'Systems', 'Software', 'Hardware']

components.each { component ->
    Components.create(projKey,component)
}
```

