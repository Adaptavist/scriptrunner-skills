# Get Jira Version

- Platform: cloud
- Feature: script-console
- Tags: automate, system
- Language: groovy
- Doc ID: example-cloud-get-jira-version-cloud
- Source: https://examples.scriptrunner.io/scripts/get-jira-version-cloud

## Overview

This is a get request to the serverInfo resource as an example we see how to add a query string parameter of `doHeathCheck` and set it to `true`

## Description

#### Overview

This is a get request to the serverInfo resource as an example we see how to add a query string parameter of `doHeathCheck` and set it to `true`

## Script

```groovy
get('/rest/api/2/serverInfo')
    .queryString('doHealthCheck', 'true')
    .asObject(Map)
    .body
    .version
```

