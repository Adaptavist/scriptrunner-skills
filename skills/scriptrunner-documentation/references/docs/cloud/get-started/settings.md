# Settings

- Platform: cloud
- Space: SR4JC
- Hierarchy: get-started
- Doc ID: doc-sr4jc-101629575
- Source: https://docs.adaptavist.com/sr4jc/latest/get-started/settings

This section helps you understand how to set up your ScriptRunner for Jira Cloud configurations. You can use the _Settings_ page to configure your preferences and save when complete.

Click the **Settings** button on the top right corner of your page, or from the _ScriptRunner_ menu, and the options shown below are displayed:

[![](/sr4jc/files/latest/101629575/524222948/1/1773942448000/image+%285%29.png)  
](https://adaptavist.slack.com/files/U075XLB80MA/F0AMKH8DA8M/image.png?origin_team=TC0TMAGBH&origin_channel=C09L2SASB0V)

## General

You can choose the time zone in which your script will execute by selecting your region from the _Scripts Time Zone_ drop-down list. This is the value used to set the [Java TimeZone](https://docs.oracle.com/javase/7/docs/api/java/util/TimeZone.html).

The default value is 'UTC'.

It is important to note that since the Java 8 release, you should avoid using the [Date class](https://docs.oracle.com/javase/8/docs/api/java/util/Date.html) and use the [Calendar](https://docs.oracle.com/javase/7/docs/api/java/util/Calendar.html), [Instant](https://docs.oracle.com/javase/8/docs/api/java/time/Instant.html), and [Zoned Time](https://docs.oracle.com/javase/8/docs/api/java/time/ZonedDateTime.html) classes.

You can find some useful examples [in this blog post](https://dzone.com/articles/deeper-look-java-8-date-and).

## Notifications

### Notifications group

If a script fails to execute successfully, you can send a group email to notify those concerned. For example, if a [Perform Actions](https://docs.adaptavist.com/sr4jc/latest/features/workflow-rules/perform-actions) or [Script Listener](https://docs.adaptavist.com/sr4jc/latest/features/script-listeners) associated with a work item-related event fails to run, an email is automatically sent to the designated notification group. 

To do so, select the relevant _Notifications Group_ from the drop-down list. The default value is the 'site-admins' group.

### Notify assignee and reporter

In addition to the group notification, you can activate the _Notify Assignee and Reporter_ option to send an email notification to the Assignee and Reporter of the failed script.

### Exclude groups

Within the notification settings, you can also use the _Exclude Groups_ setting to ensure the assignee or reporter of a failed script does _not_ receive an email notification of that work item. To do so, select the user group associated with the Assignee and Reporter from the drop-down list.

The default value is 'no groups'.

### Work item polling notifications

Enabling _Work Item Polling Notifications_ means you are notified of changes made asynchronously by [Perform Actions](https://docs.adaptavist.com/display/SR4JC/Post+Functions) and [Script Listeners](https://docs.adaptavist.com/sr4jc/latest/features/script-listeners) for work items you have viewed. 

ScriptRunner checks for updates on the work items made by any other users for a short period of time and displays a notification message when updates occur.

## Enhanced Search feature

You can enable the use of the [ScriptRunner Enhanced Search](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search) feature by activating this option. This provides you with search capabilities in Jira Cloud using advanced [JQL functions](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-functions) that are not available by default in Jira Cloud.

Using ScriptRunner JQL functions removes the need to learn the Atlassian SDK and provides you with a simple method for writing your own JQL functions.

### Filter sync interval period

When the [Enhanced Search](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search) feature has been turned on, this setting checks every 'X' minutes for changes in your Jira work items or if another user has recently changed the ScriptRunner add-on settings. If changes have occurred, then filters are synced with the changes made to the work items in your Jira instance. Filters are always run with the same set of permissions as the user who created the filter.

You can select the _Filter Sync Interval Period_ from the options available in the drop-down list to specify how often ScriptRunner synchronizes your filters. The maximum interval period allowed is one hour. However, the default interval of five minutes is recommended.

You should adjust the default interval period if you notice that filter synchronizing makes too many requests to your Jira instance and causes a performance problem. You can refer to our [filter sync performance documentation](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/troubleshoot-scriptrunner-enhanced-search#filter-sync-performance-) for further information.

## ScriptRunner AI

Your ScriptRunner for Jira Cloud organization's administrator can enable the [Behaviours Bot](https://docs.adaptavist.com/sr4jc/latest/features/behaviours/behaviours-bot) for your instance. This feature is turned off by default. 

The Bot is an AI-powered script generation assistant built into ScriptRunner for Jira Cloud. It converts natural, everyday language instructions into ready-to-use Behaviours scripts. You can utlize the functionality of the Behaviours Bot to create new Behaviours scripts, or modify, refine, and improve existing ones.

Admin issues for the Behaviours Bot

In order to access and activate the Behaviours Bot setting, you must belong to the org-admins or site-admins groups.

  

* * *

## Related content:

-   Take our **[ScriptRunner Tour](https://www.scriptrunnerhq.com/atlassian-apps/jira/scriptrunner-for-jira/cloud/get-started)** to help you get started and gain access to helpful videos and demos.
-   [Book a demo](https://www.scriptrunnerhq.com/book-a-demo) with one of our Customer Success Managers.
