# ScriptRunner Migration Suite Changelog

- Platform: migration-suite
- Space: SMS
- Hierarchy: n/a
- Doc ID: doc-sms-454393884
- Source: https://docs.adaptavist.com/sms/latest/scriptrunner-migration-suite-changelog

Find the latest updates and enhancements to [ScriptRunner Migration Agent](https://docs.adaptavist.com/sms/latest/scriptrunner-migration-suite-web-app/scriptrunner-migration-agent), [ScriptRunner Migration Analyse and Assess Tool](https://docs.adaptavist.com/sms/latest/scriptrunner-migration-suite-web-app/scriptrunner-migration-analyse-and-assess-tool), and [ScriptRunner Dev and Deployment Tool](https://docs.adaptavist.com/sms/latest/scriptrunner-dev-and-deployment-tool) on this page.

Date

Details

Documentation Link

17 August 2026

The [Dev and Deployment Tool](https://docs.adaptavist.com/sms/latest/scriptrunner-dev-and-deployment-tool) was updated to version 1.8.0, adding support for Behaviours on the JSM portal view.

-   [Use the Dev and Deployment Tool](https://docs.adaptavist.com/sms/latest/scriptrunner-dev-and-deployment-tool/use-the-dev-and-deployment-tool)

7 August 2026

The [Dev and Deployment Tool](https://docs.adaptavist.com/sms/latest/scriptrunner-dev-and-deployment-tool) was updated to version 1.7.1, adding a new mode to look for matching legacy workflow functions already on the Cloud site, created from a JCMA migration, and avoid creating duplicates.

-   The [Duplicate detection for workflow deployments](https://bitbucket.org/adaptavistlabs/migration-example-project/src/main/README.md) section of the [README](https://bitbucket.org/adaptavistlabs/migration-example-project/src/main/README.md)

23 July 2026

The [Dev and Deployment Tool](https://docs.adaptavist.com/sms/latest/scriptrunner-dev-and-deployment-tool) was updated to version 1.6.0, adding a clear message when a workflow function is not deployed because a matching transition was not found.

-   [Use the Dev and Deployment Tool](https://docs.adaptavist.com/sms/latest/scriptrunner-dev-and-deployment-tool/use-the-dev-and-deployment-tool)

22 July 2026

The [ScriptRunner Dev and Deployment Tool](https://docs.adaptavist.com/sms/latest/scriptrunner-dev-and-deployment-tool) was updated to version 1.5.0 to:

-   Run pullMappings by default if ID mappings are used.
-   Support large extensions.yaml files to be split into multiple files to make handling and navigation easier.
    

-   The [Splitting configuration across multiple YAML files](https://bitbucket.org/adaptavistlabs/migration-example-project/src/main/README.md#:~:text=Splitting%20configuration%20across%20multiple%20YAML%20files) section of the [README](https://bitbucket.org/adaptavistlabs/migration-example-project/src/main/README.md)

16 July 2026

Browser-based authentication for the [Dev and Deployment Tool](https://docs.adaptavist.com/sms/latest/scriptrunner-dev-and-deployment-tool) is broken for newer versions of Chrome and Firefox. The Local Network Access (LNA) restrictions in these browsers block iframe-initiated requests to localhost. Unfortunately, this error is outside of our control, but we do have workarounds for you. Check out the [Use the Dev and Deployment Tool](https://docs.adaptavist.com/sms/latest/scriptrunner-dev-and-deployment-tool/use-the-dev-and-deployment-tool) page to learn about workaround options.

-   [Use the Dev and Deployment Tool](https://docs.adaptavist.com/sms/latest/scriptrunner-dev-and-deployment-tool/use-the-dev-and-deployment-tool)

8 July 2026

The [ScriptRunner Dev and Deployment Tool](https://docs.adaptavist.com/sms/latest/scriptrunner-dev-and-deployment-tool) was updated to version 1.4.0 to include:

-   More detailed error messaging when an Behaviour fails to deploy. 
-   Validation for UUIDs on deployment. 
-   A fix for an error that prevented deployment of Behaviours. 

-   [Use the Dev and Deployment Tool](https://docs.adaptavist.com/sms/latest/scriptrunner-dev-and-deployment-tool/use-the-dev-and-deployment-tool)

25 June 2026

The [ScriptRunner Dev and Deployment Tool](https://docs.adaptavist.com/sms/latest/scriptrunner-dev-and-deployment-tool) can now deploy workflow functions in batches of 20.

Additionally, the typescript compilation for Behaviours in the [ScriptRunner Dev and Deployment Tool](https://docs.adaptavist.com/sms/latest/scriptrunner-dev-and-deployment-tool) has been reworked to remove false compilation errors, and a problem with running the compilation command from the Windows shell has been fixed.

-   [Use the Dev and Deployment Tool](https://docs.adaptavist.com/sms/latest/scriptrunner-dev-and-deployment-tool/use-the-dev-and-deployment-tool)

16 June 2026

The [ScriptRunner Dev and Deployment Tool](https://docs.adaptavist.com/sms/latest/scriptrunner-dev-and-deployment-tool) now supports DC to Cloud ID mapping. 

-   Sample Project: [ID Mapping](https://bitbucket.org/adaptavistlabs/migration-example-project/src/main/MAPPING.md)

15 June 2026

A bug, where deploying a post function with an inline script resulted in deploying an empty script, was fixed.

  

06 May 2026

A bug with Behaviours, which prevented users from deploying Behaviours using the browser-based authentication, was fixed.

-   [Use the Dev and Deployment Tool](https://docs.adaptavist.com/sms/latest/scriptrunner-dev-and-deployment-tool/use-the-dev-and-deployment-tool)

29 April 2026

There is now an example for the [Dev and Deployment Tool](https://docs.adaptavist.com/sms/latest/scriptrunner-dev-and-deployment-tool) that demonstrates how to structure a project spanning multiple Jira sites and multiple projects.

-   Sample Project: [Multi-Site Example](https://bitbucket.org/adaptavistlabs/dev-and-deployment-multi-site/src/main/) 

28 April 2026

There are now examples in all built-in Post Workflow Function scripts for the [Dev and Deployment Tool](https://docs.adaptavist.com/sms/latest/scriptrunner-dev-and-deployment-tool).

-   [Supported Features and Limitations](https://docs.adaptavist.com/sms/latest/scriptrunner-dev-and-deployment-tool/supported-features-and-limitations)  
    
-   Sample Project: [Sample Project: Built-In Workflow Functions](https://bitbucket.org/adaptavistlabs/migration-example-project/src/9a21d820c96e142f1f29b50bc9415ce551934a92/cloud/src/main/resources/extensions.yaml#lines-179)

27 April 2026

You can now export the results of the [ScriptRunner Migration Analyse and Assess Tool](https://docs.adaptavist.com/sms/latest/scriptrunner-migration-suite-web-app/scriptrunner-migration-analyse-and-assess-tool) in a PDF to share with stakeholders to aid in your migration. 

-   [Export as a PDF Report](https://docs.adaptavist.com/sms/current/scriptrunner-migration-suite-web-app/scriptrunner-migration-analyse-and-assess-tool/use-the-analyse-and-assess-tool#:~:text=Export%20as%20PDF%20report)

23 April 2026

When deploying workflow post functions or validators, you can control their placement among other workflow functions by using a placement block on a ScriptRunner rule. Supported placement fields are: 

-   index (0-based absolute position)
-   first
-   last

You can see an example in the [Example Project](https://bitbucket.org/adaptavistlabs/migration-example-project/src/c2509583c43a15e9a8666382899d4cbea0ff2c4d/cloud/src/main/resources/extensions.yaml#lines-315). 

-   [Supported Features and Limitations](https://docs.adaptavist.com/sms/latest/scriptrunner-dev-and-deployment-tool/supported-features-and-limitations)  
    

20 April 2026

There is a known bug on the authentication step of working with the [Dev and Deployment Tool](https://docs.adaptavist.com/sms/latest/scriptrunner-dev-and-deployment-tool/use-the-dev-and-deployment-tool). The automatic browser-based authentication is currently broken in Google Chrome and browsers based on Chromium. We're working on it, but there are some blockers. Please bear with us!

-   [Authenticate the Dev and Deployment Tool](https://docs.adaptavist.com/sms/current/scriptrunner-dev-and-deployment-tool/use-the-dev-and-deployment-tool#authenticate)

10 April 2026

Check out our new Web App [AI Training and Usage](https://docs.adaptavist.com/sms/latest/scriptrunner-migration-suite-web-app/ai-training-and-usage) guide for detailed information about the AI models used, AI-generated content, and evaluating AI output. 

-   [AI Training and Usage](https://docs.adaptavist.com/sms/latest/scriptrunner-migration-suite-web-app/ai-training-and-usage)  
    
-   [ScriptRunner Migration Suite Web App](https://docs.adaptavist.com/sms/latest/scriptrunner-migration-suite-web-app)

8 April 2026

You can now use **Jira Space Keys** (like `ECO`, `CONFCLOUD`) and **Work Item Type** names (like _Task_, _Story_, and _Bug_) for Behaviours configurations in the [ScriptRunner Dev and Deployment Tool](https://docs.adaptavist.com/sms/latest/scriptrunner-dev-and-deployment-tool). 

To see this change, update your migration-settings plugin to version 0.2.0 in [the example project's settings.gradle](https://bitbucket.org/adaptavistlabs/migration-example-project/src/main/settings.gradle), as shown on line 28 in the image below. 

![](/sms/files/latest/454393884/533463075/1/1775667699000/0.2.0.png)

Your old configuration will still work, so you do not need to update if you like the Behaviour configuration numbers.

-   [Use the Dev and Deployment Tool](https://docs.adaptavist.com/sms/latest/scriptrunner-dev-and-deployment-tool/use-the-dev-and-deployment-tool)  
    

7 April 2026

A bug affecting workflows in the [Dev and Deployment Tool](https://docs.adaptavist.com/sms/latest/scriptrunner-dev-and-deployment-tool) was fixed.  

The following error appeared when updating workflow scripts while deploying in the Dev and Deployment tool: 

`Unexpected response from workflow update validation (400): {"errorMessages":["payload.workflows[0].transitions[0].actions[0].parameters : parameter values must be less than 32768 characters"],"errors":{}}`

Although the bug is fixed, you will probably need to re-deploy your workflows with the latest version of the Dev and Deployment Tool.

If you’re still getting errors, look for a workflow post function (or "action") in your workflow that doesn’t load in the UI when you try to edit it.

The error usually occurs when the unique identifier used by the workflow function was changed _after_ deploying it, leaving an orphaned configuration that older versions of the plugin could accidentally corrupt. This corruption _won’t_ happen in the latest version, but the old workflow function may still be there in need of removal.

If you have post functions that won’t load in the workflow editor UI (shown below), the easiest workaround is to delete them from your workflow and redeploy from the Dev and Deployment Tool with the latest update.  

![](/sms/files/latest/454393884/533463042/1/1775590223000/summary.png)![](/sms/files/latest/454393884/533463041/1/1775590264000/edit.png)

-   [Use the Dev and Deployment Tool](https://docs.adaptavist.com/sms/latest/scriptrunner-dev-and-deployment-tool/use-the-dev-and-deployment-tool)  
    

3 April 2026

You now have two ways to authenticate the Dev and Deployment Tool for your site: 

1.  Automatic authentication through the browser. Run the deployment tasks from your Dev and Deployment project and click **Allow** on the page that the browser opens in your site. 
2.  Setting up new Atlassian token credentials to add to your home directory.

-   [Use the Dev and Deployment Tool](https://docs.adaptavist.com/sms/latest/scriptrunner-dev-and-deployment-tool/use-the-dev-and-deployment-tool)  
    

24 March 2026

Check out our new documentation:

-   Migrate to Cloud using the ScriptRunner Migration Suite
-   FAQ: Migration and ScriptRunner Migration Suite

-   [Migrate to Cloud Using the ScriptRunner Migration Suite](https://docs.adaptavist.com/sms/latest/migrate-to-cloud-using-the-scriptrunner-migration-suite)  
    
-   [FAQ: Migration and ScriptRunner Migration Suite](https://docs.adaptavist.com/sms/latest/migrate-to-cloud-using-the-scriptrunner-migration-suite/faq-migration-and-scriptrunner-migration-suite)

20 March 2026

The [ScriptRunner Dev and Deployment Tool](https://docs.adaptavist.com/sms/latest/scriptrunner-dev-and-deployment-tool) can now deploy workflow conditions placed inside condition groups and subgroups. 

-   [Supported Features and Limitations](https://docs.adaptavist.com/sms/latest/scriptrunner-dev-and-deployment-tool/supported-features-and-limitations)  
    

5 March 2026

The [ScriptRunner Migration Analyse and Assess Tool](https://docs.adaptavist.com/sms/latest/scriptrunner-migration-suite-web-app/scriptrunner-migration-analyse-and-assess-tool) now detects utility functions and imported scripts to include them in reports and the [ScriptRunner Migration Agent](https://docs.adaptavist.com/sms/latest/scriptrunner-migration-suite-web-app/scriptrunner-migration-agent) can reference them. 

-    [Use the Analyse and Assess Tool](https://docs.adaptavist.com/sms/latest/scriptrunner-migration-suite-web-app/scriptrunner-migration-analyse-and-assess-tool/use-the-analyse-and-assess-tool)

27 February 2026

When Behaviour conditions are detected that need to be converted to scripts in Cloud, the [ScriptRunner Migration Analyse and Assess Tool](https://docs.adaptavist.com/sms/latest/scriptrunner-migration-suite-web-app/scriptrunner-migration-analyse-and-assess-tool) now suggests a script snippet and guidance, based on the condition type, when available.

-   [Supported Features and Limitations](https://docs.adaptavist.com/sms/latest/scriptrunner-migration-suite-web-app/scriptrunner-migration-analyse-and-assess-tool/supported-features-and-limitations)

18 February 2026

The [ScriptRunner Migration Agent](https://docs.adaptavist.com/sms/latest/scriptrunner-migration-suite-web-app/scriptrunner-migration-agent) is now powered by Anthropic's Claude 4.6 Sonnet. Sonnet 4.6 has improved coding skills to help you with converting scripts for migration. Learn more from [Anthropic](https://www.anthropic.com/news/claude-sonnet-4-6).

Additionally, the Migration Agent has been updated to:

-   Be more accurate when converting Groovy Workflow Conditions and Validators to Jira Expressions for Cloud.
-   Have up-to-date knowledge on the latest supported features in the [ScriptRunner Dev and Deployment Tool](https://docs.adaptavist.com/sms/latest/scriptrunner-dev-and-deployment-tool), including Workflow Functions and Behaviors. 
-   Have access to Cloud API documentation for [Jira Software](https://developer.atlassian.com/cloud/jira/platform/rest/v3/intro/) and [Jira Service Management](https://developer.atlassian.com/cloud/jira/service-desk/rest/intro/#about). 

-   [ScriptRunner Migration Agent](https://docs.adaptavist.com/sms/latest/scriptrunner-migration-suite-web-app/scriptrunner-migration-agent)
-   [Migration Agent Supported Features and Limitations](https://docs.adaptavist.com/sms/latest/scriptrunner-migration-suite-web-app/scriptrunner-migration-agent/supported-features-and-limitations)
-   [Migration Agent FAQ](https://docs.adaptavist.com/sms/latest/scriptrunner-migration-suite-web-app/scriptrunner-migration-agent/faq)
-   [ScriptRunner Dev and Deployment Tool](https://docs.adaptavist.com/sms/latest/scriptrunner-dev-and-deployment-tool)
-   [Dev and Deployment Tool Supported Features and Limitations](https://docs.adaptavist.com/sms/latest/scriptrunner-dev-and-deployment-tool/supported-features-and-limitations)

13 February 2026

Complete analysis for Behaviours in [ScriptRunner Migration Analyse and Assess Tool](https://docs.adaptavist.com/sms/latest/scriptrunner-migration-suite-web-app/scriptrunner-migration-analyse-and-assess-tool) is now available! 

-   [Supported Features and Limitations](https://docs.adaptavist.com/sms/latest/scriptrunner-migration-suite-web-app/scriptrunner-migration-analyse-and-assess-tool/supported-features-and-limitations)

12 February 2026

Support has been added for the following features in the [ScriptRunner Dev and Deployment Tool](https://docs.adaptavist.com/sms/latest/scriptrunner-dev-and-deployment-tool): 

-   Escalation Services Job
-   Script Manager

-   [Supported Features and Limitations](https://docs.adaptavist.com/sms/latest/scriptrunner-dev-and-deployment-tool/supported-features-and-limitations)
-   [Use the Dev and Deployment Tool](https://docs.adaptavist.com/sms/latest/scriptrunner-dev-and-deployment-tool/use-the-dev-and-deployment-tool)

19 January 2026

Support has been added for the following features in the [ScriptRunner Dev and Deployment Tool](https://docs.adaptavist.com/sms/latest/scriptrunner-dev-and-deployment-tool): 

-   Workflows

-   [Supported Features and Limitations](https://docs.adaptavist.com/sms/latest/scriptrunner-dev-and-deployment-tool/supported-features-and-limitations)

15 December 2025

General Availability begins! 

-   [ScriptRunner Migration Suite](https://docs.adaptavist.com/sms/latest)

Support has been added for the following features in the [ScriptRunner Migration Analyse and Assess Tool](https://docs.adaptavist.com/sms/latest/scriptrunner-migration-suite-web-app/scriptrunner-migration-analyse-and-assess-tool): 

-   Behaviours
-   Scripted Fields

Updates to the [ScriptRunner Migration Analyse and Assess Tool](https://docs.adaptavist.com/sms/latest/scriptrunner-migration-suite-web-app/scriptrunner-migration-analyse-and-assess-tool) include:  

-   Ensures CRON expressions are not set for more than an hour to adhere to Cloud limitations. 
-   Analyses configurations with multiple scripts (for example, a listener with a main script and conditions). 
-   Check for duplicate scripts that are exact matches across all configurations. 
    
    If you participated in EAP, please re-import exports to see duplicate script metrics.
    

-   [Supported Features and Limitations](https://docs.adaptavist.com/sms/latest/scriptrunner-migration-suite-web-app/scriptrunner-migration-analyse-and-assess-tool/supported-features-and-limitations)
-   [Use the Analyse and Assess Tool](https://docs.adaptavist.com/sms/latest/scriptrunner-migration-suite-web-app/scriptrunner-migration-analyse-and-assess-tool/use-the-analyse-and-assess-tool)

Support has been added for the following features in the [ScriptRunner Migration Agent](https://docs.adaptavist.com/sms/latest/scriptrunner-migration-suite-web-app/scriptrunner-migration-agent):  

-   Behaviours
-   Workflow Conditions
-   Workflow Validators

-   [Supported Features and Limitations](https://docs.adaptavist.com/sms/latest/scriptrunner-migration-suite-web-app/scriptrunner-migration-agent/supported-features-and-limitations)

Support has been added for the following features in the [ScriptRunner Dev and Deployment Tool](https://docs.adaptavist.com/sms/latest/scriptrunner-dev-and-deployment-tool): 

-   Behaviours 

-   [Supported Features and Limitations](https://docs.adaptavist.com/sms/latest/scriptrunner-dev-and-deployment-tool/supported-features-and-limitations)

3 November 2025

Early Access Program opens! ![rocket](/plugins/servlet/twitterEmojiRedirector?id=1f680 "rocket") 

-   [ScriptRunner Migration Suite Documentation](https://docs.adaptavist.com/sms/latest)

## [![](/sms/files/latest/454393884/534479351/1/1775853330000/sr-icon-comments.png)](https://www.adaptavist.com/products/atlassian-apps/get-involved-scriptrunner?queryID=d51c44fdc2ca51c26341f63b3881b962)Get involved

Tell us how we can keep improving! Your feedback directly shapes the ScriptRunner product roadmaps and empowers others just like you.

[Give feedback](https://docs.google.com/forms/d/e/1FAIpQLSdt-Ex1FbA3gKIjotLJBzGaSggypf4veyPCwxKl01zAC_YH9w/viewform)
