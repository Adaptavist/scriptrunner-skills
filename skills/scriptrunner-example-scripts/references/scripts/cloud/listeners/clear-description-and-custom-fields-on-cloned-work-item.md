# Clear Description and Custom Fields on Cloned Work Item

- Platform: cloud
- Feature: listeners
- Tags: issue, hapi, automate
- Language: groovy
- Doc ID: example-cloud-clear-description-and-custom-fields-on-cloned-issue-cloud
- Source: https://examples.scriptrunner.io/scripts/clear-description-and-custom-fields-on-cloned-issue-cloud

## Overview

This script is configured to trigger on the "Issue Link Created" event, specifically when work items are cloned. 
It demonstrates how to programmatically clear the Description field and selected custom fields—such as single-line text fields—on the newly cloned work item. 
This is useful for ensuring that sensitive or irrelevant information from the original work item is not carried over to the clone.

## Good to Know

- Triggered by the "Issue Link Created" event.
- Only runs when the link type is "Cloners" (used during work item cloning).
- Updates apply only to the cloned work item, not the original.

## Description

#### Overview
This script is configured to trigger on the "Issue Link Created" event, specifically when work items are cloned. 
It demonstrates how to programmatically clear the Description field and selected custom fields—such as single-line text fields—on the newly cloned work item. 
This is useful for ensuring that sensitive or irrelevant information from the original work item is not carried over to the clone.

#### Good to know
- Triggered by the "Issue Link Created" event.
- Only runs when the link type is "Cloners" (used during work item cloning).
- Updates apply only to the cloned work item, not the original.

## Script

```groovy
if (issueLink.issueLinkType.name == "Cloners") {
    logger.info("The work item has been cloned, clearing specified fields on the source work item")
    if (issueLink.sourceIssueId) {
        WorkItems.getByKey(issueLink.sourceIssueId as String).update {
            clearCustomField("Description")
            clearCustomField("<SpecifyOtherCustomFieldNamesHere>")
        }
    }
    else {
        logger.warn("Could not find the source work item with ID: ${issueLink.sourceIssueId}")
    }
} else {
    logger.info("The work item has not been cloned so do nothing")
}
```

