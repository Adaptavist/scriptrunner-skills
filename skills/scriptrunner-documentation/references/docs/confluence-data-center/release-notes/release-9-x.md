# Release 9.x

- Platform: confluence-data-center
- Space: SR4C
- Hierarchy: Release Notes
- Doc ID: doc-sr4c-43275f65-ab36-4011-b363-1544ac076015-b888ceac2415f444
- Source: https://docs.adaptavist.com/sr4c/latest/release-notes/release-9.x

Feature release information about our 9.x versions.

## 9.47.0

26 Nov 2026

### Third-party dependencies updated to remove CVEs

We've updated third party dependencies within ScriptRunner, including `jsoup`, to address known CVEs (Common Vulnerabilities and Exposures). These changes are part of our ongoing hardening work.

### Create Page macro bug fixed

We've fixed an issue where pages created by the _Create Page_ macro from a From Page with attachments showed Created by Anonymous instead of the user who created them. The page creator is now recorded correctly.

### Fragments web item bug fixed

We've fixed an issue where clicking a Web Item fragment set to Navigate to a Link at the `system.content.button` location did nothing. The button now opens the configured link.

### Script engine and diagnostics bugs fixed

We've fixed multiple issues with the script editor and diagnostics:

-   Documentation for Java (JDK) classes in the script editor failed to load and showed Cannot fetch documentation, please check your internet connection. The documentation panel and hover now show a View Documentation on docs.oracle.com link to the relevant class or method page.
-   Log messages written by ScriptRunner for Confluence through SLF4J never reached the Confluence logs. These messages now appear in the logs as expected.

## 9.45.0

### Security update

We've made targeted security improvements in this release as part of our ongoing hardening work. For more details on how we handle security and vulnerability management, see our [Vulnerabilities and Security](https://docs.adaptavist.com/sr4c/latest/get-started/vulnerabilities-and-security) documentation.

### Third-party dependencies updated to remove CVEs

We've updated third-party dependencies within ScriptRunner, including Apache Ant and Apache OpenNLP, to address known CVEs (Common Vulnerabilities and Exposures). These changes are part of our ongoing hardening work.

### Fragments performance improvement

We've made an improvement to how Fragments are processed available to all customers. This reduces the load Fragments place on large or busy instances.

### Script engine and diagnostics bugs fixed

We've fixed several issues with script execution and diagnostics:

-   The script engine could load duplicate classes. Scripts now load and run as expected.
-   Groovy compiler errors, such as `BUG! exception in phase 'class generation'`, were logged with an empty stack trace. These errors now include full stack traces, which makes them easier to diagnose.
-   The ScriptRunner diagnostics tools could fail with a `NoClassDefFoundError` related to logging. Diagnostics now run as expected.

## 9.44.0

### Confluence URL redirect bug fixed

We've fixed an issue where upgrading ScriptRunner for Confluence could temporarily append `undefined` to the base URL and cause navigation errors until Confluence was restarted. Upgrades now complete without altering the URL, and navigation continues to work as expected.

## 9.41.0

### Security update

We've made targeted security improvements in this release as part of our ongoing hardening work. For more details on how we handle security and vulnerability management, see our [Vulnerabilities and Security](https://docs.adaptavist.com/sr4c/latest/get-started/vulnerabilities-and-security) documentation.

## 9.40.0

### Third-party dependencies updated to remove CVEs

We've updated third‑party dependencies within ScriptRunner to address known CVEs (Common Vulnerabilities and Exposures). These changes are part of our ongoing hardening work and do not indicate that your instance was exposed to security issues. For more details on how we handle security and vulnerability management, see our [Vulnerabilities and Security](https://docs.adaptavist.com/sr4c/latest/get-started/vulnerabilities-and-security) documentation.

## 9.39.0

### ScriptRunner menu visibility bug fixed

We've fixed an issue where the Explore built-in scripts menu item was visible to non-admin users. While the underlying functionality was not accessible without appropriate permissions, the menu entry is now correctly hidden from non-admin users to avoid unnecessary exposure of ScriptRunner-related options.

