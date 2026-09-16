# Recent Release Notes

- Platform: confluence-cloud
- Space: SR4CC
- Hierarchy: Release Notes
- Doc ID: doc-sr4cc-2fe7725c-fa57-45d9-ab82-09fb7bc7fb9a-b9976606a608a231
- Source: https://docs.adaptavist.com/sr4cc/latest/release-notes/recent-release-notes

Notes on our latest versions of the app.

Check out release notes for the current year here. For other release notes, visit [Older Release Notes](older-release-notes.md).

## 1 September 2026

We have migrated ScriptRunner for Confluence Cloud admin pages to Forge Remote!

All of your data will remain unaffected and accessible. Other than the following updates, ScriptRunner for Confluence Cloud features function the same, and there is no removal of features. You may temporarily see the admin app in both locations. Changes made in either location will be saved.

Warning: Action required: Update bookmarks

Administration page URLs have changed since migration. Please update your bookmarks for any administration pages you have saved.

### App navigation

You can now access our app in two ways:

-   Confluence Administration
-   Your Apps

Navigation to ScriptRunner for Confluence Cloud features is now done through the top navigation:

Select More for the additional features:

-   CQL Script Jobs
-   Script Variables
-   Script Fragments
-   Execution History
-   Script Logs
-   Audit Logs
-   Settings

Tip:

Learn more about how to navigate to and within the app [here](../get-started/navigation.md).

You can now access space administration built-in scripts in two ways:

-   Space Settings > Administration > ScriptRunner
-   Space Apps

Once either of these are selected, the built-in scripts open.

Tip:

Learn more about space administration built-in scripts [here](../features/built-in-scripts/space-administration-built-in-scripts.md).

