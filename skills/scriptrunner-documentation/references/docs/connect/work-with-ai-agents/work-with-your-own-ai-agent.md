# Work with your own AI Agent

- Platform: connect
- Space: SRC
- Hierarchy: Work with AI Agents
- Doc ID: doc-src-1e1402ee-f038-4708-b812-9acfa576b6d6-9102b86ad00d65b5
- Source: https://docs.adaptavist.com/src/latest/work-with-ai-agents/work-with-your-own-ai-agent

Information about using our external coding feature while working with external AI agents.

While the [CLI (Command Line Interface)](../external-coding/cli-command-line-interface.md) is designed for direct developer use, it is also optimized for AI agents and agentic workflows. When combined with the accompanying [skill](https://www.skills.sh/adaptavist/scriptrunner-skills/sr-connect), you can instruct your AI agent to perform almost any operation in ScriptRunner Connect. For security and governance, certain management operations remain restricted to the web UI—such as creating teams, upgrading subscription plans, inviting or removing team members, and approving egress firewall requests. All other workspace and integration tasks can be delegated directly to your agent, including setting up connectors and webhooks via browser-enabled agents.

Agents can create workspaces, connect systems, and write the TypeScript or JavaScript code required for business automations. Beyond creating new automations, agents can also evaluate feasibility, troubleshoot and optimize existing scripts, or perform one-off operational tasks such as aggregating data across systems. While agents can connect directly to external APIs via Model Context Protocol (MCP), using ScriptRunner Connect compiles business logic into reproducible, deterministic code that can be scheduled, triggered, and audited at lower runtime cost.

CAUTION: Granting an AI agent access to ScriptRunner Connect allows it to manage workspaces and interact with connected systems. Review the [safety](https://docs.adaptavist.com/db/organizations/adaptavist/repositories/production/content/documents/Adaptavist_Content/ScriptRunner/ScriptRunner_Connect/topics/safety_working_with_ai_agents.dita) section below before delegating production tasks.

## Demo

[Media](https://demo.arcade.software/H8rf1qSMP7I6n9PdOvwb?embed&embed_mobile=tab&embed_desktop=inline&show_copy_link=true)

## Get started

[Node 22+](https://nodejs.org/) is required for both installing the skill and running the CLI.

To start external coding with an AI agent:

1.  Install the CLI.
    
    You have 2 options for this (run the command in your terminal):
    
    -   `npx @sr-connect/cli`: this option runs the CLI via the `npx` command.
    -   Install the CLI globally via your package manager of choice, for example: `npm i -g @sr-connect/cli`. Doing so exposes the `sr-connect` command globally on your machine, which is shorter to type than `npx @sr-connect/cli` and can be faster to respond. Use this option if you'll be using the CLI yourself as well.
2.  Install the agent skill by running the following command: `npx skills add https://github.com/adaptavist/scriptrunner-skills --skill sr-connect`.
    
    When installing the skill via `skills` for the first time, you're asked to install the [skills](https://www.npmjs.com/package/skills) package first. Allow this. After that, you will be asked the following:
    
    1.  Harness selection: make sure the harness you use is pre-selected, or select it if it isn't. Claude users, even desktop app users, should make sure `Claude Code` is selected.
    2.  Installation scope: `Global` (recommended, allows you to invoke the `/sr-connect` skill from any directory).
    3.  Installation method: `Symlink` (recommended).
3.  Authenticate yourself with the CLI.
    
    To do that, run either `npx @sr-connect/cli auth login` or `sr-connect auth login` in your terminal, depending on how you installed the CLI. Amongst other things, you'll be asked to generate an API key in the web UI and provide it to the CLI. Follow the instructions laid out by the CLI.
    

## Use ScriptRunner Connect with AI agents

Now that you have the skill and the CLI installed, you're ready to delegate your automation needs to your agent. Ask it anything by referencing the `/sr-connect` skill in your prompt, for example:

-   Using `/sr-connect`, when something happens in system X, do something in system Y
-   Using `/sr-connect`, check why my workspace X is failing, fix it if you can
-   Using `/sr-connect`, check if system X can be integrated with system Y
-   Using `/sr-connect`, show me information A, B and C from systems X and Y

### Check what the agent built

When an agent using the `/sr-connect` skill creates or changes a workspace, it generates the workspace's visual flow, fixes the warnings it can, and ends with a Visual flow link. Open the link and check what the agent built or changed before you deploy a release. Warnings it could not fix are listed at the end of its summary.

If the agent's summary has no link, generate the chart yourself:

1.  Open the workspace in the web app.
2.  Click Visual flow in the list on the left.
3.  Click Generate visual flow, or Regenerate if the chart is _Outdated_.

You can also ask for a review, for example, "Using `/sr-connect`, review workspace X". The agent generates the chart if it's missing or out of date, goes through its warnings and offers fixes without making them.

## Use ScriptRunner Connect with browser-based agents

In many cases, actions such as authorizing a connector and registering a webhook cannot be performed programmatically, but AI agents that can control a browser can do so for you. When the agent thinks it can perform the browser actions for you, it should offer you the option. We recommend that a human perform connector authorizations because most connectors have a timeout for that process, and your agent might not be fast enough to complete the necessary actions within the allotted time. Webhook registration, however, generally doesn't have such restrictions, and agents can take all the time in the world, as long as you'd like to wait.

## Automated tests

If you want local automated tests written, ask for them explicitly. Also, specify the type of tests you want, as the agent is instructed to write tests either by mocking API requests or running them as integration tests (against live systems).

## Governance

When the API key that is set up in the CLI is created with access policy then the agent only has access to what the policy names and will request elevated permissions on-demand.

If the API key is limited, you should enable notifications in the web app under the AI agent chat UI. When working with an external agent, keep at least one tab open to the web app to get notified when the agent requests additional access.

API keys can also be created with expiration (`Never` is the default).

Read more about [Access policies](https://docs.adaptavist.com/src/latest/rest-api/access-policies).

## Feedback

We'd love to hear your feedback on how you're getting along with AI agents, or any instructions you think should be included in the baseline instructions. Please feel free to post your feedback on our [Nolt](https://scriptrunnerconnect.nolt.io/top) board.
