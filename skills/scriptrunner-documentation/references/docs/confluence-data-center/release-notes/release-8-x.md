# Release 8.x

- Platform: confluence-data-center
- Space: SR4C
- Hierarchy: Release Notes
- Doc ID: doc-sr4c-4ef407ac-9d16-4801-9a73-d0f9e5ee15a3-b91a28e4b938cca4
- Source: https://docs.adaptavist.com/sr4c/latest/release-notes/release-8.x

Feature release information about our 8.x versions.

## 8.68.0

There are only core component changes in ScriptRunner for Confluence 8.68.0, so we do not have any new features or bug fixes to report.

## 8.66.0

### Security update

We've made targeted security improvements in this release as part of our ongoing hardening work. For more details on how we handle security and vulnerability management, see our [Vulnerabilities and Security](https://docs.adaptavist.com/sr4c/latest/get-started/vulnerabilities-and-security) documentation.

## 8.65.0

### Confluence startup bug fixed

We've fixed an issue where, in some environments, ScriptRunner failed to load after a restart and only worked again after being reinstalled. ScriptRunner now starts reliably on Confluence restart, with improved resilience to underlying AO storage and settings problems.

### Third-party dependencies updated to remove CVEs

We've updated third‑party dependencies within ScriptRunner to address known CVEs (Common Vulnerabilities and Exposures). These changes are part of our ongoing hardening work and do not indicate that your instance was exposed to security issues. For more details on how we handle security and vulnerability management, see our [Vulnerabilities and Security](https://docs.adaptavist.com/sr4c/latest/get-started/vulnerabilities-and-security) documentation.

## 8.60.0

There are only core component changes in ScriptRunner for Confluence 8.60.0, so we do not have any new features or bug fixes to report.

## 8.59.0

Security improvement

