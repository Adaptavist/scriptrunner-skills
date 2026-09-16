# Use the ScriptRunner Migration Agent

- Platform: migration-suite
- Space: SMS
- Hierarchy: ScriptRunner Migration Suite Web App > ScriptRunner Migration Agent
- Doc ID: doc-sms-2bb1e066-169a-4518-b3ef-c64ab3fcc341-e33faa078f68c826
- Source: https://docs.adaptavist.com/sms/latest/scriptrunner-migration-suite-web-app/scriptrunner-migration-agent/use-the-scriptrunner-migration-agent

To start, open the [ScriptRunner Migration Agent](https://scriptrunnermigrationsuite.com/) and log in with your Atlassian ID or email.

## Analyse a script

You can use the ScriptRunner Migration Agent to convert a Data Center to Cloud script if the [feature is supported](../script-runner-migration-analyse-and-assess-tool/supported-features-and-limitations.md). When you choose to analyse a script, the ScriptRunner Migration Agent:

-   Analyses your script.
-   Determines what is possible in Cloud.
-   Creates a Cloud script.
-   Iterates until no compilation errors remain.

1.  Select Convert script to Cloud.
    
2.  Choose the Feature the script belongs in (like _Behaviour_ or _Workflow function_).
3.  Select the Project you want to save the script to.
    
    If you want to create a new project:
    
    1.  Select Projects on the left-hand navigation.
    2.  Select Create Project.
        
    3.  Enter a Project Name.
    4.  Select the Visibility of the project. You can choose to _Share with organization_ or _Only me_.
    5.  Select Create Project.
4.  Copy the script you want to convert and paste it into the script analysis area.
5.  Select Analyse script.
6.  If a script is produced, copy it into your Cloud instance and test to see if it works.

The script is saved in the project it is assigned to. You can come back to the Migration Agent to deal with any error handling.

Note: This process will take time.

## Answer queries

You can use the Migration Agent to answer questions about the product. When you send a question, the Migration Agent:

-   Determines what is possible in Cloud.
-   Creates a Cloud script.
-   Iterates until no compilation errors remain.

Tip: You can use the Chat section of the Migration Agent to help convert Data Center scripts to [HAPI](../../../cloud/uncategorized/h/hapi.md).

1.  Optional: Select the Project you want to save the chat to.
    
    If you want to create a new project:
    
    1.  Select Projects on the left-hand navigation.
    2.  Select Create Project.
        
    3.  Enter a Project Name.
    4.  Select the Visibility of the project. You can choose to _Share with organization_ or _Only me_.
    5.  Select Create Project.
2.  Enter your query into the chat dialog box and press Enter.
    
    Tip: See [Best Practices](best-practices.md) for more details on how to write your query.
    

You can come back to the Migration Agent to address any error handling.

## Example: Advanced usage/report creation

If you used the Migration Agent to answer multiple queries and create scripts, you can generate a report at the end of the chat process. Use and adapt the following example prompt to create a detailed report:

```
Consolidate the outputs of this process in to a single report, you can iterate over this report to produce the highest quality. The different sections should be clearly outlined. Wiki markdown can be used for tables. Use the following sections as a template but add other sections as appropriate. Provide an index at the top to enable quick access to different sections do not use the section numbering below but retain the hierarchy.

1. Migration Analysis Summary
   a. What the original script does
   b. Overview of key migration challenges
   c. Migration strategy
2. Refactored Cloud script as a code block
3. Implementation Guide
   a. Important Notes
      i.   Custom Field IDs
      ii.  JQL Query changes
      iii. Permissions
      iv.  Any other notes or further customisation requirements (eg replacement of unique IDs in the script)
   b. Deployment Steps
   c. Details of any manual adjustments still required
   d. Testing Recommendations
4. Original data centre script as a code block
5. Data Center vs Cloud Migration Comparison
   a. Original Data Center Script Issues
   b. Key Improvements in Cloud Version
   c. Migration Benefits
6. Key changes Made
   a. Removed Data Center Dependencies and where have HAPI Methods been used
   b. Improved Error Handling
   c. Automatic Benefits
   d. Before vs After Comparison
7. Optional Enhancements
```

Note: Resources

For in-depth information about the agent, visit the [FAQ](faq.md) and learn about [how ScriptRunner Migration Suite outperforms generic AI in Cloud migrations](https://www.scriptrunnerhq.com/inspiration/blog/how-scriptrunner-migration-suite-outperforms-generic-ai-in-cloud-migrations).
