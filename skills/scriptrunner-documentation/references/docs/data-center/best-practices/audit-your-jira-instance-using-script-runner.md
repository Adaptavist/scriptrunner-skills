# Audit Your Jira Instance Using ScriptRunner

- Platform: data-center
- Space: SR4JS
- Hierarchy: best-practices
- Doc ID: doc-sr4js-462192648
- Source: https://docs.adaptavist.com/sr4js/latest/best-practices/audit-your-jira-instance-using-scriptrunner

This checklist offers a comprehensive guide to using ScripRunner to audit your Jira instance and ScriptRunner scripts. A thorough audit ensures a smoother migration process, reduces unexpected issues, and helps you optimize your instance for your move to Cloud.

This guide specifically focuses on leveraging ScriptRunner features to audit your Jira instance. While comprehensive within this scope, it does not encompass all possible auditing methods or tools. Additional auditing techniques, particularly those not involving ScriptRunner, may be necessary for a complete pre-migration assessment. We recommend consulting [Atlassian's migration documentation](https://www.atlassian.com/migration/plan/cloud-guide#introduction) and other relevant resources to ensure a thorough audit of your entire Jira instance.

## When to audit your instance

The timing of your audit depends on your migration plans. If you're not currently planning a migration, you can audit your Jira Data Center instance at any convenient time. For those preparing to migrate to Jira Cloud, you should conduct your audit during the [Assess](https://www.atlassian.com/migration/plan/cloud-guide#assess) phase. Atlassian recommends starting this process 3-6 months before your desired migration date, or 6-12 months for complex migrations.

Auditing your instance before migration allows you to:

-   Identify potential migration blockers early in the process, giving you time to address them
-   Clean up unnecessary data to reduce migration time and costs
-   Document your current state for comparison after migration
-   Ensure compliance with organizational policies and Atlassian's recommended practices
-   Optimize performance by addressing issues before they carry over to your new environment

Starting your audit early provides the time needed to make informed decisions about what to migrate, what to archive, and what to leave behind.

## ScriptRunner features to use for auditing

ScriptRunner provides multiple features to help you audit and prepare your Jira instance for migration:

-   [Instance Audit built-in script](https://docs.adaptavist.com/sr4js/9.x/features/built-in-scripts/instance-audit): This feature generates a numerical summary of key components, including users, projects, issues, custom fields, workflows, workflow functions, attachments, and installed apps. For a more comprehensive analysis, you can download CSV files containing more information on users, projects, custom fields, and workflow functions.
    
    Compatibility
    
    This built-in script is compatible with ScriptRunner version 8.54+, 9.25+, and 10.1+. 
    
-   [Guardrails built-in scripts](https://docs.adaptavist.com/sr4js/latest/features/built-in-scripts/guardrails-built-in-scripts): Atlassian defines guardrails as recommended limits for various Jira components to ensure optimal performance and stability. These built-in scripts help you check if certain guardrails exceed the recommended guidelines and bring any that do within the correct limits. For example, you can find issues with more comments than the guardrail and delete comments that exceed the threshold.
-   [Export scripts](https://docs.adaptavist.com/sr4js/9.x/features/script-registry#exporting-your-scripts): This feature enables you to export all ScriptRunner scripts, configurations, and custom fields (including native Jira custom fields) from your instance. This export facilitates a more comprehensive analysis of your ScriptRunner instance, as you will have the flexibility to conduct thorough audits using external tools and repositories of your choice.

Each of these features are key for efficiently auditing and preparing your instance for migration.

## Audit report best practices

Throughout your audit process, you'll generate multiple reports. These reports form the foundation of your migration planning and provide essential documentation for stakeholders.

When you're going through the auditing checklist, consider the following best practices:

-   Generate reports in a consistent format that can be easily compared over time
-   Include timestamps and version information in all reports
-   Store reports in a centralized location accessible to all stakeholders
-   Create summary reports for executive stakeholders and detailed reports for technical teams

Your audit reports should drive concrete decisions about what to migrate, what to archive, and what to leave behind.

## Audit checklist

### ![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg) Check your guardrails

Atlassian's guardrails represent recommended limits designed to maintain instance performance and stability. Exceeding these limits can lead to poor performance in your current instance, longer migration times, and potential issues in your target environment. You can identify and fix guardrails that have exceeded the recommended guidelines using our [Guardrails built-in scripts](https://docs.adaptavist.com/sr4js/latest/features/built-in-scripts/guardrails-built-in-scripts):

-   [Maximum Comments Per Issue](https://docs.adaptavist.com/sr4js/latest/features/built-in-scripts/guardrails-built-in-scripts/maximum-comments-per-issue): Use this built-in script to find issues with more comments than the guardrail, and delete comments that exceed the threshold. 
-   [Maximum Number of Unarchived Projects](https://docs.adaptavist.com/sr4js/latest/features/built-in-scripts/guardrails-built-in-scripts/maximum-number-of-unarchived-projects): Use this built-in script to find projects that have not been updated for a specified amount of time, and archive them.
-   [Maximum Attachment Size](https://docs.adaptavist.com/sr4js/latest/features/built-in-scripts/guardrails-built-in-scripts/maximum-attachment-size): Use this built-in script to find attachments over the specified size, and delete them.
-   [Maximum Number of Issue Links Per Issue](https://docs.adaptavist.com/sr4js/latest/features/built-in-scripts/guardrails-built-in-scripts/maximum-number-of-issue-links-per-issue): Use this built-in script to find issues that contain more issue links than the recommended amount, and archive or delete the oldest.
-   [Maximum Change History Records Per Issue](https://docs.adaptavist.com/sr4js/latest/features/built-in-scripts/guardrails-built-in-scripts/maximum-change-history-records-per-issue): Use this built-in script to find issues with change items that exceed the recommended amount, and delete the oldest.

### ![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg) Analyse your workflows

Use our Instance Audit built-in script

Use the [Instance Audit](https://docs.adaptavist.com/sr4js/latest/features/built-in-scripts/instance-audit) feature to help you analyse your workflows. This built-in script exports workflow function data in CSV format, compatible with most spreadsheet applications. The exported data includes workflow names, statuses, transition, type, and plug-ins that provides the function. 

Workflow auditing helps you identify which workflow functionality is essential, which apps provide overlapping capabilities, and where potential issues may arise during migration:

-   **Compare workflows and functions:** Generate a comprehensive view of your workflows, including which functions are used in which workflows and which apps provide that functionality. This comparison reveals patterns in your workflow design and helps identify dependencies.
-   **Identify workflow function usage by app:** Analyze which apps provide the most and least used workflow functions. This helps you prioritize which apps are essential for migration and which can be replaced or removed.
-   **Detect app functionality overlap:** Identify apps that provide similar or overlapping workflow functionality. Consolidating to fewer apps can simplify your instance and reduce licensing costs when you move to Cloud.
-   **Find unused workflow apps:** Discover apps that are installed but not actively used in any workflows. Consider if you could remove these apps.
-   **Identify missing workflow apps:** The [Instance Audit](https://docs.adaptavist.com/sr4js/latest/features/built-in-scripts/instance-audit) feature can detect workflow functions that are missing their original associated apps. In the exported data, these functions are flagged as "missing plugin." Consider if you could remove these workflow functions.
-   **Document essential workflow functions:** Create a definitive list of must-have workflow functions based on your audit findings. This list becomes a critical reference during migration planning, ensuring that essential functionality is preserved or appropriately replaced in your target environment.

### ![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg) Audit your projects

Use our Instance Audit built-in script

Use the [Instance Audit](https://docs.adaptavist.com/sr4js/latest/features/built-in-scripts/instance-audit) feature to help you analyse your projects. This built-in script exports project data in CSV format, compatible with most spreadsheet applications. The exported data includes project names, categories, type, archived status, and number of issues. 

Project auditing helps you understand which projects are actively used, which can be archived, and which should be migrated:

-   **Assess project usage:** Identify the most and least used projects based on recent activity. This data provides insight about which projects should be retained, archived, or migrated.
-   **Identify unused projects:** Discover projects that have had no activity for extended periods. Consider if these projects could be archive before migration.
-   **Review archived projects:** Generate a list of already-archived projects. Determine whether these archived projects need to be migrated or can be left behind.
-   **Generate project lead consultation list:** Based on your audit findings, create a list of project leads. Focus on projects where usage patterns are unclear or where business value needs confirmation. This approach enables you to make stakeholder engagement more efficient and productive.

### ![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg) Audit your custom fields

Use our Instance Audit built-in script and Export Scripts feature

Use the [Instance Audit](https://docs.adaptavist.com/sr4js/latest/features/built-in-scripts/instance-audit) feature and the [Export Scripts](https://docs.adaptavist.com/sr4js/latest/features/script-registry#exporting-your-scripts) feature to help you analyse your custom fields:

-   The Instance Audit built-in script exports custom field data in CSV format, compatible with most spreadsheet applications. The exported data includes custom field names, type, and source.  
-   The Export Scripts feature exports all custom fields as a .json file which is located within a dedicated **Instance Information** folder.

Custom fields are a common source of migration complexity, particularly when they're created by apps that may not be available in your target environment. This audit helps you understand your custom field landscape and identify potential issues before migration.

-   **Analyze custom field types:** Identify the most common custom field types in your instance. Understanding this distribution helps you assess migration complexity and identify potential compatibility issues.
-   **Review custom field apps:** Identify which apps are most and least used for custom field creation. This analysis helps you understand dependencies and prioritize your apps.
-   **Map app-specific custom fields:** Generate a list of custom fields created by each app. As app-specific custom fields may require special handling or replacement when you migrate.
-   **Detect duplicate custom fields:** Identify custom fields that appear to be duplicates based on name, type, or usage patterns. Consider if you can consolidate duplicate fields before migration.

### ![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg) Audit your users

Use our Instance Audit built-in script

Use the [Instance Audit](https://docs.adaptavist.com/sr4js/latest/features/built-in-scripts/instance-audit) feature to help you analyse your users. This built-in script exports user data in CSV format, compatible with most spreadsheet applications. The exported data includes user names, email, directory, status, group name, number of logins, and login time. 

User auditing helps you understand the size and complexity of your user base while identifying opportunities to optimize licensing costs. Removing inactive users before migration can significantly reduce migration time and potentially allow for a smaller license tier in your target environment.

-   **Identify duplicate email addresses:** Find users whose email addresses are duplicated within your instance. Duplicate email addresses can cause significant migration issues and should be resolved before migration begins.
-   **Review user groups:** Generate a comprehensive list of user groups and their membership. Understanding group structure is essential for maintaining proper permissions after migration.
-   **Analyze directory distribution:** Identify which user directories contain the most users. This information is particularly important for instances with multiple user directories, as it helps you plan directory consolidation or migration strategies.
-   **Find inactive users:** Identify users who haven't accessed the application for an extended period. Consider if you can remove these users.
-   **Detect users who never logged in:** Find users who were created but never logged in. Consider if you can remove these users.
-   **Optimize license sizing:** Based on your user audit findings, determine if a smaller license tier is appropriate.

### ![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg) Audit your scripts

Use our Export Scripts feature

Use the [Export Scripts](https://docs.adaptavist.com/sr4js/latest/features/script-registry#exporting-your-scripts) feature to help you analyse your scripts. This feature enables you to export all ScriptRunner scripts, configurations, and custom fields (including native Jira custom fields) from your instance. This export facilitates a more comprehensive analysis of your ScriptRunner scripts, as you will have the flexibility to conduct thorough audits using external tools and repositories of your choice.

ScriptRunner scripts require careful review before migration. The complexity and compatibility of your scripts will impact your migration timeline. We provide a comprehensive guide on [Rewriting Scripts for Cloud](https://docs.adaptavist.com/sr4js/latest/scriptrunner-migration/migrating-to-cloud/rewriting-scripts-for-cloud-hints-and-tips) which includes detailed sections on understanding, preparing, and reviewing your scripts. Even if you're not migrating to Cloud, this guide offers valuable insights into script analysis and documentation.

When auditing your scripts, focus on identifying:

-   **Unused or disabled scripts**: Remove scripts that are currently disabled or no longer in use. Consider filtering out scripts that haven't been executed in several months or scripts associated with archived or inactive projects.
-   **Duplicated and similar scripts**: Consolidate scripts with duplicate or similar functionality to reduce redundancy and simplify your instance.
-   **External dependencies**: Identify scripts that rely on external applications, services, or other plugins, as these may require special attention during migration.

## Conclusion

This audit checklist allows you to prepare your instance for migration. By systematically auditing all aspects of your instance using ScriptRunner, you can identify and resolve issues before they become migration blockers. For additional support with your audit or migration planning, check out what our [Development Services](https://www.adaptavist.com/solutions/development-services) team have to offer, or [contact us](https://www.scriptrunnerhq.com/about/contact?__hstc=61790195.acc9ab94980e91817a98c863649ee11d.1741078989212.1760450678788.1760456448406.647&__hssc=61790195.1.1760456448406&__hsfp=3468463579).