We've strengthened the validation and sanitisation of user-supplied content in ScriptRunner web interfaces. No action is required on your side, and this update does not mean your instance was vulnerable to security issues. We're always working to make ScriptRunner as safe as possible, and this update is part of that ongoing effort. Check out our page on [Vulnerabilities and Security](https://docs.adaptavist.com/sr4c/latest/get-started/vulnerabilities-and-security) for more details on how we scan for vulnerabilities and common security concerns.

## 8.58.0

### Add/Remove Watchers bug fixed

We've resolved a bug related to one of our Built-in Scripts. Group picker fields in the Add/Remove Watchers built-in script now correctly accept groups whose names contain `#`. Previously, entering a group with # in its name caused the group field to return an error instead of accepting the value.

### Script export bug fixed

We've resolved a bug related to [Script Export](https://docs.adaptavist.com/sr4c/latest/features/script-registry#access-the-script-registry--en). Script exports now display the correct script count for all supported script types, including CQL Functions and Macros. Previously, exports sometimes reported a script count of `0` for these types, even when scripts were present.

## 8.57.1

### New feature

[Export scripts](https://docs.adaptavist.com/sr4c/latest/features/script-registry) from the script registry. You can export all ScriptRunner scripts, configurations, and custom fields from your instance, except ScriptRunner JQL function information.

## 8.57.0

### Script Registry

You may now access the [Script Registry](https://docs.adaptavist.com/sr4c/latest/features/script-registry) from the Tabs view in the Administration options.The Script Registry allows you to search your ScriptRunner custom scripts, view type-checking errors or deprecation warnings, and export all scripts and configurations on your instance.

### Update

We added a link to the ScriptRunner home page from the Confluence Settings menu.

### Fixes

We resolved an unexpected error that appeared during configuration of the _Update Macro_ built-in script.

## 8.56.0

There are only core component changes in ScriptRunner for Confluence 8.56.0, so we do not have any new features or bug fixes to report.

## 8.55.0

There are only core component changes in ScriptRunner for Confluence 8.55.0, so we do not have any new features or bug fixes to report.

## 8.54.0

There are only core component changes in ScriptRunner for Confluence 8.54.0, so we do not have any new features or bug fixes to report.

## 8.53.0

There are only core component changes in ScriptRunner for Confluence 8.53.0, so we do not have any new features or bug fixes to report.

## 8.52.0

### Switch User function update

In response to new Atlassian security requirements, you can only switch a user identity using the [Switch to a Different User](https://docs.adaptavist.com/sr4c/latest/features/built-in-scripts/confluence-administration-built-in-scripts/switch-to-a-different-user) built-in script. Identity switching functionality from User Management and Confluence administration has been deprecated.

### Security improvements

We've made a couple of security improvements in this release:

-   We have implemented a security improvement to our switch user feature. This update strengthens our protection against potential unauthorized account access.
-   We've addressed a known Common Vulnerabilities and Exposures (CVE).

We want to emphasize that this update doesn't mean your instance was vulnerable to security issues. We're always working to make ScriptRunner as safe as possible, and this update is part of that ongoing effort. Check out our page on [Vulnerabilities and Security](https://docs.adaptavist.com/sr4c/latest/get-started/vulnerabilities-and-security) for more details on how we scan for vulnerabilities and common security concerns.

## 8.51.0

### Security improvement

In this release, we've focused on improving the security of ScriptRunner for Confluence by addressing known Common Vulnerabilities and Exposures (CVEs). We want to emphasize that this update doesn't mean your instance was vulnerable to security issues. We're always working to make ScriptRunner as safe as possible, and this update is part of that ongoing effort. Check out our page on [Vulnerabilities and Security](https://docs.adaptavist.com/sr4c/latest/get-started/vulnerabilities-and-security) for more details on how we scan for vulnerabilities and common security concerns.

## 8.49.0

### Product update

There are only core component changes in ScriptRunner for Confluence 8.49.0, so we do not have any new features or bug fixes to report.

## 8.48.0

### Product update

There are only core component changes in ScriptRunner for Confluence 8.48.0, so we do not have any new features or bug fixes to report.

## 8.47.0

### Product update

There are only core component changes in ScriptRunner for Confluence 8.47.0, so we do not have any new features or bug fixes to report.

## 8.46.0

### Vulnerability scanner updates

We have updated and added new vulnerability scanners to reduce discrepancies in your vulnerability reports. This is an internal feature that does not require any action from you.

### 8.45.0

#### Product update

There are only core component changes in ScriptRunner for Confluence 8.45.0, so we do not have any new features or bug fixes to report.

## 8.44.0

### Product update

There are only core component changes in ScriptRunner for Confluence 8.44.0, so we do not have any new features or bug fixes to report.

## 8.43.0

### Product update

There are only core component changes in ScriptRunner for Confluence 8.43.0, so we do not have any new features or bug fixes to report.

## 8.42.0

### Documentation update: Removal of legacy versions

In the next few weeks, we will be phasing out all 6.x.x and 7.x.x versions of our documentation from public access. While this change is not expected to impact most users, we recommend taking the following actions:

-   Review your bookmarks: If you have any saved links to our documentation, please verify that they don't point to versions that will be removed.
-   Update your references: Ensure that you're using the most current documentation version for your needs.

If you have any concerns, please contact our [support team](https://www.scriptrunnerhq.com/help/support).

### Product update

There are only core component changes in ScriptRunner for Confluence 8.42.0, so we do not have any new features or bug fixes to report.

## 8.41.0

### Product update

There are only core component changes in ScriptRunner for Confluence 8.41.0, so we do not have any new features or bug fixes to report.

### Library update: Example scripts have moved to ScriptRunner HQ

Adaptavist Library has been renamed to [Example Scripts](https://www.scriptrunnerhq.com/help/example-scripts) and all scripts have been moved to their new home on the [ScriptRunner HQ](https://www.scriptrunnerhq.com/) website. These example scripts now live alongside the tutorials, case studies and other content designed to help you get the most from ScriptRunner. For more information, check out our [blog](https://www.scriptrunnerhq.com/inspiration/blog/example-scripts-on-scriptrunner-website) on this update.

Note: This update does not affect in-app example scripts, which will continue to function as usual.

## 8.40.0

### Bugs fixed

A bug to fix a Confluence compatibility issue with the CVE scan has been implemented.

## 8.39.0

### Updates

-   Security improvement
    -   In this release, we've focused on improving the security of ScriptRunner for Jira by addressing known Common Vulnerabilities and Exposure (CVE). We want to emphasise that this update doesn't mean your instance was vulnerable to security issues. We're always working to make ScriptRunner as safe as possible, and this update is part of that ongoing effort.
-   In-app feedback
    -   In this release, we have introduced a new feedback system to improve how we gather user insights. You may encounter notifications linking to surveys, which offer a convenient method to share your thoughts about the product. The notifications will not appear:
        -   If you've disabled in-app communications in ScriptRunner.
        -   If you're using an evaluation license.
        -   If your instance is isolated from the internet.

## 8.38.0

### Resources update

We have removed some visibility of passwords within [Resources](https://docs.adaptavist.com/sr4c/latest/features/resources). This change is designed to enhance security by preventing credentials from being viewed by other Confluence administrators.

### Bug fixed

A bug preventing scripts such as _Copy Page Tree_ _,_ when the user enters text and erases it from the optional _Code Transform_ block is removed.

## 8.36.0

There are only core component changes in ScriptRunner for Confluence 8.36.0, so we do not have any new features or bug fixes to report.

## 8.35.0

### Bug fix

-   Setting REST endpoint package to scan to empty value does not work

## 8.34.0

### Advanced notice for Confluence 9 compatibility

We are preparing ScriptRunner for Confluence Data Center to be compatible with Confluence 9. We expect updates to [Breaking Changes](breaking-changes.md) and [Fragments](https://docs.adaptavist.com/sr4c/latest/features/fragments), but updates are not limited to these. Please check these pages along with the release notes for updates.

### Switch user vulnerability fixed

We have patched a vulnerability related to the _Switch User_ feature.

## 8.33.0

### Advanced notice for Confluence 9 compatibility

We are preparing ScriptRunner for Confluence Data Center to be compatible with Confluence 9. We expect updates to [Breaking Changes](breaking-changes.md) and [Fragments](https://docs.adaptavist.com/sr4c/latest/features/fragments), but updates are not limited to these. Please check these pages along with the release notes for updates.

## 8.32.0

### Bugs fixed

-   Confluence Administration Borders - Space Admin Page Dark Mode Compatibility
-   Advanced Space Functionality - Manage Labels page is broken if Blogs pages are selected
-   Rename page script does not create a new Page version which causes the page to be renamed partially

## 8.31.0

### Confluence compatibility

ScriptRunner for Confluence is now compatible with Confluence 8.9.3!

## 8.30.0

### New best practices guide

Check out our new [Best Practices Guide](https://docs.adaptavist.com/db/organizations/adaptavist/repositories/master/content/documents/Adaptavist_Content/ScriptRunner/ScriptRunner_for_Confluence_Data_Center_SR4C/maps/best_practices_and_app_management.ditamap)! This guide covers 11 automation categories of ScriptRunner for Confluence! Each section walks you through different features and scripts we've created to help you automate your Confluence instance to save you time and money!

### Bugs fixed

-   Custom Search Fields fail intermittently on Confluence 8.9.0 and 8.9.1
-   Choose label button is not aligned with the Select Labels field

## 8.29.0

There are only core component changes in ScriptRunner for Confluence 8.29.0, so we do not have any new features or bug fixes to report.

## 8.28.0

### Bugs fixed

-   Create Page Macro Broken in 8.9
-   Advanced Space Functionality: Update Page Restriction fails on running on restricted pages

## 8.27.0

### Confluence compatibility

ScriptRunner for Confluence is now compatible with Confluence 8.9.0.

### New features

-   Update Empty State Images for Dark Mode Compatibility

### Bugs fixed

-   Advanced Space Functionality: Update Page Restrictions fails on running on restricted pages

## 8.26.0

Fragments improvements

We have made the following improvements to [UI Fragments](https://docs.adaptavist.com/sr4c/latest/features/fragments):

-   Location fields within the UI Fragments section of ScriptRunner for Confluence now have the option to enable or disable the Fragment Locator.
-   Fragment locations now appear as buttons.
    
    Warning: Currently, this update only applies to UI Fragments that have related binding information.
    
-   The copy function for fragment locations now appear as buttons.

### New features

-   All Users: Enabled Locator: New Button

## 8.25.0

Fragments improvements

We have made the following improvements to [Fragments](https://docs.adaptavist.com/sr4c/latest/features/fragments):

-   Updated the name to UI Fragments (previously Script Fragments) to better reflect its purpose.
-   Updated the UI Fragments view page so your UI fragments are easier to recognize and navigate.

### New features

-   Rename Fragments to UI Fragments in SR tabs section

### Bugs fixed

-   Script Editor layout is broken for Jobs/Listeners/Macros when Expanded and switched from Inline to File
-   ExecutionError: java.lang.StackOverflowError

## 8.24.0

### New support portal

Our Adaptavist Support Portal moved! Visit the new location [here](https://the-adaptavist-group-support.atlassian.net/servicedesk/customer/portal/13). Please update your bookmarks.

Visit [this page](https://docs.adaptavist.com/sr4c/latest/get-help#contact-support--en) for help logging into the portal.

### Copy the location path of a variable

You can now copy the location path of a fragment from the binding information window when the Fragment Locator is turned on.

Note: This feature is location-dependent, as not all locations have binding variables associated with them.

#### New features

-   All Users: Enabled Locator: Binding Information

#### Bugs fixed

-   Built-In Scripts: Manage Labels retrieving unpublished/draft/restricted pages.DS space

## 8.23.0

### Fragment locator update

The [Fragment Locator](https://docs.adaptavist.com/sr4c/latest/features/fragments) now has a toggle to enable and disable it:

### Doc update

The [Feature Release Summary](feature-release-summary.md) has been added.

## 8.22.0

### Confluence compatibility

ScriptRunner for Confluence is now compatible with Confluence 8.8.0.

## 8.21.0

### Script editor refresh

The [Example Scripts](https://docs.adaptavist.com/sr4c/latest/get-started/example-scripts) modal is now accessible on the [Script Editor](https://docs.adaptavist.com/sr4c/latest/features/script-editor) page using the button. In addition, we have moved the Help and Fullscreen buttons so they sit above the code editor for easy accessibility.

We have also made the type-checking dialog more prominent so you can easily see when there is an error with your code.

Bugs fixed

-   Errors binding events in 'Send Email' Listener
-   Prevent unauthorised user redirection from our SR switchuser-endsession endpoint
-   The Export Page as PDF script library example throws an exception

## 8.20.0

There are only core component changes in ScriptRunner for Confluence 8.20.0, so we do not have any new features or bug fixes to report.

## 8.19.0

There are only core component changes in ScriptRunner for Confluence 8.19.0, so we do not have any new features or bug fixes to report.

## 8.18.0

There are only core component changes in ScriptRunner for Confluence 8.18.0, so we do not have any new features or bug fixes to report.

## 8.17.0

### New: Example Scripts modal

The _Example Scripts_ modal is your go-to destination for finding basic script examples (formerly snippets) and [Library](https://library.adaptavist.com/) scripts without having to leave the ScriptRunner app. This modal replaces the Show Snippet dropdown.

To access this modal, you can select the Example Scripts button in any code editor within ScriptRunner. Learn more about this new modal on the [Example Scripts](https://docs.adaptavist.com/sr4c/latest/get-started/example-scripts) page.

### Update: Code editor refresh

In addition to the new _Example Scripts_ modal we have redesigned the code editor so it's even more user-friendly. We have moved the Help, Expand Editor, and Fullscreen buttons so they sit above the code editor and are easily accessible. We've also made the typechecking dialog more prominent so you can easily see when there is an error with your code.

#### Bugs fixed

-   Manage labels (Advanced Space Functionality) does not find label if "All Content Types" is specified

## 8.16.0

### Bugs fixed

-   "lastModified" in 4 weeks BIS example doesn't work

## 8.15.0

### HAPI is here!

Our major scripting innovation is here: a new and simplified way to define your Confluence automations in Groovy (the scripting language most commonly found in ScriptRunner products). It's time to get HAPI!

HAPI is an API (application programming interface) optimized for Confluence automations and tightly integrated with the script editor. With HAPI you will be able to create automations and customizations faster than ever.

Upskill easily on automation and customization with the helpful completions and work with simple, readable code. To find out more about HAPI, check out the [user documentation](../uncategorized/h/hapi.md).

### Script plugins update

We've done some work on the infrastructure supporting [script plugins](https://docs.adaptavist.com/sr4c/latest/best-practices-and-app-management/script-plugins). As part of this, [CQL Functions](https://docs.adaptavist.com/sr4c/latest/features/cql-functions) can now be exported and used in script plugins. All configurable ScriptRunner for Confluence features should now be supported.

### Feature removal

The Currency Converter macro has been removed. This macro has not been functional for quite some time due to the change in the Exchange Rates API becoming a paid-only service.

#### New features

-   Remove currency converter macro

#### Bugs fixed

-   Script console doesn't show exceptions properly for Confluence 8.4 and 8.2
-   Custom CQL function example script not working

## 8.14.0

### Upcoming feature removal

In the next release, the Currency Converter macro will be removed. This macro has not been functional for quite some time due to the change in the Exchange Rates API becoming a paid-only service.

#### Bugs fixed

-   Usage of URLs in SVC <use> element is deprecated

## 8.13.0

### Script Plugins Update

[Script plugins](https://docs.adaptavist.com/sr4c/latest/best-practices-and-app-management/script-plugins#script-plugins-create-a-script-plugin--en) can now be created for [Custom Search Fields](https://docs.adaptavist.com/sr4c/latest/features/custom-search-fields).

#### Documentation updates

A [Licensing FAQ](https://docs.adaptavist.com/sr4c/latest/get-help/licensing-faq) was added.

#### Bugs fixed

-   The add/remove listeners action field is not getting updated on editing

## 8.12.0

There are only core component changes in ScriptRunner for Confluence 8.12.0, so we do not have any new features or bug fixes to report.

### Documentation updates

-   [Delete a REST Endpoint That Broke the REST Endpoint Page](https://docs.adaptavist.com/sr4c/latest/get-help/delete-a-rest-endpoint-that-broke-the-rest-endpoint-page) was added to help you troubleshoot REST endpoints.
-   [Create a Confluence Toolbar Dropdown Option](https://docs.adaptavist.com/sr4c/latest/features/fragments/web-section/create-a-confluence-toolbar-dropdown-option) was added to document a workaround for adding a web section if they do not work in your instance.

## 8.11.0

There are only core component changes in ScriptRunner for Confluence 8.11.0, so we do not have any new features or bug fixes to report.

## 8.10.0

### CQL autocomplete updates

CQL autocomplete was added to the CQL fields on the following scripts:

#### Confluence administration built-in scripts

-   [Bulk Delete Attachment Versions](https://docs.adaptavist.com/sr4c/latest/features/built-in-scripts/space-administration-built-in-scripts/bulk-delete-attachment-versions)
-   [Change Content Author](https://docs.adaptavist.com/sr4c/latest/features/built-in-scripts/space-administration-built-in-scripts/change-content-author)
-   [Update Macro](https://docs.adaptavist.com/sr4c/latest/features/built-in-scripts/confluence-administration-built-in-scripts/update-macro)
-   [XPath Search in Pages](https://docs.adaptavist.com/sr4c/latest/features/built-in-scripts/confluence-administration-built-in-scripts/xpath-search-in-pages)

#### Space administration built-in scripts

-   [Add/Remove Watchers](https://docs.adaptavist.com/sr4c/latest/features/built-in-scripts/space-administration-built-in-scripts/add-or-remove-watchers)
-   [Bulk Delete Attachment Versions](https://docs.adaptavist.com/sr4c/latest/features/built-in-scripts/space-administration-built-in-scripts/bulk-delete-attachment-versions)
-   [Change Content Author](https://docs.adaptavist.com/sr4c/latest/features/built-in-scripts/space-administration-built-in-scripts/change-content-author)

#### Jobs

-   [CQL Escalation Services](https://docs.adaptavist.com/sr4c/latest/features/jobs/built-in-jobs/cql-escalation-services)
-   [Old Content Notifier Job](https://docs.adaptavist.com/sr4c/latest/features/jobs/built-in-jobs/old-content-notifier-job)
-   [Prune Old Versions Job](https://docs.adaptavist.com/sr4c/latest/features/jobs/built-in-jobs/prune-old-versions-job)

#### Bugs fixed

-   Page Tree component is broken in 8.9.0
-   Enhanced Search causes poor performance on large instances
-   Excessive runtimes of Space Admin Scripts
-   Markdown Macro with 'Attachment Preview' URL causing slowness in Confluence

## 8.9.0

### CQL autocomplete updates

CQL autocomplete was added to [Add/Remove Watchers built-in script](https://docs.adaptavist.com/sr4c/latest/features/built-in-scripts/space-administration-built-in-scripts/add-or-remove-watchers) and [Add/Remove Watchers listener](https://docs.adaptavist.com/sr4c/latest/features/event-listeners/built-in-listeners/add-or-remove-watchers-listener).

### User interface update to Listeners, Jobs, and Fragments

The Note field has been updated to Name for [Listeners](https://docs.adaptavist.com/sr4c/latest/features/event-listeners), [Jobs](https://docs.adaptavist.com/sr4c/latest/features/jobs), and [Fragments](https://docs.adaptavist.com/sr4c/latest/features/fragments). We have also made the Name field more prominent on the main pages for Listeners, Jobs, and Fragments, so you can easily identify your configurations.

#### Documentation updates

-   [Scripting Resources](https://docs.adaptavist.com/sr4c/latest/best-practices-and-app-management#scripting-resources--en) was added to gather resources for coding help.

#### New features

-   Changes to the Notes field
-   Enhanced Search – Ability to resubmit the search without having to modify my query

## 8.8.0

### Script plugins update

We've done some work on the infrastructure supporting [script plugins](https://docs.adaptavist.com/sr4c/latest/best-practices-and-app-management/script-plugins). As part of this, [resources](https://docs.adaptavist.com/sr4c/latest/features/resources) and [macros](https://docs.adaptavist.com/sr4c/latest/features/macros) can now be exported and worked on in a script plugin. We are aiming to get closer to feature completion in the coming months.

### Dynamic forms update

You can use [`optionsGenerator`](https://docs.adaptavist.com/sr4c/latest/best-practices-and-app-management/dynamic-forms) within the select list annotation to customize your own list options. This is useful if you can't find a dynamic form annotation that is suitable for your purpose.

### Built-in script update

The [Convert Absolute Links to Confluence Links](https://docs.adaptavist.com/sr4c/latest/features/built-in-scripts/confluence-administration-built-in-scripts/convert-absolute-links-to-confluence-links) built-in script has been updated. If an absolute URL points to any version of the page other than the current version, it won't be converted to a Confluence link because it will not work.

#### Bugs fixed

-   @Select annotation should not default to first option
-   allow @Select annotation to take a closure to generate options
-   CodeEditor doesn't load because of wrong MIME type
-   Convert Absolute Links to Confluence Links return NullPointerException error

## 8.7.1

### Confluence compatibility

ScriptRunner for Confluence is now compatible with Confluence 8.4.0.

## 8.7.0

### Bugs fixed

-   Update page restrictions listener documentation links
-   Changes color of the Enhanced Search binocular icon

## 8.6.0

### New features

-   Enhanced search – add parentheses when selecting a value after IN or NOT IN operator

### Bugs fixed

-   UI regression in Bulk Delete Attachment Versions when no results are returned

## 8.5.0

### Bugs fixed

-   CodeEditor doesn't load because of wrong MIME type
-   Enhanced Search - Add quotes when selecting a label
-   Enhanced Search "CQL reference" link is not working
-   Custom macro body is empty when Lazy loading is enabled

## 8.4.0

### Documentation updates

We've identified another breaking change in Groovy 4 that can impact those who use the `@Grab` annotation to import certain external libraries. The [Groovy 4 Breaking Change for Grab Annotations](https://docs.adaptavist.com/sr4c/latest/release-notes/breaking-changes/groovy-4-breaking-change-for-grab-annotations) page has more information on this breaking change and solutions on how to fix it.

Visit the new [Vulnerabilities and Security](https://docs.adaptavist.com/sr4c/latest/get-started/vulnerabilities-and-security) page to learn about how we scan for vulnerabilities and common security concerns.

A [Dynamic Forms](https://docs.adaptavist.com/sr4c/latest/best-practices-and-app-management/dynamic-forms) page was added to the ScriptRunner for Confluence documentation to help you simplify the process of adding variables to your ScriptRunner Groovy scripts.

### Bugs fixed

-   Reduce number of files written to classes directory
-   Empty result set in Local DB connection test return NullPointerException

## 8.3.0

### CQL autocomplete

ScriptRunner for Confluence now features autocomplete for CQL! This feature will dynamically show query options when you type a CQL query in [Enhanced Search](https://docs.adaptavist.com/sr4c/latest/features/enhanced-search).

Check out the [CQL Guide](https://docs.adaptavist.com/sr4c/latest/get-started/cql-guide) and the [Enhanced Search](https://docs.adaptavist.com/sr4c/latest/features/enhanced-search) documentation to learn more.

New features

-   Add logging for bulk delete attachment versions

Bugs fixed

-   Formatting regression in "Bulk delete attachment versions" script output results
-   Create page macro create page with corrupt page links
-   Manage Label - Rename Labels built-in script is adding label to all selected pages
-   "Include Reports" macro can't deal with pages that have # in the title
-   Script Editor does not display a user-friendly error when the System Admin Only Edit Permission is enabled
-   XPath Search built-in script page - checkbox selection not working as expected.

## 8.2.1

### Bugs fixed

-   The script root window in script editor cannot vertically scroll at version 8.0.0

## 8.2.0

### Bugs fixed

-   Spread operator shows STC errors for varargs methods
-   Manage labels built-in script not working for Attachment Content Type
-   Stack trace in log when Administration pages being accessed and Console disappeared.

## 8.1.0

### Bugs fixed

-   3.0.1-b10 version of javax.el has CVE
-   IllegalAccessException within DiagnosticsExecutionHandlerImpl
-   Remove the errors if the script executes successfully
-   allow rest endpoints to handle file uploads
-   'Focus' does not correctly shift to dialogue boxes when ScriptRunner is enable

## 8.0.0

### Groovy 4 update

We have updated ScriptRunner for Confluence Server/Data Center to Groovy 4!

Our primary motivator for this update is to provide support for JDK 17. Groovy 3 doesn't support JDK 17, and with Jira 9.5.0 and Confluence 8.0 being JDK 17 compatible, an upgrade to Groovy 4 is necessary.

So, apart from JDK 17 compatibility, what comes with this update, and how will it benefit you?

#### New features in Groovy 4

The following are the most significant new features that have been added in Groovy 4:

-   [Switch expressions](https://groovy-lang.org/releasenotes/groovy-4.0.html#Groovy4.0-switch-expressions) which, unlike switch statements, are optimized towards branches that handle one case and break out rather than fall through to the next case.
-   [Sealed types](https://groovy-lang.org/releasenotes/groovy-4.0.html#Groovy4.0-sealed-types)
-   [Records](https://groovy-lang.org/releasenotes/groovy-4.0.html#Groovy4.0-new-records)
-   [Ranges have been enhanced](https://groovy-lang.org/releasenotes/groovy-4.0.html#_enhanced_ranges) with support for ranges open on the left, for example, `3<..5`, or both sides, for example, `0<..<3`
-   [Support for annotating generic types](https://groovy-lang.org/releasenotes/groovy-4.0.html#_jsr308_improvements_incubating), for example `List<@IntRange(min = 0, max = 10) Integer>`

Please have a look at the [Groovy 4 Release Notes](https://groovy-lang.org/releasenotes/groovy-4.0.html) for a complete list of new features.

#### Breaking changes in Groovy 4

Groovy 4 contains a number of breaking changes. The ones which are the most significant and likely to affect ScriptRunner users are listed below. Please have a look at the [Groovy 4 Release Notes](https://groovy-lang.org/releasenotes/groovy-4.0.html) for a complete list of breaking changes.

1) Legacy package removal

Groovy 3 provided duplicate versions of numerous classes (in old and new packages) to allow Groovy users to migrate towards the new JPMS-compliant package names - see [the section about it in Groovy 3 Release Notes](http://groovy-lang.org/releasenotes/groovy-3.0.html#Groovy3.0releasenotes-Splitpackages) for more details. Groovy 4 no longer provides duplicate legacy classes.

For backwards compatibility reasons ScriptRunner still ships with the deprecated version of `groovy.util.XmlSlurper` and `groovy.xml.XmlParser`. We recommend you don't use these legacy classes going forward and use their equivalents that can be found in `groovy.xml` package.

2) Changes related to how Groovy code accesses private fields from within closures

Groovy developers are currently attempting to improve how its code accesses private fields in certain scenarios where such access is expected but problematic. For example, within closure definitions where subclasses or inner classes are involved ( [GROOVY-5438](https://issues.apache.org/jira/browse/GROOVY-5438)). You may notice breakages in Groovy 4 code in such scenarios until they fix this issue.

3) Change to `intersect` () default Groovy method

`intersect()` default Groovy method used to draw elements from the second argument passed to it, but now it draws elements from the first argument passed to it - see [GROOVY-10275](https://issues.apache.org/jira/browse/GROOVY-10275).

4) Error message for users using `@Grab` to import certain libraries

There has been a breaking change for users using `@Grab` to import certain libraries. Check out the [Groovy 4 Breaking Change for Grab Annotations](https://docs.adaptavist.com/sr4c/latest/release-notes/breaking-changes/groovy-4-breaking-change-for-grab-annotations) page for more information on this breaking change and solutions on how to fix it.

5) Changes to the resolution of properties with both a getter and isser returning different types

Warning: This Breaking Change will mostly affect Jira API users, but it could affect uncommon parts of the Confluence API. We do not expect this issue to be widespread when using ScriptRunner for Confluence.We've included information about a common example in the Jira API that you could use to solve issues you uncover when working with uncommon parts of the Confluence API.

Note: An isser is a method to retrieve boolean properties. Instead of the method name starting with `get` (as is common for accessor methods), it starts with `is`. See [the JavaBean Properties tutorial](https://docs.oracle.com/javase/tutorial/javabeans/writing/properties.html) for more information.

For properties that have a getter and an isser returning different types (for example, [JiraAuthenticationContext#getLoggedInUser](https://docs.atlassian.com/software/jira/docs/api/latest/com/atlassian/jira/security/JiraAuthenticationContext.html#getLoggedInUser--) and [JiraAuthenticationContext#isLoggedInUser](https://docs.atlassian.com/software/jira/docs/api/latest/com/atlassian/jira/security/JiraAuthenticationContext.html#isLoggedInUser--)) when accessing the property, instead of calling one of the methods (for example, `jiraAuthenticationContext.loggedInUser`), the getter is called in Groovy 3 but the isser is called in Groovy 4 - see [GROOVY-10821](https://issues.apache.org/jira/projects/GROOVY/issues/GROOVY-10821).

Solution

From Groovy 4 if you have custom classes, or are using external classes that implement conflicting isser and getter methods, and you are using the property syntax to get the getter value, you must re-write the logic to use the getter method directly.

For example, this class demonstrates conflicting isser and getter methods:

```
class GetterIsser {
  String getSomething() { 'yes' }
  boolean isSomething() { false }
}
 
def myClass = new GetterIsser()
 
myClass.something // used to return 'yes', as of Groovy 4 will return false
```

From Groovy 4, this should be written as:

```
class GetterIsser {
  String getSomething() { 'yes' }
  boolean isSomething() { false }
}
 
def myClass = new GetterIsser()
 
myClass.getSomething() // will return 'yes'
```

For backward compatibility reasons, ScriptRunner ships with a patch to keep the old Groovy 3 behaviour for two conflicting Jira API properties commonly used in customer scripts:

-   The `loggedInUser` property on `JiraAuthenticationContext`
-   The `created` property on `Issue`

We've included this patch as these properties will likely be heavily used in users' scripts. This means you do not need to change any code using these properties

### Important notice for Java 17 users

There is a current omission in the Confluence archive that may cause compatibility issues with Java 17. You need to manually add the following JVM flag to avoid these issues:

```
 --add-opens=java.base/java.lang.reflect=ALL-UNNAMED
```

See Atlassian's knowledge base guide on [configuring system properties](https://confluence.atlassian.com/doc/configuring-system-properties-168002854.html) for information on how to configure system properties and therefore add the JVM flag.

These flags are required to address module encapsulation introduced in Java 9 and later, which can cause issues when using reflection or accessing certain internal APIs. We are working closely with Atlassian to address this issue in future releases.

### Deprecated SrSpecification class removed

Authors of [script plugins](https://docs.adaptavist.com/sr4c/latest/best-practices-and-app-management/script-plugins) may be used to writing tests which extend the deprecated `com.onresolve.scriptrunner.canned.common.admin.SrSpecification` class. This class has been removed. Authors of tests for their scripts should extend the `spock.lang.Specification` class directly. Tests should still be picked up by [Test Runner built-in script](https://docs.adaptavist.com/sr4c/latest/features/built-in-scripts/confluence-administration-built-in-scripts/test-runner) as normal.

New features

-   Support for JDK 17
