# Release 6.x

- Platform: data-center
- Space: SR4JS
- Hierarchy: release-notes
- Doc ID: doc-sr4js-101624449
- Source: https://docs.adaptavist.com/sr4js/latest/release-notes/release-6-x

Check out what's new for ScriptRunner for Jira Server.

## 6.58.1

14 Sept 2022 

**Jira 9.2** **compatibility**

ScriptRunner for Jira Server/Data Center is now compatible with [Jira 9.2](https://confluence.atlassian.com/jirasoftware/jira-software-9-2-x-release-notes-1163763245.html).

## 6.58.0

24 Aug 2022 

**New bugs fixed**

This release focuses on fixing bugs to improve your experience of ScriptRunner for Jira Server/Data Center. See the Jira issues in the release notes below for more detailed information.

**Bugs Fixed**

-   SRPLAT-1992 - Script files cause "Invalid duplicate class definition" error
-   SRPLAT-1322 - 404 on newFeatureDiscovery when loading up ScriptRunner pages
-   SRJIRA-6086 - Fragments Custom Web Item link velocity variables no longer working
-   SRJIRA-6070 - setFormValue on cascade fields incorrectly trigger behaviours fields changed warning message
-   SRJIRA-6041 - Behaviour server-side script not working if 'Issue Lock for Jira' is installed since SR 6.30.0

## 6.57.0

10 Aug 2022 

## Fixed Database Picker custom field

We fixed this issue, SRJIRA-5652, so the correct fields display. Previously when using the _Two Dimensional Filter Statistics_ gadget, incorrect fields displayed.

Please note, this fix has created a new index for statistics mappers to use. If you have custom picker fields (database, Idap, custom), and need to display their results in the dashboard (e.g. _Two D__imensional Filter Statistics_ gadget), you must perform a full or background re-index.

**New Features**

-   SRPLAT-1986 - Make code editors wider in locations outside script console
-   SRPLAT-1982 - Property shorthand completions for setters
-   SRJIRA-6077 - Allow Users to display private channels in the "Post a message to Slack" built-in script

**Bugs Fixed**

-   SRPLAT-1980 - No completions for uppercase variable names
-   SRPLAT-1935 - Web items used to create menu dropdowns no longer working
-   SRPLAT-1708 - Invalid event classes used in Listener configurations can cause the listener to fire for all events
-   SRJIRA-6058 - ScriptRunner menu items are showing for project administrators
-   SRJIRA-6023 - Basic view UI for issueFieldMatch and issueFieldExactMatch JQL functions doesn't allow non-administrator users to select a "Field Name" value
-   SRJIRA-5979 - Web item links add a ? to the end of the URL, which breaks some link destinations
-   SRJIRA-5652 - Database Picker custom field doesn't work as expected with Two Dimensional Filter Statistics Gadget

## 6.56.0

27 Jul 2022 

## Improvements when working with Custom Fields in the Editor

You told us that working with opaque custom field IDs is difficult when selecting the right field by ID and then later when reading code to understand which field is meant by an ID.

We have made some improvements to make it clearer to tie custom field IDs back to a more meaningful custom field name.

As a rule, we recommend using **names** rather than IDs to make your code more readable. However, it relies on people not changing the name and, to some extent, avoiding duplicate names. Where you need to use IDs, we also have suggested [a way to externalize them](https://docs.adaptavist.com/sr4js/latest/best-practices/write-code/store-all-environment-specific-variables).

### Completions

When using APIs that take a custom field _String_ or _Long_ identifier, we will also show the name and the type:

![](/sr4js/files/latest/101624449/348417419/1/1658338808000/rn-6.56.0-01.jpg)

This is helpful when writing your code but doesn't help others, or your future self, when reading this code later.

### Inlay Hints

When you use a literal ID in your code, an inlay hint will show beside it, containing the _Field name_ or _ID_, whichever is appropriate.

![](/sr4js/files/latest/101624449/348417417/1/1658338809000/rn-6.56.0-02.jpg)

And:

![](/sr4js/files/latest/101624449/348417418/1/1658338809000/rn-6.56.0-03.jpg)

These labels are not actually part of the code and will not be present if you copy them from the editor. 

We find these helpful but are considering supplying an option to turn them off, along with other editor features. [Let us know](https://the-adaptavist-group-support.atlassian.net/servicedesk/customer/portal/21) what you think.

**New feature**

-   SRJIRA-4450 - Enable listener for IssuePropertySetEvent

**Bug fixed**

-   SRPLAT-1953 - Adjust 'Inline / File' tab z-index

## 6.55.1

20 Jul 2022 

**Bug fixed**

-   SRPLAT-1963 - monaco editor loader.js is being loaded from CDN rather than the plugin

## 6.55.0

14 Jul 2022 

## Configuration Management for Jira (CMJ) integration

We've been working closely with our peers at Appfire to make the days of manual migration and change management, when it comes to ScriptRunner, a thing of the past. You can now use Configuration Manager for Jira (CMJ) to migrate configuration for the following ScriptRunner features:

-   REST Endpoints
-   Jobs
-   Workflow Conditions, Validators and Post functions
-   Script Fields
-   Resources
-   Fragments
-   Listeners
-   Behaviours

## ScriptRunner for Jira is easier to access than ever 

It’s now even simpler to navigate to ScriptRunner with two new shortcuts. Admins can now also access ScriptRunner for Jira:

-   via the cog icon in the top right, by selecting ScriptRunner in the **Jira Admin** menu
-   via the new ScriptRunner tab in the administration navigation menu.

![](/sr4js/files/latest/101624449/348417406/1/1657807225000/sr-menu.jpg)

## Upgrade checker

In major releases of Atlassian products, some classes, methods and fields are removed. If you use these and you don't change your code, your scripts will fail.  
In nearly all cases, these are deprecated for at least one major release cycle beforehand, to give you a chance to change your code.  
In this release, for Jira (for 9.0.0) and Bitbucket (for 8.0.0), we will show you these classes, methods and fields that have been removed in a subsequent major version, as a warning:

![](/sr4js/files/latest/101624449/348417410/1/1657732788000/image+%283%29.png)

Not all deprecations are relevant - sometimes things are deprecated but they are not removed. If this is the case they are marked as a warning but without the additional pending removal warning.

**New features**

-   SRPLAT-1929 Support completions within delegating closures in editor
-   SRJIRA-6045 Allowing the Hide UI Element feature to hide web sections

## 6.54.0

05 Jul 2022 

### **Performance Improvements**

This release contains some significant improvements to the compilation and execution of scripts.

This builds on some of the work done in SRPLAT-1925 to prevent deadlocks and benchmark key parts of the ScriptRunner codebase.

This change should be invisible to 90% of users, except perhaps as an improvement in the speed and reliability of ScriptRunner, which could improve the performance of Jira overall.

A key component of this change was increasing the minimum recompilation time for scripts from Groovy’s default 100 milliseconds to 1 second. Again, this change will be practically invisible, but if you’re 6 shots of espresso deep in a script debugging session, you’re live-tailing your log files, and you’re not seeing the changes you made to a script take effect instantaneously, we advise that you take one deep breath and check again before filing a bug report. 😉

While this is not the complete solution for SRPLAT-1922, users affected by that issue may notice a marginal performance improvement due to reducing needless access to their servers’ filesystem. That said, we are still exploring further improvements for the problems introduced by slow disks and so that ticket remains open.

**Bugs fixed**

-   SRPLAT-1928 - Completions fail in closures with no parameters
-   SRJIRA-5912 - Behaviour is not able to set field to required or not required when editing the Issue
-   SRJIRA-5835 - Behaviour on comment field not working for Service desk project

## 6.53.0

15 Jun 2022 

### New _Script Registry_ filtering feature

A new filter is available in the _Script Registry_. This filter, turned off by default, may be toggled on to view all failing scripts. Use the **Show only scripts that may require attention** toggle option to engage this feature.

Two significant bugs have been removed for this release:

-   An unexpected error with creating requests in Service Desk projects has been rectified.
-   A bug preventing the _Multiple Insight Object/s_ field read-only using Behaviours from behaving as expected when populating its values using the `setFormValue()` in the _Initialiser_ is removed.

**New feature**

-   SRJIRA-5513 - New Feature (Script Registry): Filtering ONLY "failed" scripts

**Bugs fixed**

-   SRJIRA-5963 - SR compatibility issue with Git Integration plugin
-   SRJIRA-5947 - ShowDialog and ShowFlag web item actions do not work on the customer portal
-   SRJIRA-5888 - Behaviours read-only doesn't work correctly for Multiple Insight Object/s field when using setFormValue() to set the Multiple Insight Object/s field in Initialiser

## 6.52.1

08 Jun 2022 

**Bugs fixed**

-   SRJIRA-5980 - Workflow functions fail on JVMs that do not support JFR

## 6.52.0

06 Jun 2022 

**New bug fixed and improvements**

This release focuses on fixing bugs to improve the experience of using ScriptRunner for Jira Server/Data Center. These include two issues related to web action items. See the Jira issues in the release notes below for more detailed information.

**Remote Event Listeners Functionality Removed**

Remote Event Listeners were deprecated with the 6.42.0 release. As of the 6.52.0 release, they have been completely removed from ScriptRunner for Jira. If you still require the functionality provided by the Remote Event listeners, a similar outcome can be achieved using a [REST Endpoint](https://docs.adaptavist.com/sr4js/latest/features/rest-endpoints) on the target instance communicating [via app links](https://docs.adaptavist.com/sr4js/latest/integrations/atlassian-products/via-app-links) or [remote control](https://docs.adaptavist.com/sr4js/latest/integrations/atlassian-products/remote-control).

**Bugs fixed**

-   SRPLAT-1925 - Thread Deadlocks in Concurrently Running ScriptRunner scripts
-   SRPLAT-1916 - Field name providers should show suggestions without having to enter empty quotes
-   SRPLAT-1540 - Remote Events are Broken
-   SRJIRA-5948 - Web item actions do not work if the web item key starts with a number
-   SRJIRA-5914 - Make sure jobs are runnable before calling getParameters
-   SRJIRA-5868 - ShowDialog and ShowFlag web item actions do not work in certain location
-   SRJIRA-4620 - After Create Remote Custom listener it changes to local custom listener
-   SRJIRA-4619 - JiraRemoteCustomListener using wrong uri path for confluence events
-   SRJIRA-4357 - Profields integration with "automation for Jira" Breaks when Scriptrunner is also enabled
-   SRJIRA-2801 - Not all Remote events are working

## 6.51.0

18 May 2022 

**Improved exception logging and navigation**

The highlights of release 6.51.0 include:

-   The JQL function, `linkedIssuesOf`, will follow links that have any type from a specified set.
-   Improved error tracing for inline behavior scripts.
    -   A link to the related behavior configuration is now provided when logging exceptions in behavior scripts.
-   Improved navigation to the Library section of the app.

  

**New features**

-   SRPLAT-1899 - Go to relevant section of Library from the App
-   SRJIRA-3471 - Extend linkedIssuesOfRecursive() to support multiple link types
-   SRJIRA-2874 - Log link to behaviour configuration URL when an exception is thrown

**Bugs fixed**

-   SRJIRA-5940 - Monaco editor doesn't show error markers in Script Registry
    
-   SRJIRA-5939 - truncate stack traces to user code when behaviours throw unhandled ex
    
-   SRJIRA-5936 - better handle var args for JQL functions
    
-   SRJIRA-5517 - Behaviour setFormValue() doesn't work correctly for Insight fields on JSD/JSM Customer Portal sometimes
    
-   SRJIRA-4061 - The batch.js file grows on Jira dashboard when ScriptRunner is installed/enabled
    

## 6.50.0

04 May 2022 

**New features**

-   SRJIRA-5907 - Place Custom Schedule Jobs at the top of the list

**Bugs fixed**

-   SRPLAT-1905 - REST endpoints break if an AppDynamics agent is present DONE
-   SRPLAT-1877 - Smart completions does not work for class completions in methods DONE
-   SRJIRA-5889 - The text in 'Template' & 'Condition' is missing when editing the built-in script 'Service Desk Template Comments'

## 6.49.0

20 Apr 2022 

**Bug fixed**

-   SRPLAT-1888 - inference of default closure parameter
-   SRPLAT-1887 - class completions and import quick fix fail when property called on method result
-   SRPLAT-1883 - Poor performance loading configurations due to excessive class initialisation
-   SRPLAT-1870 - Smart completion not working as expected with Opt+shift+space on mac
-   SRJIRA-5883 - Error occurs if user uses the search box and create a behaviour

## 6.48.1

08 Apr 2022 

**JQL UI Fix**

When certain 3rd party apps are installed that provide JQL functions, the JQL UI failed to load. This bug has been found and removed.

**Bug fixed**

-   SRJIRA-5887 - JQL UI fails to load if 3rd party JQL function apps are installed

## 6.48.0

04 Apr 2022 

**Supercharged Jira search is now for everyone**

ScriptRunner search functionality is now available in the _Basic_ search menu, accessible via the **More** dropdown. A simple interface now helps users get more specific and efficient than ever with their Issue searches, guiding them through how to use ScriptRunner’s powerful JQL functions.

For more information see our [JQL Functions](https://docs.adaptavist.com/sr4js/latest/features/jql-functions) documentation.

![](/sr4js/files/latest/101624449/348417348/1/1649082477000/more-drop-down.png)  
![](/sr4js/files/latest/101624449/348417349/1/1649082476000/add-jql-function.png)  
![](/sr4js/files/latest/101624449/348417347/1/1649082477000/issue-function.png)

**Bug fixed**

-   SRPLAT-1882 - Annotations completion lists all of the classes that are not annotations
-   SRPLAT-1875 - dismiss signature help when leaving a method
-   SRPLAT-1874 - completions on arrays do not work
-   SRPLAT-1871 - autocomplete does not suggest local variables inside a closure
-   SRPLAT-1867 - Import quick fix does not work for certain types of code structure
-   SRPLAT-1853 - Completions expand the page width, consequently they are not positioned correctly and get truncated
-   SRJIRA-5864 - signature help does not work for constructors when inside a closure
-   SRJIRA-5449 - Cascading field parent and child values cannot be cleared simultaneously in Behaviour

## 6.47.0

09 Mar 2022 

**A New Editor** 

We've replaced our in-app editor component with [Monaco](https://microsoft.github.io/monaco-editor/), the same editor that powers [Visual Studio Code](https://code.visualstudio.com/).

Importantly, this gives us a platform for future improvements. However, there are immediate benefits to this release: you get inline documentation (press **Control+Space** when completions are open), hover over methods and classes to see documentation, see completions automatically as you type, find and replace, and more. Learn more about using features of the new editor on our [Code Editor](https://docs.adaptavist.com/sr4js/latest/best-practices/write-code/code-editor) page.

Empowering Atlassian administrators to write code, however simple, is at the heart of what we do. We hope the new editor makes you more productive and you enjoy using it! Let us know what you think.

**New features**

-   SRJIRA-5723 - Improve performance of version related JQL functions when they are used in queries which specify projects

**Bugs fixed**

-   SRJIRA-5726 - JCMA Migration of ScriptRunner from Server to Cloud fails with 'Ambiguous method overloading' error.
    

## 6.46.0

09 Mar 2022 

**Bugs fixed**

-   SRPLAT-1805 - improve performance of UnusedImportsVisitor (static type checking)
-   SRPLAT-1788 - subclasses loaded with loadClass cannot be cast to their parent class
-   SRJIRA-5798 - update country picker scripts for new version of API
-   SRJIRA-5794 - Exclude jobs execution in audit log
-   SRJIRA-5791 - Cannot create Behaviour when AJS.params.baseURL returns wrong protocol

## 6.45.0

23 Feb 2022 

**New features** 

-   SRPLAT-1753 - View server log files should default to the mostly commonly used log file

**Bug fixed** 

-   SRPLAT-1773 - Error using Hide system or plugin UI element Web Fragment
-   SRPLAT-1695 - Script Editor requests to save when a file uses windows line endings
-   SRJIRA-5715 - Version related JQL functions do not gracefully handle versions associated with not existing projects

## 6.44.0

09 Feb 2022 

**Opt out of In-App Communications**

We have added the ability for users to opt out of in-App communications in ScriptRunner. This option is available in the Settings page. For more information on in-app notifications and how to disable them, see our [documentation](https://docs.adaptavist.com/sr4js/latest/get-started/settings/in-app-communications).

**New Features** 

-   SRPLAT-1715 - Allow the log file to be searchable in "View Server Logs"

**Bug fixed** 

-   SRPLAT-1766 - Binding Info links are not clickable in the Fragment Locator elements
-   SRJIRA-5734 - linkedIssuesOf shows issues from both ends of a link direction under certain circumstances
-   SRJIRA-5626 - Database Picker value length will cause it to not render properly in Dashboard Gadget
-   SRJIRA-5624 - Behaviour clear Description field with setFormValue("") and setFormValue(null) do not work in JSD Customer Portal
-   SRJIRA-2665 - Custom Web Item Dialog Doesn't Work in the Issue Navigator and Dashboards

## 6.43.0

26 Jan 2022 

**Log Files are Sorted Alphabetically in View Server Log Files Built-in Script** 

We have enhanced the View Server Log Files built-in script so that the files available in the **Log Files** field are sorted alphabetically, making it easier for you to find the required file. 

**Bug fixed** 

-   SRPLAT-1735 - Modification of a class within a script root which has a generic supertype causes unnecessary recompilation of all classes it depends on
-   SRPLAT-1734 - Script recompilation fails if a script depends on two classes (located in a script root) that have the same generic supertype and one of these classes is modified
-   SRPLAT-1729 - Refresh listener mechanism fails when listener configuration lacks event
-   SRPLAT-1719 - Can't clear value for "Number of lines" in log file viewer built in
-   SRJIRA-5697 - Behaviour is not working on the "Remaining Estimate" field 
-   SRJIRA-5671 - Behaviour script still executes for a field that is not on the issue screen
-   SRJIRA-5631 - Service desk comments can be incorrectly marked as internal by SR

## 6.42.0

12 Jan 2022 

**Remote Event Listeners are now Deprecated**

As of ScriptRunner 6.42.0 we have deprecated [Remote Event listeners](https://docs.adaptavist.com/sr4js/latest/features/listeners/built-in-listeners/remote-events). This is due to low usage and high maintenance costs. If you still require the functionality provided by the Remote Event listeners, a similar outcome can be achieved using a [REST Endpoint](https://docs.adaptavist.com/sr4js/latest/features/rest-endpoints) on the target instance communicating [via app links](https://docs.adaptavist.com/sr4js/latest/integrations/atlassian-products/via-app-links) or [remote control](https://docs.adaptavist.com/sr4js/latest/integrations/atlassian-products/remote-control). 

**Change to behaviour of `jiraUserPropertyEquals()` JQL function**

As part of the fix for [SRJIRA-5595](https://assist.adaptavist.com/browse/SRJIRA-5595), the behaviour of the `jiraUserPropertyEquals()` JQL function has changed. Previously, only active users would match when `jiraUserPropertyEquals()` was used, now both active and inactive users are returned. See our [documentation](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/user-functions#jiraUserPropertyEquals) for more information, and steps on how to edit your query to return only active users.

**Bug fixed** 

-   SRJIRA-5691 - 'Self-referencing filter' error triggered incorrectly
-   SRJIRA-5676 - Removing Behaviour mapping that mapped to all issue types or request types will remove other mappings under the same project or service desk
-   SRJIRA-5595 - JQL function jiraUserPropertyEquals does not return results if user is inactive

## 6.41.0

21 Dec 2021 

**Enhancement to the _Change Dashboard, Filter, or Board Ownership_ Built-in Script**

We have added the ability for Jira Software users to change the ownership of boards using this built-in script. Check out our [documentation](https://docs.adaptavist.com/sr4js/latest/features/built-in-scripts/change-dashboard-filter-or-board-ownership) for more information. 

**Change to the _Fires an Event when Condition is True_ Post Function and Listener** 

The _Fires an Event when Condition is True_ built-in [post function](https://docs.adaptavist.com/sr4js/latest/features/workflows/post-functions/fires-an-event-when-condition-is-true) and [listener](https://docs.adaptavist.com/sr4js/latest/features/listeners/built-in-listeners/fires-an-event-when-condition-is-true) now wraps the selected event in an [IssueEventBundle](https://docs.atlassian.com/software/jira/docs/api/8.5.1/com/atlassian/jira/event/issue/IssueEventBundle.html) instead of directly firing an IssueEvent.

**Bug fixed** 

-   SRPLAT-1705 - Do not serialize stacktraces of compilation errors and warnings as part of static type checking endpoint response
-   SRPLAT-1702 - class completions don't allow for same class names in different packages
-   SRPLAT-1700 - Listeners for events from other plugins break on plugin upgrade or UPM upgrade
-   SRPLAT-1697 - Description column in binding information modal is being HTML escaped
-   SRJIRA-5683 - Listeners do not work on Jira 8.21.0
-   SRJIRA-5670 - Getting failed to add rrd metrics - Unknown URI in pool errors in logs
-   SRJIRA-5668 - Automation for jira extension no longer showing binding variables for script
-   SRJIRA-5666 - Time Spent field does not trigger behaviours server-side script
-   SRJIRA-5665 - Query Profiler button appear in advanced search for non-admin users
-   SRJIRA-5657 - Refine date range for issuefunction 'commented' when using the 'on' parameter
-   SRJIRA-5649 - Scripted field pickers produces stacktrace during csv export when empty
-   SRJIRA-5646 - Unable to update sub-task created via built-in post-function when All fields are copied

  

SRJIRA-3316

Events fired by "Fires an event when condition is true" canned script no longer  
trigger Automation For Jira Rules

## 6.40.1

06 Dec 2021 

**Bug fixed** 

-   SRJIRA-5635 - The aggregateExpression () JQL function doesn't consistently show results

## 6.40.0

01 Dec 2021 

**Bug fixed** 

-   SRPLAT-1605 - Writing script execution metrics to RRD fails when the shared application directory is pointing at a Windows shared folder (SMB)
-   SRPLAT-1551 - ScriptEditor code is replaced when "undone"
-   SRJIRA-5647 - Security issue in expression JQL function
-   SRJIRA-5645 - custom picker text-only view is the entire "object"
-   SRJIRA-5598 - Scripted JQL functions not checking for recursion
-   SRJIRA-5586 - CSV export in save filter did not work if issue picker or LDAP picker field added into the column
-   SRJIRA-4929 - Using issuefunction 'commented' with the 'on' parameter returns results beyond 24 hours
-   SRJIRA-4483 - Script Fields value is not displayed in confluence application link

## 6.39.0

17 Nov 2021 

**Unicode Bidirectional Override Characters Vulnerability**

Recently, Atlassian highlighted a security vulnerability where special characters (unicode bidirectional override characters) were not rendered or displayed in the affected applications ([CVE-2021-42574](https://confluence.atlassian.com/security/multiple-products-security-advisory-unrendered-unicode-bidirectional-override-characters-cve-2021-42574-1086419475.html?_ga=2.55315369.322944566.1636375808-1942073108.1631538975&_gac=1.189917657.1634652234.CjwKCAjw2bmLBhBREiwAZ6ugo1cpOjQ1h9AEUL2W9gYWvJyaT-Vv4ducCVnxB0Q44hUZAev3pfAbLhoCAjIQAvD_BwE)). This vulnerability could affect ScriptRunner if a user were to copy malicious code from an untrusted source and execute it within ScriptRunner. To mitigate this risk, we have added highlighting for bidirectional characters everywhere in ScriptRunner you can enter code. For more information please take a look at our [blog post](https://www.adaptavist.com/blog/trojan-codes-in-atlassian-products-and-scriptrunner). 

![Example image of highlighted code](/files/126386317/442890035/1/1759140969000/Untrusted+Code+.png)

**Bug fixed** 

-   SRPLAT-1603 - The script editor breaks when switching between SR tabs
-   SRJIRA-5633 - ScriptRunner is breaking the issue navigator for anonymous users
-   SRJIRA-5625 - JQL ScriptRunner function button disappeared toggling between Advanced to Basic search
-   SRJIRA-5616 - Script Listeners do not have the option to detect Workflow Scheme events
-   SRJIRA-5611 - Getting error when trying to set default value in Issue Picker for Jira 8.16.0 and above
-   SRJIRA-5592 - Advanced Roadmaps for Jira no longer showing issue when the saved JQL filter including "issueFunction in linkedIssuesOf()"
-   SRJIRA-4037 - Workflow condition evaluation request cache key is not specific enough

## 6.38.0

03 Nov 2021 

**New features** 

-   SRJIRA-5519 - Ability to set the Portfolio/Roadmaps Parent Link field value with behaviours

**Bug fixed** 

-   SRJIRA-5615 - Having 'with' closure in a script makes type-checking failed and floods atlassian-jira.log
-   SRJIRA-5590 - System Label field setFormValue does not work JSD portal
-   SRJIRA-5579 - setFormValue do not work intermittently with multiple setFieldOptions
-   SRJIRA-5575 - Unable to clear Labels custom field using setFormValue in Behaviours
-   SRJIRA-5572 - setRequired and setReadOnly does not work if used in a Radio field in which options are restricted using setFieldOptions.
-   SRJIRA-5568 - Field value is preselected after setFieldOptions
-   SRJIRA-5562  -Multi-Issue Picker produces stacktrace during csv export when empty
-   SRJIRA-4737 - Unable to clear Labels using setFormValue in Behaviours
-   SRJIRA-2101 - simple scripted validator - STC says transientVars not available

## 6.37.0

20 Oct 2021 

**Script Editor Expand and Collapse Folders**

Folders in the [Script Editor](https://docs.adaptavist.com/sr4js/latest/features/script-editor) are now collapsed by default when the editor is opened. We have also added **Expand All** and **Collapse All** buttons to the _Script Editor_ heading, as well as the option to right-click a folder to expand it. 

![](/sr4js/files/latest/101624449/348416197/1/1634725754000/script-editor-release.jpg)

**Multi-Select is now Available for Dynamic Form Picker Fields**

There is now the option to create multi-select picker fields using [Dynamic Forms](https://docs.adaptavist.com/sr4js/latest/best-practices/dynamic-forms). 

**Bug fixed** 

-   SRJIRA-5539 - Script Registry does not validate any script display
-   SRJIRA-5533 - When using the built-in script to clear Groovy class loader, it only clears it from the current node
-   SRJIRA-5453 - Behaviour setRequired does not work properly with custom field that have quote in it's name. ie: "textField"
-   SRJIRA-5388 - Flag occur when there's setFormValue() on the field which set to hide on the field configuration
-   SRJIRA-5387 - CreateIssueDetails!init.jspa doesn't trigger Behaviour
-   SRJIRA-5296 - Even if the Field is not added to the Screen, the Field's Server-Side Behaviour is still able to work

## 6.36.0

06 Oct 2021 

This version and all subsequent versions are not compatible with IE11. Do not update to this version if you use IE11. For more information see our [Retiring Support for Internet Explorer](https://docs.adaptavist.com/sr4js/latest/release-notes/retiring-support-for-internet-explorer) page.

**Ability to Specify a Count to the hasAttachments JQL Function**

You can now specify a number of attachments when using the hasAttachments JQL function. For example, you can now search for issues with two or more PDF attachments. See our [documentation](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/attachments#id-.Attachmentsv8.x-hasattachements) for more information and use cases. 

**CORS Support for REST Endpoints**

Following the implementation of CORS support in Jira 8.9.0, we have added CORS support for ScriptRunner's custom REST endpoints. 

**Bug fixed**

-   SRPLAT-1613 - AuditedEventListener is causing performance issues
-   SRJIRA-5545 - Adding behaviours mappings is not being audit logged

## 6.35.0

22 Sept 2021 

This version is not compatible with IE11. Do not update to this version if you use IE11. For more information see our [Retiring Support for Internet Explorer](https://docs.adaptavist.com/sr4js/latest/release-notes/retiring-support-for-internet-explorer) page.

**Ability to Specify a Count to the hasLinks JQL Function**

You can now specify a number of link type when using the hasLinks JQL function. For example, you can now search for issues with two or more _blocks_ links. See our [documentation](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/issue-links#id-.IssueLinksv9.x-hasLinks) for more information and use cases. 

**Project Categories Available for Behaviour Mapping**

You can now map a behaviour to project categories rather than individual projects using a custom listener. See our [documentation](https://docs.adaptavist.com/sr4js/latest/features/behaviours/category-mappings) for more information.

**Bug fixed**

-   SRJIRA-5541 - Multiple Issue Picker field name is displayed in Jira's default language, ignoring the user's language setting

## 6.34.0

08 Sept 2021 

This version is not compatible with IE11. Do not update to this version if you use IE11. For more information see our [Retiring Support for Internet Explorer](https://docs.adaptavist.com/sr4js/latest/release-notes/retiring-support-for-internet-explorer) page.

**Bug fixed**

-   SRJIRA-5529 - archivedVersions JQL function does not return results if a version is in a project the current user cannot browse
-   SRJIRA-5503 - Script Registry slowly render code components when lots of inline scripts are defined
-   SRJIRA-5329 - Behaviours' getValue outputs null on Insight Object/s field
-   SRJIRA-4642 - Column in CSV export for database picker field showing ID instead of selected title

## 6.33.0

25 Aug 2021 

This version is not compatible with IE11. Do not update to this version if you use IE11. For more information see our [Retiring Support for Internet Explorer](https://docs.adaptavist.com/sr4js/latest/release-notes/retiring-support-for-internet-explorer) page.

**Bug fixed**

SRPLAT-1596 Script changes in Script Editor doesn't reflect in REST Endpoint even after clearing Groovy Classloader

-   SRPLAT-1211 - LogFileViewer implementation is suboptimal
-   SRJIRA-5372 - When selecting a single Issue from an Multi-Issue picker after entering a filter value, multiple issues tend get selected
-   SRJIRA-5294 - Behaviour Number Field getValue() shows NullPointerException when View Issue Screen is opened
-   SRJIRA-4961 - Sanitise cluster node IDs before use as rrd directory names

## 6.32.0

11 Aug 2021 

This version is not compatible with IE11. Do not update to this version if you use IE11. For more information see our [Retiring Support for Internet Explorer](https://docs.adaptavist.com/sr4js/latest/release-notes/retiring-support-for-internet-explorer) page.

**New Script Field**

We have added a new script field called [Custom Picker](https://docs.adaptavist.com/sr4js/latest/features/script-fields/built-in-script-fields/custom-picker), which you can use to set up a field which allows users to pick values from a list. 

Using this custom picker, you can pick a Jira object such as a **Version**, **User**, or **Component** when you want custom selection criteria that are not available when using the native field types. Or you may want to utilize it when picking from a list that can be searched using a REST API.

**New Workflow Functions**

We have added a [Copy Fields Values Post Function](https://docs.adaptavist.com/sr4js/latest/features/workflows/post-functions/copy-field-values) and a [Linked Issues Condition](https://docs.adaptavist.com/sr4js/latest/features/workflows/conditions/linked-issues-condition) to give you more built-in workflow functions that don't require coding. 

**Bug fixed**

-   SRJIRA-5437 - setting an Insight field from a field validator can cause an endless loop
-   SRJIRA-5428 - Using Insight Object selector in JSD do not trigger a behaviour
-   SRJIRA-5335 - The Behaviour is not able to update the Priority field on the Jira Service Desk

## 6.31.0

28 Jul 2021 

This version is not compatible with IE11. Do not update to this version if you use IE11. For more information see our [Retiring Support for Internet Explorer](https://docs.adaptavist.com/sr4js/latest/release-notes/retiring-support-for-internet-explorer) page.

**Issue Picker Customization Enhancements** 

We have enhanced the [Issue Picker](https://docs.adaptavist.com/sr4js/latest/features/script-fields/built-in-script-fields/issue-picker) field to bring you extended customization options. For example, instead of just showing the **Issue Key** and **Summary**, you can now choose any text field(s) to display. If that's not enough, you can programatically customize how your picker renders, what information appears in the drop-down, the number of search results, and much more. See our [Issue Picker Customizations](https://docs.adaptavist.com/sr4js/latest/features/script-fields/built-in-script-fields/issue-picker/issue-picker-customizations) documentation for more information.

**Copy Field Values Built-in Script**

We have updated the [Copy Field](https://docs.adaptavist.com/sr4js/latest/features/built-in-scripts/copy-field-values) [Values](https://docs.adaptavist.com/sr4js/latest/features/built-in-scripts/copy-field-values) built-in script to allow users to copy to/from the **Summary**, **Description**, and **Environment** system fields.

**New features** 

-   SRJIRA-4811 - Allow copying system fields in 'Copy Custom Fields' built-in script
-   SRJIRA-4798 - Customise information displayed by Issue Picker field
-   SRJIRA-4788 - Display more than 30 issues to select from, by default, in issue picker script field
-   SRJIRA-4010 - Issue picker search does not work when there are more then 10 issues that contain the same word
-   SRJIRA-3926 - Control how many issues are listed in the issue picker
-   SRJIRA-3568 - Customize IssuePicker Script field

**Bug fixed** 

-   SRJIRA-5393 - Typechecking errors with markupbuilder using mkp, and outputformatter
-   SRJIRA-5325 - Adding a default Value for Text field (multiline) Behaviour does not work properly if it is placed in another Tab.
-   SRJIRA-5163 - Using Issue Picker in a public project leads to HTTP error 401
-   SRJIRA-5088 - Behaviours for Insight Multiple field is using old values and Search Option returned a null value
-   SRJIRA-4598 - Behaviours Mapping to selected Issue Type not working

## 6.30.2

21 Jul 2021 

This version is not compatible with IE11. Do not update to this version if you use IE11. For more information see our [Retiring Support for Internet Explorer](https://docs.adaptavist.com/sr4js/latest/release-notes/retiring-support-for-internet-explorer) page.

**Bug fixed** 

-   SRJIRA-5427 - Behaviours admin UI fails to load if Jira Service Management is not installed

## 6.30.1

19 Jul 2021 

This version is not compatible with IE11. Do not update to this version if you use IE11. For more information see our [Retiring Support for Internet Explorer](https://docs.adaptavist.com/sr4js/latest/release-notes/retiring-support-for-internet-explorer) page.

**Bug fixed** 

-   SRPLAT-1576 - Script Editor | script is lost on saving after switching file
-   SRJIRA-5421 - Script fields tab crashes when configuration exists with no related custom field 
-   SRJIRA-5417 - Script Editor crashes when Jira is hosted on Windows Server
-   SRJIRA-5415 - Behaviours UI does not load if mapping for a deleted project exists

## 6.30.0

15 Jul 2021 

This version is not compatible with IE11. Do not update to this version if you use IE11. For more information see our [Retiring Support for Internet Explorer](https://docs.adaptavist.com/sr4js/latest/release-notes/retiring-support-for-internet-explorer) page.

**ScriptRunner Configuration Filtering by Project**

We have added a filter to the ScriptRunner script fields screen, allowing you to filter your ScriptRunner configurations by project. 

You can use this filter to gain an understanding of which ScriptRunner configurations exist in each project to assist in project-by-project migration.

**New features** 

-   SRJIRA-5227 - Filters onto SR configurations (Script Fields)

**Bug fixed** 

-   SRPLAT-1572 - Admin UI crashes if user has previously asked to be reminded later about ScriptRunner survey
-   SRJIRA-5377 - Field Required Validator Condition is not saved
-   SRJIRA-5367 - update script field view and column-view when previewing
-   SRJIRA-5361 - Scrolling to errors not working properly for behaviours in recent Jira versions
-   SRJIRA-5353 - setDescription() does not work on Checkboxes & Radio Buttons field when used alongside setFieldOptions()
-   SRJIRA-5351 - Behaviour setFormValue() return null on Edit screen for multi group picker field
-   SRJIRA-5350 - XSRF token dialog appear when edit Jira Service Management issue with behaviour
-   SRJIRA-5348 - Behavior to set field options resets the value when editing the issue if the field is set to Required
-   SRJIRA-4640 - Return to your session link missing for Switch User Built-in Script

## 6.29.0

30 Jun 2021 

This version is not compatible with IE11. Do not update to this version if you use IE11. For more information see our [Retiring Support for Internet Explorer](https://docs.adaptavist.com/sr4js/latest/release-notes/retiring-support-for-internet-explorer) page.

**New Workflow Functions**

You asked us for more built-in workflow functions that don't require coding, and we heard you! In this release we have added a [Field(s) Required Validator](https://docs.adaptavist.com/sr4js/latest/features/workflows/validators/field-s-required-validator) and [Condition](https://docs.adaptavist.com/sr4js/latest/features/workflows/conditions/field-s-required-condition).

**ScriptRunner Configuration Filtering by Project**

We have added a filter to the ScriptRunner workflow function and listener screens, allowing you to filter your ScriptRunner configurations by project. 

You can use this filter to gain an understanding of which ScriptRunner configurations exist in each project to assist in project-by-project migration.

**New features** 

-   SRPLAT-1557 - Remove unused pluginKey property from @PluginModule DONE
-   SRJIRA-4496 - Provide an easy method to get the displayed value of a database Picker Scripted Field

**Bug fixed** 

-   SRPLAT-1562 - Context variables are not resolved correctly
-   SRPLAT-1221 - Bitbucket/Confluence/Jira is prevented from correctly shutting down when ScriptRunner is installed
-   SRJIRA-5366 - ServiceProxyDestroyedException when creating or updating ScriptRunner mail handler
-   SRJIRA-5357 - Unable to create or edit ScriptRunner mail handler
-   SRJIRA-5343 - Obtaining text display value of picker custom fields should return unsanitised text value

## 6.28.0

16 Jun 2021 

This version is not compatible with IE11. Do not update to this version if you use IE11. For more information see our [Retiring Support for Internet Explorer](https://docs.adaptavist.com/sr4js/latest/release-notes/retiring-support-for-internet-explorer) page.

**New Workflow Function**

You asked us for more built-in workflow functions that don't require coding, and we heard you! In this release we have added a [Clear Field(s) Post Function](https://docs.adaptavist.com/sr4js/latest/features/workflows/post-functions/clear-field-s).

**New features** 

-   SRJIRA-3889 - Provide a workaround for how to make searching JQL functions case-insensitive

**Bug fixed** 

-   SRJIRA-5327 - setDescription() does not work on Checkboxes custom field
-   SRJIRA-5323 - setRequired() Error text for required field displayed as field.title.missing.value on service desk customer portal
-   SRJIRA-5322 - ScriptRunner Fails to Enable Due to NoUniqueBeanDefinitionException
-   SRJIRA-5317 - Behaviour is triggered when validator fails on full page issue create screen
-   SRJIRA-5315 - Cascading list unable to work properly using behaviour
-   SRJIRA-5308 - Behaviour for comments setting restriction as 'undefined' in Issue Edit Screen
-   SRJIRA-5301 - JQL function dateCompare does not accept scripted field as parameter
-   SRJIRA-5258 - Calling behaviour setHidden after setHelpText displays an error pop-up message
-   SRJIRA-4920 - Use Behaviour to setDescription on Radio Buttons not working
-   SRJIRA-4708 - Let dateCompare handle fields that return java.util.Date
-   SRJIRA-4663 - lastCommented and firstCommented in dateCompare() jql function comparison expression are interpreted as 01/01/1970 for issues without comments

## 6.27.0

02 Jun 2021 

This version is not compatible with IE11. Do not update to this version if you use IE11. For more information see our [Retiring Support for Internet Explorer](https://docs.adaptavist.com/sr4js/latest/release-notes/retiring-support-for-internet-explorer) page.

**New Workflow Function**

You asked us for more built-in workflow functions that don't require coding, and we heard you! In this release we have added a [U](https://docs.adaptavist.com/sr4js/latest/?contentKey=project-role-condition)[ser in Field(s) Validator](https://docs.adaptavist.com/sr4js/latest/features/workflows/validators/user-in-field-s-validator). 

**New archived Versions JQL Function**

We have added a new JQL function to return versions that have or have not been been archived. See our [documentation](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/versions#id-.Versionsv8.x-archivedversions) for more information.

**New features** 

-   SRJIRA-5291 - Improve name for 'Allows the Transition if this Query Matches a JQL Query' workflow condition
-   SRJIRA-5103 - Validator: "User in field"
-   SRJIRA-3711 - JQL Function: I want to display all issues where the version has not yet been archived
-   SRJIRA-3096 - The earliestUnreleasedVersionByReleaseDate JQL function needs a flag to allow Archived Versions to be ignored

**Bug fixed** 

-   SRJIRA-5304 - Unable to set Security Level to None using Built-in Post function
-   SRJIRA-5278 - releaseDate() JQL function returns inconsistent results when used with Jira endOfWeek() function
-   SRJIRA-5304 - Unable to set Security Level to None using Built-in Post function
-   SRJIRA-5278 - releaseDate() JQL function returns inconsistent results when used with Jira endOfWeek() function

## 6.26.0

20 May 2021 

This version is not compatible with IE11. Do not update to this version if you use IE11. For more information see our [Retiring Support for Internet Explorer](https://docs.adaptavist.com/sr4js/latest/release-notes/retiring-support-for-internet-explorer) page.

**New Workflow Function**

You asked us for more built-in workflow functions that don't require coding, and we heard you! In this release we have added the following workflow functions:

-   [User in Field(s) Condition](https://docs.adaptavist.com/sr4js/latest/features/workflows/conditions/user-in-field-s-condition)
-   [Add a Comment to this Issue](https://docs.adaptavist.com/sr4js/latest/features/workflows/post-functions/add-a-comment-to-this-issue) 

**Behaviours Enhancement**

Using Behaviours has been simplified.

Now, when setting form values for fields such as select lists, radio buttons, checkboxes, components, and versions etc,  you can use the display value rather than looking up the IDs of the options themselves. The same also applies when setting the available options:

Example: 

```
getFieldByName("My checkboxes").setFormValue(['Yes', 'Maybe'])
getFieldByName("My single select").setFormValue('Oranges')

getFieldByName("My versions field").setFieldOptions(['Version One', 'Version Two'])
getFieldByName("My radio buttons").setFieldOptions(['Yes', 'No'])
```

We will validate that the provided value(s) is acceptable for whatever context you are setting it in.

**New features** 

-   SRJIRA-5260 - User see the message"Service Desk with id X not found" if they have no browse permissions to a Service Desk project
-   SRJIRA-5257 - Allow setting field options by name rather than object or ID
-   SRJIRA-5151 - Post Function: Comment Issue
-   SRJIRA-5101 - Condition: "User in field"

**Bug fixed** 

-   SRPLAT-1546 - Pickers where value is an array unnecessarily reload values when changes are made to other form fields
-   SRJIRA-6619 - Behaviour inline scripts have line breaks removed when migrated using curl
-   SRJIRA-5390 - Regular Expression Validator is failing in Bulk Transition despite field value matching the Regular Expression Condition
-   SRJIRA-5290 - Workflow Validators show an incorrect error message with "InvalidInputException"
-   SRJIRA-5276 - Setting multi line string in Description field using behaviour is not reset if the project is changed
-   SRJIRA-5268 - Validation fails should provide a more accurate message when the field is not on the screen
-   SRJIRA-5265 - Behaviour's hideTab(FieldScreenTab tabToHide) will hide next tab on the right if tabToHide is empty
-   SRJIRA-5255 - Fix 3rd party plugin installation related flakiness in jira-browser tests
-   SRJIRA-5251 - When using a validator on the create transition, it claims the field is not on the screen
-   SRJIRA-5250 - Allow setting the form value of various fields by name rather than ID
-   SRJIRA-5248 - setFormValue(null) fails after setConfigParam() on Single Issue Picker field
-   SRJIRA-5241 - The cache from a project with the Restricting Issue Type behaviour doesn't appear to clear when changing Project using the Create Issue page
-   SRJIRA-5076 - Setting a form value via initialiser does not work in JSM Customer Portal for Description field using Wiki Style renderer
-   SRJIRA-5012 - Checkboxes in Automation for Jira became hidden with SR enabled
-   SRJIRA-4823 - Behaviours .setError() message mapped to specific Project / Issue Type persists once called and prevents issues being created in other mappings until page is refreshed.
-   SRJIRA-4697 - Execution History shows failures for validators

## 6.25.0

06 May 2021 

This version is not compatible with IE11. Do not update to this version if you use IE11. For more information see our [Retiring Support for Internet Explorer](https://docs.adaptavist.com/sr4js/latest/release-notes/retiring-support-for-internet-explorer) page.

**New features** 

-   SRJIRA-5031 - Update information displayed on the Behaviour switch flag
-   SRJIRA-4376 - Changing one field using field.setValue() should cause it's validator to execute

**Bug fixed** 

-   SRPLAT-1485 - Script Editor stays unchanged when browser window resized
-   SRJIRA-5239 - Setting a select list value can clear the value if it's not a valid option ID
-   SRJIRA-5009 - Allow "Split Custom Field Context" built-in script to continue when Jira returns issues that do not fully exist with the 'getIssueIdsWithValue' method
-   SRJIRA-3970 - Description field template configured using behaviour is not reset if the project is changed
-   SRJIRA-3418 - Field server-side behaviour scripts trigger when create/edit window opened before the user has interacted with the field

## 6.24.0

28 Apr 2021 

This version is not compatible with IE11. Do not update to this version if you use IE11. For more information see our [Retiring Support for Internet Explorer](https://docs.adaptavist.com/sr4js/latest/release-notes/retiring-support-for-internet-explorer) page.

**New Workflow Function**

You asked us for more built-in workflow functions that don't require coding, and we heard you! In this release we have added a [Project Role(s) Condition](https://docs.adaptavist.com/sr4js/latest/?contentKey=project-role-condition). 

**New features** 

-   SRJIRA-5096 - Condition: Users Roles
-   SRJIRA-5046 - Option to filter out inactive workflows when creating new Workflow Function in ScriptRunner

**Bug fixed** 

-   SRJIRA-5196 - Cannot blank out certain fields in certain workflow functions, eg SimpleScriptedValidator
-   SRJIRA-5182 - Service Desk mapped Behaviour's setFormValue() doesn't work after setFieldOptions()

## 6.23.0

07 Apr 2021 

This version is not compatible with IE11. Do not update to this version if you use IE11. For more information see our [Retiring Support for Internet Explorer](https://docs.adaptavist.com/sr4js/latest/release-notes/retiring-support-for-internet-explorer) page.

**New Workflow Functions**

You asked us for more built-in workflow functions that don't require coding, and we heard you! In this release we have added the following workflow functions:

-   [Group(s) Condition](https://docs.adaptavist.com/sr4js/latest/?contentKey=group-condition)
-   [User(s) Condition](https://docs.adaptavist.com/sr4js/latest/?contentKey=user-condition)
-   [Regular Expression Condition](https://docs.adaptavist.com/sr4js/latest/?contentKey=regular-expression-condition)
-   [Regular Expression Validator](https://docs.adaptavist.com/sr4js/latest/?contentKey=regular-expression-validator)

**Bug fixed** 

-   SRPLAT-1488 - Select list control very slow when there are a large number of items, such as in "Install web resource"
-   SRJIRA-5184 - The Built-In Copy Project feature is facing an issue when copying projects that contain Sub-Task
-   SRJIRA-5172 - Drop-down options of Context(s) field of Install web resource Script Fragment with 3 lines or more overlap with each other
-   SRJIRA-5131 - setHelpText() Help Text for Cascading Field is displayed at odd position on Service Desk Portal
-   SRJIRA-5124 - Using aui-select2 does not allow the field to be cleared
-   SRJIRA-5075 - Clone Issue, and links - Don't copy issue if issue type doesn't exist in target project

## 6.22.0

24 Mar 2021 

This version is not compatible with IE11. Do not update to this version if you use IE11. For more information see our [Retiring Support for Internet Explorer](https://docs.adaptavist.com/sr4js/latest/release-notes/retiring-support-for-internet-explorer) page.

**Bug fixed** 

-   SRJIRA-5149 - Failures in ScriptRunner validators when screen references custom field which is no longer installed
-   SRJIRA-5097 - Behaviours configuration parsing errors on instances where com.sun.xml.internal.fastinfoset.stax.factory.StAXInputFactory is configured as the system javax.xml.stream.XMLInputFactory implementation
-   SRJIRA-4598 - Behaviours Mapping to selected Issue Type not working

## 6.21.0

10 Mar 2021 

This version is not compatible with IE11. Do not update to this version if you use IE11. For more information see our [Retiring Support for Internet Explorer](https://docs.adaptavist.com/sr4js/latest/release-notes/retiring-support-for-internet-explorer) page.

Welcome to the new documentation site! We have updated the in-app documentation links to point here. Let us know if you encounter any issues via [our support portal](https://productsupport.adaptavist.com/servicedesk/customer/portal/2).

For previous versions of the documentation, please visit the [old documentation site](https://scriptrunner.adaptavist.com/6.20.0/jira/quickstart.html).

**ScriptRunner Workflow Functions**

We have moved ScriptRunner workflow functions to improve visibility. ScriptRunner functions are now visible alongside all other Jira workflow functions. See our [Workflows documentation](https://docs.adaptavist.com/sr4js/latest/features/workflows) for more information. 

**New features** 

-   SRJIRA-5040 - Make Copy Project built-in script respect the rank in source project
-   SRJIRA-5003 - In the script post-function 'Clones an Issue, and Links', have the option to clone sub-tasks as well
    
-   SRJIRA-5000 - Mail Handler error logs should be included in emails sent to Forward Email
    

**Bug fixed** 

-   SRJIRA-5091 - Add button is missing when creating a new scripted mail handler in Jira 8.15
-   SRJIRA-5059 - JQL function - two error messages are displayed when there are multiple boards with the same name
-   SRJIRA-5050 - Code completions fail when requesting completions after typing Scr
-   SRJIRA-3967 - Behaviours not getting set on Project and Issue Type fields at default Create Issue screen

## 6.20.0

24 Feb 2021 

This version is not compatible with IE11. Do not update to this version if you use IE11. For more information see our [Retiring Support for Internet Explorer](https://docs.adaptavist.com/sr4js/latest/release-notes/retiring-support-for-internet-explorer) page.

**New features**

-   SRPLAT-1205 \- The compile context in the _Script Editor_ is now set when opening it from a page where the script is being used, using the **Edit** icon.
    
-   SRJIRA-4988 \- You can now search keywords that match multiple **Columns** in the _Database Picker_ **Script Field**.
    
-   SRJIRA-4533 \- For our JQL functions, you can now refer to boards and sprints by IDs, and not just names.
    

## 6.19.0

11 Feb 2021 

This version is not compatible with IE11. Do not update to this version if you use IE11. For more information see our [Retiring Support for Internet Explorer](https://docs.adaptavist.com/sr4js/latest/release-notes/retiring-support-for-internet-explorer) page.

**Bug fixed**

-   SRPLAT-1442 \- Fragment validation now checks for null and/or empty module keys.
    
-   SRPLAT-1441 \- The execution history syntax highlighting was fixed.
    
-   SRPLAT-1434 \- The _Script Editor_ was fixed to show warning annotations. An example of a warning annotation is the usage of deprecated methods.
    
-   SRPLAT-1432 \- The script file selector was fixed to run static type checking when a user returns to the tab.
    
-   SRPLAT-1431 \- The _Script Editor_ was fixed to show an overall type checking status for a given file.
    
-   SRPLAT-1430 \- The _Script Editor_ was fixed to run static type checking when a file is opened.
    
-   SRPLAT-1420 \- Documentation links were corrected in the _Hints and Tips_.
    
-   SRJIRA-4984 \- Links to listeners in the _Script Registry_ now work for after disabling the listener.
    
-   SRJIRA-4749 \- The _Bulk Fix Resolutions_ built-in script now clears the **Resolved** date.
    
-   SRJIRA-4669 \- When changing the **Component/s** field with behaviours, components with similar names will not be removed.
    
-   SRJIRA-4193 \- '`setFormValue`' now works on the **Labels** custom field.
    
-   SRJIRA-4182 \- An issue in behaviours where an issue’s editable fields became read-only if a read-only field has been edited, has now been fixed.
    
-   SRJIRA-3999 \- Inactive users are now filtered out when fetching email recipients from a group.
    
-   SRJIRA-3931 \- Required fields configuration in behaviours are now correctly reflected.
    
-   SRJIRA-3896 \- The _Copy Project_ built-in script no longer randomises the order of service desk project request types.
    
-   SRJIRA-3884 \- You can now set the **Epic Link** and **Sprint** field values in the initialiser when a _Create Issue_ dialog is opened on top of the full-page _Create Issue_ screen.
    
-   SRJIRA-3372 \- Behaviours now make **Wiki Render** fields fully read-only.
    
-   SRJIRA-2758 \- You can now get system fields with the '`getFieldByName`' behaviour method.
    

## 6.18.0

29 Jan 2021 

This version is not compatible with IE11. Do not update to this version if you use IE11. For more information see our [Retiring Support for Internet Explorer](https://docs.adaptavist.com/sr4js/latest/release-notes/retiring-support-for-internet-explorer) page.

**New features**

-   SRPLAT-1414 \- You can now configure LDAP resource environment properties.
    
-   SRJIRA-4950 \- Ability for search keyword to match multiple Search Attributes in LDAP Picker Script Field
    
-   SRPLAT-1407 \- Groovy has been updated to 2.5.14.
    

**Bug fixed**

-   SRPLAT-1412 \- Internal database connections are now able to fall back to non-read-only.
    
-   SRPLAT-1401 \- Running built-in scripts multiple times led to stuck loading spinners.
    
-   SRJIRA-4971 \- Setting ReadOnly on a required field no longer displays an error message if you do not leave the field before hitting enter.
    
-   SRJIRA-4949 \- The value of the selected option in an _LDAP Picker_ script field is now formatted correctly.
    
-   SRJIRA-4937 \- The _Copy Project_ built-in script no longer displays the target project twice in the _Issue Type Scheme_ after copying a project.
    
-   SRJIRA-4817 \- The setHidden method is now working correctly when run together with `setFieldOptions` in a behaviour.
    
-   SRJIRA-4728 \- _Simple Scripted Validators_ now show the configured error message when used with _Original Estimate_.
    
-   SRJIRA-4723 \- Read-only values are no longer lost when configuring _Edit_ screen fields for user pickers.
    
-   SRJIRA-4643 \- The _Copy Project_ built-in script now assigns the correct project key for the JQL in created queues.
    
-   SRJIRA-4575 \- The dash symbol (-) is now recognised in JQL queries when using `issueFunction` in `dateCompare`.
    
-   SRJIRA-4361 \- Behaviours disabled inline edit can no longer be overridden by the `.` or `gg` command/menu.
    
-   SRJIRA-4270 \- Selecting or unselecting the **All** option from the **Custom Fields Cog** no longer causes the value set in the _Read Only Single Select List_ to reset to _None_ even by users who have limited access.
    
-   SRJIRA-2850 \- Toggling between **All** and **Custom** in the **Configure Fields** drop-down no longer blanks fields set as read-only by behaviours.
    

## 6.17.0

14 Jan 2021 

This is the last ScriptRunner version compatible with IE11. For more information see our [Retiring Support for Internet Explorer](https://docs.adaptavist.com/display/SR4JS/.Retiring+Support+for+Internet+Explorer+v6.21.0) page.

**Integration with Slack**

We have added a new resource type representing a connection to _Slack_.

That, plus a simple API, allows you to message users and channels from within your event listeners and other extension points. Read more [here](https://docs.adaptavist.com/display/SR4JS/.Slack+Connection+v6.20.0).

**New features**

-   SRJIRA-3925 \- We have added a new Slack resource type.
    

**Bug fixed**

-   SRPLAT-1271 \- When using existing REST Endpoints that use an inline script, you could not switch to the **File** tab without an error.
    
-   SRJIRA-4927 \- We have fixed a bug where picker fields did not work on Jira Service Management portal when the project key pattern was different from the default.
    
-   SRJIRA-4857 \- Only issue events are available to be selected for the _Fast track/fire an event when condition is true_ listener.
    
-   SRJIRA-4626 \- Only issue events are available to be selected for the _Fast track/fire an event when condition is true_ listener.
    
-   SRJIRA-4327 \- The Script Registry now understands when there is an event object in the context of a listener.
    
-   SRJIRA-4221 \- The _Send a custom email_ listener now correctly sends new attachments when users add comments in quick succession.
    
-   SRJIRA-4181 \- The JQL search component, found for example in Escalation Services, now correctly handles punctuation in custom field names.
    
-   SRJIRA-3128 \- You can now pick custom fields with names under three characters as **To/CC** issue fields for custom emails.
    

## 6.16.0

16 Dec 2020 

**New ScriptRunner Action for Automation for Jira**

Automation for Jira has released a new API for third-party integrations. This allows us to provide some requested enhancements, such as the ability to retrieve the _initiator_ of the action, and the ability to use _smart values_. We have also added the ability to use [dynamic forms](https://docs.adaptavist.com/sr4js/latest/best-practices/dynamic-forms).

Because the API was so different, we have decided to provide a new action and deprecate the original one. If you need the new action, copy your script from the old action to the new, and remove the old one.

Read more in our documentation on [Automation for Jira](https://docs.adaptavist.com/sr4js/latest/integrations/automation-for-jira).

**Workflows Tab**

You can now view, edit, delete and disable/enable ScriptRunner workflow functions from the **Workflows** tab. We have also made it easier to create a new ScriptRunner workflow function, by adding this functionality to the **Workflows** tab. See our [workflow functions documentation](https://docs.adaptavist.com/sr4js/latest/features/workflows) for more information.

**New features**

-   SRJIRA-4806 \- You can now use smart values in the _Execute a ScriptRunner script_ action.
    
-   SRJIRA-3621 \- We now support `>=` operators in the dateCompare JQL function.
    

**Bug fixed**

-   SRPLAT-841 \- The URL of the _Endpoint-scanning_ endpoint is now correctly mapped to the backend method.
    
-   SRJIRA-4907 \- **Database Picker** fields no longer change to show the internal ID instead of the selected value after a comment is added from the service desk portal.
    
-   SRJIRA-4900 \- The Automation for Jira integration now provides two actions. The new action makes use of the updated Automation for Jira API
    
-   SRJIRA-4895 \- Script fields upgrade tasks no longer fail if there is data in a newer format.
    
-   SRJIRA-4891 \- Using key combinations to select all script text and then pressing delete, now works within behaviour script editor sections.
    
-   SRJIRA-4882 \- The currentUser binding variable in Automation for Jira is no longer null when the **Actor** username has been renamed.
    
-   SRJIRA-4801 \- You can now copy SLAs for service desk projects using **Copy Project**.
    
-   SRJIRA-4220 \- In the case of a `StackOverflowError` during the manual execution of a job, the user is now informed on how to solve the issue.
    
-   SRJIRA-4126 \- There is no longer a _String index out of range_ error when clicking on links in _Script Registry_ page.
    
-   SRJIRA-4125 \- setHidden,setLabel,setDescription now work for the behaviours **Attachment** field on the service desk portal.
    
-   SRJIRA-4074 \- Heritage listeners can now be referred to by file path.
    
-   SRJIRA-3465 \- `UserMessageUtil.error` method now displays the error message correctly for inline field edits or edits from the _Boards_ page.
    

## 6.15.0

02 Dec 2020 

**New features**

-   SRJIRA-4862 \- We improved the project picker for _Version Synchroniser_ listeners, to help when adding new projects to an existing configuration.
    
-   SRJIRA-4832 \- For _Issue Picker_ fields, we now display the issue summary when in list view in the _Issue Navigator_.
    
-   SRJIRA-4247 \- The _Project Picker_ dynamic form can now be customised to show or not show archived projects.
    
-   SRJIRA-3962 \- An _Issue Picker_ template is now available for _Custom Script Fields_ if you are returning one or more issues from your script.
    

**Bug fixed**

-   SRJIRA-4883 \- Empty list rendering was causing an infinite loop call in the _Bulk Copy SLA_ built-in script.
    
-   SRJIRA-4876 \- We fixed an issue where `getRequestTypeName` in behaviours did not work for users without a Jira Service Management license.
    
-   SRJIRA-4874 \- We fixed a bug where, when creating an issue anonymously with a _Database Picker_ or _Issue Picker_, it would fail with HTTP 500 error.
    
-   SRJIRA-4872 \- We fixed an issue where the _Create Sub-task_ post function failed when the parent had an epic link, on recent versions of Jira.
    
-   SRJIRA-4861 \- We improved the control for setting a template for a _Custom Script Field_.
    
-   SRJIRA-4848 \- We fixed a problem where the listener **Events** field no longer shows a loading animation when retrieving events list.
    
-   SRJIRA-4810 \- We fixed a problem where `setAllowInlineEdit` stopped working in the _Behaviour Initialiser_.
    
-   SRJIRA-4800 \- Comment visibility JQL functions now return correct results after a software/core project converted to Jira Service Management.
    
-   SRJIRA-4743 \- Behaviour to set checkbox/radio buttons as _Required_ now correctly removes "(optional") text, and the _None_ option.
    
-   SRJIRA-4114 \- _Text Field (Multi-line)_ template no longer goes blank on additional tab, and the **Description** field template is no longer reset.
    
-   SRJIRA-2664 \- It is now possible to clear the value of the **Epic Link** field in a behaviour.
    

## 6.14.0

19 Nov 2020 

When using the single or multiple [issue picker](https://docs.adaptavist.com/display/SR4JS/.Issue+Links+v6.21.0) fields, you can now find issues by a query on the issues that they link to. See the [issuePickerField](https://docs.adaptavist.com/display/SR4JS/.Issue+Links+v6.21.0) function for more information.

**Storing Environmental Variables**

Want to simplify migrating from a test instance to production? Check out our new [Storing Environmental Variables](https://scriptrunner.adaptavist.com/latest/jira/environmental-variables.html) documentation for best practices.

**New features**

-   SRJIRA-4827 \- You can now search for _Issue Picker_ field values by **Issue Summary**.
    

**Bug fixed**

-   SRPLAT-1364 \- Script Editor failed to open files with national characters created on 6.11.0.
    
-   SRJIRA-4839 \- We fixed a bug where invalid format errors did not appear in _Edit_ screen when scripted fields were present.
    
-   SRJIRA-4836 \- An issue causing the script file to disappear from the UI for REST Endpoint scripts has been fixed.
    
-   SRJIRA-4826 \- We fixed a bug where under certain circumstances a bulk move failed.
    
-   SRJIRA-4822 \- We fixed a problem where if you added or edited a resource, a failure in another resource could prevent refreshing.
    
-   SRJIRA-4792 \- The hasLinkType JQL function no longer breaks JSD queues when the referenced link type is renamed.
    
-   SRJIRA-3751 \- We fixed a problem where filters using date/time methods with the `expression` JQL function, would intermittently fail.
    

## 6.13.1

11 Nov 2020 

**Bug fixed**

-   SRJIRA-4852 \- We fixed a problem where a javascript error could prevent certain other plugins displaying correctly.
    

## 6.13.0

05 Nov 2020 

**New features**

-   SRJIRA-4794 \- _Database Picker_ fields now use the _Display Value_ instead of _ID_ in email notifications.
    

**Bug fixed**

-   SRPLAT-1345 \- Audit logging was added for _Settings_ changes.
    
-   SRPLAT-1302 \- Secure shell options have been expanded to include boolean literals and negation.
    
-   SRJIRA-4821 \- A bug causing _Issue Picker_ and _Database Picker_ fields to copy the value to the left of the cell, when no value was present in the issue navigator, has been fixed.
    
-   SRJIRA-4529 \- Fields set as read-only in a behaviour initialiser are now correctly prevented from being edited inline.
    
-   SRJIRA-3783 \- The Behaviours `setRequired` method for the **Tempo Account** and **Teams** field no longer allows you to submit the value _None_.
    
-   SRJIRA-2230 \- The post function _Assign to Last Role Member_ now correctly picks the previously assigned user from the specified role.
    

## 6.12.0

22 Oct 2020 

**Potentially Breaking Change**

Previously, you could enable sorting in JQL queries through the use of the `getSortValue` closure and `sortAttribute` property in _Database_ and _LDAP_ pickers respectively.

These are now redundant. If you had implemented these, and don’t make any changes, the sort order may not be what it was before upgrading. Assuming you want the default value to be indexed and to be used for sorting, it’s safe to remove them. Otherwise, see the new configuration options at [_Database Picker_](https://docs.adaptavist.com/display/SR4JS/.Database+Picker+v6.20.0) or [_LDAP Picker_](https://docs.adaptavist.com/display/SR4JS/.LDAP+Picker+v6.19.0).

**New features**

-   SRJIRA-3852 \- We now index _Database Picker_ fields on display value.
    

**Bug fixed**

-   SRPLAT-1221 \- Bitbucket/Confluence/Jira is no longer prevented from correctly shutting down when ScriptRunner is installed.
    
-   SRJIRA-4779 \- The _Behaviours_ feature now scrolls to fields in errors on submit, for all types of fields.
    
-   SRJIRA-4759 \- We fixed a problem where it was not possible to stop watching an issue after the _Add Watcher_ post function triggered.
    
-   SRJIRA-4755 \- We fixed a problem where _Database Picker_ field values were not saved if you left inline edit active while creating a new issue in a modal window.
    
-   SRJIRA-4747 \- The behaviour to clear the value of a selection list field now works in JSD portal.
    
-   SRJIRA-4735 \- There is no longer a `NullPointerException` on Pie Chart gadgets using _Scripted Issue Picker_ custom fields.
    
-   SRJIRA-4724 \- JiraProjectPicker now returns `projectId` as an immutable project identifier.
    
-   SRJIRA-4623 \- The _Database Picker_ field can now set the field’s value using `setFormValue` on Jira Service Desk.
    
-   SRJIRA-2191 \- _Split Custom Field Contexts_ built-in script now works properly for a cascading select list.
    

## 6.11.0

08 Oct 2020 

A new feature-length tutorial has been added on using the database picker with a raft of customisations, based on a real external database running in a docker container. Take a look at the [Country Picker](https://scriptrunner.adaptavist.com/6.12.0/jira/script-fields/database-picker-world-countries.html) tutorial.

In ScriptRunner 7 there will be potentially breaking changes for users of the Database Picker - see [breaking changes](https://docs.adaptavist.com/display/SR4JS/.Breaking+Changes+v6.19.0).

**New features**

-   SRJIRA-4707 \- You can now search for a lower case issue key in the **Issue Picker** field.
    
-   SRJIRA-2563 \- We now support using behaviours with Mindville Insight custom fields.
    

**Bug fixed**

-   SRPLAT-1319 \- Custom scripts returning String from `getHelpUrl()` did not work.
    
-   SRJIRA-4719 \- renderColumnHtml closure is no longer called with wrong parameters.
    
-   SRJIRA-4710 \- Clone Plus for Jira add-on now works for issues with **Issue Picker** fields.
    
-   SRJIRA-4699 \- Dynamic forms _ProjectRolePicker_ now persists data correctly.
    
-   SRJIRA-4696 \- **LDAP Picker** fields now have their values automatically html-encoded.
    
-   SRJIRA-4690 \- **Database Picker** fields no longer cause an exception in **Issue Search**.
    
-   SRJIRA-4688 \- There is no longer an error when moving an issue without an **Issue Picker** field to an issue type with an **Issue Picker** field.
    
-   SRJIRA-4686 \- **Database Picker** fields can now be sorted by clicking the column header in the issue navigator.
    
-   SRJIRA-4638 \- Behaviour page no longer fails to load with the `Cannot read property 'scriptPath' of undefined` error.
    
-   SRJIRA-3937 \- There are no longer hidden lines in the Script Editor
    
-   SRJIRA-2867 \- _Show parent issue in hierarchy_ Script Field no longer breaks when target issue has a parent.
    
-   SRPLAT-1302 \- We have expanded secure shell options to include boolean literals and negation.
    
-   SRPLAT-1313 \- Script configurations can now be saved with a blank inline script.
    

## 6.10.0

23 Sept 2020 

**Ceasing Development on Jira 7**

We are no longer developing new features for ScriptRunner versions running on Jira 7. See our [Jira 7 Development](https://docs.adaptavist.com/display/SR4JS/.Ceasing+Development+on+Jira+7+v6.19.0) statement for more information.

**Bug fixed**

-   SRJIRA-4681 \- Jira agile functions such as `previousSprint` and `nextSprint` fail in a safe way when security is overridden.
    
-   SRJIRA-4670 \- **Picker** fields no longer incorrectly sanitise the entirety of the "view html", rather than just DB or LDAP record.
    
-   SRJIRA-4662 \- **firstCommented** and **lastCommented** fields available in the `dateCompare()` jql function comparison expression now work as expected.
    
-   SRJIRA-4649 \- Webhooks that use `previousSprint` in their JQL query no longer fail with a NullPointerException.
    
-   SRJIRA-4611 \- **Issue Picker** required fields now register a valid selection correctly.
    
-   SRJIRA-4598 \- Behaviours mapping to a selected issue type is now working correctly.
    
-   SRJIRA-4412 \- _IssueLinkCreatedEvent_ and _IssueLinkDeletedEvent_ are no longer triggered when the project is not included in the listener’s **Project** field.
    
-   SRJIRA-3634 \- Script listeners that react to `ProjectComponent` \-based events now take the **Project** field into account.
    

## 6.9.1

14 Sept 2020 

**Bug fixed**

-   SRJIRA-4672 \- lastUpdate() issue function was not working correctly for issues without comments in ScriptRunner 6.9.0.
    

## 6.9.0

09 Sept 2020 

**New features**

-   SRJIRA-4501 \- The workflow error output was improved to make it easier to find the workflow and transition where the script is configured.
    

**Bugs fixed**

-   SRJIRA-4596 \- Indexing failed because the `sr_num_atch` field was sometimes added multiple times per index document in Jira 8.10+.
    
-   SRJIRA-4586 \- Compatibility with Jira 8.12 was added.
    
-   SRJIRA-4332 \- Behaviours were not highlighting a tab when a field is required.
    
-   SRJIRA-4270 \- Selecting or unselecting the _All_ option from the **Custom Fields** cog caused the value set in the _Read Only Single Select List_ to reset to _None_ even by users who have limited access.
    
-   SRJIRA-4121 \- LDAP and the database picker did not work when when the custom field context contained issue types. Additionally, the pickers were fixed for Service Desk users.
    
-   SRJIRA-4021 \- Inline edit was not disabled by behaviours when it should have been on the _Issue Details_ page for Jira 8 for certain board pages.
    
-   SRJIRA-3563 \- The _Bulk Copy_ SLA broke automation rules with "SLA time remaining" in a `WHEN` statement.
    

## 6.7.0

27 Aug 2020 

**Retiring Support for Internet Explorer**

From Feburary 1st 2021 ScriptRunner will no longer support Internet Explorer. See our [full statement](https://docs.adaptavist.com/display/SR4JS/.Retiring+Support+for+Internet+Explorer+v6.21.0) for more information.

**New features**

-   SRJIRA-4527 \- Text search now looks for a match of the entire string first in Issue Picker fields.
    
-   SRJIRA-4449 \- **Issue Picker** script fields now display up to 30 preview issues.
    
-   SRJIRA-4160 \- You can now store all environment-specific variables.
    

**Bugs fixed**

-   SRJIRA-4590 \- The information logged in the _Indexing Stats Performance_ report has been improved.
    
-   SRJIRA-4578 \- **Picker** fields have been made stattable to allow them to appear in certain gadgets.
    
-   SRJIRA-4576 \- You can now update the SQL in **Database Picker** fields.
    
-   SRJIRA-4573 \- You can now change the display attribute in **LDAP Picker** fields.
    
-   SRJIRA-4488 \- _DiagnosticsLoggerManager_ is compatible with `com.atlassian.logging.log4j.layout.JsonLayout` on Jira 8.
    

## 6.6.0

12 Aug 2020 

**Customising Database and LDAP Pickers**

You can now customise LDAP and database pickers using the _Configuration Script_ option. Use this to customise the displayed value, add additional information to the picker drop-down, customise the search filter, and more. For examples of these and more information on how you can use this functionality, see our [Database Picker](https://docs.adaptavist.com/display/SR4JS/.Database+Picker+v6.20.0) and [LDAP Picker](https://docs.adaptavist.com/display/SR4JS/.LDAP+Picker+v6.19.0) documentation.

  

**Ability to Disable Switch User Built-in Script**

The _Switch User_ built-in script allows administrator users to temporarily assume the identity of another user.

This script is enabled by default. However, if you have extremely strong compliance requirements, you may wish to disable this feature.

This release adds a toggle to the **Settings** tab to disable the Switch User built-in script. When the script is disabled, it is not accessible for any user (including system administrators).

For more information, see the [Disable Switch User Built-in Script documentation](https://docs.adaptavist.com/display/SR4JS/.Settings+v6.21.0#id-.Settingsv6.21.0-switch-to-different-user).

**New features**

-   SRJIRA-4500 \- Behaviours can now be enabled/disabled independently. Actions related to each behaviour have been moved into the **Cog** menu.
    
-   SRJIRA-3996 \- _Database Picker_ field queries can be generated using attributes of the current issue.
    

**Bugs fixed**

-   SRPLAT-1228 \- An issue causing parameters to be garbled when adding a project filter to a query containing a picker field has been fixed.
    
-   SRPLAT-1227 \- Some documentation links were missing from scripts.
    
-   SRPLAT-1217 \- _Switch to Different User_ script banner no longer breaks TinyMCE 4 functionality.
    
-   SRJIRA-4543 \- _Database Picker_ values are now sortable in JQL queries.
    
-   SRJIRA-4521 \- ScriptRunner javascript was incompatible with the **Microsoft Azure Active Directory single sign-on for JIRA** plugin.
    

## 6.5.0

23 Jul 2020 

**Bugs fixed**

-   SRPLAT-1213 \- _Test on borrow_ is now the default for LDAP connections.
    
-   SRJIRA-4509 \- Script fields now work correctly on Jira Service Desk when there are multiple request types corresponding to the same issue type.
    
-   SRJIRA-4463 \- Script Fragment errors now logs information users can use to find the broken fragment.
    
-   SRJIRA-4418 \- Behaviours no longer overwrite other behaviour scripts.
    
-   SRJIRA-3366 \- The **View in Issue Navigator** button has been updated to show the correct results.
    
-   SRJIRA-4517 \- ScriptRunner is now compatible with Jira 8.11.
    
-   SRJIRA-4451 \- javax.mail.Session creation no longer fails in Jira 8.10.0.
    

## 6.4.0

02 Jul 2020 

**JQL function: memberOfRole**

Use `memberOfRole` to find issues where the value of a user field is a member of a given role, for example:

```
issueFunction in memberOfRole("Reporter", "Administrators")
issueFunction in memberOfRole('Approvers', 'Service Desk Team')
```

See our documentation on [memberOfRole](https://docs.adaptavist.com/display/SR4JS/.User+Functions+v6.21.0#id-.UserFunctionsv6.21.0-memberofrole).

  

**New features**

-   SRJIRA-4349 \- You can now create an LDAP resource with Anonymous bind.
    
-   SRJIRA-4271 \- A JQL function has been added to find issues assigned to users in a role.
    

**Bugs fixed**

-   SRPLAT-11 \- An invalid user-configured raw XML script fragment could have prevented the ScriptRunner plugin from enabling.
    
-   SRJIRA-4405 \- The lastComment("inRole Administrators") query has been optimised to take account of any project clauses.
    
-   SRJIRA-4388 \- We fixed an issue in behaviours where the **Method Selection** field was not appearing, even though a file had been selected.
    
-   SRJIRA-4353 \- The behaviour UI condition now checks the workflow step correctly for the _Create Issue_ screen.
    
-   SRJIRA-3799 \- In behaviours, the **IssueType/Project** field is no longer editable via the _Create Issue_ screen when the Behaviour sets it to read-only.
    
-   SRJIRA-3766 \- A _Field Required_ error in behaviours has been fixed.
    

## 6.3.0

15 Jun 2020 

**New features**

-   SRJIRA-2563 \- We added support for using Behaviours with Mindville Insight custom fields.
    

**Bugs fixed**

-   SRPLAT-1171 \- The Confluence-specific scriptMacroMetadataProvider module no longer shows up in UPM for all ScriptRunner products.
    
-   SRJIRA-4401 \- There is no longer a NullPointerException when a JQL function is unavailable.
    
-   SRJIRA-4391 \- Adding a default value to a database picker no longer causes a MethodInvocationException.
    
-   SRJIRA-4386 \- Multi-Issue Picker field validation now works correctly when the field is set to _Required_ using the Field Configurations.
    
-   SRJIRA-4323 \- Picker fields are now fully functional when placed at the bottom of a form.
    
-   SRJIRA-4076 \- The behaviour "Setting a Default Description" now works correctly when the Rich Text Editor is disabled.
    
-   SRJIRA-3918 \- Setting a user picker value via behaviours now works in JSD portal if the logged-in user is a customer.
    
-   SRJIRA-2974 \- Aggregate functions were not always displaying calculations when a search was performed.
    

## 6.2.1

10 Jun 2020 

**Bugs fixed**

-   SRJIRA-4380 \- The `clearError` behaviour was not able to clear out `setError`.
    
-   SRJIRA-4374 \- `AddMissingScriptFieldConfigurationsUpgradeTask` skipped custom fields.
    
-   SRJIRA-4373 \- The ScriptRunner plugin presence broke the JSD Customer Portal loading.
    

## 6.2.0

04 Jun 2020 

**Bugs fixed**

-   SRJIRA-4338 \- When using two `select2` fields with behaviours on each, it was possible to get an infinite loop.
    
-   SRJIRA-4112 \- When using behaviours to change options on a checkbox or radio button, field-level scripts did not run because change events were not fired.
    
-   SRJIRA-4032 \- The `setRequired` behaviour method on _User Picker_ fields could prevent the _User Selection_ drop-down from clearing.
    
-   SRJIRA-2686 \- When using behaviours, clearing all radio button/checkbox options prevented being able to add options.
    
-   SRJIRA-2416 \- Behaviours did not return the value of the Sprint field as expected.
    

## 6.1.0

27 May 2020 

**New features**

-   SRJIRA-4329 \- There is now IssueContext-like access to request type name in Service Desk behaviours.
    

**Bugs fixed**

-   SRPLAT-1139 \- Compilation failures in one script caused entire features to fail.
    
-   SRPLAT-1131 \- You now have the ability to set all Hikari pool configuration parameters when using database connections.
    
-   SRPLAT-1094 \- Autocompletion requests failed when requesting autocomplete after typing "Check".
    
-   SRJIRA-4334 \- Making a multi-group picker read-only now disables the link to an external popup.
    
-   SRJIRA-4308 \- The type of issue in post-function was incorrectly Issue and not MutableIssue.
    
-   SRJIRA-4294 \- Database picker fields now use the correct RestFieldOperationsHandler.
    
-   SRJIRA-4280 \- Single-select list fields width is no longer narrow when ScriptRunner is installed.
    
-   SRJIRA-4263 \- Behaviours now works correctly with Chrome 81.0.4044.92+.
    
-   SRJIRA-4260 \- Classloader cache now refreshes properly.
    
-   SRJIRA-4177 \- Database Picker and Issue Picker fields configured for "Multiple" selection are now correctly "Required" when set to "required" via field configuration.
    
-   SRJIRA-4170 \- The Multiple Issue Picker no longer shows an entry in the Change History of an issue when it was not changed.
    
-   SRJIRA-4159 \- 5.6.15 no longer throws a java.lang.ClassCastException error when using an LdapTemplate.
    
-   SRJIRA-4027 \- An issue with keyboard shortcuts and autocomplete in the browser-based Code Editor has been fixed.
    
-   SRJIRA-3973 \- Post function "Transition parent when all subtasks are resolved" does not require a Resolution field.
    
-   SRJIRA-3934 \- The setLabel() no longer causes a duplicate if any markup parameters are included.
    
-   SRJIRA-3860 \- The script for reindexing scripted fields in the documentation has been updated for the Jira 8 API.
    
-   SRJIRA-3771 \- Single-select / Multi-select list conversion no longer duplicates field (Behaviour) on Jira Service Desk Customer Portal.
    
-   SRJIRA-3720 \- Behaviours API now recognises translated language.
    
-   SRJIRA-3526 \- User Picker Required validation now works correctly for behaviours.
    
-   SRJIRA-3367 \- The User-aware and Date-aware script fields now appear in the correct panel after a cache reset.
    
-   SRJIRA-3303 \- Issue picker field now works correctly as a required field.
    
-   SRJIRA-2820 \- The Bulk Fix Resolution built-in script now closes the SLA of the issue.
    
-   SRJIRA-2535 \- The Bulk-Fix-Resolution built-in script now retains the original resolution date.
    
-   SRJIRA-2027 \- Form values are now available in the Behaviours initialiser.
    

## 6.0.2

15 May 2020 

**Bugs fixed**

-   SRJIRA-4325 \- Script Field - Configure screen link is broken
    
-   SRJIRA-4318 \- Unable to create ticket issue upgrading to 6.0.1 due to missing script field config
    

## 6.0.1

**Bugs fixed**

-   SRPLAT-1119 \- Classes in scriptrunner-api/spi no longer consumable by dependent plugins
    
-   SRJIRA-4297 \- Built in script Script registry - java.lang.NullPointerException
    
-   SRJIRA-4295 \- Exceptions during issue creation, indexing due to failed script fields upgrade
    

## 6.0.0

**Groovy Upgrade**

The version of Groovy used by ScriptRunner has been upgraded from 2.4.15 to 2.5.11. Improvements and new features (like additional AST transformations, or the new `tap()` method) shipped in Groovy 2.5 are now available to ScriptRunner users. See the [Groovy 2.5 Release Notes](https://groovy-lang.org/releasenotes/groovy-2.5.html) for more information.

As with any dependency upgrade, breaking changes could potentially affect users' scripts. However, the breaking changes between Groovy 2.4 and 2.5 are relatively minor. The low-level nature of most of these breaking changes means they are unlikely to impact many ScriptRunner scripts if any.

Take a look at the list of breaking changes in the [Groovy 2.5 Release Notes](https://groovy-lang.org/releasenotes/groovy-2.5.html#Groovy2.5releasenotes-Breakingchanges) for further details.

**IntelliJ Removal**

This version removes all support for the IntelliJ IDEA plugin. See our previous [deprecation announcement](https://docs.adaptavist.com/sr4js/latest/release-notes/release-5-x#id-.Release5.xv8.x-intellijdeprecation) for our rationale and plans for the future.

**Hidden Fields Removal**

_Hidden Fields_ custom fields, which were deprecated in version 5.6.14, have now been removed. Even though all the hidden fields configuration and data will still exist in the database, it is recommended that users change the custom field type of all hidden fields before updating to this version. To change the custom field type, follow the [Atlassian guidelines](https://confluence.atlassian.com/jirakb/change-custom-field-types-in-jira-server-158357.html).

If changing custom field type via the database, use the following type keys:

```
com.onresolve.jira.groovy.groovyrunner:hideable-textfield
com.onresolve.jira.groovy.groovyrunner:hideable-textarea
```

and custom field searcher:

```
com.onresolve.jira.groovy.groovyrunner:hideable-textsearcher
```

**Use of Natural Searchers in Script Fields**

Previously many users may have used the [Natural Searchers for Jira](https://marketplace.atlassian.com/apps/1210967/natural-searchers-for-jira?hosting=server&tab=overview) plugin. Use of these searchers on script fields allows the use of gadgets such as _Two Dimensional Filter Statistics_ and _Heatmap_, for these fields.

This release of ScriptRunner includes searchers similar to those provided by the _Natural Searchers for Jira_ plugin. On installation of this version, ScriptRunner converts any usage of searchers in script fields from the plugin versions, to ScriptRunner-native versions.

If you are only using this plugin for script fields natural searchers, you can uninstall the **Natural Searchers for Jira plugin. To check your usage of the _Natural Searchers for Jira_ plugin navigate to Admin → Natural Searchers**.

Please see the [warning message](https://docs.adaptavist.com/sr4js/latest/features/script-fields) on usage.

**New features**

-   SRJIRA-2335 \- ScriptRunner now provides stat-able/natural searchers
    

**Bugs fixed**

-   SRPLAT-1092 \- There is now DocLink support for absolute URLs
    
-   SRPLAT-1084 \- The autocompletion window of the Script Console now closes correctly
    
-   SRPLAT-1041 \- ScriptRegistry performance has been improved
    
-   SRJIRA-4075 \- The Custom Email post function now saves multiple values selected in **To Issue Fields** and **CC Issue Fields**
    
-   SRJIRA-3080 \- The binding variable 'originalIssue' is no longer incorrectly displayed for Custom Script post functions
