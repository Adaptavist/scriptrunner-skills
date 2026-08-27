# Add Comment to an Issue with Visibility Restrictions

- Platform: data-center
- Feature: script-console
- Tags: automate, workflow, user, hapi
- Language: groovy
- Doc ID: example-dataCenter-add-comment-visibility-restrictions-onPrem
- Source: https://examples.scriptrunner.io/scripts/add-comment-visibility-restrictions-onPrem

## Overview

Create a comment on an issue and specify the groups or roles than can view it. 
For Jira Service Management projects, mark the comment as "Internal", meaning only **agents** can view it.

You may only specify one of roles, groups, or internal.

The same syntax can be used in a post-function, see [Add Comment to an Issue in a Post Function](https://library.adaptavist.com/entity/add-comment-post-function).

## Description

#### Overview

Create a comment on an issue and specify the groups or roles than can view it. 
For Jira Service Management projects, mark the comment as "Internal", meaning only **agents** can view it.

You may only specify one of roles, groups, or internal.

The same syntax can be used in a post-function, see [Add Comment to an Issue in a Post Function](https://library.adaptavist.com/entity/add-comment-post-function).

## Script

```groovy
def issue = Issues.getByKey('SR-1')

issue.addComment('My comment') {
    // set the group that can view the comment
    setGroupRestriction('jira-administrators')

    // set the role that can view the comment
    // setProjectRoleRestriction('Developers')

    // for Jira Service Management projects, mark the comment as "Internal"
    // internal()
}
```

