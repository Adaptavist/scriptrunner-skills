# Migrate from version 1 to version 2

- Platform: migration-suite
- Space: SMS
- Hierarchy: scriptrunner-migration-suite-web-app
- Doc ID: doc-sms-578718840
- Source: https://docs.adaptavist.com/sms/latest/scriptrunner-migration-suite-web-app/migrate-from-version-1-to-version-2

## Migration Analyse and Assess

Please re-upload your [exports of your instance](https://docs.adaptavist.com/sr4js/latest/features/script-registry#exporting-your-scripts) to version 2 of the ScriptRunner Migration Agent. You can review how to use the Analyse and Assess tool [here](https://docs.adaptavist.com/sms/latest/scriptrunner-migration-suite-web-app/scriptrunner-migration-analyse-and-assess-tool/use-the-analyse-and-assess-tool), including uploading files and reading your analysis. 

## Migration Agent

You can move all of your chats in the [ScriptRunner Migration Agent](https://docs.adaptavist.com/sms/latest/scriptrunner-migration-suite-web-app/scriptrunner-migration-agent) from version 1 to version 2. Follow these steps to keep your chat data:

### Export scripts in version 1

1.  Open version 1 of the ScriptRunner Migration Suite and log in.
2.  From any screen, select **Export chat data** from the left-hand menu.  
    ![](/sms/files/latest/578718840/585205300/1/1787674361000/export-chat-data.png)
3.  Select **Download export**.
4.  Save the .json file in a safe location.   
    
    If you used sensitive information including scripts and configurations in your chats, it is contained in the file.
    

### Import scripts in version 2

1.  Open version 2 of the ScriptRunner Migration Suite and log in. 
2.  Select the ![](/sms/files/latest/550633631/550633629/1/1779225288000/settings-button.png) next to your username, and then select **Import chats**.  
    ![](/sms/files/latest/578718840/585205301/1/1787678979000/import-chat.png)
3.  Add your .json file from the export of version 1. 
4.  Select the following settings for your version 1 chats:
    -   Keep them private to you: No further input required.
    -   Add them to an existing project: Choose which Project.
    -   Add them to a new project: Name your Project.
5.  Select **Import chats**.

Once your upload is done, you receive a message: 

![](/sms/files/latest/578718840/585205302/1/1787679330000/import-complete.png)

Upload chats into more than one project

Here, you can also choose to upload the exported chats to another project. 

Next time you navigate to the project where you uploaded the chats, they will be in your chat history. If you kept them private to you, they will appear on the [ScriptRunner Migration Agent](https://docs.adaptavist.com/sms/latest/scriptrunner-migration-suite-web-app/scriptrunner-migration-agent) home page.

## Dev and Deployment Tool

No action required. The [Dev and Deployment Tool](https://docs.adaptavist.com/sms/latest/scriptrunner-dev-and-deployment-tool) has not been changed on version 2 of the ScriptRunner Migration Suite.
