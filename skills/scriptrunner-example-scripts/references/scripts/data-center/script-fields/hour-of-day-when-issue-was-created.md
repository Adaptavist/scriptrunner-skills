# Hour of day when issue was created

- Platform: data-center
- Feature: script-fields
- Tags: issue
- Language: groovy
- Doc ID: example-dataCenter-hour-of-day-when-issue-was-created-onPrem
- Source: https://examples.scriptrunner.io/scripts/hour-of-day-when-issue-was-created-onPrem

## Overview

This script allows you to easily calculate how many hours after the start of a working day an issue was created.

## Example

I have an SLA with my clients which we need to adhere to, part of this SLA is knowing how many hours an issue was created after the start of the working day. However, Jira is not configured to provide this information, so this script has helped me with my reporting and time keeping.

## Good to Know

* This script considers the users time zone.

## Script

```groovy
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.timezone.TimeZoneManager

import java.time.ZonedDateTime

import static java.time.temporal.ChronoUnit.HOURS

TimeZoneManager tzm = ComponentAccessor.getComponent(TimeZoneManager)

ZonedDateTime creationTime = ZonedDateTime.ofInstant(issue.created.toInstant(), tzm.loggedInUserTimeZone.toZoneId())
ZonedDateTime startOfDay = creationTime.toLocalDate().atStartOfDay(creationTime.zone)

HOURS.between(startOfDay, creationTime)
```

