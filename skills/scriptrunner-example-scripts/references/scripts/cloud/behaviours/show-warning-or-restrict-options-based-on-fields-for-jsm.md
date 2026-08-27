# Show warning or restrict options based on fields for JSM

- Platform: cloud
- Feature: behaviours
- Tags: automate, fields
- Language: typescript
- Doc ID: example-cloud-show-warning-or-restrict-options-based-on-fields-cloud
- Source: https://examples.scriptrunner.io/scripts/show-warning-or-restrict-options-based-on-fields-cloud

## Overview

With this script, when a selection is made on a select field. It will show a warning or restrict the options based on the selection made.

## Example

I want to show a warning or restrict the options based on the selections made in the Transport and Level fields.

## Good to Know

* Ensure the fields on which you want to apply this script are present on the screen.
* Replace the custom field IDs in the script with the ones from your Jira instance.

## Script

```typescript
const rules = {
    Employee: {
        Plane: ["Economy"],
        Train: ["Economy"]
    },
    Manager: {
        Plane: ["Economy", "Premium Economy"],
        Train: ["Economy"]
    },
    Leadership: {
        Plane: ["Economy", "Premium Economy", "Business"],
        Train: ["Economy", "Business"]
    },
    "Executive Leadership": {
        Plane: ["Economy", "Premium Economy", "Business", "First"],
        Train: ["Economy", "Business"]
    }
};

// Options available per transport
const optionsByTransport = {
    Plane: ["Economy", "Premium Economy", "Business", "First"],
    Train: ["Economy", "Business"]
};

// Replace with your actual field IDs
const ticketFieldId = "customfield_11581";
const contextId = "12717"; // Find this at /rest/api/3/field/YOUR_FIELD_ID/context
const levelField = getFieldById("customfield_11579");
const transportField = getFieldById("customfield_11580");
const ticketField = getFieldById(ticketFieldId);

const level = levelField.getValue();
const transport = transportField.getValue();
const ticket = ticketField.getValue();

if (!level || !transport) {
    ticketField.setDescription('');
} else {
    // Filter options by transport
    const transportOptions = optionsByTransport[transport.value] ?? [];

    // Get the field options
    const fieldOptions = await makeRequest(
        `/rest/api/3/field/${ticketFieldId}/context/${contextId}/option`
    );

    if (fieldOptions.status === 200) {
        const allOptions = fieldOptions.body.values;
        const visibleOptionIds = allOptions
            .filter(option => transportOptions.includes(option.value))
            .map(option => option.id);
        ticketField.setOptionsVisibility(visibleOptionIds, true);
    } else {
        logger.warn("Unable to fetch field options");
    }

    // Show a warning if the selected ticket class exceeds what their level allows
    const allowedClassNames = rules[level.value]?.[transport.value] ?? [];
    if (ticket && !allowedClassNames.includes(ticket.value)) {
        const maxAllowed = allowedClassNames[allowedClassNames.length - 1];
        let message = `❌ Your maximum allowed ticket class for ${transport.value} travel is ${maxAllowed}.`;

        if (transport.value === "Train" && ticket.value === "First") {
            message = "❌ First Class is not available for train travel. Maximum available class is Business.";
        } else if (ticket.value === "Business" && level.value === "Manager") {
            message = "❌ Business Class requires Leadership level or above.";
        } else if (ticket.value === "First" && level.value !== "Executive Leadership") {
            message = "❌ First Class is only available for Executive Leadership.";
        }
        ticketField.setDescription(message);
    } else {
        ticketField.setDescription('');
    }
}
```

