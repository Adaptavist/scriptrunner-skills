# Scripting Resources

- Platform: confluence-cloud
- Space: SR4CC
- Hierarchy: n/a
- Doc ID: doc-sr4cc-c8c6cfc4-00bf-45ec-a491-7c707da62c4d-a7ad622459298fa2
- Source: https://docs.adaptavist.com/sr4cc/latest/scripting-resources

Learn about the resources available to make your Confluence Cloud experience better.

To use ScriptRunner for Confluence Cloud to its full capability, write scripts in Groovy to automate and extend your Confluence Cloud instance. Using scripts, you can enhance your Confluence Cloud content and administer your Confluence Cloud instance easily.

-   Enhance your Confluence Cloud spaces, pages, and users
-   Administer your Confluence Cloud instance easily

ScriptRunner simplifies tasks and enables experienced users to perform advanced operations. You can do anything in a script that you could do in a plugin, usually without the overhead of understanding the host of software development tools and methodologies that a typical plugin developer would have to worry about.

But scripting can be challenging. This page provides information on writing, maintaining, storing, and integrating scripts.

## Write scripts

Learn about writing scripts to suit your needs in the Code Editor.

Every place you write code in ScriptRunner for Confluence Cloud uses the [Code Editor](https://docs.adaptavist.com/sr4cc/latest/scripting-resources/code-editor). The browser-based _Code Editor_ provides code completions, inline Javadoc lookups, and error line indications.

To practice scripting with the _Code Editor_, you can use the [Script Console](../../features/script-console.md) to run one-off ad hoc scripts and to learn and experiment with the Confluence API.

### Scripting languages

In ScriptRunner for Confluence Cloud, we use the Apache Groovy language to write scripts. Apache Groovy is a dynamic language for the Java platform with a familiar syntax that allows for domain-specific language authoring. To learn more about Apache Groovy, visit these resources:

-   [Introduction to Groovy](https://docs.adaptavist.com/sr4cc/latest/scripting-resources/introduction-to-groovy) is an Adaptavist ScriptRunner for Confluence Cloud documentation page that links you to specific ScriptRunner coding question resources.
-   The [Apache Groovy website](http://groovy-lang.org/) has in-depth documentation, blog posts, and support to help you learn and troubleshoot Groovy.

### Script Variables

Script Variables allow you to specify variables that can be injected into your scripts.

Use Script Variables to create variables that can be inserted into your scripts. Script Variables are encrypted and stored in your Confluence Cloud instance. You can use them to share common variables between your scripts or to store sensitive data, like passwords, that require encryption rather than hardcoding them in scripts directly.

Note: Please remember that a variable has a String value type, even if the value is a number. It is also worth noting that Script Variables are static and can only be set on the Script Variables page, so you cannot dynamically set the values of these via a script.

#### Naming convention

Variable names must follow these rules:

-   The name must start with a letter
-   Only capital letters are allowed
-   Only digits and the underscore character (\_) are allowed.

#### Limitations

Length limits for variables include:

-   Name is 32 characters max
    
-   Value is 3000 characters max.
    

Note that clicking the show password icon for script variables containing 50 or more characters opens a pop-up window for easy viewing.

## Quick Links

-   [Code Editor](https://docs.adaptavist.com/sr4cc/latest/scripting-resources/code-editor)
-   [Coding Questions](https://docs.adaptavist.com/sr4cc/latest/scripting-resources/coding-questions)
-   [Example Scripts](https://docs.adaptavist.com/sr4cc/latest/scripting-resources/example-scripts)
-   [Introduction to Groovy](https://docs.adaptavist.com/sr4cc/latest/scripting-resources/introduction-to-groovy)
-   [Send an Email with a Script](https://docs.adaptavist.com/sr4cc/latest/scripting-resources/send-an-email-with-a-script)
