# Behaviours with Service Management

- Platform: data-center
- Space: SR4JS
- Hierarchy: features > behaviours
- Doc ID: doc-sr4js-442889116
- Source: https://docs.adaptavist.com/sr4js/latest/features/behaviours/behaviours-with-service-management

If you have the Jira Service Management application, you can create behaviours specifically for the customer portal. You need to map them separately from project behaviours, because typically, though not always, they have different functionality.

If you want behaviours to be active in the customer portal, you must create a Service Management mapping. Even if you associate a behaviour with _All Issue Types_ in a project, unless you create a mapping to the service management portal, they won’t be active.

In most other respects, using behaviours with Service Management is the same as with a normal Jira project.

In Service Management you can provide a different _label_ for each field, per portal and request type. However, when setting field behaviours for a request type, as with normal Jira, you set behaviours by field name. You can determine the actual field name by editing the request type fields.

For example, in a customer portal you may see:

![](/sr4js/files/latest/442889116/442889119/1/1758746997000/portal-view.png)

To establish that this field is actually the **Summary** field, click the _edit_ link on the field in the request types view:

![](/sr4js/files/latest/442889116/442889118/1/1758746997000/edit-field-view.png)

## Example

If the user selects _Highest_ priority, we’re going to change the field label for the Description field, and change the help text so we can understand why the priority is so high.  

```
import com.onresolve.jira.groovy.user.FieldBehaviours
import com.atlassian.jira.issue.priority.Priority
import groovy.transform.BaseScript

@BaseScript FieldBehaviours fieldBehaviours

if ((getFieldById(getFieldChanged()).value as Priority)?.name == "Highest") {
    getFieldById("description")
        .setLabel("Why do you need this and why so important?")
        .setDescription("Please explain why this is Highest priority including details of outage etc.")
} else {
    getFieldById("description")
        .setLabel("Why do you need this?")
        .setDescription("Tell us why you want this.")

}
```

When the customer changes the Priority to Highest the screen changes to look like the following:

![](/sr4js/files/latest/442889116/442889117/1/1758746997000/jsd-priority-change.png)
