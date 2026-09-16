# 2024 Release Notes

- Platform: confluence-cloud
- Space: SR4CC
- Hierarchy: Release Notes > Older Release Notes
- Doc ID: doc-sr4cc-817b3d69-e01a-4d4f-a6e6-a0b0159e7dae-0ba791c073ccd09d
- Source: https://docs.adaptavist.com/sr4cc/latest/release-notes/older-release-notes/2024-release-notes

## July 2024

### Example scripts modal

The new [Example Scripts](https://docs.adaptavist.com/sr4cc/latest/scripting-resources/example-scripts) modal is your go-to destination for finding basic examples (formerly the _Examples_ field) and Adaptavist [Library](https://library.adaptavist.com/) The new modal is available everywhere there is a Scripts field throughout ScriptRunner for Confluence Cloud.

### Send emails with scripts

You can now [use a custom script to send an email](https://docs.adaptavist.com/sr4cc/latest/scripting-resources/send-an-email-with-a-script).

## June 2024

### Updated User Journey

Now, when you're [installing](../../get-started/installation.md) ScriptRunner for Confluence Cloud, you will be automatically taken to the [Quick Scripting](../../get-started/navigation/quick-scripting.md) page after clicking Get Started.

From the Browse page, you can search and discover ScriptRunner functionality, including scripts and macros.

## March 2024

A New Editor

We've replaced our in-app editor component with the new [Code Editor](https://docs.adaptavist.com/sr4cc/latest/scripting-resources/code-editor).

Importantly, this gives us a platform for future improvements. However, there are immediate benefits to this release: you get inline documentation (press Control+Space when completions are open), hover over methods and classes to see documentation, see completions automatically as you type, find and replace, and more.

This editor has autocomplete for the following code:

-   Groovy
-   Atlassian REST API
-   Custom ScriptRunner-defined script variables

## February 2024

Update to Copy Space built-in script

Previously, you could choose to copy the permissions of a space if you had a paid version of Confluence Cloud when working with [Copy Space](https://docs.adaptavist.com/db/organizations/adaptavist/repositories/master/content/documents/Adaptavist_Content/ScriptRunner/ScriptRunner_for_Confluence_Cloud_SR4CC/topics/copy_space.dita). This is no longer supported, so we removed the option to copy permissions. When you copy a space, default permissions are always applied.

This change applies to both the Confluence Administration built-in script and Space Administration built-in script.

## January 2024

Increased script timeout limits

We have increased the duration of timeouts for script executions!

The previous limit was set at 120 seconds; now, we have increased this limit to 240 seconds for script executions.