If you have any questions, please [contact support](https://the-adaptavist-group-support.atlassian.net/servicedesk/customer/portal/18).

## 12 August 2026

### Script Manager enhancement

New script usage functionality has been added to the [Script Manager](../features/script-manager.md) feature that enables you to check where your saved scripts are used in your ScriptRunner for Confluence Cloud instance. It allows you to review details on the location and number of configurations where your scripts are loaded.

## 21 July 2026

### Markdown Macro now available

We've added a Markdown macro to the Built-in Macros section of ScriptRunner for Confluence Cloud! The _Markdown_ macro lets you use Markdown to format Confluence pages. You can use this macro to insert your own markdown inline tags or to render them from a URL. The Markdown macro supports migrated content from ScriptRunner for Confluence DC to our Cloud-based app.

Check out the [Markdown Macro](../features/macros/built-in-macros/markdown.md) now!

## 26 February 2026

### Advance notice for platform change

ScriptRunner for Confluence Cloud is migrating to Forge for our app platform! The upcoming changes are minimal to you and do not require a migration on your end, and all of your data will remain unaffected and accessible. A few updates are coming, including:

-   Navigation to open ScriptRunner for Confluence Cloud
-   Navigation to features within ScriptRunner for Confluence Cloud
-   The order of features within ScriptRunner for Confluence Cloud

We will update this page with more information closer to when the changes will go live. In the meantime, you might take note of your current bookmarks to ScriptRunner because they will need to be updated once the change is live.

### Example Scripts HAPI update

The following [Example Scripts](https://docs.adaptavist.com/sr4cc/latest/scripting-resources/example-scripts) have been updated to include HAPI:

-   Find and replace text across space

### Minor updates

-   We made minor UI refinements to improve visual consistency and clarity. These updates do not affect functionality or navigation.
-   Minor bugs were fixed.

## 12 February 2026

### New HAPI method

You can now get all pages in a space, set the body format of each page, and fetch the body of each page using one HAPI script. Check out [Get all pages and their body format](../hapi/work-with-spaces.md) in a space for more information!

### Bugs fixed

-   HAPI autocomplete for [Work with Templates](../hapi/work-with-templates.md) has been fixed.
-   An error with [Quick Scripting](../get-started/navigation/quick-scripting.md) search and categorization has been fixed.

## 5 February 2026

### Script Manager is now available!

[Script Manager](../features/script-manager.md) allows you to manage saved `.groovy` scripts and folders directly from the ScriptRunner front-end. It enables you to create, edit, save, delete, and rename scripts and folders within your instance without relying on FTP services or server administrators. [Check it out](../features/script-manager.md) now!

## 23 January 2026

### Bugs fixed

Minor bug fixes in Script Jobs and Built-In Scripts were fixed.

## 9 January 2026

### User interface improvements

We made minor UI refinements to improve visual consistency and clarity. These updates do not affect functionality or navigation.

## 18 December 2025

### New HAPI methods

-   [Work with Templates](../hapi/work-with-templates.md): You can now fetch blueprint templates from inside your Confluence instance.
-   [Work with Pages](../hapi/work-with-pages.md): You can now update the body of a page.

Tip: Fetching blueprint templates is also available as an [Example Script](https://docs.adaptavist.com/sr4cc/latest/scripting-resources/example-scripts)!

## 5 December 2025

### Bugs fixed

-   A deprecated endpoint was causing errors when migrating macros from Data Center to Cloud. This issue has been resolved.
-   A bug that affected the Workflow page was fixed.

## 3 December 2025

### New HAPI method

A new [HAPI](../uncategorized/h/hapi.md) method is now available! You can now [set the body format](../hapi/work-with-pages.md) when getting a page.

## 20 November 2025

### Bugs fixed

A bug that affected scripting relative URL requests with `basicAuth` was fixed.

## 17 November 2025

### New HAPI methods are live!

There are new [HAPI](../uncategorized/h/hapi.md) methods available! You can now update the name and the status of a [space](../hapi/work-with-spaces.md).

## 7 November 2025

### Bugs fixed

A bug that affected page counts on the [Bulk Add or Remove Labels on One or More Pages](https://docs.adaptavist.com/sr4cc/latest/features/built-in-scripts/confluence-administration-built-in-scripts/bulk-add-or-remove-labels-on-one-or-more-pages) built-in script was fixed.

## 24 October 2025

### Bugs fixed

-   A bug that affected the Copy Space built-in space was fixed.
-   A bug that affected the Script Fragment space picker was fixed. Now, it will only show active spaces.

## 16 October 2025

### Example Scripts HAPI update

The following [Example Scripts](https://docs.adaptavist.com/sr4cc/latest/scripting-resources/example-scripts) have been updated to include HAPI:

-   Add comment on a page
-   Add label to outdated pages job
-   Perform a CQL search in ScriptRunner for Confluence Cloud.

## 9 October 2025

### Bugs fixed

A bug that affected HAPI autocomplete was fixed.

## 3 October 2025

### New ScriptRunner Home and Quick Scripting pages

We have introduced two new pages in the ScriptRunner for Confluence Cloud app! These updates make ScriptRunner easier to use and navigate. Meet the [ScriptRunner Home](../get-started/navigation/script-runner-home.md) and reimagined [Quick Scripting](../get-started/navigation/quick-scripting.md) pages!

[ScriptRunner Home](../get-started/navigation/script-runner-home.md) provides a snapshot of your Confluence instance's capabilities, highlights current activity within your instance, and directs you to help resources and [Example Scripts](https://docs.adaptavist.com/sr4cc/latest/scripting-resources/example-scripts). Check it out below!

Formerly known as the homepage, the new [Quick Scripting](../get-started/navigation/quick-scripting.md) page can be used to search and discover ScriptRunner functionality, including scripts and macros. Check it out below!

## 1 October 2025

### New HAPI methods are live!

There are new [HAPI](../uncategorized/h/hapi.md) methods available:

-   [Pages](../hapi/work-with-pages.md): You can now move a page to a different space.
-   [Page Components](../hapi/work-with-page-components.md): You can now add a footer comment to a page.
-   [Spaces](../hapi/work-with-spaces.md): You can delete all pages with a certain status from a space.

### HAPI documentation update

As our [HAPI](../uncategorized/h/hapi.md) methods list grows, we've improved the documentation organization to get you the information you need faster. You can now find HAPI methods in four sections:

-   [Search for Pages](../hapi/search-for-pages.md): Find everything you need to search pages in your instance.
-   [Work with Labels](../hapi/work-with-labels.md): Find what you need to work with HAPI methods for labels.
-   [Work with Pages](../hapi/work-with-pages.md): Find what you need to create, delete, move, and update pages using HAPI.
-   [Work with Spaces](../hapi/work-with-spaces.md): Find what you need to create, delete, get space information (including permissions), and search for spaces.

## 26 September 2025

### Example Scripts HAPI update

The following [Example Script](https://docs.adaptavist.com/sr4cc/latest/scripting-resources/example-scripts) has been updated to include HAPI:

-   Delete space

## 19 September 2025

### New HAPI methods are live!

There are new [HAPI](../uncategorized/h/hapi.md) methods available:

-   [Pages](../hapi/work-with-pages.md): You can now get all attachments of a page and search for pages using titles and CQL!
-   [Spaces](../hapi/work-with-spaces.md): You can now delete a space, get all pages in a space, and get space permissions!

## 13 September 2025

### Bug fixed

A bug affecting built-in scripts that returned archived pages was fixed.

## 15 August 2025

### Example Scripts HAPI update

The following [Example Scripts](https://docs.adaptavist.com/sr4cc/latest/scripting-resources/example-scripts) have been updated to include HAPI:

-   Create space
-   Get all spaces
-   Create page in space

### Bug fixed

A bug affecting custom macros that returned an error for specific parameters (like a `string` parameter, for example) was fixed.

### Documentation updates

-   The [Feature Parity](../migration/feature-parity.md) page has been updated with information about Custom REST Endpoints.
-   The new [Rewrite Scripts for Cloud Guide](../migration/rewrite-scripts-for-cloud-guide.md) is there to help you rewrite ScriptRunner for Confluence scripts for your migration from Data Center to Cloud!

## 1 August 2025

### HAPI is live!

Our major scripting innovation is now available to use in ScriptRunner for Confluence Cloud.

[HAPI](../uncategorized/h/hapi.md) is an API optimized for Confluence automations and integrated within the code editor. HAPI is not a new programming language. It's essentially plain Groovy, but it gives you a simpler alternative to Confluence's regular API. You can even mix and match HAPI calls with the Confluence API.

HAPI enables you to create automations and customizations faster than ever. We've simplified the following component APIs with HAPI:

-   [Pages](../hapi/work-with-pages.md): Using HAPI, you can now create new pages, delete pages, get, and update pages by their IDs using simple lines of code.
-   [Labels](../hapi/work-with-labels.md): HAPI makes it easier to add and find labels!
-   [Spaces](../hapi/work-with-spaces.md):

Note: Autocompletions

When using HAPI in the code editor you'll notice helpful completions with available methods within the context of your operation. If you need to display completions after they have disappeared, press the keyboard shortcut Control + Space.

Keep an eye on these release notes and the [HAPI Changelog](hapi-changelog.md) for updates.

### Documentation updates

The [Feature Parity](../migration/feature-parity.md) page has been upated with information about Custom REST Endpoints.

## July 2025

We are changing how we create release notes! We will communicate more changes with you, including small updates and bug fixes. Have feedback for us? [Raise a support ticket here](https://the-adaptavist-group-support.atlassian.net/servicedesk/customer/user/login?destination=portals).

### Bug fixes

We fixed an issue in the Custom Macro that caused non-ASCII characters (such as ç, ã, etc.) to be rendered incorrectly. Previously Previously, text containing these characters was displayed as question marks. With this fix, the macro now accurately displays non-ASCII text as intended.

### Documentation updates

-   The [Feature Parity](../migration/feature-parity.md) page has been updated with information about Script Fragments and CQL Functions.
-   There's a new use case, [Example: Search all pages that contain a specific label](https://docs.adaptavist.com/sr4cc/latest/features/macros/custom-macros/example-cql-function-search-all-pages-that-contain-a-specific-label), to assist in your Data Center to Cloud migration.

### Feature parity documentation update

The [Feature Parity](../migration/feature-parity.md) documentation page has been updated with Cloud parity information for built-in scripts and macros.

## May 2025

### New script fragment type

There is a new type of script fragment called [General Page](../features/script-fragments.md) fragment to help you customize your Confluence instance. You can use this fragment type to open a web page in your Confluence instance, which will look like this:

Check out the documentation [here](../features/script-fragments.md).

### Feature parity documentation update

The [Feature Parity](../migration/feature-parity.md) documentation page has been updated with Cloud parity information for built-in scripts and macros.

## March 2025

### Adaptavist bridge for Fragments

The new [Adaptavist bridge](https://docs.adaptavist.com/sr4cc/latest/features/script-fragments/adaptavist-bridge) is a JavaScript library that allows your [Script Fragments](../features/script-fragments.md) to get Confluence information. The Adaptavist bridge also allows the script to use Confluence REST APIs. Check out the documentation [here](https://docs.adaptavist.com/sr4cc/latest/features/script-fragments/adaptavist-bridge).
