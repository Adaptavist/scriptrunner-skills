# Create a Script Plugin

- Platform: data-center
- Space: SR4JS
- Hierarchy: best-practices > write-code
- Doc ID: doc-sr4js-442888904
- Source: https://docs.adaptavist.com/sr4js/latest/best-practices/write-code/create-a-script-plugin

A script plugin is an Atlassian app that bundles ScriptRunner scripts and their configurations. Script plugins can be created for the following ScriptRunner components: 

-   [Event listeners](https://docs.adaptavist.com/sr4js/latest/features/listeners)
    
-   [REST endpoints](https://docs.adaptavist.com/sr4js/latest/features/rest-endpoints)
-   [Script fragments](https://docs.adaptavist.com/sr4js/latest/features/fragments)
-   [Resources](https://docs.adaptavist.com/sr4js/latest/features/resources)

Script plugins are useful for the following types of users: 

-   **Atlassian Experts and partners** who would like to deliver a fully functional business process to a customer without having to copy scripts to their server manually.
    
-   **Developer teams** that would like to implement common software development practices (like version control, automated testing, code review, and continuous integration) for their ScriptRunner scripts.
    

## Advantages

Using a script plugin gives you two practical advantages compared to configuring your scripts through the ScriptRunner UI.

### **Configuration as code**

ScriptRunner supports storing the configuration of your extension points as code. You can bundle a descriptor file (YAML) into your script plugin that details the configuration for an extension point(s) so that your item is automatically configured as soon as the plugin is installed. Upon disabling or removing the script plugin, these items are also removed.

For example, you can provide an event listener, which uses a script inside a script root, and ship these files in a plugin. Upon the plugin's installation, ScriptRunner detects it and installs all the items listed in the descriptor file.

### **A custom script root**

ScriptRunner supports looking up its [script roots](https://docs.adaptavist.com/sr4js/latest/best-practices/write-code/script-roots) from inside another plugin. This means it can automatically add the root of another plugin to its collection of script roots. This allows event listeners, built-in scripts, and other extension points to be loaded directly from those script roots.

## Create a script plugin

The process to create a script plugin is outlined in [Setting up a Development Environment](https://docs.adaptavist.com/sr4js/latest/best-practices/write-code/set-up-a-dev-environment). 

### Basic script plugin

For a basic plugin, it is only necessary to follow the guide up to the _Advanced IntelliJ IDEA Configurations_ section in [Setting up a Development Environment](https://docs.adaptavist.com/sr4js/latest/best-practices/write-code/set-up-a-dev-environment).

### Advanced script plugin: Descriptor file (YAML) 

In addition to following the steps outlined in [Setting up a Development Environment](https://docs.adaptavist.com/sr4js/latest/best-practices/write-code/set-up-a-dev-environment) up to the _Advanced IntelliJ IDEA Configurations_ section, review the following information about setting up YAML files.

Inside the `src/main/resources/` directory of each individual module (`jira`, `confluence`, etc.) you will find a `scriptrunner.yaml` file. This is the descriptor file which contains the details of all your configured extension points. This file is where ScriptRunner looks for all the items that it will automatically configure upon the script plugin’s installation.

There should be an example item already present in the file, like the one shown below.

![A YAML descriptor file, with an example item.](/sr4js/files/latest/442888904/442888918/1/1758746980000/yaml-example+%283%29.png)

The code that needs to go inside the YAML file can be automatically generated using ScriptRunner’s _Configuration Exporter_ built-in script.

The `scriptrunner.yaml` file should be at the root of the plugin’s jar file. Keeping it in `src/main/resources` will make sure this is always the case.

### Advanced script plugin: Quick reload plugin

In addition to following the steps outlined in [Setting up a Development Environment](https://docs.adaptavist.com/sr4js/latest/best-practices/write-code/set-up-a-dev-environment) up to the _Advanced IntelliJ IDEA Configurations_ section, review the following information about setting up quick load plugins.

If you ever modify any compiled code or the YAML descriptor file, you will need to re-install the Script Plugin in order to see your changes. Normally, this is done by running `mvn package` to build a new jar, then running `mvn` `confluence:install` to install the new jar into your application.

The _ScriptRunner Samples_ project comes bundled with the [Quick Reload Plugin](https://bitbucket.org/atlassianlabs/quickreload), which will notice the updated jar (after running `mvn package`) and automatically re-install the plugin into your application.

## Test your script plugin

If you have written integration tests, they can be run using `mvn verify`. The command will:

1.  Start a host application.
    
2.  Run the integration tests inside the application.
    
3.  Shut down the application.
    

The `mvn verify` command runs your whole test suite.

If you would like to run just one test, you can start your application with `mvn <app>:debug`. Then once your app starts, run your tests directly from IntelliJ by clicking the **Run** icon next to your test.

![](/sr4js/files/latest/442888904/442888921/1/1758746980000/idea-run-test-icon+%282%29.png)

## Known limitations

There are some limitations to creating a script plugin:

-   If you disable or uninstall ScriptRunner, your script plugin is also disabled. It will not be re-enabled automatically when you re-enable ScriptRunner. You have to enable it manually.
    
-   Certain extension points cannot be created or configured via the `scriptrunner.yaml` file.
