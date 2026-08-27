# Clear Jira internal caches

- Platform: data-center
- Feature: script-console
- Tags: administer
- Language: groovy
- Doc ID: example-dataCenter-clear-jira-caches-onPrem
- Source: https://examples.scriptrunner.io/scripts/clear-jira-caches-onPrem

## Overview

Clear the Jira caches if you have changed something in the database. 
Expect a delay after executing this.

**NOTE** - Atlassian does not recommend clearing all caches for Jira Data Center.
Instead, Atlassian recommends restarting each node in turn.

## Description

#### Overview

Clear the Jira caches if you have changed something in the database. 
Expect a delay after executing this.

**NOTE** - Atlassian does not recommend clearing all caches for Jira Data Center.
Instead, Atlassian recommends restarting each node in turn.

## Script

```groovy
import com.atlassian.event.api.EventPublisher
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.event.ClearCacheEvent

ComponentAccessor.getComponent(EventPublisher).publish(ClearCacheEvent.INSTANCE)
```

