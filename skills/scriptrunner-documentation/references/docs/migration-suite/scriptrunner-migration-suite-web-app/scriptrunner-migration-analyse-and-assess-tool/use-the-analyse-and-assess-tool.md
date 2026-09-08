# Use the Analyse and Assess Tool

- Platform: migration-suite
- Space: SMS
- Hierarchy: scriptrunner-migration-suite-web-app > scriptrunner-migration-analyse-and-assess-tool
- Doc ID: doc-sms-550633803
- Source: https://docs.adaptavist.com/sms/latest/scriptrunner-migration-suite-web-app/scriptrunner-migration-analyse-and-assess-tool/use-the-analyse-and-assess-tool

Check out the following sections to learn how to analyse an export of a Jira instance:

## Upload an export to analyse and assess

Follow these steps to start using the Analyse and Assess tool: 

1.  Create or get a script export from the Jira instance with ScriptRunner you want to work with.
    
    See the [Script Registry export from ScriptRunner for Jira Data Center](https://docs.adaptavist.com/sr4js/latest/features/script-registry#exporting-your-scripts) documentation for details on how to create a script export.
    
2.  Open the ScriptRunner Migration Suite, and log in with your Atlassian ID or email.
    
3.  Navigate to the Analyse and Assess tool using the tile or **Analyse** on the left-hand menu:  
    ![](/sms/files/latest/550633803/585009421/1/1787598871000/analysis-nav.png)
    
4.  Enter an **Instance Name** for the export.
    
5.  Select a **Project**.  
    
    Create a new project
    
    If you want to create a new project,
    
    1.  Select **Projects** on the left-hand navigation. 
    2.  Select **Create Project**.   
        ![](/sms/files/latest/550633803/550633797/1/1779483522000/create-project.png)
    3.  Enter a **Project Name**. 
    4.  Select the **Visibility** of the project.  
        You can choose to _Share with organization_ or _Only me_.
    5.  Select **Create Project**.
    
6.  Drag and drop or upload your script export zip file to the **File** field.
    
7.  Select **Analyse**.
    

Your export uploads to the list. When it is finished, the **Status** changes to _Completed_. 

![](/sms/files/latest/550633803/550633798/2/1779483522000/upload.png)

## Understand your results

Select See details on your analysis to view your results. These definitions will be helpful: 

-   **Info**: Information that may be helpful to you in your migration.
-   **Ready to Migrate**: These configurations are ready for migration. They may include informational messages about possible cloud limitations, but the configuration is otherwise complete. A rewrite will still be required, but all necessary components exist in ScriptRunner Cloud.
-   **Review Recommended**: These are configurations with warnings that might not be blockers, but they do signal areas requiring script adjustments, testing, or acceptance of functional limitations in the Cloud environment.
-   **Critical Findings**: These are configurations with at least one critical blocker. The next step is to decide whether the configuration needs to be migrated to Cloud, can be migrated, or replicated differently. Blockers occur when:
    
    -   The feature is not supported in Cloud.
        
    -   Scripts rely on Java APIs or server-side features missing from Cloud's REST API-only architecture, requiring complete rewrites.
        
    -   Integrations require direct database or file system access, which cannot be migrated and need alternative solutions or may block migration.
        

When your results are ready and the _Overview_ tab is selected, you will see the _Migration Readiness_ and _Feature Breakdown_ sections.

![](/sms/files/latest/550633803/585009423/1/1787599966000/results-1.png)

For more information about the Export and Bulk Convert features, visit [Bulk Convert Your Scripts](https://docs.adaptavist.com/sms/latest/scriptrunner-migration-suite-web-app/scriptrunner-migration-analyse-and-assess-tool/bulk-convert-your-scripts).

### Migration readiness

The following sections help you analyse your entire export as a whole:

-   _Overall Progress_: progress bar to show how many configurations are ready for migration.
-   _Script Breakdown_: Shows how many scripts are unique and duplicated.
-   _Critical Findings_: Shows how many critical findings you have.

## Feature breakdown

The second section you'll see on the _Overview_ tab is the _Feature Breakdown_: 

![](/sms/files/latest/550633803/585009424/1/1787599989000/results-2.png)

You can select one of the feature categories from **See details** to see more information. Once you select a feature, you'll see information focused on the migration readiness of that specific feature. 

![](/sms/files/latest/550633803/566298753/1/1784147236000/listeners.png)

You'll still see the same progress bar with the status of scripts.

Then, for each configuration, you'll see the number of _Observations_, _Critical_ findings, _Review_ items, and a _Status._ To see more information, select **See details**.

## Details

Each script overview shows the number of information messages, things to review, and critical findings.

![](/sms/files/latest/550633803/585009425/1/1787600267000/detailed-script-page.png)

It also includes the following tabs:

-   **Analysis findings**: Lists all messages for the configuration, along with next steps and more information.
-   **Configuration**: An overview of the selected configuration.
    
-   **Script analysis**: If applicable, it shows an inline review of the script for the selected configuration, displaying info, warning, and blocker messages.
    
-   **Conversion output**: This is where your conversion data is stored. Descriptor fragments and files are stored here.

These findings are tagged with an _Info_, _Review_, and _Critical_. 

-   _Info_: Helpful information for your migration.
-   _Review_: These are configurations with warnings that might not be blockers, but they do signal areas requiring script adjustments, testing, or acceptance of functional limitations in the Cloud environment.
-   _Critical_: These are configurations with at least one critical blocker.

  

On the _Analysis Findings_ tab of the configuration, you'll have options for next steps:

-   **Explain this configuration**: Select this for a detailed explanation of the script.
-   **Convert this configuration**: If applicable, you can select **Convert this configuration** to attempt to convert the Data Center script to a Cloud script.

Selecting **Explain the configuration** or **Convert this configuration** moves you into the [ScriptRunner Migration Agent](https://docs.adaptavist.com/sms/latest/scriptrunner-migration-suite-web-app/scriptrunner-migration-agent).

## Export your results

Use the **Export** button on the main analysis page to export your scripts to a PDF report or the [Dev and Deployment Tool](https://docs.adaptavist.com/sms/latest/scriptrunner-dev-and-deployment-tool).

![](/sms/files/latest/550633803/585009426/2/1787604489000/export.png)
