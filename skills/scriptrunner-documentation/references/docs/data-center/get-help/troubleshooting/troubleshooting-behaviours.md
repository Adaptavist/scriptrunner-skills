# Troubleshooting Behaviours

- Platform: data-center
- Space: SR4JS
- Hierarchy: get-help > troubleshooting
- Doc ID: doc-sr4js-442887066
- Source: https://docs.adaptavist.com/sr4js/latest/get-help/troubleshooting/troubleshooting-behaviours

## Cannot Add Behaviours

The _Behaviours_ page in ScriptRunner is failing to load information, blocking you from adding behaviours to your Jira instance. Try the steps below before contacting ScriptRunner support.

### Behaviours module disabled

One cause of this issue may be that the behaviours module has been disabled. Follow the steps below to check.

1.  From the _Administration_ page, navigate to **Manage Apps** under _Atlassian Marketplace_.
    
2.  Locate ScriptRunner and expand the section.
    
3.  Click **XXX of XXX modules enabled**.
    
    ![Image of location of modules](/sr4js/files/latest/442887066/442887073/1/1758746774000/Behaviour_modules.png)
4.  From the modules list, find **Behaviour admin assets (bh-admin)** and check if disabled (greyed out with _Disabled_ in red).
    
    ![](/sr4js/files/latest/442887066/442887070/1/1758746774000/Troubleshooting-behaviour-admin-assets.png)
5.  If disabled, click **Enable**.
    

### Customized HTML banner containing JavaScript 

Many Jira Data Center administrators add custom HTML banners to their pages (as described in [Atlassian's Documentation](https://confluence.atlassian.com/adminjiraserver/configuring-an-announcement-banner-938846985.html)). While this is generally fine for basic HTML, some administrators will use this banner to include custom JavaScript for various purposes, such as:

-   Adding page tracking for monitoring tools (for example [New Relic's](https://docs.newrelic.com/docs/browser/browser-monitoring/installation/install-browser-monitoring-agent/) browser agent)
-   Adding custom interactivity to an announcement banner

These customizations usually work well with ScriptRunner. However, they can break ScriptRunner Behaviours if not carefully implemented.

#### Troubleshooting

If you experience issues with ScriptRunner Behaviours, check your browser's _Developer Tools Console Log_ (see [documentation for Chrome](https://support.google.com/docs/thread/1873663/collecting-console-logs-chrome-browser-only?hl=en), [Firefox](https://firefox-source-docs.mozilla.org/devtools-user/browser_console/index.html), [Edge](https://learn.microsoft.com/en-us/azure/azure-portal/capture-browser-trace#microsoft-edge) for details on how to do this).

There may be some telltale signs that an odd bit of JavaScript is breaking Behaviours. If you see one of the following errors, it may be caused by a customized HTML banner containing JavaScript:

```
TypeError: $ is not a function
```

```
Uncaught ReferenceError: jQuery is not defined
```

These errors cause the same issue with post-functions, validators and conditions.

#### Solution

1.  Navigate to the HTML banner.
2.  Eliminate any custom JavaScript from your banner.
    
    This may remove some added functionality, but it is an important troubleshooting step.
    
3.  Clear your browser cache and reload a Jira issue to test whether your Behaviours work as expected.
4.  If your Behaviours work as expected you will need to troubleshoot the JavaScript in your custom HTML banner. We recommend you try the following:
    
    While providing detailed instructions for this process is beyond the scope of this documentation, we can offer some general tips that have proven helpful for other customers in similar situations. The effectiveness of these solutions may vary depending on your specific circumstances. 
    
    -   Locate the following and remove it from the HTML file (either by deleting or commenting out).
        
        ```
jQuery.noConflict( );
```
        
        For more information on why this line causes errors see this [explanation of jQuery.noConflict()](https://api.jquery.com/jquery.noconflict/).
        
    -   If your custom JavaScript was provided by a third party application, such as [New Relic's](https://docs.newrelic.com/docs/browser/browser-monitoring/installation/install-browser-monitoring-agent/) browser monitoring agent, try re-generating the code from that application.

## Custom HTML/JavaScript in custom field descriptions no longer work in Jira 8.7

### Problem

You have recently upgraded to Jira 8.7, and behaviours that set custom field description values are not working correctly on custom fields, or you're seeing raw code in the field's description.

### Solution

Jira 8.7 automatically disables the feature labelled as **"Enable HTML in custom field descriptions and list item values".** If your custom HTML or JavaScript just shows as text, where your fields description should show, and your custom code is not being executed, you must re-enable that feature. Alternatively, you can load your custom JavaScript in a different way, for example, using our [web resources](https://docs.adaptavist.com/sr4js/latest/features/fragments/web-resource) feature.

Atlassian bug reference: [JRASERVER-38866](https://jira.atlassian.com/browse/JRASERVER-38866?src=confmacro)

The bug is referenced in the [release notes for Jira 8.7](https://confluence.atlassian.com/jirasoftware/jira-software-8-7-x-release-notes-990550432.html).

  

* * *

## Related content

-   [Get Help with Behaviours](https://docs.adaptavist.com/sr4js/latest/get-help/get-help-with-behaviours)
-   [Behaviours FAQs](https://docs.adaptavist.com/sr4js/latest/get-help/frequently-asked-questions/behaviours-faqs)
-   [Behaviours Supported Fields](https://docs.adaptavist.com/sr4js/latest/features/behaviours/behaviours-supported-fields)
