# Get Help with Behaviours

- Platform: data-center
- Space: SR4JS
- Hierarchy: get-help
- Doc ID: doc-sr4js-574522539
- Source: https://docs.adaptavist.com/sr4js/latest/get-help/get-help-with-behaviours

If you have any problems, please include the following information in your bug report to [Adaptavist Support](https://the-adaptavist-group-support.atlassian.net/servicedesk/customer/portal/21):

1.  **Support Zip** \- For information on how to create a support zip see the Atlassian [Create a Support Zip](https://confluence.atlassian.com/support/create-a-support-zip-790796819.html) documentation.
    
    For instructions on how to set logging for Behaviours, see our [Log Levels](https://docs.adaptavist.com/sr4js/latest/best-practices/logging/advanced-logging#id-.AdvancedLoggingv9.x-loglevels) documentation.
    
2.  **XML Snippet** \- For the problematic behaviour, follow the XML Storage instructions below.
    
3.  **Custom Field Type Details** \- Description of any custom field types involved, eg their type.
    

## Disable/Enable Features

If you are having issues with a specific feature of ScriptRunner, we suggest disabling all ScriptRunner scripts for that feature and re-enabling one-by-one to identify the source of the problem. For example, to troubleshoot behaviours:

1.  Navigate to **Behaviours**.
    
2.  Click the **Cog** drop-down under _Operations_.
    
3.  Select **Disable** from the list.
    
4.  Repeat this for all configured behaviours.
    
5.  Re-enable behaviours one-by-one and test.
    

## XML Storage

If Adaptavist Support requests the XML text for your behaviour, please follow the below instructions.

### 6.0+

1.  Navigate to **ScriptRunner → Behaviours**.
    
2.  Click **Edit** next to the affected behaviour.
    
    ![](/sr4js/files/latest/574522539/574522538/1/1785331742000/edit-behaviours.png)
3.  Copy the behaviour ID from the URL; this is the last number in the URL. For example, for the behaviour with the following URL, the ID is `1`:
    
    ```
<JiraBaseURL>/plugins/servlet/scriptrunner/admin/behaviours/edit/1
```
    
      
    
4.  Open a new browser tab, and enter the following REST API call, where `<behaviourID>` is the ID from the behaviour URL:
    
    ```
<JiraBaseURL>/rest/scriptrunner/behaviours/latest/config/<behaviourID>
```
    
    For example:  
    
    ```
jira.example.com/rest/scriptrunner/behaviours/latest/config/1
```
    
    ```
The behaviours XML is displayed:
```
    
    ![](/sr4js/files/latest/574522539/574522537/1/1785331742000/behaviours-xml.png)
5.  Copy the text and send it to Adaptavist Support.
    

### 5.x

1.  Navigate to **ScriptRunner>Behaviours**.
    
2.  Click **Advanced Edit** next to the affected behaviour.
    
3.  Copy the full XML snippet and send it to Adaptavist Support.
    

  

* * *

## Related content

-   [Troubleshooting Behaviours](https://docs.adaptavist.com/sr4js/latest/get-help/troubleshooting/troubleshooting-behaviours)
-   [Behaviours FAQs](https://docs.adaptavist.com/sr4js/latest/get-help/frequently-asked-questions/behaviours-faqs)
-   [Behaviours Supported Fields](https://docs.adaptavist.com/sr4js/latest/features/behaviours/behaviours-supported-fields)