### Execution history status colours bug fixed

We've fixed an issue where execution history entries showed blue/grey icons instead of green for success and red for failure. Execution history now displays the correct status colours again.

## 9.35.1

### Security improvement

In this release, we've focused on improving the security of ScriptRunner for Confluence by addressing known Common Vulnerabilities and Exposures (CVEs). We want to emphasize that this update doesn't mean your instance was vulnerable to security issues. We're always working to make ScriptRunner as safe as possible, and this update is part of that ongoing effort. Check out our page on [Vulnerabilities and Security](https://docs.adaptavist.com/sr4c/latest/get-started/vulnerabilities-and-security) for more details on how we scan for vulnerabilities and common security concerns.

## 9.34.0

There are only core component changes in ScriptRunner for Confluence 9.34.0, so we do not have any new features or bug fixes to report.

## 9.33.0

### Home page update

We've updated the [Home page](https://docs.adaptavist.com/sr4c/latest/get-started/navigation) in ScriptRunner to make it easier to find the functionalities you need.

### Security improvement

We've strengthened the validation and sanitisation of user-supplied content in ScriptRunner web interfaces. No action is required on your side, and this update does not mean your instance was vulnerable to security issues. We're always working to make ScriptRunner as safe as possible, and this update is part of that ongoing effort. Check out our page on [Vulnerabilities and Security](https://docs.adaptavist.com/sr4c/latest/get-started/vulnerabilities-and-security) for more details on how we scan for vulnerabilities and common security concerns.

## 9.32.0

There are only core component changes in ScriptRunner for Confluence 9.32.0, so we do not have any new features or bug fixes to report.

## 9.31.0

### Add/Remove Watchers bug fixed

We've resolved a bug related to one of our Built-in Scripts. Group picker fields in the Add/Remove Watchers built-in script now correctly accept groups whose names contain `#`. Previously, entering a group with # in its name caused the group field to return an error instead of accepting the value.

### Fragment bug fixed

We've resolved a bug related to Fragments. Enabling other apps alongside ScriptRunner no longer causes a Fragment Manager clash. Previously, enabling or disabling apps could trigger a `RuntimeException: org/dom4j/Element` error.

### Script export bug fixed

We've resolved a bug related to [Script Export](https://docs.adaptavist.com/sr4c/latest/features/script-registry#access-the-script-registry--en). Script exports now display the correct script count for all supported script types, including CQL Functions and Macros. Previously, exports sometimes reported a script count of `0` for these types, even when scripts were present because the exporter did not correctly handle the JSON structures used by these script types.

## 9.30.0

### Update

We added a link to the ScriptRunner home page from the Confluence Settings menu.

## 9.29.0

### Script Registry

You may now access the [Script Registry](https://docs.adaptavist.com/sr4c/latest/features/script-registry) from the Tabs view in the Administration options.

The Script Registry allows you to search your ScriptRunner custom scripts, view type-checking errors or deprecation warnings, and export all scripts and configurations on your instance.

[Export scripts](https://docs.adaptavist.com/sr4c/latest/features/script-registry) from the script registry. You can export all ScriptRunner scripts, configurations, and custom fields from your instance, except ScriptRunner JQL function information.

### Fixes

-   We fixed a bug that caused the Create Page macro to return an error when viewed anonymously.
-   We resolved an unexpected error that appeared during configuration of the Update Macro built-in script.

## 9.28.0

There are only core component changes in ScriptRunner for Confluence 9.28.0, so we do not have any new features or bug fixes to report.

## 9.27.0

### Updates

As recommended by [Atlassian](https://confluence.atlassian.com/doc/styling-confluence-with-css-166528400.html), we added a new configuration option within the ScriptRunner settings for system admins to enable/disable custom CSS for macros, and have this disabled by default for all users.

### Fixes

-   We have fixed a bug that caused the _Choose Label_ macro to return an error when viewed anonymously.
-   We have fixed a bug that caused the Enhanced Search information panel to shorten the quick search results pane and prevent it from using the full available height.

## 9.26.1

There are only core component changes in ScriptRunner for Confluence 9.26.1, so we do not have any new features or bug fixes to report.

## 9.26.0

### Fixes

We did backend work to ensure that users are able to configure a custom Web Resource directory for sharing resource files in Confluence 9.

We fixed a bug that caused the _Add Label_ macro not to appear when viewed anonymously.

## 9.24.0

There are only core component changes in ScriptRunner for Confluence 9.24.0, so we do not have any new features or bug fixes to report.

### Advanced Notice for Documentation Versions Removal

On September 17, 2025, we will be removing legacy versions of the documentation. This change is part of our efforts to simplify the customer experience and align with wider industry practices. From September 17 onward, there will be two versions of documentation:

-   The previous version: As of September 17, that will be 8.x. All documentation updates that happened from 8.0 to 8.52 and beyond will be available in 8.x.
-   The latest version: As of September 17, that will be version 9.24. All documentation changes that happened from 9.0 to 9.24 and beyond when we release in the future will be available in the latest version.

If you have a link saved with a version number, you will be redirected to 8.x or the latest version. If you have any questions or concerns, please [contact us](https://the-adaptavist-group-support.atlassian.net/servicedesk/customer/portal/13/user/login?destination=portal%2F13).

Warning: HAPI breaking change advanced notice

The [HAPI](../uncategorized/h/hapi.md) page iterator will be moved. Currently, the page iterator is `import com.adaptavist.hapi.confluence.cql.PageIterator`. It will be updated to `import com.adaptavist.hapi.confluence.pages.PageIterator`.

Please update your HAPI scripts now to avoid broken scripts.

## 9.23.0

### Advanced Notice for Documentation Versions Removal

On September 17, 2025, we will be removing legacy versions of the documentation. This change is part of our efforts to simplify the customer experience and align with wider industry practices. From September 17 onward, there will be two versions of documentation:

-   The previous version: As of September 17, that will be 8.x. All documentation updates that happened from 8.0 to 8.52 and beyond will be available in 8.x.
-   The latest version: As of September 17, that will be version 9.24. All documentation changes that happened from 9.0 to 9.24 and beyond when we release in the future will be available in the latest version.

If you have a link saved with a version number, you will be redirected to 8.x or the latest version. If you have any questions or concerns, please [contact us](https://the-adaptavist-group-support.atlassian.net/servicedesk/customer/portal/13/user/login?destination=portal%2F13).

Warning: HAPI breaking change advanced notice

The [HAPI](../uncategorized/h/hapi.md) page iterator will be moved. Currently, the page iterator is `import com.adaptavist.hapi.confluence.cql.PageIterator`. It will be updated to `import com.adaptavist.hapi.confluence.pages.PageIterator`.

Please update your HAPI scripts now to avoid broken scripts.

### Switch User function update

In response to new Atlassian security requirements, you can only switch a user identity using the [Switch to a Different User](https://docs.adaptavist.com/sr4c/latest/features/built-in-scripts/confluence-administration-built-in-scripts/switch-to-a-different-user) built-in script. Identity switching functionality from User Management and Confluence administration has been deprecated.

### Security improvements

We've made a couple of security improvements in this release:

-   We have implemented a security improvement to our switch user feature. This update strengthens our protection against potential unauthorized account access.
-   We've addressed a known Common Vulnerabilities and Exposures (CVE).

We want to emphasize that this update doesn't mean your instance was vulnerable to security issues. We're always working to make ScriptRunner as safe as possible, and this update is part of that ongoing effort. Check out our page on [Vulnerabilities and Security](https://docs.adaptavist.com/sr4c/latest/get-started/vulnerabilities-and-security) for more details on how we scan for vulnerabilities and common security concerns.

### Documentation update

The [Rewrite Scripts for Cloud Guide](https://docs.adaptavist.com/sr4c/latest/migration/migrating-to-cloud/rewrite-scripts-for-cloud) is ready to help with your migration!

## 9.22.0

### Security improvement

For this release, we've made small changes for compliance with Atlassian's upcoming Content Security Policy (CSP) requirements. Learn more [from Atlassian here](https://community.developer.atlassian.com/t/csp-adoption-in-confluence-10-0/91519).

## 9.21.0

### Security improvement

In this release, we've focused on improving the security of ScriptRunner for Confluence by addressing known Common Vulnerabilities and Exposures (CVEs). We want to emphasize that this update doesn't mean your instance was vulnerable to security issues. We're always working to make ScriptRunner as safe as possible, and this update is part of that ongoing effort. Check out our page on [Vulnerabilities and Security](https://docs.adaptavist.com/sr4c/latest/get-started/vulnerabilities-and-security) for more details on how we scan for vulnerabilities and common security concerns.

## 9.20.0

### New feature: Inbox

We have introduced a new Inbox feature in ScriptRunner. When enabled, it displays notifications about breaking changes, migrations, recommended upgrades, new releases, and other important updates. When disabled, no information displays in the inbox. See the [In-App Communications](https://docs.adaptavist.com/sr4c/latest/get-started/settings/in-app-communications) page for information on how to enable/disable this feature.

Note: In the previous version of ScriptRunner, we incorrectly stated that the Inbox feature was released. It is actually introduced in this version, and the release notes have been updated accordingly

## 9.19.0

### Product update

There are only core component changes in ScriptRunner for Confluence 9.19.0, so we do not have any new features or bug fixes to report.

## 9.18.0

### Product update

There are only core component changes in ScriptRunner for Confluence 8.42.0, so we do not have any new features or bug fixes to report.

### Documentation update

We added a [Migration Checklist](https://docs.adaptavist.com/sr4c/latest/migration/migrating-to-cloud/migration-checklist) to help get you started with migration to ScriptRunner for Confluence Cloud!

## 9.17.0

### Product update

There are only core component changes in ScriptRunner for Confluence 9.17.0, so we do not have any new features or bug fixes to report.

## 9.16.0

### Vulnerability scanner updates

We have updated and added new vulnerability scanners to reduce discrepancies in your vulnerability reports. This is an internal feature that does not require any action from you.

## 9.15.0

### Product update

There are only core component changes in ScriptRunner for Confluence 8.41.0, so we do not have any new features or bug fixes to report.

### Documentation update: Migration

The following migration documentation has been updated:

-   [Feature Parity](https://docs.adaptavist.com/sr4c/latest/migration/migrating-to-cloud/feature-parity)

The following migration documentation has been added:

-   [Confluence Events Parity](https://docs.adaptavist.com/sr4c/latest/migration/migrating-to-cloud/feature-parity/confluence-events-parity)
-   [Macro Migration Tips](https://docs.adaptavist.com/sr4c/latest/migration/migrating-to-cloud/feature-parity/macro-migration-tips)

## 9.14.0

### Confluence compatibility

ScriptRunner for Confluence is now compatible with Confluence 9.2.2 and 9.2.3!

## 9.13.0

### Script registry

There is a new built-in script, [Script Registry](https://docs.adaptavist.com/sr4c/latest/features/script-registry), where you can search all of your custom scripts. You'll be able to see the script's content, type, and location.

## 9.12.0

### Confluence compatibility

ScriptRunner for Confluence is now compatible with Confluence 9.2 and Confluence 9.3!

## 9.11.0

### Documentation update: Removal of legacy versions

In the next few weeks, we will be phasing out all 6.x.x and 7.x.x versions of our documentation from public access. While this change is not expected to impact most users, we recommend taking the following actions:

-   Review your bookmarks: If you have any saved links to our documentation, please verify that they don't point to versions that will be removed.
-   Update your references: Ensure that you're using the most current documentation version for your needs.

If you have any concerns, please contact our [support team](https://www.scriptrunnerhq.com/help/support).

### Product update

There are only core component changes in ScriptRunner for Confluence 9.11.0, so we do not have any new features or bug fixes to report.

## 9.10.0

### New built-in example

There is a new built-in script example, Pages with nested macros, for the [XPath Search in Pages](https://docs.adaptavist.com/sr4c/latest/features/built-in-scripts/confluence-administration-built-in-scripts/xpath-search-in-pages) built-in script. You can use this to find all pages with macros nested inside of other macros in your Confluence instance. Check out the [documentation](https://docs.adaptavist.com/sr4c/latest/features/built-in-scripts/confluence-administration-built-in-scripts/xpath-search-in-pages) to find out more information about using the script.

### Library update: Example scripts have moved to ScriptRunner HQ

Adaptavist Library has been renamed to [Example Scripts](https://www.scriptrunnerhq.com/help/example-scripts) and all scripts have been moved to their new home on the [ScriptRunner HQ](https://www.scriptrunnerhq.com/) website. These example scripts now live alongside the tutorials, case studies and other content designed to help you get the most from ScriptRunner. For more information, check out our [blog](https://www.scriptrunnerhq.com/inspiration/blog/example-scripts-on-scriptrunner-website) on this update.

Note: This update does not affect in-app example scripts, which will continue to function as usual.

## 9.9.0

### Bug fixed

A bug to fix a Confluence compatibility issue with the CVE scan has been implemented.

## 9.8.0

### Updates

-   Confluence compatibility updates have been made.
-   Security improvement
    
    In this release, we've focused on improving the security of ScriptRunner for Jira by addressing known Common Vulnerabilities and Exposure (CVE). We want to emphasise that this update doesn't mean your instance was vulnerable to security issues. We're always working to make ScriptRunner as safe as possible, and this update is part of that ongoing effort.
    
-   In-app feedback
    
    In this release, we have introduced a new feedback system to improve how we gather user insights. You may encounter notifications linking to surveys, which offer a convenient method to share your thoughts about the product.
    
    The notifications will not appear:
    
-   If you've disabled in-app communications in ScriptRunner.
-   If you're using an evaluation license.
-   If your instance is isolated from the internet.

Bugs fixed

-   A bug preventing Tiny URLs from displaying correctly in the _Page Info_ macro is removed.
-   A bug causing REST Endpoint pages to break when a certain script is entered with an error has been removed.
-   A bug preventing a second page from opening when the _Open Page in New Tab_ option is used is removed.
-   A bug causing an error with the _Copy page_ built-in script is removed.

## 9.7.0

### Bug fixed

-   A bug preventing the _Button_ macro from displaying properly in _Edit_ mode is removed.

## 9.6.0

### Confluence 9.1 compatibility added

#### Bugs fixed

-   A bug that prevented _Web Items_ located at `system.space.tools/permissions` from displaying dialogs correctly has been removed.
-   A bug preventing the Copy Space function from working properly when the link text for the page shortcut differs from its corresponding page title is removed.

## 9.5.0

### Bugs fixed

-   A bug preventing scripts from running with erased configuration details is removed.
-   A bug preventing the _Update macro_ built-in script does from working properly with _Excerpt Include_ parameter is removed.
-   A bug preventing proper function of the _Automate removal of old or inactive content_ script is removed.
-   Broken links to _Listeners_ and _Rest end points_ from the ScriptRunner homepage are removed.

## 9.4.0

### Resources update

We have removed some visibility of passwords within [Resources](https://docs.adaptavist.com/sr4c/latest/features/resources). This change is designed to enhance security by preventing credentials from being viewed by other Jira administrators.

### Bugs fixed

-   Page info return error when view anonymously (SRCONF-3111)
-   'Custom Script Macro' throws 'Uncaught SyntaxError: Unexpected end of input' when there is a single line comment in the 'Macro Javascript code' field (SRCONF-2182)

## 9.3.0

### HAPI suggestions

We made it easier to see which scripts HAPI can optimize for you.

Bugs fixed

-   Setting REST endpoint package to scan to empty value does not work (SRPLAT-1209)

## 9.2.0

### Upcoming Resources update

In a forthcoming release, we will be removing the visibility of passwords within [Resources](https://docs.adaptavist.com/sr4c/latest/features/resources). This change is designed to enhance security by preventing credentials from being viewed by other Jira administrators.

Bug fix

-   Markdown macro cause performance issues (SRCONF-3033)

## 9.1.1

There are only core component changes in ScriptRunner for Confluence 9.1.1, so we do not have any new features or bug fixes to report.

## 9.0.0

### Compatibility with Confluence 9

ScriptRunner for Confluence Data Center is now compatible with Confluence 9. See the [Compatibility with Confluence](https://docs.adaptavist.com/sr4c/latest/get-started/update/compatibility-with-confluence#compatibility-with-confluence-10--en) page for more information on Confluence 9 best practices on upgrading your instance.

### Backward compatibility

ScriptRunner 9.0.0 will only support Confluence 9.0. and above and will not be backwards compatible with earlier Confluence versions. Critical bugs and security fixes will continue to be released for ScriptRunner 8.x.x. We recommend users on older versions of Confluence or ScriptRunner plan their upgrade to ensure access to the latest features, performance improvements, and security enhancements. We recommend following our [Compatibility with Confluence](https://docs.adaptavist.com/sr4c/latest/get-started/update/compatibility-with-confluence) page for information and recommendations on how to upgrade.

### Breaking changes

Check out the [Breaking Changes](breaking-changes.md) page for major updates for Confluence 9.0.0 that affect ScriptRunner for Confluence Data Center. Major changes include:

-   Gray APIs removed
-   APIs removed
-   Gadgets removed
-   JDK upgrade

### Fragments updates

To adhere to Confluence 9, the [UI Fragments](https://docs.adaptavist.com/sr4c/latest/features/fragments) feature has the following changes:

[Raw XML Module Breaking Change](https://docs.adaptavist.com/sr4c/latest/release-notes/breaking-changes/raw-xml-module-breaking-change-for-confluence-9): Fragment XML conditions scripts and web panel class scripts are now provided via XML parameters and are no longer directly set as the condition class element attribute or web panel class element attribute value. The previous formats no longer work in Confluence 9.0.0 versions of Scriptrunner. You can use the [Raw XML Module Breaking Change](https://docs.adaptavist.com/sr4c/latest/release-notes/breaking-changes/raw-xml-module-breaking-change-for-confluence-9) guide to help you convert your scripts to the new fragment XML parameters format. Major changes include:

-   Format of the XML condition class attribute and user scripts now added as parameters
-   Format of the XML Web Panel class attribute and user scripts now added as parameters

Note: Related feature documentation has also been updated for the new format here [Raw XML Module Built-In Script](https://docs.adaptavist.com/sr4c/latest/features/fragments/raw-xml-module-built-in-script).

[Web Panel Breaking Change](https://docs.adaptavist.com/sr4c/latest/release-notes/breaking-changes/web-panel-breaking-change-deprecation-for-confluence-9): If you used a `com.atlassian.plugin.web.model.WebPanel` class implementation for the `provider class/script` of your [web panels](https://docs.adaptavist.com/sr4c/latest/features/fragments/web-panel), the way this is processed will be different after upgrading to Confluence 9.0.0. Check out the [Web Panel Breaking Change](https://docs.adaptavist.com/sr4c/latest/release-notes/breaking-changes/web-panel-breaking-change-deprecation-for-confluence-9) page to learn how to update scripts. Major changes include:

-   The `writeHtml` method is now ignored
-   The Atlassian `com.atlassian.plugin.web.model.WebPanel` interface is deprecated and has moved to a new location

[Web Resource Breaking Change](https://docs.adaptavist.com/sr4c/latest/release-notes/breaking-changes/web-resource-breaking-change-for-confluence-9): If you have scripts in `plugin.resource.directories` you will have to move them to `web-resources/com.onresolve.confluence.groovy.groovyrunner`. Check out this page to learn more.

Bugs fixed

-   Script compilation can leak file handles (SRPLAT 2630)
