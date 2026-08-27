# Number of Linked Alerts - ITSM

- Platform: data-center
- Feature: script-fields
- Tags: customise, workflow
- Language: groovy
- Doc ID: example-dataCenter-itsm-lab-4-number-of-linked-alerts-onPrem
- Source: https://examples.scriptrunner.io/scripts/itsm-lab-4-number-of-linked-alerts-onPrem

## Overview

Count and display (using a Custom Script Field with a _Number Field_ template) the number of issues with an _Alert_
issue type that are linked with a _Problem/Incident_ to another issue.

* Navigate to **Add-ons** > **Script Fields** using the **Administration Cog** in the top right corner.
* Click **Add New Item** and choose **Custom Script Field**.
* Configure the screen and add the code.
* Click **Add**.

## Example

Detailed use case example: [Adding Scripted Fields to Count Alerts](http://hub.adaptavist.com/hubfs/Belgium%20Event%20-%202018/Lab%204%20Adding%20Scripted%20Fields%20to%20Count%20Alerts.pdf)

## Description

#### Overview

Count and display (using a Custom Script Field with a _Number Field_ template) the number of issues with an _Alert_
issue type that are linked with a _Problem/Incident_ to another issue.

* Navigate to **Add-ons** > **Script Fields** using the **Administration Cog** in the top right corner.
* Click **Add New Item** and choose **Custom Script Field**.
* Configure the screen and add the code.
* Click **Add**.

#### Example

Detailed use case example: [Adding Scripted Fields to Count Alerts](http://hub.adaptavist.com/hubfs/Belgium%20Event%20-%202018/Lab%204%20Adding%20Scripted%20Fields%20to%20Count%20Alerts.pdf)

## Script

```groovy
import com.atlassian.jira.component.ComponentAccessor

final alertIssueType = 'Alert'
final linkNamesForIncident = ['Problem/Incident']

ComponentAccessor.issueLinkManager
    .getOutwardLinks(issue.id)
    .findAll { it.issueLinkType.name in linkNamesForIncident && it.destinationObject.issueType.name == alertIssueType }
    .size()
```

