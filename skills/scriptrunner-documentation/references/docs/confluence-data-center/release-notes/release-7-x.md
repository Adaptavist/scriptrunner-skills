# Release 7.x

- Platform: confluence-data-center
- Space: SR4C
- Hierarchy: Release Notes
- Doc ID: doc-sr4c-4a0293b1-b683-41a3-8411-2c36d5968e0a-a94cbb80bed06113
- Source: https://docs.adaptavist.com/sr4c/latest/release-notes/release-7.x

Feature release information about our 7.x versions.

Check out what's new with ScriptRunner for Confluence!

## 7.13.0

New Update Page Restrictions Scripts

There are two new scripts to help you manage restrictions on parent and child pages. Using the [Update Page Restrictions Listener](https://docs.adaptavist.com/sr4c/latest/features/event-listeners/built-in-listeners/update-page-restrictions-listener) listener, you can automatically add or remove restrictions to entire spaces or pages and manage access for newly created spaces, which is triggered by another event. Similarly, you can use the [Update Page Restrictions Job](https://docs.adaptavist.com/sr4c/latest/features/jobs/built-in-jobs/update-page-restrictions-job) job to automatically add or remove restrictions to entire spaces or pages and manage access for newly created spaces.

### Modified Update Page Restriction Built-In Scripts

The [Update Page Restrictions](https://docs.adaptavist.com/sr4c/latest/features/built-in-scripts/space-administration-built-in-scripts/update-page-restrictions) Confluence Administration and [Update Page Restrictions](https://docs.adaptavist.com/sr4c/latest/features/built-in-scripts/space-administration-built-in-scripts/update-page-restrictions) Space Administration built-in scripts were also renamed. Additionally, the Permission Level field was renamed to Restriction Level. The script functions the same as it did previously.

### New Settings Option

You can now [show or hide the Enhanced Search section message](https://docs.adaptavist.com/sr4c/latest/get-started/settings/show-or-hide-enhanced-search-section-messages).

### Bugs Fixed

-   ClassGraph ThreadGroup memory leak (SRPLAT-2253)
-   Copy Space script return stacktrace if user do not have Create Space(s) permission (SRCONF-2532)
-   Enhanced Search banner for other languages (SRCONF-2319)

### Documentation Update

[Permissions](https://docs.adaptavist.com/sr4c/latest/get-started/permissions) has been added to the documentation to list the different features of ScriptRunner for Confluence and what user permissions are needed to use it.

## 7.12.0

New Built-In Script Job

Using the new [Bulk Delete Attachments](https://docs.adaptavist.com/sr4c/latest/features/jobs/built-in-jobs/bulk-delete-attachments-job) job, you can use this job to schedule attachments to be deleted based on selected criteria.

### Documentation Update

[Java Agents and ScriptRunner](https://docs.adaptavist.com/sr4c/latest/get-help/java-agents-and-scriptrunner) has been added to the documentation to help you use Java Agents with ScriptRunner for Confluence.

## 7.11.0

Manage Labels

There are two new scripts to help you create, update, and maintain labels. Using the [Manage Labels job](https://docs.adaptavist.com/sr4c/latest/features/jobs/built-in-jobs/manage-labels-job), you can schedule routine label management. Similiary, you can use the [Manage Labels listener](https://docs.adaptavist.com/sr4c/latest/features/event-listeners/built-in-listeners/manage-labels-listener) to customize label management automation using conditions and target content.

Additionally, the [Manage Labels Confluence administration built-in script](https://docs.adaptavist.com/sr4c/latest/features/built-in-scripts/confluence-administration-built-in-scripts/manage-labels) and [Manage Labels space administration built-in script](https://docs.adaptavist.com/sr4c/latest/features/built-in-scripts/space-administration-built-in-scripts/manage-labels) have been updated to give you more flexibility when creating, removing, and renaming labels.

Bugs Fixed

-   Sorting works wrong for Configured items table (SRPLAT-2205)
-   Space Administrator built-in script throws an error when trying to load the page tree (SRCONF-2524)

## 7.10.0

### Bugs Fixed

-   "Switch User Function" is not recorded in Audit Log (SRPLAT-2180)

## 7.9.0

### Bugs Fixed

-   Enhanced Search 'Help and Documentation' button redirect to non-existent page. (SRCONF-2451)
-   Resource Preview result table shows wrong column order between the header and value (SRCONF-2385)

## 7.8.0

### Bugs Fixed

-   Unable to add onboarding examples if there is no user with username 'admin' (SRCONF-2444)

## 7.7.0

Confluence 8 Compatibility

This release is compatible with Confluence 8 on Java 11. We are still working to provide compatibility on Java 17.

Custom Search Fields

The Search Extractors feature has been replaced with [Custom Search Fields](https://docs.adaptavist.com/sr4c/latest/features/custom-search-fields). You can use custom search fields to add useful indexes to Confluence's search to find content that meets specific criteria. This feature was changed to be compatible with Confluence 8.

Built-in Scripts Renamed

Four scripts were renamed. The two renamed Confluence administration scripts are [Copy Pages](https://docs.adaptavist.com/sr4c/latest/features/built-in-scripts/space-administration-built-in-scripts/copy-pages) and [Delete Pages](https://docs.adaptavist.com/sr4c/latest/features/built-in-scripts/space-administration-built-in-scripts/delete-pages). The two renamed Space Administration scripts are [Copy Pages](https://docs.adaptavist.com/sr4c/latest/features/built-in-scripts/space-administration-built-in-scripts/copy-pages) and [Delete Pages](https://docs.adaptavist.com/sr4c/latest/features/built-in-scripts/space-administration-built-in-scripts/delete-pages).

Bugs Fixed

-   Third party plugin class loaders registered in scripts using @WithPlugin are not discarded when said plugins are disabled (SRPLAT-2175)
-   Execution history item containing nulls causes error when viewing history (SRPLAT-2149)
-   CodeEditor doesn't load because of wrong MIME type (SRPLAT-2116)
-   Rename Pages checkbox allows to select only one option at a time (SRCONF-2313)

## 7.6.0

Confluence 8 Compatibility

We have been working for several months to ensure compatibility with Confluence 8. Pending any unforeseen issues, we expect to be compatible with Confluence 8 on Java 11 in the next release. It is possible that Java 17 compatibility may take longer, but we'll provide updates as needed.

Bugs Fixed

-   Import completions are being added above package declaration (SRPLAT-2106)
-   Presence of an empty page throws IndexOutOfBounds exception for delete page tree built in script (SRCONF-1280)

## 7.5.0

### Hide the binocular icon

You can now [show or hide the Enhanced Search binocular icon](https://docs.adaptavist.com/sr4c/latest/get-started/settings/show-or-hide-the-enhanced-search-binocular-icon).

### Package declaration message

In version 7.1.0, we introduced a warning message to the Script Editor to flag invalid/missing package declarations in script files. The message stated these invalid/missing package declarations wouldn't be supported from version 9.0.0 onwards. However, this is no longer the case. We will not do anything that breaks existing usage in future releases. See [this page](https://docs.adaptavist.com/sr4c/latest/features/script-editor/why-is-there-an-incorrect-package-declaration-message-in-the-script-editor) for more information.

### New Features

-   Add an ability to disable/hide the binocular icon from Enhanced Search (SRCONF-2259)
    

### Bugs Fixed

-   Package Declaration validation incorrect when file imports another package (SRPLAT-2137)
-   CodeEditor doesn't load because of wrong MIME type (SRPLAT-2116)
-   Listeners which import classes relying on @Canonical fail after upgrade or cache clearing (SRPLAT-2100)
-   The graphs for content older than 1 year is not working in space statistics built-in scripts (SRCONF-2158)

## 7.4.0

### Bulk Purge Trash Job

You can now use the [Bulk Purge Trash](https://docs.adaptavist.com/sr4c/latest/features/jobs/built-in-jobs/bulk-purge-trash-job) job to create a job that runs on a set schedule to purge the trash from all the spaces specified in the job.

### Bugs Fixed

-   The code in the editor disappears when switching between the script editor tab and other SR tabs (SRPLAT-2059)

## 7.3.0

ADVANCE NOTICE

Beginning in ScriptRunner for Confluence 8.0.0, existing Custom Search Extractors will no longer function. This is due to the requirement that we must move to the new [Extractor2 implementation](https://confluence.atlassian.com/doc/preparing-for-confluence-8-0-1095775426.html#PreparingforConfluence8.0-LuceneandBonnieAPIisolation) in order to maintain cross-compatibility with Confluence 7.x.x and Confluence 8.x.x. Existing Search Extractors cannot be automatically migrated and manual intervention by customers will be required.

We aim to provide feature parity with the new Extractor2 implementation along with documentation describing how to migrate your existing extractors. Our goal is to have the new Extractor2 implementation released in ScriptRunner for Confluence 8.0.0, or in a version shortly after that.

### New switch user functions

Administrators can now [switch to a different user](https://docs.adaptavist.com/sr4c/latest/features/built-in-scripts/confluence-administration-built-in-scripts/switch-to-a-different-user) from within a page in Confluence or in the User management space. Previously admins could only switch user through the _Switch User_ built-in script.

### New Features

-   Documentation shown when we hover over import keyword in an import statement (SRPLAT-2070)
-   Automatically add a package declaration when a new file is created using script editor to avoid package name mismatch (SRPLAT-2058)

### Bugs Fixed

-   open redirect vulnerability (SRPLAT-2097)
-   Fragments Custom Web Item link "mailto:" not working (SRPLAT-2080)
-   Web items - URISyntaxException: Illegal character in query (SRPLAT-2028)

## 7.2.0

### New user setting allows toggling the minimap on/off

The [minimap](https://code.visualstudio.com/docs/getstarted/userinterface#_minimap) is visible on the right-hand side of your script. When you write a script, the minimap can be useful for navigating, and understanding, large areas of code. You can now turn the minimap off if you don't find it useful! See the [User Editor Settings](https://docs.adaptavist.com/sr4c/latest/get-started/settings/user-editor-settings) page for more information.

### New Features

-   more tolerant parser strategy to allow completions in syntactically incorrect code (SRPLAT-2055)
-   warn if package declaration is incorrect/missing when editing a file script (SRPLAT-2047)
-   Add settings page available to all users with minimap toggle slider (SRPLAT-2001)

### Bugs Fixed

-   Unable to load list of slack channels if scopes to access private channels is missing. (SRPLAT-2073)
-   prevent script engine making unnecessary "file open" operations (SRPLAT-2068)
-   console script to test filesystem performance (SRPLAT-2063)
-   Slow Disk Access for Script Roots can lead to stuck thread errors under high load (SRPLAT-1922)
-   Page tree options are shown as expanded although no options displayed (SRCONF-2347)
-   Copy Space script does not copy Space's Colour Scheme (SRCONF-1887)
-   Adding the Create Page macro to a table header results in an error (SRCONF-1514)

## 7.1.0

### New Features

-   Show a deprecation warning when editing file scripts without correct package declaration (SRPLAT-2012)
-   Always show scrollbar in snippets dropdown (SRPLAT-1997)

### Bugs Fixed

-   Inline REST model dependency jars (SRPLAT-1993)
-   The include version macro always defaults to latest version once saved (SRCONF-2184)

## 7.0.0

### Groovy 3 update

This is the update you've all been waiting for. We have updated ScriptRunner for Confluence to Groovy 3! What comes with this update and how will it benefit you?

To start, the language parser has been reimplemented in Groovy 3 under the [Parrot Parser](https://groovy-lang.org/releasenotes/groovy-3.0.html#Groovy3.0releasenotes-Parrot) codename. This new parser brings a number of syntax improvements that could benefit you as a user of ScriptRunner. The Groovy 3 syntax improvements include the following:

-   Improvements that bring Groovy syntax closer to that of modern Java, such as [interface default methods](https://groovy-lang.org/releasenotes/groovy-3.0.html#_interface_default_methods), [Java style lambda syntax](https://groovy-lang.org/releasenotes/groovy-3.0.html#_java_style_lambda_syntax), [Java style method references](https://groovy-lang.org/releasenotes/groovy-3.0.html#_method_references), or [try-with-resources statements](https://groovy-lang.org/releasenotes/groovy-3.0.html#_arm_try_with_resources).
-   Additional operators, for example [`!in` and `!instanceof`](https://groovy-lang.org/releasenotes/groovy-3.0.html#_in_and_instanceof_operators), [`===` and `!==` for identity comparison](https://groovy-lang.org/releasenotes/groovy-3.0.html#_identity_comparison_operators) or [null safe subscript operator](https://groovy-lang.org/releasenotes/groovy-3.0.html#_identity_comparison_operators).

In addition, there are a handful of minor general improvements, for example, [new GDK methods](https://groovy-lang.org/releasenotes/groovy-3.0.html#Groovy3.0releasenotes-GDKimprovements) or the [`@NullCheck` AST transformation](https://groovy-lang.org/releasenotes/groovy-3.0.html#_nullcheck_ast_transformation) .

For a full list of changes, see the [release notes for Groovy 3](https://groovy-lang.org/releasenotes/groovy-3.0.html).

### Breaking changes

There are a number of known breaking changes in Groovy 3. The breaking changes include [relocation of some classes to different packages](https://groovy-lang.org/releasenotes/groovy-3.0.html#Groovy3.0releasenotes-Splitpackages). All the other breaking changes for Groovy 3 are listed in [the release notes](https://groovy-lang.org/releasenotes/groovy-3.0.html#Groovy3.0releasenotes-OtherBreaking). There are also some additional minor breaking changes in [Groovy 3.0.5.](https://groovy-lang.org/releasenotes/groovy-3.0.html#_breaking_changes) and [Groovy 3.0.8](https://groovy-lang.org/releasenotes/groovy-3.0.html#_breaking_changes2).

We don't believe that any of these changes are significant, or that they should affect a large number of ScriptRunner users. However, there is a chance this update may cause some of your scripts to fail.

If you have any issues, please contact our customer support team [here](https://the-adaptavist-group-support.atlassian.net/servicedesk/customer/portal/21).

### `SrSpecification` has been deprecated

In the past, when [writing tests](https://docs.adaptavist.com/sr4c/latest/best-practices-and-app-management/test-your-code), we provided an example to extend `com.onresolve.scriptrunner.canned.common.admin.SrSpecification`.

`SrSpecification` will be removed in a future release of ScriptRunner, but is still available in the current release. From now on, please use `spock.lang.Specification` as the base for your tests.

### Lock Content macro has been removed

We deprecated the Lock Content macro in release 6.27.0, and gave notice then that the macro would be removed in a future release. That is now happening with the release of 7.0.0.

You can check to see if the Lock Content macro is used on any of your pages by using [Enhanced Search](https://docs.adaptavist.com/sr4c/latest/features/enhanced-search) and searching for `macro = "lock-content-macro"`. This returns a list of any pages that use the macro.

You can then decide how to handle the removal of the macro from each page. You could, for example, change the page permissions. Or you could move the content to a secured page and use the [Include Page](https://confluence.atlassian.com/doc/include-page-macro-139514.html) macro.

If you have issues related to the removal of the macro, please contact us via [our support portal](https://the-adaptavist-group-support.atlassian.net/servicedesk/customer/portal/13) for assistance. If you have a request for functionality similar to the _Lock Content_ macro, please open a new [feature request](https://the-adaptavist-group-support.atlassian.net/servicedesk/customer/portal/21) with Support. By creating these requests, we can better understand your use case and help you solve problems.

### Jsoup update

We have updated our internal version of Jsoup to 1.15.3 due to a potential vulnerability. The key change is the replacement of `org.jsoup.safety.Whitelist` with `org.jsoup.safety.Safelist`. Please find more information at [https://jsoup.org/news/release-1.15.1](https://jsoup.org/news/release-1.15.1).

### New Features

-   Update to Spock 2.0 (SRPLAT-2005)
-   Change field description label so it is above snippets/examples (SRPLAT-1999)
-   Upgrade to Groovy 3.0.12 (SRPLAT-1954)

### Bugs Fixed

-   Inner class in Script Editor causes autocomplete to fail and errors output in server log (SRPLAT-2027)
-   Import statement mangled when package declaration present (SRPLAT-2007)
-   Automatic import completions are mangling imports in some cases (SRPLAT-1991)
-   Documentation for wrong method shown when using property setter shorthand (SRPLAT-1983)
-   Static Type Checking may lead to large consumption of memory in some circumstances (SRPLAT-1923)
-   Lock content macro not hiding content in edit page mode (SRCONF-824)
