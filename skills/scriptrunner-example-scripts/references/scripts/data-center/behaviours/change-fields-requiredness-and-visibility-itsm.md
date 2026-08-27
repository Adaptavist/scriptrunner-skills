# Change Field's Requiredness and Visibility - ITSM

- Platform: data-center
- Feature: behaviours
- Tags: customise, issue
- Language: groovy
- Doc ID: example-dataCenter-itsm-lab-1-field-required-behaviour-onPrem
- Source: https://examples.scriptrunner.io/scripts/itsm-lab-1-field-required-behaviour-onPrem

## Overview

Set up a behaviour that changes the visibility of a field depending on the priority of an issue.

* Navigate to **Add-ons** > **Behaviours**, using the **Administration Cog** in the top right corner.
* Under _Add Behaviour_, enter a **Name** and **Description**.
* Click **Add**.
* Click on the **Fields** option for the newly created behaviour. Add the behaviour to the *Priority* field by choosing it from the drop-down list and clicking **Add**.
* Select **Add Server-Side Script**.
* The inline script should appear, paste this code snippet into it.

## Example

Detailed use case example: [Adding Behaviours to The Customer Portal](https://hub.adaptavist.com/hubfs/Lab%201%20Adding%20Behaviours%20to%20The%20Customer%20Portal.pdf)

## Description

#### Overview

Set up a behaviour that changes the visibility of a field depending on the priority of an issue.

* Navigate to **Add-ons** > **Behaviours**, using the **Administration Cog** in the top right corner.
* Under _Add Behaviour_, enter a **Name** and **Description**.
* Click **Add**.
* Click on the **Fields** option for the newly created behaviour. Add the behaviour to the *Priority* field by choosing it from the drop-down list and clicking **Add**.
* Select **Add Server-Side Script**.
* The inline script should appear, paste this code snippet into it.

#### Example

Detailed use case example: [Adding Behaviours to The Customer Portal](https://hub.adaptavist.com/hubfs/Lab%201%20Adding%20Behaviours%20to%20The%20Customer%20Portal.pdf)

## Script

```groovy
import com.atlassian.jira.issue.priority.Priority
import com.onresolve.jira.groovy.user.FieldBehaviours
import groovy.transform.BaseScript

@BaseScript FieldBehaviours fieldBehaviours

def priorityField = getFieldById(fieldChanged)
def customField = getFieldByName("Number Field")
def priorityValue = priorityField.value as Priority

priorityValue.name == "Highest" ?
    customField.setRequired(true).setHidden(false) :
    customField.setRequired(false).setHidden(true)
```

