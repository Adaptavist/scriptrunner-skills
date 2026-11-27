# Rovo Integration

- Platform: cloud
- Space: SR4JC
- Hierarchy: Features > AI and Agents
- Doc ID: doc-sr4jc-1c5d6489-68f5-4a96-be6e-83a99e1b3662-8e6d921de94b5654
- Source: https://docs.adaptavist.com/sr4jc/latest/features/ai-and-agents/rovo-integration

Learn how to use Atlassian Rovo within ScriptRunner for Jira Cloud to write scripts, answer ScriptRunner questions, and improve your Jira automations.

Warning: Rovo is turned on by default.

Rovo is Atlassian's AI offering that helps you search, chat, and use agents to accelerate tasks across all your connected SaaS apps. Learn more about [Rovo](https://www.atlassian.com/software/rovo/guides/end-user-guide/what-is-rovo) from Atlassian. Rovo has been integrated into ScriptRunner for Jira Cloud to help you write scripts, answer questions about ScriptRunner, and improve your Jira automations.

You can open Rovo from within ScriptRunner for Jira Cloud in two ways:

-   Select Ask Agent on any ScriptRunner screen:
-   Select the Agent button on any code editor, and then select Open Agent:
    
    Note: You can also select Explain this script or Use script as context here when there is a script in the editor. Learn more in a [following section](https://docs.adaptavist.com/sr4jc/latest/features/ai-and-agents/rovo-integration#concept-4572--en__section-64).
    

After selecting Open Agent, Rovo appears on the right-hand side of the screen. There, you can chat with Rovo. You can:

-   Ask questions about ScriptRunner for Jira Cloud
    
-   Create, update, or delete listeners, scheduled jobs, escalation services, scriptfied fields, behaviours, workflow rules, and Script Manager files.
    

Rovo in ScriptRunner for Jira Cloud works as you, with your Jira permissions. Rovo changes go live immediately, but they do not appear in the ScriptRunner audit log yet.

Warning: Rovo answers use AI. Make sure to verify your results before implementing them in your production instance.

## Example actions and questions for Rovo

You can ask Rovo to help you manage your instance and implement new automations, like:

-   Write an Enhanced Search query to find unresolved work items that are blocked by open work items
-   Create a behaviour that looks up a user through the Jira REST API and fills in the assignee on the create screen
-   Create a paragraph scripted field that shows a table of work item data
-   Is there a place in this script to use HAPI? (Make sure to include a script in the question.)

Learn more about [how to prompt Rovo](https://www.atlassian.com/software/rovo/guides/end-user-guide/prompt-fundamentals) from Atlassian.

## Use Rovo on a specific script

When you select the agent button on a code editor, you can select two options for help with a script that is populated in the editor: Explain this script and Use script as context

After selecting Explain this script, Rovo opens on the right-hand side of your screen and runs an analysis of the script. When it finishes, it sends a detailed report of what the script is and how it works. For example, you can receive a Summary of Functionality, Inputs (like APIs and URLs), Jira Effects (like Field Mapping and Issue Creation), Control Flow (like Data Parsing and Time Calculation), and Risks and Considerations (like Error Handling and Rate Limiting warnings). You also get example follow-up prompts you can send the agent.

After selecting Use script as context, Rovo opens on the right-hand side of your screen with the script loaded, waiting for further instructions. You receive follow-up prompts you can send the agent to get started.

## Restricting the Rovo agent

Atlassian currently gives administrators limited controls over app agents, and there's no way to remove one from a site. We have submitted feedback to Atlassian asking for better controls.

In the meantime, you can restrict the agent to specific people in Rovo Studio. Follow these steps:

1.  Open Rovo Studio.
    
2.  Select Agents in the left sidebar.
    
3.  Find the ScriptRunner agent, and then select Edit Agent.
    
4.  Under Users and Collaborators, select Add people, and then add one user.
    
    Tip: We recommend setting this to an administrator.
    
5.  Turn off Open to all users under User Access.
    

## Use a different AI agent

If you want to use your own agent, please refer to [Connect AI Agents to ScriptRunner for Jira Cloud with MCP](connect-ai-agents-to-script-runner-for-jira-cloud-with-mcp.md).
