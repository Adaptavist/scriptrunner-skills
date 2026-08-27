# Change the display name of the default named priority field

- Platform: cloud
- Feature: behaviours
- Tags: automate, issue
- Language: typescript
- Doc ID: example-cloud-change-display-of-priority-field-cloud
- Source: https://examples.scriptrunner.io/scripts/change-display-of-priority-field-cloud

## Overview

This script shows how with behaviours you can rename a field's display name to a custom specific one.

## Example

As a product manager, I want to customise the display name of the priority field to be more in line with our business requirements.

## Good to Know

* This script works on both *Create* and *Issue* views inside of Jira Cloud.

## Script

```typescript
getFieldById("priority").setName("Customer Priority Level")
```

