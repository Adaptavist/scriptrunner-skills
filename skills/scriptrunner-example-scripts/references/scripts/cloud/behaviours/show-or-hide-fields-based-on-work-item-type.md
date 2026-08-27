# Show or hide fields based on work item type

- Platform: cloud
- Feature: behaviours
- Tags: automate, issue
- Language: typescript
- Doc ID: example-cloud-behaviours-show-hide-fields-based-on-issue-type-cloud
- Source: https://examples.scriptrunner.io/scripts/behaviours-show-hide-fields-based-on-issue-type-cloud

## Overview

Show or hide one or more fields based on the work item type when work item transitions to In Review

## Example

When a work item transition to the 'In review' status, the behaviour will make the screen:
- display the 'Summary of fix' paragraph field if the work item is of type 'Bug'
- display the 'Link to proposal" url field is the work item is of type 'Proposal'
- display the 'Severity' list field if the work item is of type 'Incident'

## Good to Know

- Ensure the fields on which you want to apply this script are present on the screen.

## Script

```typescript
// Define the ID for the "In Review" transition
const transitionToInReview = 41

// Get the transition ID from the current work item context
const transitionId = await getContext().then(context => context.extension.issueTransition.id)

// Get the fields by their custom field IDs
const summaryOfFix = getFieldById("customfield_10053")  // Field for the summary of the fix (used for Bugs)
const linkToProposal = getFieldById("customfield_10054") // Field for the link to a proposal (used for Proposals)
const severity = getFieldById("customfield_10055")       // Field for the severity level (used for Incidents)

// Get the work item type of the current work item
const workItemType = getFieldById("issuetype").getValue().name

// Check if the current transition is the "In Review" transition
if (transitionId == transitionToInReview) {

    // Conditionally show the relevant fields based on the work item type
    summaryOfFix.setVisible(workItemType == "Bug")        // Show "Summary of Fix" if the work item is a Bug
    linkToProposal.setVisible(workItemType == "Proposal") // Show "Link to Proposal" if the work item is a Proposal
    severity.setVisible(workItemType == "Incident")       // Show "Severity" if the work item is an Incident
} else {

    // Hide all fields if the transition is not "In Review"
    summaryOfFix.setVisible(false)
    linkToProposal.setVisible(false)
    severity.setVisible(false)
}
```

