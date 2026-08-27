# Set the description text below a field on the create screen

- Platform: cloud
- Feature: behaviours
- Tags: automate, issue
- Language: typescript
- Doc ID: example-cloud-behaviours-set-description-snippet-cloud
- Source: https://examples.scriptrunner.io/scripts/behaviours-set-description-snippet-cloud

## Overview

Want to add some custom help text below a field to explain further context to users about what the field is for,
then use the *setDescription()* method provided by behaviours.

## Example

As a product manager add help information below the fields on the *Create Screen*.

## Good to Know

* You can change the name of the field from *summary* to any other supported field inside of your Jira instance.

## Script

```typescript
getFieldById("summary").setDescription("Please describe the work item in less than 25 words");
```

