# Release 10.x

- Platform: confluence-data-center
- Space: SR4C
- Hierarchy: Release Notes
- Doc ID: doc-sr4c-7e328ed1-a1a7-4a15-ad12-8e569f1e4fbe-ee39f1d964103323
- Source: https://docs.adaptavist.com/sr4c/latest/release-notes/release-10.x

Feature release information about our 10.x versions.

## 10.18.0

### Compatibility with Confluence 10.2.18

We are now compatible with Confluence 10.2.18.

## 10.17.0

### Compatibility with Confluence 10.2.15

We are now compatible with Confluence 10.2.15.

## 10.16.0

### Create Page macro 500 error bug fixed

We've fixed an issue in Confluence where the Create Page macro returned a 500 error if the source page had attachments. The macro now creates the page correctly from templates that include attachments.

### Confluence URL redirect bug fixed

We've fixed an issue where upgrading ScriptRunner for Confluence could temporarily break navigation by appending `undefined` to the base URL, leaving Confluence unusable until a restart. Upgrades no longer append this invalid fragment, and Confluence remains accessible immediately after the update.

### Security update

We've made targeted security improvements in this release as part of our ongoing hardening work. For more details on how we handle security and vulnerability management, see our [Vulnerabilities and Security](https://docs.adaptavist.com/sr4c/latest/get-started/vulnerabilities-and-security) documentation.

## 10.15.0

### Create Page macro bugs fixed

We've fixed multiple bugs with the Create Page macro:

-   Non-admin users with valid Confluence permissions were previously redirected to an HTTP 403 error page when clicking the macro link; they can now create pages successfully.
-   When a template was configured, the macro previously created the page but opened it in edit mode and ignored the configured title prefix; it now applies the title prefix and opens the new page in view mode when Target Mode is set to _View_.

### Third-party dependencies updated to remove CVEs

We've updated third‑party dependencies within ScriptRunner to address known CVEs (Common Vulnerabilities and Exposures). These changes are part of our ongoing hardening work and do not indicate that your instance was exposed to security issues. For more details on how we handle security and vulnerability management, see our [Vulnerabilities and Security](https://docs.adaptavist.com/sr4c/latest/get-started/vulnerabilities-and-security) documentation.

## 10.14.0

### ScriptRunner menu visibility bug fixed

We've fixed an issue where the Explore built-in scripts menu item was visible to non-admin users. While the underlying functionality was not accessible without appropriate permissions, the menu entry is now correctly hidden from non-admin users to avoid unnecessary exposure of ScriptRunner-related options.

## 10.11.2

Security improvement

