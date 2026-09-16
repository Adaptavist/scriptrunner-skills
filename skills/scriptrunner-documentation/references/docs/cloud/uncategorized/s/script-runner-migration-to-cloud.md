# ScriptRunner Migration to Cloud

- Platform: cloud
- Space: SR4JC
- Hierarchy: n/a
- Doc ID: doc-sr4jc-59ef4810-f265-4951-864a-c5fdf2362c9d-20e78c86b64c4691
- Source: https://docs.adaptavist.com/sr4jc/latest/scriptrunner-migration-to-cloud

This section provides you with the steps required to move from ScriptRunner for Jira Server/Data Center to Cloud. It also offers guidance on the differences between the two versions of ScriptRunner and provides some details on rewriting scripts and using alternatives.

CAUTION: Feature Differences

ScriptRunner for Jira Cloud does not have the same feature set as the Server/Data Center version. You can learn about the parity for each individual ScriptRunner for Server/Data Center feature in our [Feature Parity table](../../script-runner-migration-to-cloud/feature-parity-and-script-alternatives.md). We also provide details on workaround script/function alternatives where there is currently no parity with Cloud.

Note: REST APIs

Scripts in Jira Cloud do not execute within the same process as Jira Server and so must interact with Jira using the [REST APIs](https://docs.adaptavist.com/sr4jc/latest/get-started/technical-background#rest-apis--en) rather than the JAVA APIs.

-   [Platform Differences between ScriptRunner for Jira Server/DC and Jira Cloud](../../script-runner-migration-to-cloud/platform-differences-between-script-runner-for-jira-server-dc-and-jira-cloud.md)
-   [Feature Parity and Script Alternatives](../../script-runner-migration-to-cloud/feature-parity-and-script-alternatives.md)
-   [Migration Checklist](../../script-runner-migration-to-cloud/migration-checklist.md)
-   [Rewrite Scripts for Cloud Hints and Tips](../../script-runner-migration-to-cloud/rewrite-scripts-for-cloud-hints-and-tips.md)
-   [Troubleshoot ScriptRunner Migration](../../script-runner-migration-to-cloud/troubleshoot-script-runner-migration.md)
-   [GDPR Migration](../../script-runner-migration-to-cloud/gdpr-migration.md)

Tip: Try our migration tools!

The ScriptRunner Migration Suite is a suite of tools that helps you plan, analyse, convert and deploy scripts with confidence, significantly reducing the manual migration effort. It supports (not replaces) your expertise. The suite is made up of three tools:

-   [ScriptRunner Migration Analyse and Assess Tool](../../../migration-suite/script-runner-migration-suite-web-app/script-runner-migration-analyse-and-assess-tool.md): Use this tool to review your ScriptRunner Data Center scripts and configurations for risks and cloud readiness.
-   [The ScriptRunner Migration Agent](../../../migration-suite/script-runner-migration-suite-web-app/script-runner-migration-agent.md): Use our specialised AI chat agent to create, convert, and optimise scripts, or you can use it to answer a variety of different questions about ScriptRunner.
-   [ScriptRunner Dev and Deployment Tool](../../../migration-suite/uncategorized/s/script-runner-dev-and-deployment-tool.md): Use this tool to organise and deploy ScriptRunner Cloud scripts. It is focused on making it easier and faster for consultants and developers to migrate, test, and deploy scripts from ScriptRunner DC to Cloud.

If you have any questions, need help, or would like to request access, the quickest way to get assistance is through our [dedicated support portal](https://the-adaptavist-group-support.atlassian.net/servicedesk/customer/portal/1069).
