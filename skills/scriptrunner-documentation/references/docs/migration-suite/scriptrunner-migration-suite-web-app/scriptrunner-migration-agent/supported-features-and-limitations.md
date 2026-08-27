# Supported Features and Limitations

- Platform: migration-suite
- Space: SMS
- Hierarchy: scriptrunner-migration-suite-web-app > scriptrunner-migration-agent
- Doc ID: doc-sms-448135898
- Source: https://docs.adaptavist.com/sms/latest/scriptrunner-migration-suite-web-app/scriptrunner-migration-agent/supported-features-and-limitations

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

  

Script Fields

![check mark](/plugins/servlet/twitterEmojiRedirector?id=2714 "check mark")  

\-

  

Workflows

![check mark](/plugins/servlet/twitterEmojiRedirector?id=2714 "check mark") 

\-

  

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

  

JQL Functions

![cross mark](/plugins/servlet/twitterEmojiRedirector?id=274c "cross mark")

![check mark](/plugins/servlet/twitterEmojiRedirector?id=2714 "check mark")

  

Resources

![cross mark](/plugins/servlet/twitterEmojiRedirector?id=274c "cross mark") 

![cross mark](/plugins/servlet/twitterEmojiRedirector?id=274c "cross mark") 

This feature is unavailable in ScriptRunner for Jira Cloud, so no configuration is needed.

Some Resources have script alternatives that can be executed in the Script Console in ScriptRunner for Jira Cloud.

Mail Handler

![cross mark](/plugins/servlet/twitterEmojiRedirector?id=274c "cross mark") 

![cross mark](/plugins/servlet/twitterEmojiRedirector?id=274c "cross mark") 

This feature is unavailable in ScriptRunner for Jira Cloud, so no configuration is needed.

We hope to support more features in the future. Check this page and the [changelog](https://docs.adaptavist.com/sms/latest/scriptrunner-migration-suite-changelog) for updates.

## Limitations

While the Migration Agent can do a lot, there are limitations. The Migration Agent does not:

-   Perform bulk conversions. We aim to have this option available in a future version.
    
-   Read from local files and repositories.
    
-   Connect to a Jira instance to test code.
