# Create a Time Logging Work Item

- Platform: cloud
- Feature: jobs
- Tags: automate, organise, manage, hapi
- Language: groovy
- Doc ID: example-cloud-create-a-time-logging-issue-cloud
- Source: https://examples.scriptrunner.io/scripts/create-a-time-logging-issue-cloud

## Overview

This script demonstrates how to create a new Time Logging work item within a specific space. 
It's ideal for teams looking to track time spent on various space tasks or phases in a streamlined way.

## Description

#### Overview
This script demonstrates how to create a new Time Logging work item within a specific space. 
It's ideal for teams looking to track time spent on various space tasks or phases in a streamlined way.

## Script

```groovy
import java.util.Calendar
import java.util.Locale

def now = Calendar.getInstance()
def month = now.getDisplayName(Calendar.MONTH, Calendar.LONG, Locale.getDefault())

def spaceKey = 'DEMO'
WorkItems.create(spaceKey, "Time Logging"){
    setSummary("Time logging for ${month}")
    setDescription("Log development time here for ${month}")
}
```

