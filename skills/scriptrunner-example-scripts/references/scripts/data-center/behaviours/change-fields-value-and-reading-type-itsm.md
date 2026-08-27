# Change Field's Value and Reading Type - ITSM

- Platform: data-center
- Feature: behaviours
- Tags: customise, issue
- Language: groovy
- Doc ID: example-dataCenter-itsm-lab-2-form-value-and-read-only-behaviour-onPrem
- Source: https://examples.scriptrunner.io/scripts/itsm-lab-2-form-value-and-read-only-behaviour-onPrem

## Overview

Set up a behaviour that will change a field's value and reading type.

* Navigate to **Add-ons** > **Script Fragments**, using the **Administration Cog** in the top right corner.
* Click **Add New Item** and choose **Create Constrained Issue Dialog**.
* Configure the screen.
* Click **Add**.
* Navigate to **Add-ons** > **Behaviours**, using the **Administration Cog** in the top right corner.
* Under _Add Behaviour_, enter a **Name** and **Description**.
* Click **Add**.
* Click on the **Fields** option for the newly created behaviour.
* Now add an initialiser by clicking **Create Initialiser**.
* The inline editor appears, paste the code snippet into it.
* Click **Save** at the bottom of the screen.
* You should get a flag that says the save has been successful.

## Example

Detailed use case example: [Constrained Create Issue Dialog with Behaviours](http://hub.adaptavist.com/hubfs/Belgium%20Event%20-%202018/Lab%202%20Constrained%20Create%20Issue%20Dialog%20with%20Behaviours.pdf)

## Description

#### Overview

Set up a behaviour that will change a field's value and reading type.

* Navigate to **Add-ons** > **Script Fragments**, using the **Administration Cog** in the top right corner.
* Click **Add New Item** and choose **Create Constrained Issue Dialog**.
* Configure the screen.
* Click **Add**.
* Navigate to **Add-ons** > **Behaviours**, using the **Administration Cog** in the top right corner.
* Under _Add Behaviour_, enter a **Name** and **Description**.
* Click **Add**.
* Click on the **Fields** option for the newly created behaviour.
* Now add an initialiser by clicking **Create Initialiser**.
* The inline editor appears, paste the code snippet into it.
* Click **Save** at the bottom of the screen.
* You should get a flag that says the save has been successful.

#### Example

Detailed use case example: [Constrained Create Issue Dialog with Behaviours](http://hub.adaptavist.com/hubfs/Belgium%20Event%20-%202018/Lab%202%20Constrained%20Create%20Issue%20Dialog%20with%20Behaviours.pdf)

## Script

```groovy
import com.atlassian.jira.component.ComponentAccessor
import com.onresolve.jira.groovy.user.FieldBehaviours
import groovy.transform.BaseScript

@BaseScript FieldBehaviours fieldBehaviours

def issueManager = ComponentAccessor.issueManager
//Check to make sure this is the correct context for the behaviour.
if (behaviourContextId == 'CP') {
    //Set the project and issuetype to be readonly so the user cannot alter these.
    getFieldById('project-field').setReadOnly(true)
    getFieldById('issuetype-field').setReadOnly(true)

    //Find the details of the Issue from which the request to link was made
    def contextIssue = issueManager.getIssueObject(contextIssueId)

    //Pre-populate the Summary, issue link and issue link type.
    getFieldById('summary').setFormValue("Problem created from ${contextIssue.key}").setReadOnly(false)
    getFieldById('issuelinks-linktype').setFormValue('Problem for Incident').setReadOnly(true)
    getFieldById('issuelinks-issues').setFormValue(contextIssue.key).setReadOnly(true)
}
```

