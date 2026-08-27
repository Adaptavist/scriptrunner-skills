# Use the Analyse and Assess Tool

- Platform: migration-suite
- Space: SMS
- Hierarchy: scriptrunner-migration-suite-web-app > scriptrunner-migration-analyse-and-assess-tool
- Doc ID: doc-sms-448135870
- Source: https://docs.adaptavist.com/sms/latest/scriptrunner-migration-suite-web-app/scriptrunner-migration-analyse-and-assess-tool/use-the-analyse-and-assess-tool

Check out the following sections to learn how to analyse an export of a Jira instance:

## Upload an export to assess and analyse

Follow these steps to start using the Assess and Analyse tool: 

1.  Create or get a script export from the Jira instance with ScriptRunner you want to work with.
    
    See the [Script Registry export from ScriptRunner for Jira Data Center](https://docs.adaptavist.com/sr4js/latest/features/script-registry#exporting-your-scripts) documentation for details on how to create a script export.
    
2.  Open the [ScriptRunner Migration Suite](https://migrationpilot.scriptrunnerhq.com/analyse "https://migrationpilot.scriptrunnerhq.com/analyse"), and log in with your Atlassian ID or email.
    
3.  Navigate to the Assess and Analyse tool using the toggle or a tile.
    
4.  Enter a name for **Name this analysis**.
    
5.  Drag and drop or upload your script export zip file to the analyser.
    
6.  Select **Upload and Analyse**.
    

How you use the results depends on your processes. You can find guidance in the section below and recommendations on the [Best Practices](https://docs.adaptavist.com/sms/latest/scriptrunner-migration-suite-web-app/scriptrunner-migration-analyse-and-assess-tool/best-practices) page.

## Understand your results

As you view your results, these definitions will be helpful: 

-   **Observations**: Information that may be helpful to you in your migration.
-   **Ready to Migrate**: These configurations are ready for migration. They may include informational messages about possible cloud limitations, but the configuration is otherwise complete. A rewrite will still be required, but all necessary components exist in ScriptRunner Cloud.
-   **Review Recommended**: These are configurations with warnings that might not be blockers, but they do signal areas requiring script adjustments, testing, or acceptance of functional limitations in the Cloud environment.
-   **Critical Findings**: These are configurations with at least one critical blocker. The next step is to decide whether the configuration needs to be migrated to Cloud, can be migrated, or replicated differently. Blockers occur when:
    
    -   The feature is not supported in Cloud.
        
    -   Scripts rely on Java APIs or server-side features missing from Cloud's REST API-only architecture, requiring complete rewrites.
        
    -   Integrations require direct database or file system access, which cannot be migrated and need alternative solutions or may block migration.
        

When your results are ready and the _Overview_ tab is selected, you will see the _Migration Readiness_ and _Feature Breakdown_ sections.

![](/sms/files/latest/448135870/537854775/1/1776702632000/analysis-overview.png)

### Migration Readiness

The following sections help you analyse your entire export as a whole:

-   _Overall Progress_: progress bar to show how many configurations are ready for migration.
-   _Script Breakdown_: Shows how many scripts are unique and duplicated.
-   _Critical Findings_: Shows how many critical findings you have.

### Feature Breakdown

The second section you'll see on the _Overview_ tab is the _Feature Breakdown_: 

![](/sms/files/latest/448135870/484576984/1/1765831183000/sms-assess-2.png)

You can select one of the feature categories from the tile or the left navigation to see more information. Once you select a feature, you'll see information focused on the migration readiness of that specific feature. 

![](/sms/files/latest/448135870/484576398/1/1765484584000/features-breakdown.png)

You'll still see the same progress bar with the status of scripts.

Then, for each configuration, you'll see where it is _Applied To_, and the number of _Observations_, _Critical_ findings, _Review_ items, and a _Status._ To see more information, select **See Details**.

### Script Breakdown

Select **Script Breakdown** in the left navigation to see data for all scripts.

![](/sms/files/latest/448135870/484576397/1/1765484785000/script-breakdown.png)

From here, you can see the _Script_, _Usages_, _Findings_ status, and _Duplication_ status of every script in your export. Click **View Script** to see where each script is used: 

![](/sms/files/latest/448135870/484576402/1/1764796240000/script-usage.png)

Click the links to see the analysis of the script.

## Export as PDF report

Select **Export as PDF Report** to get your assessment results in a PDF. You can access this feature on the _Overview_ page of the Assess and Analyse tool: 

![](/sms/files/latest/448135870/537854774/1/1776702632000/export-as-pdf.png)

The PDF includes your: 

-   _Your Cloud migration readiness assessment_ 
-   _Executive summary_, including main risks and script conversion tips
-   _Feature breakdown_, with quick wins and needs attention
-   _Findings_ that need redesigning and adapting
-   _Your Groovy codebase_ details, including script complexity and API conversion
-   Feature analysis, like _Behaviour details_ 
-   _Suggested approach_ for recommendations on a migration path
-   _Decisions to make_ before you start your migration 

For example, this is what the _Executive summary_ looks like in the PDF: 

![](/sms/files/latest/448135870/537854773/1/1776702631000/executive+summary.png)

This PDF can be shared with stakeholders that do not have access to ScriptRunner Migration Suite to aid in your migration. 

## Take next steps

Each script overview shows the number of information messages, things to review, and critical findings.

![](/sms/files/latest/448135870/477865299/1/1766092705000/no-robot.png)

It also includes the following tabs:

-   **Analysis Findings**: Lists all messages for the configuration, along with next steps and more information.
-   **Configuration**: An overview of the selected configuration.
    
-   **Script Analysis**: If applicable, it shows an inline review of the script for the selected configuration, displaying info, warning, and blocker messages.
    

On the _Analysis Findings_ tab of the configuration, you'll have options for next steps:

-   **Explain this configuration**: Select this for a detailed explanation of the script.
-   **Convert this configuration**: If applicable, you can select **Convert this configuration** to attempt to convert the Data Center script to a Cloud script.

Selecting **Explain the configuration** or **Convert this configuration** moves you into the [ScriptRunner Migration Agent](https://docs.adaptavist.com/sms/latest/scriptrunner-migration-suite-web-app/scriptrunner-migration-agent).

## Work with other exports

You can add more than one export to the tool. To add more or move between exports, follow these instructions:

### Analyse another zip file

To analyse a different zip file, select **New analysis** on the left of the screen: 

![](/sms/files/latest/448135870/454395288/1/1761771777000/new-analysis.png)

### Retrieve previous results

Results from analysing a zip file are stored in your browser. You can view previous results in the panel on the left: 

![](/sms/files/latest/448135870/458653776/1/1761880187000/old-export.png)

This tool only stores results in the browser. If you log in elsewhere, you must reupload your data. Additionally, the data is stored per user. If another member of your team logs in, they will not be able to see your old exports. They will also have to upload.
