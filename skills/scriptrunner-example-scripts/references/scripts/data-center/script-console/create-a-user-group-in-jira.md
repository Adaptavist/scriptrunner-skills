# Create a User Group in Jira

- Platform: data-center
- Feature: script-console
- Tags: administer, user
- Language: groovy
- Doc ID: example-dataCenter-basics-create-group-onPrem
- Source: https://examples.scriptrunner.io/scripts/basics-create-group-onPrem

## Overview

In addition to creating users in Jira, it is often necessary to create groups when multiple users in your instance need the same permissions or restrictions. This snippet allows you to create a new group and can be modified to bulk add users in Jira.

## Example

I am a project manager and I have been assigned a new project. I need to create a group in Jira with all of the team. I can use this snippet to create a new group, then modify this script to add members of the team automatically.

## Description

#### Overview

 In addition to creating users in Jira, it is often necessary to create groups when multiple users in your instance need the same permissions or restrictions. This snippet allows you to create a new group and can be modified to bulk add users in Jira.

#### Example

I am a project manager and I have been assigned a new project. I need to create a group in Jira with all of the team. I can use this snippet to create a new group, then modify this script to add members of the team automatically.

## Script

```groovy
import com.atlassian.jira.component.ComponentAccessor

// the name of the new group
final String groupName = "A new Group"

ComponentAccessor.groupManager.createGroup(groupName)
```

