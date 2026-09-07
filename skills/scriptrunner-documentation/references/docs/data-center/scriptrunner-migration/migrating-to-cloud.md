# Migrating to Cloud

- Platform: data-center
- Space: SR4JS
- Hierarchy: scriptrunner-migration
- Doc ID: doc-sr4js-484577017
- Source: https://docs.adaptavist.com/sr4js/latest/scriptrunner-migration/migrating-to-cloud

This section provides you with the steps required to move from ScriptRunner for Jira Server/Data Center to Cloud. It also offers guidance on the differences between the two versions of ScriptRunner and provides some details on rewriting scripts and using alternatives:

Feature Differences

ScriptRunner for Jira Cloud **does not have the same feature set** as the Server/Data Center version. You can learn about the parity for each individual ScriptRunner for Server/Data Center feature in our [Feature Parity table](https://docs.adaptavist.com/sr4js/latest/scriptrunner-migration/migrating-to-cloud/feature-parity-and-script-alternatives). We also provide details on workaround script/function alternatives where there is currently no parity with Cloud.

REST APIs

Scripts in Jira Cloud do not execute within the same process as Jira Server and so must interact with Jira using the [REST APIs](https://docs.adaptavist.com/sr4jc/latest/get-started/technical-background#rest-apis) rather than the JAVA APIs.

Try our migration tools!

The ScriptRunner Migration Suite is a suite of tools that helps you plan, analyse, convert and deploy scripts with confidence, significantly reducing the manual migration effort. It supports (not replaces) your expertise. The suite is made up of three tools: 

-   [ScriptRunner Migration Analyse and Assess Tool](https://docs.adaptavist.com/sms/latest/scriptrunner-migration-suite-web-app/scriptrunner-migration-analyse-and-assess-tool): Use this tool to review your ScriptRunner Data Center scripts and configurations for risks and cloud readiness.
-   [The ScriptRunner Migration Agent](https://docs.adaptavist.com/sms/latest/scriptrunner-migration-suite-web-app/scriptrunner-migration-agent): Use our specialised AI chat agent to create, convert, and optimise scripts, or you can use it to answer a variety of different questions about ScriptRunner.
-   [ScriptRunner Dev and Deployment Tool](https://docs.adaptavist.com/sms/latest/scriptrunner-dev-and-deployment-tool): Use this tool to organise and deploy ScriptRunner Cloud scripts. It is focused on making it easier and faster for consultants and developers to migrate, test, and deploy scripts from ScriptRunner DC to Cloud.

If you have any questions, need help, or would like to request access, the quickest way to get assistance is through our [dedicated support portal](https://the-adaptavist-group-support.atlassian.net/servicedesk/customer/portal/1069/user/login?destination=portal%2F1069).

-   [Migration Checklist](https://docs.adaptavist.com/sr4js/latest/scriptrunner-migration/migrating-to-cloud/migration-checklist)
-   [Platform Differences between ScriptRunner for Jira Server/DC and Jira Cloud](https://docs.adaptavist.com/sr4js/latest/scriptrunner-migration/migrating-to-cloud/platform-differences-between-scriptrunner-for-jira-server-dc-and-jira-cloud)
-   [Feature Parity and Script Alternatives](https://docs.adaptavist.com/sr4js/latest/scriptrunner-migration/migrating-to-cloud/feature-parity-and-script-alternatives)
-   [Rewriting Scripts for Cloud Hints and Tips](https://docs.adaptavist.com/sr4js/latest/scriptrunner-migration/migrating-to-cloud/rewriting-scripts-for-cloud-hints-and-tips)
-   [Troubleshoot ScriptRunner Migration](https://docs.adaptavist.com/sr4js/latest/scriptrunner-migration/migrating-to-cloud/troubleshoot-scriptrunner-migration)
-   [GDPR Migration](https://docs.adaptavist.com/sr4js/latest/scriptrunner-migration/migrating-to-cloud/gdpr-migration)

## Related content

-   [JQL Query Comparison](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/comparison-with-scriptrunner-for-jira-server#jql-query-comparison) (ScriptRunner for Jira Cloud documentation)
-   [Simplify Current Scripts with HAPI](https://docs.adaptavist.com/sr4js/latest/hapi/simplify-current-scripts-with-hapi)
