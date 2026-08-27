# Focus or hide screenTabs conditionally based on view

- Platform: cloud
- Feature: behaviours
- Tags: automate, issue
- Language: typescript
- Doc ID: example-cloud-behaviours-screenTab-support-script-cloud
- Source: https://examples.scriptrunner.io/scripts/behaviours-screenTab-support-script-cloud

## Overview

With this script, you can focus or hide screenTabs conditionally based on the view and action (Load or Create), by simply typing the name of the screenTab in brackets (without quotes). 
The script will locate the screenTab you have created, or a preexisting one, and  applying any actions you have written in your behaviour.

## Example

I want to focus on a screenTab and hide other screenTabs when creating a work item.

## Good to Know

Ensure that the screenTabs you want to interact with are present and have been created beforehand. The script checks for existence before executing.
You can simply type the name of the screenTab in the parentheses and the script console will find the screenTab ID for you.

## Script

```typescript
// Retrieve the "Admin" screenTab by its ID
const adminTab = getScreenTabById("10083"); // Replace with your actual screen tab

// Retrieve the "General" screenTab by its ID
const generalTab = getScreenTabById("10000"); // Replace with your actual screen tab

// Retrieve the "Complete" screenTab by its ID
const completeTab = getScreenTabById("10084"); // Replace with your actual screen tab

// Focus on the "Admin" screenTab if it exists
adminTab?.focus();

// Hide the "General" screenTab if it exists
generalTab?.setVisible(false);

// Hide the "Complete" screenTab if it exists
completeTab?.setVisible(false);
```

