# Migration Checklist

- Platform: confluence-cloud
- Space: SR4CC
- Hierarchy: Migration
- Doc ID: doc-sr4cc-f3c9edb3-cd86-4acf-96e8-825d57983b0a-9aff49d54626b8ed
- Source: https://docs.adaptavist.com/sr4cc/latest/migration/migration-checklist

Find information needed for your migration between products.

## ✅ Learn about the differences between Data Center and Cloud

Use these resources to learn about feature parity between the two products:

-   [Feature Parity](feature-parity.md)
-   [Confluence Events Parity](https://docs.adaptavist.com/sr4cc/latest/migration/feature-parity/confluence-events-parity)
-   [Platform Differences](platform-differences.md)
-   [Video on this page](https://www.scriptrunnerhq.com/help/migration/scriptrunner-for-confluence)

Note: APIs

When migrating scripts from Atlassian's on-prem to Cloud products, one common question is whether there's a straightforward way to translate the Java API to the REST API. The Java API used in Data Center is fundamentally different from the REST API used in the Cloud, meaning direct translations are rarely possible. However, the Cloud API does provide a rich set of functions which can be leveraged to achieve similar outcomes.

For more information on the Atlassian Cloud API, check out [this page from Atlassian](https://developer.atlassian.com/cloud/).

## ✅ Prepare

### Back up your instance

Start by backing up your current environment, including all scripts and configurations.

### Review your current instance

Decide whether you need to migrate everything or declutter your instance. Then, figure out which scripts can be rewritten for the new environment and which scripts will need an alternative solution.

## ✅ Download and install ScriptRunner for Confluence Cloud

There are two ways you can download and install ScriptRunner for Confluence Cloud: from the [marketplace](https://docs.adaptavist.com/sr4cc/latest/migration/migration-checklist#install-from-the-atlassian-marketplace--en) or from your [instance](https://docs.adaptavist.com/sr4cc/latest/migration/migration-checklist#install-from-your-confluence-instance--en). Choose one and proceed.

### Install from the Atlassian Marketplace

1.  Navigate to the [Marketplace listing](https://marketplace.atlassian.com/apps/1215215/scriptrunner-for-confluence?tab=pricing&hosting=cloud).
2.  Enter your team's details to get a pricing plan for ScriptRunner for Confluence Cloud and select Get it now.
    
3.  Select which instances you want the product installed in.
    
    Tip: When you are logged in to your instance, they will automatically appear on this screen.
    
4.  Select Start Free Trial.

### Install from your Confluence instance

If you would prefer to install from inside your Confluence instance, follow [these steps](../get-started/installation.md).

## ✅ Migrate your macros

When you migrate from ScriptRunner for Confluence Server or Data Center to ScriptRunner for Confluence Cloud, most built-in macros are unsupported and need to be replaced with a custom Cloud macro to perform the same tasks. Check out the [Custom Macros documentation](../features/macros/custom-macros.md) for SciptRunner for Confluence Cloud to learn more.

There are currently three built-in macros that ScriptRunner for Confluence Cloud supports. These built-in macros are:

-   [Add Label](../features/macros/built-in-macros/add-label.md)
-   [Choose Label](../features/macros/built-in-macros/choose-label.md)
-   [Page Info](../features/macros/built-in-macros/page-info.md)

For tips on migrating these macros to ScriptRunner for Confluence Cloud, [check this out](https://docs.adaptavist.com/db/organizations/adaptavist/repositories/master/content/documents/Adaptavist_Content/ScriptRunner/ScriptRunner_for_Confluence_Cloud_SR4CC/topics/macro_migration.dita).

## ✅ Rewrite your scripts

Migration from Scriptrunner for Confluence Server/Data Center to ScriptRunner for Confluence Cloud will require your scripts to be rewritten. This is because the APIs and programming models differ significantly between Confluence Server/Data Center and Confluence Cloud.

Check out this [Rewrite Scripts for ScriptRunner for Confluence Cloud Guide](rewrite-scripts-for-cloud-guide.md) and [ScriptRunner HQ](https://www.scriptrunnerhq.com/inspiration/blog/rewriting-scriptrunner-scripts-for-migration) to start.

### 🚀 Need help?

Check out our [Development Services](https://www.adaptavist.com/solutions/development-services) or [contact us](https://www.scriptrunnerhq.com/about/contact).
