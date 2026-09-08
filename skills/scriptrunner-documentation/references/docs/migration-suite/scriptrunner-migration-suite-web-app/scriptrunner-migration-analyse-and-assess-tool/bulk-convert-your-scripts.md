# Bulk Convert Your Scripts

- Platform: migration-suite
- Space: SMS
- Hierarchy: scriptrunner-migration-suite-web-app > scriptrunner-migration-analyse-and-assess-tool
- Doc ID: doc-sms-585009436
- Source: https://docs.adaptavist.com/sms/latest/scriptrunner-migration-suite-web-app/scriptrunner-migration-analyse-and-assess-tool/bulk-convert-your-scripts

On the main analysis page, you can convert multiple scripts to Cloud scripts at once. 

1.  Select **Analysis** in the main ScriptRunner Migration Suite navigation.
2.  Select **See details** on an analysis. 
3.  Select **Bulk Convert** from the main analysis page.  
    ![](/sms/files/latest/585009436/585009463/1/1787602705000/bulk-convert.png)
4.  Select the type of scripts you want to work with. _  
    As you select script types, the number of eligible items, configurations, and shared scripts totals for you.  
    _![](/sms/files/latest/585009436/585009464/1/1787602705000/bulk-convert-total.png)
5.  Select **Start Conversion**.  
    As the conversion runs (which could take quite a bit of time for large projects!), you'll see status updates:  
    ![](/sms/files/latest/585009436/585009465/1/1787602705000/conversion-progress.png)

## Reading your results

Once the conversion finishes running, you'll see your results screen:

![](/sms/files/latest/585009436/585009472/1/1787603254000/conversion-results.png)

You can hover over a cell to see the script name, status, and time it took to convert. 

![](/sms/files/latest/585009436/585009471/2/1787603388000/conversion-hover.png)

You can click that cell to see conversion details, including tasks that need to be completed. Here, you can ask the [ScriptRunner Migration Agent](https://docs.adaptavist.com/sms/latest/scriptrunner-migration-suite-web-app/scriptrunner-migration-agent) to make further changes to the scripts:

![](/sms/files/latest/585009436/585009473/1/1787603255000/converted-script-details.png)

Conversion history

Once you run conversions on an analysis, you can access the entire results by selecting the **Conversion history** button that appears on the main analysis page after you or another users has run a bulk conversion on your analysis:

![](/sms/files/latest/585009436/585009476/1/1787603916000/conversion-history-button.png)

Click on one of the date and times in the _Started_ column to access the full results.

![](/sms/files/latest/585009436/585009477/1/1787604026000/bulk-conversions-history.png)

## Now what?

### Dev and Deployment Tool

You can now export those converted scripts to the [ScriptRunner Dev and Deployment Tool](https://docs.adaptavist.com/sms/latest/scriptrunner-dev-and-deployment-tool) by using the **Export** button on the main analysis page.

![](/sms/files/latest/585009436/585009466/1/1787602705000/export.png)

Visit the [Use the Dev and Deployment Tool](https://docs.adaptavist.com/sms/latest/scriptrunner-dev-and-deployment-tool/use-the-dev-and-deployment-tool) documentation to learn about how to rewrite the converted scripts and then deploy them to a Cloud instance. Remember to use the results pages from the conversion to know what needs to be rewritten from your scripts and the Migration Agent to help you rewrite them.

### Conversion output

You can also see your data in the _Conversion output_ tab of the [Details](#id-.Bulkconvertyourscriptsv2.0-details) of a script in the analysis. Here, you can see your extension.yaml fragment and groovy script with conversion notes. 

![](/sms/files/latest/585009436/585009475/1/1787603643000/groovy-script.png)
