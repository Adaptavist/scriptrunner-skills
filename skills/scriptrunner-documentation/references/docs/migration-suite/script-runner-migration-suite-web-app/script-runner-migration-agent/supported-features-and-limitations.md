# Supported Features and Limitations

- Platform: migration-suite
- Space: SMS
- Hierarchy: ScriptRunner Migration Suite Web App > ScriptRunner Migration Agent
- Doc ID: doc-sms-0d74af59-7302-4425-82e3-a6425b582d79-383b9048d8c872c5
- Source: https://docs.adaptavist.com/sms/latest/scriptrunner-migration-suite-web-app/scriptrunner-migration-agent/supported-features-and-limitations

## Supported features

This tool is a work in progress and does not yet work for all features. Review the following table for more information:

| Feature | Support | Is support for this feature planned? | Notes/Details |
| --- | --- | --- | --- |
| Built-in Scripts | \- | \- | There is nothing to configure in Cloud.<br>Note: "Built-in Script" here refers to the Built-In Script feature of ScriptRunner (General Configuration > ScriptRunner > Built-in Scripts). Other features, such as Listeners, Workflows, and Jobs, have built-ins that come with ScriptRunner (like the [Create a Sub-Task](https://docs.adaptavist.com/sr4js/latest/features/listeners/built-in-listeners/create-a-sub-task) built-in listener) that are supported by this tool and exported by Script Export. |
| Listeners | Yes | \- |  |
| Behaviours | Yes | \- |  |
| Script Fields | Yes | \- |  |
| Workflows | Yes | \- |  |
| REST Endpoints | No | No | This feature is not currently available in ScriptRunner for Jira Cloud. Jira Cloud does not offer custom endpoints. Our recommendation is to use<br>[ScriptRunner Connect](https://www.scriptrunnerhq.com/atlassian-apps/jira/scriptrunner-connect)<br>to fill this gap. |
| UI Fragments | No | Yes | Only Web Panels are supported in Cloud, with certain restrictions. |
| Jobs | Yes | \- |  |
| JQL Functions | No | Yes |  |
| Resources | No | No | This feature is unavailable in ScriptRunner for Jira Cloud, so no configuration is needed.<br>Some Resources have script alternatives that can be executed in the Script Console in ScriptRunner for Jira Cloud. |
| Mail Handler | No | No | This feature is unavailable in ScriptRunner for Jira Cloud, so no configuration is needed. |

Tip: We hope to support more features in the future. Check this page and the [ScriptRunner Migration Suite Changelog](../../uncategorized/s/script-runner-migration-suite-changelog.md) for updates.

## Limitations

While the Migration Agent can do a lot, there are limitations. The Migration Agent does not:

-   Perform bulk conversions. We aim to have this option available in a future version.
-   Read from local files and repositories.
-   Connect to a Jira instance to test code.
