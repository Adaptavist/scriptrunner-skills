# Release 6.x

- Platform: confluence-data-center
- Space: SR4C
- Hierarchy: Release Notes
- Doc ID: doc-sr4c-1a9e173e-02e4-439e-b6d6-64e0de770a10-750216a9d24c4454
- Source: https://docs.adaptavist.com/sr4c/latest/release-notes/release-6.x

Feature release information about our 6.x versions.

Check out what's new for ScriptRunner for Confluence Server.

## 6.58.0

### New Features

-   Add a Category to a bulk of spaces (SRCONF-2286)
-   Copy users from space permissions to the local group (SRCONF-2285)

### Bugs Fixed

-   Script files cause "Invalid duplicate class definition" error (SRPLAT-1992)
-   404 on newFeatureDiscovery when loading up ScriptRunner pages (SRPLAT-1322)

## 6.57.0

### New Training Courses Available

We're delighted to announce that our Customer Education team has made four new training courses available for ScriptRunner for Confluence. Three courses are aimed at Confluence administrators, with the fourth aimed at space administrators. Each course is a series of tutorial videos designed to show you how to get more out of ScriptRunner for Confluence. The course topics are:

-   Introduction to ScriptRunner for Data Center/Server.
-   Managing Your Confluence Instance with ScriptRunner.
-   Introduction to Scripting in ScriptRunner for Confluence.
-   Introduction to ScriptRunner for Space Administrators.

