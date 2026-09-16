# Migrate from Version 1 to Version 2

- Platform: migration-suite
- Space: SMS
- Hierarchy: ScriptRunner Migration Suite Web App
- Doc ID: doc-sms-deab6d67-0d59-4723-b692-31ad5b5e645a-bd2bce3b416e3cd7
- Source: https://docs.adaptavist.com/sms/latest/scriptrunner-migration-suite-web-app/migrate-from-version-1-to-version-2

## Migration Analyse and Assess

Please re-upload your [exports of your instance](https://docs.adaptavist.com/sr4js/latest/features/script-registry#exporting-your-scripts--en) to version 2 of the ScriptRunner Migration Agent. You can review how to use the Analyse and Assess tool [here](script-runner-migration-analyse-and-assess-tool/use-the-analyse-and-assess-tool.md), including uploading files and reading your analysis.

## Migration Agent

You can move all of your chats in the [ScriptRunner Migration Agent](script-runner-migration-agent.md) from version 1 to version 2. Follow these steps to keep your chat data:

### Export chats in version 1

1.  Open version 1 of the ScriptRunner Migration Suite and log in.
2.  From any screen, select Export chat data from the left-hand menu.
    
      
      
    
3.  Select Download export.
4.  Save the .json file in a safe location.
    
    Note: If you used sensitive information including scripts and configurations in your chats, it is contained in the file.
    

### Import chats in version 2

1.  Open version 2 of the ScriptRunner Migration Suite and log in.
2.  Select the next to your username, and then select Import chats.
    
      
      
    
3.  Add your .json file from the export of version 1.
4.  Select the following settings for your version 1 chats:
    
    -   Keep them private to you: No further input required.
    -   Add them to an existing project: Choose which Project.
    -   Add them to a new project: Name your Project.
    
5.  Select Import chats.

Once your upload is done, you receive a message:

  
  

Tip: Upload chats into more than one project

Here, you can also choose to upload the exported chats to another project.

Next time you navigate to the project where you uploaded the chats, they will be in your chat history. If you kept them private to you, they will appear on the [ScriptRunner Migration Agent](script-runner-migration-agent.md) home page.

## Dev and Deployment Tool

No action required. The [Dev and Deployment Tool](../uncategorized/s/script-runner-dev-and-deployment-tool.md) has not been changed on version 2 of the ScriptRunner Migration Suite.
