# Work with the Embedded Agent

- Platform: connect
- Space: SRC
- Hierarchy: Work with AI Agents
- Doc ID: doc-src-6c3722fc-1f24-402c-a707-88001ce079de-16a5879b8f9562f9
- Source: https://docs.adaptavist.com/src/latest/work-with-ai-agents/work-with-the-embedded-agent

Note: The embedded agent is not fully released yet. If the side navigation shows a button called _AI assistant_ instead of _AI Agent_, you are seeing the previous experience. Wait until the _AI Agent_ button is available, or use your own AI agent in the meantime.

Note: The embedded agent uses Anthropic models. Calls to the model are not bound to your ScriptRunner Connect region: Anthropic routes them through its global data centres, mainly in the US. Your tasks and attached files are stored in your ScriptRunner Connect region. For more, see [Security](https://docs.adaptavist.com/src/latest/security/).

The embedded agent is the AI agent built into the ScriptRunner Connect web app. You describe what you need in plain words, and it works out how to do it: it checks whether an integration is possible, builds and changes integrations for you, and finds out why something failed. It asks before it changes anything, and you decide how much access it has.

The embedded agent is about as capable as an AI agent you run yourself with the [ScriptRunner Connect CLI](https://docs.adaptavist.com/src/latest/external-coding/cli-command-line-interface/) and the [sr-connect skill](https://www.skills.sh/adaptavist/scriptrunner-skills/sr-connect). That is because it uses the same CLI and skill within its own sandbox, with additional guidance for working in the web app. On top of that, it runs in a secure hosted sandbox and comes with security settings you control for each task.

## Key terms

Embedded agent

The AI agent built into the web app.

External agent

An AI agent you run yourself, such as Claude Code, Codex, or OpenCode, on your computer, connected to ScriptRunner Connect with an API key.

Task

One conversation with the embedded agent, from your first message to the last. A few places in the web app call it a "chat", such as Copy chat ID.

Plan

The list of changes the agent wants to make, which you confirm before it changes or runs anything.

Access request

The agent asking you for permissions its access policy does not automatically grant.

Allowance

How much your team can use the embedded agent each day and week.

Sandbox

The isolated, temporary environment the agent works in.

[Visual flow](https://docs.adaptavist.com/src/latest/workspaces/visual-flow)

A chart of what a workspace's scrpts do, derived from the saved code, not by AI. After changing a workspace, the agent generates its visual flow.

## What the embedded agent can do

Everything an AI agent can do in ScriptRunner Connect: check whether an integration is possible, find templates, advise, build, expand, troubleshoot and analyse.

You can attach files to a message: images, PDFs and other files. The agent reads images and PDFs directly and works with other files in its sandbox. It can also return files such as images, CSV and Excel files, and PDFs, for example, a report of the users in your Jira instance.

## Where to find it

Click AI Agent in the side navigation, above _Help & support_. The agent panel opens over the page you are on, so you can keep working while the agent does.

A new task starts with _How can I help you?_ and a few example prompts. Click one to add it to the message box, change it if you like, and send it.

You can also start a task from the place where you need help:

<table class="table" id="topic-3573--en__generated-table-id-1"><caption></caption><colgroup><col><col><col></colgroup><thead class="thead"><tr class="row"><th class="entry" id="topic-3573--en__generated-table-id-1__entry__1">Where</th><th class="entry" id="topic-3573--en__generated-table-id-1__entry__2">What to click</th><th class="entry" id="topic-3573--en__generated-table-id-1__entry__3">What the agent does</th></tr></thead><tbody class="tbody"><tr class="row"><td class="entry" headers="topic-3573--en__generated-table-id-1__entry__1 topic-3573--en__generated-table-id-1__entry__2 topic-3573--en__generated-table-id-1__entry__3 " rowspan="1" colspan="1">A workspace's console, or the invocation logs</td><td class="entry" headers="topic-3573--en__generated-table-id-1__entry__1 topic-3573--en__generated-table-id-1__entry__2 topic-3573--en__generated-table-id-1__entry__3 " rowspan="1" colspan="1">The agent icon on an error row (<em class="ph i">Ask the agent to troubleshoot the error</em>), or <span class="ph uicontrol">Troubleshoot it with the agent</span> above the logs</td><td class="entry" headers="topic-3573--en__generated-table-id-1__entry__1 topic-3573--en__generated-table-id-1__entry__2 topic-3573--en__generated-table-id-1__entry__3 " rowspan="1" colspan="1">Troubleshoots the error</td></tr><tr class="row"><td class="entry" headers="topic-3573--en__generated-table-id-1__entry__1 topic-3573--en__generated-table-id-1__entry__2 topic-3573--en__generated-table-id-1__entry__3 " rowspan="1" colspan="1">A script failure email</td><td class="entry" headers="topic-3573--en__generated-table-id-1__entry__1 topic-3573--en__generated-table-id-1__entry__2 topic-3573--en__generated-table-id-1__entry__3 " rowspan="1" colspan="1">The troubleshooting link in the email</td><td class="entry" headers="topic-3573--en__generated-table-id-1__entry__1 topic-3573--en__generated-table-id-1__entry__2 topic-3573--en__generated-table-id-1__entry__3 " rowspan="1" colspan="1">Troubleshoots the failed invocation</td></tr><tr class="row"><td class="entry" headers="topic-3573--en__generated-table-id-1__entry__1 topic-3573--en__generated-table-id-1__entry__2 topic-3573--en__generated-table-id-1__entry__3 " rowspan="1" colspan="1">The script editor</td><td class="entry" headers="topic-3573--en__generated-table-id-1__entry__1 topic-3573--en__generated-table-id-1__entry__2 topic-3573--en__generated-table-id-1__entry__3 " rowspan="1" colspan="1"><span class="ph uicontrol">Ask the agent</span>, then <span class="ph uicontrol">Explain script</span> or <span class="ph uicontrol">Suggest improvements</span></td><td class="entry" headers="topic-3573--en__generated-table-id-1__entry__1 topic-3573--en__generated-table-id-1__entry__2 topic-3573--en__generated-table-id-1__entry__3 " rowspan="1" colspan="1">Explains or reviews the script</td></tr><tr class="row"><td class="entry" headers="topic-3573--en__generated-table-id-1__entry__1 topic-3573--en__generated-table-id-1__entry__2 topic-3573--en__generated-table-id-1__entry__3 " rowspan="1" colspan="1">The script editor, with some code selected</td><td class="entry" headers="topic-3573--en__generated-table-id-1__entry__1 topic-3573--en__generated-table-id-1__entry__2 topic-3573--en__generated-table-id-1__entry__3 " rowspan="1" colspan="1">Right-click, then <span class="ph uicontrol">Ask the agent to explain this code</span></td><td class="entry" headers="topic-3573--en__generated-table-id-1__entry__1 topic-3573--en__generated-table-id-1__entry__2 topic-3573--en__generated-table-id-1__entry__3 " rowspan="1" colspan="1">Explains the selected code</td></tr><tr class="row"><td class="entry" headers="topic-3573--en__generated-table-id-1__entry__1 topic-3573--en__generated-table-id-1__entry__2 topic-3573--en__generated-table-id-1__entry__3 " rowspan="1" colspan="1">A workspace's home page</td><td class="entry" headers="topic-3573--en__generated-table-id-1__entry__1 topic-3573--en__generated-table-id-1__entry__2 topic-3573--en__generated-table-id-1__entry__3 " rowspan="1" colspan="1">The message box under <em class="ph i">How can I help you?</em>, or the <em class="ph i">Explain</em>, <em class="ph i">Review</em> and <em class="ph i">Troubleshoot</em> tiles</td><td class="entry" headers="topic-3573--en__generated-table-id-1__entry__1 topic-3573--en__generated-table-id-1__entry__2 topic-3573--en__generated-table-id-1__entry__3 " rowspan="1" colspan="1">Explains, reviews or troubleshoots the workspace</td></tr><tr class="row"><td class="entry" headers="topic-3573--en__generated-table-id-1__entry__1 topic-3573--en__generated-table-id-1__entry__2 topic-3573--en__generated-table-id-1__entry__3 " rowspan="1" colspan="1">The dashboard</td><td class="entry" headers="topic-3573--en__generated-table-id-1__entry__1 topic-3573--en__generated-table-id-1__entry__2 topic-3573--en__generated-table-id-1__entry__3 " rowspan="1" colspan="1"><span class="ph uicontrol">Work with the agent</span></td><td class="entry" headers="topic-3573--en__generated-table-id-1__entry__1 topic-3573--en__generated-table-id-1__entry__2 topic-3573--en__generated-table-id-1__entry__3 " rowspan="1" colspan="1">Opens the agent panel</td></tr><tr class="row"><td class="entry" headers="topic-3573--en__generated-table-id-1__entry__1 topic-3573--en__generated-table-id-1__entry__2 topic-3573--en__generated-table-id-1__entry__3 ">A step in a workspace's <a class="xref" href="https://docs.adaptavist.com/src/latest/workspaces/visual-flow">visual flow</a></td><td class="entry" headers="topic-3573--en__generated-table-id-1__entry__1 topic-3573--en__generated-table-id-1__entry__2 topic-3573--en__generated-table-id-1__entry__3 ">Explain by AI agent</td><td class="entry" headers="topic-3573--en__generated-table-id-1__entry__1 topic-3573--en__generated-table-id-1__entry__2 topic-3573--en__generated-table-id-1__entry__3 ">Explains what the step does and how it fits into the workspace</td></tr><tr class="row"><td class="entry" headers="topic-3573--en__generated-table-id-1__entry__1 topic-3573--en__generated-table-id-1__entry__2 topic-3573--en__generated-table-id-1__entry__3 ">The Warnings tab of a visual flow</td><td class="entry" headers="topic-3573--en__generated-table-id-1__entry__1 topic-3573--en__generated-table-id-1__entry__2 topic-3573--en__generated-table-id-1__entry__3 ">Investigate by AI agent</td><td class="entry" headers="topic-3573--en__generated-table-id-1__entry__1 topic-3573--en__generated-table-id-1__entry__2 topic-3573--en__generated-table-id-1__entry__3 ">Looks into the warnings and proposes fixes before changing anything</td></tr></tbody></table>

The agent fills in the prompt for you to read and send. Before a shortcut sends your logs or code to the agent, it asks you to confirm. Logs can contain customer data and credentials.

When you troubleshoot an error this way, the task starts with the _Read-Only + Logs_ access policy, so the agent can read the logs it needs.

## What the embedded agent cannot reach

The embedded agent works only inside ScriptRunner Connect and its own sandbox. It has no access to your computer or to other systems you may have connected to an external agent through APIs, MCP servers, CLIs or skills. If the work needs any of them, use an external agent instead.

It also cannot use a web browser. Some steps need one, such as registering a webhook in another app or authorizing a connector. When the work leaves steps like these for you, the agent ends with a _Browser setup prompt_: a complete set of instructions with a copy button. Paste it into an external agent that can control a web browser, and that agent carries out the steps for you. You can also follow the steps yourself.

## How a task is completed

For work that changes something, a task usually goes like this:

1.  Pre-flight checks. The agent reads what it needs first: the workspace, its scripts, your connectors, and environments.
    
2.  Questions. It asks everything the work turns on in one round, such as which environments to use, what counts as production and how the result will be tested. Each question offers choices, often with one marked _Recommended_, and an _Other_ box for your own answer. Click Send answers, or type a reply instead.
    
3.  Plan. Before it changes or runs anything, the agent shows a plan: the changes it will make, grouped under _Add_, _Edit_, _Delete_ and _Run_, and the access each one still needs. Click Confirm, or click Decline and say what should change.
    
4.  Access request. If the task has limited access, the agent requests the permissions the plan needs in a single request. Confirming the plan does not approve any access; you approve or decline each permission in the request.
    
5.  The work. The agent reports progress as it goes, links to the workspace it is changing and locks it for editing while it works.
    
6.  Summary. The agent tells you what it did and what is left for you to do, and may include a coloured diagram of the changes. When it creates or updates a workspace, it also generates the workspace's visual flow, fixes the warnings it can, and ends the summary with a _[Visual flow](https://docs.adaptavist.com/src/latest/workspaces/visual-flow)_ link under the diagram. Open the link and check what the agent built or changed before you deploy a release. Warnings that it could not fix are listed under _Still to do_.
    
    When it is done, it sums up what changed, often with a diagram coloured 🟦 Existing · 🟩 Added · 🟧 Changed · 🟥 Removed. If any steps require a browser, they end with a browser setup prompt.
    

These steps can be repeated. When the work changes, the agent shows a new plan for you to confirm. When it finds it needs more access, it sends a new access request. Work that only reads, such as explaining a script or diagnosing a failure, has no plan.

Note: External agents don't produce a plan, a closing diagram or a browser setup prompt by default. With the sr-connect skill, they do generate the [visual flow](https://docs.adaptavist.com/src/latest/workspaces/visual-flow) and link to it, like the embedded agent.

## Notifications

We highly recommend turning on notifications. Click the bell in the agent panel's header (_Turn on notifications_) and allow notifications when the browser asks. You then get a notification, with a sound, when the agent has questions or a plan for you, asks for more access, finishes or fails, and when a visual flow generation you requested is ready. A visual flow that the agent generates is reported in the task instead.

You are not notified about a task you are already looking at.

Notifications come from the web app, so keep a tab with it open. The tab can be in the background or minimised. When every tab is closed, nothing arrives.

Note: Keep the tab open with notifications enabled when working with an external agent, too. When an external agent requests additional access, the web app notifies you immediately, even when the agent itself does not tell you.

If the bell's tooltip says _Notifications are blocked in your browser settings_, allow notifications for ScriptRunner Connect in the browser's site settings.

## Security

## The sandbox

Every task runs in its own isolated sandbox. The sandbox is temporary: it lasts at most an hour and keeps no files after it ends. It reaches the internet only through a controlled connection that never allows private or internal network addresses.

Every message you send uses its own new, temporary API. The key lasts at most an hour, and you can revoke it at any time.

## The Security menu

Click Security below the message box to view the task settings.

<table class="table" id="topic-3573--en__generated-table-id-2"><caption></caption><colgroup><col><col><col></colgroup><thead class="thead"><tr class="row"><th class="entry" id="topic-3573--en__generated-table-id-2__entry__1">Setting</th><th class="entry" id="topic-3573--en__generated-table-id-2__entry__2">Default</th><th class="entry" id="topic-3573--en__generated-table-id-2__entry__3">What it does</th></tr></thead><tbody class="tbody"><tr class="row"><td class="entry" headers="topic-3573--en__generated-table-id-2__entry__1 topic-3573--en__generated-table-id-2__entry__2 topic-3573--en__generated-table-id-2__entry__3 " rowspan="1" colspan="1"><span class="ph b">Internet access</span></td><td class="entry" headers="topic-3573--en__generated-table-id-2__entry__1 topic-3573--en__generated-table-id-2__entry__2 topic-3573--en__generated-table-id-2__entry__3 " rowspan="1" colspan="1">On</td><td class="entry" headers="topic-3573--en__generated-table-id-2__entry__1 topic-3573--en__generated-table-id-2__entry__2 topic-3573--en__generated-table-id-2__entry__3 " rowspan="1" colspan="1">When on, the agent can reach any public website, for example, to read documentation or call an API. When off, it can reach only ScriptRunner Connect and the NPM registry for installing packages. Scripts the agent deploys still run with full internet access. Changes apply from your next message.</td></tr><tr class="row"><td class="entry" headers="topic-3573--en__generated-table-id-2__entry__1 topic-3573--en__generated-table-id-2__entry__2 topic-3573--en__generated-table-id-2__entry__3 " rowspan="1" colspan="1"><span class="ph b">Allow triggering externally</span></td><td class="entry" headers="topic-3573--en__generated-table-id-2__entry__1 topic-3573--en__generated-table-id-2__entry__2 topic-3573--en__generated-table-id-2__entry__3 " rowspan="1" colspan="1">Off</td><td class="entry" headers="topic-3573--en__generated-table-id-2__entry__1 topic-3573--en__generated-table-id-2__entry__2 topic-3573--en__generated-table-id-2__entry__3 " rowspan="1" colspan="1">When on, the agent can call the URLs of your event listeners. The scripts those calls trigger are not held to your access policy's <a class="xref" href="https://docs.adaptavist.com/src/latest/rest-api/access-policies#access-policies--en__Runtime_access">runtime rules</a>. Changes apply from your next message.</td></tr><tr class="row"><td class="entry" headers="topic-3573--en__generated-table-id-2__entry__1 topic-3573--en__generated-table-id-2__entry__2 topic-3573--en__generated-table-id-2__entry__3 " rowspan="1" colspan="1"><span class="ph b">Agentic feedback</span></td><td class="entry" headers="topic-3573--en__generated-table-id-2__entry__1 topic-3573--en__generated-table-id-2__entry__2 topic-3573--en__generated-table-id-2__entry__3 " rowspan="1" colspan="1">On</td><td class="entry" headers="topic-3573--en__generated-table-id-2__entry__1 topic-3573--en__generated-table-id-2__entry__2 topic-3573--en__generated-table-id-2__entry__3 " rowspan="1" colspan="1">When on, the agent sends the ScriptRunner Connect team short notes on what worked and what got in its way. The notes omit personal data, business data, credentials and script content. Changes apply from your next message.</td></tr><tr class="row"><td class="entry" headers="topic-3573--en__generated-table-id-2__entry__1 topic-3573--en__generated-table-id-2__entry__2 topic-3573--en__generated-table-id-2__entry__3 " rowspan="1" colspan="1"><span class="ph b">Limited access</span></td><td class="entry" headers="topic-3573--en__generated-table-id-2__entry__1 topic-3573--en__generated-table-id-2__entry__2 topic-3573--en__generated-table-id-2__entry__3 " rowspan="1" colspan="1">On</td><td class="entry" headers="topic-3573--en__generated-table-id-2__entry__1 topic-3573--en__generated-table-id-2__entry__2 topic-3573--en__generated-table-id-2__entry__3 " rowspan="1" colspan="1">When on, the agent starts with the permissions defined in the <a class="xref" href="https://docs.adaptavist.com/src/latest/rest-api/access-policies#access-policies--en__Best_practices_access_policies">access policy</a> you choose and requests additional permissions as needed. When off, it can act as you in all your teams, with almost everything you can do yourself. It cannot change once the task has started.</td></tr><tr class="row"><td class="entry" headers="topic-3573--en__generated-table-id-2__entry__1 topic-3573--en__generated-table-id-2__entry__2 topic-3573--en__generated-table-id-2__entry__3 " rowspan="1" colspan="1"><span class="ph b">Access policy</span></td><td class="entry" headers="topic-3573--en__generated-table-id-2__entry__1 topic-3573--en__generated-table-id-2__entry__2 topic-3573--en__generated-table-id-2__entry__3 " rowspan="1" colspan="1">Read-Only</td><td class="entry" headers="topic-3573--en__generated-table-id-2__entry__1 topic-3573--en__generated-table-id-2__entry__2 topic-3573--en__generated-table-id-2__entry__3 " rowspan="1" colspan="1">The <a class="xref" href="https://docs.adaptavist.com/src/latest/rest-api/access-policies#access-policies--en__access-policies">access policy</a> a limited task starts with. Displayed only while <em class="ph i">Limited access</em> is on.</td></tr></tbody></table>

A new task starts with the settings you picked last time in the browser, except Allow triggering externally, which starts off in every task.

## Limited access

With [limited access](https://docs.adaptavist.com/src/latest/rest-api/access-policies#access-policies--en__The_built_in_policies), the agent starts with the permissions in an access policy, _Read-Only_ unless you pick another. When it needs more, it sends you an access request, and you approve or decline each permission. Approvals expire on their own and never change the policy.

Deleting a workspace, an environment, a connector, or a connector share is one of these permissions. With limited access, the agent can do it once you approve the permission. With unlimited access, the agent cannot do it at all: you do it yourself in the web app.

## More control

-   You confirm the plan before the agent changes or runs anything.
    
-   Stop ends the agent's run at any time. Requests that have not had an answer are withdrawn.
    
-   A Super Admin can turn the agent off for the whole team, in Team settings > AI agent, with Allow the AI agent in this team. Nobody in the team can then start or continue a task there. Tasks are saved and resumed when the agent is turned on again. The setting applies only to the embedded agent; it does not stop external agents from working in the team.
    
-   Team admins can see what the agent did. Changes the agent makes are recorded in the team's audit log, like your own. Team admins can read the audit log, but not your conversation with the agent.
    

## Choose a model

Click the model button below the message box, for example _Sonnet 5.5 · High_, to choose a model and how it reasons.  
  

<table class="table" id="topic-3573--en__generated-table-id-3"><caption></caption><colgroup><col><col><col></colgroup><thead class="thead"><tr class="row"><th class="entry" id="topic-3573--en__generated-table-id-3__entry__1">Model</th><th class="entry" id="topic-3573--en__generated-table-id-3__entry__2">Best for</th><th class="entry" id="topic-3573--en__generated-table-id-3__entry__3">Cost</th></tr></thead><tbody class="tbody"><tr class="row"><td class="entry" headers="topic-3573--en__generated-table-id-3__entry__1 topic-3573--en__generated-table-id-3__entry__2 topic-3573--en__generated-table-id-3__entry__3 " rowspan="1" colspan="1"><span class="ph b">Sonnet 5.5</span> (default)</td><td class="entry" headers="topic-3573--en__generated-table-id-3__entry__1 topic-3573--en__generated-table-id-3__entry__2 topic-3573--en__generated-table-id-3__entry__3 " rowspan="1" colspan="1">Most work</td><td class="entry" headers="topic-3573--en__generated-table-id-3__entry__1 topic-3573--en__generated-table-id-3__entry__2 topic-3573--en__generated-table-id-3__entry__3 " rowspan="1" colspan="1"></td></tr><tr class="row"><td class="entry" headers="topic-3573--en__generated-table-id-3__entry__1 topic-3573--en__generated-table-id-3__entry__2 topic-3573--en__generated-table-id-3__entry__3 " rowspan="1" colspan="1"><span class="ph b">Haiku 5.5</span></td><td class="entry" headers="topic-3573--en__generated-table-id-3__entry__1 topic-3573--en__generated-table-id-3__entry__2 topic-3573--en__generated-table-id-3__entry__3 " rowspan="1" colspan="1">Questions and work of low complexity</td><td class="entry" headers="topic-3573--en__generated-table-id-3__entry__1 topic-3573--en__generated-table-id-3__entry__2 topic-3573--en__generated-table-id-3__entry__3 " rowspan="1" colspan="1">Ultra cheap</td></tr><tr class="row"><td class="entry" headers="topic-3573--en__generated-table-id-3__entry__1 topic-3573--en__generated-table-id-3__entry__2 topic-3573--en__generated-table-id-3__entry__3 " rowspan="1" colspan="1"><span class="ph b">Opus 5.5</span></td><td class="entry" headers="topic-3573--en__generated-table-id-3__entry__1 topic-3573--en__generated-table-id-3__entry__2 topic-3573--en__generated-table-id-3__entry__3 " rowspan="1" colspan="1">Work of high complexity</td><td class="entry" headers="topic-3573--en__generated-table-id-3__entry__1 topic-3573--en__generated-table-id-3__entry__2 topic-3573--en__generated-table-id-3__entry__3 " rowspan="1" colspan="1">Twice the cost of Sonnet</td></tr></tbody></table>

Sonnet is the best model for most work, which is why it is the default. Haiku can be surprisingly capable for simpler tasks, especially when cost matters. Keep Opus for the hardest work.

Reasoning can be set to _High_ (the default), _Medium_ or _Low_. Higher reasoning takes longer and costs more, but usually yields better results on complex work.  
  

The browser remembers your choice for new tasks. When you reopen a task, you're shown which model you last used.

Warning: Changing the model or reasoning on a task that is already going makes the next reply re-read the whole conversation, which costs more. Choose before you send the first message where you can.

## Usage allowance

Each team has a modest daily and weekly allowance for the embedded agent, shared among all team members. How much it is depends on the team's plan.

To see how much is left, open either:

-   The model button below the message box, which shows _Usage_ at the top
    
-   The menu that opens when you click your name in the side navigation, which shows _Agent usage_.
    

Each limit is displayed as a percentage used, with when it resets. The daily allowance resets at midnight UTC, and the weekly allowance resets on Monday at midnight UTC, both displayed in your own time. When the weekly allowance is used up, the daily reset restores nothing until the weekly one resets.

When your team runs out, the panel says _Agent budget used_ and you cannot send messages until the allowance resets. You can carry on with your own external agent in the meantime.

## Diagrams and charts

The agent can draw diagrams and charts in its replies, and you can ask for one explicitly, for example, "draw a sequence diagram of the sync between Jira and Slack" or "chart the failed invocations per day this week". It uses:

<table class="table" id="topic-3573--en__generated-table-id-4"><caption></caption><colgroup><col><col></colgroup><thead class="thead"><tr class="row"><th class="entry" id="topic-3573--en__generated-table-id-4__entry__1">Tool</th><th class="entry" id="topic-3573--en__generated-table-id-4__entry__2">Usage</th></tr></thead><tbody class="tbody"><tr class="row"><td class="entry" headers="topic-3573--en__generated-table-id-4__entry__1 topic-3573--en__generated-table-id-4__entry__2 " rowspan="1" colspan="1"><a class="xref j-external-link" href="https://mermaid.js.org/" target="_blank">Mermaid</a></td><td class="entry" headers="topic-3573--en__generated-table-id-4__entry__1 topic-3573--en__generated-table-id-4__entry__2 " rowspan="1" colspan="1">Flowcharts, sequence diagrams, state and entity relationship diagrams, timelines</td></tr><tr class="row"><td class="entry" headers="topic-3573--en__generated-table-id-4__entry__1 topic-3573--en__generated-table-id-4__entry__2 " rowspan="1" colspan="1"><a class="xref j-external-link" href="https://vega.github.io/vega-lite/" target="_blank">Vega-Lite</a></td><td class="entry" headers="topic-3573--en__generated-table-id-4__entry__1 topic-3573--en__generated-table-id-4__entry__2 " rowspan="1" colspan="1">Bar, line, area and scatter charts, and heatmaps</td></tr><tr class="row"><td class="entry" headers="topic-3573--en__generated-table-id-4__entry__1 topic-3573--en__generated-table-id-4__entry__2 " rowspan="1" colspan="1"><a class="xref j-external-link" href="https://developer.mozilla.org/en-US/docs/Web/SVG" target="_blank">SVG</a></td><td class="entry" headers="topic-3573--en__generated-table-id-4__entry__1 topic-3573--en__generated-table-id-4__entry__2 " rowspan="1" colspan="1">Simple custom images</td></tr><tr class="row"><td class="entry" headers="topic-3573--en__generated-table-id-4__entry__1 topic-3573--en__generated-table-id-4__entry__2 " rowspan="1" colspan="1"><a class="xref j-external-link" href="https://matplotlib.org/" target="_blank">Matplotlib</a></td><td class="entry" headers="topic-3573--en__generated-table-id-4__entry__1 topic-3573--en__generated-table-id-4__entry__2 " rowspan="1" colspan="1">Charts from data, delivered as image files</td></tr></tbody></table>

Note: The diagram in the agent's summary is drawn by the agent, to show what it added, changed or removed. The visual flow it links to is different: it's worked out from the saved code, without AI, and shows everything the workspace's scripts do, except in a few cases listed under the [visual flow's limitations](https://docs.adaptavist.com/src/latest/workspaces/visual-flow#visual-flow--en__visual-flow-limitations).

Each diagram or chart in a reply has Download SVG, Download PNG, Copy source, and Expand options, which open the item in a larger view with zoom controls.

## Work in the panel

## Size and layout

-   Drag the panel's header to move it, and drag an edge or a corner to resize it.
    
-   Click Expand to full screen to fill the browser window.
    
-   Make the panel wider to see your tasks beside the conversation. Once the panel is 1,200 pixels wide, or in full screen, the task list appears next to the conversation, so you don't have to switch back and forth.
    
-   The browser remembers the panel's size and position.
    

## Your tasks

-   New task starts a new task. The task list shows your own tasks in the selected team, newest first, each with its status: _Running_, _Awaiting reply_, _Awaiting approval_, _Timed out_ or _Failed_.
    
-   Each task's menu has Rename, Copy chat ID and Delete.
    
-   Tasks are private to you and belong to the team they were started in. The list displays only the tasks for the team selected in the top-left corner, so changing the team updates the list. The agent remembers nothing from one task to the next, so start a new task with everything it needs to know.
    
-   While the agent is working, the send button becomes Stop.
    
-   Hover over a message to copy it. Code blocks have their own Copy code button.
    
-   Links to pages in ScriptRunner Connect open in the web app without closing the panel.
    

## Rating and feedback

When the agent finishes, you can rate the task and click Send feedback to tell the ScriptRunner Connect team what went well or what went wrong. You can change your rating later, send more feedback, and turn Share chat on or off at any time.

In the feedback dialog, you can turn on Share chat. The ScriptRunner Connect team can then read the whole task: everything so far and everything added later, until you send feedback with sharing turned off. We recommend sharing whenever you want the team to look into what happened, especially when the agent did something you did not ask for or expect: the conversation is the evidence. Tasks can hold personal or sensitive data, so share only if you're comfortable with that.

## Best practices

-   Start with limited access, on Read-Only.
    
    -   Approve more as the work shows what the agent needs.
        
-   Turn on notifications.
    
    -   And keep a tab with the web app open.
        
-   Answer the first round of questions fully.
    
    -   The answers shape everything the agent does next.
        
-   Read the plan before you confirm it.
    
    -   And read red permissions and production environments carefully in access requests.
        
-   Keep Allow triggering externally off
    
    -   Unless the agent needs it to check its work.
        
-   Turn internet access off when the work does not need it.
    
    -   If you are not sure, leave it on: the agent uses it to look things up.
        
-   Use Haiku for questions.
    
    -   And Sonnet for building and troubleshooting.
        
-   Split large work across tasks.
    
    -   A run lasts at most an hour. If it times out, send a message asking the agent to continue.
        
-   Check the agent's work before production. It can make mistakes.
    
    -   Open the [Visual flow](https://docs.adaptavist.com/src/latest/workspaces/visual-flow) link in its summary to see what the workspace now does, and read the warnings.
        

## Availability

The embedded agent may not be available in every deployment. In private cloud (isolated) hosting, it is not available by default and can be enabled on request using your own Anthropic API key.

## Limits

| Limit | Value |
| --- | --- |
| How long the agent works on one message | 1 hour. After _Timed out_, send a message asking it to continue. |
| Tasks running at once | 3 per user |
| Message length | 40,000 characters |
| Files attached to a message | 10 files and 30 MB in total. Images up to 5 MB each, other files up to 10 MB each. |
| Files the agent sends back | 20 files and 25 MB for each message you send, 5 MB each |
| Unused tasks | Deleted after 180 days without activity |
| Usage allowance | Resets daily at midnight UTC, and weekly on Monday at midnight UTC |
