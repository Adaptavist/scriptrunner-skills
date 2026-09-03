# Script Console

- Platform: confluence-cloud
- Space: SR4CC
- Hierarchy: features
- Doc ID: doc-sr4cc-107988483
- Source: https://docs.adaptavist.com/sr4cc/latest/features/script-console

The script console is a place to run scripts. Using the script console, you can copy and paste or write a script to run in Confluence. You can experiment with the [Cloud REST APIs](https://developer.atlassian.com/cloud/confluence/rest/), or you can run one-time scripts. Code run from the script console can make requests back to Confluence using either the ScriptRunner add-on user or the current user.

You find a script editor, similar to the the script console, anywhere you choose to use a custom script option (for example, when adding a listener or scheduled job).

The script console is useful for testing scripts or performing operations that you only want to do once. So if you want a list of all the spaces on your instance and some details about them, you can run a script for that. Or if you want to delete all spaces that were created by a certain person, you can do that. You can also run maintenance scripts that modify something on your instance.

You can perform a lot of these same tasks in different parts of ScriptRunner.

Like all coding fields in ScriptRunner for Confluence Cloud, the script console uses the [Code Editor](https://docs.adaptavist.com/sr4cc/latest/scripting-resources/code-editor). The editor has autocomplete for the following code: 

-   Groovy
-   Atlassian REST API
-   Automatically available variables

You can see autocomplete in the following screenshot: 

![](/sr4cc/files/latest/107988483/288523524/1/1725041408000/autocomplete-example.png)

## Use the Script Console 

To use the script console, follow these steps: 

1.  Navigate to _ScriptRunner_ and select **Script Console**.  
    ![](/sr4cc/files/latest/107988483/588874148/1/1769186409000/script-console.png)
    
2.  Enter the script you want.
    
    Tips for using the Script Console
    
    -   Some example scripts can be found below the editor box (click one to auto-fill), but you can also write and run your own.
    -   Use the Expand button (![](/sr4cc/files/latest/107988483/246186048/1/1710449980000/expand.png)) to have more room for scripting. 
    -   To exit the full screen, press **F11** or Esc twice when the cursor is in the editor. 
    
3.  Choose the user you want to run the script for **Run As**. 
    
    Script console can make requests back to Confluence using either the ScriptRunner add-on user or the user that performed the action to cause the event to be fired. Therefore, you can choose whether the creator of a specific action is the current user or a generic ScriptRunner add-on user using the **Run As** field. 
    
4.  Select **Run**.
