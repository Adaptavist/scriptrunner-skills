# Audit Logging

- Platform: confluence-data-center
- Space: SR4C
- Hierarchy: Best Practices and App Management
- Doc ID: doc-sr4c-9837e8f0-6fbc-405d-b134-c51279d0b943-f44640c25e3b64e2
- Source: https://docs.adaptavist.com/sr4c/latest/best-practices-and-app-management#audit-logging--en

The ScriptRunner audit log helps you inspect the script configuration changes made by your users.

The audit log service logs add, edit, or delete operations for ScriptRunner scripts as part of the application audit log. The service also logs execution of built-in scripts that could potentially change the system.

To prevent overwhelming the audit log, the service does not log activities where scripts retrieve data from the system. It only logs activities where the configuration has been changed.

## View Audit Log

Tip: ScriptRunner audit logging is enabled by default since ScriptRunner v5.3.8 as part of the Confluence audit log. You must be a Confluence administrator to view the Confluence audit log.

Navigate to General Configuration > Administration > Audit Log to view the audit log.

The _Change_ column starts with _ScriptRunner_ for the ScriptRunner audit log entry. The screenshot below is an example of what the ScriptRunner audit log entries look like in the Confluence audit log.

## Disable Audit Log

Warning: You won't be able to inspect ScriptRunner script configuration changes if the audit logging is disabled. Disabling the ScriptRunner audit logging mechanism is highly discouraged unless you have a strong reason.

To disable the audit logging, follow these steps:

1.  Log in as an administrator.
2.  Go to \[BASE-URL\]/admin/darkfeatures.action.
3.  In the Enable Dark Feature text field, add `scriptrunner.audit.log.disabled`.

The image below shows the dark feature page after adding the scriptrunner.audit.log.disabled key:

## Enable Audit Log

1.  Log in as an administrator.
2.  Go to `[BASE-URL]/admin/darkfeatures.action`.
3.  Locate the _scriptrunner.audit.log.disabled_ key, and then select (remove) link on the right side of the key.
    
    This should remove the _scriptrunner.audit.log.disabled_ key from the list.
