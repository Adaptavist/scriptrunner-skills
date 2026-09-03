# Settings

- Platform: confluence-cloud
- Space: SR4CC
- Hierarchy: get-started
- Doc ID: doc-sr4cc-112138409
- Source: https://docs.adaptavist.com/sr4cc/latest/get-started/settings

This page allows you to configure your settings for the ScriptRunner for Confluence Cloud app.

## Settings section

### Notifications Group

Select a group that will receive email notifications when a script (for example, a listener) fails to execute successfully. The default value is the _site-admins group_.

### Scripts Time Zone

You can set the timezone in which your scripts execute here. This is the value used to set the [Java TimeZone](https://docs.oracle.com/javase/7/docs/api/java/util/TimeZone.html). The default value is _UTC_.

Since the Java 8 release, you should avoid using the [Date class](https://docs.oracle.com/javase/8/docs/api/java/util/Date.html). Use the [Calendar](https://docs.oracle.com/javase/7/docs/api/java/util/Calendar.html), [Instant](https://docs.oracle.com/javase/8/docs/api/java/time/Instant.html), or [Zoned Time](https://docs.oracle.com/javase/8/docs/api/java/time/ZonedDateTime.html) classes instead.

You can find some useful examples [in this blog post](https://dzone.com/articles/deeper-look-java-8-date-and).

## Built-in Scripts Space Admin Permission section

Confluence administrators have control of a space admin’s use of the features in Advanced Space Functionality_,_ and they can revoke permissions for specific groups of users and spaces. It is also possible to disable space admin built-in scripts for the entire Confluence instance. By default, all space admins have access to Advanced Space Functionality.

To find out more about assigning space admin permissions, take a look at Atlassian’s [documentation](https://confluence.atlassian.com/confcloud/assign-space-permissions-724764762.html).

Add the name of the **Groups** or **Spaces** that you want to disable the Advanced Space Functionality for. Or, to disable Advanced Space Functionality in all spaces, tick the box. 

## Other Settings

### Store Scripts in ScriptRunner Cloud Storage

As described in the [Limitations](https://docs.adaptavist.com/sr4cc/latest/get-started/general-information/limitations), the maximum amount of code that can be stored in each of the three features Script Listeners, CQL Script Jobs, and Script Jobs is 32KB as they are stored within Confluence.

We have an alternative solution which does not impose a limit on the amount of code you can store. However, your scripts will be stored externally from your Confluence instance in ScriptRunner Cloud Storage, and will no longer be part of any Confluence exports (so your scripts cannot be automatically migrated between Confluence instances). Additionally, it is not possible to migrate your scripts back into Confluence’s storage.

If you require more storage, feel free to create a [support request](https://the-adaptavist-group-support.atlassian.net/servicedesk/customer/portal/18).
