# Update Staging Environment

- Platform: confluence-data-center
- Space: SR4C
- Hierarchy: Best Practices and App Management
- Doc ID: doc-sr4c-52a792f5-ffc9-46fd-8f1c-8a4bc9a043fd-fb3b3cc63614b1a3
- Source: https://docs.adaptavist.com/sr4c/latest/best-practices-and-app-management#update-staging-environment--en

Learn to create a staging environment so you can run tests safely.

If you do not have a staging environment, you should invest the time it takes to create one. You should be able to reliably clone your production instance to the staging environment, so you can test plugins and upgrades.

A good strategy to follow is to:

1.  Make changes to remove all deprecated code while you are using Confluence 8. If you remove deprecated code, then your code has the best chance of working unchanged with Confluence 8.
    
    Note: Deprecated code is shown as a warning.
    
2.  Upgrade your staging instance to Confluence 8.
3.  Review your scripts to make sure you don't have any type checking errors, and Test.
4.  Record changes, if needed.
5.  When upgrading your production instance using inline scripts some changes are necessary. For files, you can update your _Scripts Directory_, e.g. by merging from a branch.

Tip: For information on updating a production environment, visit [Update](https://docs.adaptavist.com/sr4c/latest/get-started/update).
