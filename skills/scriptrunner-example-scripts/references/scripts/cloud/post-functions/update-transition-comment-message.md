# Update transition comment message

- Platform: cloud
- Feature: post-functions
- Tags: workflow, automate, issue
- Language: groovy
- Doc ID: example-cloud-update-transition-comment-message-cloud
- Source: https://examples.scriptrunner.io/scripts/update-transition-comment-message-cloud

## Overview

This example shows how to update the comment identifying the transition.

## Description

#### Overview

This example shows how to update the comment identifying the transition.

## Script

```groovy
// this only works when there is a transition screen
Map addComment = transition.update.comment[0].add as Map
addComment.body = "${workItem.key} caused this to be transitioned"
```

