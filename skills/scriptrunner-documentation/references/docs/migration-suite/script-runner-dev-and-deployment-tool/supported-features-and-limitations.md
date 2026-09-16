# Supported Features and Limitations

- Platform: migration-suite
- Space: SMS
- Hierarchy: ScriptRunner Dev and Deployment Tool
- Doc ID: doc-sms-ef0fbe39-f2e4-4ec1-b950-64212038eb57-971fc99a4f67ba79
- Source: https://docs.adaptavist.com/sms/latest/scriptrunner-dev-and-deployment-tool#supported-features-and-limitations--en

## Supported features

This tool is a work in progress and does not yet work for all features. Review the following table for more information:

| Feature | Support | Is support for this feature planned? | Notes/Details |
| --- | --- | --- | --- |
| Built-in scripts | \- | \- | There is nothing to configure in Cloud.<br>Note: "Built-in Script" here refers to the Built-In Script feature of ScriptRunner (General Configuration > ScriptRunner > Built-in Scripts). Other features, such as Listeners, Workflows, and Jobs, have built-ins that come with ScriptRunner (like the [Create a Sub-task](https://docs.adaptavist.com/sr4js/latest/features/listeners/built-in-listeners/create-a-sub-task) built-in listener) that are supported by this tool and exported by Script Export. |
| Listeners | Yes | \- |  |
| Behaviours | Yes | \- | Two Behaviours cannot have the same name. |
| Script Fields | Yes | \- |  |
| Workflows | Yes | \- |  |
| REST Endpoints | No | No | This feature is not currently available in ScriptRunner for Jira Cloud. Jira Cloud does not offer custom endpoints. Our recommendation is to use [ScriptRunner Connect](https://www.scriptrunnerhq.com/atlassian-apps/jira/scriptrunner-connect) to fill this gap. |
| UI Fragments | No | Yes | Only Web Panels are supported in Cloud, with certain restrictions. |
| Jobs | Yes | \- | Tip: [Escalation Services](../../cloud/features/escalation-service.md) are supported by the tool and grouped under jobs. |
| JQL Functions | No | Yes | Writing your own [custom JQL functions](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/custom-jql-functions) in Groovy is not supported in ScriptRunner Cloud. Most of the JQL functions provided by ScriptRunner are available in [ScriptRunner Enhanced Search](../../cloud/features/script-runner-enhanced-search.md) feature (available as a standalone app). |
| Resources | No | No | This feature is unavailable in ScriptRunner for Jira Cloud, so no configuration is needed.<br>Some Resources have script alternatives that can be executed in the Script Console in ScriptRunner for Jira Cloud. |
| Script Manager | Yes | \- |  |
| Mail Handler | No | No | This feature is unavailable in ScriptRunner for Jira Cloud, so no configuration is needed. |

Tip: We hope to support more features in the future. Check this page and the [changelog](../uncategorized/s/script-runner-migration-suite-changelog.md) for updates.

## Limitations

While this tool can do a lot, there are limitations. The Dev and Deployment Tool does not:

-   Automate script rewriting (handled by [ScriptRunner Migration Agent](../script-runner-migration-suite-web-app/script-runner-migration-agent.md)).
-   Have a visual interface for script development (focus is on CLI/IDE-based workflows).
-   Perform end-to-end migration automation.

## Rate limits

Atlassian and Adaptavist APIs have rate limits. Rate limiting is most noticeable during workflow deployments, particularly for customers with many workflows. At scale, these deployments may run into Atlassian's rate limits. See Atlassian's [Rate limiting](https://developer.atlassian.com/cloud/jira/platform/rate-limiting/) documentation for more details.

We are actively working on more comprehensive handling of rate limits within this tool.
