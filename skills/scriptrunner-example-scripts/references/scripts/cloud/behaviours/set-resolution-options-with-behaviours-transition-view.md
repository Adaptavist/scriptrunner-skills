# Set Resolution Options with Behaviours (Transition View)

- Platform: cloud
- Feature: behaviours
- Tags: automate, workflow, fields, issue
- Language: typescript
- Doc ID: example-cloud-filter-resolution-for-issue-type-cloud
- Source: https://examples.scriptrunner.io/scripts/filter-resolution-for-issue-type-cloud

## Overview

This Behaviours script dynamically adjusts the "resolution" field options in the Transition View based on the work item type.

## Good to Know

- Setting specific options to visible automatically hides the remaining options.
- The script fetches all resolutions to filter by name. For improved performance, consider filtering directly by resolution IDs.
- Customizable for different work item types (currently set up for "bug" and "task").
- To filter using the work item type, the work item type field needs to be configured on the screen to access its value.

## Description

#### Overview
This Behaviours script dynamically adjusts the "resolution" field options in the Transition View based on the work item type. 

#### Use Case
As a Jira Administrator, you can use this script to tailor the "resolution" field options presented to users during work item transitions. The available options will vary depending on whether the work item is classified as a bug, task, or another type.
This can be useful in a system where many resolutions are configured to make it easier to select relevant resolutions.

#### Good to know
- Setting specific options to visible automatically hides the remaining options.
- The script fetches all resolutions to filter by name. For improved performance, consider filtering directly by resolution IDs.
- Customizable for different work item types (currently set up for "bug" and "task").
- To filter using the work item type, the work item type field needs to be configured on the screen to access its value.

## Script

```typescript
// Fetch the resolution field
const resolutionField = getFieldById("resolution");

// Fetch all available resolutions
const resolutions = await getAllResolutions();

// Get the work item type name (lowercase) - this requires the work item type field to be configured on the screen
const workItemType = getFieldById("issuetype").getValue().name.toLowerCase();

// Define resolutions to show based on work item type
let resolutionsToShow = [];
switch (workItemType) {
    case "bug":
        resolutionsToShow = ["Done", "Cannot Reproduce", "Fixed in Future Release"];
        break;
    case "task":
        resolutionsToShow = ["Completed", "Obsolete", "Duplicate"];
        break;
    // You might want to add a default case here if needed
    default:
        resolutionsToShow = ["Completed"];
        break;
}

// Only set visibility if resolutionsToShow is not empty
if (resolutionsToShow.length > 0) {
    // Set the visibility of the specified resolutions in the resolution field
    resolutionField.setOptionsVisibility(
        resolutions
            // Filter the resolutions array to keep only those whose names are in the resolutionsToShow array
            .filter(resolution => resolutionsToShow.includes(resolution.name))
            // Transform the filtered array of resolution objects to an array of resolution IDs 
            .map(resolution => resolution.id),
        true // Set the visibility to true for the filtered and mapped resolution IDs
    );
}

/**
 * Asynchronously fetches all resolutions from the Jira API.
 * Uses pagination to retrieve all resolutions if they span multiple pages.
 *
 * @param {number} startAt - The starting index for the API request (default: 0).
 * @param {Array} fields - An array to accumulate fetched resolution data (default: []).
 * @returns {Array} An array of all resolution objects.
 */
async function getAllResolutions(startAt = 0, fields = []) {
    // Make an API request to fetch resolutions starting from the specified index
    const res = await makeRequest(`/rest/api/3/resolution/search?startAt=${startAt}`);

    if (res.status === 200) {
        const data = res.body;

        // Accumulate the fetched resolution values
        fields = [...fields, ...data.values];

        if (data.isLast) {
            return fields; // Return accumulated resolutions if this is the last page
        } else {
            // Recursively fetch the next page of resolutions
            return await getAllResolutions(startAt + data.maxResults, fields);
        }
    } else {
        // Log a warning if the API request fails
        logger.warn("Unable to fetch resolutions from Behaviours");
        return []; // Return an empty array in case of failure
    }
}
```

