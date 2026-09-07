# Release 7.x

- Platform: data-center
- Space: SR4JS
- Hierarchy: release-notes
- Doc ID: doc-sr4js-348417475
- Source: https://docs.adaptavist.com/sr4js/latest/release-notes/release-7-x

## 7.13.0

22 Mar 2023 

### HAPI updates

We've refined Assets so new syntax is available and developed new options for filters. Find out more details in the [HAPI Changelog](https://docs.adaptavist.com/sr4js/latest/release-notes/hapi-changelog#7130).

### A note about JDK 17 compatibility

See the release notes for version [7.8.0](#id-.Release7.xv8.x-JDK_17) for information on JDK 17 compatibility. 

**Bugs Fixed**

-   SRPLAT-2253 - ClassGraph ThreadGroup memory leak 
-   SRJIRA-6541 - add/remove support for list values when updating Assets
-   SRJIRA-6531 - Errors in Dashboard and Gadgets Docs

## 7.12.0

08 Mar 2023 

### HAPI updates

We've developed HAPI updates for projects, Jira Service Management (JSM) workflow approvals, and project permission schemes. Find out more details in the [HAPI Changelog](https://docs.adaptavist.com/sr4js/latest/release-notes/hapi-changelog#7120).

### A note about JDK 17 compatibility

See the release notes for version [7.8.0](#id-.Release7.xv8.x-JDK_17) for information on JDK 17 compatibility. 

### Documentation update

[Troubleshooting Java Agents and ScriptRunner](https://docs.adaptavist.com/sr4js/latest/get-help/troubleshooting/troubleshooting-java-agents-and-scriptrunner) has been added to the documentation to help you troubleshoot problems associated with Java Agents. 

## 7.11.0

22 Feb 2023 

### HAPI is HERE!

Our major scripting innovation is **here: a new and simplified way to define your Jira automations in Groovy** (the scripting language most commonly found in ScriptRunner products). **It's time to get HAPI!**

HAPI is an API (application programming interface) optimized for Jira automations and tightly integrated with the script editor. With HAPI you will be able to create automations and customizations faster than ever.

Upskill easily on automation and customization with the helpful completions and work with simple, readable code. To find out more about HAPI, check out the [user documentation](https://docs.adaptavist.com/sr4js/latest/hapi).

### HAPI example scripts

We've updated a number of [Example Scripts](https://www.scriptrunnerhq.com/help/example-scripts?ScriptRunner%5BrefinementList%5D%5Bapp%5D%5B0%5D=script-runner-jira&ScriptRunner%5BrefinementList%5D%5Bplatform%5D%5B0%5D=dataCenter&ScriptRunner%5BrefinementList%5D%5Btag%5D%5B0%5D=hapi) to include HAPI methods. If you have used any of these scripts in the past, you'll notice they're shorter and easier to understand because of HAPI.

### A note about JDK 17 compatibility

See the release notes for version [7.8.0](#id-.Release7.xv8.x-JDK_17) for information on JDK 17 compatibility. 

**Bugs Fixed**

-   SRPLAT-2205 - Sorting works wrong for Configured items table
-   SRJIRA-6492 - Insight/Assets events can't be selected for listeners
-   SRJIRA-6376 - Switch user function should not allow impersonating current user
-   SRJIRA-5696 - Triggering Validation Error removes pre-existing Behaviour configuration in Create Issue Page
-   SRJIRA-3652 - JSD public comment works when executed as Admin user

## 7.10.0

08 Feb 2023 

### The clear Jira caches feature has been removed

The built-in script that previously allowed you to clear Groovy class loader caches and Jira caches has been updated so you can only [clear Groovy class loader caches](https://docs.adaptavist.com/sr4js/latest/features/built-in-scripts/clear-groovy-class-loader). We have removed this feature as it is unsafe to clear Jira caches in Data Center (SRJIRA-6417 - Remove "clear Jira caches").

If you wish to clear Jira caches in a Server instance, check out this [Example Script](https://www.scriptrunnerhq.com/help/example-scripts/clear-jira-caches-onPrem). 

### A note about JDK 17 compatibility

See the release notes for version [7.8.0](#id-.Release7.xv8.x-JDK_17) for information on JDK 17 compatibility. 

**New Features**

-   SRJIRA-6417 - Remove "clear Jira caches" feature

**Bugs Fixed**

-   SRPLAT-2180 - "Switch User Function" is not recorded in Audit Log
-   SRJIRA-5699 - Behaviour server-side script for 'required' radio button field is not triggered on form launch

## 7.9.0

25 Jan 2023 

### A major innovation is coming soon

We're working on something which makes automations and customisations in ScriptRunner faster and easier. [Check out what we're up to](https://www.adaptavist.com/atlassian-apps/adaptavist-apps-for-jira/major-scripting-innovation-for-scriptrunner).

### A note about JDK 17 compatibility

See the release notes for version [7.8.0](#id-.Release7.xv8.x-JDK_17) for information on JDK 17 compatibility. 

### Snippets are now available in a custom script post-function

You will now see snippets when adding or updating a custom script post-function. You can use these snippets to help you develop a script for your post-function.

![GIF of post function snippets](/sr4js/files/latest/348417475/348418820/1/1674142670000/Custom_script_post_function_snippets_2.gif)

**New Features**

-   SRJIRA-6261 - Customers should see snippets for Custom Post Scripts

## 7.8.0

11 Jan 2023 

### A note about JDK 17 compatibility

Jira now supports running on JDK 17 on versions 9.5.0 and above. **ScriptRunner is not currently compatible with JDK 17**, and the app will not function on that version of the JDK.

We are actively working on JDK 17 support (SRPLAT-2179).

ScriptRunner does support Jira 9.5 when running on JDK 8 or 11.

**Bugs Fixed**

-   SRJIRA-6374 - Behaviour set field options doesn't work for Components field in Jira 9
-   SRJIRA-6361 - Setting "readonly" on a Insight Field populated with a value occasionally fails due to timing issues
-   SRJIRA-6322 - No longer able to restrict priority options with Behaviour on Jira version 9
-   SRJIRA-6226 - Cannot setFormOptions on Priority field after Jira 9.2.0

## 7.7.0

15 Dec 2022 

### A note about JDK 17 compatibility

Jira now supports running on JDK 17 on versions 9.5.0 and above. **ScriptRunner is not currently compatible with JDK 17**, and the app will not function on that version of the JDK.

We are actively working on JDK 17 support (SRPLAT-2179).

ScriptRunner does support Jira 9.5 when running on JDK 8 or 11.

### New bugs fixed

In this release, we've focused on fixing bugs to improve your experience of ScriptRunner for Jira Server/Data Center. See the Jira issues in the tables below for more detailed information.

**Bugs Fixed**

-   SRPLAT-2175 - Third party plugin class loaders registered in scripts using @WithPlugin are not discarded when said plugins are disabled
-   SRPLAT-2149 - Execution history item containing nulls causes error when viewing history
-   SRPLAT-2116 - CodeEditor doesn't load because of wrong MIME type
-   SRJIRA-6283 - The Visual tab of the Description field is uneditable if the Description field is changed from read-only to editable using Behaviour

## 7.6.0

30 Nov 2022 

### New bugs fixed

This release focuses on fixing bugs to improve your experience of ScriptRunner for Jira Server/Data Center. See the Jira issues in the tables below for more detailed information.

**Bugs Fixed**

-   SRPLAT-2106 - Import completions are being added above package declaration
-   SRJIRA-6230 - Error in Jira script linked in Docs
-   SRJIRA-5956 - Service Desk Template Comments triggered automatically when editing Issue in Jira Service Management 4.14.0
-   SRJIRA-5765 - Behaviour setFormValue no longer works for User Picker (Multiple User) field from Jira v8.21.0
-   SRJIRA-4571 - The Transition Behaviour for the Comment field appears to be cached.

## 7.5.0

16 Nov 2022 

### Package declaration message

In version 7.1.0, we introduced a warning message to the Script Editor to flag invalid/missing package declarations in script files. The message stated these invalid/missing package declarations wouldn't be supported from version 9.0.0 onwards. However, this is no longer the case. **W****e will not do anything that breaks existing usage in future releases.** See [this page](https://docs.adaptavist.com/sr4js/latest/?contentKey=package-declaration-message) for more information. 

### New bugs fixed

This release focuses on fixing bugs to improve your experience of ScriptRunner for Jira Server/Data Center. See the Jira issues in the tables below for more detailed information.

**Bugs Fixed**

-   SRPLAT-2137 - Package Declaration validation incorrect when file imports another package
-   SRPLAT-2116 - CodeEditor doesn't load because of wrong MIME type
-   SRPLAT-2100 - Listeners which import classes relying on @Canonical fail after upgrade or cache clearing

## 7.4.0

02 Nov 2022 

### Get involved

Want to know how you can get involved with shaping the future of ScriptRunner? Check out our [Get Involved](https://docs.adaptavist.com/sr4js/latest/get-involved) page. 

### Guardrails blog

We introduced new Guardrails built-in scripts and guidance in version 7.3.0. We now also have a [Guardrails blog](https://www.adaptavist.com/blog/guardrails-optimise-jira-instance-stability-for-enterprise) - go check it out!

### New bugs fixed

This release focuses on fixing bugs to improve your experience of ScriptRunner for Jira Server/Data Center. See the Jira issues in the tables below for more detailed information.

**Bugs Fixed**

-   SRPLAT-2059 - The code in the editor disappears when switching between the script editor tab and other SR tabs
-   SRJIRA-6222 - Script Registry is not in line with Script Editor on package declaration warnings
-   SRJIRA-6200 - "TypeError: Cannot read properties of null (reading 'toString')" on create issue screen when affected third-party plugin is installed
-   SRJIRA-6188 - Checklist for Jira (Okapya) shows "TypeError: Cannot read properties of null (reading 'toString')" when ScriptRunner is installed and enabled
-   SRJIRA-6179 - Behaviour for ScriptRunner version 7.0.0 and above does not work on service desk if Translation for Jira Service Management plugin is enabled

## 7.3.0

19 Oct 2022 

### **New guardrails built-in scripts and guidance**

Guardrails are suggested limits and thresholds that Atlassian recommend in order to keep your Jira instance performing well. With ScriptRunner you can now run a number of [built-in scripts](https://docs.adaptavist.com/sr4js/latest/features/built-in-scripts/guardrails-built-in-scripts) to check guardrails associated with projects, comments, attachments, issue links and change logs. ScriptRunner also allows you to run more complex JQL queries to check the [epics guardrail](https://docs.adaptavist.com/sr4js/latest/best-practices/guardrails#Epicsguardrail). Visit the [Guardrails](https://docs.adaptavist.com/sr4js/latest/best-practices/guardrails) page for more information.

![GIF of how to access guardrails](/sr4js/files/latest/348417475/348418041/1/1665586504000/Guardrails_GIF_3.gif)

### New switch user functions

Administrators can now [switch user](https://docs.adaptavist.com/sr4js/latest/?contentKey=settings-switch-user#switchuser) from within an issue or in the **User management** space. Previously admins could only switch user through the _Switch User_ [built-in script](https://docs.adaptavist.com/sr4js/latest/features/built-in-scripts/switch-user). 

![Image showing where to access switch user in an issue](/sr4js/files/latest/348417475/348418036/1/1665591805000/switch_user_1.png)

![screenshot of switch user function in user management](/sr4js/files/latest/348417475/348418039/1/1665591711000/switch_user_2.png)

**New Features**

-   SRPLAT-2070 - Documentation shown when we hover over import keyword in an import statement
-   SRPLAT-2058 - Automatically add a package declaration when a new file is created using script editor to avoid package name mismatch

**Bugs Fixed**

-   SRPLAT-2097 - open redirect vulnerability
-   SRPLAT-2080 - Fragments Custom Web Item link "mailto:" not working
-   SRPLAT-2028 - Web items - URISyntaxException: Illegal character in query
-   SRJIRA-6153 - Behavior displays an error if any user who is added to the Behaviour condition is removed from Jira
-   SRJIRA-5499 - When using the Constrained create issue dialog fragment in creating an issue, if the issue type/project is changed, a Reload site dialog appears when the create button is clicked

## 7.2.0

05 Oct 2022 

### New user setting that allows you to toggle the minimap on and off

The [minimap](https://code.visualstudio.com/docs/getstarted/userinterface#_minimap) is visible on the right hand side of your script. When you write a script, the minimap can be useful for navigating, and understanding, large areas of code. You can now turn the minimap off if you don't find it useful! See the [User Editor Settings](https://docs.adaptavist.com/sr4js/latest/get-started/settings/user-editor-settings) page for more information. 

![minimap toggle gif](/sr4js/files/latest/348417475/348417909/1/1664542102000/user_editor_settings_GIF.gif)

**New Features**

-   SRPLAT-2055 - more tolerant parser strategy to allow completions in syntactically incorrect code
-   SRPLAT-2047 - warn if package declaration is incorrect/missing when editing a file script  
    SRPLAT-2001 - Add settings page available to all users with minimap toggle slider

**Bugs Fixed**

-   SRPLAT-2073 - Unable to load list of slack channels if scopes to access private channels is missing.
-   SRPLAT-2068 - prevent script engine making unnecessary "file open" operations
-   SRPLAT-2063 - console script to test filesystem performance
-   SRPLAT-1922 - Slow Disk Access for Script Roots can lead to stuck thread errors under high load
-   SRJIRA-6113 - Behaviour not able to read child value for cascading select list since SR 6.58.0
-   SRJIRA-6100 - Errors are shown when modifying the ScriptRunner script (Execute a ScriptRunner script action) in Automation for Jira (A4J)
-   SRJIRA-5970 - Rest Endpoint page is inaccessible when a Rest endpoint is broken

## 7.1.0 

21 Sept 2022 

### General feature improvements

This release focuses on general feature improvements to better your experience of ScriptRunner for Jira Server/Data Center. See the Jira issues in the tables below for more detailed information.

### Behaviours training video is now in German 🇩🇪

Our training video on [Using Behaviours for ScriptRunner for Jira Server/Data Center](https://docs.adaptavist.com/sr4js/latest/training/course-introduction-to-scriptrunner-for-jira-data-center-server/1-2-video-using-behaviours-in-scriptrunner-for-jira-data-center-server) is now available in German. You can find a link to the translated video [here](https://www.youtube.com/watch?v=j8oVrtQizNs).  

  

**New Features**

-   SRPLAT-2012 - Show a deprecation warning when editing file scripts without correct package declaration
-   SRPLAT-1997 - Always show scrollbar in snippets dropdown
-   SRJIRA-5349 - Improvements to Behaviours override warning flag

**Bugs Fixed**

-   SRPLAT-1993 - Inline REST model dependency jars
-   SRJIRA-6081 - The Priority field if set to Read-Only is editable if clicked on the Priority field's icons
-   SRJIRA-6040 - Copy Project | AR4J Parent Link should have same treatment as Epic Link

## 7.0.0

15 Sept 2022 

### Groovy 3 update

This is the update you have all been waiting for, we have updated ScriptRunner for Jira Server/Data Center to Groovy 3! What comes with this update and how will it benefit you? 

To start, the language parser has been reimplemented in Groovy 3 under the [Parrot Parser](https://groovy-lang.org/releasenotes/groovy-3.0.html#Groovy3.0releasenotes-Parrot) codename. This new parser brings a number of syntax improvements which could benefit you as a user of ScriptRunner. The Groovy 3 syntax improvements include the following:

-   Improvements that bring Groovy syntax closer to that of modern Java, such as [interface default methods](https://groovy-lang.org/releasenotes/groovy-3.0.html#_interface_default_methods), [Java style lambda syntax](https://groovy-lang.org/releasenotes/groovy-3.0.html#_java_style_lambda_syntax), [Java style method references](https://groovy-lang.org/releasenotes/groovy-3.0.html#_method_references) or [try-with-resources statements](https://groovy-lang.org/releasenotes/groovy-3.0.html#_arm_try_with_resources).
-   Additional operators, for example [`!in`  and `!instanceof`](https://groovy-lang.org/releasenotes/groovy-3.0.html#_in_and_instanceof_operators) , [`===`   and `!==` for identity comparison](https://groovy-lang.org/releasenotes/groovy-3.0.html#_identity_comparison_operators) or [null safe subscript operator](https://groovy-lang.org/releasenotes/groovy-3.0.html#_identity_comparison_operators).

In addition, there are a handful of minor general improvements, for example [new GDK methods](https://groovy-lang.org/releasenotes/groovy-3.0.html#Groovy3.0releasenotes-GDKimprovements) or the [`@NullCheck` AST transformation](https://groovy-lang.org/releasenotes/groovy-3.0.html#_nullcheck_ast_transformation).

For a full list of changes see the [release notes for Groovy 3](https://groovy-lang.org/releasenotes/groovy-3.0.html). 

#### Breaking changes

There are a number of known breaking changes in Groovy 3. The breaking changes include [relocation of some classes to different packages](https://groovy-lang.org/releasenotes/groovy-3.0.html#Groovy3.0releasenotes-Splitpackages). All the other breaking changes for Groovy 3 are listed in [the release notes](https://groovy-lang.org/releasenotes/groovy-3.0.html#Groovy3.0releasenotes-OtherBreaking). There are also some additional minor breaking changes in [Groovy 3.0.5.](https://groovy-lang.org/releasenotes/groovy-3.0.html#_breaking_changes) and [Groovy 3.0.8](https://groovy-lang.org/releasenotes/groovy-3.0.html#_breaking_changes2).

We don't believe that any of these changes are significant, or that they should affect a large number of ScriptRunner users. However, there is a chance this update may cause some of your scripts to fail. 

If you have any issues please contact our customer support team. 

### `SrSpecification` has been deprecated

In the past, when [writing tests](https://docs.adaptavist.com/pages/viewpage.action?pageId=115708816), we provided an example to extend `com.onresolve.scriptrunner.canned.common.admin.SrSpecification`. 

`SrSpecification` will be removed in a future release of ScriptRunner, but is still available in the current release. From now on please use `spock.lang.Specification` as the base for your tests. 

### Jsoup update

We have updated our internal version of Jsoup to 1.15.3 due to a potential vulnerability. The key change is the replacement of `org.jsoup.safety.Whitelist` with `org.jsoup.safety.Safelist`. Please find more information at [https://jsoup.org/news/release-1.15.1](https://jsoup.org/news/release-1.15.1).

**New Features**

-   SRPLAT-2005 - Update to Spock 2.0
-   SRPLAT-1999 - Change field description label so it is above snippets/examples
-   SRPLAT-1954 - Upgrade to Groovy 3.0.12
-   SRJIRA-6099 - Update dev Jira license

**Bugs Fixed**

-   SRPLAT-2027 - Inner class in Script Editor causes autocomplete to fail and errors output in server log
-   SRPLAT-2007 - Import statement mangled when package declaration present
-   SRPLAT-1991 - Automatic import completions are mangling imports in some cases
-   SRPLAT-1983 - Documentation for wrong method shown when using property setter shorthand
-   SRPLAT-1923 - Static Type Checking may lead to large consumption of memory in some circumstances
-   SRJIRA-6097 - "Show only scripts that may require attention" toggle can cause UI crashes
-   SRJIRA-6079 - Show option description in Behaviours "preserve user input" flag
-   SRJIRA-6060 - Unable to save script selected via File tab in Automation for Jira "Execute a ScriptRunner script"
-   SRJIRA-5888 - Behaviours read-only doesn't work correctly for Multiple Insight Object/s field when using setFormValue() to set the Multiple Insight Object/s field in Initialiser
-   SRJIRA-5148 - Deleting a project used by a "Create subtask" listener and updating the listener will cause it to be applied on all projects
