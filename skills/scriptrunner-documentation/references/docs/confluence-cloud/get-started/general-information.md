# General Information

- Platform: confluence-cloud
- Space: SR4CC
- Hierarchy: get-started
- Doc ID: doc-sr4cc-107996193
- Source: https://docs.adaptavist.com/sr4cc/latest/get-started/general-information

ScriptRunner for Confluence Cloud allows you to extend the functionality of Confluence Cloud by executing scripts to interact with Confluence as [built-in scripts](https://docs.adaptavist.com/sr4cc/latest/features/built-in-scripts), [listeners](https://docs.adaptavist.com/sr4cc/latest/features/script-listeners), [script fragments](https://docs.adaptavist.com/sr4cc/latest/features/script-fragments), etc. Scripts can perform tasks such as updating pages when a space is created or watching a whole page tree. Administrators have the power of the [Groovy programming language](http://www.groovy-lang.org/) at their disposal to respond to events by manipulating Confluence using the REST API.

ScriptRunner for Confluence Cloud follows the same principles as ScriptRunner for Confluence Server/DC. However, the execution model is significantly different due to the differences in extension points between the Atlassian Connect framework used to write add-ons in the cloud and the Plugins V2 framework used in behind-the-firewall implementations. Scripts in ScriptRunner for Confluence Cloud do not execute within the same process as Confluence Data Center. So they must interact with Confluence using the REST APIs rather than the Java APIs. Atlassian Connect is also inherently [asynchronous](https://docs.adaptavist.com/sr4cc/latest/get-started/general-information/script-execution), which means that when a script executes, the user may see the page load before the script has completed.

Read the following sections for more information: 

-   [Script Execution](https://docs.adaptavist.com/sr4cc/latest/get-started/general-information/script-execution)
-   [Data Residency](https://docs.adaptavist.com/sr4cc/latest/get-started/general-information/data-residency)
-   [Limitations](https://docs.adaptavist.com/sr4cc/latest/get-started/general-information/limitations)
-   [REST APIs](https://docs.adaptavist.com/sr4cc/latest/get-started/general-information/rest-apis)

At this time, it is not possible to implement CQL Functions.
