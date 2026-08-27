# Migrate to Cloud Using the ScriptRunner Migration Suite

- Platform: migration-suite
- Space: SMS
- Hierarchy: n/a
- Doc ID: doc-sms-524223369
- Source: https://docs.adaptavist.com/sms/latest/migrate-to-cloud-using-the-scriptrunner-migration-suite

This page will help you plan and accomplish your migration from Data Center to Cloud, using the [ScriptRunner Migration Suite](https://docs.adaptavist.com/sms/latest). The following steps of a migration plan are outlined for you, including links to resources from Atlassian and ScriptRunner: 

-   [Before you start](#id-.BestPracticesfortheScriptRunnerMigrationSuitevCurrent-review)
-   [Install ScriptRunner for Jira Cloud](#id-.BestPracticesfortheScriptRunnerMigrationSuitevCurrent-install)
-   [Prepare your instance](#id-.BestPracticesfortheScriptRunnerMigrationSuitevCurrent-prepare)
-   [Rewrite your scripts](#id-.BestPracticesfortheScriptRunnerMigrationSuitevCurrent-rewrite)
-   [Migrate your data](#id-.BestPracticesfortheScriptRunnerMigrationSuitevCurrent-migrate)
-   [Test your data](#id-.BestPracticesfortheScriptRunnerMigrationSuitevCurrent-test)
-   [Train your team](#id-.BestPracticesfortheScriptRunnerMigrationSuitevCurrent-train)
-   [Go live](#id-.BestPracticesfortheScriptRunnerMigrationSuitevCurrent-live)
-   [Need help?](#id-.BestPracticesfortheScriptRunnerMigrationSuitevCurrent-help)

More resources

Additionally, check out the [Atlassian documentation](https://www.atlassian.com/migration), [JCMA documentation](https://support.atlassian.com/migration/docs/jira-cloud-migration-assistant/), and the [FAQ: Migration and ScriptRunner Migration Suite](https://docs.adaptavist.com/sms/latest/migrate-to-cloud-using-the-scriptrunner-migration-suite/faq-migration-and-scriptrunner-migration-suite). 

## Before you start

Before you start your migration, review Atlassian's [Cloud Migration Guide](https://www.atlassian.com/migration/plan/cloud-guide) and prepare our Jira instance according to Atlassian's recommendations. You can also review the full [ScriptRunner for Jira Migration Guide](https://docs.adaptavist.com/sr4js/latest/scriptrunner-migration) for Cloud.

### Key takeaways

Scripts between ScriptRunner for Jira Data Center and Cloud are different. Please review the following resources for more information: 

-   [REST APIs](https://docs.adaptavist.com/sr4jc/latest/get-started/technical-background#rest-apis)
-   [Feature Parity](https://docs.adaptavist.com/sr4js/latest/scriptrunner-migration/migrating-to-cloud/feature-parity-and-script-alternatives)
-   [JQL Queries](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/comparison-with-scriptrunner-for-jira-server#jql-query-comparison)

Reminder about ScriptRunner features

The [Script Registry](https://docs.adaptavist.com/sr4js/latest/features/script-registry) for Data Center and the [Script Manager](https://docs.adaptavist.com/sr4jc/latest/features/script-manager) for Cloud are similar features for ScriptRunner for Jira, but they function differently. Pease review the documentation to learn more about them, if needed.

### ![rocket](/plugins/servlet/twitterEmojiRedirector?id=1f680 "rocket") Learn more using the ScriptRunner Migration Suite

As a reminder, the ScriptRunner Migration Suite is made up of three tools: 

-   [ScriptRunner Migration Analyse and Assess Tool](https://docs.adaptavist.com/sms/latest/scriptrunner-migration-suite-web-app/scriptrunner-migration-analyse-and-assess-tool): A tool to analyse your current instance. Upload an export of your scripts and receive a full readiness report, including Cloud alternatives and rewrite guidance for every configuration in your instance.
-   [ScriptRunner Migration Agent](https://docs.adaptavist.com/sms/latest/scriptrunner-migration-suite-web-app/scriptrunner-migration-agent): An AI assistant loaded with migration knowledge. Ask it questions about platform differences, script rewrites, and migration planning at any stage of the process.
-   [ScriptRunner Dev and Deployment Tool](https://docs.adaptavist.com/sms/latest/scriptrunner-dev-and-deployment-tool): A standalone tool that lets you store your rewritten scripts in a code repository and deploy them to ScriptRunner Cloud without manually recreating each configuration in the UI.

We will also use the [Script Registry](https://docs.adaptavist.com/display/_PK/SR4JS/script-registry) from ScriptRunner for Jira Data Center that gives you an export of your scripts and configurations to use with the Assess and Analyse tool. 

-   You can ask the [ScriptRunner Migration Agent](https://docs.adaptavist.com/sms/latest/scriptrunner-migration-suite-web-app/scriptrunner-migration-agent) questions about your ScriptRunner migration at any point!   
    
    Example questions
    
    > _"Which ScriptRunner features work differently in Cloud?"  
    > __"What is Enhanced Search and how does it replace my JQL functions?"  
    > __"What do I need to rewrite when moving to Cloud?"  
    > _
    
    These are just two examples of what you can ask the Migration Agent. It's loaded with content to help you understand the difference between platforms and how to prepare for your migration.
    
-   Use the [ScriptRunner Migration Analyse and Assess Tool](https://docs.adaptavist.com/sms/latest/scriptrunner-migration-suite-web-app/scriptrunner-migration-analyse-and-assess-tool) to understand your instance and the scripts that you have. [Upload the export of your instance and start reviewing your reports](https://docs.adaptavist.com/sms/latest/scriptrunner-migration-suite-web-app/scriptrunner-migration-analyse-and-assess-tool/use-the-analyse-and-assess-tool) to learn about your instance's readiness. 

## Install ScriptRunner for Jira Cloud

Skip this step if you have already installed!

Install ScriptRunner for Jira Cloud as described on our [Installation](https://docs.adaptavist.com/display/_PK/SR4JC/installation) page.  

## Prepare your migration

You are ready to start preparing your ScriptRunner instance! 

### Back up your test instance 

Back up your current test ScriptRunner Data Center environment, including all scripts and configurations. 

### Export your scripts using Script Registry

Do you need an upgrade before you migrate?

You may need to update ScriptRunner for Data Center before migrating for the [Export](https://docs.adaptavist.com/sr4js/latest/features/script-registry#exporting-your-scripts) feature. Check the [Version History](https://marketplace.atlassian.com/apps/6820/scriptrunner-for-jira/version-history?versionHistoryHosting=dataCenter) on Marketplace to ensure you're getting the most recent version of ScriptRunner for Jira Data Center to get the full analysis.

Use the [Script Registry](https://docs.adaptavist.com/display/_PK/SR4JS/script-registry) feature in ScriptRunner for Jira Data Center to export all scripts and configurations of your instance that you want to migrate to your Cloud instance. When you export your instance, it is stored as a local copy. You will need this to use the [ScriptRunner Migration Analyse and Assess Tool](https://docs.adaptavist.com/sms/latest/scriptrunner-migration-suite-web-app/scriptrunner-migration-analyse-and-assess-tool) in the next step. 

### ![rocket](/plugins/servlet/twitterEmojiRedirector?id=1f680 "rocket") Review your scripts using ScriptRunner Migration Suite

[Use the Analyse and Assess Tool](https://docs.adaptavist.com/sms/latest/scriptrunner-migration-suite-web-app/scriptrunner-migration-analyse-and-assess-tool/use-the-analyse-and-assess-tool) to review your exported scripts and decide what is still needed. Data Center instances often accumulate legacy scripts, duplicates, or configurations tied to deprecated workflows over time. Removing or consolidating these now means less work in the rewrite phase and a cleaner Cloud instance. The Analyze and Assess Tool to tell you what old scripts that may not be in use anymore do. 

Reminder about ScriptRunner features

Fragments and REST Endpoints are not available in Cloud, so they will always be red in reports. Learn more in the [Feature Parity](https://docs.adaptavist.com/sr4js/latest/scriptrunner-migration/migrating-to-cloud/feature-parity-and-script-alternatives) guide.

Use the [Audit Your Jira Instance Using ScriptRunner](https://docs.adaptavist.com/sr4js/latest/best-practices/audit-your-jira-instance-using-scriptrunner) page for a checklist that guides you through auditing parts of your ScriptRunner for Jira Data Center.

Create a new export if needed

Make sure you have a new version of your export here that includes all scripts. 

### ![rocket](/plugins/servlet/twitterEmojiRedirector?id=1f680 "rocket") Create your migration strategy using ScriptRunner Migration Suite

With the insights gained from reviewing and evaluating your scripts, develop a comprehensive migration strategy using the [ScriptRunner Migration Agent](https://docs.adaptavist.com/sms/latest/scriptrunner-migration-suite-web-app/scriptrunner-migration-agent). This plan should include:

-   **Timelines**: Set realistic timelines for each phase of the migration, considering the complexity of script preparation and rewriting. This is typically the most time-consuming phase.  
    
    ScriptRunner Enhanced Search initial synchronization estimate
    
    After installing ScriptRunner for Jira Cloud, an initial synchronisation is required before Enhanced Search results are accurate. This can take several days depending on instance size. Factor this time into your migration plan before your go-live date. Check out our [Enhanced Search documentation](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-keywords-synchronization "https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-keywords-synchronization") for more details.
    
-   **Resources**: Identify and allocate the necessary resources including personnel, tools, and budget to support the migration process.
-   **Responsibilities**: Clearly define roles and responsibilities for all stakeholders involved in the migration to ensure accountability and smooth execution.

Use the Migration Agent to write a strategy report

Paste this into the [ScriptRunner Migration Agent](https://docs.adaptavist.com/sms/latest/scriptrunner-migration-suite-web-app/scriptrunner-migration-agent) for a concise report about your migration:

> Consolidate the outputs of this process in to a single report, you can iterate over this report to produce the highest quality. The different sections should be clearly outlined. Wiki markdown can be used for tables. Use the following sections as a template but add other sections as appropriate. Provide an index at the top to enable quick access to different sections do not use the section numbering below but retain the hierarchy.

1.  > Migration Analysis Summary
    > 
    > 1.   What the original script does
    > 2.   Overview of key migration challenges
    > 3.   Migration strategy
    
2.  > Refactored Cloud script as a code block
    
3.  > Implementation Guide
    > 
    > 1.   Important Notes
    >     1.   Custom Field IDs
    >     2.   JQL Query changes
    >     3.   Permissions
    >     4.   Any other notes or further customisation requirements eg replacement of unique IDs in the script
    > 2.   Deployment Steps
    > 3.   Details of any manual adjustments still required
    > 4.   Testing Recommendations
    
4.  > Original data centre script as a code block
    
5.  > Data Center vs Cloud Migration Comparison
    > 
    > 1.   Original Data Center Script Issues
    > 2.   Key Improvements in Cloud Version
    > 3.   Migration Benefits
    
6.  > Key changes Made
    > 
    > 1.   Removed Data Center Dependencies and where have HAPI Methods been used
    > 2.   Improved Error Handling
    > 3.   Automatic Benefits
    > 4.   Before vs After Comparison
    
7.  > Optional Enhancements
    

## Rewrite your scripts

Migration from Scriptrunner for Jira DC to ScriptRunner for Jira Cloud requires your scripts to be rewritten because the APIs and programming models differ significantly between Jira Data Center and Jira Cloud. The ScriptRunner Migration Suite is built for this! Before you get started, make sure you have that export using Script Registry [that you created after auditing your instance](#id-.BestPracticesfortheScriptRunnerMigrationSuitevCurrent-scriptregistry).

ScriptRunner for Jira documentation

See our detailed guide on [Rewriting Scripts for Cloud](https://docs.adaptavist.com/sr4js/latest/scriptrunner-migration/migrating-to-cloud/rewriting-scripts-for-cloud-hints-and-tips) for examples.

### ![rocket](/plugins/servlet/twitterEmojiRedirector?id=1f680 "rocket") Analyze all scripts in your instance

Follow the steps on the [Use the Analyse and Assess Tool](https://docs.adaptavist.com/sms/latest/scriptrunner-migration-suite-web-app/scriptrunner-migration-analyse-and-assess-tool/use-the-analyse-and-assess-tool) page to upload and analyze your scripts. In the analysis, you receive: 

-   **A readiness report**: Scripts and configurations are grouped by features (listeners, workflows, etc.) and individual configurations.
-   **Cloud pointers**: When there is no parity for Cloud, you can see what alternatives exist, including links and identifiers for Cloud options (like HAPI or REST endpoints). Using these pointers, you can start rewriting with concrete next steps.

### ![rocket](/plugins/servlet/twitterEmojiRedirector?id=1f680 "rocket") Analyze a specific script

The Migration Agent will [rewrite a single script for you](https://docs.adaptavist.com/sms/latest/scriptrunner-migration-suite-web-app/scriptrunner-migration-analyse-and-assess-tool/use-the-analyse-and-assess-tool) to use in your Cloud instance. It will also provide an explanation and further steps that should be taken with the script.

Use the Migration Agent

Do you have a specific questions about a script? Ask the Migration Agent!

## Migrate your data

It's time to migrate your data into your Cloud instance! You can migrate your data either manually or by using the [ScriptRunner Dev and Deployment Tool](https://docs.adaptavist.com/sms/latest/scriptrunner-dev-and-deployment-tool). The right approach depends on your instance size and how much manual effort you want to invest. 

### Manually migrate ScriptRunner

Recreate all your custom scripts and scriptrunner configurations in ScriptRunner for Jira Cloud. This approach is best for smaller instances with a manageable number of configurations. 

Consult the [Platform Differences between ScriptRunner for Jira Server/DC and Jira Cloud](https://docs.adaptavist.com/sr4js/latest/scriptrunner-migration/migrating-to-cloud/platform-differences-between-scriptrunner-for-jira-server-dc-and-jira-cloud) and [Feature Parity and Script Alternatives](https://docs.adaptavist.com/sr4js/latest/scriptrunner-migration/migrating-to-cloud/feature-parity-and-script-alternatives) documentation during this process to address any Cloud-specific considerations.

###  ![rocket](/plugins/servlet/twitterEmojiRedirector?id=1f680 "rocket") Migrate with the Dev and Deployment Tool

ScriptRunner Migration Suite adds a third option for you with the [Dev and Deployment Tool](https://docs.adaptavist.com/sms/latest/scriptrunner-dev-and-deployment-tool)! [Use this tool](https://docs.adaptavist.com/sms/latest/scriptrunner-dev-and-deployment-tool/use-the-dev-and-deployment-tool) to organize and deploy ScriptRunner Cloud scripts. It is focused on making it easier and faster for consultants and developers to migrate, test, and deploy scripts from ScriptRunner DC to Cloud. This approach is best for larger instances or teams who want repeatable, version-controlled deployments.

  

Need another reason to use the Dev and Deployment Tool?

A good reason to use the Dev and Deployment Tool is that you can deploy to a test instance first to test the scripts. 

The Dev and Deployment Tool gives you a place to save your script code and their configurations _and_ a way to deploy that code to ScriptRunner in your Atlassian Cloud site without having to manually point-and-click through the UI. This is helpful if you have a lot of scripts, particularly if you want to test them in a separate instance before deploying them to production.

  

Please visit [Use the Dev and Deployment Tool](https://docs.adaptavist.com/sms/latest/scriptrunner-dev-and-deployment-tool/use-the-dev-and-deployment-tool) to learn how to clone the [public repository](https://bitbucket.org/adaptavistlabs/migration-example-project/src/main/) and follow the README to configure and run the tooling.

Background knowledge

To use the Dev and Deployment Tool, we assume you can do a few fairly technical things:

-   Use Git, at least a little, to manage code. It's totally fine if you use tools like SourceTree or your IDE to make this easier for you.
-   Run commands using an IDE like IntelliJ IDEA or via a terminal or command line. We'll tell you which commands. 

The Dev and Deployment Tool works by running Gradle tasks to send your script code and configurations to ScriptRunner Cloud. You don't need to know anything about Gradle or how it works to use the tool, as long as you can run the commands described in the documentation here.

## Test your configurations

Make sure all testing is completed in a staging environment. 

Ensure the initial sync has completed before testing. 

Make sure to test the full behavior of each migrated component, not just that scripts run without errors. Test the following: 

-   Verify that listeners fire on the correct events
-   Workflow post-functions and conditions behave as expected
-   Behaviours apply correctly on the right screens
-   Scheduled jobs run on time
-   Enhanced Search returns accurate results

### ![rocket](/plugins/servlet/twitterEmojiRedirector?id=1f680 "rocket") How ScriptRunner Migration Suite can help

Once you determine what you want to test, the [ScriptRunner Migration Agent](https://docs.adaptavist.com/sms/latest/scriptrunner-migration-suite-web-app/scriptrunner-migration-agent) can help you test your new instance out. 

> Describe what a script does and ask, "_What test cases should I write to validate this script has migrated correctly?_" for tailored test case suggestions.

## Train your team 

The next step is to train your team!

### Admins

Make sure your Jira admins are familiar with the ScriptRunner for Jira Cloud interface, the differences in how scripts are written and managed, and that not every script can be migrated to Cloud. Refer them to the [ScriptRunner for Jira Cloud training](https://docs.adaptavist.com/sr4jc/latest/training) to get started. Things to know: 

-   How do you report when a script doesn't work as it did in Data Center?
-   How do you troubleshoot problems? 

### End users

Users who write JQL queries are most affected by the move to [Enhanced Search](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search). Provide training on the new keyword-based syntax and make sure they know who to contact if a previously working query no longer behaves as expected.

### ![rocket](/plugins/servlet/twitterEmojiRedirector?id=1f680 "rocket") How ScriptRunner Migration Suite can help

The [ScriptRunner Migration Agent](https://docs.adaptavist.com/sms/latest/scriptrunner-migration-suite-web-app/scriptrunner-migration-agent) can help you create a plan and materials to help train your team.

> Ask "_Can you help me create training materials and a communication plan for my team's migration to Jira Cloud_?" for audience-specific training content and communication templates.

## Go live 

Alongside your [JCMA](https://support.atlassian.com/migration/docs/jira-cloud-migration-assistant/) migration plan, after thorough testing and team training, you're ready to go live with your migrated ScriptRunner for Jira Cloud instance. Before cutting over, make sure to: 

-   Notify all users of the migration date and what to expect.
-   Test your rollback plan.  
    Document the conditions that would trigger a rollback and confirm how quickly your Data Center environment can be restored if needed.

Once live, monitor the performance of your instance and your scripts. Keep an eye out for any unexpected behaviors in workflows, searches, and scheduled jobs. Encourage your team members or admins to report any issues promptly. 

Data Center banner messaging

If your Data Center instance is still live, consider adding a banner message to redirect users that navigate there instead of your new Cloud instance. 

## Need help? 

If you have a question, try asking [ScriptRunner Migration Agent](https://docs.adaptavist.com/sms/latest/scriptrunner-migration-suite-web-app/scriptrunner-migration-agent)! It can help with any migration question at any stage of the process. If you need further help, please [reach out to support](https://the-adaptavist-group-support.atlassian.net/servicedesk/customer/portal/1069/user/login?destination=portal%2F1069) for assistance!
