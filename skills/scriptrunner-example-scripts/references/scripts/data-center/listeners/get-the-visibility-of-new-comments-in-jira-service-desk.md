# Get the Visibility of New Comments in Jira Service Desk

- Platform: data-center
- Feature: listeners
- Tags: customise, issue, hapi
- Language: groovy
- Doc ID: example-dataCenter-sd-comment-visibility-onPrem
- Source: https://examples.scriptrunner.io/scripts/sd-comment-visibility-onPrem

## Overview

Comments on Jira Service Management project issues can be public (shared with the customer) or private (internal comments).
With this snippet, you can retrieve the visibility of a comment.

## Example

I want to perform actions based on the issue comment visibility in Jira Service Management, in a *Script Listener*.
For instance, I want to perform some automated task, like create a new comment, when an internal comment is created.

## Description

#### Overview

Comments on Jira Service Management project issues can be public (shared with the customer) or private (internal comments).
With this snippet, you can retrieve the visibility of a comment.

#### Example

I want to perform actions based on the issue comment visibility in Jira Service Management, in a *Script Listener*.
For instance, I want to perform some automated task, like create a new comment, when an internal comment is created.

## Script

```groovy
Issues.getByKey('SR-2').comments.last().isPublic()
```

