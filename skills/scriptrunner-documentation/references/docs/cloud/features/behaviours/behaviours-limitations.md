# Behaviours Limitations

- Platform: cloud
- Space: SR4JC
- Hierarchy: features > behaviours
- Doc ID: doc-sr4jc-355468353
- Source: https://docs.adaptavist.com/sr4jc/latest/features/behaviours/behaviours-limitations

Atlassian created an API called [UI Modifications](https://developer.atlassian.com/platform/forge/custom-ui-jira-bridge/uiModifications/) on the Forge platform, which made it possible for ScriptRunner to build Behaviours. ScriptRunner for Jira Cloud Behaviours relies upon Atlassian's UI Modifications REST API. We register UI Modifications for each ScriptRunner Behaviour; however, there are certain limitations set by Atlassian, including:

-   The number of UI Modifications (Behaviours) an app can register:  
    Currently, this limit is set at 3000.
    
-   The number of contexts each UI Modification can have:  
    This limit is set at 1000. By context, we mean space x work type x view.
    
-   The number of characters in each Behaviour script:  
    ScriptRunner can store up to 50,000 characters in scripts associated with a Behaviour. This includes the sum of all characters in all scripts in a single behaviour after compiling from TypeScript to JavaScript, plus our metadata. For more information, see the data in the POST request in [Atlassian's documentation](https://developer.atlassian.com/cloud/jira/platform/rest/v3/api-group-ui-modifications--apps-/#api-rest-api-3-uimodifications-post).
    

You can find further information in [Atlassian's UI Modifications](https://developer.atlassian.com/platform/forge/apis-reference/jira-api-bridge/uiModifications/#uimodifications) guide and [Jira Cloud platform REST API](https://developer.atlassian.com/cloud/jira/platform/rest/v3/api-group-ui-modifications--apps-/#api-rest-api-3-uimodifications-post).

Some other points worth noting about Behaviour scripts: 

-   The language used when writing the logic for Behaviour scripts is **JavaScript** and not Groovy. You can refer to our [scripting](https://docs.adaptavist.com/sr4jc/latest/get-started/scripting-in-scriptrunner-for-jira-cloud) information for more details.
-   Complex scripts may affect the speed at which your Behaviours run and may be slower than simple or efficient scripts.
-   You can apply Behaviours to the Create, Issue, and Transition views (Create, View/Edit, Transition view types) of a Jira work item. For details, refer to [Behaviours Supported Fields and Products](https://docs.adaptavist.com/sr4jc/latest/features/behaviours/behaviours-supported-fields-and-products).
-   JSM is currently supported in Portal view only. Due to an Atlassian limitation, Agent view is not supported at this time but will be available soon.
-   Behaviours may be applied to certain supported fields only. Not all fields are currently supported in all available views. Refer to our [documentation](https://docs.adaptavist.com/sr4jc/latest/features/behaviours#behaviours-supported-fields-and-products) to discover which fields are supported on each supported view.
-   Both company-managed and team-managed Jira spaces support Behaviours; however, business spaces (a subset of team-managed or JWM spaces) support the Global Issue Create (GIC) or Create view type **only**. Refer to [Behaviours Supported Fields and Products](https://docs.adaptavist.com/sr4jc/latest/features/behaviours/behaviours-supported-fields-and-products) for details.
-   You cannot select all spaces and all work types simultaneously.
-   In Behaviours, some Jira-native system fields can be custom field types. An example of this is the **Labels** field, which is a Jira-native system field. Only Jira-native system fields are supported, so your Behaviours may not function correctly if you have created a custom field of _type_ **Labels**.
    

As more capabilities become available in the UI Modifications API, more functionality can be built in ScriptRunner's Behaviours feature. We are actively enhancing this feature by integrating new capabilities as Atlassian releases them. 

* * *

## Related content

-   If you are migrating from DC/Server to Cloud, take a look at our [Feature Parity and Script Alternatives](https://docs.adaptavist.com/sr4jc/latest/scriptrunner-migration-to-cloud/feature-parity-and-script-alternatives).
