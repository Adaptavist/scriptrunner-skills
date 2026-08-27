# Supported Features and Limitations

- Platform: migration-suite
- Space: SMS
- Hierarchy: scriptrunner-dev-and-deployment-tool
- Doc ID: doc-sms-448135920
- Source: https://docs.adaptavist.com/sms/latest/scriptrunner-dev-and-deployment-tool/supported-features-and-limitations

## Supported features

This tool is a work in progress and does not yet work for all features. Review the following table for more information: 

Feature

Support

Is support for this feature planned?

Notes/Details

Built-in Scripts

\-

\-

There is nothing to configure in Cloud.

"Built-in Script" here refers to the Built-In Script feature of ScriptRunner (_General Configuration_ > _ScriptRunner_ > _Built-in Scripts_). Other features, such as Listeners, Workflows, and Jobs, have built-ins that come with ScriptRunner (like the [Create a Sub-task](https://docs.adaptavist.com/sr4js/latest/features/listeners/built-in-listeners/create-a-sub-task) built-in listener) that are supported by this tool and exported by Script Export.

Listeners

 ![check mark](/plugins/servlet/twitterEmojiRedirector?id=2714 "check mark") 

\-

  

Behaviours

![check mark](/plugins/servlet/twitterEmojiRedirector?id=2714 "check mark")

\-

Two Behaviours cannot have the same name.

Script Fields

![check mark](/plugins/servlet/twitterEmojiRedirector?id=2714 "check mark")   

\-

  

Workflows

![check mark](/plugins/servlet/twitterEmojiRedirector?id=2714 "check mark")

 -  

  

REST Endpoints

![cross mark](/plugins/servlet/twitterEmojiRedirector?id=274c "cross mark")

![cross mark](/plugins/servlet/twitterEmojiRedirector?id=274c "cross mark")

This feature is not currently available in ScriptRunner for Jira Cloud. Jira Cloud does not offer custom endpoints. Our recommendation is to use [ScriptRunner Connect](https://www.scriptrunnerhq.com/atlassian-apps/jira/scriptrunner-connect) to fill this gap.

UI Fragments

![cross mark](/plugins/servlet/twitterEmojiRedirector?id=274c "cross mark")

![check mark](/plugins/servlet/twitterEmojiRedirector?id=2714 "check mark") 

Only Web Panels are supported in Cloud, with certain restrictions.

Jobs

![check mark](/plugins/servlet/twitterEmojiRedirector?id=2714 "check mark") 

\-

[Escalation Services](https://docs.adaptavist.com/sr4jc/latest/features/escalation-service) are supported by the tool and grouped under jobs.

JQL Functions

![cross mark](/plugins/servlet/twitterEmojiRedirector?id=274c "cross mark")

![check mark](/plugins/servlet/twitterEmojiRedirector?id=2714 "check mark") 

Writing your own [custom JQL functions](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/custom-jql-functions) in Groovy is not supported in ScriptRunner Cloud. Most of the JQL functions provided by ScriptRunner are available in [ScriptRunner's Enhanced Search](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search) feature (available as a standalone app).

Resources

![cross mark](/plugins/servlet/twitterEmojiRedirector?id=274c "cross mark")

![cross mark](/plugins/servlet/twitterEmojiRedirector?id=274c "cross mark")

This feature is unavailable in ScriptRunner for Jira Cloud, so no configuration is needed.

Some Resources have script alternatives that can be executed in the Script Console in ScriptRunner for Jira Cloud.

Script Manager

![check mark](/plugins/servlet/twitterEmojiRedirector?id=2714 "check mark") 

\-

  

Mail Handler

![cross mark](/plugins/servlet/twitterEmojiRedirector?id=274c "cross mark") 

![cross mark](/plugins/servlet/twitterEmojiRedirector?id=274c "cross mark")

This feature is unavailable in ScriptRunner for Jira Cloud, so no configuration is needed.

We hope to support more features in the future. Check this page and the [changelog](https://docs.adaptavist.com/sms/latest/scriptrunner-migration-suite-changelog) for updates.

## Limitations 

While this tool can do a lot, there are limitations. The Dev and Deployment Tool does not:

-   Automate script rewriting (handled by [ScriptRunner Migration Agent](https://docs.adaptavist.com/sms/latest/scriptrunner-migration-suite-web-app/scriptrunner-migration-agent)).
    
-   Have a visual interface for script development (focus is on CLI/IDE-based workflows).
    
-   Perform end-to-end migration automation.
    

### Rate limits

Atlassian and Adaptavist APIs have rate limits. Rate limiting is most noticeable during workflow deployments, particularly for customers with many workflows. At scale, these deployments may run into Atlassian’s rate limits. See Atlassian's [Rate limiting](https://developer.atlassian.com/cloud/jira/platform/rate-limiting/) documentation for more details.

We are actively working on more comprehensive handling of rate limits within this tool.
