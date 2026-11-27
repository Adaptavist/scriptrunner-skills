# Work with AI Agents

- Platform: connect
- Space: SRC
- Hierarchy: n/a
- Doc ID: doc-src-096124ec-1a8b-459f-9af1-0ac46a228798-b5a7f1123a5bdd8c
- Source: https://docs.adaptavist.com/src/latest/work-with-ai-agents

Learn how to use AI Agents to get work done in ScriptRunner Connect.

Note: The embedded agent is not fully released yet. If the side navigation shows _AI assistant_ instead of _AI Agent_, you are seeing the previous experience. Use your own AI agent until _AI Agent_ is available.

An AI agent builds, changes and troubleshoots integrations in ScriptRunner Connect for you. You describe what you need in plain words, and the agent works out how to do it: which apps to connect, which scripts to write, and how to test them. It asks before it changes anything, and an [access policy](https://docs.adaptavist.com/src/latest/rest-api/access-policies) determines how far it can go.

You can work with an AI agent in two ways:

-   [Use the embedded agent](../../work-with-ai-agents/work-with-the-embedded-agent.md), the AI agent built into the ScriptRunner Connect web app. There is nothing to install.
-   [Use your own AI agent](../../work-with-ai-agents/work-with-your-own-ai-agent.md), such as Claude Code, Codex, or OpenCode, on your computer. It works with ScriptRunner Connect through the [ScriptRunner Connect CLI](../../external-coding/cli-command-line-interface.md) and the [sr-connect skill](https://www.skills.sh/adaptavist/scriptrunner-skills/sr-connect).

Both use the same CLI and skill, so they can do the same work. They differ in where they run, what they can reach, and how they guide you through the work.

## Key terms

Embedded agent

The AI agent built into the web app.

External agent

An AI agent you run yourself, such as Claude Code, Codex, or OpenCode, on your computer, connected to ScriptRunner Connect with an API key. This page also refers to external agents as "your own AI agent."

CLI

The ScriptRunner Connect Command-Line Interface. AI agents use it to work in ScriptRunner Connect.

sr-connect skill

The instructions that teach an AI agent how ScriptRunner Connect works and how to use the CLI.

Access policy

The permissions an agent starts with. The agent asks you for more when the work requires it.

Task

One conversation with the embedded agent.

## What AI agents can do

Check viability

Whether and how an app can be integrated with ScriptRunner Connect, including apps behind a firewall.

Find

Templates that already solve all or part of what you need, so you can start from one instead of from scratch.

Advise

How ScriptRunner Connect works and which features fit your use case.

Build

New integrations from start to finish, including workspaces, scripts, connectors, API connections, event listeners, scheduled triggers, event queues, parameters and releases. It triggers scripts and replays events to test its work.

Expand

Change and extend the workspaces you already have.

Troubleshoot

Read the invocation, console, and HTTP logs to identify the cause of a failure, propose and apply a fix.

Analyse

Explain and review scripts and workspaces, and work with the files you provide.

## Which one to use

Start with the embedded agent.

There is nothing to install; it guides you through the work with questions, a plan and access requests, and it runs in a secure sandbox with security settings you control for each task.

Choose your own AI agent when:

-   The work needs your computer: a browser, your files, a Git repository, tests that run in CI, or other tools you use.
-   Your team's daily or weekly allowance for the embedded agent has run out.
-   A Super Admin has turned the embedded agent off for your team.
-   Your company does not allow the use of Anthropic models, which the embedded agent uses. Your own agent can use a model your company has approved.

The work itself lives in ScriptRunner Connect, not in the agent. You can start with one agent and carry on with the other.

## Comparison

## What they do

| Capabilty | Embedded agent | Your own AI agent |
| --- | --- | --- |
| Checks, finds, advises, builds, expands, troubleshoots and analyses | Yes | Yes |
| Works under access policies | Yes, with the policy you pick for each task. | Yes, with the policy on its API key. |
| Prepares a plan for you to confirm before it changes or runs anything | Yes, with Confirm and Decline buttons. | No, not by default. Ask for a plan, using the planning tools of your choice. |
| Finishes with a diagram of the workspace and what changed | Yes | No, not by default. Ask for one. |
| Writes tests you can keep and run in CI | No. Tests written in its sandbox are lost when the sandbox ends. | Yes, when explicitly asked. It writes Jest tests in a copy of the workspace on your computer, which you can keep in Git and run in CI. |
| Has API specs for most supported connector apps built in | Yes, for apps such as Jira, Confluence, Slack, GitHub, Microsoft and Zendesk, also with internet access off. | No. They look them up online. |

## How agents work with you

| Scenario | Embedded agent | Your own AI agent |
| --- | --- | --- |
| Knows where you are in the web app: the team, workspace and environment you have open, and whether you have unsaved changes | Yes. With limited access, it keeps to the team selected in the top-left corner of the web app. | No. Tell it which workspace to work on. For an API key, the current team is any team you are a member of. |
| Has one-click actions in the web app: explain or improve a script, troubleshoot an error, explain or review a workspace, check its latest failures | Yes | No. When a run fails, the web app provides a prompt you can copy into your own agent. |
| Asks its questions as choices you click | Yes | This depends on your chosen agent. |
| Draws charts and diagrams in the conversation, and gives you files such as CSV, Excel and PDF | Yes | This depends on your chosen agent. |
| Takes the workspace lock for you when you have no unsaved changes, and links you to the workspace to watch its changes land | Yes | No. While you have the workspace open, it asks before it takes the lock. |
| Notifies you in the browser | Yes, when it has questions, a plan or an access request, and when it finishes or fails. | Access requests only while a web app tab is open. |

## What they can reach

| Access | Embedded agent | Your own AI agent |
| --- | --- | --- |
| Drives a browser for steps such as authorizing a connector or registering a webhook in another app | No. It gives you a _Browser setup prompt_ to copy into an agent that can, or to follow yourself. | Yes, if your agent has browser tools. |
| Works with your computer: your files, Git repositories, other CLIs, MCP servers and skills | No | Yes |
| Keeps a copy of the workspace on your computer, for example, in Git | No. Its sandbox is temporary. | Yes |
| Runs in an isolated sandbox, with security settings for each task, such as internet access | Yes | No. It runs with your computer's access, which you control. |
| Deletes workspaces, environments, connectors and connector shares | Only with limited access, once you approve the permission. Never with unlimited access. | Yes, as its API key allows. |
| Can be turned off for a team by a Super Admin | Yes | No. This setting applies only to the embedded agent. |

## Setup and cost

|  | Embedded agent | Your own AI agent |
| --- | --- | --- |
| Setup | None. | Node.js, the CLI and the sr-connect skill, and a login. |
| Models and cost | Anthropic models you pick for each task. Uses your team's daily and weekly allowance. | Any model your agent supports on your own AI subscription. |
| Time limits | Up to an hour for each message you send. | None from ScriptRunner Connect. |
| Updates | Always uses the CLI and skill version the web app provides. | You keep the CLI and skill up to date. Both tell your agent when an update is available. |

## Use the embedded agent

Click [AI Agent](../../work-with-ai-agents/work-with-the-embedded-agent.md) in the side navigation, describe what you need and send the message.

## Use your own AI agent

Install the CLI and the sr-connect skill, log in, and mention `/sr-connect` in your prompt. The web app shows you how under _[Use your own AI agent](../../work-with-ai-agents/work-with-your-own-ai-agent.md)_, in the embedded agent panel.

## Governance

Both agents work under [access policies](https://docs.adaptavist.com/src/latest/rest-api/access-policies). A policy sets what an agent can do without asking you, and in which teams, workspaces and environments. It also specifies which HTTP methods and URL paths the scripts the agent triggers can use to call external API endpoints. When the work needs more, the agent sends you an access request, and you approve or decline each permission.

## Best practice

-   Start with limited access.
    -   Give the agent the _Read-Only_ policy, and approve more as the work shows what it needs.
-   Ask for a plan before production work.
    -   And review it before the agent makes any changes. The embedded agent always prepares one; ask your own agent for one.
-   Be precise.
    -   Name the apps, the workspace and the environment, and say what counts as done, so the agent does not have to guess.
-   Keep a web app tab open.
    -   With notifications on when you work with your own agent, you are notified straight away when it asks for more access.
-   Switch agents when you need to.
    -   When the embedded agent's allowance runs out, or the work requires your computer, continue with your own agent. The workspace is in ScriptRunner Connect, so nothing is lost.
