# Fragments

- Platform: confluence-data-center
- Space: SR4C
- Hierarchy: Features
- Doc ID: doc-sr4c-dc928e07-a128-4841-aff5-b6bd51dfcede-553b7aad7a1e12e3
- Source: https://docs.adaptavist.com/sr4c/latest/features#fragments--en

Using ScriptRunner, you can customize the web UI by dynamically adding web fragments.

See the Atlassian documentation on [web fragments for Confluence](https://developer.atlassian.com/confdev/confluence-plugin-guide/confluence-plugin-module-types/web-ui-modules).

You can use web fragments to:

-   Show an announcement banner
-   Show different banners for admins, non-admins, and users who are not logged in
-   Add buttons to the _Tools_ menu for particular pages

This is accomplished by adding a UI customization at Administrator > UI > Fragments.

## Types

There are several different types of fragment scripts available:

-   [Web Item](https://docs.adaptavist.com/sr4c/latest/features/fragments/web-item) - A link or button that appears in your chosen location.
-   [Web Panel](https://docs.adaptavist.com/sr4c/latest/features/fragments/web-panel) - Displays additional information in a panel.
-   [Web Section](https://docs.adaptavist.com/sr4c/latest/features/fragments/web-section) - Defines new locations to add items.
-   [Web Resource](https://docs.adaptavist.com/sr4c/latest/features/fragments/web-resource) - Defines custom JavaScript and CSS resources in specific contexts.
-   [Hide UI Element](https://docs.adaptavist.com/sr4c/latest/features/fragments/hide-ui-element-built-in-script) - Hide any system web item or panel, including ones provided by plugins.
-   [XML Module Item](https://docs.adaptavist.com/sr4c/latest/features/fragments/raw-xml-module-built-in-script) - Define a custom web item using raw XML, which gives you more flexibility.

CAUTION: As always, test in a development environment before deploying to your production environment.

## Use Web Fragments

You can add, execute, edit, and delete the scripts from Administrator > UI > Fragments. After restarting your instance, the UI customizations are in place. Some scripts are reloaded automatically, but you can edit the script item and click update if they are not.

Note: Keys

When creating web fragments, the key field is required. Be sure to use original keys for each element. Web fragments with reused keys will not function properly.

All the built-in scripts produce XML that is similar to the XML found in a [plugin descriptor](https://developer.atlassian.com/confdev/confluence-plugin-guide/writing-confluence-plugins/creating-your-plugin-descriptor). You will notice that, for usability reasons, the forms do not provide all the possible configuration elements available in plugins. For example, the web item script does not give you the option to provide a tooltip for the web item link, a velocity context provider, or an icon URL.

You can work around this limitation using the [Raw XML Module](https://docs.adaptavist.com/sr4c/latest/features/fragments/raw-xml-module-built-in-script) script.

## Fragment Locator

Finding the locations and/or sections for web items, web sections, and web panels can be difficult. The _Fragment Locator_ tool is designed to show you the places where you can put these fragments. You can enable (and disable) it from the main _UI Fragments_ page.

CAUTION: Enabling the _Fragment Locator_ changes the UI appearance for every user, so it should not be enabled in a production system.

When you turn on the Fragment Locator, you can select Binding Info on the location you select. A window appears, allowing you to copy the binding information for use in your scripts.

Tip: Copy the location path

You can copy the location path by selecting the copy button.

## Script Fragment Variables

The variables available to you depend on the fragment location. The _Fragment Locator_ tool can help you see which variables are available, so your scripts run as expected.

Fragment binding variables are context-specific, and knowing what is available in certain contexts could help you avoid unexpected scripting errors. After enabling the _Fragment Locator_, you can hover over a fragment to view available binding variables for an item or panel in a specific context.

For example, the following image is of the Confluence homepage with the fragment locator enabled:

## Browse Script Fragment Functionality

You can use the _Search ScriptRunner Functionality_ search bar to search for the available script fragments.

For example, if you're looking for a script fragment that works with web items, you could type web items and press Enter. Then, the list of script fragments is narrowed down to only those containing the word "web items" in their title or description.
