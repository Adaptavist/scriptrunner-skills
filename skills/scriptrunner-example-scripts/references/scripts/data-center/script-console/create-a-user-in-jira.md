# Create a User in Jira

- Platform: data-center
- Feature: script-console
- Tags: administer, user, hapi
- Language: groovy
- Doc ID: example-dataCenter-basics-create-user-onPrem
- Source: https://examples.scriptrunner.io/scripts/basics-create-user-onPrem

## Overview

Use this script to create users in Jira.

## Description

#### Overview

Use this script to create users in Jira.

## Script

```groovy
import com.atlassian.jira.application.ApplicationKeys

Users.create('jbloggs', 'jbloggs@mail.com', 'Joe Bloggs')

Users.create('bob', 'bob@mail.com', 'Mr Bob') {
    setDirectoryId(1)
    withApplicationAccess(ApplicationKeys.SERVICE_DESK, ApplicationKeys.SOFTWARE)
    setPassword('secret')
}
```

