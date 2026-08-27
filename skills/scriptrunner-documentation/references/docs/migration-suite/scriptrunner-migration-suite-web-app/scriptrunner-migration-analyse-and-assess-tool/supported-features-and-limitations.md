# Supported Features and Limitations

- Platform: migration-suite
- Space: SMS
- Hierarchy: scriptrunner-migration-suite-web-app > scriptrunner-migration-analyse-and-assess-tool
- Doc ID: doc-sms-448135867
- Source: https://docs.adaptavist.com/sms/latest/scriptrunner-migration-suite-web-app/scriptrunner-migration-analyse-and-assess-tool/supported-features-and-limitations

## Supported features

This tool is a work in progress and does not yet analyse all folders within a script export. Review the following table for more information: 

Feature

Support

Is support for this feature planned?

Notes/Details

Behaviours

![check mark](/plugins/servlet/twitterEmojiRedirector?id=2714 "check mark")

\-  

Only [exports from the Script Registry in ScriptRunner for Jira](https://docs.adaptavist.com/sr4js/latest/features/script-registry#exporting-your-scripts) are supported.

The analysis scans the [Behaviours configurations](https://docs.adaptavist.com/sr4js/latest/features/behaviours/behaviours-tutorial) from ScriptRunner for Jira Data Center to detect if field types are [supported by ScriptRunner for Jira Cloud](https://docs.adaptavist.com/sr4jc/latest/features/behaviours/behaviours-supported-fields-and-products). 

Conditions

Most Behaviours conditions can be used in Cloud when used with a code snippet that the tool provides: 

-   `Current user is issue reporter:` ![check mark button](/plugins/servlet/twitterEmojiRedirector?id=2705 "check mark button") Supported with simple snippet
-   `Current user in group`: ![check mark button](/plugins/servlet/twitterEmojiRedirector?id=2705 "check mark button") Supported with simple snippet
-   `Current user is given user:` ![check mark button](/plugins/servlet/twitterEmojiRedirector?id=2705 "check mark button") Supported with additional guidance to convert the DC `user id` to cloud
-   `User in project role`: ![check mark button](/plugins/servlet/twitterEmojiRedirector?id=2705 "check mark button") Supported with simple snippet
-   `Current user is project lead`: ![check mark button](/plugins/servlet/twitterEmojiRedirector?id=2705 "check mark button") Supported with simple snippet
-   `Current user is current assignee`: ![check mark button](/plugins/servlet/twitterEmojiRedirector?id=2705 "check mark button") Supported with simple snippet
-   `Current user is value of user field`: ![check mark button](/plugins/servlet/twitterEmojiRedirector?id=2705 "check mark button") Supported with simple snippet
-   `Workflow Action`: ![check mark button](/plugins/servlet/twitterEmojiRedirector?id=2705 "check mark button") Supported with additional guidance to find `workflow transition ids`
-   `Workflow Step`:  ![large orange diamond](/plugins/servlet/twitterEmojiRedirector?id=1f536 "large orange diamond")  Not Supported, but there is a workaround. Since the `status` is not supported in the _Transition View_, we added guidance to convert this condition to a `Workflow Action` condition instead.
-   `Current user member of group custom field value`: ![cross mark](/plugins/servlet/twitterEmojiRedirector?id=274c "cross mark") Not supported because `Group Picker` is not available for conditions

Built-in Scripts

\-

\-

There is nothing to configure in Cloud.

Built-in scripts usage data is not exported by the Script Export.

"Built-in Script" here refers to the Built-In Script feature of ScriptRunner (_General Configuration_ > _ScriptRunner_ > _Built-in Scripts_). Other features, such as Listeners, Workflows, and Jobs, have built-ins that come with ScriptRunner (like the [Create a Sub-task](https://docs.adaptavist.com/sr4js/latest/features/listeners/built-in-listeners/create-a-sub-task) built-in listener) that are supported by this tool and exported by Script Export.

Jobs

![check mark](/plugins/servlet/twitterEmojiRedirector?id=2714 "check mark") 

\-

  

JQL Functions

![cross mark](/plugins/servlet/twitterEmojiRedirector?id=274c "cross mark")

 ![question mark](/plugins/servlet/twitterEmojiRedirector?id=2753 "question mark")

JQL function usage data is not exported by Script Export.  
  
This feature might be supported if JQL function usage is supported by a future version of Script Export.

Listeners

![check mark](/plugins/servlet/twitterEmojiRedirector?id=2714 "check mark") 

\-

  

Mail Handler

![cross mark](/plugins/servlet/twitterEmojiRedirector?id=274c "cross mark")

**![cross mark](/plugins/servlet/twitterEmojiRedirector?id=274c "cross mark")**

This feature is unavailable in ScriptRunner for Jira Cloud, so no configuration is needed.

Resources

![cross mark](/plugins/servlet/twitterEmojiRedirector?id=274c "cross mark")

![cross mark](/plugins/servlet/twitterEmojiRedirector?id=274c "cross mark")

This feature is unavailable in ScriptRunner for Jira Cloud, so no configuration is needed.

Some Resources have script alternatives that can be executed in the Script Console in ScriptRunner for Jira Cloud.

REST Endpoints

![cross mark](/plugins/servlet/twitterEmojiRedirector?id=274c "cross mark")

\-

This feature is not currently available in ScriptRunner for Jira Cloud. Jira Cloud does not offer custom endpoints. Our recommendation is to use [ScriptRunner Connect](https://www.scriptrunnerhq.com/atlassian-apps/jira/scriptrunner-connect) to fill this gap.

Script Fields

![check mark](/plugins/servlet/twitterEmojiRedirector?id=2714 "check mark")

\- 

Script Field values are calculated when you view or edit an issue in Cloud, so the values are not automatically migrated from Data Center to Jira Cloud by the Jira Cloud Migration Assistant. After using ScriptRunner Migration Suite to convert your Script Field scripts, paste the code directly into ScriptRunner Cloud or use the [ScriptRunner Dev and Deployment Tool](https://docs.adaptavist.com/sms/latest/scriptrunner-dev-and-deployment-tool) to automate deployment.

When a Script Field is configured in Cloud, values do not exist because the value is only generated when an issue is viewed or edited. JQL searches against Script Field values may give incomplete or inconsistent results until all issues have had their value calculated. Currently, ScriptRunner Cloud doesn’t have a built-in way to sync Script Field values after a migration. Manually viewing or editing affected issues may be sufficient for smaller datasets, while custom scripts can be used for a more automated approach.

If you need help, please [contact support](https://the-adaptavist-group-support.atlassian.net/servicedesk/customer/portal/1069/user/login?destination=portal%2F1069).

Script Manager

![check mark](/plugins/servlet/twitterEmojiRedirector?id=2714 "check mark") 

\-

File scripts that are used in a feature, or imported by a feature, will be analysed and stored in the Script Manager in Scriptrunner for Jira Cloud. Scripts that are standalone (e.g. meant to be used run from the Script Console) and not used in a feature, are not analysed.

UI Fragments

![check mark](/plugins/servlet/twitterEmojiRedirector?id=2714 "check mark") 

\-

Only Web Panels are supported in Cloud, with certain restrictions.

Workflows

  ![check mark](/plugins/servlet/twitterEmojiRedirector?id=2714 "check mark")

\-

Workflow Post Functions are supported for [exports from the Script Registry in ScriptRunner for Jira](https://docs.adaptavist.com/sr4js/latest/features/script-registry#exporting-your-scripts%27). 

We hope to support more features in the future. Check this page and the [changelog](https://docs.adaptavist.com/sms/latest/scriptrunner-migration-suite-changelog) for updates.

## Limitations

While this tool can do a lot, there are limitations. The assess and analyse tool does not:

-   **Migrate or rewrite scripts** (you can use the [Dev and Deployment Tool](https://docs.adaptavist.com/sms/latest/scriptrunner-dev-and-deployment-tool) and [Migration Agent](https://docs.adaptavist.com/sms/latest/scriptrunner-migration-suite-web-app/scriptrunner-migration-agent) for this).
    
-   **Embed** the analysis directly into ScriptRunner products.
    
-   **Generate a migration quote**. Human interaction is required to gather inputs and create a proposal for customers.
    

### Cloud parity and limitations

ScriptRunner for Jira Cloud has a different feature set compared to the Data Center version, with some features working differently or having limitations in Cloud. Differences include:

-   **UI Fragments**: Only Web Panels are supported, with certain restrictions.
    
-   **Behaviours**: Available but with limitations; many common use cases are still implementable.
    
-   **Workflow conditions and validators**: The Jira Expression Framework is used instead of REST API.
    

See the [Feature Parity and Script Alternatives](https://docs.adaptavist.com/sr4js/latest/scriptrunner-migration/migrating-to-cloud/feature-parity-and-script-alternatives "https://docs.adaptavist.com/sr4js/latest/scriptrunner-migration/migrating-to-cloud/feature-parity-and-script-alternatives") documentation for more details.

The [Assess and Analyse tool](https://migrationpilot.scriptrunnerhq.com/analyse) accounts for these differences and provides alternatives where they are available.
