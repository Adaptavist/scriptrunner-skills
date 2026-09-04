# Migrating Behaviours

- Platform: data-center
- Space: SR4JS
- Hierarchy: features > behaviours
- Doc ID: doc-sr4js-442888379
- Source: https://docs.adaptavist.com/sr4js/latest/features/behaviours/migrating-behaviours

You may want to migrate behaviours from one Jira instance to another. ScriptRunner has native integration with [Configuration Manager for Jira](https://docs.adaptavist.com/x/nRTtCQ), which can migrate Behaviours between instances with compatible versions of ScriptRunner.

If you need a manual means of migrating behaviours, there are some HTTP APIs that help with migrating the configuration.

Below we explain the process of migrating Behaviours using the HTTP API. Take care when following these instructions. We recommend trying out any migration steps in a test instance first.

1.  Enter this URL into your browser address bar to provide the mapping between behaviours and projects/issue types:  
    `<JiraBaseURL>/rest/scriptrunner/behaviours/latest/config`
    
    ```
<Behaviours>
    <project pid="10001" configuration="26a15255-ddc9-4575-ad4f-d3efae9199d8"/>
    <project pid="10003">
        <issuetype id="10004" configuration="f362ac19-ffe6-47d3-9e00-458ae57b1b05"/>
        <issuetype id="10000" configuration="f362ac19-ffe6-47d3-9e00-458ae57b1b05"/>
    </project>
</Behaviours>
```
    
    Each configuration ID above (`26a15255-ddc9-4575-ad4f-d3efae9199d8` & f362ac19-ffe6-47d3-9e00-458ae57b1b05) is a single behaviour
    
2.  Paste the following URL into your browser address bar to return the configuration of a behaviour, where f362ac19-ffe6-47d3-9e00-458ae57b1b05 is the ID of one of the behaviours above:
    
    The configuration of your behaviour may display without any line breaks. You can view the configuration with line breaks if you view your browser's page source.
    
    If the configuration is migrated without line breaks then it may throw a compilation error. 
    
    `<JiraBaseURL>/rest/scriptrunner/behaviours/latest/config/f362ac19-ffe6-47d3-9e00-458ae57b1b05`
    
    The configuration of behaviour f362ac19-ffe6-47d3-9e00-458ae57b1b05 is shown:
    
    ```
<config use-validator-plugin="false" validate-jira-requiredness="false" name="test">
    <field id="customfield_10011" readonly="true"/>
    <field
        id="customfield_10013" validator-method="" validator-class="" validator="server"
        validator-script=" getFieldByName("TextFieldB").setFormValue("Hello World") "/>
    <field id="customfield_10014" required="true"/>
</config>
```
    
    As you can see, custom fields are identified by their ID (for example, `customfield_10011`). If you are migrating this to another system, check the XML and manually update any custom field IDs that don’t match the new system. If you are editing a behaviour, make changes directly to this XML in a text editor.
    
    If your development environment is a copy of your production environment, or you are just editing a behaviour, the IDs should match and do not need changing.
    
    Project and issue types are also represented by IDs and might need updating before migration.
    
3.  Once the XML is updated, post it to your production instance, using:
    
    ```
curl  -X POST -u admin:admin --header "X-Atlassian-Token:no-check" --header "Content-Type:application/xml" --data-binary @behaviour_26a15255-ddc9-4575-ad4f-d3efae9199d8.xml <jira-base-url>/rest/scriptrunner/behaviours/latest/config/26a15255-ddc9-4575-ad4f-d3efae9199d8
```
    
    Where behaviour\_26a15255-ddc9-4575-ad4f-d3efae9199d8.xml, obtained from step 2, is a file with the contents of the behaviour configuration, and `admin:admin` is an admin username and password.
    
    If a behaviour already exists with this ID, the command above overwrites it.
    
4.  Once you have recreated any behaviours, you can write the mappings to the production server:
    
    ```
curl  -X POST -u admin:admin --header "X-Atlassian-Token:no-check" --header "Content-Type:application/xml" --data-binary @bh.xml <jira-base-url>/rest/scriptrunner/behaviours/latest/config
```
    
    Where `bh.xml` contains the mappings retrieved in Step 1.
    
    This overwrites any mappings already defined. Make sure you test the procedure on a non-production instance first.
    
    Please check the documentation for `curl` for the system you are on. We are not able to support you in this procedure.
