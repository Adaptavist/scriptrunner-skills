# Compatibility with Confluence

- Platform: confluence-data-center
- Space: SR4C
- Hierarchy: Get Started > Update
- Doc ID: doc-sr4c-87d31f1e-8617-4e94-af55-62345b488475-d30f01d45287bb07
- Source: https://docs.adaptavist.com/sr4c/latest/get-started#update--en#compatibility-with-confluence--en

Information about compatibility between ScriptRunner for Confluence Server/DC and specific versions of Confluence.

## Confluence 10

### Compatibility with Confluence 10

Only those versions marked as compatible in the Atlassian Marketplace will work with Confluence 10. This process should be familiar and relatively smooth if you have been through the Confluence 8 to Confluence 9 upgrade. For further reference, see [Atlassian's Preparing for Confluence 10](https://confluence.atlassian.com/doc/preparing-for-confluence-10-0-1509720080.html) documentation. The information on this page is focused on the areas of change likely to affect your scripts.

### Script functionality

If you upgrade without modifications, some of your scripts may fail. The major areas of change are listed below and on the [Breaking Changes](../../release-notes/breaking-changes.md) page.

### Upgrades and staging Environments

If you do not have a staging environment, check out [the Atlassian documentation to create one](https://confluence.atlassian.com/doc/create-a-staging-environment-for-upgrading-confluence-866094180.html). You should be able to reliably clone your production instance to the staging environment so that you can test plugins and upgrades.

We recommend the following strategy:

1.  Make changes to remove all deprecated code before you upgrade. If you remove deprecated code, then your code has the best chance of working unchanged with Confluence 10.
    
    Note: Deprecated code is shown as a warning.
    
2.  Upgrade your staging instance to Confluence 10.
3.  Review your scripts to make sure you don't have any type checking errors, and Test.
4.  Record changes, if needed.
5.  When upgrading your production instance using inline scripts, some changes are necessary. For files, you can update your _Scripts Directory_, e.g. by merging from a branch.

### Changes to Confluence Java API

You can review changes to the Confluence Java API on Atlassian's [Deprecated Code Paths Removed in 10.0.](https://confluence.atlassian.com/doc/deprecated-code-paths-removed-in-9-0-1333827747.html)

### Anything else?

Did we miss something important that script authors should take into account when upgrading? Please [let us know](https://the-adaptavist-group-support.atlassian.net/servicedesk/customer/portal/13).

If it's likely to affect more than a couple of users, we will add it to this documentation.

## Confluence 9

### Compatibility with Confluence 9

Only those versions marked as compatible in the Atlassian Marketplace will work with Confluence 9. If you have been through the Confluence 7 to Confluence 8 upgrade, this process should be familiar and relatively smooth. For further reference, see [Atlassian's Preparing for Confluence 9](https://confluence.atlassian.com/doc/preparing-for-confluence-9-0-1333827518.html) documentation. The information on this page is focused on the areas of change likely to affect your scripts.

### Script functionality

Some of your scripts may fail if you upgrade without modifications. The major areas of change are listed below and on the [Breaking Changes](../../release-notes/breaking-changes.md) page.

### Upgrades and staging Environments

If you do not have a staging environment, check out [the Atlassian documentation to create one](https://confluence.atlassian.com/doc/create-a-staging-environment-for-upgrading-confluence-866094180.html?_ga=2.207914705.216492954.1723491220-411303320.1718722849). You should be able to reliably clone your production instance to the staging environment so that you can test plugins and upgrades.

A good strategy to follow is to:

1.  Make changes to remove all deprecated code before you upgrade. If you remove deprecated code, then your code has the best chance of working unchanged with Confluence 9.
    
    Deprecated code is shown as a warning.
    
2.  Upgrade your staging instance to Confluence 9.
3.  Review your scripts to ensure you have no type checking errors, and Test.
4.  Record changes, if needed.
5.  When upgrading your production instance using inline scripts, some changes are necessary. For files, you can update your _Scripts Directory_, e.g. by merging from a branch.

### Changes to Confluence Java API

You can review changes to the Confluence Java API on Atlassian's [Deprecated Code Paths Removed in 9.0.](https://confluence.atlassian.com/doc/deprecated-code-paths-removed-in-9-0-1333827747.html)

### Anything else?

Did we miss something important that script authors should take into account when upgrading? Please [let us know](https://the-adaptavist-group-support.atlassian.net/servicedesk/customer/portal/13).

If it's likely to affect more than a couple of users, we will add it to this documentation.

## Confluence 8

### Compatibility with Confluence 8

Only those versions marked as compatible in the Atlassian Marketplace will work with Confluence 8.

Note: Some of your scripts may fail if you upgrade without modifications.

If you have been through the Confluence 6 → 7 upgrade, you have little to fear in upgrading to Confluence 8.

You may not need to make any changes to your own scripts. The major areas of change are listed below.

For further reference, see Atlassian's [Preparing for Confluence 8](https://confluence.atlassian.com/doc/preparing-for-confluence-8-0-1095775426.html) documentation. The information here is focused on the areas of change likely to affect script writers.

Tip: Please manually review your configured scripts for each feature.

### Upgrades and staging Environments

If you do not have a staging environment, you should invest the time it takes to create one. You should be able to reliably clone your production instance to the staging environment, so you can test plugins and upgrades.

A good strategy to follow is to:

1.  Make changes to remove all deprecated code while you are using Confluence 8. If you remove deprecated code, then your code has the best chance of working unchanged with Confluence 8.
    
    Note: Deprecated code is shown as a warning.
    
2.  Upgrade your staging instance to Confluence 8.
3.  Review your scripts to make sure you don't have any type checking errors, and Test.
4.  Record changes, if needed.
5.  When upgrading your production instance using inline scripts some changes are necessary. For files, you can update your _Scripts Directory_, e.g. by merging from a branch.

### Changes to Confluence Java API

You can review changes to the Confluence Java API on Atlassian's [Deprecated Code Paths Removed in 8.0.](https://confluence.atlassian.com/doc/deprecated-code-paths-removed-in-8-0-1167825206.html)

### Anything else?

Did we miss something important that script authors should take into account when upgrading? Please [let us know](https://the-adaptavist-group-support.atlassian.net/servicedesk/customer/portal/13).

If it's likely to affect more than a couple of users we will add it to this documentation.
