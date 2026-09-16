# Macro Migration Tips

- Platform: confluence-cloud
- Space: SR4CC
- Hierarchy: Migration > Feature Parity
- Doc ID: doc-sr4cc-8fc0854f-8947-493d-a67e-2ae059c0336e-a58f533812c9a06d
- Source: https://docs.adaptavist.com/sr4cc/latest/migration/feature-parity#macro-migration-tips--en

Useful information about macros to learn before migrating between ScriptRunner for Confluence Sever/DC and Cloud.

When you migrate from ScriptRunner for Confluence Server or Data Center to ScriptRunner for Confluence Cloud, most built-in macros are unsupported and need to be replaced with a custom Cloud macro to perform the same tasks. There are currently three built-in macros that ScriptRunner for Confluence Cloud supports. These built-in macros are:

-   [Add Label](../../features/macros/built-in-macros/add-label.md)
-   [Choose Label](../../features/macros/built-in-macros/choose-label.md)
-   [Page Info](../../features/macros/built-in-macros/page-info.md)

Note: Is there a macro that you would like to see supported in Cloud? Do you have an idea for a new macro? We want to hear from you! Please forward your requests and ideas via our [customer support portal](https://the-adaptavist-group-support.atlassian.net/servicedesk/customer/portal/18).

If you open a Confluence page and see the macro highlighted in yellow, the old macro needs to be replaced or converted.

## Convert the macro

Select Convert macro to replace the current Server/Data Center macro with the equivalent Cloud macro.

Warning: The Cloud version of the Choose Label macro doesn't have as many parameters as the Server/DC version. So if you are converting a Choose Label macro, you may see the following message after you click Convert macro:

You can complete the conversion by clicking Convert Macro or cancel the conversion by clicking Cancel.

Once you have converted a macro, the page refreshes with a Cloud macro replacing the Server/DC macro.

## Remove the macro

Click Remove macro to remove the macro from the page without converting it.
