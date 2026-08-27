# Behaviours Bot

- Platform: cloud
- Space: SR4JC
- Hierarchy: features > behaviours
- Doc ID: doc-sr4jc-480379487
- Source: https://docs.adaptavist.com/sr4jc/latest/features/behaviours/behaviours-bot

## What is the Behaviours Bot?

The Behaviours Bot is an AI-powered script generation assistant built into ScriptRunner for Jira Cloud. It converts natural, everyday language instructions into ready-to-use Behaviour scripts. You can utilize the functionality of the Behaviours Bot to create new Behaviour scripts or modify, refine, and improve existing ones.

The Behaviours Bot uses a Ministral model by Mistral AI (hosted on AWS Bedrock) to process requests and generate responses. All data handled by the Behaviours Bot is processed exclusively within AWS, which is already covered under the Adaptavist Data Processing Addendum (DPA) accepted when obtaining a ScriptRunner license. No additional third parties receive or process Behaviours Bot data.

Using the Behaviours Bot offers several advantages when creating and managing Behaviour scripts:

-   **Simplified script creation**  
    Supports both technical and non-technical users by generating Behaviour scripts from natural language input.
    
-   **Faster Jira Cloud customization**  
    Converts requirements into Behaviours scripts instantly, speeding up configuration work.
    
-   **Improved reliability**  
    Built-in error checking and testing allow you to validate Behaviours scripts before deployment, reducing the risk of issues.
    
-   **Script preview  
    **Generated Behaviours scripts can be executed and previewed directly in a preview window.
-   **Lower training and support demands**  
    Helps teams customize Behaviours without needing scripting knowledge, decreasing the need for training or support.
    
-   **Context-aware AI assistance**  
    Generates accurate results informed by deep ScriptRunner and Jira Cloud expertise.
    
-   **Fewer bugs and misconfigurations**  
    Early error detection and clear Behaviour script generation lead to smoother workflows and fewer support tickets.
    

## How to use the Behaviours Bot

JSM coming soon

The Behaviours Bot does not support JSM behaviours, however, this functionality will be released soon.

The Behaviours Bot is fully integrated into the app and is free to use. This feature is turned off by default. Your ScriptRunner for Jira Cloud organization administrator can enable it in the [Settings](https://docs.adaptavist.com/sr4jc/latest/get-started/settings) for your instance.

Within the Behaviours feature, you’ll see a notification banner prompting you to try the Behaviours Bot, as shown in the example below.

![](/sr4jc/files/latest/480379487/574260439/1/1784710477000/bot+try+it+out.png)

Click **Try it out** to open the Behaviours Bot on your instance. Depending on your role and whether your [ScriptRunner AI setting](https://docs.adaptavist.com/sr4jc/latest/get-started/settings#id-.SettingsvCurrent-ScriptRunnerAI) is enabled, you are prompted to do one of the following actions:

-   Start using the Behaviours Bot.
-   Activate the required setting.
-   Contact your administrator.

![](/sr4jc/files/latest/480379487/483197262/1/1765285745000/bot+onboarding.png)

When writing a script in the Behaviours code editor, you can:

-   Use one of the available **Example Scripts.**
-   Write your own code, or
-   Click **Ask Behaviours Bot** to chat with the Behaviours Bot. 

Chatting with the Behaviours Bot allows you to describe your scripting queries in everyday plain language, enabling the Bot to generate example Behaviours scripts based on your prompts.

### Example: Generate a Behaviours script with the Bot

Suppose you're editing an existing behaviour that has two events and two views selected. In this case, you'll see the **Ask Behaviours Bot** option enabled, as shown below:![](/sr4jc/files/latest/480379487/480379489/1/1764168804000/edit+script+bot.png)  

1.  Click **Ask Behaviours Bot**. The Behaviours Bot landing screen opens:  
    ![](/sr4jc/files/latest/480379487/480379497/2/1774367184000/bot+landing+screen.png)  
    
2.  Enter your Behaviours context in the right-hand panel by choosing from either the **Create** or **View/Edit** view type options.  
    Depending on your selection, choose:
    -   **Space** - select the relevant space from the list available for the chosen view.
    -   **Work type** - select from a list of recent work items, or enter a full work item key.  
        
3.  Enter your query or instruction in the main panel.  
    You can make the query as descriptive as you like. The Behaviours Bot is designed to deliver accurate responses to all Behaviours queries. It can modify existing scripts, identify errors, and create new scripts from your prompts. For example, after choosing your **View type**, **Space**, and **Work type**, you could ask the Bot to _Set summary to 'sprint demo',_ and opt to run the script **onload**.
4.  **(Optional)** Use the **Add some code** option to include code for the Bot to review.
5.  Click **Send**. The Behaviours Bot generates a Behaviours script and displays it in the code editor.  
    ![](/sr4jc/files/latest/480379487/524224866/1/1774367504000/Set+summary+to+%27sprint+demo%27.png)  
    The Behaviours Bot provides you with the corresponding work item fields in the _Form preview_ panel configured for the chosen space on your Jira instance.  
    ![](/sr4jc/files/latest/480379487/480379490/1/1763462237000/code+with+preview.png)
6.  Review both the generated code and the _Form preview_ panel to confirm the behaviour works as expected. 
7.  **(Optional)** Modify the example script if it doesn't work as expected by:
    -   Editing the code directly in the editor.
    -   Continuing to chat with the Behaviours Bot to refine the result.
    -   Changing how the code is executed by selecting **On load** or **On change** under **Run this script**, and clicking **Re-run script.**
    -   Clicking **Re-run script** again once all modifications have been made to generate an updated Behaviours script.
8.  Click **Copy code** when you are satisfied with the results provided, and paste it into your Behaviours script.  
    
    The Behaviours Bot is currently in Beta, and chat history is not yet stored. This means your conversation will be lost if you leave the page. We are actively working to improve this experience.
