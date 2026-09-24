# Release 4.x

- Platform: confluence-data-center
- Space: SR4C
- Hierarchy: Release Notes
- Doc ID: doc-sr4c-2e66ccf4-bc9e-4281-8301-2ae68e60699f-f051829c2a5aafad
- Source: https://docs.adaptavist.com/sr4c/latest/release-notes/release-4.x

Feature release information about our 4.x versions.

Check out what's new for ScriptRunner for Confluence.

## 4.3.25

-   Released 08 Feb 2017

Updates

Security Fixes

This update fixes a critical security vulnerability in ScriptRunner for Confluence discovered during an internal review. We strongly recommend all customers apply this update at their earliest opportunity. Further details will be released in the coming weeks as part of Adaptavist's responsible disclosure approach.

All versions of ScriptRunner for Confluence are affected. Below are instructions on which version we recommend you upgrade to:

-   If you have Confluence 5.10.x or above, upgrade to 5.3.35
    
-   If you have Confluence 5.9.x, upgrade to 5.3.34
    
-   If you have Confluence 5.8.x, upgrade to 4.3.25
    

## 4.3.21

-   Released 08 Feb 2017

### Bug Fixes

-   \[SRPLAT-254\] - XSS security issue in the tree view

## 4.3.19

-   Released 08 Feb 2017

### Bug Fixes

-   \[SRCONF-133\] - Markdown macro fails to find correct link for multiple application links

## 4.3.16

-   Released 19 Jan 2017

### Bug Fixes

-   \[SRCONF-142\] - When using the Copy Space built-in script, global templates are being copy as space templates
-   \[SRCONF-143\] - Copy space built-in script is not copying links from the sidebar
-   \[SRCONF-147\] - NPE when installing a dependent plugin with no listeners configured
-   \[SRCONF-151\] - Script Macros are not working after a Confluence restart
-   \[SRCONF-152\] - The Macro editor is not refreshed with the newly created scripted macros
-   \[SRCONF-156\] - Copy space is throwing exceptions

## 4.3.15

-   Released 14 Nov 2016
-   Compatible with Confluence 6.0

### Bug Fixes

-   \[SRPLAT-9\] - REST Endpoints not entirely thread safe
-   \[SRPLAT-10\] - Static type checker error resolving classes

## 4.3.12

-   Released 14 Nov 2016
-   This contains a single fix to the Switch User built-in script.

### Bug Fix

-   \[SRPLAT-5\] - Switch User built in script no longer works

## 4.3.8

-   Released 30 Sep 2016
-   This contains a single fix to the Switch User built-in script

### Bug Fix

-   \[SRPLAT-5\] - Switch User built in script no longer works

## 4.3.7

-   Released 28 Sep 2016

Script Plugins

[Script Plugins](https://docs.adaptavist.com/sr4c/latest/best-practices-and-app-management/script-plugins) have been reworked, and now support including a special descriptor file, so that you can ship a script plugin which contains configured script fragments, rest endpoints, listeners etc.

In addition, we have reworked the documentation for [setting up a development environment](https://docs.adaptavist.com/sr4c/latest/best-practices-and-app-management/set-up-a-dev-environment), and published some sample Maven projects that should get you up and running with a development environment very quickly.

Bug Fix

-   \[SRCONF-127\] - Submitting an event handler with no events causes all event listeners to fail to display

## 4.3.6

-   Released 29 June 2016
-   Compatible with Confluence 5.10.x

New Features

Markdown Macro

The [markdown macro](https://docs.adaptavist.com/sr4c/latest/features/macros/built-in-macros/markdown) will now use app links to get Bitbucket content, using the authentication of the current user.

Bug Fixes

-   \[SRCONF-106\] - Built-in script "rename labels" does not work
-   \[SRCONF-108\] - Use app links for Markdown macro
-   \[SRCONF-112\] - CQL Search macro should have next/prev links
-   \[SRCONF-123\] - compatibility with Confluence 5.10
-   \[SRCONF-126\] - Error when copying space
-   \[SRCONF-95\] - Currency converter macro (including documentation on how)
-   \[SRCONF-99\] - Mug-shot gallery macro

## 4.1.0

-   Released 20 May 2016
-   Initial release of ScriptRunner for Confluence
