# Configuration Manager for Jira (CMJ)

- Platform: data-center
- Space: SR4JS
- Hierarchy: integrations > other-apps
- Doc ID: doc-sr4js-284099353
- Source: https://docs.adaptavist.com/sr4js/latest/integrations/other-apps/configuration-manager-for-jira-cmj

[Configuration Manager for Jira (CMJ)](https://marketplace.atlassian.com/apps/1211611/configuration-manager-for-jira-cmj?hosting=datacenter&tab=overview) automates the process of copying projects and configurations from one Jira instance to another. The app allows you to export or import specific project configurations or complete projects (configuration and data). ScriptRunner is integrated with CMJ, allowing you to export some of your ScriptRunner specific configurations.

For more information on what ScriptRunner version is currently supported, see the [CMJ Documentation](https://appfire.atlassian.net/wiki/spaces/AppIn/pages/790495487/Integrations+for+Server-to-Server+Migrations).

## What ScriptRunner features can CMJ migrate?

CMJ can migrate all ScriptRunner features, however there are limitations as described below.

## CMJ limitations

**Script files** are currently **not** migrated as part of CMJ integration. Configurations pointing at script files are migrated but the script files must be manually migrated by the user.
