# Slack Connection

- Platform: data-center
- Space: SR4JS
- Hierarchy: features > resources
- Doc ID: doc-sr4js-101625781
- Source: https://docs.adaptavist.com/sr4js/latest/features/resources/slack-connection

In this page we go through the process of creating a _Resources_ Slack connection. 

## Create Slack App

First, you will need to navigate to Slack api to create an app with a name and a Slack domain. Here we walk through creating a simple slack app which allows a bot to post a message to a user.

We suggest setting up your Slack app on a development workspace first.

1.  Navigate to Slack’s [_Your Apps_](https://api.slack.com/apps?new_app=1) page and click **Create an App**.
2.  Enter an **App Name**, for example, _ScriptRunner Integration_.
3.  Choose your **Development Slack Workspace**. You’ll need to either sign in to your workspace or [create a new workspace](https://slack.com/create) to add it as your development workspace.
4.  Navigate to **OAuth & Permissions** and click **Add an OAuth Scope** under _Bot Token Scopes_.
    
    These [scopes](https://api.slack.com/scopes) tell your app the permissions that it has access to, such as sending messages or viewing rooms.
    
    For example, add the _im:write_ scope if you want your Slack bot to post a message to a user. You can edit this later to add extra permissions, such as _chat:write_ and _chat:write:public_ to post to a channel.
    
5.  Once you have added at least one scope, navigate to **App Home**.
6.  Click **Edit** to change the **Display Name** and **Default username** for your bot (the app uses the _bot user_ to post in the workspace). The **Display Name** is the name that will be displayed on Slack when a message is sent.  
    ![](/files/101638450/107984089/1/1616790186000/slack-bot-example.png)
7.  Click **Save**.
8.  Navigate back to the **OAuth and Permissions** tab and click **Install to Workspace** to install the app.  
    ![](/files/101638450/107984088/1/1616790186000/slack-example-app.png)
    
      
    
9.  The **Bot Oauth Access Token** now displays at the top of the _OAuth & Permissions_ page. This is the token the feature needs to send messages, click the **Copy** button.
    
    ![](/files/101638450/107984090/1/1616790186000/slack-bot-token.png)

## Set up the Slack Resource

1.  Navigate to **ScriptRunner**→ **Resources**→ **Add New Item**→ **Slack Connection**.
    
2.  Provide a name for the connection in **Connection Name**. For example, _slack_ or if you use multiple workspaces use the workspace name.
    
3.  Enter the _Bot OAuth Token_ for your Slack workspace in **Token**.
    
    For help getting your _Bot OAuth Token_ see _Create a Slack App_ above.
    
    The token provided can be viewed by administrators.
    
4.  Click **Preview** to validate the connection using the token provided.
    
5.  Click **Add**. Your Slack connection is now configured.
    
6.  To test the connection, navigate to the **ScriptRunner**→ **Script Console**.
    
7.  Use the simple script below to test that the bot can post to a user and/or a channel.
    
    We recommend you test your slack connection using your own user details, or set up a test slack room.
    
    When sending a message to a Slack channel the scope _chat:write_ is required…​ for a public channel _chat:write\_public_ is required. To send a direct message the scope _users:read.email_ is required.
    
    ```
import com.onresolve.scriptrunner.slack.SlackUtil

SlackUtil.message(
    "slack",                         // Identifier you provided when creating the resource
    "acme-developers",               // channel name or ID, or user email
    "Hi, this is the message text"   // Message text
)
```
    

Accepted values for the _channel_ argument (the second argument) are public or private channel name (or ID), or a user’s email address, or ID, to send a direct message.

The full list of allowed parameters that can be used to format your Slack messages can be found [here](https://api.slack.com/methods/chat.postMessage).

Remember that a Slack bot requires certain [scopes](https://api.slack.com/scopes) to message a user and/or channel. If these test scripts fail, check the _Bot Token Scopes_ under **OAuth & Permissions** for your [Slack app](https://api.slack.com/apps).

-   _chat:write_: send messages to channels
    
-   _chat:write.public_: send messages to channels the _bot user_ user isn’t a member of.
    
-   _files:write_: upload files
    
-   _users:read_ and _users:read.email_: send direct messages to a user
    
-   _chat:write.customize_: send messages as _bot user_ with a customized username and avatar
    

## Slack Examples

Having set up your Slack connection, you can now use it in your ScriptRunner scripts using the resource **Connection Name**.

### Using Blocks and Attachments

The following example sends a message using [blocks](https://api.slack.com/reference/block-kit) and [attachments](https://api.slack.com/methods/chat.postMessage). In this case the message text provided is used as a fallback option.  

```
import com.onresolve.scriptrunner.slack.SlackUtil

SlackUtil.message("slack",
    "acme-developers",
    "This is the fallback message text",
    [
        username   : "ScriptRunner Bot",
        blocks     : [
            [
                type: 'section',
                text: [
                    type: 'plain_text',
                    text: 'Message text'
                ]
            ]
        ],
        attachments: [
            [
                pretext: 'Introductory text',
                text   : 'Text message as part of attachment'
            ],
        ]
    ]
)
```

Use the [block kit builder](https://app.slack.com/block-kit-builder) to preview your messages.

### Uploading a File

Upload file to a Slack channel. Scope _files:write_ is required. You can either upload a file to a channel (if the bot user is part of this channel) or to a specific user:

```
import com.onresolve.scriptrunner.slack.SlackUtil

SlackUtil.upload("slack",
    "acme-developers",
    new File("/tmp/file.txt"),
    [
        text           : 'Fallback text',
        initial_comment: 'Comment about the file being uploaded',
    ]
)
```

To send an attachment the app must be added to the channel, which you can do by clicking the _Add apps_ link from the channel details, then the **More** menu.

The full list of allowed parameters can be found [here](https://api.slack.com/methods/files.upload).

In a Post Function

As another example, you can add the following to a post function to send a message to the project manager with the issue priority and summary after it is created.

```
import com.onresolve.scriptrunner.slack.SlackUtil

SlackUtil.message("slack",
    "acme-developers",
    "${issue.priority.name} priority issue created: *${issue.summary}*"
)
```
