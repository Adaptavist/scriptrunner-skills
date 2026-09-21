# Audit Logging

- Platform: data-center
- Space: SR4JS
- Hierarchy: Best Practices > Logging
- Doc ID: doc-sr4js-900cc81f-c455-4bd9-8787-21d77d818027-2eeb89c89c4866fa
- Source: https://docs.adaptavist.com/sr4js/latest/best-practices/logging#audit-logging--en

The ScriptRunner audit log helps you inspect the script configuration changes made by your users. The audit log service logs add, edit, or delete operations for ScriptRunner scripts as part of application audit log. The service also logs execution of built-in scripts that could potentially change the system.

To avoid swamping the audit log, the service does not log activities where scripts read data from the system. It only logs activities where the configuration has been changed. Also, the service does not monitor Jira workflow modification activities as Jira already has its own mechanism in place to log such changes.

## View Audit Log

Tip: ScriptRunner audit logging is enabled by default since ScriptRunner v5.3.8 as part of the Jira audit log. You must be a Jira administrator to view the Jira audit log.

Navigate to System → Audit Log to view the audit log.

The `Summary` field appends with ' ScriptRunner' for the ScriptRunner audit log entry. The screenshot below is an example of how the ScriptRunner audit log entries looks like in Jira audit log.

## Disabling Audit Log

Warning: You won't be able to inspect ScriptRunner script configuration changes if the audit logging is disabled. Disabling ScriptRunner audit logging mechanism is highly discouraged unless you have a strong reason.

To disable the audit logging, follow these steps:

Log in as an administrator and go to `BASE-URL/secure/SiteDarkFeatures!default.jspa`

1.  In the Enable Dark Feature text field, add scriptrunner.audit.log.disabled.
    
    The image below shows the dark feature page after adding the scriptrunner.audit.log.disabled key:
    

## Enabling Audit Log

1.  Log in as an administrator and go to [BASE-URL/secure/SiteDarkFeatures!default.jspa](https://docs.adaptavist.com/sr4js/latest/best-practices/BASE-URL/secure/SiteDarkFeatures!default.jspa)
2.  Locate scriptrunner.audit.log.disabled key and select (Disable) link on the right side of the key.
    
    This should remove the scriptrunner.audit.log.disabled key from the list.
