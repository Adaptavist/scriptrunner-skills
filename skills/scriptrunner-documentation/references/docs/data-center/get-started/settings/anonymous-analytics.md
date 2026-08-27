# Anonymous Analytics

- Platform: data-center
- Space: SR4JS
- Hierarchy: get-started > settings
- Doc ID: doc-sr4js-441364236
- Source: https://docs.adaptavist.com/sr4js/latest/get-started/settings/anonymous-analytics

_Anonymous Analytics_ is a setting in ScriptRunner that, when enabled, allows us to collect ScriptRunner usage data.

Data is sent to the following domain when _Anonymous Analytics_ is enabled:  
`https://product.telemetry.adaptavist.com/`

Please add the following IP addresses to your allowlist. Communication to these IP addresses is via https on port 443. 

-   44.233.157.216
-   54.190.84.90
-   35.84.96.253

## How we use the data

All data collected is for internal use only, allowing us to gain insight into ScriptRunner usage. All the data we collect is anonymous, and none of the data collected is Personally Identifiable Information (PII). We use this information to help us improve user experience, prioritise workload, and ensure we are bringing value to our users. For example, we collect the following: 

-   Platform version
-   Plugin version
-   SEN
-   Usage data (such as the execution of Built-in Scripts, the type of events for which Listeners are executed).

See our [EULA](https://www.adaptavist.com/company/adaptavist-eula/) for more information.

## How to enable/disable anonymous analytics

_Anonymous Analytics_ is enabled by default (if Atlassian analytics is enabled).

To enable or disable _Anonymous Analytics_ follow the steps below:

1.  From ScriptRunner, select **Settings**.  
    ![Image of Settings options](/sr4js/files/latest/441364236/441364238/1/1737458940000/Settings_options.png)
    
2.  Select the **Instance Settings** tab.
3.  Toggle _Anonymous Analytics_ on/off.  
    ![Image of the ScriptRunner Settings screen](/sr4js/files/latest/441364236/441364239/1/1737458940000/Scriptrunner_for_Jira_anonymous_analytics.png)
    
    If Atlassian analytics is disabled, then _Anonymous Analytics_ is also disabled and the toggle is greyed out. To check if Atlassian analytics is enabled, select **System** from the administration menu, and select **Analytics** under _Advanced_ in the sidebar.
