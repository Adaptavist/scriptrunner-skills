# Deprecation reports

- Platform: cloud
- Space: SR4JC
- Hierarchy: Release Notes > Deprecation Notices Overview
- Doc ID: doc-sr4jc-ddc7c99c-8c5d-49d1-95fb-16e3f788048f-2a49059a5e721555
- Source: https://docs.adaptavist.com/sr4jc/latest/release-notes/deprecation-notices-overview/deprecation-reports

You can view a report that runs every 24 hours and highlights any Atlassian deprecations in your instance. To view the report:

1.  Navigate to ScriptRunner > Deprecation Reports.
2.  Click Deprecation Reports in the left-hand menu of your ScriptRunner for Jira Cloud instance.
    
    You will see tabbed report types from which you can choose, including:
    
    -   REST Search Endpoints
    -   Epic/Parent Link Fields
    -   Missing Event Properties
    -   Response Body Links
    -   Missing Cascading Events
    
    The reports highlight ScriptRunner for Jira Cloud features that contain any Atlassian-deprecated endpoints, fields, or event types that have been detected in your instance. Each report highlights the deprecated script _Name_ and _UUID_. If there are workflow-related scripts, you will also see a _Workflow Name_ link. Similarly, if there are specific _Event types_ in the _Missing Event Properties_ report, you can open the corresponding links to see the details.
    
    When scripts in your instance match deprecated endpoints, fields, or event types, a red numerical indicator appears on the report tab. As shown in the example image above, the _Missing Cascading Events_ report has identified one event. Details are provided in the expanded area below, where we can see the related Script Listeners.
    
    Note:
    
    If no deprecated endpoints, fields, or event types are found, a message will appear in each report informing you of this.
    
3.  Optional: Click the links provided to go directly to the event types in this example. When using the other reports, you are linked directly to scripts that are highlighted.
    
    You can now modify these as required. Any items listed in the report will remain there until the related script is updated. For Missing Cascading Events, the listener stays listed until you remove the affected events from it.
    
4.  Optional: Click Download CSV to download a copy of the report.
