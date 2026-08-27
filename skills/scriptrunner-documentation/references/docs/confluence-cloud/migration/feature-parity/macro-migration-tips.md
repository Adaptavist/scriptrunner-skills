# Macro Migration Tips

- Platform: confluence-cloud
- Space: SR4CC
- Hierarchy: migration > feature-parity
- Doc ID: doc-sr4cc-123736462
- Source: https://docs.adaptavist.com/sr4cc/latest/migration/feature-parity/macro-migration-tips

When you migrate from ScriptRunner for Confluence Server or Data Center to ScriptRunner for Confluence Cloud, most built-in macros are unsupported and need to be replaced with a custom Cloud macro to perform the same tasks. There are currently three built-in macros that ScriptRunner for Confluence Cloud supports. These built-in macros are: 

-   [Add Label](https://docs.adaptavist.com/sr4cc/latest/features/macros/built-in-macros/add-label)
-   [Choose Label](https://docs.adaptavist.com/sr4cc/latest/features/macros/built-in-macros/choose-label)
-   [Page Info](https://docs.adaptavist.com/sr4cc/latest/features/macros/built-in-macros/page-info)

Is there a macro that you would like to see supported in Cloud? Do you have an idea for a new macro? We want to hear from you! Please forward your requests and ideas via our [customer support portal](https://productsupport.adaptavist.com/servicedesk/customer/portal/40). 

If you open a Confluence page and see the macro highlighted in yellow, the old macro needs to be replaced or converted.

![](/sr4cc/files/latest/123736462/151625730/1/1653555222000/image2022-5-26_9-31-16.png)

## Convert the macro

Select **Convert macro** to replace the current Server/Data Center macro with the equivalent Cloud macro. 

The Cloud version of the **Choose Label** macro doesn't have as many parameters as the Server/DC version. So if you are converting a **Choose Label** macro, you may see the following message after you click **Convert macro**:

![](/sr4cc/files/latest/123736462/151625729/1/1653555222000/image2022-5-26_9-41-47.png)

You can complete the conversion by clicking **Convert Macro** or cancel the conversion by clicking **Cancel**.

Once you have converted a macro, the page refreshes with a Cloud macro replacing the Server/DC macro.

![](/sr4cc/files/latest/123736462/151625728/1/1653555222000/image2022-5-26_9-46-15.png)

## Remove the macro

Click on **Remove macro** to remove the macro from the page without converting it.
