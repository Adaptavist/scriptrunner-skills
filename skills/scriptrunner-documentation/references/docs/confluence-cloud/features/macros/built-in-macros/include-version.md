# Include Version

- Platform: confluence-cloud
- Space: SR4CC
- Hierarchy: Features > Macros > Built-In Macros
- Doc ID: doc-sr4cc-8158fa02-4dff-425d-a5e8-3206cdf5d368-67bcc029d1121fc4
- Source: https://docs.adaptavist.com/sr4cc/latest/features/macros/built-in-macros/include-version

Use the _Include Version_ macro to choose a specific version of the page to display.

This macro is similar to the [Include Page](https://confluence.atlassian.com/doc/include-page-macro-139514.html) macro.

Using _Include Version_, you can create a space that consists only of boilerplates, which can be great for proposals and reports. The boilerplates can be as long or short as you want them to be; some may only be a combination of include macros.

When including a page using this macro, the page defaults to the number of the latest version. There is an additional macro, _Latest_, which simply tracks the latest version. When _Latest_ is used, it becomes identical to the standard _Include Page_ macro.

Note: Keep in mind that if the version of the page specified in the macro doesn't exist, the macro will display the latest version instead.

You can use the macro browser preview functionality to view the results of including the different versions.

Note: Limitation:

Images inside Include Version content may not show up properly in PDF exports. This is a known Atlassian-side limitation with Forge/Confluence Cloud export, not something specific to Include Version. The PDF export snapshots the macro iframe, and those images often don't load in time.

Workaround:

Use your browser's native print function (File > Print > Ctrl/Cmd + P and select Save as PDF. Because the browser has already fully rendered the macro and image in your active session, the images will appear correctly in the PDF.

## Use Include Version

How to use the Include Version built-in macro.

1.  Open the desired page in Confluence Cloud.
2.  Use the Insert function and select Include Version.
    
    The Include Version dialog opens to the Configuration tab.
    
3.  Select a Page to include. This page contains the content to be used by the macro.
4.  Select a Version. This is the version of the content on the selected page to be used by the macro.
5.  Optional: Optional: Use the Preview tab to confirm that your desired content has been targeted.
6.  Click Save.

The content of the desired page from the selected version is rendered in the macro on your page.
