# Use the Dev and Deployment Tool

- Platform: migration-suite
- Space: SMS
- Hierarchy: scriptrunner-dev-and-deployment-tool
- Doc ID: doc-sms-448135912
- Source: https://docs.adaptavist.com/sms/latest/scriptrunner-dev-and-deployment-tool/use-the-dev-and-deployment-tool

Check out this page to set up the tool and start adding repositories. 

## Background knowledge

To use the Dev and Deployment Tool, we assume you can do a few fairly technical things:

1.  Use git, at least a little, to manage code. It's totally fine if you use tools like SourceTree or your IDE to make this easier for you.
2.  Run commands using an IDE like IntelliJ IDEA or via a terminal or command line. We'll tell you which [commands](#id-.UsetheDevandDevelopmentToolvCurrent-com).

The Dev and Deployment Tool works by running Gradle tasks to send your scripts' code and configuration to ScriptRunner Cloud. You don't need to know anything about Gradle or how it works to use the tool, as long as you can run the commands described in the documentation here.

## Set up the tool using a sample repository

Follow these instructions to set up your tool:

You can find the same information in the [README](https://bitbucket.org/adaptavistlabs/migration-example-project/src/main/README.md) for the sample repository, which is named `migration-example-project`.

1.  Navigate to the [sample repository](https://bitbucket.org/adaptavistlabs/migration-example-project/). 
2.  Clone the sample repository by selecting **Clone** in the upper right-hand corner. 
    1.  In the dropdown, Choose if you want to clone the **SSH** or the **HTTPS**.
    2.  Choose your method of cloning: 
        -   To clone using the terminal, **Copy** the command to paste into your terminal in the chosen repository. 
        -   Choose **Clone in Sourcetree** to clone the repo using a GIT client for macOS. 
        -   Choose **Clone in VS Code** to clone the repo to a source-code editor developed by Microsoft.
3.  Update the `gradle.properties` file in your local copy of the `migration-example-project` with your instance URL to connect to your Jira Cloud instance. Use the following format:  
    
    ```
targetAtlassianSite=https://your-instance-goes-here.atlassian.net
```
    

## Authenticate the Dev and Deployment Tool for your site 

To add scripts to your instance, the Dev and Deployment Tool has to authenticate against your site.

Normally, this happens automatically. When you run a deployment command, a browser window opens asking for your permission. When you click **Allow**, the Dev and Deployment tool caches your credentials. 

![](/sms/files/latest/448135912/524228899/1/1775072397000/DnD+Tool+Login+Permission+Dialog.png)

Browser-based authentication known bug

Browser-based authentication for the [Dev and Deployment Tool](https://docs.adaptavist.com/sms/latest/scriptrunner-dev-and-deployment-tool) is broken for newer versions of Chrome and Firefox. The Local Network Access (LNA) restrictions in these browsers block iframe-initiated requests to localhost. Unfortunately, this error is outside of our control, but we do have workarounds for you.

#### Recommended workaround

[Use API token authentication](#id-.UsetheDevandDevelopmentToolvCurrent-token)

#### Alternative workarounds

-   Downgrade to older browser versions. 
    -   Firefox: 150 or earlier
    -   Chrome: 140 or earlier
-   Disable browser security settings
    -   Chrome:
        1.  Navigate to `chrome://flags/#local-network-access-check`. 
        2.  Change **Local Network Access Checks** to _Disabled_.
    -   Firefox: 
        1.  Navigate to `about:config.` 
        2.  Set `network.lna.enabled` to `false`.

### Set up Atlassian API token credentials 

While the automated process works, you could need something else for the following reasons: 

-   You're using the Dev and Deployment Tool inside a Continuous Integration Environment like Jenkins, Bitbucket Pipelines, GitHub Actions, Gitlab Pipelines, or something similar
-   You would like to avoid the Allow/Deny dialog box and want to remove this one

Follow these steps to set up new Atlassian token credentials to add to your home directory: 

1.  Navigate to [your Atlassian profile](https://id.atlassian.com/manage-profile/security/api-tokens). 
2.  Select **Create API Token**.   
    
    A window will appear with your credentials. Copy this token because it will not be visible once the window is closed. Make sure to save it in a safe place, like a password manager.  
    Atlassian API tokens allow a user to act as you on any instance connected to your Atlassian account. Protect this token as you would any other password.
    
3.  Make the credentials available in your environment.
    1.  For a CI/CD environment, you'll typically save the credentials as environment variables (such as `${ATLASSIAN_USER}` and `${ATLASSIAN_TOKEN}`). You can then add arguments like `-PatlassianUser="${ATLASSIAN_USER}" -PatlassianToken="${ATLASSIAN_TOKEN}"`  to any of the Gradle commands your CI/CD pipelines are running. 
    2.  For a local development environment:
        1.  Open your [Gradle user home directory](https://docs.gradle.org/current/userguide/directory_layout.html#dir:gradle_user_home), named `.gradle`  in your user home directory. Inside that directory, edit (or create) the file `gradle.properties`.
            
            Your user home directory varies, depending on your operating system. Assuming your username is `me`, it might be `/Users/home/me` on Mac OSX, `C:\Users\me` on Windows, or `/home/me` on Linux.  
            
        2.  Paste that user and token into this gradle.properties document using the following format:  
            
            ```
atlassianUser=[your email address]
atlassianToken=[your token from the previous step]
```
            
            Keeping your credentials in your user home `gradle.properties` file will allow you to reuse them across multiple projects. Setting the target instance in the project's `gradle.properties` file will make it easier if you have multiple projects in progress, each one in a different directory. It will also save you from publishing in an incorrect place. Finally, it makes collaboration between multiple users working on the same migration easier.
            

## Optional: Add your old scripts to the project

You may find it helpful to have your old scripts from DC alongside your new Cloud scripts while you edit. This step is entirely optional and is mainly intended for users who want to do a side-by-side comparison of the cloud code and the DC code in their favorite code editor.

To add your scripts to the sample repo to start using the tool, follow these steps:

1.  Make sure you have your [script export](https://docs.adaptavist.com/sr4js/latest/features/script-registry#exporting-your-scripts).
2.  Add your script code to the Data Center scripts to the `onprem/src/main/groovy` directory. 

## Rewrite your scripts

1.  Rewrite the scripts for Cloud however you like (perhaps with the help of the [Migration Agent](https://docs.adaptavist.com/sms/latest/scriptrunner-migration-suite-web-app/scriptrunner-migration-agent)), and put the Cloud equivalent scripts in the `cloud/src/main groovy` folder.
2.  Edit the `cloud/src/main/resources/extensions.yaml` file to include the configuration for each supported feature (the [Migration Agent](https://docs.adaptavist.com/sms/latest/scriptrunner-migration-suite-web-app/scriptrunner-migration-agent) can help with this too)
    
    Refer to the [Supported Features](https://docs.adaptavist.com/sms/latest/scriptrunner-dev-and-deployment-tool/supported-features-and-limitations) for the current list of ScriptRunner Cloud features that the Dev & Deployment Tool works with
    

## Open the project in an IDE 

Open your IDE with Gradle and Groovy support. For an IDE, we recommend [IntelliJ IDEA](https://www.jetbrains.com/idea/download/?section=mac). The free Community Edition supports everything that you need to use this project.

## Optional: Use mapping variables

When migrating from Jira Data Center, scripts and configuration files contain hard-coded data center entity identifiers that have different values in Cloud, like custom field IDs, issue type IDs, user keys, etc. The Dev and Deployment Tool allows you to define IDs as variable names and refer to them in your scripts and yaml configuration, instead of using hardcoded values. 

For a detailed guide on the mapping file format, placeholder syntax, supported entity types, and how to deploy configurations with mapped IDs, see [MAPPING.md](https://bitbucket.org/adaptavistlabs/migration-example-project/src/main/MAPPING.md)

## Deploy scripts from an IDE

You can deploy scripts from an IDE in one of two ways:

-   From the command line, accessible by selecting **Terminal**:  
    ![](/sms/files/latest/448135912/484576486/1/1763498534000/IDE-terminal.png)
-   From the Gradle tool window, accessible by selecting **Gradle** (shaped like an elephant)**.** The deployment tasks will be in the **deployment** subfolder. You can double-click individual tasks to run them.  
      
    ![](/sms/files/latest/448135912/516718837/1/1772133892000/dev+and+deployment+gradle+intellij+tool+window.png)
-   You can also click the Execute a Gradle Task button, which opens the Gradle tasks. You can start typing to find the specific configuration you want to deploy:  
    ![](/sms/files/latest/448135912/516718838/1/1772133892000/execute+task+window.png)  
      
    

### Deploy scripts in bulk 

On Windows, use `./gradlew.bat`  to invoke the Gradle wrapper.

  

Feature to Deploy

Command

All extensions

```
./gradlew cloud:deploy-all
```

All listeners

```
./gradlew cloud:deploy-listener-all
```

All script fields

```
./gradlew cloud:deploy-scriptField-all
```

All jobs  
(including Escalation Services)

```
./gradlew cloud:deploy-job-all
```

All Behaviours

```
./gradlew cloud:deploy-behaviour-all
```

All workflows

```
./gradlew cloud:deploy-workflow-all
```

All script manager scripts

```
./gradlew cloud:deploy-script-manager-all
```

### Deploy individual scripts

You can deploy individual scripts by using the description for listeners or the name for script jobs and script fields.

You can run the following gradle commands to deploy specific scripts set up in the sample repository:

```
./gradlew "deploy-job-Create time logging issue"
./gradlew "deploy-scriptField-Date Difference"
./gradlew "deploy-listener-Add a definition of done checklist to an issue on creation"
./gradlew "deploy-workflow-Workflow with file scripts"
./gradlew deploy-behaviour-Test
./gradlew cloud:deploy-script-manager-acme-dev-ConsoleScript2.groovy
```

  
If there are errors in the YAML, the plugin will log any errors received. It will still try to create tasks for any good configurations it finds, so you may be able to continue work with partially correct configuration. Still, do try to correct any errors you see so that you can proceed with deployments for all of your configuration.
