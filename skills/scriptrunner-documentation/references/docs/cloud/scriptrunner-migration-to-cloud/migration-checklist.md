# Migration Checklist

- Platform: cloud
- Space: SR4JC
- Hierarchy: scriptrunner-migration-to-cloud
- Doc ID: doc-sr4jc-101629528
- Source: https://docs.adaptavist.com/sr4jc/latest/scriptrunner-migration-to-cloud/migration-checklist

## ✅ Familiarize yourself with Atlassian's migration documentation

Before proceeding, we recommend familiarizing yourself with Atlassian's [Cloud Migration Guide](https://www.atlassian.com/migration/plan/cloud-guide) and preparing your Jira instance according to Atlassian's recommendations. This checklist is designed to guide you through migrating ScriptRunner for Jira from Data Center (DC) to Cloud. While it focuses specifically on ScriptRunner for Jira, some tasks may overlap with Atlassian's general migration recommendations.

**🚀 Need help with your migration?**

Check out what our [Development Services](https://www.adaptavist.com/solutions/development-services) team have to offer, or [contact us](https://www.scriptrunnerhq.com/about/contact).

## ✅ Learn about the differences between DC and Cloud

Use these resources to learn about feature parity and platform differences between the two products: 

-   [Migration Cheat Sheet](https://www.scriptrunnerhq.com/locker/migration-cheat-sheet)
-   [Platform Differences between ScriptRunner for Jira Server/DC and Jira Cloud](https://docs.adaptavist.com/sr4js/latest/scriptrunner-migration/migrating-to-cloud/platform-differences-between-scriptrunner-for-jira-server-dc-and-jira-cloud)
-   [Feature Parity and Script Alternatives](https://docs.adaptavist.com/sr4js/latest/scriptrunner-migration/migrating-to-cloud/feature-parity-and-script-alternatives)
-   [JQL Query Comparison](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/comparison-with-scriptrunner-for-jira-server#jql-query-comparison)

REST APIs

Scripts in Jira Cloud do not execute within the same process as Jira DC and so must interact with Jira using the [REST APIs](https://docs.adaptavist.com/sr4jc/latest/get-started/technical-background#rest-apis) rather than the JAVA APIs.

## ✅ Prepare

Try our migration tools!

The ScriptRunner Migration Suite is a suite of tools that helps you plan, analyse, convert and deploy scripts with confidence, significantly reducing the manual migration effort. It supports (not replaces) your expertise. The suite is made up of three tools: 

-   [ScriptRunner Migration Analyse and Assess Tool](https://docs.adaptavist.com/sms/latest/scriptrunner-migration-suite-web-app/scriptrunner-migration-analyse-and-assess-tool): Use this tool to review your ScriptRunner Data Center scripts and configurations for risks and cloud readiness.
-   [The ScriptRunner Migration Agent](https://docs.adaptavist.com/sms/latest/scriptrunner-migration-suite-web-app/scriptrunner-migration-agent): Use our specialised AI chat agent to create, convert, and optimise scripts, or you can use it to answer a variety of different questions about ScriptRunner.
-   [ScriptRunner Dev and Deployment Tool](https://docs.adaptavist.com/sms/latest/scriptrunner-dev-and-deployment-tool): Use this tool to organise and deploy ScriptRunner Cloud scripts. It is focused on making it easier and faster for consultants and developers to migrate, test, and deploy scripts from ScriptRunner DC to Cloud.

If you have any questions, need help, or would like to request access, the quickest way to get assistance is through our [dedicated support portal](https://the-adaptavist-group-support.atlassian.net/servicedesk/customer/portal/1069/user/login?destination=portal%2F1069).

### Back up your instance

Start by backing up your current DC environment, including all scripts and configurations. 

Before migrating, ensure you're using ScriptRunner for Jira DC version 8.18.0 or above.

### Create a migration plan

Follow these steps to create a tailored migration plan for a smooth cloud transition:

1.  **Review your current instance:** Thoroughly review your current DC instance. Decide whether you need to migrate everything or declutter your instance. See our [Audit Your Jira Instance Using ScriptRunner](https://docs.adaptavist.com/sr4js/latest/best-practices/audit-your-jira-instance-using-scriptrunner) page for a checklist that guides you through auditing parts of your instance.   
    
    You can use the [Script Registry](https://docs.adaptavist.com/display/_PK/SR4JS/script-registry) to **export all scripts** and configurations on your instance.
    
2.  **Evaluate script requirements:** Determine which scripts can be directly rewritten for the cloud environment and which ones will require alternative solutions. This step is crucial for understanding the scope of work needed for the migration. See our [Rewriting Scripts for Cloud](https://docs.adaptavist.com/sr4js/latest/scriptrunner-migration/migrating-to-cloud/rewriting-scripts-for-cloud-hints-and-tips#preparation-steps) page for details on how to review your instance and prepare your scripts.  
    
    Make sure you have a migration path for each script and that you have an alternative solution for the scripts that can't be migrated. 
    
    Be aware that some of the steps on the [Rewriting Scripts for Cloud](https://docs.adaptavist.com/sr4js/latest/scriptrunner-migration/migrating-to-cloud/rewriting-scripts-for-cloud-hints-and-tips#preparation-steps) page may overlap with the guidance provided here.
    
3.  **Develop a detailed migration plan:** With the insights gained from reviewing and evaluating your scripts, develop a comprehensive migration plan. This plan should include:  
    -   **Timelines**: Set realistic timelines for each phase of the migration, considering the complexity of script preparation and rewriting.  
        
        ScriptRunner Enhanced Search Initial Synchronisation Estimate
        
        ScriptRunner JQL functions have been implemented as [Enhanced Search](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search "https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search") within ScriptRunner for Jira Cloud. After installation, an initial JQL Keyword sync is required, which may take several days depending on your instance size (for example, 5.8 days for 1 million issues). **Factor this sync time into your migration plan and consult our** [**Enhanced Search documentation**](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-keywords-synchronization "https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-keywords-synchronization") **for more details.**
        
    -   **Resources**: Identify and allocate the necessary resources, including personnel, tools, and budget, to support the migration process.
    -   **Responsibilities**: Clearly define roles and responsibilities for all stakeholders involved in the migration to ensure accountability and smooth execution.

## ✅ Install ScriptRunner for Jira Cloud

Skip this step if you have already done it!

Install ScriptRunner for Jira Cloud as described on our [Installation](https://docs.adaptavist.com/display/_PK/SR4JC/installation) page.  

## ✅ Rewrite your scripts

Migration from Scriptrunner for Jira DC to ScriptRunner for Jira Cloud **will require your scripts to be rewritten**. This is because the APIs and programming models differ significantly between Jira Data Center and Jira Cloud.

See our detailed guide on [Rewriting Scripts for Cloud](https://docs.adaptavist.com/sr4js/latest/scriptrunner-migration/migrating-to-cloud/rewriting-scripts-for-cloud-hints-and-tips).

## ✅ Rewrite your saved ScriptRunner JQL query filters 

Both versions of ScriptRunner use JQL Functions. However, this feature has been implemented as [Enhanced Search](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search) within ScriptRunner for Jira Cloud. You **might** need to rewrite your saved JQL query filters that use ScriptRunner JQL functions.

JCMA and ScriptRunner JQL functions

[Jira Cloud Migration Assistant](https://marketplace.atlassian.com/apps/1222010/jira-cloud-migration-assistant?hosting=datacenter&tab=overview&_gl=1*l8m3e8*_gcl_aw*R0NMLjE3NDQ3MDg1NDIuQ2owS0NRandoX2lfQmhDekFSSXNBTmltZW9FQXlzOUxmdG81Zm1UeHVEdEVMTXFZbUtIQU5OWHZrUHBhbzZxblZjQ0c5T0lHSThBZVVWc2FBbkZURUFMd193Y0I.*_gcl_au*NjI2MTU5MDguMTc1MDA2MDUzNw..*_ga*MTYzNTU0NTI3OC4xNzQyMjI2ODg5*_ga_C6V1F2HSMM*czE3NTAzMTkyMzIkbzkzNiRnMSR0MTc1MDMyNTAwMSRqNjAkbDAkaDM3NTg2NTkzNQ..) (JCMA) is an Atlassian app created to help with migrations from Data Center to Cloud. If you use JCMA to migrate, filters containing ScriptRunner JQL functions will be automatically migrated if equivalent Enhanced Search functions exist. Filters with non-equivalent ScriptRunner JQL functions will be deleted during migration.

To rewrite your ScriptRunner JQL query filters:

1.  Identify all saved JQL query filters that use ScriptRunner JQL functions.  
    
    Most ScriptRunner for Jira JQL functions require the `issueFunction` prefix, making them easier to identify. See our [Included JQL Functions](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions) documentation for a complete list of ScriptRunner JQL functions.
    
2.  Identify any filters owned by deactivated users. Transfer these to active Jira users before migrating, or the filters will not work in Cloud.
3.  Identify any ScriptRunner queries that do not have equivalent Enhanced Search functions. These are the filters you will have to rewrite.   
    
    See the following documentation to help you rewrite your saved JQL query filters:
    
    -   [JQL Functions Feature Parity](https://docs.adaptavist.com/sr4js/latest/scriptrunner-migration/migrating-to-cloud/feature-parity-and-script-alternatives#jql-functions)
    -   [JQL Query Comparison](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/comparison-with-scriptrunner-for-jira-server#jql-query-comparison)
    -   [Enhanced Search Training](https://docs.adaptavist.com/sr4jc/latest/training/course-scriptrunner-for-jira-cloud-for-beginners/1-4-module-enhanced-search)
    
4.  Prepare versions of your filters to work with the Enhanced Search feature in ScriptRunner for Jira Cloud.

## ✅ Migrate your data

You can migrate your data either manually or using the [Jira Cloud Migration Assistant](https://marketplace.atlassian.com/apps/1222010/jira-cloud-migration-assistant?hosting=datacenter&tab=overview&_gl=1*l8m3e8*_gcl_aw*R0NMLjE3NDQ3MDg1NDIuQ2owS0NRandoX2lfQmhDekFSSXNBTmltZW9FQXlzOUxmdG81Zm1UeHVEdEVMTXFZbUtIQU5OWHZrUHBhbzZxblZjQ0c5T0lHSThBZVVWc2FBbkZURUFMd193Y0I.*_gcl_au*NjI2MTU5MDguMTc1MDA2MDUzNw..*_ga*MTYzNTU0NTI3OC4xNzQyMjI2ODg5*_ga_C6V1F2HSMM*czE3NTAzMTkyMzIkbzkzNiRnMSR0MTc1MDMyNTAwMSRqNjAkbDAkaDM3NTg2NTkzNQ..) (JCMA). We recommend using JCMA when migrating an instance with ScriptRunner from DC to Cloud.

### Manually migrate ScriptRunner

You can now recreate all your custom scripts and scriptrunner configurations in ScriptRunner for Jira Cloud. To manually migrate to Cloud:

-   Utilize your previously prepared scripts to recreate your custom configurations in ScriptRunner for Jira Cloud. 
    
-   Implement your revised JQL functions using Enhanced Search in ScriptRunner for Jira Cloud.
    
-   Address each ScriptRunner feature individually, such as behaviours, listeners, and scheduled jobs.
    
-   Identify and resolve any dependencies that may not be directly available in the Cloud version.
    
-   Consult the [Platform Differences between ScriptRunner for Jira Server/DC and Jira Cloud](https://docs.adaptavist.com/sr4js/latest/scriptrunner-migration/migrating-to-cloud/platform-differences-between-scriptrunner-for-jira-server-dc-and-jira-cloud) and [Feature Parity and Script Alternatives](https://docs.adaptavist.com/sr4js/latest/scriptrunner-migration/migrating-to-cloud/feature-parity-and-script-alternatives) documentation during this process to address any Cloud-specific considerations.

### Migrate ScriptRunner with Jira Cloud Migration Assistant

When using [JCMA](https://marketplace.atlassian.com/apps/1222010/jira-cloud-migration-assistant?hosting=datacenter&tab=overview&_gl=1*l8m3e8*_gcl_aw*R0NMLjE3NDQ3MDg1NDIuQ2owS0NRandoX2lfQmhDekFSSXNBTmltZW9FQXlzOUxmdG81Zm1UeHVEdEVMTXFZbUtIQU5OWHZrUHBhbzZxblZjQ0c5T0lHSThBZVVWc2FBbkZURUFMd193Y0I.*_gcl_au*NjI2MTU5MDguMTc1MDA2MDUzNw..*_ga*MTYzNTU0NTI3OC4xNzQyMjI2ODg5*_ga_C6V1F2HSMM*czE3NTAzMTkyMzIkbzkzNiRnMSR0MTc1MDMyNTAwMSRqNjAkbDAkaDM3NTg2NTkzNQ..) for migration, the process is partially automated. However, you will still need to perform many migration tasks manually (such as recreating built-in feature configurations, behaviours, fragments, and more). This section outlines what JCMA can migrate automatically and what requires manual intervention.

ScriptRunner Data During JCMA Migrations

When migrating from Jira Data Center to Jira Cloud using the Jira Cloud Migration Assistant (JCMA), ScriptRunner configuration data migrates as part of your Jira data.

According to Atlassian, migration data is [temporarily stored in transit in US-WEST or US-EAST for up to 14 days](https://support.atlassian.com/migration/docs/migrations-trust-and-security-faqs/#Data-management-and-control:~:text=data%20is%20temporarily%20stored%20%27in%2Dtransit%27%20in%20US%2DWEST%20or%20US%2DEAST%20for%20a%20period%20of%20up%20to%2014%20days.) during the migration process. Because ScriptRunner data is embedded within Jira configuration data (for example, [Workflow Rules](https://docs.adaptavist.com/sr4jc/current/features/workflow-rules) are embedded directly into your workflows), it follows the same migration path.

ScriptRunner does not control where Atlassian stores or routes JCMA migration data during transfer.

Our migration processing services operate in both the EU and the US regions. If your ScriptRunner Cloud data residency is set to EU, ScriptRunner migration processing will occur in the EU where applicable. However, any data handled directly by JCMA during migration remains under Atlassian’s control.

#### Features supported by JCMA

JCMA automatically migrates the configurations for the following ScriptRunner features:

These features are copied and then deactivated, with any code commented out.

-   Custom script fields
-   Custom script listeners
-   Custom script scheduled jobs
-   Custom script escalation services
-   Custom workflow functions

#### JQL functions supported by JCMA

If you are using [Enhanced Search](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search) JQL functions and Keywords, you must complete an [initial synchronisation](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/jql-keywords-synchronization) after migrating so that all functions and keywords work.

JCMA automatically migrates filters containing ScriptRunner JQL functions if equivalent Enhanced Search functions exist. **Filters with non-equivalent ScriptRunner JQL functions will be deleted during migration.**

The following JQL functions have equivalents in Enhanced Search and are supported by JCMA:

-   addedAfterSprintStart
-   componentMatch
-   dateCompare  
    
-   epicsOf
-   issueFieldExactMatch
-   issueFieldMatch
-   issuesInEpics
-   linkedIssuesOf
-   linkedIssuesOfRecursive
-   linkedIssuesOfRecursiveLimited
-   nextSprint
-   parentsOf
-   previousSprint
-   projectMatch
-   subtasksOf
-   versionMatch

The Enhanced Search version of the dateCompare function requires a valid JQL query in the first parameter. It will be automatically migrated when all parameters are provided. If there's a mismatch between Cloud/DC issue field names (for example in custom fields), the migration won't automatically create an Enhanced Search filter, and it will need to be created manually.

It is important to note that even if equivalent functions exist, filters that contain invalid or unparseable Jira Cloud JQL will not be normalized and may cause errors in Enhanced Search.

For example, a JQL query in Jira Data Center that escapes double quotes using backslashes, such as `issueFunction in issuesInEpics("\"project\" = \"SLASH\""),` is valid in Jira Data Center but can cause issues during migration to Jira Cloud. To avoid problems during migration, we recommend the following:

-   Update these queries prior to migration by replacing escaped double quotes with a Jira Cloud-compatible format (for example, using single quotes where applicable). 
-   If the filter owners cannot be migrated, transfer ownership of the filters in your Jira Data Center instance before completing the migration.
-   Ensure that the original filter owner in Jira Cloud is an active user with access to the Jira Cloud instance, as well as to any groups or projects with which the filters are shared.

#### JCMA post migration steps

1.  Check the [migration report](https://docs.adaptavist.com/sr4jc/latest/scriptrunner-migration-to-cloud/troubleshoot-scriptrunner-migration#migration-reports) in ScriptRunner for Jira Cloud to find the details of any problems during filter migration.  
    
    All script configurations for other ScriptRunner features (such as built-in feature configurations, behaviours, fragments, etc.) will need to be recreated manually. 
    
2.  Review all deactivated custom scripts, update them for Cloud compatibility, and reactivate them.
3.  Manually update ScriptRunner for Jira Cloud as described in the [Manually migrate ScriptRunner](#id-.MigrationChecklistvCurrent-manual) section. 

Once custom script fields, listeners, or scheduled jobs are migrated, subsequent migrations will not overwrite them. To re-migrate these items, delete them from the Cloud instance before performing another migration.

JCMA Notes

You should note the following points when using [JCMA](https://marketplace.atlassian.com/apps/1222010/jira-cloud-migration-assistant?hosting=datacenter&tab=overview&_gl=1*l8m3e8*_gcl_aw*R0NMLjE3NDQ3MDg1NDIuQ2owS0NRandoX2lfQmhDekFSSXNBTmltZW9FQXlzOUxmdG81Zm1UeHVEdEVMTXFZbUtIQU5OWHZrUHBhbzZxblZjQ0c5T0lHSThBZVVWc2FBbkZURUFMd193Y0I.*_gcl_au*NjI2MTU5MDguMTc1MDA2MDUzNw..*_ga*MTYzNTU0NTI3OC4xNzQyMjI2ODg5*_ga_C6V1F2HSMM*czE3NTAzMTkyMzIkbzkzNiRnMSR0MTc1MDMyNTAwMSRqNjAkbDAkaDM3NTg2NTkzNQ..):

-   If re-migrating a project, delete the project and associated workflows/workflow scheme for workflow rules to be migrated correctly.
-   Built-in script conditions or validators migrated from Jira DC are not supported and will display in ScriptRunner for Jira Cloud as blank validators or conditions. Therefore, once the migration is performed, these will need to be deleted.

## ✅ Test thoroughly

Make sure all testing is completed in a staging environment. 

Perform extensive testing of all migrated components:

-   Projects and issues
-   Workflows
-   Scripts
-   JQL functions
-   ScriptRunner-specific functionalities

Ensure all ScriptRunner functionalities work as expected in the Cloud environment.

## ✅ Train your team

Train your admins on the differences between Jira Data Center and Jira Cloud:

-   Make sure they're familiar with the new ScriptRunner for Jira Cloud interface and capabilities. To get them started, refer your admins to our [ScriptRunner for Jira Cloud training](https://docs.adaptavist.com/sr4jc/latest/training) documentation.
-   Highlight the differences in [scripting in ScriptRunner for Jira Cloud](https://docs.adaptavist.com/sr4jc/latest/get-started/scripting-in-scriptrunner-for-jira-cloud).

Train the rest of your team on [Enhanced Search](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search) so they're familiar with the new functionality. 

## ✅ Go live

After thorough testing and team training, you're ready to go live with your migrated ScriptRunner for Jira Cloud instance. Consider the following when you go live:

-   Make sure all users are aware of this move to Cloud.
-   Once live, monitor the performance of your instance and your scripts. Keep an eye out for any unexpected behaviors.
-   Encourage any team members or admins to provide feedback and report any issues.
