# Bulk Convert Your Scripts

- Platform: migration-suite
- Space: SMS
- Hierarchy: ScriptRunner Migration Suite Web App > ScriptRunner Migration Analyse and Assess Tool
- Doc ID: doc-sms-ab1d39bf-fa75-4a8b-b7c7-a3ff92076fb5-293406f2b53b7c97
- Source: https://docs.adaptavist.com/sms/latest/scriptrunner-migration-suite-web-app/scriptrunner-migration-analyse-and-assess-tool/bulk-convert-your-scripts

On the main analysis page, you can convert multiple scripts to Cloud scripts at once.

Note: This part of the Analyse and Assess Tool does use AI because the [ScriptRunner Migration Agent](../script-runner-migration-agent.md) is used for conversion.

1.  Select Analysis in the main ScriptRunner Migration Suite navigation.
2.  Select See details on an analysis.
3.  Select Bulk Convert from the main analysis page.
    
4.  Select the type of scripts you want to work with.
    
    _As you select script types, the number of eligible items, configurations, and shared scripts totals for you._
    
5.  Select Start Conversion.
    
    As the conversion runs (which could take quite a bit of time for large projects!), you'll see status updates as it runs.
    

## Reading your results

When you start the conversion, you'll see your results screen. The first part is the Overall progress, including the conversion status and details about the converesion run.

Next you see a Run summary, which breaks down your configuration types and how many were sucessfully converted.

The final section, is the Item section.  

  

You can select cells to see conversion details, including tasks that need to be completed, which will take you to the configuration:  
  

You can ask the [ScriptRunner Migration Agent](../script-runner-migration-agent.md) to make further changes to the scripts:

Tip: Conversion history

Once you run conversions on an analysis, you can access the entire results by selecting the Conversion history button that appears on the main analysis page after you or another user has run a bulk conversion on your analysis:

Select one of the date and times in the _Started_ column to access the full results.

## Now what?

### Dev and Deployment Tool

You can now export those converted scripts to the [ScriptRunner Dev and Deployment Tool](../../uncategorized/s/script-runner-dev-and-deployment-tool.md) by using the Export button on the main analysis page.

Visit the [Use the Dev and Deployment Tool](../../uncategorized/s/script-runner-dev-and-deployment-tool.md) documentation to learn about how to rewrite the converted scripts and then deploy them to a Cloud instance. Remember to use the results pages from the conversion to know what needs to be rewritten from your scripts and the Migration Agent to help you rewrite them.

### Conversion output

You can also see your data in the Conversion output tab of the [Details](https://docs.adaptavist.com/sms/latest/scriptrunner-migration-suite-web-app/scriptrunner-migration-analyse-and-assess-tool/use-the-analyse-and-assess-tool#details--en) of a script in the analysis. Here, you can see your extension.yaml fragment and groovy script with conversion notes.
