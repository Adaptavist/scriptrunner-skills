# ScriptRunner Migration Agent

- Platform: migration-suite
- Space: SMS
- Hierarchy: scriptrunner-migration-suite-web-app
- Doc ID: doc-sms-566298760
- Source: https://docs.adaptavist.com/sms/latest/scriptrunner-migration-suite-web-app/scriptrunner-migration-agent

The Migration Agent is a specialised AI chat agent. You can use the agent to help you create, convert, and optimise scripts, or you can use it to answer a variety of different questions about ScriptRunner. Whether you're migrating from Data Center, building new Cloud implementations, or troubleshooting existing code, the migration agent provides comprehensive guidance using current API documentation and best practices.

The Migration Agent has two main functions:

-   **Chat**: The chat function lets you discuss all aspects of migration.
    
-   **Convert script to Cloud**: Converts a single DC script and suggests an alternative for ScriptRunner Cloud.
    

The **Convert script to Cloud** function in the Migration Agent is different from the **Migration Assess and Analyse Tool**.

## How the Migration Agent works

The Migration Agent has many research and validation capabilities, these are a few of them:

-   Explains what a script does in natural language
    
-   Generates helpful reports based on the analysis of the customer instance
    
-   Researches current API documentation before generating code
    
-   Performs recursive API lookups to ensure accuracy
    
-   Validates all generated code automatically
    
-   Bases solutions on verified, up-to-date information
    

**HAPI prioritization**

The Migration Agent prioritizes HAPI (the Cloud-specific DSL) over direct REST API calls, which is crucial for Cloud development.
