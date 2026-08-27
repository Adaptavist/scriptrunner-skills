# Audit Logs

- Platform: connect
- Space: SRC
- Hierarchy: observability
- Doc ID: doc-src-284099554
- Source: https://docs.adaptavist.com/src/latest/observability/audit-logs

The audit log tracks all actions taken by users within ScriptRunner Connect. To access the audit log, click **Reporting** > **Audit Logs**. This feature lets you view your historical actions and those of your teammates, provided you have the necessary privileges.

**Retention period ⏰**

Audit logs are kept for six months, after which they are auto-deleted from the app.

Audit-log collection began on 29 August 2024.

## Fields

The audit logs consist of the following fields:

-   **Actor** - The user who performed the action.
-   **Action** - The specific action taken. The action name is formatted as `${resource_name}(.${sub_resource_name}).${action}` 
-   **IP Address** - The IP address of the user who performed the action.
-   **Date** - The date and time when the action was taken.
-   **Related entities** (expandable) - Entities related to the action.
-   **Metadata** (expandable) - Additional information related to the action.

## Visibility

By default, you'll see all actions related to your user object. For instance, if you edit your profile, that action will appear in the audit log because it relates to your user object. If you are an admin or super admin in any team, you'll have access to audit logs for all actions related to that team and its sub-resources.

**Team-specific details 🔻**

Audit logs are generated at the team level, so you only see audit logs for the team you select from the main navigation.

## Export to CSV

If you want to apply more filters, export audit logs from the past six months to a CSV file and use external tools like Excel for further analysis. Note that team filtering will still be applied to the exported data.
