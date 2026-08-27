# 2024 Release Notes

- Platform: confluence-cloud
- Space: SR4CC
- Hierarchy: release-notes > older-release-notes
- Doc ID: doc-sr4cc-454394464
- Source: https://docs.adaptavist.com/sr4cc/latest/release-notes/older-release-notes/2024-release-notes

## July 2024

### Example scripts modal

The new [Example Scripts](https://docs.adaptavist.com/sr4cc/latest/scripting-resources/example-scripts) modal is your go-to destination for finding basic examples (formerly the **Examples** field) and Adaptavist [Library](https://library.adaptavist.com/) scripts without having to leave the ScriptRunner app.

![](/sr4cc/files/latest/454394464/454394466/1/1761330089000/example-scripts.png)

The new modal is available everywhere there is a Scripts field throughout ScriptRunner for Confluence Cloud.

### **Send emails with scripts**

You can now [use a custom script to send an email](https://docs.adaptavist.com/sr4cc/latest/scripting-resources/send-an-email-with-a-script). 

## June 2024

### **Updated User Journey**

Now, when you're [installing](https://docs.adaptavist.com/sr4cc/latest/get-started/installation) ScriptRunner for Confluence Cloud, you will be automatically be taken to the [Quick Scripting](https://docs.adaptavist.com/sr4cc/latest/get-started/navigation/quick-scripting) page after clicking **Get Started**.

![](/sr4cc/files/latest/454394464/454394467/1/1761330089000/cloud-browse.png)

From the Browse page, you can search and discover ScriptRunner functionality, including scripts and macros.

## March 2024

### **A New Editor** 

We've replaced our in-app editor component with the new [Code Editor](https://docs.adaptavist.com/sr4cc/latest/scripting-resources/code-editor).

Importantly, this gives us a platform for future improvements. However, there are immediate benefits to this release: you get inline documentation (press **Control+Space** when completions are open), hover over methods and classes to see documentation, see completions automatically as you type, find and replace, and more. 

This editor has autocomplete for the following code: 

-   Groovy
-   Atlassian REST API
-   Custom ScriptRunner-defined script variables 

## February 2024

### Update to Copy Space built-in script

Previously, you could choose to copy the permissions of a space if you had a paid version of Confluence Cloud when working with [Copy Space](https://docs.adaptavist.com/sr4cc/latest/features/built-in-scripts/confluence-administration-built-in-script/copy-space). This is no longer supported, so we removed the option to copy permissions. When you copy a space, default permissions are always applied.

This change applies to both the Confluence Administration built-in script and Space Adminstration built-in script. 

## January 2024

### Increased script timeout limits

We have increased the duration of timeouts for script executions!

The previous limit was set at 120 seconds; now, we have increased this limit to 240 seconds for script executions.