We've strengthened the validation and sanitisation of user-supplied content in ScriptRunner web interfaces. No action is required on your side, and this update does not mean your instance was vulnerable to security issues. We're always working to make ScriptRunner as safe as possible, and this update is part of that ongoing effort. Check out our page on [Vulnerabilities and Security](https://docs.adaptavist.com/sr4c/latest/get-started/vulnerabilities-and-security) for more details on how we scan for vulnerabilities and common security concerns.

## 10.9.0

There are only core component changes in ScriptRunner for Confluence 10.9.0, so we do not have any new features or bug fixes to report.

## 10.8.0

### Updates

#### Home page update

We've updated the [Home page](https://docs.adaptavist.com/sr4c/latest/get-started/navigation) in ScriptRunner to make it easier to find the functionalities you need.

#### Security improvement

We've strengthened the validation and sanitisation of user-supplied content in ScriptRunner web interfaces. No action is required on your side, and this update does not mean your instance was vulnerable to security issues. We're always working to make ScriptRunner as safe as possible, and this update is part of that ongoing effort. Check out our page on [Vulnerabilities and Security](https://docs.adaptavist.com/sr4c/latest/get-started/vulnerabilities-and-security) for more details on how we scan for vulnerabilities and common security concerns.

### Bug fix

-   We fixed a static type checking error.

## 10.7.0

### Compatibility with Confluence 10.2.6

We are now compatible with Confluence 10.2.6.

## 10.6.0

### Add/Remove Watchers bug fixed

We've resolved a bug related to one of our Built-in Scripts. Group picker fields in the Add/Remove Watchers built-in script now correctly accept groups whose names contain `#`. Previously, entering a group with # in its name caused the group field to return an error instead of accepting the value.

### Script export bug fixed

We've resolved a bug related to [Script Export](https://docs.adaptavist.com/sr4c/latest/features/script-registry#access-the-script-registry--en). Script exports now display the correct script count for all supported script types, including CQL Functions and Macros. Previously, exports sometimes reported a script count of `0` for these types, even when scripts were present.

## 10.5.0

### Updates

-   Confluence 10.1.2 compatibility
-   We added a link to the ScriptRunner home page from the Confluence _Settings_ menu.

### New feature

[Export scripts](https://docs.adaptavist.com/sr4c/latest/features/script-registry) from the script registry. You can export all ScriptRunner scripts, configurations, and custom fields from your instance, except ScriptRunner JQL function information.

## 10.4.0

### Updates

-   We added a new pathway to Built-in Scripts. You can now access Built-in Scripts through the Confluence three-dot menu.
-   We've re-worked and re-named the Browse page to _Quick Scripting_.

### Fix

We fixed a bug that caused the Enhanced Search bar to disappear after executing an invalid CQL query.

## 10.3.0

### Script Registry

You may now access the [Script Registry](https://docs.adaptavist.com/sr4c/latest/features/script-registry) from the _Tabs_ view in the _Administration_ options. The Script Registry allows you to search your ScriptRunner custom scripts, view type-checking errors or deprecation warnings, and export all scripts and configurations on your instance.

### Fixes

-   We fixed a bug that caused the Create Page macro to return an error when viewed anonymously.
-   We resolved an unexpected error that appeared during configuration of the Update Macro built-in script.

## 10.2.0

### Updates

As recommended by [Atlassian](https://confluence.atlassian.com/doc/styling-confluence-with-css-166528400.html), we added a new configuration option within the ScriptRunner settings for system admins to enable/disable custom CSS for macros, and have this disabled by default for all users.

### Fixes

-   We have fixed a bug that caused the _Choose Label_ macro to return an error when viewed anonymously.
-   We have fixed a bug that caused the Enhanced Search information panel to shorten the quick search results pane and prevent it from using the full available height.

## 10.1.0

### Macro functionality

We did backend work to ensure our macros work correctly with Confluence 10.

## 10.0.0

### Compatibility with Confluence 10

ScriptRunner for Confluence Data Center is now compatible with Confluence 10. See the [Compatibility with Confluence](https://docs.adaptavist.com/sr4c/latest/get-started/update/compatibility-with-confluence#compatibility-with-confluence-10--en) page for more information on Confluence 10 best practices on upgrading your instance.

### Backward compatibility

ScriptRunner 9.0.0 will only support Confluence 9.0. and above and will not be backwards compatible with earlier Confluence versions. Critical bugs and security fixes will continue to be released for ScriptRunner 8.x.x. We recommend users on older versions of Confluence or ScriptRunner plan their upgrade to ensure access to the latest features, performance improvements, and security enhancements. We recommend following our [Compatibility with Confluence](https://docs.adaptavist.com/sr4c/latest/get-started/update/compatibility-with-confluence) page for information and recommendations on how to upgrade.

### TrustedRequestFactory removed in Confluence 10

Scripts using `com.atlassian.sal.api.net.TrustedRequestFactory` will no longer work. Use the new [HAPI API `OAuthRequestSigner`](https://docs.adaptavist.com/sr4c/latest/hapi/work-with-oauthrequestsigner) instead. Example scripts have been updated accordingly.

### Breaking changes

There are some key breaking changes you should be aware of when upgrading to Jira 11:

-   `TrustedRequestFactory` removed in Jira 11: `com.atlassian.sal.api.net.TrustedRequestFactory` has been removed and will no longer work. Instead, use the HAPI class `com.adaptavist.hapi.platform.oauth.OAuthRequestSigner` to construct HTTP requests.
    
-   Spring and Jakarta update: Jira has upgraded to Spring 6.x and Jakarta EE 10.
    
-   jQuery update: Jira has upgraded to jQuery 3 from version 2.
    

Check out the [Breaking Changes](breaking-changes.md) page for full updates for Confluence 10.0.0 that affect ScriptRunner for Confluence Data Center.
