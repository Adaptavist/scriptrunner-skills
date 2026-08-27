# Remove Specified Users from a Group

- Platform: data-center
- Feature: script-console
- Tags: automate, user, hapi
- Language: groovy
- Doc ID: example-dataCenter-remove-specific-users-onPrem
- Source: https://examples.scriptrunner.io/scripts/remove-specific-users-onPrem

## Overview

Remove specified users from a group using this snippet, meaning they no longer have the permissions associated with the group. 
For example, if a project admin has left a project, use this snippet to remove them from the group with access rights to the project they left.

## Example

I want to ensure users only have access to the projects they are working on currently, enforcing the principle of least privilege.

## Description

#### Overview

Remove specified users from a group using this snippet, meaning they no longer have the permissions associated with the group. 
For example, if a project admin has left a project, use this snippet to remove them from the group with access rights to the project they left.

#### Example

I want to ensure users only have access to the projects they are working on currently, enforcing the principle of least privilege.

## Script

```groovy
def group = Groups.getByName('teams-in-space-admins')
group.remove('jdoe')
group.remove('msmith')
```

