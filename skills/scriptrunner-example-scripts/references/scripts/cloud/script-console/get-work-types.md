# Get Work Types

- Platform: cloud
- Feature: script-console
- Tags: hapi, automate
- Language: groovy
- Doc ID: example-cloud-get-issue-types-cloud
- Source: https://examples.scriptrunner.io/scripts/get-issue-types-cloud

## Overview

This example shows how you can retrieve all of the work types from a specified space.

## Description

#### Overview
This example shows how you can retrieve all of the work types from a specified space.

## Script

```groovy
Spaces.getByKey("SPACE_KEY").getWorkTypes()
```

