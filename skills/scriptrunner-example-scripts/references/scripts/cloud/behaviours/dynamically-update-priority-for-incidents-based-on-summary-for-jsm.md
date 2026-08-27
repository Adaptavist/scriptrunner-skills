# Dynamically update priority for incidents based on summary for JSM

- Platform: cloud
- Feature: behaviours
- Tags: automate, fields
- Language: typescript
- Doc ID: example-cloud-priority-based-on-summary-cloud
- Source: https://examples.scriptrunner.io/scripts/priority-based-on-summary-cloud

## Overview

This script checks the Summary field for critical keywords. When found, it sets Priority to highest and makes it read-only.
When not found, it keeps Priority editable and defaults to medium if empty.

## Example

Automatically set highest priority for incidents when the summary contains urgent keywords like outage or system down.

## Good to Know

Update the *criticalKeywords* list to match the wording your users use.

## Script

```typescript
// Keywords that should trigger highest priority
const criticalKeywords = [
    'outage',
    'system down',
    'cannot access',
    'critical failure',
    'urgent'
];

const summaryField = getFieldById('summary');
const priorityField = getFieldById('priority');

// Function to check if summary contains any critical keyword
function isCritical(summaryText) {
    if (!summaryText) return false;
    const lowerSummary = summaryText.toLowerCase();
    return criticalKeywords.some(keyword => lowerSummary.includes(keyword));
}

// On change of Summary field
const currentSummary = summaryField.getValue();

if (isCritical(currentSummary)) {
    // Auto-set to Highest
    priorityField.setValue('1');
    priorityField.setReadOnly(true);
    priorityField.setDescription('This request has been classified as critical based on your description.');
} else {
    priorityField.setReadOnly(false);
    priorityField.setDescription('Choose a priority that reflects the business impact.');

    // Default to Medium if not already set
    if (!priorityField.getValue()) {
        priorityField.setValue('3');
    }
}
```

