# Release 5.x

- Platform: confluence-data-center
- Space: SR4C
- Hierarchy: Release Notes
- Doc ID: doc-sr4c-7ff4d1af-8fcc-4747-9d11-2cac1de1603c-12ffffaa9bc524ad
- Source: https://docs.adaptavist.com/sr4c/latest/release-notes/release-5.x

Feature release information about our 5.x versions.

Check out what's new for ScriptRunner for Confluence Server.

## 5.9.1

### Bug Fixes

-   This release resolved a low severity security issue which was discovered internally.

## 5.9.0

-   Released 16 April 2020
-   Behind the scenes, the deprecation information behind the [code editor](https://docs.adaptavist.com/sr4c/latest/best-practices-and-app-management/code-editor) has been improved

New Features

-   SRPLAT-1022 - There is now an Exit button for the _Switch User_ built-in script
    

Bug Fixes

-   SRPLAT-1055 - Script editor did not enable vertical scroll when too many lines were added
    
-   SRCONF-1163 - The _Copy Space_ script was updated to keep inline comments when copied
    
-   SRCONF-1077 - Show Suggested Label on the _Label_ dialog box for _Choose Label_ threw an error
    

## 5.8.0

-   Released 31 March 2020

### Bug Fixes

-   SRCONF-1148 - The _Copy Page Tree_ script was updated to keep inline comments when copied
-   SRPLAT-931 - The code editor did not show method deprecation warnings for SAL

## 5.7.2

### Bug Fixes

-   SRPLAT-999 - Script Editor - deprecations of inner classes are now correctly shown
-   SRCONF-1053 - The CQL Search macro did not display more than 201 rows within the table
-   SRPLAT-931 - The code editor did not show method deprecation warnings for SAL

## 5.7.1

-   Released 12 March 2020

### Bug Fixes

-   SRPLAT-962 - Cron descriptions now display the correct weekday
-   SRCONF-1101 - The _Browse_ tab new feature indicator did not work properly
-   SRCONF-1028 - The Event listeners Note field did not appear
-   SRCONF-1160 - The Projects field was removed from the listener description
-   SRCONF-1106 - The code editor was not showing method deprecation warnings for the Confluence API

## 5.7.0

-   Released 28 Feb 2020

### Bug Fixes

-   SRPLAT-948 - Conditions on Web Fragments created prior to release 5.6.15 are now visible
-   SRCONF-1150 - The Delete Page Tree built-in script was missing on Advanced Space Functionality
-   SRCONF-1130 - Bulk Purge Trash on Advanced Space Functionality > Built-In Scripts produced an error
-   SRCONF-1129 - Copy Space on Advanced Space Functionality > Built-In Scripts produced an error
-   SRCONF-1100 - Resources did not appear in the Browse tab list
-   SRCONF-1099 - An error was produced when CopySpace was ran from Space Administration
-   SRCONF-682 - CSS files were not found in the Scripts Root folder

## 5.6.16

-   Released 18 Feb 2020

Updates

Critical Security Vulnerabilities Fixed

This release fixes critical security vulnerabilities around the Space Admin Built-In scripts for ScriptRunner for Confluence. See SRCONF-1097 for details about the vulnerability.

Temporary Workaround

If you are unable to upgrade immediately, blocking HTTP requests beginning with `<base_url>/rest/scriptrunner-confluence/*/space_admin/` mitigates the vulnerability.

Tip: To verify the workaround is applied correctly check that requests to `<base_url>/rest/scriptrunner-confluence/*/space_admin/` are denied.

Below are examples of how to apply the workaround in Apache and Tomcat by blocking requests to the ScriptRunner Remote Events endpoint at the reverse proxy, load-balancer or application server level.

Note: Please note that Adaptavist Support does not provide any assistance for configuring reverse proxies. Consequently, we provide the below examples as is, with no support and no written or implied warranties. To verify the workaround is applied correctly check that requests to <base\_url>/rest/scriptrunner-confluence/\*/space\_admin/ are denied.

Apache HTTPD Reverse Proxy

Apache 2.4 Syntax

Add the following into the `.conf` file containing the virtualhost that proxies to the Atlassian application.

```
<LocationMatch "/rest/scriptrunner-confluence/.*/space_admin/.*">
Require all denied
</LocationMatch>
```

Example:

```
<VirtualHost *:80>
ServerName confluence.example.com

    ProxyRequests Off
    ProxyVia Off
    <Proxy *>
         Require all granted
    </Proxy>
    ProxyPass /confluence  http://ipaddress:8080/confluence
    ProxyPassReverse /confluence  http://ipaddress:8080/confluence

    <LocationMatch "/rest/scriptrunner-confluence/.*/space_admin/.*">
        Require all denied
    </LocationMatch>
</VirtualHost>
```

Apache 2.2 Syntax

Add the following into the `.conf` file containing the virtualhost that proxies to the Atlassian application:

```
<LocationMatch "/rest/scriptrunner-confluence/.*/space_admin/.*">
Order Allow,Deny
Deny from  all
</LocationMatch>
```

Example:

```
<VirtualHost *:80>
ServerName confluence.example.com
    ProxyRequests Off
    ProxyVia Off
    <Proxy *>
         Require all granted
    </Proxy>
    ProxyPass /confluence  http://ipaddress:8080/confluence
    ProxyPassReverse /confluence  http://ipaddress:8080/confluence
    <LocationMatch "/rest/scriptrunner-confluence/.*/space_admin/.*">
         Order Allow,Deny
         Deny from  all
    </LocationMatch>
</VirtualHost>
```

Tomcat urlrewrite.xml

Redirect requests to `/rest/scriptrunner-confluence/.*/space_admin/.*` to a safe URL.

1.  Add the following to the `<urlrewrite>` section of `[confluence-installation-directory]/atlassian-confluence/WEB-INF/urlrewrite.xml`:

```
<rule>
<from>/rest/scriptrunner-confluence/.*/space_admin/.*</from>
<to type="temporary-redirect">/</to>
</rule>
```

2\. Save the `urlrewrite.xml`.

3\. Restart the Atlassian application.Known Issues

-   SPLAT-948 - Conditions on Script Fragments will be hidden from the UI
    

Bug Fixes

-   SRCONF-1094 - Error when running Bulk Delete Attachments script as Space Admin
    
-   SRCONF-1093 - Error when running Bulk Delete Comments script as Space Admin
    
-   SRCONF-1092 - Error when running Bulk Add/Remove Labels on One or More Pages script as Space Admin
    
-   SRCONF-1084 - Error when running Space Statistics as space admin
    

## 5.6.15

-   Released 11 Feb 2020

### Bug Fixes

-   SRPLAT-912 - Script Editor has been fixed
-   SRPLAT-566 - Browse Page now maintains search input focus
-   SRCONF-1026 - Space Statistics failed when the Space Key value was _In_

## 5.6.14

-   Released 27 Jan 2020

### Bug Fixes

-   SRPLAT-908 - A bug that prevented editing of previously configured script files has been fixed
-   SRCONF-1069 - A bug that prevented the _Bulk Delete Attachments_ built-in script from respecting the minimum age has been fixed

## 5.6.13

-   Released 22 Jan 2020

Updates

IntelliJ IDEA Plugin Deprecation

We are officially deprecating the IntelliJ IDEA plugin, also known as the _Adaptavist Power Editor_. ScriptRunner 5.6.13 contains the last bugfix we will ship for this feature, and 0.7.20 is the last release we will make on the JetBrains marketplace. Future support requests for this feature will be referred to this deprecation notice.

As can be seen from the review history on [our JetBrains marketplace listing](https://plugins.jetbrains.com/plugin/9751-adaptavist-scriptrunner-power-editor), we haven't been consistently keeping up with JetBrains's quarterly release schedule, due to prioritization constraints.

Reasons for the Change

Two key concerns motivated our decision to deprecate: the opportunity cost of developing the _Adaptavist Power Editor_ and its overlap with other ScriptRunner features.

The IntelliJ IDEA platform is a rich, fast-moving one. Just about every release requires refactoring some part of our plugin's codebase. As users of IntelliJ IDEA, we love this rapid development. However, it is a challenge to keep up with developing a secondary plugin that is not our core product, while also keeping an eye on the Atlassian release cycle. While IntelliJ IDEA was an interesting platform to expand into, it required more focus than we were able to give it.

Further, we are continuing to maintain and develop two other features which meet most of the needs met by the IntelliJ Plugin. These are the _[Code Editor](https://docs.adaptavist.com/sr4c/latest/best-practices-and-app-management/code-editor)_ and [the `scriptrunner-samples` repository for local development](https://docs.adaptavist.com/sr4c/latest/best-practices-and-app-management/script-plugins).

The _Code Editor_ provides smart completions, parameter hints, and javadoc lookup. While that's nowhere near the feature set provided by IntelliJ IDEA, it does provide a rich development experience, one which we'd like to develop further. Most importantly, the _Code Editor_ is up and running by default with no setup.

For users who want a deeper development experience and don't mind some setup, developing a _Script Plugin_ affords a fully featured IDE, git integration, the ability to save script configuration as code, and other developer tools.

With the addition of the _Code Editor_ (with built-in autocompletion), and the new _Script Editor_ (allowing users to save files in script roots), the _Adaptavist Power Editor_ had a very niche user base with a very high maintenance burden. Although we had reservations about deprecating the IntelliJ IDEA integration due to feature loss in the short term, increased investment in the core ScriptRunner product is our priority.

Continuing to let the _Adaptavist Power Editor_ lag with late compatibility updates wasn't fair to our users, and we are committed to delivering more new features and improvements to the ScriptRunner product itself.

Ultimately, creating a plugin for IntelliJ IDEA was a valuable experiment. It taught us important lessons about providing a rich code editor that we still want to incorporate into the core _Code Editor_. We would love to hear from you which aspects you found most valuable. Please contact us through our support portal if there are features you would like to request for the _Code Editor_.

We are Dropping Support for Custom Macro Variables

As of this release, we will no longer be supporting or advertising the ability to extend our internal macro classes. Given that our macros weren't initially designed as an external API with extendability in mind, we've decided that it would be irresponsible to continue promoting them as such. That being said, we _will not_ be removing the ability to extend them entirely. It will absolutely still be possible to extend our built-in macros and make custom configurations with them.

To demonstrate, as of now, you can use the following steps to specify your own variables using the _Create Page_ macro:

1.  Navigate to your script root.
    
    The default is <Confluence>/home/scripts. Select [Script Roots](https://docs.adaptavist.com/sr4c/latest/best-practices-and-app-management/script-roots) for more information.
    
2.  Create the package `com.onresolve.scriptrunner.canned.confluence.macros` in your script root.
    
3.  Navigate to the package you just created and create a new groovy class `CreatePageMacroModified.groovy` inside the macros folder.
    
    This extends the old class and overrides the `setCustomVariables()` method. Using a descriptive class name is recommended.
    
4.  Populate the class:
    
    ```
    package com.onresolve.scriptrunner.canned.confluence.macros
    
    import .../**
     * Overrides custom variables in the Create Page Macro to specify new variable behaviour
     */
    class CreatePageMacroModified extends CreatePageMacro {
    
        @Inject
        CreatePageMacroModified(
            PageManager pageManager, SpaceManager spaceManager, PageTemplateManager pageTemplateManager, SettingsManager settingsManager, ContentPropertyManager contentPropertyManager) {
            super(ComponentLocator.getComponent(I18NBeanFactory), pageManager, spaceManager, pageTemplateManager, ComponentLocator.getComponent(PermissionManager), ComponentLocator.getComponent(SubRenderer), settingsManager, contentPropertyManager)
        }
    
        @Override
        protected Map<String, String> setCustomVariables() {
            Map<String, String> customVariables = new HashMap<>()
            customVariables.put("\$myVariable", "This is my custom variable")
            customVariables.put("\$epoch", String.valueOf(Instant.now().toEpochMilli()))
    
            return customVariables
        }
    }
    ```
    

Warning: It's important to note that the constructors for each of our built-in macros are subject to change without notice. There is no guarantee that this code will work in the future in the event that we decide to make changes to these classes.

5\. Disable the old macro in the _Script Macros_ section in _Confluence Administration_.

6\. Finally, enable the new macro in the _Script Macros_ section in _Confluence Administration_.

Bug Fixes

-   SRPLAT-830 - IntelliJ Integration that was broken in 5.6.6 and beyond, is now fixed
    
-   SRCONF-1016 - Macro Overrides had incorrect constructors
    
-   SRCONF-1068 - The _Script fragments_ page has been updated with _Browse_ functionality
    
-   SRCONF-1056 - The _Jobs_ page has been updated with _Browse_ functionality
    

## 5.6.12

-   Released 22 Jan 2020

Updates

ScriptRunner Remote Events Code Execution Vulnerability

An HTTP POST made to `/rest/scriptrunner/latest/remote-events` with a specially crafted JSON payload could lead to unrestricted Groovy code execution for any logged-in user, regardless of permissions.

This security vulnerability has been fixed in ScriptRunner 5.6.12; it is recommended all customers upgrade to 5.6.12+ where possible.

If no firewall is enabled, users must update ScriptRunner to include this security patch.

Temporary Workaround

If you are unable to upgrade immediately, blocking HTTP requests beginning with `<base_url>rest/scriptrunner/*/remote-events` mitigates the vulnerability.

Tip: To verify the workaround is applied correctly check that requests to <base\_url>rest/scriptrunner/\*/remote-events/ are denied.

Below are examples of how to apply the workaround in Apache and Tomcat by blocking requests to the ScriptRunner Remote Events endpoint at the reverse proxy, load-balancer or application server level.

Note: Please note that Adaptavist Support does not provide any assistance for configuring reverse proxies. Consequently, we provide the below examples as is, with no support and no written or implied warranties. To verify the workaround is applied correctly check that requests to <base\_url>rest/scriptrunner/\*/remote-events/ are denied.

Apache HTTPD Reverse Proxy

Apache 2.4 Syntax

Add the following into the `.conf` file containing the virtualhost that proxies to the Atlassian application.

```
<LocationMatch "/rest/scriptrunner/.*/remote-events/">
Require all denied
</LocationMatch>
Example:
<VirtualHost *:80>
ServerName jira.example.com
```

```
ProxyRequests Off
ProxyVia Off
<Proxy *>
     Require all granted
</Proxy>
ProxyPass /jira  http://ipaddress:8080/jira
ProxyPassReverse /jira  http://ipaddress:8080/jira
```

```
    <LocationMatch "/rest/scriptrunner/.*/remote-events/">
        Require all denied
    </LocationMatch>
</VirtualHost>
```

Apache 2.2 Syntax

Add the following into the `.conf` file containing the virtualhost that proxies to the Atlassian application:

```
<LocationMatch "/rest/scriptrunner/.*/remote-events/">
Order Allow,Deny
Deny from  all
</LocationMatch>
Example
<VirtualHost *:80>
ServerName jira.example.com
    ProxyRequests Off
    ProxyVia Off
    <Proxy *>
         Require all granted
    </Proxy>
    ProxyPass /jira  http://ipaddress:8080/jira
    ProxyPassReverse /jira  http://ipaddress:8080/jira
    <LocationMatch "/rest/scriptrunner/.*/remote-events/">
         Order Allow,Deny
         Deny from  all
    </LocationMatch>
</VirtualHost>
```

Tomcat urlrewrite.xml

Redirect requests to `/rest/scriptrunner/.*/remote-events/.*` to a safe URL.

1.  Add the following to the `<urlrewrite>` section of `[jira-installation-directory]/atlassian-jira/WEB-INF/urlrewrite.xml`:
    
    ```
    <rule>
    <from>/rest/scriptrunner/.*/remote-events/.*</from>
    <to type="temporary-redirect">/</to>
    </rule>
    ```
    
2.  Save the `urlrewrite.xml`.
    
3.  Restart the Atlassian application.
    

## 5.6.11

-   Released 09 Jan 2020

New Features

Folder Support in Script Editor

You can now use the _Context_ menu to create new folders in the script root directory.

Script Editor also supports the creation of nested folders, just separate them using the `/` character.

Folders (and files) can be moved around the file tree using drag-and-drop.

Deletion Support in Script Editor

You can now remove files and folders directly from the Script Editor UI. Just right-click on the file or folder you want to remove and select Delete from the Context menu.

Renaming Support in Script Editor

You can now rename files and folders using the context menu option Rename, which is available on each node in Script Editor.

Execution History

[Execution History](https://docs.adaptavist.com/sr4c/latest/best-practices-and-app-management/execution-history) was added to [Custom Search Fields](https://docs.adaptavist.com/sr4c/latest/features/custom-search-fields) and [Custom CQL Functions](https://docs.adaptavist.com/sr4c/latest/features/cql-functions/custom-cql-functions).

You can use _Execution History_ to view up to two years of execution times and failure rates of ScriptRunner scripts in your instance, allowing a long-term view of script performance.

Breaking Change to Internal API

An internal API, `CQLSearchUtils` class has been changed to use dependency injection. This should be invisible to most users, but if you have a custom script using the `CQLSearchUtils` class, you will need to change how you retrieve & use it.

In prior versions of ScriptRunner for Confluence, you could use `CQLSearchUtils` to get pages using a static method:

```
import com.onresolve.scriptrunner.canned.confluence.utils.CQLSearchUtils def cqlQuery = 'space = KEY' // some CQL query def pages = CQLSearchUtils.searchForContent(cqlQuery)
```

Now, you need to retrieve it as a Spring bean.

```
import ...def cqlSearchUtils = ScriptRunnerImpl.scriptRunner.getBean(CQLSearchUtils) def cqlQuery = 'space = KEY' // some CQL query def pages = cqlSearchUtils.searchForContent(cqlQuery)
```

Bug Fixes

-   SRPLAT-873 - Settings could have been null, which caused NPE in various locations
-   SRPLAT-864 - An invalid object name, _null.AO\_31728E\_SR\_USER\_PROP_, was added when the plugin was run against an instance running on MS SQL Server
-   SRCONF-942 - [Execution History](https://docs.adaptavist.com/sr4c/latest/best-practices-and-app-management/execution-history) was added to [Custom Search Fields](https://docs.adaptavist.com/sr4c/latest/features/custom-search-fields)
-   SRCONF-941 - [Execution History](https://docs.adaptavist.com/sr4c/latest/best-practices-and-app-management/execution-history) was added to [Custom CQL Functions](https://docs.adaptavist.com/sr4c/latest/features/cql-functions/custom-cql-functions)
-   SRCONF-999 - _Browse_ features were removed from _Advanced Space Functionality_

## 5.6.9

-   Released 12 Dec 2019

### Bug Fixes

-   SRPLAT-670 - An exception was generated when adding or removing an event in the Events field on the _Custom Event Listener_ screen.
-   SRCONF-943 - Selecting the Advanced Space Functionality option while on version 5.6.6 caused high CPU loads and, in some cases, the page did not load.

## 5.6.8

### New Features

Browse Page Update

ScriptRunner for Confluence _Browse_ page concepts are now on the [_Event Listeners_](https://docs.adaptavist.com/sr4c/latest/features/event-listeners), [_Script Macros_](https://docs.adaptavist.com/sr4c/latest/features/macros), and [_Built-In Scripts_](https://docs.adaptavist.com/sr4c/latest/features/built-in-scripts) pages. You can now search all ScriptRunner functionality, like you can on the _Browse_ page, using the search bar on each page.

For example, the _Event Listeners_ search bar is pictured below:

Security vulnerabilities involving custom macros are explained in the [_Security and Best Practices_](https://docs.adaptavist.com/sr4c/latest/features/macros/create-custom-macro/security-and-best-practices) documentation. Additionally, code samples in the [_Custom Macros_](https://docs.adaptavist.com/sr4c/latest/features/macros/create-custom-macro) documentation were updated to show more secure code.

Bug Fixes

-   SRPLAT-836 - ScriptRunner did not clean up `MultiParentClassLoader` on plugin-enabled events
    

## 5.6.7

-   Released 11 Nov 2019

New Features

Label Tools Macros are Now Native Features of ScriptRunner for Confluence

Previously the _[Add Label Macro](https://docs.adaptavist.com/sr4c/latest/features/macros/built-in-macros/add-label-macro)_ macro and _[Choose Label Macro](https://docs.adaptavist.com/sr4c/latest/features/macros/built-in-macros/choose-label-macro)_ macro were housed in their own plugin (_Label Tools_), which depended on _ScriptRunner_.

In this release, _Label Tools_ has been merged into _ScriptRunner for Confluence_ to reduce your maintenance burden and speed up the release cycle for all _ScriptRunner_ features.

Upgrade Path

The upgrade path may be more or less complicated, depending on which version of ScriptRunner you currently have installed and which of the old dependent plugins you have installed, if any.

Most likely, you can simply install _ScriptRunner for Confluence_ 5.6.7, uninstall the old _Label Tools_ plugin (if you have it), and be done. If you encounter problems, read on.

Troubleshooting the Upgrade

If something goes wrong while you're upgrading, try these steps:

1.  Disable _ScriptRunner_ and all dependent plugins.
    
2.  Enable _ScriptRunner for Confluence_ 5.6.7.
    
3.  Uninstall all of the old _Label Tools_, _Create Page_, and _Page Information_ plugins.
    
4.  If you are using the _Notifications_ dependent plugin, then you can re-enable it.
    

If you encounter any issues that aren't resolved by the above steps, please do not hesitate to contact us via our [Support Portal](https://the-adaptavist-group-support.atlassian.net/servicedesk/customer/portal/21).For further details about the upgrade path for different environments, read on.

For Users Without Any Dependent Plugins

If you do not have any dependent plugins installed at all (_Create Page_, _Page Information_, _Label Tools_, or _Notifications_), this update should not require any action from you other than installation. That said, we encourage you to give the _[Choose Label Macro](https://docs.adaptavist.com/sr4c/latest/features/macros/built-in-macros/choose-label-macro)_ macro and the _[Add Label Macro](https://docs.adaptavist.com/sr4c/latest/features/macros/built-in-macros/add-label-macro)_ macro a try! Both macros were useful in their standalone plugin, and they'll make nice additions to your macro portfolio now that they are part of _ScriptRunner for Confluence_.

If you would prefer not to have either of these macros, they can be disabled just like any other script macro from the _Script Macros_ administration page.

Bug Fixes

-   SRPLAT-774 - There was a `MissingPropertyException` in subclasses of `AbstractBaseRestEndpoint` when accessing the log field
    
-   SRPLAT-773 - YAML files were not auto-deploying saved script configurations in custom plugin jars
    
-   SRCONF-835 - The browser Back button on the _Create Page_ macro screen was fixed
    
-   SRCONF-508 - Log output was not consistent in the _Logs_ tab of the _Script Console_ screen
    

## 5.6.6

-   Released 28 Oct 2019

New Features

Create Page and Page Information Macros Are Now Native Features of ScriptRunner for Confluence

Previously the _[Create Page Macro](https://docs.adaptavist.com/sr4c/latest/features/macros/built-in-macros/create-page-macro)_ macro and _[Page Info Macro](https://docs.adaptavist.com/sr4c/latest/features/macros/built-in-macros/page-info-macro)_ macro were housed in their own plugins, and the plugins depended on ScriptRunner. The two plugins have been merged into ScriptRunner for Confluence to reduce your maintenance burden and speed up the release cycle for all ScriptRunner features.

Upgrade Path

The upgrade path may be more or less complicated, depending on which of the dependent plugins you have installed, if any.

Troubleshooting Upgrades

If something goes wrong while you're upgrading, try these steps:

1.  Disable ScriptRunner and all dependent plugins.
    
2.  Enable ScriptRunner for Confluence 5.6.4.
    
3.  Make sure the old _Create Page_ and _Page Information_ plugins are uninstalled.
    
4.  If you are using the _Label Tools_ or _Notifications_ dependent plugins, then you can re-enable those.
    

If you encounter any issues that aren't resolved by the above steps, please do not hesitate to contact us via our [Support Portal](https://the-adaptavist-group-support.atlassian.net/servicedesk/customer/portal/21).

For further details about the upgrade path for different environments, read on.

Users Without Dependent Plugins

If you do not have any dependent plugins installed at all (_Create Page_, _Page Information_, _Label Tools_, or _Notifications_), this update should not require any action from you. However, we encourage you to give _[Create Page Macro](https://docs.adaptavist.com/sr4c/latest/features/macros/built-in-macros/create-page-macro)_ and _[Page Information](https://docs.adaptavist.com/sr4c/latest/features/macros/built-in-macros/page-info-macro)_ a try! Both macros were useful plugins on their own, and they'll make a nice new addition to your macro portfolio.

If you would prefer not to have these macros, they can be disabled just like any other script macro from the _Script Macros_ administration page.

Users With Create Page or Page Information Plugins Already Installed

If you currently have either the _Create Page_ plugin or the _Page Information_ plugin installed, you should be able to install this release without issues. You can see what apps you currently have installed via the [Confluence's Manage Add-ons](https://confluence.atlassian.com/conf63/managing-add-ons-or-plugins-929729605.html) page.The old _Create Page_ plugin and _Page Information_ plugins are still installed after you upgrade, but they should be disabled.

Warning: You should uninstall them immediately after upgrading.

Once the old plugins are uninstalled, existing uses of the _Create Page_ and _Page Information_ macros in your Confluence pages will continue to work as normal. This has been confirmed through backward compatibility testing, including in the Confluence instance where we use these macros.

Users With Dependent Plugins Besides Create Page and Page Information

The _Label Tools_ plugin will need to be updated to work with this version of ScriptRunner for Confluence.The latest releases of both _Label Tools_ and _[Notifications](https://marketplace.atlassian.com/apps/1218822/notifications-scriptrunner-confluence?hosting=datacenter&tab=overview)_ should be compatible with this release of ScriptRunner for Confluence.The current plan is to merge the _Label Tools_ plugin into ScriptRunner for Confluence next. We do not have a firm release date, but it will be announced in the release notes as usual.The _Notifications_ plugin is under evaluation to determine if the plugin's functionality should be merged as is or if building on ScriptRunner for Confluence's features and providing a migration path would be best.

Ability to Limit Which `confluence-administrators` Groups Can Edit ScriptRunner Scripts

You can now configure which groups with _Confluence Administrator_ permissions can create or edit scripts. For more information, see the [documentation](https://docs.adaptavist.com/sr4c/latest/get-started/settings).

Fix for SRPLAT-560 - Occasional NoClassDefFound with @WithPlugin compilation customizer

Dynamically adding and removing plugin classloaders was found to be impractical and unreliable due to lack of control over classloader caches.The behavior has changed so that when any `@WithPlugin` annotation is detected, the classloader from the selected plugin(s) is available to all scripts. This is true when using `@WithPlugin` or not in subsequent script executions. This change does not affect performance as the system classloaders are first in the classloader order.Continue to add `@WithPlugin` to any scripts that use classes from other plugins. Without this, after a restart, successful script compiling will be dependent on the order of execution. Static type checking will show errors if you forget to use `@WithPlugin`.

Other New Features

-   SRCONF-763 - _Bulk Delete Attachments_ now deletes old attachments
    
-   SRCONF-730 - A built-in script that clears the Groovy Classloader was added
    
-   Manage your .groovy script files using the new ScriptRunner [Script Editor](https://docs.adaptavist.com/sr4c/latest/features/script-editor)
    

Bug Fixes

-   SRPLAT-715 - The use of class autocompletion with an as cast operation was fixed.
    
-   SRPLAT-712 - An exception thrown by getting docs on a variable no longer occurs.
    
-   SRPLAT-709 - The fragment finder context variables overlay was added.
    
-   SRPLAT-703 - The missing Idea Integration icon was added back to code editors.
    
-   SRCONF-835 - _Create Page_ was fixed to work with the browser Back button.
    
-   SRCONF-830 - After upgrade, the _Create Page_ macro caused `StaleStateException` on Confluence instances using MySQL.
    
-   SRCONF-802 - The _Mugshot Gallery_ macro did not work for all authenticated users.
    
-   SRCONF-776 - All Confluence features with a code editor were fixed to abide by script edit permissions.
    
-   SRCONF-770 - Script Console was fixed to not appear for users without script edit permissions.
    
-   SRCONF-750 - The Browse Page link was fixed not to appear when it was not enabled.
    
-   SRCONF-575 - Old event listeners were not removed when scripts were updated.
    
-   SRCONF-435 - CQL did not run when editing the script job.
    
-   SRCONF-728 - Data from existing macros in the old plugin was handled in the plugin migration to ScriptRunner for Confluence
    
-   SRCONF-670 - The _Create Page_ macro was migrated to ScriptRunner for Confluence
    

## 5.5.11

-   Released 13 Aug 2019

Updates

Critical Security Update

This release fixes a security vulnerability that has been discovered in ScriptRunner for Confluence. The vulnerability affects version 4.3.1 - 5.5.8 (inclusive) of ScriptRunner for Confluence.The vulnerability is classified as critical in line with [Atlassian's Security Levels](https://www.atlassian.com/trust/security/security-severity-levels).The Markdown macro in ScriptRunner for Confluence enables users to render a markdown document in a page, blogpost or comment. The vulnerability is a [Server Side Request Forgery (SSRF)](https://www.owasp.org/index.php/Server_Side_Request_Forgery) that can be exploited by an unauthorized user to access internal resources accessible to the Confluence server, including files.After you upgrade, a Confluence administrator will need to add the websites hosting approved Markdown documents to Confluence's whitelist. Follow the detailed instructions in [the Markdown Macro documentation on the whitelist](https://docs.adaptavist.com/sr4c/latest/features/macros/built-in-macros/markdown).

How to Find URLs to Whitelist

The easiest way to find affected content is to do a quick search for which pages contain the Markdown Macro. ScriptRunner for Confluence makes this easy by adding a CQL Search feature right into Confluence???s main search.To make use of it, start typing a search query and the search panel should pop out. Click Advanced Search.On the search page, enter this query into the search box:`macro = markdown`…​then click the CQL Search button. A list of pages with the Markdown Macro should appear.From the search results, you can visit a page and edit it to see the URL used for that content.

You do not need to whitelist each individual URL.

Confluence's whitelist allows administrators to specify permitted domains or URL patterns. We recommend whitelisting [https://bitbucket.com](https://bitbucket.com/), [https://raw.githubusercontent.com](https://raw.githubusercontent.com/), and [https://raw.github.com](https://raw.github.com/) by default, as they will represent some of the most common use cases for this macro. All HTML produced by the Markdown Macro is sanitized to protect against cross-site scripting attacks, but you may use a more restrictive pattern such as [https://bitbucket.com/MyCompany/\*](https://bitbucket.com/MyCompany/*) at your discretion. Any linked Atlassian applications, such as a linked Bitbucket Server instance, will be whitelisted by default as well.

Replacing File URLs

One of the use cases originally supported by the Markdown Macro was specifying file paths on the server or on remote FTP servers using URLs with the `file://` or `ftp://` prefix.As the Confluence whitelist only supports `http` and `https` URLs, supporting file-based URLs requires a workaround. To that end, we have documented how to set up a [REST Endpoint](https://docs.adaptavist.com/sr4c/latest/features/rest-endpoints) to securely read files from the [filesystem on the Confluence server (including network shares)](https://docs.adaptavist.com/sr4c/latest/features/macros/built-in-macros/markdown) or from [remote FTP servers](https://docs.adaptavist.com/sr4c/latest/features/macros/built-in-macros/markdown).

## 5.5.8

-   Released 10 July 2019

### Bug Fixes

-   \[SRCONF-397\] - Lock-content macro: Error message when restricting a group in template
-   \[SRCONF-471\] - Built-in macros not available to select

## 5.5.7

-   Released 19 June 2019

New Features

-   \[SRCONF-708\] - Javadoc lookup for Confluence
-   \[SRPLAT-96\] - Custom event listeners should be able to listen to events provided by plugins
-   \[SRCONF-706\] - ScriptRunner for Confluence + Comala Workflows

Bug Fixes

-   \[SRCONF-416\] - Event Handler name consistency
-   \[SRCONF-704\] - Custom script macro & Smart code editor
-   \[SRCONF-535\] - To fix Currency Converter feature

## 5.5.6

-   Released 15 May 2019.

Updates

Anonymous Analytics

_Anonymous Analytics_ collects data allowing Adaptavist to gain insight into ScriptRunner usage. A new settings option allows administrators to switch _Anonymous Analytics_ on or off. See our [documentation](https://docs.adaptavist.com/sr4c/latest/get-started/settings) for more information.

Code Insight

This release includes our first version of _code insight_, a set of features designed to increase productivity, discovery, and enjoyement, when writing code in ScriptRunner.This consists of code completions, parameter lookups, and javadoc links (javadoc links currently for Jira only).

Take a look at the [documentation](https://docs.adaptavist.com/sr4c/latest/best-practices-and-app-management/code-editor) for more information.

Bug Fixes

-   \[SRCONF-425\] - Rename labels wrong error message position
-   \[SRCONF-437\] - Prune old versions terminates if a new version is created while the script is running
-   \[SRCONF-666\] - Built-in Script Transformation window throws a 500 when checking the code in the script window

## 5.4.50

-   Released 27 Feb 2019

### New Features

-   \[SRCONF-492\] - ScriptRunner for Confluence users are now able to get notified when a page hasn't been updated for some time, therefore, ensuring your content is always relevant
-   \[SRCONF-641\] - ScriptRunner for Confluence users can now better integrate their custom codes with Comala Workflow App

Bug Fixes

-   \[SRCONF-581\] - Information box for Space Tools is incorrectly showing a blank message
-   \[SRCONF-503\] - Attempting to use the Confluence Search bar while in any of the ScriptRunner pages throws an error
-   \[SRCONF-386\] - Group Rest end point access in Lock content Macro is not restricted
-   \[SRCONF-620\] - Jackson-databind Vulnerabilities Assessment and Patch

## 5.4.47

-   Released 16 Jan 2019

### Bug Fixes

-   \[SRCONF-542\] - Copy Page Tree throws an error

## 5.4.36

-   Released 22 Oct 2018

Warning: Please read if you are using versions 5.4.16, 5.4.17 or 5.4.22

If you are currently using any of these versions, you may experience issues updating ScriptRunner if any of the dependent apps are enabled.

Dependent Apps include:

-   [Create Page for ScriptRunner Confluence](https://docs.adaptavist.com/sr4c/latest/features/macros/built-in-macros/create-page-macro)
    
-   [Page Info for ScriptRunner Confluence](https://docs.adaptavist.com/sr4c/latest/features/macros/built-in-macros/page-info-macro)
    
-   [Label Tools for ScriptRunner Confluence](https://docs.adaptavist.com/sr4c/latest/features/macros/built-in-macros/choose-label-macro)
    
-   [Notifications for ScriptRunner Confluence](https://marketplace.atlassian.com/apps/1218822/notifications-scriptrunner-confluence?hosting=server&tab=overview)
    

Suggested Workaround

You can avoid this issue simply by disabling dependent apps BEFORE you update ScriptRunner. You can then update ScriptRunner and re-enable your dependent apps. Once you update to 5.4.26 or later, you will no longer need to perform this workaround.

Note: Other workarounds are available, please see this ticket for a full list of the documented workarounds. SRCONF-439.

Bug Fixes

-   \[SRCONF-455\] - Parameter button is missing in the Custom Script Macros. This fixes an issue where a change or changes to the custom script macro causes an error

-   \[SRCONF-454\] - Fixes issue where browsing server log files functionality is broken

-   Minor Security Updates

## 5.4.26

-   Released 18 Sep 2018
-   Compatible with Confluence 6.11.x

Updates

Important Instructions

If you are currently using either version 5.4.16 to 5.4.22 and you are moving to the latest release, you may experience issues updating if you are using ScriptRunner dependent plugins and they are enabled. There are workarounds documented as part of SRCONF-439.

Workaround

You can avoid this issue simply by disabling dependent plugins BEFORE you update ScriptRunner. You can then simply update ScriptRunner and re-enable your dependent plugins. Once you update to 5.4.26 or later, you will no longer need to perform this workaround.

New Features

-   \[SRCONF-334\] - Add a script to set page restrictions recursively
-   \[SRCONF-314\] - Create a new Rename Pages built-in script

Bug Fixes

-   \[SRCONF-285\] - JS and CSS files are not working, has to be inline
-   \[SRCONF-445\] - ScriptRunner macros not present in Macro Manager
-   \[SRCONF-439\] - ScriptRunner hanging on update

## 5.4.17

-   Released 10 August 2018

### Bug Fixes

-   \[SRCONF-420\] - Bug in CQL Search Macro
-   \[SRCONF-419\] - Script Macros: Lazy macros are not loading
-   \[SRCONF-338\] - All the page trees should have a lazy select 2 and only when selected should fetch the page tree for that space

## 5.4.16

-   Released 20 July 2018
-   Compatible with Confluence 6.10.x

### Bug Fixes

-   \[SRCONF-385\] - Permissions only allow selection of a single space
-   \[SRCONF-384\] - Broken macro after ScriptRunner update
-   \[SRCONF-381\] - Bulk Purge Trash does not work using the "All" checkbox
-   \[SRCONF-380\] - Inherit Permissions are not being maintained when upgrading to 5.4.9
-   \[SRCONF-362\] - Groups are not being lazily fetched
-   \[SRCONF-341\] - Example does not work
-   \[SRCONF-284\] - Built-in scripts pop-up dialogue not locked to the 'Space Tools' tab
-   \[SRCONF-398\] - Script macros : parameters cannot be edited after upgrade
-   \[SRCONF-407\] - ScriptConsole is showing up in the Space Admin Built-in Scripts

Note: Due to an issue in the [Space Admin Permissions](https://docs.adaptavist.com/sr4c/latest/get-started/permissions) we advise to navigate to that specific screen and verify if the permissions are correctly set for your instance.

## 5.3.35

-   Released 01 May 2018

Updates

Security Fixes

This update fixes a critical security vulnerability in ScriptRunner for Confluence discovered during an internal review. We strongly recommend all customers apply this update at their earliest opportunity. Further details will be released in the coming weeks as part of Adaptavist's responsible disclosure approach.

All versions of ScriptRunner for Confluence are affected. Below are instructions on which version we recommend you upgrade to:

-   If you have Confluence 5.10.x or above, upgrade to 5.3.35
    
-   If you have Confluence 5.9.x, upgrade to 5.3.34
    
-   If you have Confluence 5.8.x, upgrade to 4.3.25
    

## 5.3.12

-   05 April 2018
-   Compatible with Confluence 6.8.x

New Features

ScriptRunner Audit Logging Service Added

As a Confluence administrator you can now inspect script configuration changes from Confluence audit. For more information check [_Audit Logging_](https://docs.adaptavist.com/sr4c/latest/best-practices-and-app-management/audit-logging).

Bug Fixes

-   \[SRCONF-308\] - Page with Lock Content macro does not save page after edit
-   \[SRCONF-313\] - Space field is eagerly fetching and should fetch lazy based on the user input
-   \[SRCONF-306\] - More reliable loading of ScriptRunner using MySQL
-   \[SRPLAT-261\] - ScriptRunner custom REST endpoints in Data Center only setup on one node
-   \[SRCONF-265\] - Copy Space Builtin Script Doesn't Copy all the properties

## 5.3.3

-   Released 12 Feb 2018
-   Compatible with Confluence 6.7.x

### Bug Fixes

-   \[SRCONF-272\] - Lock Content is not pre-filling groups
-   \[SRCONF-268\] - Hide the panel "Advanced space Functionality" in space
-   \[SRCONF-274\] - Markdown Macro is not displaying Tables

## 5.2.12

-   Released 22 Jan 2018

### Bug Fixes

-   \[SRPLAT-254\] - XSS security issue in the tree view

## 5.2.4

-   Released 04 Dec 2017

### Bug Fixes

-   \[SRCONF-266\] - Markdown Macro allows access to the filesystem
-   \[SRCONF-264\] - Include Version macro error
-   \[SRCONF-263\] - Permissions pulling groups are using always lower case so if a group is uppercase it fails

## 5.2.2

-   Released 31 Oct 2017

New Features

This version introduces two new built-in script for both Confluence and Space admins.

The Bulk Add or Remove Labels to One or More Pages allows you to bulk add or remove labels on page trees.

The Space Statistics script allows the comparing of spaces in bar chart and table form.

Bug Fixes

-   \[SRCONF-250\] - Space Admins copy space has to respect if the user has permission to create new spaces
-   \[SRCONF-252\] - ScriptRunner for Confluence breaks macro usage search

## 5.1.2

-   Released 21 Sep 2017

New Features

This version introduces built-in scripts for space admins. This feature allows space admins to take advantage of some of the built-in scripts that were only available to Confluence admins. This means less support tickets and a quicker resolution of administration tasks. Built-in scripts for space admins includes:

-   Bulk delete attachments
    
-   Bulk purge trash
    
-   Copy page tree
    
-   Delete page tree
    
-   Bulk delete comments
    
-   Copy space
    
-   Inherit permissions
    

To onboard your space admins quickly we've created a helpful [how-to guide](https://s3-eu-west-1.amazonaws.com/confluence-addons.connect.adaptavist.com/Adaptavist_Add-ons_SR4C_How-To_Built-in-Scripts-for-Space-Admins_20170830.pdf).

Please note that you may disable this feature or limit it by user or group should your users not require it. You can do this by following the steps in our documentation [here](https://docs.adaptavist.com/sr4c/latest/get-started/permissions).

Additionally the Lock Content Macro now allows to hide content from users that do not have permissions. This means you can now customize your content for different audiences.

Bug Fixes

-   \[SRCONF-249\] - Lock Content macro does not work on some cases
-   \[SRCONF-238\] - Unable to add new Script Job-CQL escalation service
-   \[SRCONF-210\] - Create from template button pointing at a wrong template after cloning

## 5.0.17

-   Released 25 July 2017
-   Compatible with Confluence version 6.3.x

### Bug Fixes

-   \[SRCONF-237\] - Fixed event handler inline comment example
-   \[SRCONF-242\] - Fixed user interface issue with script jobs

## 5.0.9

-   Released 25 July 2017

### Bug Fixes

-   \[SRCONF-221\] - Fixed removing of the filter that was causing issues regarding the encoding when accessing the REST API

## 5.0.8

-   Released 15 May 2017

### Bug Fixes

-   \[SRCONF-230\] - Fixed Lock Content blocking save issue
-   \[SRCONF-233\] - Fixed unable to create new CQL function

## 5.0.0

-   Released 28 April 2017.

New Features

User Interface Updated

With version 5.0.0 we've done a major overhaul of the user interface, allowing for a more user friendly experience and providing a better way of navigating through all sections of ScriptRunner.

Scripts are also now better organized and easier to access allowing for a quicker access to the desired script through a collapse and expand buttons. Together with this, we've decided to removed the slow auto-scroll when a script was being edited for a more snappy experience.

### Lock Content Macro

Let's say as a page author you want to add a page status or information and do not want the information to be removed or modified by specific users or groups. This is not achievable straight away as Confluence does not support the concept of partial restrictions. Lock Content Macro helps you to achieve this by restricting users or groups editing its content. Add the user name in Restricted Users or group in Restricted Groups you want to restrict. That's all. The user or the users in group won't be able to edit the content of the macro.

### Inherit Restrictions for Pages

Inherit restrictions lets you create pages inheriting the parent page restrictions. By default, newly created pages only inherit view permissions from the parent page, not edit permissions, which means users have to set it manually every time a page is created. Inherit Restrictions overcomes this shortcoming by offering administrators the option to specify which pages or spaces that inherit page restrictions automatically.

### Custom CQL Functions

Confluence Query Language (CQL) allow you to create custom CQL Functions that perform advanced searches for content in Confluence. Create and share custom CQL functions with your users in order to empower their search.

### Search Extractors

Search Extractors allow you to add useful indexes to Confluence's search in order to find pages that meet a specific criteria. Some examples are:

-   Find all home pages
    
-   Find pages with large attachments
    
-   Search all pages that contain a specific label
    
-   Find pages last modified by a specific user
    
-   Search for pages created in a specific year
    

Script Macros

-   Ability to define CSS and Javascript in Script Macros
    
-   Fixed UI for Parameters
    

Bug Fixes

-   \[SRCONF-211\] - Fixed template label bug for copy space built-in script.
-   \[SRCONF-180\] - Fixed error "Configuration module is enabled or plugin is missing an configuration module" while starting Confluence.
-   \[SRCONF-200\] - Fixed Scheduled Job Cron Expressions bug.
