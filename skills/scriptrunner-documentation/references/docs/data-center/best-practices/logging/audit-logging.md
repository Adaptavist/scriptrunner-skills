# Audit Logging

- Platform: data-center
- Space: SR4JS
- Hierarchy: best-practices > logging
- Doc ID: doc-sr4js-101624118
- Source: https://docs.adaptavist.com/sr4js/latest/best-practices/logging/audit-logging

The ScriptRunner audit log helps you inspect the script configuration changes made by your users. The audit log service logs add, edit, or delete operations for ScriptRunner scripts as part of application audit log. The service also logs execution of built-in scripts that could potentially change the system.

To avoid swamping the audit log, the service does not log activities where scripts read data from the system. It only logs activities where the configuration has been changed. Also, the service does not monitor Jira workflow modification activities as Jira already has its own mechanism in place to log such changes.

### View Audit Log

ScriptRunner audit logging is enabled by default since ScriptRunner v5.3.8 as part of Jira audit log. You must be a Jira administrator to view the Jira audit log.

Navigate to _System →Audit Log_ to view the audit log. The `Summary` field appends with '**ScriptRunner**' for the ScriptRunner audit log entry. The screenshot below is an example of how the ScriptRunner audit log entries looks like in Jira audit log.

![](/sr4js/files/latest/101624118/101627983/1/1600701682000/audit-log-jira.png)

### Disabling Audit Log

You won’t be able to inspect ScriptRunner script configuration changes if the audit logging is disabled. Disabling ScriptRunner audit logging mechanism is highly discouraged unless you have a strong reason.

To disable the audit logging, follow these steps:

-   Login as an administrator and go to \[BASE-URL\]/secure/SiteDarkFeatures!default.jspa
    
    1.  In the **Enable Dark Feature** text field, add _scriptrunner.audit.log.disabled_.
        

The image below shows the dark feature page after adding the _scriptrunner.audit.log.disabled_ key:

![](/sr4js/files/latest/101624118/101627982/1/1600701682000/audit-log-dark.png)

### Enabling Audit Log

-   Login as an administrator and go to \[BASE-URL\]/secure/SiteDarkFeatures!default.jspa
    
-   Locate **scriptrunner.audit.log.disabled** key and select **(Disable)** link on the right side of the key. This should remove the **scriptrunner.audit.log.disabled** key from the list.
