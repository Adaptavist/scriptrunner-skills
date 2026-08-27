# Auto assign issue based on priority

- Platform: cloud
- Feature: behaviours
- Tags: automate, issue, user
- Language: typescript
- Doc ID: example-cloud-Auto-assign-issue-based-on-priority-cloud
- Source: https://examples.scriptrunner.io/scripts/Auto-assign-issue-based-on-priority-cloud

## Script

```typescript
const priorityField = getFieldById("priority")
const assigneeField = getFieldById("assignee")

console.log(priorityField.getValue().name)

switch (priorityField.getValue().name) {
    case "Highest":
        assigneeField.setValue("USER1")
        break;
    case "Medium":
        assigneeField.setValue("USER2")
        break;
    default:
        break;
}
```

