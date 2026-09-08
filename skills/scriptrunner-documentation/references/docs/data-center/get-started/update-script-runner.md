# Update ScriptRunner

- Platform: data-center
- Space: SR4JS
- Hierarchy: get-started
- Doc ID: doc-sr4js-441364171
- Source: https://docs.adaptavist.com/sr4js/latest/get-started/update-scriptrunner

There are two ways to update ScriptRunner for Jira—on the Atlassian marketplace or from within your Jira instance. This page provides update instructions and recommendations for both minor and major version updates.

Recommendations for updating ScriptRunner 

The update process varies depending on whether you're performing a minor or major version update.

### Minor version update

For minor updates (for example, from version 9.3.0 to 9.5.0), you can typically update ScriptRunner without any significant issues. However, we always recommend you check out our latest [Release Notes](https://docs.adaptavist.com/sr4js/latest/release-notes) before updating. You can update ScriptRunner as described in [Updating ScriptRunner in your Jira instance](#id-.UpgradeScriptRunnerv9.x-update) below.

### Major version update

When updating to a new major version of ScriptRunner (for example, from version 8.x.x to 9.x.x) or updating both ScriptRunner and Jira simultaneously, more preparation is required. In these cases, we recommend that you look at the [Compatibility with Jira](https://docs.adaptavist.com/sr4js/latest/get-started/update-scriptrunner/compatibility-with-jira) page. On this page, you can find:

-   ScriptRunner compatibility with major Jira versions
-   Details of breaking changes
-   Recommended upgrade strategies

If you do not have a staging environment, we recommend you invest the time into creating one. You should be able to reliably clone your production instance to the staging environment, so you can test plugins and upgrades.

## Updating ScriptRunner on the Atlassian marketplace

To upgrade ScriptRunner for Jira, navigate to [Version history](https://marketplace.atlassian.com/apps/6820/scriptrunner-for-jira/version-history). From there, you can select a version to **Download**. 

![Image of version history screen](/sr4js/files/latest/441364171/441364178/1/1736512598000/Update_scriptrunner_on_marketplace.png)

You can also click **Watch** in the upper right-hand corner to be notified when new versions are released. 

## Updating ScriptRunner in your Jira instance

We recommend performing upgrades during a maintenance window. Update Jira as follows:

1.  Navigate to **Administration** \> **Manage apps**
2.  Select **Update**.
3.  Once complete, **restart Jira** to ensure ScriptRunner is fully enabled. On Data Center, restart nodes one at a time, letting each rejoin the cluster before restarting the next.

The Manage apps screen may appear unresponsive during an update

When you update, enabling ScriptRunner can take several minutes while it recompiles scripts and re-registers workflow functions, listeners, and REST endpoints. During this time the Manage apps screen may appear unresponsive or return errors. This is expected. Allow it to complete rather than reloading the page or stopping the process.

![Image of manage apps screen](/sr4js/files/latest/441364171/441364177/1/1736512598000/Manage_apps_screen.png)

### Atlassian Universal Plugin Manager

When you update ScriptRunner in your Jira instance you're doing so through the [Universal Plugin Manager](https://confluence.atlassian.com/upm/universal-plugin-manager-documentation-273875696.html) (UPM). UPM typically comes pre-installed in recent versions of all Atlassian applications. With UPM, in addition to updating ScriptRunner, you can also do the following:

-   View app information including the installed version of the app and the available version of the app.
    
-   Review information about ScriptRunner for Jira including pricing details, data security, privacy information, and documentation.
    
-   Enable and disable modules for apps.
    
    -   A module is a piece of an app that allows you to expand Jira functionality. It is basically a chunk of code that lets you extend different parts of Jira in different ways.
        
    -   You can’t disable all modules; some are required for ScriptRunner to function.
        
    -   Script JQL functions run as modules here, so if you need to add or remove a Script JQL function, you do that here.
        

For each app listed in the UPM, you can also see release notes for recent updates.

  

* * *

## Related content

-   [Upgrade FAQs](https://docs.adaptavist.com/sr4js/latest/get-help/frequently-asked-questions/upgrade-faqs)
-   [Installation](https://docs.adaptavist.com/sr4js/latest/get-started/installation)
-   [Navigation](https://docs.adaptavist.com/sr4js/latest/get-started/navigation)
