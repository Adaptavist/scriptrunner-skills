# Script Roots FAQs

- Platform: data-center
- Space: SR4JS
- Hierarchy: get-help > frequently-asked-questions
- Doc ID: doc-sr4js-442888363
- Source: https://docs.adaptavist.com/sr4js/latest/get-help/frequently-asked-questions/script-roots-faqs

### Where are script files stored on Jira Data Center? / Where is the script roots folder on Jira Data Center?

When using ScriptRunner for Jira Data Center, the default location for the script roots is the `<shared_home/scripts>` directory. This is also the location script files are created by default when using the _Script Editor_.

The default script roots `<shared_home>/scripts`, and any custom script root directories created must be accessible to all nodes in the cluster for ScriptRunner features to be able to access the script files.

When you set up Jira Data Center, you are required to create a shared home directory that can be accessed by all nodes in the cluster. Atlassian provides more information on [creating this directory](https://confluence.atlassian.com/jirakb/startup-check-creating-a-shared-home-directory-for-data-center-884705999.html).

  

* * *

## Related content

-   [Script Roots](https://docs.adaptavist.com/sr4js/latest/best-practices/write-code/script-roots)
-   [Write Code](https://docs.adaptavist.com/sr4js/latest/best-practices/write-code)
