# Behaviours Bot security and data

- Platform: cloud
- Space: SR4JC
- Hierarchy: Features > Behaviours > Behaviours Bot
- Doc ID: doc-sr4jc-fbb75415-6d9b-4f9e-869e-10927a2c795f-31b532edb55cdc39
- Source: https://docs.adaptavist.com/sr4jc/latest/features/behaviours#behaviours-bot--en#what-8xdtsrlx--en

Note: The Behaviours Bot uses the OpenAI GPT-5.6 Luna model, developed by OpenAI but run on Amazon Bedrock within AWS to process requests and generate responses. All data handled by the Behaviours Bot is processed exclusively within AWS, which is already covered under the Adaptavist Data Processing Addendum (DPA) accepted when obtaining a ScriptRunner license. No additional third parties receive or process Behaviours Bot data.

## Is the Behaviours Bot enabled by default?

No. ScriptRunner AI, which powers the Behaviours Bot, is a [setting](../../../get-started/settings.md) that is disabled by default. An admin has to turn it on before anyone on your site can use the Behaviours Bot.

## Who can turn the Bot on or off?

Only ScriptRunner for Jira Cloud organization admins can enable or disable ScriptRunner AI.

To do this, go to ScriptRunner > Settings > ScriptRunner AI and activate the toggle.

In order to access and activate the Behaviours Bot setting, you must belong to the org-admins or site-admins groups.

## Does turning off AI affect Behaviours?

No. With ScriptRunner AI turned off, Behaviours keeps working as normal, and you can still create, edit and run Behaviours. The only difference is that users can't open the Behaviours Bot to generate Behaviour scripts.

## Where is the AI hosted?

The Behaviours Bot uses Amazon Bedrock, hosted in the us-west-2 (US West, Oregon) AWS region. At peak times, Amazon Bedrock may process requests in other US regions, such as us-east-1 and us-east-2.

Your data stays within AWS. It's never sent to any other AI provider, such as OpenAI. AWS is already listed as a subprocessor in our \[Data Processing Addendum\].

## What data is sent to Amazon Bedrock?

When someone uses the Behaviours Bot, ScriptRunner sends:

| Data | What's included |
| --- | --- |
| Jira data | Space (project) data, work item data, fields, field values, and screen configurations. |
| Conversation | User messages to the Behaviours Bot, and its replies, in the current session. |
| User details | The user's Atlassian display name and Atlassian account ID. |

Note: An Atlassian display name and account ID count as personal data under GDPR.

ScriptRunner only sends data when the Behaviours Bot is actively being used. Nothing is sent while ScriptRunner AI is turned off.

## Is my data used to train AI models?

No. Your data isn't used to train any AI models, either by Adaptavist or by AWS.

## Is chat history stored?

The Behaviours Bot is currently in Beta, and chat history is not yet stored. This means your conversation will be lost if you leave the page.

## Does the Behaviours Bot comply with our DPA and security agreements?

Yes. The Behaviours Bot is covered by your existing customer agreements and our Data Processing Addendum. It doesn't add any new subprocessors, because AWS is already listed as one.

## Related content

-   [AI and agents](../../ai-and-agents.md)
