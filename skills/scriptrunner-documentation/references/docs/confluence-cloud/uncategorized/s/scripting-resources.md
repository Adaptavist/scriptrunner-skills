# Scripting Resources

- Platform: confluence-cloud
- Space: SR4CC
- Hierarchy: n/a
- Doc ID: doc-sr4cc-81dbede4-1435-432d-a0ed-ab4335aaffbf-a7ad622459298fa2
- Source: https://docs.adaptavist.com/sr4cc/latest/scripting-resources

Learn about the resources available to make your Confluence Cloud experience better.

To use ScriptRunner for Confluence Cloud to its full capability, write scripts in Groovy to automate and extend your Confluence Cloud instance. Using scripts, you can enhance your Confluence Cloud content and administer your Confluence Cloud instance easily.

-   Enhance your Confluence Cloud spaces, pages, and users
-   Administer your Confluence Cloud instance easily

ScriptRunner makes things easier and allows experienced users to perform advanced tasks. You can do anything in a script that you could do in a plugin, usually without the overhead of understanding the host of software development tools and methodologies that a typical plugin developer would have to worry about.

But scripting can be challenging. This page provides information on writing, maintaining, storing, and integrating scripts.

## Write scripts

Learn about writing scripts to suit your needs in the Code Editor.

Every place you write code in ScriptRunner for Confluence Cloud uses the [Code Editor](https://docs.adaptavist.com/sr4cc/latest/scripting-resources/code-editor). The browser-based _Code Editor_ provides code completions, inline Javadoc lookups, and error line indications.

To practice scripting with the _Code Editor,_ you can use the [Script Console](../../features/script-console.md) to run one-off ad hoc scripts and to learn and experiment with the Confluence API.

### Scripting languages

In ScriptRunner for Confluence Cloud, we use the Apache Groovy language to write scripts. Apache Groovy is a dynamic language for the Java platform with a familiar syntax, and it allows for domain-specific language authoring. To learn more about Apache Groovy, visit these resources:

-   [Introduction to Groovy](https://docs.adaptavist.com/sr4cc/latest/scripting-resources/introduction-to-groovy) is an Adaptavist ScriptRunner for Confluence Cloud documentation page that links you with specific ScriptRunner coding question resources.
-   The [Apache Groovy website](http://groovy-lang.org/) has in-depth documentation, blog posts, and support to help you learn and troubleshoot Groovy.

### Script variables

Script variables allow you can specify variables that can be injected into your scripts.

Script Variables are encrypted and stored in your Confluence Cloud instance. You can use them to share common variables between your scripts or to store sensitive data like passwords that require encryption rather than hardcoding them in scripts directly.

Tip: Remember that variable value has a type `String`, even if the value is a number.

Variable names must follow these rules:

-   Start with a letter
    
-   Only capital letters are allowed
    
-   Only letters, digits, and the underscore character (\_) are allowed
    

Length limit for variable:

-   Name is 32 characters
    
-   Value is 128 characters
    

## Quick Links

-   [Code Editor](https://docs.adaptavist.com/sr4cc/latest/scripting-resources/code-editor)
-   [Coding Questions](https://docs.adaptavist.com/sr4cc/latest/scripting-resources/coding-questions)
-   [Example Scripts](https://docs.adaptavist.com/sr4cc/latest/scripting-resources/example-scripts)
-   [Introduction to Groovy](https://docs.adaptavist.com/sr4cc/latest/scripting-resources/introduction-to-groovy)
-   [Send an Email with a Script](https://docs.adaptavist.com/sr4cc/latest/scripting-resources/send-an-email-with-a-script)
