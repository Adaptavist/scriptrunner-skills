# Release 5.x

- Platform: data-center
- Space: SR4JS
- Hierarchy: release-notes
- Doc ID: doc-sr4js-101624452
- Source: https://docs.adaptavist.com/sr4js/latest/release-notes/release-5-x

Check out what’s new for ScriptRunner for Jira Server.

## 5.9.1

-   Released 23 April 2020.

**Bug Fixes**

-   SRJIRA-4215 \- An issue where Automation for Jira’s _Execute a ScriptRunner script_ action caused a blank page and an _Invariant Violation: Minified React error_ in the console has been fixed.
    

## 5.9.0

-   Released 16 April 2020.

**New Features**

Behind the scenes, the deprecation information behind the [code editor](https://docs.adaptavist.com/display/SR4JS/.Code+Editor+v6.19.0) has been improved.

-   SRPLAT-1022 \- There is now an **Exit** button for the _Switch User_ built-in script.
    

**Bug Fixes**

-   SRPLAT-1057 \- Script Registry execution performance has been improved.
    
-   SRPLAT-1055 \- Script editor did not enable vertical scroll when too many lines were added.
    

## 5.8.0

-   Released 31 March 2020.
-   Compatible with Jira 8.8.0.

**Bug Fixes**

-   SRJIRA-4206 \- A NullPointerException in the _Script Registry_ built-in script has been fixed.
    
-   SRJIRA-4194 \- The _Execution History_ CSS within workflows now displays correctly.
    
-   SRJIRA-4094 \- A MismatchedInputException error causing the _Script Registry_ not to load, has been fixed.
    
-   SRPLAT-931 \- The code editor did not show method deprecation warnings for SAL.
    

## 5.7.2

-   Released 25 March 2020.

**Bug Fixes**

-   SRPLAT-999 \- Script Editor - deprecations of inner classes are now correctly shown.
    
-   ```
SRJIRA-4173 - The Send a Custom Email workflow script configuration deserialization no longer assumes that the FIELD_EMAIL_FORMAT will be either HTML or TEXT.
```
    
-   SRJIRA-4129 \- The `/remote-events/available` endpoint no longer throws an error.
    
-   SRPLAT-931 \- Method deprecation warnings for SAL now show in the Code Editor.
    

## 5.7.1

-   Released 11 March 2020.

**New Features**

**Dynamic Forms**

Introducing Dynamic Forms, a feature to simplify the process of editing variables in your ScriptRunner Groovy scripts. Dynamic Forms allows you to create complex scripts with flexible variables that can be shared with multiple users, allowing one script to be used for various use cases, reducing maintenance requirements while allowing for script customization. For more information see our [documentation](https://docs.adaptavist.com/display/SR4JS/.Dynamic+Forms+v6.21.0).

**Bug Fixes**

-   SRPLAT-962 \- Cron descriptions now display the correct weekday.
    
-   SRJIRA-4155 \- "When" behaviour conditions can now be added after the first "Except" condition is added.
    
-   SRJIRA-3723 \- Opening multiple constrained issue dialogs on the same page no longer causes issues with the behaviour context ID.
    
-   SRJIRA-3646 \- The execution history for Custom Script scripted fields now displays in the user interface.
    

## 5.7.0

-   Released 27 Feb 2020.

**Bug Fixes**

-   SRPLAT-948 \- Conditions on Web Fragments created prior to release 5.6.15 are now visible.
    
-   SRJIRA-4138 \- Previewing an editable script field now shows the current value.
    
-   SRJIRA-4128 \- The width of picker fields is constrained correctly.
    
-   SRJIRA-4127 \- Database picker fields have highlighting info when searching.
    
-   SRJIRA-4109 \- PostMessageToChatService now handles an empty hook URL.
    
-   SRJIRA-4047 \- An UncaughtException showing a null behaviourID, caused by Anonymous Analytics, has been fixed.
    
-   SRJIRA-4044 \- Custom Email post-function no longer reverts (and fails to save) updates from HTML to plain text
    
-   SRJIRA-3938 \- The Issue Picker list no longer overlaps other issue picker fields.
    
-   SRJIRA-2532 \- Nested script execution no longer overrides "sr.execution.id" in Log4j MDC storage which caused scripts running up the stack to lose remaining log entries.
    
-   SRJIRA-4067 \- A full reindex scoped cache for last index lookups has been introduced to improve the performance of last comment indexing on large instances
    

## 5.6.15

-   Released 11 Feb 2020.

**Bug Fixes**

-   SRPLAT-912 \- Script Editor has been fixed.
    
-   SRPLAT-566 \- Browse Page now maintains search input focus.
    
-   SRJIRA-3921 \- Scripted multi-issue picker no longer selects multiple items with one click.
    
-   SRJIRA-3842 \- A MethodMissing exception that caused the REST endpoint page to fail to load has been fixed.
    
-   SRJIRA-2974 \- Aggregate functions now always display calculation.
    

## 5.6.14

**Bug Fixes**

-   SRPLAT-908 \- A bug that prevented editing of previously configured script files has been fixed.
    
-   SRJIRA-3139 \- Issue Picker Field now supports searching empty values.
    

## 5.6.13

-   Released 22 Jan 2020.

**IntelliJ IDEA Plugin Deprecation**

We are officially deprecating the IntelliJ IDEA plugin, also known as the _Adaptavist Power Editor_. ScriptRunner 5.6.13 contains the last bugfix we will ship for this feature, and 0.7.20 is the last release we will make on the JetBrains marketplace. Future support requests for this feature will be referred to this deprecation notice.

As can be seen from the review history on [our JetBrains marketplace listing](https://plugins.jetbrains.com/plugin/9751-adaptavist-scriptrunner-power-editor), we haven’t been consistently keeping up with JetBrains’s quarterly release schedule, due to prioritization constraints.

**Reasons for the Change**

Two key concerns motivated our decision to deprecate: the opportunity cost of developing the _Adaptavist Power Editor_ and its overlap with other ScriptRunner features.

The IntelliJ IDEA platform is a rich, fast-moving one. Just about every release requires refactoring some part of our plugin’s codebase. As users of IntelliJ IDEA, we love this rapid development. However, it is a challenge to keep up with developing a secondary plugin that is not our core product, while also keeping an eye on the Atlassian release cycle. While IntelliJ IDEA was an interesting platform to expand into, it required more focus than we were able to give it.

Further, we are continuing to maintain and develop two other features which meet most of the needs met by the IntelliJ Plugin. These are the _[Code Editor](https://docs.adaptavist.com/sr4js/latest/best-practices/write-code/code-editor)_ and [the `scriptrunner-samples` repository for local development](https://docs.adaptavist.com/sr4js/latest/best-practices/write-code/create-a-script-plugin).

The _Code Editor_ provides smart completions, parameter hints, and javadoc lookup. While that’s nowhere near the feature set provided by IntelliJ IDEA, it does provide a rich development experience, one which we’d like to develop further. Most importantly, the _Code Editor_ is up and running by default with no setup.

For users who want a deeper development experience and don’t mind some setup, developing a _Script Plugin_ affords a fully featured IDE, git integration, the ability to save script configuration as code, and other developer tools.

With the addition of the _Code Editor_ (with built-in autocompletion), and the new _Script Editor_ (allowing users to save files in script roots), the _Adaptavist Power Editor_ had a very niche user base with a very high maintenance burden. Although we had reservations about deprecating the IntelliJ IDEA integration due to feature loss in the short term, increased investment in the core ScriptRunner product is our priority.

Continuing to let the _Adaptavist Power Editor_ lag with late compatibility updates wasn’t fair to our users, and we are committed to delivering more new features and improvements to the ScriptRunner product itself.

Ultimately, creating a plugin for IntelliJ IDEA was a valuable experiment. It taught us important lessons about providing a rich code editor that we still want to incorporate into the core _Code Editor_. We would love to hear from you which aspects you found most valuable. Please contact us through our support portal if there are features you would like to request for the _Code Editor_.

**Bug Fixes**

-   SRPLAT-830 \- IntelliJ Integration that was broken in 5.6.6 and beyond, is now fixed.
    
-   SRJIRA-4077 \- Script Editor icons are now displayed correctly.
    
-   SRJIRA-4066 \- Escalation Services are now successfully migrated to jobs.
    
-   SRJIRA-4057 \- Creating a planning board item with action == "comment" does now show the item.
    

## 5.6.12

-   Released 22 Jan 2020.

**ScriptRunner Remote Events Code Execution Vulnerability**

An HTTP POST made to `/rest/scriptrunner/latest/remote-events` with a specially crafted JSON payload could lead to unrestricted Groovy code execution for any logged-in user, regardless of permissions.

This security vulnerability has been fixed in ScriptRunner 5.6.12; it is recommended all customers upgrade to 5.6.12+ where possible.

If no firewall is enabled, users must update ScriptRunner to include this security patch.

**Temporary Workaround**

If you are unable to upgrade immediately, blocking HTTP requests beginning with `<base_url>rest/scriptrunner/*/remote-events` mitigates the vulnerability.

To verify the workaround is applied correctly check that requests to <base\_url>rest/scriptrunner/\*/remote-events/ are denied.

Below are examples of how to apply the workaround in Apache and Tomcat by blocking requests to the Scriptrunner Remote Events endpoint at the reverse proxy, load-balancer or application server level.

Please note that Adaptavist Support does not provide any assistance for configuring reverse proxies. Consequently, we provide the below examples as is, with no support and no written or implied warranties. To verify the workaround is applied correctly check that requests to <base\_url>rest/scriptrunner/\*/remote-events/ are denied.

##### **Apache HTTPD Reverse Proxy**

###### Apache 2.4 Syntax

Add the following into the `.conf` file containing the virtualhost that proxies to the Atlassian application.

```
<LocationMatch "/rest/scriptrunner/.*/remote-events/">
Require all denied
</LocationMatch>
Example:
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
        Require all denied
    </LocationMatch>
</VirtualHost>
```

###### Apache 2.2 Syntax

Add the following into the `.conf` file containing the virtualhost that proxies to the Atlassian application:

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

##### Tomcat urlrewrite.xml

Redirect requests to `/rest/scriptrunner/.*/remote-events/.*` to a safe URL.

1.  Add the following to the `<urlrewrite>` section of `[jira-installation-directory]/atlassian-jira/WEB-INF/urlrewrite.xml`:
    
    ```
<rule>
<from>/rest/scriptrunner/.*/remote-events/.*</from>
<to type="temporary-redirect">/</to>
</rule>
```
    
      
    
      
    
2.  Save the `urlrewrite.xml`.
    
3.  Restart the Atlassian application.
    

## 5.6.11

-   Released 09 Jan 2020.

**Bug Fixes**

-   SRPLAT-873 \- Settings could have been null, which caused NPE in various locations.
    
-   SRPLAT-864 \- An invalid object name, _null.AO\_31728E\_SR\_USER\_PROP_, was added when the plugin was run against an instance running on MS SQL Server.
    

## 5.6.10

-   Released 26 Dec 2019.

**New Features**

**Issue Archiving (Data Center 8.1+)**

There are two new features in ScriptRunner for Jira server allowing users to archive issues. You can now configure an Issue Archiving Job or Archive this Issue Post-function.

**New Features in Script Editor**

-   **Folder Support** \- Use the context menu to create new folders in the script root directory. Script Editor also supports the creation of nested folders, separate them using `/` character. Folders (and files) can be moved around the file tree using drag-and-drop.
    
-   **Deletion Support** \- You can now remove files and folders directly from the Script Editor UI. Just right-click on the file or folder you want to remove and select **Delete** from the context menu.
    
-   **Renaming Support** \- You can now rename files and folders using context menu option **Rename** available on each node in Script Editor.
    

**Services and Escalation Services Moved to Jobs**

Services and Escalation Services are now part of ScriptRunner Jobs. Migrated services run as expected, however; when editing a service, you must specify an application user in the User field. For more information see our Jobs documentation.

  

**Bug Fixes**

-   SRPLAT-864 \- An invalid object name 'null.AO\_31728E\_SR\_USER\_PROP' when running on MS SQL Server has been fixed.
    
-   SRJIRA-4017 \- _Script Registry_ now picks up simple scripted validators.
    
-   SRJIRA-3990 \- An issue with the Send Custom Email function has been fixed.
    
-   SRJIRA-3988 \- An error with Send a custom email listener filing to find event has been fixed.
    
-   SRJIRA-3985 \- The StackOverflowError when using AddedAfterSprintStart or RemovedAfterSprintStart JQL functions in card color queries is fixed.
    
-   SRJIRA-3983 \- Having a large number of comments on an issue no longer causes re-indexing delays.
    
-   SRPLAT-862 \- There is now support for cross-app, in-app fixtures usable from tests running outside of the app.
    

## 5.6.9

-   Released 12 Dec 2019.

**More Groovy Classes are Backwards Incompatible**

We are continuing the background work that we started in 5.6.7.

If you have any custom classes in your script roots or configured scripts which extend `com.onresolve.scriptrunner.canned.jira.workflow.listeners.CustomListener`, those may be broken by this release.

If you notice the Listeners page is failing to load, this problem may be affecting you. One potential workaround: you can add the `@groovy.transform.InheritConstructors` annotation to your custom class. As before, if you need additional help as a result of these changes, please contact us via [our support portal](https://the-adaptavist-group-support.atlassian.net/servicedesk/customer/portal/21).

**Scalability Improvements to lastComment JQL Function**

In version 5.6.6 we released a scalability improvement to the `lastComment` JQL function.

Unfortunately due to an internal process problem, we neglected to include in the release notes the following information.

The changes to the implementation of [lastComment JQL function](https://docs.adaptavist.com/sr4js/latest/features/jql-functions) in this version mean that a reindex of Jira is required for that function to work correctly.

A background reindex of Jira is not sufficient. You must select the option "Lock Jira and rebuild index". Obviously this should be done out of business hours.

**Bug Fixes**

-   SRPLAT-670 \- An exception was generated when adding or removing an event in the **Events** field on the _Custom Event Listener_ screen.
    
-   SRJIRA-3982 \- The wrong value displayed for scripted fields based on the current user.
    
-   SRJIRA-3969 \- Creating a Post Function "create sub-task" or "Clones an issue, and links" no longer throws the java.lang.NoClassDefFoundError: com/atlassian/servicedesk/api/NoSuchEntityException.
    
-   SRJIRA-3710 \- STC errors/warnings are now shown in the registry.
    
-   SRJIRA-3488 \- Missing icons now show within script execution reports.
    

## 5.6.8

-   Released 27 Nov 2019.

**New Features**

-   SRJIRA-3712 \- The **Database Picker** fields can now appear on the Service Desk Portal.
    

**Bug Fixes**

-   SRPLAT-836 \- Scriptrunner did not clean up `MultiParentClassLoader` on plugin-enabled events.
    
-   SRJIRA-3960 \- `FireEventWhen` sometimes received the wrong ChangeLog it fired events.
    
-   SRJIRA-3954 \- The **View in Issue Navigator** link on the backlog board did not show all issues in the backlog.
    
-   SRJIRA-3953 \- You could not edit workflow functions that were created several years ago.
    
-   SRJIRA-3935 \- ScriptRunner action did not work in automation because of a JavaScript error.
    

## 5.6.7

-   Released 07 Nov 2019.

**Bug Fixes**

-   SRPLAT-774 \- `MissingPropertyException` in subclasses of `AbstractBaseRestEndpoint` when accessing the log field has been fixed.
    
-   SRPLAT-773 \- Yaml files now auto deploy saved script configurations in custom plugin jars.
    
-   SRJIRA-3344 \- Default text in _Visual_ mode in a tab now renders correctly.
    
-   SRJIRA-3827 \- An issue causing uneditable checkboxes is now fixed.
    

## 5.6.6

-   Released 28 Oct 2019.

**New Features**

-   Manage your .groovy script files using the new ScriptRunner [_Script Editor_](https://docs.adaptavist.com/sr4js/latest/features/script-editor).
    
-   SRJIRA-3782 \- **Database Picker** options display automatically.
    

**Bug Fixes**

-   SRPLAT-715 \- The use of class autocompletion with an _as_ cast operation was fixed.
    
-   SRPLAT-712 \- An exception thrown by getting docs on a variable no longer occurs.
    
-   SRPLAT-709 \- The fragment finder context variables overlay was added.
    
-   SRPLAT-703 \- The missing **Idea Integration** icon was added back to code editors.
    
-   SRPLAT-691 \- Long files are now rendered in _Script Editor_.
    
-   SRJIRA-3827 \- An issue causing uneditable checkboxes is now fixed.
    
-   SRJIRA-3790 \- Script fragments items have been reordered.
    
-   SRJIRA-3789 \- Free text search is not defaulted unless the field has the _text_ template.
    
-   SRJIRA-3777 \- An issue causing new issue events to be missing when configuring a custom listener, has been fixed.
    
-   SRJIRA-3619 \- layering issue when using any picker field
    
-   SRJIRA-3617 \- **Issue Picker** search has been improved.
    
-   SRJIRA-3112 \- Installing Service Desk or Jira Software after ScriptRunner no longer causes 'NoClassDefFoundError'.
    
-   SRJIRA-2679 \- The `lastComment` JQL function is now scalable for enterprise.
    
-   [SRJIRA-3528](https://assist.adaptavist.com/browse/SRJIRA-3528) \- The _Behaviour_ feature has had performance improvements.
    

## 5.6.5

-   Released 28 Oct 2019.

**New Features**

-   SRJIRA-3782 \- Show database picker options without having to start typing
    

**Bug Fixes**

-   SRPLAT-715 \- Cannot use class completion with "as" cast operation
    
-   SRPLAT-712 \- Code Insight - getting docs on a variable throws exception
    
-   SRPLAT-709 \- Fragment Finder context variables overlay missing
    
-   SRPLAT-703 \- No Idea icon to connect plugin
    
-   SRJIRA-3790 \- Script fragments items not ordered well
    
-   SRJIRA-3789 \- do not default to free text search unless the field has the "text" template
    
-   SRJIRA-3777 \- New issue events cannot be found when configuring a custom listener
    
-   SRJIRA-3619 \- Layering issue when using any picker field
    
-   SRJIRA-3112 \- Installing Service Desk or Jira Software after ScriptRunner cause NoClassDefFoundError
    
-   SRJIRA-3776 \- Support writing Arquillian Spock specifications for SR for Jira
    
-   SRJIRA-3528 \- Behaviour Feature - Performance Improvements
    

## 5.6.2

-   Released 12 Sep 2019.

**Bug Fixes**

-   \[SRJIRA-2931\] - SD Behaviours were executing off of the wrong ID.
-   \[SRJIRA-3681\] - Script fields were appearing empty.
-   \[SRPLAT-658\] - Could not use code completion features with @WithPlugin for some plugins.
-   \[SRPLAT-680\] - Dependent plugin classes weren't loaded correctly.

## 5.6.1

-   Released 15 Aug 2019.

**Bug Fixes**

-   \[SRJIRA-458\] - Import of helper class not possible
-   \[SRJIRA-3328\] - Script Field partially duplicated after adding a new configuration context
-   \[SRJIRA-3391\] - Assigning closures with no parameters to script field bindings doesn't type check
-   \[SRJIRA-3457\] - Subquery in 'expression' JQL function isn't necessarily valid when expression script is being validated
-   \[SRJIRA-3494\] - Cached condition results need to be keyed on status as well
-   \[SRJIRA-3651\] - Ambiguous method error when using expression JQL function anonymously
-   \[SRJIRA-3658\] - potential class loader lock contention issue when parsing behaviours configuration
-   \[SRJIRA-3646\] - "Custom Script" Scripted Fields fail to show Execution History in user interface

**Fix for SRPLAT-560 - Occasional NoClassDefFound with @WithPlugin compilation customizer**

Dynamically adding and removing plugin classloaders was found to be impractical and unreliable due to lack of control over classloader caches.

The behaviour has changed so that when any `@WithPlugin` annotation is detected, the classloader from the selected plugin(s) is available to all scripts. This is true when using `@WithPlugin` or not in subsequent script executions. This change does not affect performance as the system classloaders are first in the classloader order.

Continue to add `@WithPlugin` to any scripts that use classes from other plugins. Without this, after a restart, successful script compiling will be dependent on the order of execution. Static type checking will show errors if you forget to use `@WithPlugin`.

## 5.5.9

-   Released 12 July 2019.

**Bug Fixes**

-   \[SRJIRA-3640\] - Cannot edit script fields if they were created previously

## 5.5.8

-   Released 12 June 2019.

**New Features**

**Database Picker**

Introducing the ScriptRunner _Database Picker_ scripted field. The _Database Picker_ scripted field allows you to display database records as field options. Configure custom SQL queries to retrieve data from databases connected under the [_Resources_](https://docs.adaptavist.com/sr4js/latest/features/resources) tab.

For more information on the ScriptRunner _Database Picker_ see our [documentation](https://docs.adaptavist.com/sr4js/latest/features/script-fields/built-in-script-fields/database-picker).

**Bug Fixes**

-   \[SRJIRA-3357\] - Behaviours Mapping screen can only search on the first 100 RequestTypes and 50 Service Desks
-   \[SRJIRA-3415\] - Behavior script is not loaded on Service Desk if the request page loads slowly
-   \[SRJIRA-3485\] - Preview button is not working for Post-Functions and the Update Button fails for some Post functions
-   \[SRJIRA-3624\] - Link to field config is incorrect from script fields

## 5.5.7

-   Released 12 June 2019.

**New Features**

-   \[SRJIRA-2011\] - Apply create constrained issue fragment to multiple projects
-   \[SRJIRA-3218\] - ScriptRunner Mail Handler
-   \[SRPLAT-96\] - Custom event listeners should be able to listen to events provided by plugins

**Mail Handler**

Introducing the new ScriptRunner _Mail Handler_. _Mail Handler_ for ScriptRunner expands on Jira’s built-in mail handling capabilities. This new feature allows users to run groovy scripts when messages are received, automating tasks such as creating a new issue from the mail subject, creating users from the recipient list, or triggering workflow actions.

For more information on how to configure a ScriptRunner _Mail Handler_ see our [documentation](https://docs.adaptavist.com/sr4js/latest/features/mail-handler).

**Bug Fixes**

-   \[SRJIRA-2747\] - Constrained create issue screen doesn't preserve behaviour context id when project is changed
-   \[SRJIRA-3004\] - Fields with behaviours become inline-editable if you edit another field inline first
-   \[SRJIRA-3296\] - Unable to use send mail attachments callback on Service Desk project
-   \[SRJIRA-3449\] - AddedAfterSprintStart and RemovedAfterSprintStart do not work with anonymous access
-   \[SRJIRA-3459\] - Update Custom attachment callback example
-   \[SRJIRA-3462\] - Behaviours: Edit popup dialog does not trigger since 5.5.5
-   \[SRJIRA-3469\] - Script Field "Issue Picker" does not work with REST API

## 5.5.6

-   Released 15 May 2019.

**New Features**

**Anonymous Analytics**

_Anonymous Analytics_ collects data allowing Adaptavist to gain insight into ScriptRunner usage. A new settings option allows administrators to switch _Anonymous Analytics_ on or off. See our [documentation](https://docs.adaptavist.com/sr4js/latest/get-started/settings) for more information.

**Bug Fixes**

-   \[SRJIRA-2931\] - SD Behaviours executing off of the wrong ID
-   \[SRJIRA-3450\] - Scripted Field Searchers bugs
-   \[SRPLAT-524\] - User is encountering exceptions when upgrading to ScriptRunner 5.5.5

## 5.5.5

-   Released 01 May 2019.

**Bug Fixes**

-   \[SRJIRA-2853\] - Cannot set time spent field to read only
-   \[SRJIRA-2873\] - setHidden() on attachment hides upload box, but doesn't hide field name
-   \[SRJIRA-2880\] - Behaviours | Unable to find and manipulate Log Work fields
-   \[SRJIRA-2926\] - Create Constrained Issue Dialog Doesn't Work
-   \[SRJIRA-3068\] - The Script Fields page doesn't reflect field name changes
-   \[SRJIRA-3381\] - Original estimate field not working on behaviour
-   \[SRJIRA-3409\] - Group Picker Fields can still be set when set to read only by behaviours
-   \[SRJIRA-3411\] - Behaviours setRequired() doesnt work on Time Tracking fields
-   \[SRJIRA-3422\] - Send Custom Email Listener includes non listener events
-   \[SRJIRA-3451\] - Create Constrained Issue - Menu item no longer opens in a modal window in Jira 8

## 5.5.3

-   Released 09 April 2019.

**Bug Fixes**

-   \[SRJIRA-3119\] - A bug preventing behaviours from altering **Issue Picker** field JQL filters has been fixed.
-   \[SRJIRA-3365\] - Missing events from the **Listeners Event** drop-down field have been restored.

## 5.5.2

-   Released 02 April 2019.

**New Features**

**New Browse Experience Helping you Discover Features Within ScriptRunne**r

-   Easy for users to search scripts by keyword.
    
-   New tagging system to quickly identify solutions
    
-   Comes as standalone page and as part of any configured Items creation flow
    

**Jira Agile Functions Can Now be Used in Boards**

SRJIRA-2350 has been fixed, which means you can use JQL functions like `addedAfterSprintStart` to define card colors and swimlane queries.

**Bug Fixes**

-   \[SRJIRA-2168\] - Can't use behaviours with issue picker in behaviours select list conversion field
-   \[SRJIRA-2636\] - JSD Behaviours - Behaviour lost after server validation fail
-   \[SRJIRA-2690\] - Send a custom email listener doesn't work for non-issue events
-   \[SRJIRA-3141\] - "Send Custom Email" Canned script getWorkflowButtons.call method fails to get workflow buttons if defined at the Create transition stage
-   \[SRJIRA-3229\] - EditableScriptFieldTrait tries to fetch script configurations by field config ID rather than field config scheme ID
-   \[SRJIRA-3295\] - Behaviour mapping REST endpoint doesn't validate the input
-   \[SRJIRA-3302\] - Automation for Jira integration - run action regardless of whether an issue is provided
-   \[SRJIRA-3325\] - setFormValue() doesn't work on cascade select in JSD
-   \[SRJIRA-3348\] - Using the Remove from Sprint function throws error when board is not selected
-   \[SRJIRA-3353\] - Automation for Jira Integration broken in Jira 8
-   \[SRJIRA-3362\] - Script Console - Full screen mode doesn't show error message
-   \[SRJIRA-3364\] - Clicking "Save" on a behaviour config will add "null" in the UI if no description added
-   \[SRJIRA-3373\] - Missing Binding variable in Simple scripted validator
-   \[SRJIRA-3394\] - @RunWith(ScriptRunnerTestRunner) no longer uses baseurl system property so users cannot change default port/baseurl
-   \[SRJIRA-3398\] - addMapping redirect can cause crash if behaviour not present

## 5.5.0

-   Released 06 March 2019.

**Code Insight**

This release includes our first version of _code insight_, a set of features designed to increase productivity, discovery, and enjoyment, when writing code in ScriptRunner.

This consists of code completions, parameter lookups, and javadoc links (javadoc links currently for Jira only).

![The Condition field, with an example autocompletion.](/sr4js/files/latest/101624452/101628602/1/1602076863000/completion-on-issues.png)

Take a look at the [documentation](https://docs.adaptavist.com/sr4js/latest/best-practices/write-code/code-editor) for more information.

**Bug Fixes**

-   \[SRJIRA-3140\] - 'Send Custom Email' canned script getWorkflowButtons.call closure returns incorrect workflow id for the Workflow Button
-   \[SRJIRA-3292\] - Behaviour's description cleared upon saving
-   \[SRJIRA-587\] - Use of 'Script Runner' under Administration should be restricted to Jira System Administrators permission
-   \[SRJIRA-3225\] - 'Show parent issue...' scripted field isn't indexed at time of child issue creation

## 5.4.49

-   Released 13 Feb 2019.

**New Features**

**Edit Scripts Permission and Settings Page**

Now you are able to configure which groups with _Jira Administrator_ permissions can create or edit _ScriptRunner_ scripts. See [documentation](https://docs.adaptavist.com/sr4js/latest/get-started/settings).

**Bug Fixes**

-   \[SRJIRA-2976\] - No compile context for UpdateBlockedIssues in registry
-   \[SRJIRA-3089\] - ScriptRunner IntelliJ Plugin does not provide link to accept SSL certificate as shown in guide
-   \[SRJIRA-3294\] - Default descriptions with Behaviours do not work in version 5.4.48

## 5.4.48

-   Released 30 Jan 2019.

**History of Execution Times and Failures Rates**

Previously, for each script, we have displayed information about the previous fifteen executions. This includes how long it took, the payload, and whether it failed or not.

This can be useful but doesn’t give you a long-term trend analysis - for example, is this gradually slowing down, perhaps as it processes more data? Has a recent change to the script caused it to slow down (or speed up)?

![Example History of Execution Times and Failure Rate data.](/sr4js/files/latest/101624452/101628607/1/1602076863000/rrd-execution-history.png)

With this release we show execution speed and failure rates going back up to two years. Initially there will be no data available, but over time this should become a valuable resource.

**Inclusion of Canned Comments Plugin**

This release sees the inclusion of [Template Comments for Jira Service Desk](https://docs.adaptavist.com/sr4js/latest/features/built-in-scripts/template-comments-service-management) in ScriptRunner for Jira. This will enable us to better keep it up to date. By default this is disabled, as since it was introduced Service Desk provides a different method of achieving a similar thing. On installing this upgrade, if you have the _Template Comments_ app installed, it will automatically be uninstalled…​ the functionality is the same so you should not notice any difference.

See [the documentation](https://docs.adaptavist.com/sr4js/latest/features/built-in-scripts/template-comments-service-management) for more information.

**Important:** There is a known issue that the resources are not correctly enabled if you had previously installed the Template Comments plugin. This is the issue: SRJIRA-3263. To work around this go to Built-in Scripts → Service Desk template comments, then click Disable, then Enable.

**Bug Fixes**

-   \[SRJIRA-2944\] - Copy Project script does not copy the field names of customer request types
-   \[SRJIRA-2993\] - Can't delete Behaviour mapping with a null Issue Type

## 5.4.47

-   Released 16 Jan 2019.

**Bug Fixes**

Fixed issue with upgrading that causes missing scripts.

-   \[SRJIRA-3002\] - Empty message dialogs using Script Runner together with Secure Login
-   \[SRJIRA-3092\] - ScriptRunner IntelliJ Plugin shows http 500 error if user has not entered text into script console first

## 5.4.45

-   Released 18 Dec 2018.

**Change to Behaviours' getValue() Output on Linked Issues Field**

**Prior Behaviour**

There was some inconsistency in the object type which getValue() returned when called on the Linked Issues field (i.e. `getFieldById("issuelinks-issues")`).

![The Issue field is highlighted in an example configuration.](/sr4js/files/latest/101624452/101628605/1/1602076863000/linked-issues-field.png)

-   If the field contains no issues: `""`
    
-   If the field contains one issue: `"ISSUE_KEY"`
    
-   If the field contains multiple issues: `[FIRST_ISSUE_KEY, SECOND_ISSUE_KEY, etc.]`
    

Notice the differences in the object types. Two are strings, one is an array.

**New Behaviour**

As of this release, getValue() will always return an array for the Linked Issues field. This new behaviour is documented in the Behaviours [API Quick Reference](https://docs.adaptavist.com/sr4js/latest/features/behaviours/api-quick-reference).

We are aware that this change will break backwards compatibility for some users. Take a look at the new outputs below to see what adjustments you need to make to your scripts.

-   If the field contains no issues: `[]`
    
-   If the field contains one issue: `[ISSUE_KEY]`
    
-   If the field contains multiple issues: `[FIRST_ISSUE_KEY, SECOND_ISSUE_KEY, etc.]`
    

**Bug Fixes**

-   \[SRJIRA-2393\] - Clearing cache event, even once, creates performance issues for Change Shared Entity Owner script
-   \[SRJIRA-2900\] - Behaviours getValue() on Linked Issues field not returning consistent object type
-   \[SRJIRA-2966\] - Create issue in new tab fails to create issue if behavior takes too long
-   \[SRJIRA-2968\] - Autocomplete for script file paths repositions certain numerical prefixes
-   \[SRJIRA-2991\] - Cannot disable post function on Create step
-   \[SRJIRA-3003\] - dateCompare can produce an HTTP 400 (Bad Request) with error jqlTooComplex
-   \[SRJIRA-3124\] - Accessing undefined this.\_input element on Firefox v52 and v60
-   \[SRJIRA-2979\] - Group and multi-group scripted fields

## 5.4.43

-   Released 22 Nov 2018.

**Bug Fixes**

-   Fixed issue with upgrading that causes missing scripts.
-   This release also contains other bug fixes.

## 5.4.42

-   Released 22 Nov 2018.

**Bug Fixes**

-   \[SRJIRA-2911\] - Clone Issue throws MissingMethodException because of classloader issues
-   \[SRJIRA-3102\] - Issue Picker field - does not allow JQL to return subtasks
-   \[SRJIRA-2924\] - Behaviour set in an initializer fails after a server side validation failure
-   \[SRJIRA-2949\] - Behaviours timer for checking certain fields is never stopped
-   \[SRJIRA-2987\] - Script Registry is unable to resolve classes located in script roots directory
-   \[SRJIRA-3074\] - Renaming a user prevents user picker field from being set with behaviours in JSD portal
-   \[SRJIRA-3084\] - Conditional Behaviours Don???t Work Correctly When Switching Users

## 5.4.40

-   Released 13 Nov 2018.

**Bug Fixes**

-   \[SRJIRA-3094\] - Clone Issue and Create Subtasks breaks when custom field has no context

## 5.4.39

-   Released 08 Nov 2018. 

**New Features**

**Restrict Available Issue Types**

You can now use _Behaviours_ to [restrict which issue types are available](https://docs.adaptavist.com/sr4js/latest/features/behaviours/behaviours-examples/restricting-issue-types) to different categories of users. This could be based on group or role membership for instance, and could be used to prevent for example, users in the _Customers_ role creating **Bug** tickets, and restrict them only to **Support Request** issue type.

**Add to Agile Board Context Menu**

You can now [add items to the context menu](https://docs.adaptavist.com/sr4js/latest/features/fragments/board-context-menu-item) when you right-click on issue or issues in the planning or sprint boards. As with other web items you have the option of calling a REST endpoint which can cause a flag or dialog to be displayed (or have no visible output), or linking to another page. You can also add commonly-used actions that are available through the _"dot"_ menu to the context menu, for example _Create sub-task_, _Clone issue_, and so on.

  

**Bug Fixes**

-   Fixed regression when editing code which caused the UI to crash.

## 5.4.38

-   Released 08 Nov 2018.

**Bug Fixes**

-   \[SRJIRA-3013\] - Jira agile context menu option for web items
-   \[SRJIRA-1010\] - Cannot customize proposed issue types using behaviours
-   \[SRJIRA-2375\] - Expression JQL function doesn't work with user-picker custom fields
-   \[SRJIRA-2734\] - Behaviour description is cleared after clicking the Advanced Edit operation
-   \[SRJIRA-2954\] - Setting readonly on a single user select field on Service Desk makes the field look hidden in the portal view
-   \[SRJIRA-3006\] - 'Change dashboard or filter ownership' conflates user names and user keys
-   \[SRJIRA-3069\] - Behaviours group condition doesn't check for anon users
-   \[SRJIRA-3076\] - WorkflowUtils.updateIssue says "transition" in its error message rather than "update"
-   \[SRJIRA-3077\] - File attached with the ON predicate can produce incorrect results
-   \[SRJIRA-1046\] - Disable Jira's dirty form checking for fields that have been set through behaviour setValue

## 5.4.34

-   Released 24 Oct 2018.

**Script JQL Functions are now Singletons**

If you only use the JQL functions included in ScriptRunner this won’t affect you, but if you have written your own, please read on.

We have fixed a couple of race conditions in JQL functions that may have caused problems under **extreme** load. JQL function classes are now only instantiated once. This may cause a problem if you have written your function class to have state, e.g. shared fields that are written from the `validate` method and read from the `getQuery` method. In the unlikely event this is the case, please refactor your JQL function.

**Version Synchronizer Delete Behaviour Modified for Deleting and Swapping to Missing Versions**

When a version is deleted, you can specify the actions to be taken for issues associated with the version to be deleted. One of the options is to associate these issues with another version. A new option has been added to control the propagation of these events with the Version Synchronizer:

Previously, on a Version Deleted event, if there was a version in the swap that was not present in the source project, the version in the destination project would be deleted, and there was no control over that functionality. That could potentially lead to an unintended loss of information, imagine the following scenario:

Project A has versions 1 and 2, and Project B has version 1, but it does not have version 2.

The Version Synchronizer event listener is active with source project A and destination project B.

If a delete version event is called in project A, and in that event, it is specified that version 1 is to be deleted and swapped with version 2, that would work in project A because both versions exist. However, when that event is propagated through the Version Sync Listener to project B, it would delete version 1, and it wouldn't swap to version 2, because version 2 does not exist.

That could lead to a loss of information in project B.

In order to prevent this loss of information, the default behaviour has been modified to copy the version to the target project if it is not contained in that project. In the previous scenario, the new Version Synchronizer would realize the version that the user wants to swap to is missing in the target project, and it would create it there. That way the swap can be completed successfully and there is no information lost.

**Bug Fixes**

-   \[SRJIRA-2377\] - Default custom field values not set in sub-task created by 'Create Sub-task' post-function
-   \[SRJIRA-2788\] - Issue type field does not respond to setFormValue or setRequired (etc) in Behaviours
-   \[SRJIRA-2810\] - Behaviours setRequired considers "None" as a valid selection for select lists in JSD??portal
-   \[SRJIRA-2916\] - Return full datetime when outputting scripted fields to JSON
-   \[SRJIRA-2935\] - Mapping behaviour to specific SD without selecting request types doesn't show an error
-   \[SRJIRA-2947\] - Memory Issues with IssueFunction in dateCompare("", "resolutionDate < dueDate") with high load
-   \[SRJIRA-2887\] - Combined postfunction/listener send message to Slack Stride or Hipchat
-   \[SRJIRA-2973\] - More Advanced Handling for Version Synchronizer Deletion
-   \[SRJIRA-2933\] - ScriptRunner IntelliJ plugin compatibility with 2018.2

## 5.4.30

-   Released 24 Sep 2018.

**Bug Fixes**

-   \[SRPLAT-77\] - Race condition when using WithPlugin
-   \[SRJIRA-2667\] - JSD Behaviours do not work with Select List Conversions
-   \[SRJIRA-2923\] - 'Attachments' not available as option for 'Fields to Copy"

## 5.4.28

**New Features**

**Issue and Remote Issue Pickers**

Previously you could convert text fields to issue pickers…​ the problem with this is that the "view issue" renderer had room for improvement, and that when using the API you were returned plain text strings. With this release we are introducing proper [local](https://docs.adaptavist.com/sr4js/latest/features/script-fields/built-in-script-fields/issue-picker) and [remote](https://docs.adaptavist.com/sr4js/latest/features/script-fields/built-in-script-fields/remote-issue-picker) issue pickers, with full Behaviours support.

**Commented and lastComment Visibility Predicate**

Commented and LastComment now support searching on JSD comment visibility. You will need to reindex Jira in order to use this. See the [documentation](https://docs.adaptavist.com/sr4js/latest/features/jql-functions).

**New option to prevent impersonation of Jira System Administrators**

Admin users have not been able to switch to a system admin for a long while, now we have added an option to prevent Systems Administrators from impersonating other System Admins. This feature is optional, and you can find out how to enable it in the [Switch User Documentation Page](https://docs.adaptavist.com/sr4js/latest/features/built-in-scripts)

**Workflow Transition Buttons**

As part of the Send Mail built-in script, the email template field now includes getWorkflowButtons in its binding. This _closure_ is called using `getWorkflowButtons.call()` and adds a button to the email body for every valid transition given the issue’s current state. Example output:

**Bug Fixes**

-   \[SRJIRA-2906\] - Show numerical IDs next to workflow actions when editing a behaviour condition
-   \[SRJIRA-2414\] - Script Listeners Don't Show New Events
-   \[SRJIRA-2738\] - Behaviours don't preset or lock issue type field
-   \[SRJIRA-2809\] - Calling setRequired() on a RadioButton or CheckBox in SD portal doesn't remove (optional) text from UI
-   \[SRJIRA-2937\] - Rich text fields bypass read-only setting when changing edit modes/settings
-   \[SRJIRA-2981\] - Previous Status condition: Immediately Previous setting cannot be disabled once enabled
-   \[SRJIRA-2668\] - Add a Script Fields Template for Dates without timestamps
-   \[SRJIRA-2928\] - Provide an analogue to 'approval.buttons' in the custom email bindings
-   \[SRJIRA-2948\] - Optionally prevent System Administrators impersonating other System Administrators.
-   \[SRJIRA-2579\] - Script Registry Improvements/Fixes

## 5.4.27

-   Released 24 Sep 2018.

**Bug Fixes**

-   \[SRJIRA-2132\] - Filter by Jira Service Desk comment visibility using lastComment and commented JQL functions
-   \[SRJIRA-2718\] - Copy custom field values built-in sets wrong options with lossy field conversions
-   \[SRJIRA-2789\] - History Results in Escalation Services
-   \[SRJIRA-2807\] - ScriptRunner IDEA Integration 2018.1 compatibility
-   \[SRJIRA-2817\] - Listeners fail after project key change
-   \[SRJIRA-2818\] - Parent Issue Script Field does not display value through rest API
-   \[SRJIRA-2871\] - View in issue navigator does not work in the Kanban backlog
-   \[SRJIRA-2885\] - Behaviour doesn't run when clearing Epic Link field
-   \[SRJIRA-2888\] - hideTab(String) hides the wrong tab if an earlier tab has been hidden by Jira itself
-   \[SRJIRA-2889\] - AbstractEntityMatch doesn't respect permissions overrides
-   \[SRJIRA-2905\] - Send Email on Transition sends to inactive accounts
-   \[SRJIRA-2922\] - If no issue type avatar or default avatar - behaviours admin break
-   \[SRJIRA-1921\] - Display note on scripted post-functions to distinguish them more easily
-   \[SRJIRA-2543\] - Create Subtasks: Include option "none" in fields to copy
-   \[SRJIRA-2545\] - Add support for CommentLevel to the setFieldOptions method in Behaviours
-   \[SRJIRA-2870\] - setLabel() and setDescription() doesn't work on checkbox/radio button in customer portal
-   \[SRJIRA-2836\] - formField.setDescription() doesn't work on Issue Type field
-   \[SRJIRA-2809\] - Calling setRequired() on a RadioButton or CheckBox in SD portal doesn't remove (optional) text from UI
-   \[SRJIRA-2932\] - Use JQL input field component in scripts

## 5.4.12

**Bug Fixes**

-   \[SRJIRA-2903\] - Custom Web section is missing

## 5.4.11

-   Released 25 June 2018.

**Bug Fixes**

-   \[SRJIRA-2582\] - Execution Information Doesn't Get Updated Correctly
-   \[SRJIRA-2678\] - Cannot cast com.onresolve.scriptrunner.canned.jira.utils.ConditionCustomScriptDelegate to com.onresolve.scriptrunner.canned.jira.utils.CustomScriptDelegate
-   \[SRJIRA-2849\] - ON server validation setForm does not work s expected
-   \[SRJIRA-2852\] - addedAfterSprintStart returns only non-done issues when sprint is closed
-   \[SRJIRA-2863\] - Script registry throws NPE if you have unscripted web fragments
-   \[SRJIRA-2868\] - ScriptRunner broken in Automation
-   \[SRJIRA-2872\] - completeInSprint JQL Function Returns Incorrect Values
-   \[SRJIRA-2875\] - Previewing the Script Registry produces a JS error
-   \[SRJIRA-2877\] - Field becomes read-only when created on top of area where that field is read-only

## 5.4.7

-   Released 31 May 2018.
-   Compatible with Jira 7.10.x

**Bug Fixes**

-   \[SRPLAT-266\] - Builtin scripts documentation broken codeboxes for AfterCreateActions
-   \[SRJIRA-2829\] - ScriptRunner compatible with Jira 7.10.0 and SD 3.13.0
-   \[SRJIRA-2733\] - Behaviours do not load on SD support portal for some users
-   \[SRJIRA-2707\] - Add Distinguishing Features Between Field Behaviours

## 5.4.0

-   Released 21 May 2018.

**User interface rewrite**

The administration user interface has been rewritten to provide a better and faster for enterprise-scale clients. The appearance is similar to the existing UI, but the rewrite gives us a base to add new features.

If you experience any problems please contact us through our [Jira support desk](https://productsupport.adaptavist.com/servicedesk/customer/portal/2).

Currently we are targeting this release only at Jira 7.9, over the next days we will make it available to earlier Jira versions.

**Bug Fixes**

-   \[SRJIRA-2432\] - Send custom email listener takes long time to load when user have thousands of groups.
-   \[SRJIRA-2547\] - Inline Edit Behaviours javascript is sending excessive requests to validators.json
-   \[SRJIRA-2564\] - Script fields break when the field has multiple configured contexts
-   \[SRJIRA-2692\] - Cannot Map JSD Behaviours to All projects and All Request Types
-   \[SRJIRA-2773\] - nextSprint JQL function only returns sprint if it is owned by the board provided as argument
-   \[SRJIRA-2787\] - Dependency Problems with parent pom
-   \[SRJIRA-2792\] - Script Registry workflow function link 404s for global transitions
-   \[SRJIRA-2796\] - Onboarding tooltips don't show up, leaving screens like the Script Console dark
-   \[SRJIRA-2799\] - Cannot highlight/select text if behaviour active on field
-   \[SRJIRA-2812\] - SR Behaviours failed to parse JSON
-   \[SRJIRA-2795\] - Jira 7.9.0 and Service Desk 3.12.0 Compatibility
-   \[SRPLAT-263\] - Copy button on code snippets in doc appears not to work anymore
-   \[SRPLAT-184\] - Disable configured items individually
-   \[SRPLAT-7\] - Document slow mode maven settings for script plugin developers

## 5.3.26

-   Released 01 May 2018.

**Updates**

This update fixes a serious security vulnerability in ScriptRunner for Jira discovered during an internal review. We strongly recommend all customers apply this update at their earliest opportunity. Further details will be released in the coming weeks as part of Adaptavist’s responsible disclosure approach.

All versions of ScriptRunner for Jira from 4.0.0 are affected. Below are instructions on which version we recommend you upgrade to:

-   If you have **Jira 7.2 or above**, upgrade to **5.3.26**
    
-   If you have **Jira 7.0 or 7.1**, upgrade to **5.1.6.2**
    
-   If you have **Jira 6.4**, upgrade to **4.1.3.29**
    
-   If you have **Jira 6.3.10 to Jira 6.3.15** inclusive, upgrade to **4.1.3.28**
    
-   If you have **Jira 6.3.0 to 6.3.9** inclusive, upgrade to **4.1.3.27**
    

## 5.3.16

-   Released 20 April 2018.

**Bug Fixes**

-   \[SRJIRA-2811\] - Removed dialog2 dependency makes some Jira screens inaccessible

## 5.3.13

-   Released 16 April 2018. 
-   Compatible with Jira 7.9.x

**Bug Fixes**

-   \[SRJIRA-2797\] - ScriptRunner compatible with Jira 7.9.0 and SD 3.12.0
-   \[SRJIRA-2538\] - AddedAfterSprintStarts exception with filter subscription
-   \[SRJIRA-2670\] - Running post-functions as a renamed user throws exception
-   \[SRJIRA-2753\] - addedAfterSprintStart uses http context
-   \[SRJIRA-2754\] - Exclude post function conditions from audit logging to stop swamping the audit log
-   \[SRJIRA-2786\] - Remove audit logging from script field

## 5.3.9

-   Released 16 March 2018.

**New Features**

**ScriptRunner audit Logging Service** 

As a Jira administrator you can now inspect script configuration changes from Jira audit. For more information check [_Audit Logging_](https://docs.adaptavist.com/sr4js/latest/best-practices/logging/audit-logging).

**Test Management for Jira Integration**

As a Jira administrator you can now run ScriptRunner scripts that interact with Test Management for Jira. For more information check [_Test Management for Jira_](https://docs.adaptavist.com/sr4js/latest/integrations/other-apps/zephyr).

**Bug Fixes**

-   \[SRPLAT-261\] - ScriptRunner custom REST endpoints in Data Center only setup on one node
-   \[SRPLAT-24\] - Log built in scripts actions
-   \[SRJIRA-2739\] - Change name of "Execute a ScriptRunner script" module
-   \[SRJIRA-2606\] - Package required for built-in scripts is wrong in docs
-   \[SRJIRA-2607\] - Copy Project errors when deleted user is member of project role
-   \[SRJIRA-2674\] - ScriptRunner Version synchroniser
-   \[SRJIRA-2693\] - Reporter field is not copied via the "Clone an issue, and links" listener
-   \[SRJIRA-2705\] - Display error when first creating a Scripted Field with Custom Template
-   \[SRJIRA-2708\] - Custom REST Endpoint : trows NullPointerException with DELETE method
-   \[SRJIRA-2721\] - More clarification in the UI/docs about the one behaviour per-field rule
-   \[SRJIRA-2723\] - Fix broken example on Service Desk blog
-   \[SRJIRA-2727\] - Canned responses in transition window missing
-   \[SRJIRA-2732\] - Behaviours: cannot ctrl-click range select mappings anymore
-   \[SRJIRA-2545\] - Add support for CommentLevel to the setFieldOptions method in Behaviours
-   \[SRJIRA-2706\] - Documentation on maintaining/creating dashboards and gadgets
-   \[SRJIRA-2671\] - TM4J and SR integration examples documentation

## 5.3.7

-   Released 22 Feb 2018.
-   Compatible with Jira 7.8.x

**Updates**

**Sample Code for Creating Dashboards**

Enterprise Jira users often need to automatically generate dashboards with gadgets, to provide a consistent management-level overview of progress. Check out our code samples to create configured dashboards in response to project or version creation etc.

**Bug Fixes**

-   \[SRJIRA-2606\] - Package required for built-in scripts is wrong in docs
-   \[SRJIRA-2706\] - documentation on maintaining/creating dashboards and gadgets

## 5.3.6

-   Released 19 Feb 2018.

**Bug Fixes**

-   \[SRJIRA-2676\] - Script Fragments for web items were executing twice.
-   \[SRJIRA-2683\] - Stop older versions of Jira Service Desk from running incompatible features.
-   \[SRJIRA-2684\] - Fix Behaviours use of guide workflows containing special characters like /, \\, #, or %.
-   \[SRJIRA-2685\] - Fix Behaviours handling of radio buttons for Internet Explorer.

## 5.3.5

-   Released 14 Feb 2018.

**Bug Fixes**

-   \[SRJIRA-2593\] - Behaviour: Server side script does not set form value if there is a Jira validation error in form
-   \[SRJIRA-2657\] - Behaviour does not hide nFeed fields.
-   \[SRJIRA-2658\] - Behaviour : Setting form value for radio button is not working
-   \[SRJIRA-2660\] - Behaviours mapping screen fails if JSD is enabled but unlicensed
-   \[SRJIRA-2661\] - Diagnostic failure from rest endpoint when content ~ 10M
-   \[SRJIRA-2663\] - Behaviours on Cascading Select List Blocks Issue Creation
-   \[SRJIRA-2675\] - Cascading Select List object only corresponds to first selection
-   \[SRPLAT-259\] - JSD error in logs for other products
-   \[SRPLAT-260\] - Enabling fragment locator displays error in UI on every page when hovering over locations

## 5.3.1

-   Released 31 Jan 2018.

5.3.1 addresses issues that arose in 5.3.0 with ScriptRunner and integrations with other Atlassian apps that modify the front-end infrastructure. This release should address these issues, and allow for seamless app compatibility.

We apologize for any inconvenience this might have caused, and thank the ScriptRunner community for their feedback and patience while we resolved this issue.

**Bug Fixes**

-   \[SRJIRA-2638\] - Duplicated Escalation services after upgrade to 5.3.0
-   \[SRJIRA-2639\] - plugin interaction issues due to multiple includes of polypill

## 5.3.0

-   Released 31 Jan 2018.

**New Features**

**Conditions and additional issue actions script file**

You can now put your conditions and additional issue actions in a script file.

**Potentially breaking changes**

When ScriptRunner is installed the old inline scripts will be converted to support the new schema. This only becomes a problem if you downgrade to a previous ScriptRunner release.

If you do downgrade you should run the following script in `Admin → Script Console`, before downgrading.

This will only put the current inline script code back. Therefore if you’ve updated the condition or additional issue actions code to use a script file after upgrading then this won’t be preserved when downgrading. You’ll have to manually reenter the code after downgrading. Therefore we recommend you keep the relevant script files under your script root so you can refer back to them.

```
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.util.json.JSONObject
import com.onresolve.scriptrunner.canned.jira.admin.EscalationService
import com.onresolve.scriptrunner.canned.jira.utils.ConditionUtils
import com.onresolve.scriptrunner.runner.ListenerManager
import com.onresolve.scriptrunner.runner.ListenerManagerImpl

import com.onresolve.scriptrunner.runner.ScriptRunnerImpl
import com.onresolve.scriptrunner.runner.util.OSPropertyPersister
import com.opensymphony.workflow.loader.ConditionDescriptor
import com.opensymphony.workflow.loader.FunctionDescriptor
import com.opensymphony.workflow.loader.ValidatorDescriptor

import java.util.regex.Pattern

// convert listeners
def listenerManager = ScriptRunnerImpl.getPluginComponent(ListenerManager)

def listeners = OSPropertyPersister.loadList(ListenerManagerImpl.CONFIG_LISTENERS) as List<Map>

listeners.each { listener ->
    convertScript(listener, ConditionUtils.FIELD_CONDITION)
    convertScript(listener, ConditionUtils.FIELD_ADDITIONAL_SCRIPT)
}

OSPropertyPersister.save(listeners, ListenerManagerImpl.CONFIG_LISTENERS)

listenerManager.refresh()

// convert escalation service
def escalationService = new EscalationService()
def escalationServiceConfig = escalationService.getConfig()

escalationServiceConfig["rows"].each { service ->
    convertScript(service, ConditionUtils.FIELD_ADDITIONAL_SCRIPT)
}

escalationService.saveConfig(new JSONObject(escalationServiceConfig))

// convert workflow functions
def workflowManager = ComponentAccessor.getWorkflowManager()
def user = ComponentAccessor.getJiraAuthenticationContext().getLoggedInUser()

String BASE_64_CANARY = "`!`"
String BASE_64_REGEX = Pattern.compile('^([A-Za-z0-9+/]{4})*([A-Za-z0-9+/]{4}|[A-Za-z0-9+/]{3}=|[A-Za-z0-9+/]{2}==)

**Behaviours for Jira Service Desk**

You can now apply _behaviours_ to the customer portal. Things like help text, requiredness etc, follow the normal Service Desk theme.

**Potentially breaking changes**

Behaviours have been fixed so that when getting the value for a priority, it correctly returns a `Priority` object.

For example, so now you can correctly do:

* * *

```
getFieldById("priority").value?.name == "Highest"
```

* * *

If previously you were comparing the string value, for instance:

* * *

```
getFieldById("priority").value == "1"
```

* * *

you can either replace with code like the above, or change `.value` to `.formValue`.

**Hide or disable tabs on Jira issue screens**

You can now hide or disable entire tabs with Behaviours. You might wish to do this to prevent a category of field attributes being edited at certain stages of the workflow, or by certain groups or roles.

**Set Allowed Options for Radio and Checkbox Fields**

You can now use `setFieldOptions` to restrict the available options for radio and checkbox custom fields, in exactly the same way as with [select and multiselect fields](https://docs.adaptavist.com/sr4js/latest/features/behaviours/behaviours-examples/restricting-priority-and-resolution).

**Script Search Within Script File Input**

You now have the ability to search for scripts contained within your configured script roots inside ScriptRunner. Wherever you used to be able to paste the path of a script, you can now search for the script directly in the file input. Simply start typing the name of your script and the search will present suggestions that you can select!

**Execute Script Action in Automation for Jira**

We now provide an action allowing you to run your own script, in Automation for Jira. [More](https://docs.adaptavist.com/sr4js/latest/integrations/automation-for-jira).

Please restart your system after installing the update if you intend to use this integration, otherwise you may get an error when saving the rule. We are investigating why this may happen.

**Compatibility with Jira 7.7 and Jira Service Desk 3.10.0**

Compatibility with latest Jira release.

**Potential XSS Issues Fixed**

Insufficient escaping may have allowed a vulnerability via XSS. However we judge the severity of this vulnerability as "low" as it would require a specific sequence of actions by an administrator.

**Bug fixes**

-   \[SRJIRA-44\] - Behaviours: A read-only Version field can be emptied using delete key
-   \[SRJIRA-77\] - Required fields are not displayed when scrolling
-   \[SRJIRA-643\] - Field not consistently read-only with inline editing
-   \[SRJIRA-689\] - The Cascading select list first value equal to example wrong
-   \[SRJIRA-791\] - Behaviour didn't work for transitions (like in the past)
-   \[SRJIRA-869\] - Script Registry logs ERROR and Exception for validators
-   \[SRJIRA-877\] - Syntax check in Script Registry shows mangled script and errors
-   \[SRJIRA-1325\] - Adding a behaviour to the Due Date field does not disable inline editing
-   \[SRJIRA-2142\] - Behaviours ignores multi user picker custom field
-   \[SRJIRA-2186\] - LastComment function throws an error if there are no comments
-   \[SRJIRA-2204\] - Cannot use Behaviours on Original Estimate and other time tracking fields
-   \[SRJIRA-2205\] - Jira comment behaviours broken in Issue View Screen
-   \[SRJIRA-2212\] - Behaviours sometimes don't work for full screen create/edit issue dialogs
-   \[SRJIRA-2229\] - Inconsistent setError in Behaviours
-   \[SRJIRA-2257\] - Escalation Service Throws an Exception
-   \[SRJIRA-2320\] - Setting Comment field to "required" via Behaviors results in an inconsistent red asterisk
-   \[SRJIRA-2341\] - Setting linked issues field as not required in behaviours does not unmark the field as required
-   \[SRJIRA-2344\] - Link does not create on issue for Confluence Pages
-   \[SRJIRA-2345\] - No red asterisks shown after enabling the Validator Plugin (JSU) in Behaviours on the Create issue screen
-   \[SRJIRA-2354\] - Behaviours set Description added multiple times
-   \[SRJIRA-2355\] - Behaviour on Component/s field result in an Uncaught TypeError when set to required and the project has no components
-   \[SRJIRA-2396\] - <script> tag causes the script registry to not load
-   \[SRJIRA-2399\] - Copy Project script fails to copy users and roles
-   \[SRJIRA-2416\] - Behaviours do not return the value of the Sprint field as expected
-   \[SRJIRA-2423\] - Behaviour Mapping Setup shows duplicate Sub-task issue types
-   \[SRJIRA-2447\] - Setting up a Dev Environment instructions don't work for latest SR Version
-   \[SRJIRA-2452\] - On transition screens fix version/s red asterisk persists when set to not required via Behaviour
-   \[SRJIRA-2456\] - Behaviours: Setting the Assignee field as required does not work
-   \[SRJIRA-2531\] - Links are broken in Script Information dialog
-   \[SRJIRA-2540\] - IE11issues caused by use of includes
-   \[SRJIRA-2544\] - In FieldBehaviours class there is typo which throws exception.
-   \[SRJIRA-2559\] - Fix location and structure of help text
-   \[SRJIRA-2569\] - ProjectRole\* events are not listed in Script Listener Event list
-   \[SRJIRA-2577\] - If a behaviour is configured - Script registry fails
-   \[SRJIRA-2581\] - Test Runner Removes Configured Scripted Fields and Listeners
-   \[SRJIRA-2583\] - Behaviours editing GUI rewrite
-   \[SRJIRA-2584\] - codemirror linting broken
-   \[SRJIRA-2585\] - Builds infrastructure improvements
-   \[SRJIRA-2597\] - Can't have a behaviour on issue type anymore
-   \[SRJIRA-2605\] - Behaviours documentation is wrong due to .getValue change
-   \[SRJIRA-1319\] - Add current http request to behaviours script bindings
-   \[SRJIRA-1385\] - Ability to hide/show entire tabs
-   \[SRJIRA-2207\] - Add an expandable example showing how to change the default FROM email address
-   \[SRJIRA-2258\] - hasRemoteLinks JQL function
-   \[SRJIRA-2353\] - Lock the issueFunction custom field
-   \[SRJIRA-2387\] - Behaviours: Extend use of the setFieldOptions function to other field types
-   \[SRJIRA-2546\] - Implement helping pop-up for JSD Fragments
-   \[SRJIRA-2557\] - Ability to set change the name of the field via Behaviours
-   \[SRJIRA-2315\] - Implement Web Fragments for JSD
-   \[SRJIRA-2319\] - As an Administrator, I need the Send Customer Email script to automatically send emails to Approvers and members of Organizations to keep everyone informed of activities in ServiceDesk
-   \[SRJIRA-2402\] - As a Jira Administrator, I need to be able to load Conditions and Validators from source files so my whole ScritpRunner customization can be code reviewed and deployed to a file system
-   \[SRJIRA-2429\] - Provide an interface for selecting which script file to apply to any given automation, rather than writing out the file by name
-   \[SRJIRA-2103\] - Behaviours API does not expose getConfigsFor()
-   \[SRJIRA-2382\] - Midori Better Excel Docs Example
-   \[SRJIRA-2519\] - User Guide - Scripted Fields and Displaying links
-   \[SRJIRA-2596\] - Update Build Plan to include 7.7
-   \[SRJIRA-2598\] - Compatibility with Jira 7.7.0 & SD 3.10.0
-   \[SRPLAT-249\] - Built In Scripts Not Ordered and naming inconsistency
-   \[SRPLAT-127\] - Separate log file for ScriptRunner logging

## 5.2.2

-   Released 21 Nov 2017.
-   ScriptRunner is now compatible with Jira 7.6.0 and Service Desk 3.9.0.

**Bug Fixes**

-   \[SRJIRA-2548\] - Compatibility with Jira 7.6.0 & SD 3.9.0

For _how-to_ questions please ask on [Atlassian Answers](https://answers.atlassian.com/).

## 5.2.1

-   Released 02 Nov 2017.

**New Features**

**Script Listeners - New Jira Service Desk and Jira Software Events**

[Script Listeners](https://docs.adaptavist.com/display/SR4JS/.Listeners+v6.19.0) are powerful tools that let you react automatically to specific actions in Jira. We have updated Script Listeners to include Jira Service Desk, Jira Software, and other events.

We have added more than 40 new events to Script Listeners, including Sprint started/completed, Agile Boards created/updated, and even SLA-specific events like Thresholds Exceeded.

**Copy Project for Jira Service Desk and Bulk Update SLAs**

ScriptRunner for Jira now makes administering Jira Service Desk even easier with updates to our [Copy Project](https://docs.adaptavist.com/display/SR4JS/.Built-In+Scripts+v6.20.0) built-in script, as well a new [Bulk Copy SLAs](https://docs.adaptavist.com/display/SR4JS/.Built-In+Scripts+v6.20.0) built-in script.

**New User Guides for Jira Service Desk and SmartDraw**

We are very happy to share best practices guides for how ScriptRunner for Jira can help your Service, Support, and Operations teams. We provided clear examples for you to automatically [_create a Root Cause Analysis document_](https://docs.adaptavist.com/display/SR4JS/.Getting+the+Most+Out+of+Service+Management+v6.20.0) on a transition, [_clone and link a development issue from a Jira Service Desk ticket_](https://docs.adaptavist.com/display/SR4JS/.Getting+the+Most+Out+of+Service+Management+v6.20.0), or even [_email all watchers of issues linked to a development ticket_](https://docs.adaptavist.com/display/SR4JS/.Getting+the+Most+Out+of+Service+Management+v6.20.0), so your support teams can spend time supporting your customers, not manually updating tickets.

We have also shown you how to use the new SmartDraw Object Notation (SDON) to [_automatically generate a diagram of your backlog_](https://docs.adaptavist.com/display/SR4JS/.Smart+Draw+v6.20.0).

**Bug Fixes**

-   \[SRJIRA-2389\] - Missing MentionIssueEvent and MentionIssueCommentEvent etc in Jira event listeners
-   \[SRJIRA-2275\] - Copy JSD Project
-   \[SRPLAT-199\] - Spinner not showing when clicking add new item and available canned scripts are not ready
-   \[SRJIRA-2386\] - Scripted Field with without "type" property in Jira API
-   \[SRJIRA-2206\] - json for custom fields doesn't handle durations properly
-   \[SRJIRA-2433\] - Upgrading to 5.0.15 or above then Downgrading causes Script Fields to stop functioning
-   \[SRJIRA-2277\] - JSD Events
-   \[SRJIRA-2453\] - Clones an Issue and Links "As User" selection ignored when linking issue
-   \[SRJIRA-2238\] - Change docs for upgrading to Jira 7
-   \[SRJIRA-2276\] - Bulk Update SLAs
-   \[SRJIRA-2422\] - In-Product Help and Community
-   \[SRJIRA-2257\] - Escalation Service Throws an Exception
-   \[SRJIRA-2399\] - Copy Project script fails to copy users and roles

## 5.2.0

-   Released 02 Nov 2017.

**Updates**

**Support for Issue Link Events**

ScriptRunner now supports the long-awaited issue link events when creating and deleting issue links.

Please refer to the documentation for the [IssueLinkCreatedEvent](https://docs.atlassian.com/jira/server/com/atlassian/jira/event/issue/link/IssueLinkCreatedEvent.html) and [IssueLinkDeletedEvent](https://docs.atlassian.com/jira/server/com/atlassian/jira/event/issue/link/IssueLinkDeletedEvent.html).

**Bug Fixes**

-   \[SRJIRA-2268\] - Built-In Script: Generate list of approvers based on JSD Request Type
-   \[SRJIRA-2379\] - Support Issue Link Events
-   \[SRJIRA-2385\] - Terminate recursive calls back to same scripted event listener

## 5.1.6.2

-   Released 15 Sep 2017.

**Updates**

This update fixes a serious security vulnerability in ScriptRunner for Jira discovered during an internal review. We strongly recommend all customers apply this update at their earliest opportunity. Further details will be released in the coming weeks as part of Adaptavist’s responsible disclosure approach.

All versions of ScriptRunner for Jira from 4.0.0 are affected. Below are instructions on which version we recommend you upgrade to:

-   If you have **Jira 7.2 or above**, upgrade to **5.3.26**
    
-   If you have **Jira 7.0 or 7.1**, upgrade to **5.1.6.2**
    
-   If you have **Jira 6.4**, upgrade to **4.1.3.29**
    
-   If you have **Jira 6.3.10 to Jira 6.3.15** inclusive, upgrade to **4.1.3.28**
    
-   If you have **Jira 6.3.0 to 6.3.9** inclusive, upgrade to **4.1.3.27**
    

## 5.1.0

-   Released 30 Aug 2017.

**New Features**

**Canned Script Fields**

Scripted Fields allow anyone to make custom fields in Jira that are customizable, automatically generated, and visible and searchable throughout Jira.

While you can write their own custom Scripted Field today, we are very happy to provide new built-in Scripted Fields that make it very easy to get started with your own Scripted Fields - Date of first transition : Easily see when an ticket began, use this in JQL searches to ensure that issues are moving at a good pace - Time of last status change : Keep track of how long issues are in your workflow, use this to surface long-running issues in JQL searches - Number of times in status : Make it easy to see how often an issue is bouncing around, set alerts to help teams swarm on these issues to get them over the line - Show parent issue in hierarchy : Make the relationship between issues and their parent Stories, Epics, and even Portfolio relationships like Theme and Initiatives!

**Remote Control and Remote Events**

[_Remote Control_](https://docs.adaptavist.com/display/SR4JS/.Remote+Control+v6.19.0) is an easy-to-use new feature that allows you to execute code on other Atlassian applications with ScriptRunner installed. This may be come into its own if you have multiple Jira instances to manage, or as an easy way to synchronize data between instances.

[_Remote Events_](https://docs.adaptavist.com/display/SR4JS/.Remote+Events+v6.19.0) allows you to listen to events that happen on a linked application, and respond to it locally. This may be a simpler way to integrate applications than adding a REST endpoint to the remote, then writing a listener than invokes it.

**Bug Fixes**

-   \[SRJIRA-2283\] - Scope of Behaviors is Poorly Documented
-   \[SRJIRA-2302\] - Custom web item to trigger dialog renders it only when clicking on the text of a web item
-   \[SRJIRA-2183\] - Canned Scripted Field - Work Remaining in Linked Issues
-   \[SRJIRA-2336\] - canned script field to display issue type in the hierarchy above
-   \[SRJIRA-2364\] - Ensure compatibility with 7.4.\* versions

## 5.0.17

-   Released 14 July 2017.

**Updates**

**Behaviours and Inline Edit**

Instead of disabling inline edit on the view screen entirely, Behaviours will now launch the Edit Issue screen if you try to edit any field with an associated behaviour. The behaviour will be applied there as normal.

**Bug Fixes**

-   \[SRJIRA-2155\] - Clearing the Groovy class loader generates an error in Jira 7.0+
-   \[SRJIRA-2173\] - Scripted Field still called even if issue type is not configured
-   \[SRJIRA-2308\] - Copy Comments checkbox in a post function not working properly
-   \[SRJIRA-2309\] - Getting ScriptRunner reindexing failed to reindex Portfolio parent issue
-   \[SRJIRA-2313\] - Portfolio functions do not work without user context
-   \[SRJIRA-2330\] - Copy project won't work if installation dir has spaces
-   \[SRJIRA-2294\] - Add Midori examples to Scripting Other Addons documentation
-   \[SRJIRA-2303\] - Copy Project Function should skip gadgets that are not supported rather than fail

## 5.0.13

-   Released 23 June 2017.

**New Features**

**New JQL Functions for Portfolio Users**

If you use [_Portfolio for Jira_](https://marketplace.atlassian.com/plugins/com.radiantminds.roadmaps-jira/server/overview) you can now take advantage of two new functions for traversing the Portfolio hierarchy, allowing you to search for open Initiatives of closed themes, find themes with outstanding epics, epics with no initiative, issues with no children, and so on. [Read more](https://docs.adaptavist.com/display/SR4JS/.JQL+Functions+v6.21.0).

**Choose Fields to Copy in Clone Issue/Create Subtask**

The [Clone Issue](https://docs.adaptavist.com/display/SR4JS/.Built-In+Scripts+v6.20.0) and [Create Subtask](https://docs.adaptavist.com/display/SR4JS/.Built-In+Scripts+v6.20.0) workflow functions now allow you to much more easily choose which fields to copy using a simple multi-select. Previously it would copy everything and you would have to "null out" those fields you didn’t wish to copy in the **additional code** section.

**Jira Switch User Built-in Script Writes to the Audit Log**

When this script is used, it will generate a log entry in the audit log. [Read more](https://docs.adaptavist.com/display/SR4JS/.Built-In+Scripts+v6.20.0).

**Workflow Functions Validation of Position**

Some workflow functions need to be in a specific order in the list of functions. For example, fast-track, if placed on the _Create_ transition, should be after the system workflow function "Creates the issue originally". If they are not in this position they will show an error when viewing the workflow.

In some cases they may work fine as they are, although you will see the error message. If this is the case, just move it as requested. The error message will disappear when it’s in the correct position.

**Bug Fixes**

-   \[SRJIRA-551\] - inconsistent scripted field values
-   \[SRJIRA-599\] - issueFunction can be used to execute a circular reference query
-   \[SRJIRA-603\] - Copy project script fails - all worked except last Dashboard
-   \[SRJIRA-1883\] - 404 from behaviours validators.json when on tempo timesheet page
-   \[SRJIRA-2081\] - Improve send custom email diagnostics when it is before create issue post-function
-   \[SRJIRA-2107\] - Web items trigger dialog/flag not working for items in the Projects menu (and possibly other menus)
-   \[SRJIRA-2135\] - Script listener execution information takes long time to load when many are setup
-   \[SRJIRA-2150\] - Behaviours don't function when creating subtasks in full screen, ie without a dialog
-   \[SRJIRA-2164\] - Create web panel built-in missing weight form attribute
-   \[SRJIRA-2170\] - Fast track transition Post function does not remember the transition options
-   \[SRJIRA-2184\] - Comment group-based JQL predicates need to search on userKey, not userName
-   \[SRJIRA-2197\] - Bug in SetErrorText that leaves field in incorrect state
-   \[SRJIRA-2200\] - Setting a drop-down field as "Required" behaviour broken
-   \[SRJIRA-2227\] - inactiveUsers fails if there are more than 1000 inactive users
-   \[SRJIRA-2231\] - On ajaxError causes fields override
-   \[SRJIRA-2246\] - Updating links from [atlassian.answers.com](http://atlassian.answers.com/) in documentation
-   \[SRJIRA-2251\] - Canned comments failing to insert properly in visual mode
-   \[SRJIRA-1056\] - Clone issue should optionally copy fields, include watchers
-   \[SRJIRA-2300\] - As a Jira Portfolio user, I would like Parent Link to operate like Epic/Story so that I am able to surface issues related to larger themes / initiatives

## 5.0.10

-   Released 23 June 2017.
-   ScriptRunner is now compatible with Jira 7.3.6

**Bug Fixes**

-   \[SRJIRA-2236\] - Compatibility with Jira 7.3.6

## 5.0.3

-   Released 09 May 2017.

Version 5.0.0 was publicly released for a short period of time on Marketplace. Unfortunately due to major issues with that release we pulled it from the marketplace. If you have this version you should upgrade to 5.0.1 which fixes these major issues.

**Bug Fixes**

-   \[SRJIRA-2226\] - Text displayed in pink on view issue screen
-   \[SRJIRA-2233\] - Add button on workflow conditions, validators and post-functions missing

## 5.0.0

-   Released 26 April 2017.

**Updates**

**User Interface Updated**

With version 5.0.0 we’ve done a major overhaul of the user interface, allowing for a more user friendly experience and providing a better way of navigating through all sections of ScriptRunner.

Scripts are also now better organized and easier to access allowing for a quicker access to the desired script through a collapse and expand buttons. Together with this, we’ve decided to removed the slow auto-scroll when a script was being edited for a more snappy experience.

![The Built-in Scripts options.](/sr4js/files/latest/101624452/101628608/1/1602076863000/built-in-scripts.png)

![The Add New Item option, highlighted on the Script Listeners page.](/sr4js/files/latest/101624452/101628601/1/1602076863000/new_ui_1.png)

![The Cog drop-down menu, on a Confluence page.](/sr4js/files/latest/101624452/101628604/1/1602076863000/actions.png)

**Bug Fixes**

-   \[SRJIRA-688\] - Script fields - using the date template shows relative dates in column view
-   \[SRJIRA-1316\] - Linked Issue validator not triggering
-   \[SRJIRA-2107\] - Web items trigger dialog/flag not working for items in the Projects menu (and possibly other menus)
-   \[SRJIRA-2116\] - Script Registry throws error when workflow function implements CannedScript
-   \[SRJIRA-2117\] - UserMessageUtil not displaying messages
-   \[SRJIRA-2189\] - Assignee is not set in behaviours if user picker returns multiple results and the required user is not the first one
-   \[SRJIRA-2213\] - Ability to use UserMessageUtil from rest endpoint
-   \[SRJIRA-2217\] - Escalation service is not deleted
-   \[SRPLAT-133\] - Cannot create a web section with the location of a web item we added)

def decodeBase64EncodedString = { String str ->
    if (str ==~ BASE_64_REGEX) {
        def decoded = new String(str.decodeBase64())
        if (decoded.startsWith(BASE_64_CANARY)) {
            return decoded.substring(BASE_64_CANARY.size())
        }
    }
    return str
}

def rewriteScripts = { Map functionArgs ->
    functionArgs.each { arg ->
        if (arg.key in [ConditionUtils.FIELD_CONDITION, ConditionUtils.FIELD_ADDITIONAL_SCRIPT] && arg.value) {
            def script = decodeBase64EncodedString(arg.value)

            def inlineScript = script.tokenize("|||")[0]

            def base64encoded = (BASE_64_CANARY + inlineScript).bytes.encodeBase64().toString()

            arg.value = base64encoded
        }
    }
}

workflowManager.getActiveWorkflows().each { workflow ->

    def draftWorkflow = workflowManager.getDraftWorkflow(workflow.name)
    if (draftWorkflow) {
        log.warn("A draft existed, for $workflow.name it's being taken over")
    } else {
        draftWorkflow = workflowManager.createDraftWorkflow(user, workflow.name)
    }

    draftWorkflow.getAllActions().each { action ->

        def postFunctions = action.getUnconditionalResult().getPostFunctions()

        postFunctions.each { FunctionDescriptor postFunction ->
            rewriteScripts(postFunction.getArgs())
        }

        def validators = action.getUnconditionalResult().getValidators()

        validators.each { ValidatorDescriptor validator ->
            rewriteScripts(validator.getArgs())
        }

        def conditionDescriptor = action.getRestriction()?.getConditionsDescriptor()

        conditionDescriptor?.conditions.each { ConditionDescriptor condition ->
            rewriteScripts(condition.getArgs())
        }
    }

    workflowManager.updateWorkflow(user, draftWorkflow)
    workflowManager.overwriteActiveWorkflow(user, workflow.name)
}

void convertScript(Map<String, Object> param, String fieldName) {
    if (param.containsKey(fieldName) && param[fieldName] && param[fieldName] instanceof List) {
        def scripts = param[fieldName]

        def inlineScript = scripts[0]

        param[fieldName] = inlineScript ?: null
    }
}
```

**Behaviours for Jira Service Desk**

You can now apply _behaviours_ to the customer portal. Things like help text, requiredness etc, follow the normal Service Desk theme.

**Potentially breaking changes**

Behaviours have been fixed so that when getting the value for a priority, it correctly returns a `Priority` object.

For example, so now you can correctly do:

* * *

```
getFieldById("priority").value?.name == "Highest"
```

* * *

If previously you were comparing the string value, for instance:

* * *

```
getFieldById("priority").value == "1"
```

* * *

you can either replace with code like the above, or change `.value` to `.formValue`.

**Hide or disable tabs on Jira issue screens**

You can now hide or disable entire tabs with Behaviours. You might wish to do this to prevent a category of field attributes being edited at certain stages of the workflow, or by certain groups or roles.

**Set Allowed Options for Radio and Checkbox Fields**

You can now use `setFieldOptions` to restrict the available options for radio and checkbox custom fields, in exactly the same way as with [select and multiselect fields](https://docs.adaptavist.com/sr4js/latest/features/behaviours/behaviours-examples/restricting-priority-and-resolution).

**Script Search Within Script File Input**

You now have the ability to search for scripts contained within your configured script roots inside ScriptRunner. Wherever you used to be able to paste the path of a script, you can now search for the script directly in the file input. Simply start typing the name of your script and the search will present suggestions that you can select!

**Execute Script Action in Automation for Jira**

We now provide an action allowing you to run your own script, in Automation for Jira. [More](https://docs.adaptavist.com/sr4js/latest/integrations/automation-for-jira).

Please restart your system after installing the update if you intend to use this integration, otherwise you may get an error when saving the rule. We are investigating why this may happen.

**Compatibility with Jira 7.7 and Jira Service Desk 3.10.0**

Compatibility with latest Jira release.

**Potential XSS Issues Fixed**

Insufficient escaping may have allowed a vulnerability via XSS. However we judge the severity of this vulnerability as "low" as it would require a specific sequence of actions by an administrator.

**Bug fixes**

-   \[SRJIRA-44\] - Behaviours: A read-only Version field can be emptied using delete key
-   \[SRJIRA-77\] - Required fields are not displayed when scrolling
-   \[SRJIRA-643\] - Field not consistently read-only with inline editing
-   \[SRJIRA-689\] - The Cascading select list first value equal to example wrong
-   \[SRJIRA-791\] - Behaviour didn't work for transitions (like in the past)
-   \[SRJIRA-869\] - Script Registry logs ERROR and Exception for validators
-   \[SRJIRA-877\] - Syntax check in Script Registry shows mangled script and errors
-   \[SRJIRA-1325\] - Adding a behaviour to the Due Date field does not disable inline editing
-   \[SRJIRA-2142\] - Behaviours ignores multi user picker custom field
-   \[SRJIRA-2186\] - LastComment function throws an error if there are no comments
-   \[SRJIRA-2204\] - Cannot use Behaviours on Original Estimate and other time tracking fields
-   \[SRJIRA-2205\] - Jira comment behaviours broken in Issue View Screen
-   \[SRJIRA-2212\] - Behaviours sometimes don't work for full screen create/edit issue dialogs
-   \[SRJIRA-2229\] - Inconsistent setError in Behaviours
-   \[SRJIRA-2257\] - Escalation Service Throws an Exception
-   \[SRJIRA-2320\] - Setting Comment field to "required" via Behaviors results in an inconsistent red asterisk
-   \[SRJIRA-2341\] - Setting linked issues field as not required in behaviours does not unmark the field as required
-   \[SRJIRA-2344\] - Link does not create on issue for Confluence Pages
-   \[SRJIRA-2345\] - No red asterisks shown after enabling the Validator Plugin (JSU) in Behaviours on the Create issue screen
-   \[SRJIRA-2354\] - Behaviours set Description added multiple times
-   \[SRJIRA-2355\] - Behaviour on Component/s field result in an Uncaught TypeError when set to required and the project has no components
-   \[SRJIRA-2396\] - <script> tag causes the script registry to not load
-   \[SRJIRA-2399\] - Copy Project script fails to copy users and roles
-   \[SRJIRA-2416\] - Behaviours do not return the value of the Sprint field as expected
-   \[SRJIRA-2423\] - Behaviour Mapping Setup shows duplicate Sub-task issue types
-   \[SRJIRA-2447\] - Setting up a Dev Environment instructions don't work for latest SR Version
-   \[SRJIRA-2452\] - On transition screens fix version/s red asterisk persists when set to not required via Behaviour
-   \[SRJIRA-2456\] - Behaviours: Setting the Assignee field as required does not work
-   \[SRJIRA-2531\] - Links are broken in Script Information dialog
-   \[SRJIRA-2540\] - IE11issues caused by use of includes
-   \[SRJIRA-2544\] - In FieldBehaviours class there is typo which throws exception.
-   \[SRJIRA-2559\] - Fix location and structure of help text
-   \[SRJIRA-2569\] - ProjectRole\* events are not listed in Script Listener Event list
-   \[SRJIRA-2577\] - If a behaviour is configured - Script registry fails
-   \[SRJIRA-2581\] - Test Runner Removes Configured Scripted Fields and Listeners
-   \[SRJIRA-2583\] - Behaviours editing GUI rewrite
-   \[SRJIRA-2584\] - codemirror linting broken
-   \[SRJIRA-2585\] - Builds infrastructure improvements
-   \[SRJIRA-2597\] - Can't have a behaviour on issue type anymore
-   \[SRJIRA-2605\] - Behaviours documentation is wrong due to .getValue change
-   \[SRJIRA-1319\] - Add current http request to behaviours script bindings
-   \[SRJIRA-1385\] - Ability to hide/show entire tabs
-   \[SRJIRA-2207\] - Add an expandable example showing how to change the default FROM email address
-   \[SRJIRA-2258\] - hasRemoteLinks JQL function
-   \[SRJIRA-2353\] - Lock the issueFunction custom field
-   \[SRJIRA-2387\] - Behaviours: Extend use of the setFieldOptions function to other field types
-   \[SRJIRA-2546\] - Implement helping pop-up for JSD Fragments
-   \[SRJIRA-2557\] - Ability to set change the name of the field via Behaviours
-   \[SRJIRA-2315\] - Implement Web Fragments for JSD
-   \[SRJIRA-2319\] - As an Administrator, I need the Send Customer Email script to automatically send emails to Approvers and members of Organizations to keep everyone informed of activities in ServiceDesk
-   \[SRJIRA-2402\] - As a Jira Administrator, I need to be able to load Conditions and Validators from source files so my whole ScritpRunner customization can be code reviewed and deployed to a file system
-   \[SRJIRA-2429\] - Provide an interface for selecting which script file to apply to any given automation, rather than writing out the file by name
-   \[SRJIRA-2103\] - Behaviours API does not expose getConfigsFor()
-   \[SRJIRA-2382\] - Midori Better Excel Docs Example
-   \[SRJIRA-2519\] - User Guide - Scripted Fields and Displaying links
-   \[SRJIRA-2596\] - Update Build Plan to include 7.7
-   \[SRJIRA-2598\] - Compatibility with Jira 7.7.0 & SD 3.10.0
-   \[SRPLAT-249\] - Built In Scripts Not Ordered and naming inconsistency
-   \[SRPLAT-127\] - Separate log file for ScriptRunner logging

## 5.2.2

-   Released 21 Nov 2017.
-   ScriptRunner is now compatible with Jira 7.6.0 and Service Desk 3.9.0.

**Bug Fixes**

-   \[SRJIRA-2548\] - Compatibility with Jira 7.6.0 & SD 3.9.0

For _how-to_ questions please ask on [Atlassian Answers](https://answers.atlassian.com/).

## 5.2.1

-   Released 02 Nov 2017.

**New Features**

**Script Listeners - New Jira Service Desk and Jira Software Events**

[Script Listeners](https://docs.adaptavist.com/display/SR4JS/.Listeners+v6.19.0) are powerful tools that let you react automatically to specific actions in Jira. We have updated Script Listeners to include Jira Service Desk, Jira Software, and other events.

We have added more than 40 new events to Script Listeners, including Sprint started/completed, Agile Boards created/updated, and even SLA-specific events like Thresholds Exceeded.

**Copy Project for Jira Service Desk and Bulk Update SLAs**

ScriptRunner for Jira now makes administering Jira Service Desk even easier with updates to our [Copy Project](https://docs.adaptavist.com/display/SR4JS/.Built-In+Scripts+v6.20.0) built-in script, as well a new [Bulk Copy SLAs](https://docs.adaptavist.com/display/SR4JS/.Built-In+Scripts+v6.20.0) built-in script.

**New User Guides for Jira Service Desk and SmartDraw**

We are very happy to share best practices guides for how ScriptRunner for Jira can help your Service, Support, and Operations teams. We provided clear examples for you to automatically [_create a Root Cause Analysis document_](https://docs.adaptavist.com/display/SR4JS/.Getting+the+Most+Out+of+Service+Management+v6.20.0) on a transition, [_clone and link a development issue from a Jira Service Desk ticket_](https://docs.adaptavist.com/display/SR4JS/.Getting+the+Most+Out+of+Service+Management+v6.20.0), or even [_email all watchers of issues linked to a development ticket_](https://docs.adaptavist.com/display/SR4JS/.Getting+the+Most+Out+of+Service+Management+v6.20.0), so your support teams can spend time supporting your customers, not manually updating tickets.

We have also shown you how to use the new SmartDraw Object Notation (SDON) to [_automatically generate a diagram of your backlog_](https://docs.adaptavist.com/display/SR4JS/.Smart+Draw+v6.20.0).

**Bug Fixes**

-   \[SRJIRA-2389\] - Missing MentionIssueEvent and MentionIssueCommentEvent etc in Jira event listeners
-   \[SRJIRA-2275\] - Copy JSD Project
-   \[SRPLAT-199\] - Spinner not showing when clicking add new item and available canned scripts are not ready
-   \[SRJIRA-2386\] - Scripted Field with without "type" property in Jira API
-   \[SRJIRA-2206\] - json for custom fields doesn't handle durations properly
-   \[SRJIRA-2433\] - Upgrading to 5.0.15 or above then Downgrading causes Script Fields to stop functioning
-   \[SRJIRA-2277\] - JSD Events
-   \[SRJIRA-2453\] - Clones an Issue and Links "As User" selection ignored when linking issue
-   \[SRJIRA-2238\] - Change docs for upgrading to Jira 7
-   \[SRJIRA-2276\] - Bulk Update SLAs
-   \[SRJIRA-2422\] - In-Product Help and Community
-   \[SRJIRA-2257\] - Escalation Service Throws an Exception
-   \[SRJIRA-2399\] - Copy Project script fails to copy users and roles

## 5.2.0

-   Released 02 Nov 2017.

**Updates**

**Support for Issue Link Events**

ScriptRunner now supports the long-awaited issue link events when creating and deleting issue links.

Please refer to the documentation for the [IssueLinkCreatedEvent](https://docs.atlassian.com/jira/server/com/atlassian/jira/event/issue/link/IssueLinkCreatedEvent.html) and [IssueLinkDeletedEvent](https://docs.atlassian.com/jira/server/com/atlassian/jira/event/issue/link/IssueLinkDeletedEvent.html).

**Bug Fixes**

-   \[SRJIRA-2268\] - Built-In Script: Generate list of approvers based on JSD Request Type
-   \[SRJIRA-2379\] - Support Issue Link Events
-   \[SRJIRA-2385\] - Terminate recursive calls back to same scripted event listener

## 5.1.6.2

-   Released 15 Sep 2017.

**Updates**

This update fixes a serious security vulnerability in ScriptRunner for Jira discovered during an internal review. We strongly recommend all customers apply this update at their earliest opportunity. Further details will be released in the coming weeks as part of Adaptavist’s responsible disclosure approach.

All versions of ScriptRunner for Jira from 4.0.0 are affected. Below are instructions on which version we recommend you upgrade to:

-   If you have **Jira 7.2 or above**, upgrade to **5.3.26**
    
-   If you have **Jira 7.0 or 7.1**, upgrade to **5.1.6.2**
    
-   If you have **Jira 6.4**, upgrade to **4.1.3.29**
    
-   If you have **Jira 6.3.10 to Jira 6.3.15** inclusive, upgrade to **4.1.3.28**
    
-   If you have **Jira 6.3.0 to 6.3.9** inclusive, upgrade to **4.1.3.27**
    

## 5.1.0

-   Released 30 Aug 2017.

**New Features**

**Canned Script Fields**

Scripted Fields allow anyone to make custom fields in Jira that are customizable, automatically generated, and visible and searchable throughout Jira.

While you can write their own custom Scripted Field today, we are very happy to provide new built-in Scripted Fields that make it very easy to get started with your own Scripted Fields - Date of first transition : Easily see when an ticket began, use this in JQL searches to ensure that issues are moving at a good pace - Time of last status change : Keep track of how long issues are in your workflow, use this to surface long-running issues in JQL searches - Number of times in status : Make it easy to see how often an issue is bouncing around, set alerts to help teams swarm on these issues to get them over the line - Show parent issue in hierarchy : Make the relationship between issues and their parent Stories, Epics, and even Portfolio relationships like Theme and Initiatives!

**Remote Control and Remote Events**

[_Remote Control_](https://docs.adaptavist.com/display/SR4JS/.Remote+Control+v6.19.0) is an easy-to-use new feature that allows you to execute code on other Atlassian applications with ScriptRunner installed. This may be come into its own if you have multiple Jira instances to manage, or as an easy way to synchronize data between instances.

[_Remote Events_](https://docs.adaptavist.com/display/SR4JS/.Remote+Events+v6.19.0) allows you to listen to events that happen on a linked application, and respond to it locally. This may be a simpler way to integrate applications than adding a REST endpoint to the remote, then writing a listener than invokes it.

**Bug Fixes**

-   \[SRJIRA-2283\] - Scope of Behaviors is Poorly Documented
-   \[SRJIRA-2302\] - Custom web item to trigger dialog renders it only when clicking on the text of a web item
-   \[SRJIRA-2183\] - Canned Scripted Field - Work Remaining in Linked Issues
-   \[SRJIRA-2336\] - canned script field to display issue type in the hierarchy above
-   \[SRJIRA-2364\] - Ensure compatibility with 7.4.\* versions

## 5.0.17

-   Released 14 July 2017.

**Updates**

**Behaviours and Inline Edit**

Instead of disabling inline edit on the view screen entirely, Behaviours will now launch the Edit Issue screen if you try to edit any field with an associated behaviour. The behaviour will be applied there as normal.

**Bug Fixes**

-   \[SRJIRA-2155\] - Clearing the Groovy class loader generates an error in Jira 7.0+
-   \[SRJIRA-2173\] - Scripted Field still called even if issue type is not configured
-   \[SRJIRA-2308\] - Copy Comments checkbox in a post function not working properly
-   \[SRJIRA-2309\] - Getting ScriptRunner reindexing failed to reindex Portfolio parent issue
-   \[SRJIRA-2313\] - Portfolio functions do not work without user context
-   \[SRJIRA-2330\] - Copy project won't work if installation dir has spaces
-   \[SRJIRA-2294\] - Add Midori examples to Scripting Other Addons documentation
-   \[SRJIRA-2303\] - Copy Project Function should skip gadgets that are not supported rather than fail

## 5.0.13

-   Released 23 June 2017.

**New Features**

**New JQL Functions for Portfolio Users**

If you use [_Portfolio for Jira_](https://marketplace.atlassian.com/plugins/com.radiantminds.roadmaps-jira/server/overview) you can now take advantage of two new functions for traversing the Portfolio hierarchy, allowing you to search for open Initiatives of closed themes, find themes with outstanding epics, epics with no initiative, issues with no children, and so on. [Read more](https://docs.adaptavist.com/display/SR4JS/.JQL+Functions+v6.21.0).

**Choose Fields to Copy in Clone Issue/Create Subtask**

The [Clone Issue](https://docs.adaptavist.com/display/SR4JS/.Built-In+Scripts+v6.20.0) and [Create Subtask](https://docs.adaptavist.com/display/SR4JS/.Built-In+Scripts+v6.20.0) workflow functions now allow you to much more easily choose which fields to copy using a simple multi-select. Previously it would copy everything and you would have to "null out" those fields you didn’t wish to copy in the **additional code** section.

**Jira Switch User Built-in Script Writes to the Audit Log**

When this script is used, it will generate a log entry in the audit log. [Read more](https://docs.adaptavist.com/display/SR4JS/.Built-In+Scripts+v6.20.0).

**Workflow Functions Validation of Position**

Some workflow functions need to be in a specific order in the list of functions. For example, fast-track, if placed on the _Create_ transition, should be after the system workflow function "Creates the issue originally". If they are not in this position they will show an error when viewing the workflow.

In some cases they may work fine as they are, although you will see the error message. If this is the case, just move it as requested. The error message will disappear when it’s in the correct position.

**Bug Fixes**

-   \[SRJIRA-551\] - inconsistent scripted field values
-   \[SRJIRA-599\] - issueFunction can be used to execute a circular reference query
-   \[SRJIRA-603\] - Copy project script fails - all worked except last Dashboard
-   \[SRJIRA-1883\] - 404 from behaviours validators.json when on tempo timesheet page
-   \[SRJIRA-2081\] - Improve send custom email diagnostics when it is before create issue post-function
-   \[SRJIRA-2107\] - Web items trigger dialog/flag not working for items in the Projects menu (and possibly other menus)
-   \[SRJIRA-2135\] - Script listener execution information takes long time to load when many are setup
-   \[SRJIRA-2150\] - Behaviours don't function when creating subtasks in full screen, ie without a dialog
-   \[SRJIRA-2164\] - Create web panel built-in missing weight form attribute
-   \[SRJIRA-2170\] - Fast track transition Post function does not remember the transition options
-   \[SRJIRA-2184\] - Comment group-based JQL predicates need to search on userKey, not userName
-   \[SRJIRA-2197\] - Bug in SetErrorText that leaves field in incorrect state
-   \[SRJIRA-2200\] - Setting a drop-down field as "Required" behaviour broken
-   \[SRJIRA-2227\] - inactiveUsers fails if there are more than 1000 inactive users
-   \[SRJIRA-2231\] - On ajaxError causes fields override
-   \[SRJIRA-2246\] - Updating links from [atlassian.answers.com](http://atlassian.answers.com/) in documentation
-   \[SRJIRA-2251\] - Canned comments failing to insert properly in visual mode
-   \[SRJIRA-1056\] - Clone issue should optionally copy fields, include watchers
-   \[SRJIRA-2300\] - As a Jira Portfolio user, I would like Parent Link to operate like Epic/Story so that I am able to surface issues related to larger themes / initiatives

## 5.0.10

-   Released 23 June 2017.
-   ScriptRunner is now compatible with Jira 7.3.6

**Bug Fixes**

-   \[SRJIRA-2236\] - Compatibility with Jira 7.3.6

## 5.0.3

-   Released 09 May 2017.

Version 5.0.0 was publicly released for a short period of time on Marketplace. Unfortunately due to major issues with that release we pulled it from the marketplace. If you have this version you should upgrade to 5.0.1 which fixes these major issues.

**Bug Fixes**

-   \[SRJIRA-2226\] - Text displayed in pink on view issue screen
-   \[SRJIRA-2233\] - Add button on workflow conditions, validators and post-functions missing

## 5.0.0

-   Released 26 April 2017.

**Updates**

**User Interface Updated**

With version 5.0.0 we’ve done a major overhaul of the user interface, allowing for a more user friendly experience and providing a better way of navigating through all sections of ScriptRunner.

Scripts are also now better organized and easier to access allowing for a quicker access to the desired script through a collapse and expand buttons. Together with this, we’ve decided to removed the slow auto-scroll when a script was being edited for a more snappy experience.

![The Built-in Scripts options.](/sr4js/files/latest/101624452/101628608/1/1602076863000/built-in-scripts.png)

![The Add New Item option, highlighted on the Script Listeners page.](/sr4js/files/latest/101624452/101628601/1/1602076863000/new_ui_1.png)

![The Cog drop-down menu, on a Confluence page.](/sr4js/files/latest/101624452/101628604/1/1602076863000/actions.png)

**Bug Fixes**

-   \[SRJIRA-688\] - Script fields - using the date template shows relative dates in column view
-   \[SRJIRA-1316\] - Linked Issue validator not triggering
-   \[SRJIRA-2107\] - Web items trigger dialog/flag not working for items in the Projects menu (and possibly other menus)
-   \[SRJIRA-2116\] - Script Registry throws error when workflow function implements CannedScript
-   \[SRJIRA-2117\] - UserMessageUtil not displaying messages
-   \[SRJIRA-2189\] - Assignee is not set in behaviours if user picker returns multiple results and the required user is not the first one
-   \[SRJIRA-2213\] - Ability to use UserMessageUtil from rest endpoint
-   \[SRJIRA-2217\] - Escalation service is not deleted
-   \[SRPLAT-133\] - Cannot create a web section with the location of a web item we added
