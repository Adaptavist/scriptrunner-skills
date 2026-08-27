# Get current user of the execution

- Platform: cloud
- Feature: script-console
- Tags: user, hapi
- Language: groovy
- Doc ID: example-cloud-get-current-user-of-the-execution-cloud
- Source: https://examples.scriptrunner.io/scripts/get-current-user-of-the-execution-cloud

## Overview

This script demonstrates how to get the user details that executes the code.

## Example

I want to check who is executing the code.

## Good to Know

The user is a person that initializes the execution.

## Script

```groovy
Users.getLoggedInUser()
```

