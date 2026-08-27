# ScriptRunner Migration Analyse and Assess Tool

- Platform: migration-suite
- Space: SMS
- Hierarchy: scriptrunner-migration-suite-web-app
- Doc ID: doc-sms-448135864
- Source: https://docs.adaptavist.com/sms/latest/scriptrunner-migration-suite-web-app/scriptrunner-migration-analyse-and-assess-tool

Use [The ScriptRunner Migration Analyse and Assess](https://migrationpilot.scriptrunnerhq.com/analyse "https://migrationpilot.scriptrunnerhq.com/analyse") tool to review your ScriptRunner Data Center scripts and configurations for risks and cloud readiness. After your scripts and configurations are assessed and analyzed, you will be given guidance on how to convert scripts for Cloud.

This tool does not use AI.

The Assess and Analyse tool reads a [Script Registry export from ScriptRunner for Jira Data Center](https://docs.adaptavist.com/sr4js/latest/features/script-registry#exporting-your-scripts) and provides you with:

-   A readiness report: Scripts and configurations are grouped by features (listeners, workflows, etc.) and individual configurations. Learn more on the [Use the Analyse and Assess Tool](https://docs.adaptavist.com/sms/latest/scriptrunner-migration-suite-web-app/scriptrunner-migration-analyse-and-assess-tool/use-the-analyse-and-assess-tool) page.
-   Cloud pointers: When there is no parity for Cloud, you can see what alternatives exist, including links and identifiers for Cloud options (like HAPI or REST endpoints). Using these pointers, you can start rewriting with concrete next steps.

To create a script export, use the [export feature of Script Registry](https://docs.adaptavist.com/sr4js/latest/features/script-registry#exporting-your-scripts). This feature is supported on the latest available release within each major version of [ScriptRunner for Jira](https://marketplace.atlassian.com/apps/6820/scriptrunner-for-jira?hosting=datacenter&tab=overview&utm_term=&utm_campaign=AVST%20-%20BU1%20-%20Search%20-%20sr4j_s-dc_marketplace-listing_scriptrunner-for-jira---non-brand---search_us_2021-05-12&utm_source=google&utm_medium=cpc&hsa_acc=7742523188&hsa_cam=19818549782&hsa_grp=174978758364&hsa_ad=728760419904&hsa_src=g&hsa_tgt=dsa-2391903919339&hsa_kw=&hsa_mt=&hsa_net=adwords&hsa_ver=3&gad_source=1&gad_campaignid=19818549782&gbraid=0AAAAApB0nG1L5J8n8NmjtaIKbmSRfsb07&gclid=CjwKCAiA3L_JBhAlEiwAlcWO502tcUyOdxp9BT2Xqnl3xC2KWHZYAZvXjcV_NeNRFr0HcjraqMAaLRoCX6cQAvD_BwE). If you’re already on a supported version, you don’t need to upgrade to the newest overall release.

If you are on a version older than 8.54 or 9.19, you only need to update to the most recent release within your current major version. For example:

-   If you’re on version 8.x, update to the latest 8.x release.
-   If you’re on version 9.x, update to the latest 9.x release.

Watch a demo of the Analyse and Assess tool below! ![rocket](/plugins/servlet/twitterEmojiRedirector?id=1f680 "rocket") 

## [![](/sms/files/latest/448135864/534479444/1/1776103872000/sr-icon-comments.png)](https://www.adaptavist.com/products/atlassian-apps/get-involved-scriptrunner?queryID=d51c44fdc2ca51c26341f63b3881b962)

## Get involved

Tell us how we can keep improving! Your feedback directly shapes the ScriptRunner product roadmaps and empowers others just like you.

[Give feedback](https://docs.google.com/forms/d/e/1FAIpQLSdt-Ex1FbA3gKIjotLJBzGaSggypf4veyPCwxKl01zAC_YH9w/viewform)
