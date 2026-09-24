# Macro Migration Tips

- Platform: confluence-data-center
- Space: SR4C
- Hierarchy: Migration > Migrating to or from Cloud > Feature Parity
- Doc ID: doc-sr4c-9ac016be-8f0b-44b6-847d-b7a1f471fd22-e5c0d3ade8e8af1e
- Source: https://docs.adaptavist.com/sr4c/latest/migration#migrating-to-or-from-cloud--en#feature-parity--en#macro-migration-tips--en

Helpful information about macros to use during a migration.

When you migrate from ScriptRunner for Confluence Server or Data Center to ScriptRunner for Confluence Cloud, most built-in macros are unsupported and need to be replaced with a custom Cloud macro to perform the same tasks. There are currently three built-in macros that ScriptRunner for Confluence Cloud supports. These built-in macros are:

-   [Add Label](../../../../confluence-cloud/features/macros/built-in-macros/add-label.md)
-   [Choose Label](../../../../confluence-cloud/features/macros/built-in-macros/choose-label.md)
-   [Page Info](../../../../confluence-cloud/features/macros/built-in-macros/page-info.md)

Tip: Is there a macro that you would like to see supported in Cloud? Do you have an idea for a new macro? We want to hear from you! Please forward your requests and ideas via our [customer support portal](https://productsupport.adaptavist.com/servicedesk/customer/portal/40).

If you open a Confluence page and see the macro highlighted in yellow, the old macro needs to be replaced or converted.

## Convert the macro

Select Convert macro to replace the current Server/Data Center macro with the equivalent Cloud macro

CAUTION: The Cloud version of the Choose Label macro doesn't have as many parameters as the Server/DC version. So if you are converting a Choose Label macro, you may see the following message after you click Convert macro:

You can complete the conversion by clicking Convert Macro or cancel the conversion by clicking Cancel.

Once you have converted a macro, the page refreshes with a Cloud macro replacing the Server/DC macro.

## Remove the macro

Click Remove macro to remove the macro from the page without converting it.