You can access the videos through the Training card on the [ScriptRunner for Confluence documentation page](../uncategorized/t/training.md) or the [Adaptavist YouTube channel](https://www.youtube.com/channel/UCJL9a_VEGQsr9LWWwTzPyhA).

New Features

-   Make code editors wider in locations outside script console (SRPLAT-1986)
-   Property shorthand completions for setters (SRPLAT-1982)

Bugs Fixed

-   No completions for uppercase variable names (SRPLAT-1980)
-   Web items used to create menu dropdowns no longer working (SRPLAT-1935)
-   Invalid event classes used in Listener configurations can cause the listener to fire for all events (SRPLAT-1708)
-   Bulk Delete Attachment built in script will throw an error if the attachment has many version (SRCONF-2231)

## 6.56.0

New Library Scripts Added

We've recently added six new ScriptRunner for Confluence scripts to the [Adaptavist Library](https://library.adaptavist.com/). The Adaptavist Library is your one-stop shop for pre-written scripts that provide all sorts of functionality to make life easier when you're working with ScriptRunner for Confluence. The scripts we've added recently are:

-   [Add Label to Outdated Pages](https://www.scriptrunnerhq.com/help/example-scripts/add-label-to-outdated-pages-onPrem).
-   [Automate the Removal of Old or Inactive Content](https://www.scriptrunnerhq.com/help/example-scripts/delete-old-pages-cql-escalation-service-onPrem).
-   [Display SQL Results from an External Database](https://www.scriptrunnerhq.com/help/example-scripts/display-sql-macro-onPrem).
-   [Get Active User Count and Disable Oldest User](https://www.scriptrunnerhq.com/help/example-scripts/check-active-user-count-remove-oldest-listener-onPrem).
-   [Get Outgoing Links using a CQL Function](https://www.scriptrunnerhq.com/help/example-scripts/linked-pages-cql-function-onPrem).
-   [Roll Back Anonymous Space Permissions via Listener](https://www.scriptrunnerhq.com/help/example-scripts/remove-anonymous-permissions-listener-onPrem).

Head over to the Library to check out these and the other scripts we have there. Be sure to check back regularly, as we'll be adding new scripts regularly over the coming weeks and months.

Bugs Fixed

-   Adjust 'Inline / File' tab z-index (SRPLAT-1953)
-   Less Than Operator '<' is not working in Enhanced Search (SRCONF-2291)
-   Enhanced Search UI & Functionality does not work together with 'Refined for Confluence' themes (SRCONF-2256)

## 6.55.1

### Bugs Fixed

-   monaco editor loader.js is being loaded from CDN rather than the plugin (SRPLAT-1963)

## 6.55.0

### New Features

-   Support completions within delegating closures in editor (SRPLAT-1929)

### Bugs Fixed

-   When navigated to new Home page from any SR tabs,Home browser title is defaulted to the instance name. (SRCONF-2066)

## 6.54.0

Performance Improvements

This release contains some significant improvements to the compilation and execution of scripts.

This builds on some of the work done in SRPLAT-1925 to prevent deadlocks and benchmark key parts of the ScriptRunner codebase.

This change should be invisible to 90% of users, except perhaps as an improvement in the speed and reliability of ScriptRunner, which could improve the performance of Confluence overall.

A key component of this change was increasing the minimum recompilation time for scripts from Groovy's default 100 milliseconds to 1 second. Again, this change should be practically invisible, but if you're 6 shots of espresso deep in a script debugging session, you're live-tailing your log files, and you're not seeing the changes you made to a script take effect instantaneously, we advise that you take one deep breath and check again before filing a bug report. 😉

While this is not the complete solution for SRPLAT-1922, users affected by that issue may notice a marginal performance improvement due to reducing needless access to their servers' filesystem. We are still exploring further improvements for the problems introduced by slow disks, and so that ticket remains open.

Bugs Fixed

-   Completions fail in closures with no parameters (SRPLAT-1928)
-   Rename Pages built in script throw an hibernate error (SRCONF-2263)
-   'Convert Absolute Links to Confluence Links' built-in script unable to detect viewpage.action link if it has an extra parameter (SRCONF-2087)

## 6.53.0

There are only core component changes in ScriptRunner for Confluence 6.53.0, so we do not have any new features or bug fixes to report.

## 6.52.0

Enhanced Search

We've added a new page to ScriptRunner for Confluence that gives you a simple way to search your content using CQL without calling Atlassian's Confluence REST API. Read more about the new Enhanced Search functionality [here](release-6-x.md).

Remote Event Listeners Fully Deprecated

Remote Event Listeners were deprecated with the 6.42.0 release. As of the 6.52.0 release, they have been completely removed from ScriptRunner for Confluence and you may experience problems if you still have a remote event listener configured. If you still require the functionality provided by the Remote Event listeners, a similar outcome can be achieved using a [REST Endpoint](https://docs.adaptavist.com/sr4c/latest/features/rest-endpoints) on the target instance communicating [via app links](https://docs.adaptavist.com/sr4c/latest/integrations/atlassian/connect-to-atlassian-via-app-links) or [remote control](https://docs.adaptavist.com/sr4c/latest/integrations/atlassian/remote-control).

Bug Fixes

-   Thread Deadlocks in Concurrently Running ScriptRunner scripts (SRPLAT-1925)
-   Field name providers should show suggestions without having to enter empty quotes (SRPLAT-1916)
-   Remote Events are Broken (SRPLAT-1540)
-   CQL Preview Search Link Automatically Searches with the Last Type of Search Used (SRCONF-771)

## 6.51.0

### New Features

-   Go to relevant section of Library from the App (SRPLAT-1899)

## 6.50.0

### Bug Fixes

-   REST endpoints break if an AppDynamics agent is present (SRPLAT-1905)
-   Smart completions does not work for class completions in methods (SRPLAT-1877)
-   Create page macro: Unable to create a page using the From Page parameter if the user does not have Add Page permissions in the source space (SRCONF-1512)

## 6.49.0

### Bug Fixes

-   inference of default closure parameter (SRPLAT-1888)
-   class completions and import quick fix fail when property called on method result (SRPLAT-1887)
-   Poor performance loading configurations due to excessive class initialisation (SRPLAT-1883)
-   Smart completion not working as expected with Opt+shift+space on mac (SRPLAT-1870)
-   'Rename Pages' built-in script is still validating either 'Title Prefix', 'Title Suffix', or 'Title Replace' even though the page has been renamed via 'Code Transform' (SRCONF-2181)

## 6.48.0

### Bug Fixes

-   Annotations completion lists all of the classes that are not annotations (SRPLAT-1882)
-   dismiss signature help when leaving a method (SRPLAT-1875)
-   completions on arrays do not work (SRPLAT-1874)
-   auto complete does not suggest local variables inside a closure (SRPLAT-1871)
-   Import quick fix does not work for certain types of code structure (SRPLAT-1867)
-   Completions expand the page width, consequently they are not positioned correctly and get truncated (SRPLAT-1853)

## 6.47.0

A New Editor

We've replaced our in-app editor component with [Monaco](https://microsoft.github.io/monaco-editor/), the same editor that powers [Visual Studio Code](https://code.visualstudio.com/).

Importantly, this gives us a platform for future improvements. However, there are immediate benefits to this release: you get inline documentation (press Control+Space when completions are open), hover over methods and classes to see documentation, see completions automatically as you type, find and replace, and more. Read more about Monaco by following the link above.

Empowering Atlassian administrators to write code, however simple, is at the heart of what we do. We hope the new editor makes you more productive and you enjoy using it! Let us know what you think.

Bug Fixes

-   Parameter 'version' in Include Version macro does not reset to 1 when page is copied (SRCONF-2164)
-   'Include Version' macro unable to render if target page title has '#' in it. (SRCONF-2126)

## 6.46.0

### Bug Fixes

-   improve performance of UnusedImportsVisitor (static type checking) (SRPLAT-1805)
-   subclasses loaded with loadClass cannot be cast to their parent class (SRPLAT-1788)
-   The bulk delete attachment versions built in script is failing (SRCONF-2134)

## 6.45.0

### Space Admin Built-in Script Permissions

Confluence administrators and system administrators can now control exactly which built-in scripts space administrators can access. By default, all space admins have access to all built-in scripts. If you want to change this, you can go to the Configure Space Admin Built-In Script Permissions section of your Settings page. From there, you can add users, groups, and spaces to the table and refine who can access which built-in scripts. Learn more about the new functionality [here](https://docs.adaptavist.com/sr4c/latest/get-started/settings/space-admin-built-in-script-permissions).

New Features

-   View server log files should default to the mostly commonly used log file (SRPLAT-1753)

Bug Fixes

-   Error using Hide system or plugin UI element Web Fragment (SRPLAT-1773)
-   Script Editor requests to save when a file uses windows line endings (SRPLAT-1695)
-   The exception messages from the script are not shown in logs for the script listeners (SRCONF-2159)
-   Markdown macro unable to render horizontal rule (SRCONF-2009)
-   Space Administrators cannot use the Export page info as CSV functionality on Space Statistics (SRCONF-1575)

## 6.44.0

Opt out of In-App Communications

We have added the ability for users to opt out of in-App communications in ScriptRunner. This option is available in the Settings page. For more information on in-app notifications and how to disable them, see our [documentation](https://docs.adaptavist.com/sr4c/latest/get-started/settings/in-app-communications).

New Feature

-   Allow the log file to be searchable in "View Server Logs" (SRPLAT-1715)

Bug Fix

-   Binding Info links are not clickable in the Fragment Locator elements (SRPLAT-1766)

## 6.43.0

### Bug Fixes

-   Modification of a class within a script root which has a generic supertype causes unnecessary recompilation of all classes it depends on (SRPLAT-1735)
-   Script recompilation fails if a script depends on two classes (located in a script root) that have the same generic supertype and one of these classes is modified (SRPLAT-1734)
-   Refresh listener mechanism fails when listener configuration lacks event (SRPLAT-1729)
-   Can't clear value for "Number of lines" in log file viewer built in (SRPLAT-1719)
-   Confluence 7.15 specific> copy space / copy page tree built in script is unable to copy pages to the newly created space (SRCONF-2082)

## 6.42.0

Remote Event Listeners are now Deprecated

As of ScriptRunner 6.42.0, we have deprecated Remote Event listeners. This is due to low usage and high maintenance costs. If you still require the functionality provided by the Remote Event listeners, a similar outcome can be achieved using a [REST Endpoint](https://docs.adaptavist.com/sr4c/latest/features/rest-endpoints) on the target instance communicating [via app links](https://docs.adaptavist.com/sr4c/latest/integrations/atlassian/connect-to-atlassian-via-app-links) or [remote control](https://docs.adaptavist.com/sr4c/latest/integrations/atlassian/remote-control).

Training resources are now available from the Documentation home page

We've added a tile to the Documentation home page that brings you to the ScriptRunner for Confluence Training Hub. Here you can find all the training resources we have currently made available. We're currently working on creating more training resources for ScriptRunner for Confluence, so keep an eye on this page for updates.

Bug Fix

-   No event types are available in the dropdown when configuring listeners on instances running on Windows (SRCONF-2105)

## 6.41.0

### Bug Fixes

-   Do not serialize stacktraces of compilation errors and warnings as part of static type checking endpoint response (SRPLAT-1705)
-   class completions don't allow for same class names in different packages (SRPLAT-1702)
-   Listeners for events from other plugins break on plugin upgrade or UPM upgrade (SRPLAT-1700)
-   Description column in binding information modal is being HTML escaped (SRPLAT-1697)
-   Users get onboarding credit for the Examples Modal even when examples fail to configure (SRCONF-2074)

## 6.40.0

### Bug Fixes

-   Writing script execution metrics to RRD fails when the shared application directory is pointing at a Windows shared folder (SMB) (SRPLAT-1605)
-   ScriptEditor code is replaced when "undone" (SRPLAT-1551)

## 6.39.0

ScriptRunner Homepage

Each admin has access to the ScriptRunner homepage where you can explore features in ScriptRunner that you want to learn more about.

### Unicode Bidirectional Override Characters Vulnerability

Recently, Atlassian highlighted a security vulnerability where special characters (unicode bidirectional override characters) were not rendered or displayed in the affected applications ( [CVE-2021-42574](https://confluence.atlassian.com/security/multiple-products-security-advisory-unrendered-unicode-bidirectional-override-characters-cve-2021-42574-1086419475.html?_ga=2.55315369.322944566.1636375808-1942073108.1631538975&_gac=1.189917657.1634652234.CjwKCAjw2bmLBhBREiwAZ6ugo1cpOjQ1h9AEUL2W9gYWvJyaT-Vv4ducCVnxB0Q44hUZAev3pfAbLhoCAjIQAvD_BwE)). This vulnerability could affect ScriptRunner if a user were to copy malicious code from an untrusted source and execute it within ScriptRunner. To mitigate this risk, we have added highlighting for bidirectional characters everywhere in ScriptRunner you can enter code. For more information please take a look at our [blog post](https://www.adaptavist.com/blog/trojan-codes-in-atlassian-products-and-scriptrunner).

Bug Fix

-   The script editor breaks when switching between SR tabs (SRPLAT-1603)

## 6.38.0

Note: ADVANCE NOTICE

We'll soon be releasing ScriptRunner for Confluence 7.0.0. In that release we'll be adding more powerful controls for Confluence Administrators to govern access to Space Admin scripts. Any existing restrictions you have will be migrated to the new system. However, it will not be possible to downgrade ScriptRunner and keep any changes you have made to access in the old system, as they aren't backwards compatible.

Warning: A bug was discovered in ScriptRunner for Confluence 6.11.0 through 6.37.0 which, in some upgrade paths, could have caused users with Space Administrator script permissions setup to lose their settings after upgrade. If you have any questions, please [contact us](https://the-adaptavist-group-support.atlassian.net/servicedesk/customer/portal/21).

### Bug Fix

-   Space Admin Script Permissions not upgraded properly (SRCONF-2024)

## 6.37.0

### Script Editor Expand and Collapse Folders

Folders in the [Script Editor](https://docs.adaptavist.com/sr4c/latest/features/script-editor) are now collapsed by default when the editor is opened. We have also added Expand All and Collapse All buttons to the _Script Editor_ heading, as well as the option to right-click a folder to expand it.

### New Features

-   Script Editor - Collapse Folders (SRPLAT-1607)

## 6.36.0

### New Features

-   Add CORS support to REST Endpoints (SRPLAT-1611)

### Bug Fixes

-   AuditedEventListener is causing performance issues (SRPLAT-1613)
-   Unable to 'Enable' fresh installed ScriptRunner 6.33.0 on Confluence Data Center (SRCONF-1972)
-   Remote Custom Listener is not working for Confluence (SRCONF-1398)

## 6.35.0

Warning: This version is not compatible with IE11. Do not update to this version if you use IE11.

### Notifications for Bulk Delete Attachment Versions Built-In Script

We're continuing to add more detailed notifications control to our built-in scripts. The [Bulk Delete Attachment Versions](https://docs.adaptavist.com/sr4c/latest/features/built-in-scripts/space-administration-built-in-scripts/bulk-delete-attachment-versions) built-in script for Confluence administrators and the [Bulk Delete Attachment Versions](https://docs.adaptavist.com/sr4c/latest/features/built-in-scripts/space-administration-built-in-scripts/bulk-delete-attachment-versions) for space administrators are the latest to be updated. Using the Notifications checkbox, choose if you want to send a notification to users when attachment versions are deleted.

### New Features

-   Space Admin script - Prevent notifications being sent out from the Bulk Delete Attachment Versions built-in script (SRCONF-1917)
-   Prevent notifications being sent out from the Bulk Delete Attachment Versions built-in script (SRCONF-1652)

Bug Fixes

-   CQL Search macro doesn't handle blogposts properly (SRCONF-1840)

## 6.34.0

Warning: This version is not compatible with IE11. Do not update to this version if you use IE11.

### Bug Fixes

-   Comala Workflow Event Listeners not fired after Comala Upgrade (SRCONF-1738)

## 6.33.0

Warning: This version is not compatible with IE11.

### New Features

We're continuing to add more detailed notifications control to our built-in scripts. The [Update Macro](https://docs.adaptavist.com/sr4c/latest/features/built-in-scripts/confluence-administration-built-in-scripts/update-macro) built-in script is the latest to be updated. Using the Notifications checkbox, choose if you want to send a notification to users when updating macro parameters.

-   Prevent notifications being sent out from the Update Macro built-in script (SRCONF-1834)

Bug Fixes

-   Script changes in Script Editor doesn't reflect in REST Endpoint even after clearing Groovy Classloader (SRPLAT-1596)
-   LogFileViewer implementation is suboptimal (SRPLAT-1211)

## 6.32.0

Warning: This version is not compatible with IE11. Do not update to this version if you use IE11.

There are only core component changes in ScriptRunner for Confluence 6.32.0, so we do not have any new features or bug fixes to report.

## 6.30.1

This version is not compatible with IE11. Do not update to this version if you use IE11.

### Bug Fixes

-   Script Editor | script is lost on saving after switching file (SRPLAT-1576)

## 6.30.0

Warning: This version is not compatible with IE11. Do not update to this version if you use IE11.

There are only core component changes in ScriptRunner for Confluence 6.30.0, so we do not have any new features or bug fixes to report.

## 6.29.0

### New Features

Warning: This version is not compatible with IE11. Do not update to this version if you use IE11.

-   Remove unused pluginKey property from @PluginModule (SRPLAT-1557)

Bug Fixes

-   Context variables are not resolved correctly (SRPLAT-1562)
-   Bitbucket/Confluence/Jira is prevented from correctly shutting down when ScriptRunner is installed (SRPLAT-1221)

## 6.28.0

Warning: This version is not compatible with IE11. Do not update to this version if you use IE11.

There are only core component changes in ScriptRunner for Confluence 6.28.0, so we do not have any new features or bug fixes to report.

## 6.27.0

Warning: This version is not compatible with IE11. Do not update to this version if you use IE11.

Sunsetting Feature

The _Lock Content_ macro is deprecated. It will be removed in an upcoming release. If you have needs related to the macro or requests for functionality similar to the _Lock Content_ macro, please open a new [feature request](https://the-adaptavist-group-support.atlassian.net/servicedesk/customer/portal/21) with Support. By creating these requests, we can better understand your use case and help you solve problems.

New Features

-   Add a clear visual indication that the CQL Search option has been enabled (SRCONF-1554)

Bug Fixes

-   We are able to edit the SR built-in macros in the Macros page (SRCONF-1651)

## 6.26.0

This version is not compatible with IE11. Do not update to this version if you use IE11.

### Bug Fixes

-   Pickers where value is an array unnecessarily reload values when changes are made to other form fields (SRPLAT-1546)
-   Multiple error messages in Copy Space Built-in Script for Target space empty state condition (SRCONF-1767)
-   The validation for mandatory 'to' address fields are not working for custom email listener in edit mode (SRCONF-1734)

## 6.25.0

Warning: This version is not compatible with IE11. Do not update to this version if you use IE11.

### Update Macro Built-in Script Enhancement

The [Update Macro](https://docs.adaptavist.com/sr4c/latest/features/built-in-scripts/confluence-administration-built-in-scripts/update-macro) built-in script has been enhanced to include a [Code Transform](https://docs.adaptavist.com/sr4c/latest/features/built-in-scripts/confluence-administration-built-in-scripts/update-macro) field. This field allows you to manipulate macros further by executing custom code; for example, you can [edit the macro body or update a URL parameter](https://docs.adaptavist.com/sr4c/latest/features/built-in-scripts/confluence-administration-built-in-scripts/update-macro).

### Crowd Events Added to Event Listeners

All Crowd events are now available to use with our [Event Listeners](https://docs.adaptavist.com/sr4c/latest/features/event-listeners).

### Bug Fixes

-   Script Editor stays unchanged when browser window resized (SRPLAT-1485)
-   The CQL way to add watchers doesnt work for blogposts on built-in script (SRCONF-1269)

## 6.24.0

This version is not compatible with IE11. Do not update to this version if you use IE11.

There are only core component changes in ScriptRunner for Confluence 6.24.0, so we do not have any new features or bug fixes to report.

## 6.23.0

Warning: This version is not compatible with IE11. Do not update to this version if you use IE11.

Add/Remove Watchers Listener

There's a new built-in listener to choose to add or remove watchers on spaces, blogs, or content selected by CQL when prompted by a Confluence event called [Add/Remove Watchers](https://docs.adaptavist.com/sr4c/latest/features/event-listeners/built-in-listeners/add-or-remove-watchers-listener).

-   SRCONF-1269 - Like the equivalent built-in script, the listener can't target blog posts with CQL. Please watch this known bug for updates.

Send Custom Email Listener

There's a new built-in listener to send a customized email in response to an event called [Send Custom Email](https://docs.adaptavist.com/sr4c/latest/features/event-listeners/built-in-listeners/send-custom-email). In order to send an email for an event, the event has to be configured as an event listener.

Bug Fixes

-   Select list control very slow when there are a large number of items, such as in "Install web resource" (SRPLAT-1488)
-   Choose label button is not aligned with the Select Labels field (SRCONF-1429)

## 6.22.0

Warning: This version is not compatible with IE11. Do not update to this version if you use IE11.

Update Macro Built-In Script

There's a new built-in script to help you update parameters in bulk called [Update Macro](https://docs.adaptavist.com/sr4c/latest/features/built-in-scripts/confluence-administration-built-in-scripts/update-macro). This script updates every selected parameter of the selected macro in pages found by the CQL query. The script is available for Confluence administrators.

Bug Fixes

-   All built-in script text is blue (SRCONF-1611)

## 6.21.0

Warning: This version is not compatible with IE11. Do not update to this version if you use IE11.

Welcome to the new documentation site! We don't have any major changes in this ScriptRunner for Confluence release, but we have updated the in-app documentation links to point here. Let us know if you encounter any issues via [our support portal](https://the-adaptavist-group-support.atlassian.net/servicedesk/customer/portal/21).

## 6.20.0

Warning: This version is not compatible with IE11. Do not update to this version if you use IE11.

### Manage Labels Built-In Script

The _Bulk Add/Remove Labels on One or ore Pages_ and _Rename Labels_ scripts have been removed, and the functionality has been combined into the new _Manage Labels_ built-in script. Using this script, you can rename, add, and remove page labels in bulk. The script is available for [Confluence administrators](https://docs.adaptavist.com/sr4c/latest/features/built-in-scripts/confluence-administration-built-in-scripts/manage-labels) and [space administrators](https://docs.adaptavist.com/sr4c/latest/features/built-in-scripts/confluence-administration-built-in-scripts/manage-labels).

New Features

-   SRPLAT-1205 - The compile context in the _Script Editor_ is now set when opening it from a page where the script is being used, using the Edit icon.
    

Bug Fixes

-   SRPLAT-1415 - Syntax highlighting for SQL and properties editors was added.
    
-   SRCONF-1590 - Custom REST endpoints failed because the remote address not being able to write to the audit log.
    
-   SRCONF-1579 - The _Prune Old Page Versions_ job did not reorder the versions of a page after running.
    
-   SRCONF-1569 - When audit log is enabled, scheduled blog posts of the Linchpin plugin failed.
    

## 6.19.0

Warning: This version is not compatible with IE11. Do not update to this version if you use IE11.

IE11 Support

As of the 1st February 2021, we are no longer developing new ScriptRunner features that are compatible with IE11, and subsequent versions of ScriptRunner will not be compatible with IE11.

Bug Fixes

-   SRPLAT-1442 - Fragment validation now checks for null and/or empty module keys.
    
-   SRPLAT-1441 - The execution history syntax highlighting was fixed.
    
-   SRPLAT-1434 - The _Script Editor_ was fixed to show warning annotations. An example of a warning annotation is the usage of deprecated methods.
    
-   SRPLAT-1432 - `CheckedScriptFileInputBox` was fixed to run static type checking when a user returns to the tab.
    
-   SRPLAT-1431 - The _Script Editor_ was fixed to show an overall RAG status for a given file.
    
-   SRPLAT-1430 - The _Script Editor_ was fixed to run static type checking when a file is opened.
    
-   SRPLAT-1420 - Documentation links were corrected in the _Hints and Tips_.
    
-   SRCONF-1610 - The _Bulk Delete Attachment Versions_ built-in script was fixed to work for all space administrators.
    

## 6.18.0

Warning: This version is not compatible with IE11. Do not update to this version if you use IE11.

### Notifications Control for Copy Page Tree Space Administration

We're continuing to add more detailed notifications control to our built-in scripts. The [Copy Pages](https://docs.adaptavist.com/sr4c/latest/features/built-in-scripts/space-administration-built-in-scripts/copy-pages) built-in script for space administrators is the latest to be updated. Using the Notifications checkbox, choose if you want to send a notification to users when copying the page tree from _Advanced Space Functionality_.

New Features

-   SRPLAT-1414 - You can now configure LDAP resource environment properties.
    

Bug Fixes

-   SRPLAT-1412 - Internal database connections are now able to fall back to non-read-only.
    
-   SRPLAT-1401 - Running built-in scripts multiple times led to stuck loading spinners.
    
-   SRCONF-1017 - The _Next Run_ label for jobs had the wrong calculations.
    
-   SRPLAT-1407 - Groovy has been updated to 2.5.14.
    

## 6.17.0

Note: This is the last ScriptRunner version compatible with IE11.

Integration with Slack

We have added a new resouce type representing a connection to _Slack_.

That, plus a simple API, allows you to message users and channels from within your event listeners and other extension points. Read more [here](https://docs.adaptavist.com/sr4c/latest/features/resources/slack-connection).

New Bulk Delete Attachment Versions Built-In Script

A new [script](https://docs.adaptavist.com/sr4c/latest/features/built-in-scripts/space-administration-built-in-scripts/bulk-delete-attachment-versions) was added for Confluence space administrators to delete old attachment versions.

Notifications Control for Copy Page Tree

We're continuing to add more detailed notifications control to our built-in scripts. The [Copy Pages](https://docs.adaptavist.com/sr4c/latest/features/built-in-scripts/space-administration-built-in-scripts/copy-pages) built-in script is the latest to be updated. Using the Notifications checkbox, choose if you want to send a notification to users when copying the page tree.

-   SRCONF-1583 - An issue that causes _Copy Page Tree_ notifications to be sent to space watchers no matter the status of the checkbox has been reported.
    

Bug Fixes

-   SRPLAT-1271 - When using existing REST Endpoints that use an inline script, you could not switch to the File tab without an error.
    
-   SRCONF-1562 - Disabling the _Confluence Mentions_ plugin no longer disables ScriptRunner.
    
-   SRCONF-1553 - The details of the original author displayed for _Change Content Author_ script was not accurate.
    
-   SRCONF-1510 - The ScriptRunner-based _Page Info_ macro did not support an `@SELF` reference to the current page.
    
-   SRCONF-1087 - The _Bulk Delete Comments_ built-in script preview threw an error for anonymous-created comments.
    

## 6.16.0

### Better Handling for Templates in Create Page Macro

In this release, we improved support for using templates with the _Create Page_ macro. Now, when you select a template as the source to create a page from and that template contains [variable expressions](https://confluence.atlassian.com/doc/create-a-template-296093779.html#CreateaTemplate-Templatevariables), users will be directed to a form to provide values for those variables first.

Bug Fixes

-   SRPLAT-841 - The URL of the _Endpoint-scanning_ endpoint is now correctly mapped to the backend method.
    
-   SRCONF-1368 - _Prune Old Page Versions_ now works for blogpost pages.
    
-   SRCONF-436 - Mugshot gallery now filters disabled users.
    
-   SRCONF-1511 - Macros will work properly if they exist in the template selected in the _Create Page_ macro.
    

## 6.15.0

Bulk Delete Attachment Versions

A new [script](https://docs.adaptavist.com/sr4c/latest/features/built-in-scripts/space-administration-built-in-scripts/bulk-delete-attachment-versions) was added for Confluence administrators to delete old attachment versions.

New Features

-   SRCONF-1345 - A new _Change Content Author_ built-in script for Space Admins is now available.
    

Bug Fixes

-   SRCONF-950 - We have fixed an issue causing an error when copying sidebar links in the _Copy Space_ built-in script.
    

## 6.14.0

### Storing Environmental Variables

Want to simplify migrating from a test instance to production? Check out our new [Storing Environmental Variables](https://docs.adaptavist.com/sr4c/latest/best-practices-and-app-management/store-all-environment-specific-variables) documentation for best practices.

### Notifications Control for Bulk Delete Comments

We're continuing to add more detailed notifications control to our built-in scripts. The [Bulk Delete Comments](https://docs.adaptavist.com/sr4c/latest/features/built-in-scripts/space-administration-built-in-scripts/bulk-delete-comments) built-in script is the latest to be updated. Notifications are now suppressed by default when you run the script, but notifications can still be sent out by checking the appropriate box.

Bug Fixes

-   SRPLAT-1364 - Script Editor failed to open files with national characters created on 6.11.0.
    

## 6.13.0

### The Inherit Restrictions for Pages Built-In Script Was Converted to an Event Listener

Since the _Inherit Restrictions for Pages_ built-in script performed its duties when a new page was created, it operates like an event listener. Therefore, we removed the existing built-in script and transformed it into a canned ScriptRunner listener, which is the first of its kind.

If you are using the current script and benefiting from its functionality, then no further steps are required from you. Upon upgrade, a listener bearing the same parameters as your saved configuration is automatically created for you, and it is visible on ScriptRunner's _Event Listeners_ page.

See documentation for the new event listener [here](https://docs.adaptavist.com/sr4c/latest/features/event-listeners).

### The Bulk Delete Comments and Bulk Delete Attachments Built-In Scripts Now Operate On Descendants

When selecting a page using the page picker field, the scripts now delete comments from both the selected page(s) and their descendants. In the UI, children checkboxes are now disabled when the parent page is selected.

This is both less surprising and more consistent with how the page picker field shows up in our other built-in scripts.

### Bug Fixes

-   SRPLAT-1345 - Audit logging was added for _Settings_ changes.
-   SRCONF-1481 - The _Add/Remove Restrictions to Parent & Child Pages_ built-in script does not operate on subpages of selected page trees.
-   SRCONF-1413 - The _Old Content Notifier_ job threw an exception when ran manually.
-   SRCONF-1241 - The _Space Statistics_ built-in script added the total attachment size incorrectly.
-   SRCONF-1147 - The _Bulk Delete Attachments_ built-in script does not operate on subpages of selected page trees.
-   SRCONF-1146 - The _Bulk Delete Comments_ built-in script does not operate on subpages of selected page trees.

## 6.12.0

New Features

The [Add/Remove Restrictions](https://docs.adaptavist.com/sr4c/latest/features/built-in-scripts/space-administration-built-in-scripts/update-page-restrictions) built-in scripts has been added for space admins.

Bug Fixes

-   SRPLAT-1221 - Bitbucket/Confluence/Jira is no longer prevented from correctly shutting down when ScriptRunner is installed.
    
-   SRCONF-1209 - _Bulk Add/Remove Labels_ now has consistent case-sensitivity handling.
    
-   SRCONF-1181 - The editor no longer loads blank page when using a template with the _Create Page_ macro. See SRCONF-1479 for the feature request to add more advanced support for templates.
    

## 6.11.0

### Space Admin Permissions Moved to Settings Page

To be more consistent with the rest of the permissions and product settings, [permissions to restrict access to the Advanced Space Functionality](https://docs.adaptavist.com/sr4c/latest/get-started/settings) have been moved to the Settings tab.

Notably, this included some changes to the underlying data schema. These will be invisible to users who follow a normal upgrade path, but it will mean that downgrading to prior releases after upgrading and making changes to permissions could see those changes disappear after a downgrade.

Rename `titleTransform` to `pageTransform` for _Copy Page Tree_ and _Rename Pages_

The [Copy Pages](https://docs.adaptavist.com/sr4c/latest/features/built-in-scripts/space-administration-built-in-scripts/copy-pages) and [Rename Pages](https://docs.adaptavist.com/sr4c/latest/features/built-in-scripts/confluence-administration-built-in-scripts/rename-pages) built-in scripts have a blank code field that had the `titleTransform` closure included in the field's binding. The closure allows you to make modifications to pages during the copying and/or renaming process.

That `titleTransform` closure is now named `pageTransform`. Since the closure can [modify more than just the page title](https://community.atlassian.com/t5/Confluence-articles/Transforming-body-content-as-well-as-page-title-using/ba-p/1370402?tempId=eyJvaWRjX2NvbnNlbnRfbGFuZ3VhZ2VfdmVyc2lvbiI6IjIuMCIsIm9pZGNfY29uc2VudF9ncmFudGVkX2F0IjoxNjAwNzg3MTMxNDEzfQ%3D%3D), this name better describes it.

Bug Fixes

-   SRPLAT-1319 - Custom scripts returning String from `getHelpUrl()` did not work.
    
-   SRCONF-1407 - Script Jobs did not start after a restart.
    
-   SRCONF-1121 - Edit page restrictions prevented unauthorised users from using the _Create Page_ macro.
    
-   SRPLAT-1313 - Script configurations can now be saved with a blank inline script.
    
-   SRCONF-1453 - The _Legacy Page Information_ macro storage format was incompatible with the ScriptRunner-based _Page Info_ macro.
    

## 6.10.0

### Ceasing Development on 6

We are no longer developing new features for ScriptRunner versions running on Confluence 6. See our [Confluence 6 Development](ceasing-development-on-confluence-6.md) statement for more information.

### Bug Fixes

-   SRCONF-1420 - There was an exception when trying to run the _Rename Labels_ script.

## 6.9.0

### Bug Fixes

-   SRCONF-1408 - There is now better validation for missing labels in the _Rename Labels_ built-in script.
-   SRCONF-1330 - The _Page Property Reports Macro_ failed when it contained a custom macro.

## 6.7.0

### Retiring Support for Internet Explorer

From February 1st 2021 ScriptRunner will no longer support Internet Explorer.

Age Picker Field for Jobs

The [Prune Old Page Versions](https://docs.adaptavist.com/sr4c/latest/features/jobs/built-in-jobs/prune-old-versions-job) and [Old Content Notifier Job](https://docs.adaptavist.com/sr4c/latest/features/jobs/built-in-jobs/old-content-notifier-job) jobs have a more flexible and friendly way to specify the age of old content that needs to be cleaned up.

## 6.6.0

### Ability to Disable Switch User Built-in Script

The _Switch User_ built-in script allows administrator users to temporarily assume the identity of another user.

This script is enabled by default. However, if you have extremely strong compliance requirements, you may wish to disable this feature.

This release adds a toggle to the Settings tab to disable the Switch User built-in script. When the script is disabled, it is not accessible for any user (including system administrators).

### Notifications Control for Copy Space

Now when using the _Copy Space_ built-in script as a [Confluence administrator](https://docs.adaptavist.com/sr4c/latest/features/built-in-scripts/confluence-administration-built-in-scripts/copy-space) and/or [space administrator](https://docs.adaptavist.com/sr4c/latest/features/built-in-scripts/confluence-administration-built-in-scripts/copy-space), you can control whether Inline Comments and Page Comments are copied over. Additionally, notifications are now suppressed by default when you run the script, but notifications can still be sent out by checking the appropriate box.

### Bug Fixes

-   SRPLAT-1227 - Documentation links were missing from scripts.
    
-   SRPLAT-1217 - The _Switch to a Different User_ script banner broke TinyMCE 4 functionality.
    
-   SRCONF-1091 - On the _Database Connection Resources_ page, the checkbox overlapped with text.
    
-   SRCONF-1386 - The age picker field validation was fixed.
    
-   SRPLAT-1213 - "test on borrow" should be the default for LDAP connections
    
-   SRCONF-1009 - Some scripts do not link to proper location in docs
    
-   SRCONF-1386 - Fix Age Picker Field Validation
    

## 6.5.0

New Features

### Watch Descendants is Now a Native Feature of ScriptRunner for Confluence

We have (finally!) finished migrating the core feature of the _Notifications for Confluence_ plugin into ScriptRunner for Confluence as a native feature. Being able to watch the descendants of a page is a [much sought-after feature](https://jira.atlassian.com/browse/CONFSERVER-2853) in Confluence, and we're glad to make it an important ScriptRunner for Confluence feature. You can read more in the [descendants documentation](https://docs.adaptavist.com/sr4c/latest/features/watch-descendants).

### Upgrade Path

If you have the Notifications plugin installed, uninstall the old _Notifications_ plugin, then update ScriptRunner for Confluence. There won't be too much harm in having the old plugin installed alongside the update, but that creates two Watch Descendants checkboxes, which would be confusing for end-users.

If you weren't using the _Notifications_ plugin, you only need to upgrade ScriptRunner for Confluence as you normally would.

### Warning: No Data Migration

Any pages marked as _Watched_ by the old plugin are still watched, but the information about which ancestor pages have the Watch Descendants checkbox ticked will not be migrated. If you were using the old _Notifications_ plugin, end-users need to click Watch Descendants again on any pages that they wish to watch all descendants of.

Our rationale for avoiding data migration is that most of the problems with the old notifications plugin centered around its own migration tasks from an early data schema to a new one. Rather than put all ScriptRunner for Confluence customers at risk for similar problems, we decided to make a clean break between the old _Notifications_ plugin and the new one.

### A Word on Performance

We have tested the _Watch Descendants_ feature against very large page trees under high load. It performs consistently with [Atlassian's load profiles](https://confluence.atlassian.com/enterprise/confluence-data-center-load-profiles-946603546.html) for Confluence, and it performs as well as or better than the old _Notifications_ app, which was itself used in some large production instances of Confluence.

### Bug Fixes

-   SRPLAT-1213 - _Test on Borrow_ should be the default for LDAP connections.
    

## 6.4.0

### Bug Fixes

-   SRPLAT-11 - An invalid user-configured raw XML script fragment could have prevented the ScriptRunner plugin from enabling.

## 6.3.0

### New Features

-   SRCONF-1021 - The _Age Picker_ field for Bulk Delete Comments now gives you more flexibility to specify which comments to delete.

Bug Fixes

-   SRPLAT-1171 - The Confluence-specific `scriptMacroMetadataProvider` module no longer shows up in UPM for all ScriptRunner products.
    
-   SRCONF-713 - The gears icon for lazy loading on script macros was not loading and threw a 404 error.
    

## 6.2.0

### Bug Fixes

-   SRCONF-1051 - The link to a content indexing section led to a page with a missing tab error.

## 6.1.0

### New Features

-   SRCONF - 1020 - The _Age Picker_ field for _Bulk Delete Attachments_ now gives you more flexibility to specify which attachments to delete.

Bug Fixes

-   SRPLAT-1139 - Compilation failures in one script caused entire features to fail.
    
-   SRPLAT-1131 - You now have the ability to set all Hikari pool configuration parameters when using database connections.
    
-   SRPLAT-1094 - Autocompletion requests failed when requesting autocomplete after typing "Check."
    
-   SRCONF-1282 - Macros were broken on Windows Server.
    
-   SRCONF-1205 - ScriptRunner for Confluence is now compatible with the Confluence 7.5 EAP.
    

## 6.0.1

-   Released 12 May 2020

### Bug Fixes

-   SRPLAT-1119 - Classes in scriptrunner-api/spi no longer consumable by dependent plugins

## 6.0.0

-   Released 06 May 2020

Updates

Groovy Upgrade

The version of Groovy used by ScriptRunner has been upgraded from 2.4.15 to 2.5.11. Improvements and new features (like additional AST transformations, or the new `tap()` method) shipped in Groovy 2.5 are now available to ScriptRunner users. See the [Groovy 2.5 Release Notes](https://groovy-lang.org/releasenotes/groovy-2.5.html) for more information.

As with any dependency upgrade, breaking changes could potentially affect users' scripts. However, the breaking changes between Groovy 2.4 and 2.5 are relatively minor. The low-level nature of most of these breaking changes means they are unlikely to impact many ScriptRunner scripts if any.

Take a look at the list of breaking changes in the [Groovy 2.5 Release Notes](https://groovy-lang.org/releasenotes/groovy-2.5.html#Groovy2.5releasenotes-Breakingchanges) for further details.

IntelliJ Removal

This version removes all support for the IntelliJ IDEA plugin. See our previous [deprecation announcement](release-5-x.md) for our rationale and plans for the future.

Bug Fixes

-   SRPLAT-1092 - There is now DocLink support for absolute URLs
    
-   SRPLAT-1084 - The autocompletion window of the Script Console now closes correctly
    
-   SRCONF-1205 - ScriptRunner for Confluence is now compatible with the Confluence 7.5 EAP
