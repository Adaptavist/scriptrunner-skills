# Migration Checklist

- Platform: confluence-data-center
- Space: SR4C
- Hierarchy: Migration > Migrating to or from Cloud
- Doc ID: doc-sr4c-38afbad9-4976-419d-b90e-21778ee2411f-353fd908ab71c3c2
- Source: https://docs.adaptavist.com/sr4c/latest/migration#migrating-to-or-from-cloud--en#migration-checklist--en

Use this checklist to perform a migration between products as safely and efficiently as possible.

## ✅ Learn the differences between Data Center and Cloud

Use these resources to learn about feature parity between the two products:

-   [Feature Parity](https://docs.adaptavist.com/sr4c/latest/migration/migrating-to-or-from-cloud/feature-parity)
-   [Confluence Events Parity](https://docs.adaptavist.com/sr4c/latest/migration/migrating-to-or-from-cloud/feature-parity/confluence-events-parity)
-   [Platform Differences](https://docs.adaptavist.com/sr4c/latest/migration/migrating-to-or-from-cloud/platform-differences)
-   [Video on this page](https://www.scriptrunnerhq.com/help/migration/scriptrunner-for-confluence)

Note: Note about APIs

When migrating scripts from Atlassian's on-prem to Cloud products, one common question is whether there's a straightforward way to translate the Java API to the REST API. The Java API used in Data Center is fundamentally different from the REST API used in the Cloud, meaning direct translations are rarely possible. However, the Cloud API does provide a rich set of functions which can be leveraged to achieve similar outcomes.

For more information on the Atlassian Cloud API, check out [this page from Atlassian](https://developer.atlassian.com/cloud/).

## ✅ Prepare

### Back up your instance

Start by backing up your current environment, including all scripts and configurations.

### Review your current instance

Decide whether you need to migrate everything or declutter your instance. Then, figure out which scripts can be rewritten for the new environment and which scripts will need an alternative solution.

## ✅ Download and install ScriptRunner for Confluence Cloud

There are two ways you can download and install ScriptRunner for Confluence Cloud: from the [marketplace](https://docs.adaptavist.com/sr4c/latest/migration/migrating-to-or-from-cloud/migration-checklist#install-from-the-atlassian-marketplace--en) or from your [instance](https://docs.adaptavist.com/sr4c/latest/migration/migrating-to-or-from-cloud/migration-checklist#install-from-your-confluence-instance--en). Choose one and proceed:

### Install from the Atlassian Marketplace

1.  Navigate to the [Marketplace listing](https://marketplace.atlassian.com/apps/1215215/scriptrunner-for-confluence?tab=pricing&hosting=cloud).
2.  Enter your team's details to get a pricing plan for ScriptRunner for Confluence Cloud and select Get it now.
    
3.  Select which instances you want the product installed in.
    
    Tip: When you are logged in to your instance, they will automatically appear on this screen.
    
4.  Select Start Free Trial.

### Install from your Confluence instance

If you would prefer to install from inside your Confluence instance, follow [these steps](https://docs.adaptavist.com/sr4c/latest/get-started/installation).

## ✅ Migrate your macros

When you migrate from ScriptRunner for Confluence Server or Data Center to ScriptRunner for Confluence Cloud, most built-in macros are unsupported and need to be replaced with a custom Cloud macro to perform the same tasks. Check out the [Custom Macros documentation.](../../../confluence-cloud/features/macros/custom-macros.md) for SciptRunner for Confluence Cloud to learn more.

There are currently three built-in macros that ScriptRunner for Confluence Cloud supports. These built-in macros are:

-   [Add Label](../../../confluence-cloud/features/macros/built-in-macros/add-label.md)
-   [Choose Label](../../../confluence-cloud/features/macros/built-in-macros/choose-label.md)
-   [Page Info](../../../confluence-cloud/features/macros/built-in-macros/page-info.md)

For tips on migrating these macros to ScriptRunner for Confluence Cloud, [check this out](https://docs.adaptavist.com/sr4c/latest/migration/migrating-to-or-from-cloud/feature-parity/macro-migration-tips).

## ✅ Rewrite your scripts

Migration from Scriptrunner for Confluence Server/Data Center to ScriptRunner for Confluence Cloud will require your scripts to be rewritten. This is because the APIs and programming models differ significantly between Confluence Server/Data Center and Confluence Cloud.

Check out this [Rewrite Scripts for ScriptRunner for Confluence Cloud Guide](https://docs.adaptavist.com/sr4c/latest/migration/migrating-to-or-from-cloud/rewrite-scripts-for-cloud) and [ScriptRunner HQ](https://www.scriptrunnerhq.com/inspiration/blog/rewriting-scriptrunner-scripts-for-migration) to start.

### 🚀 Need help?

Check out our [Development Services](https://www.adaptavist.com/solutions/development-services) or [contact us](https://www.scriptrunnerhq.com/about/contact).

## Runbook

We've created a downloadable file that serves as a runbook template for migrations. Use this runbook to plan, track, and verify the end-to-end migration process between platforms. It standardizes steps, ownership, and validation to ensure consistent execution across teams. It's designed for project managers, migration leads, and technical specialists responsible for executing or coordinating migration tasks.

Tip: Save a copy

We recommend saving a blank copy before entering data.

Download: [Runbook\_Template\_v1.0.xlsx](https://docs.adaptavist.com/sr4c/latest/migration#migrating-to-or-from-cloud--en#migration-checklist--en)
