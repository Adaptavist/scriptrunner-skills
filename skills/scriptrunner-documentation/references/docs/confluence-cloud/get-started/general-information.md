# General Information

- Platform: confluence-cloud
- Space: SR4CC
- Hierarchy: Get Started
- Doc ID: doc-sr4cc-50285bc0-0dd1-482c-b632-4ca9487bbe28-0f9821480dd5e7bd
- Source: https://docs.adaptavist.com/sr4cc/latest/get-started/general-information

An overview of ScriptRunner for Confluence Cloud for those who want to know more about how the app works.

ScriptRunner for Confluence Cloud allows you to extend the functionality of Confluence Cloud by executing scripts to interact with Confluence as [built-in scripts](../features/built-in-scripts.md), [listeners](../features/script-listeners.md), [script fragments](../features/script-fragments.md), etc. Scripts can perform tasks such as updating pages when a space is created or watching a whole page tree. Administrators have the power of the [Groovy programming language](http://www.groovy-lang.org/) at their disposal to respond to events by manipulating Confluence using the REST API.

ScriptRunner for Confluence Cloud follows the same principles as ScriptRunner for Confluence Server/DC. However, the execution model is significantly different due to the differences in extension points between the Atlassian Connect framework used to write add-ons in the cloud and the Plugins V2 framework used in behind-the-firewall implementations. Scripts in ScriptRunner for Confluence Cloud do not execute within the same process as Confluence Data Center. So they must interact with Confluence using the REST APIs rather than the Java APIs. Atlassian Connect is also inherently [asynchronous](general-information/script-execution.md), which means that when a script executes, the user may see the page load before the script has completed.

Read the following sections for more information:

-   [Script Execution](general-information/script-execution.md)
-   [Data Residency](general-information/data-residency.md)
-   [Limitations](general-information/limitations.md)
-   [REST APIs](general-information/rest-apis.md)

Important: At this time, it is not possible to implement CQL Functions.
