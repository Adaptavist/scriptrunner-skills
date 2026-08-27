# Automatically Update the Assignee of an Issue in Jira

- Platform: data-center
- Feature: script-console
- Tags: administer, user, issue, hapi
- Language: groovy
- Doc ID: example-dataCenter-basics-updating-assignee-onPrem
- Source: https://examples.scriptrunner.io/scripts/basics-updating-assignee-onPrem

## Overview

Automatically update the Assignee field of an issue in Jira.

## Example

I can use this snippet as part of a larger script, so if an issue isn't updated within seven days, the assignee changes automatically.

## Description

#### Overview

Automatically update the Assignee field of an issue in Jira.

#### Example

I can use this snippet as part of a larger script, so if an issue isn't updated within seven days, the assignee changes automatically.

## Script

```groovy
Issues.getByKey('SR-1').update {
    setAssignee('jdoe')
}
```

