# Scripting resources

- Platform: confluence-data-center
- Space: SR4C
- Hierarchy: Get Started
- Doc ID: doc-sr4c-1677e8b4-c22a-4535-adc4-01ca6c12e96d-1460f8fde58a2981
- Source: https://docs.adaptavist.com/sr4c/latest/get-started#scripting-resources--en

To use ScriptRunner for Confluence to its full capability, write scripts in Groovy to automate and extend your Confluence instance.

Using scripts, you can enhance your Confluence content and administer your Confluence instance easily.

-   Enhance your Confluence spaces, pages, and users
-   Administer your Confluence instance easily

ScriptRunner makes simple tasks even simpler and enables experienced users to perform advanced tasks. You can do anything in a script that you could do in a plugin, usually without the overhead of understanding the host of software development tools and methodologies that a typical plugin developer would have to worry about.

But scripting can be challenging. This page provides information on writing, maintaining, storing, and integrating scripts.

## Write scripts

Every place you write code in ScriptRunner for Confluence uses the [Code Editor](https://docs.adaptavist.com/sr4c/latest/best-practices-and-app-management/code-editor). The browser-based _Code Editor_ provides code completion, inline Javadoc lookups, inline find-and-replace, and error line indications.

To practice scripting with the _Code Editor,_ you can use the [Script Console](https://docs.adaptavist.com/sr4c/latest/features/script-console) to run one-off ad hoc scripts and to learn and experiment with the Confluence API.

### Scripting languages

In ScriptRunner for Confluence, we use the Apache Groovy language to write scripts. Apache Groovy is a dynamic language for the Java platform with a familiar syntax and supports domain-specific language authoring. To learn more about Apache Groovy, visit these resources:

-   [Introduction to Groovy](https://docs.adaptavist.com/sr4c/latest/best-practices-and-app-management/introduction-to-groovy) is an Adaptavist ScriptRunner for Confluence documentation page that links you with specific ScriptRunner coding question resources.
-   The [Apache Groovy website](http://groovy-lang.org/) has in-depth documentation, blog posts, and support to help you learn and troubleshoot Groovy.

Tip: Visit [Using GString Templates](https://docs.adaptavist.com/sr4c/latest/best-practices-and-app-management/using-gstring-templates) to learn how to write Groovy scripts with dynamically generated text in ScriptRunner for Confluence.

## Maintain scripts

ScriptRunner for Confluence has features to help maintain your scripts.

### General script management

Manage your .groovy script files and folders using the ScriptRunner [Script Editor](https://docs.adaptavist.com/sr4c/latest/features/script-editor). Reuse and share scripts across an instance without the need for FTP or server administrator access. With the _Script Editor_, you can create, edit, move, save, rename, and delete .groovy script files and folders in root folders from the ScriptRunner front-end.

### Clear caches

You can run the [Clear Groovy Class Loader](https://docs.adaptavist.com/sr4c/latest/features/built-in-scripts/confluence-administration-built-in-scripts/clear-groovy-class-loader) built-in script to clear caches if automated clearing fails. Classes should be reloaded whenever a script is modified, but dependent classes can fail to reload.

## Store scripts

Scripts are stored in script roots, directories that ScriptRunner automatically scans for scripts. The scripts you store here will be available across all of ScriptRunner. The [Script Roots](https://docs.adaptavist.com/sr4c/latest/best-practices-and-app-management/script-roots) documentation helps you set them up and search script roots.

### Version Control

For large instances with multiple administrators, we recommend establishing a [version control](https://docs.adaptavist.com/sr4c/latest/best-practices-and-app-management/version-control) system (VCS) to maintain your ScriptRunner scripts. Maintaining scripts within a VCS records changes to individual scripts over time, allowing you to revert changes and access old script versions if needed. When troubleshooting, the VCS history may contain metadata indicating why a particular change was made, when it was made, and who initiated the change.

## Integrate with external systems

You can interact with external systems in different ways using ScriptRunner for Confluence. The [Integrations](https://docs.adaptavist.com/sr4c/latest/best-practices-and-app-management#integrations--en) section of this documentation provides information for integrating [Atlassian](https://docs.adaptavist.com/sr4c/latest/integrations/atlassian) products and [databases](https://docs.adaptavist.com/sr4c/latest/integrations/connecting-to-databases) in specific ways. REST Endpoints and Script Plugins give you the power to use integrations however you need.

### REST Endpoints

Use Groovy scripts to define [REST Endpoints](https://docs.adaptavist.com/sr4c/latest/features/rest-endpoints), allowing you to integrate with external systems and exchange data. An endpoint is a URL that runs a script; therefore, they allow you to create custom endpoints to suit your needs.

### Script Plugins

A [Script Plugin](https://docs.adaptavist.com/sr4c/latest/best-practices-and-app-management/script-plugins) is an Atlassian app that bundles ScriptRunner scripts and their configurations. Script plugins can be created for the following ScriptRunner components:

-   [Event Listeners](https://docs.adaptavist.com/sr4c/latest/features/event-listeners)
-   [REST Endpoints](https://docs.adaptavist.com/sr4c/latest/features/rest-endpoints)
-   [Fragments](https://docs.adaptavist.com/sr4c/latest/features/fragments)
-   [Macros](https://docs.adaptavist.com/sr4c/latest/features/macros)
-   [Jobs](https://docs.adaptavist.com/sr4c/latest/features/jobs)
-   [Resources](https://docs.adaptavist.com/sr4c/latest/features/resources)

## Test your code

If you're using ScriptRunner extensively to write a lot of custom code or small amounts of custom code that are heavily relied upon, you're getting into the development platform portion of the product. You can write and run tests to ensure your code is functioning correctly. Visit [Test Your Code](https://docs.adaptavist.com/sr4c/latest/best-practices-and-app-management/test-your-code) to learn how to test your scripts.

When you're writing and testing a large number of scripts, you might want to set up [a dev environment](https://docs.adaptavist.com/sr4c/latest/best-practices-and-app-management/set-up-a-dev-environment). This documentation provides information about requirements, ScriptRunner samples, and configurations.

### Name Custom Components

While your scripts are in the test/development instance before being migrated to production, we recommend using names rather than IDs for custom components to avoid migration issues. Learn more in [Store all Environment Specific Variables](https://docs.adaptavist.com/sr4c/latest/best-practices-and-app-management/store-all-environment-specific-variables).
