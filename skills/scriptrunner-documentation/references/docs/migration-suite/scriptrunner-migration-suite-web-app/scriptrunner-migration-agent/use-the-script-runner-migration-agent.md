# Use the ScriptRunner Migration Agent

- Platform: migration-suite
- Space: SMS
- Hierarchy: scriptrunner-migration-suite-web-app > scriptrunner-migration-agent
- Doc ID: doc-sms-566298781
- Source: https://docs.adaptavist.com/sms/latest/scriptrunner-migration-suite-web-app/scriptrunner-migration-agent/use-the-scriptrunner-migration-agent

To start, open the ScriptRunner Migration Agent and log in with your Atlassian ID or email.

## Analyse a script

You can use the ScriptRunner Migration Agent to convert a Data Center to Cloud script if the [feature is supported](https://docs.adaptavist.com/sms/latest/scriptrunner-migration-suite-web-app/scriptrunner-migration-agent/supported-features-and-limitations). When you choose to analyse a script, the ScriptRunner Migration Agent:

-   Analyses your script.
    
-   Determines what is possible in Cloud.
    
-   Createss a Cloud script.
    
-   Iterate until until no compilation errors remain.
    

Follow these steps to analyse a script:

1.  Select **Convert script to Cloud**.****  
    ![](/sms/files/latest/566298781/566298779/1/1784147940000/agent-single-script.png)
2.  Choose the **Feature** the script belongs in (like _Behaviour_ or _Workflow function_).
3.  Select the **Project** you want to save the script to.  
    
    Create a new project
    
    If you want to create a new project,
    
    1.  Select **Projects** on the left-hand navigation. 
    2.  Select **Create Project**.   
        ![](/sms/files/latest/566298781/566298780/1/1784147940000/create-project.png)
    3.  Enter a **Project Name**. 
    4.  Select the **Visibility** of the project.  
        You can choose to _Share with organization_ or _Only me_.
    5.  Select **Create Project**.
    
4.  Copy the script you want to convert and paste the script into the script analysis area.
    
5.  Select **Analyse script**.
6.  If a script is produced for you, copy it into your Cloud instance and test to see if it works.

The script is saved in your Project it is assigned to. You can come back to the Migration Agent to deal with any error handling.

This process will take time. ![alarm clock](/plugins/servlet/twitterEmojiRedirector?id=23f0 "alarm clock") 

## Answer queries

You can use the Migration Agent to answer questions about the product. When you send this question, the Migration Agent:

-   Determines what is possible in Cloud.
    
-   Creates a Cloud script.
    
-   Iterates until no compilation errors remain.
    

You can use the **Chat** section of the Migration Agent to help convert Data Center scripts to [HAPI](https://docs.adaptavist.com/sr4js/latest/hapi "https://docs.adaptavist.com/sr4js/latest/hapi").

Follow these steps to ask the ScriptRunner Migration Agent a question:

1.  Optional: Select the **Project** you want to save the chat to.
    
    Create a new project
    
    If you want to create a new project,
    
    1.  Select **Projects** on the left-hand navigation. 
    2.  Select **Create Project**.   
        ![](/sms/files/latest/566298781/566298780/1/1784147940000/create-project.png)
    3.  Enter a **Project Name**. 
    4.  Select the **Visibility** of the project.  
        You can choose to _Share with organization_ or _Only me_.
    5.  Select **Create Project**.
    
2.  Enter your query into the chat dialog box and press Enter.
    
    See [Best Practices](https://docs.adaptavist.com/sms/latest/scriptrunner-migration-suite-web-app/scriptrunner-migration-agent/best-practices) for more details on how to write your query.
    

You can come back to the Migration Agent to address any error handling.

## Example: Advanced usage/report creation

If you used the Migration Agent to answer multiple queries and create scripts, you can generate a report at the end of the chat process. Use and adapt the following example prompt, then paste it into the chat dialog box to create a detailed report:

`Consolidate the outputs of this process in to a single report, you can iterate over this report to produce the highest quality. The different sections should be clearly outlined. Wiki markdown can be used for tables. Use the following sections as a template but add other sections as appropriate. Provide an index at the top to enable quick access to different sections do not use the section numbering below but retain the hierarchy.`

1.  `Migration Analysis Summary`
    
    1.  `What the original script does` 
        
    2.  `Overview of key migration challenges` 
        
    3.  `Migration strategy` 
        
2.  `Refactored Cloud script as a code block`
    
3.  `Implementation Guide` 
    
    1.  `Important Notes` 
        
        1.  `Custom Field IDs` 
            
        2.  `JQL Query changes` 
            
        3.  `Permissions` 
            
        4.  `Any other notes or further customisation requirements (eg replacement of unique IDs in the script)`
            
    2.  `Deployment Steps` 
        
    3.  `Details of any manual adjustments still required` 
        
    4.  `Testing Recommendations` 
        
4.  `Original data centre script as a code block`
    
5.  `Data Center vs Cloud Migration Comparison` 
    
    1.  `Original Data Center Script Issues` 
        
    2.  `Key Improvements in Cloud Version` 
        
    3.  `Migration Benefits`
        
6.  `Key changes Made` 
    
    1.  `Removed Data Center Dependencies and where have HAPI Methods been used` 
        
    2.  `Improved Error Handling` 
        
    3.  `Automatic Benefits` 
        
    4.  `Before vs After Comparison`
        
7.  `Optional Enhancements`
    

Resources

For in depth information about the agent visit the [FAQ](https://docs.adaptavist.com/sms/latest/scriptrunner-migration-suite-web-app/scriptrunner-migration-agent/faq) and learn about [how ScriptRunner Migration Suite outperforms generic AI in Cloud migrations](https://www.scriptrunnerhq.com/inspiration/blog/how-scriptrunner-migration-suite-outperforms-generic-ai-in-cloud-migrations).
