# Connect AI Agents to ScriptRunner for Jira Cloud with MCP

- Platform: cloud
- Space: SR4JC
- Hierarchy: Features > AI and Agents
- Doc ID: doc-sr4jc-addbc00b-dbd9-4f2a-91dc-751977a0364d-1866b0abe1acab81
- Source: https://docs.adaptavist.com/sr4jc/latest/features/ai-and-agents/connect-ai-agents-to-scriptrunner-for-jira-cloud-with-mcp

Connect AI agents such as Claude Code, Codex and ChatGPT to ScriptRunner for Jira Cloud using the Model Context Protocol (MCP).

Note: MCP support is brand new, and we're still shaping it. Things may change as we develop. Changes made through MCP don't show up in the ScriptRunner audit log yet.

Want your AI agent to help with ScriptRunner? With our [Model Context Protocol (MCP)](https://modelcontextprotocol.io/) server, agents like Claude Code, Codex, and ChatGPT can work with ScriptRunner for Jira Cloud on your behalf. They can look through your setup, build and update configuration for you, and help work out why a script didn't behave.

Setup takes a few minutes. You'll need to be a Jira administrator, and an organisation or site admin needs to switch MCP tools on once for your site.

## Step 1: Turn on MCP tools

MCP tools are off by default, so an admin needs to switch them on first:

1.  Go to [https://admin.atlassian.com](https://admin.atlassian.com/) and pick your site once signed in.
    
2.  Select Apps > Sites and pick your site.
    
3.  Select Connected apps.
    
4.  Find ScriptRunner for Jira, and then select View app details.
    
5.  On the Details tab, scroll to the bottom and under Expose tools to MCP-compatible apps, select Enable tools.
    

Tip: Changed your mind? You can switch it off any time with Disable tools on the same page.

## Step 2: Connect your agent

1.  Copy the MCP server URL: [https://mcp.atlassian.com/forge/1dd33d5a-4685-4816-9851-1b36b2fb3dbd](https://mcp.atlassian.com/forge/1dd33d5a-4685-4816-9851-1b36b2fb3dbd)
    
2.  Optional: Connect Claude Code.
    
    1.  Run this command: 
        
        ```
        claude mcp add --transport http scriptrunner https://mcp.atlassian.com/forge/1dd33d5a-4685-4816-9851-1b36b2fb3dbd
        ```
        
    2.  Run `/mcp` and select Authenticate.
        
    
3.  Optional: Connect Codex.
    
    1.  Run these two commands:
        
        ```
        codex mcp add scriptrunner --url https://mcp.atlassian.com/forge/1dd33d5a-4685-4816-9851-1b36b2fb3dbd
        codex mcp login scriptrunner
        ```
        
    
4.  Prompted by your browser, sign in with your Atlassian account.
    
5.  Pick your site, and then select Accept.
    

## Install ScriptRunner skills

CAUTION: We really recommend this step. The MCP server lets your agent take action, but it doesn't teach it ScriptRunner. Our skills give your agent the documentation, platform know-how, and example scripts it needs to write scripts that actually work.

```
npx skills add adaptavist/scriptrunner-skills
```

You can find out more about each skill on [skills.sh](https://skills.sh/adaptavist/scriptrunner-skills).

## What your agent can do

You won't need to call these tools yourself. Your agent picks the right ones for what you ask. In the table, CHANGES DATA marks tools that create, update or delete things on your site, and RUNS A SCRIPT marks tools that run code. 

<table class="table" id="concept-7489--en__generated-table-id-1"><caption></caption><colgroup><col><col></colgroup><thead class="thead"><tr class="row"><th class="entry" id="concept-7489--en__generated-table-id-1__entry__1">Tool</th><th class="entry" id="concept-7489--en__generated-table-id-1__entry__2">What it does</th></tr></thead><tbody class="tbody"><tr class="row"><td class="entry" headers="concept-7489--en__generated-table-id-1__entry__1 concept-7489--en__generated-table-id-1__entry__2 " rowspan="1" colspan="1"><code class="ph codeph">sr-explore-config</code></td><td class="entry" headers="concept-7489--en__generated-table-id-1__entry__1 concept-7489--en__generated-table-id-1__entry__2 " rowspan="1" colspan="1">Lets your agent read your existing listeners, scheduled jobs, escalation services, scripted fields, and behaviours, so it understands your current setup.</td></tr><tr class="row"><td class="entry" headers="concept-7489--en__generated-table-id-1__entry__1 concept-7489--en__generated-table-id-1__entry__2 " rowspan="1" colspan="1"><code class="ph codeph">sr-apply-config-change</code> <var class="keyword varname">CHANGES DATA</var></td><td class="entry" headers="concept-7489--en__generated-table-id-1__entry__1 concept-7489--en__generated-table-id-1__entry__2 " rowspan="1" colspan="1">Creates, updates, or deletes any of those.</td></tr><tr class="row"><td class="entry" headers="concept-7489--en__generated-table-id-1__entry__1 concept-7489--en__generated-table-id-1__entry__2 " rowspan="1" colspan="1"><code class="ph codeph">sr-list-behaviour-fields</code></td><td class="entry" headers="concept-7489--en__generated-table-id-1__entry__1 concept-7489--en__generated-table-id-1__entry__2 " rowspan="1" colspan="1">Finds the create screen fields a behaviour can use.</td></tr><tr class="row"><td class="entry" headers="concept-7489--en__generated-table-id-1__entry__1 concept-7489--en__generated-table-id-1__entry__2 " rowspan="1" colspan="1"><code class="ph codeph">sr-list-script-variables</code></td><td class="entry" headers="concept-7489--en__generated-table-id-1__entry__1 concept-7489--en__generated-table-id-1__entry__2 " rowspan="1" colspan="1">Lets your agent see which Script Variables you have, so it can use them in scripts. It only ever sees the names. Values are never returned to the agent, so your secrets stay safe.</td></tr><tr class="row"><td class="entry" headers="concept-7489--en__generated-table-id-1__entry__1 concept-7489--en__generated-table-id-1__entry__2 " rowspan="1" colspan="1"><code class="ph codeph">sr-test-scripted-field</code> <var class="keyword varname">RUNS A SCRIPT</var></td><td class="entry" headers="concept-7489--en__generated-table-id-1__entry__1 concept-7489--en__generated-table-id-1__entry__2 " rowspan="1" colspan="1">Tries out a scripted field on one work item, without saving anything.</td></tr><tr class="row"><td class="entry" headers="concept-7489--en__generated-table-id-1__entry__1 concept-7489--en__generated-table-id-1__entry__2 " rowspan="1" colspan="1"><code class="ph codeph">sr-explore-workflows</code></td><td class="entry" headers="concept-7489--en__generated-table-id-1__entry__1 concept-7489--en__generated-table-id-1__entry__2 " rowspan="1" colspan="1">Lets your agent read your existing workflows, including their ScriptRunner conditions, validators, and post functions.</td></tr><tr class="row"><td class="entry" headers="concept-7489--en__generated-table-id-1__entry__1 concept-7489--en__generated-table-id-1__entry__2 " rowspan="1" colspan="1"><code class="ph codeph">sr-change-workflow-rule</code> <var class="keyword varname">CHANGES DATA</var></td><td class="entry" headers="concept-7489--en__generated-table-id-1__entry__1 concept-7489--en__generated-table-id-1__entry__2 " rowspan="1" colspan="1">Creates, updates, enables, disables, moves, or deletes a workflow rule.</td></tr><tr class="row"><td class="entry" headers="concept-7489--en__generated-table-id-1__entry__1 concept-7489--en__generated-table-id-1__entry__2 " rowspan="1" colspan="1"><code class="ph codeph">sr-explore-script-manager</code></td><td class="entry" headers="concept-7489--en__generated-table-id-1__entry__1 concept-7489--en__generated-table-id-1__entry__2 " rowspan="1" colspan="1">Browses and reads your Script Manager files.</td></tr><tr class="row"><td class="entry" headers="concept-7489--en__generated-table-id-1__entry__1 concept-7489--en__generated-table-id-1__entry__2 " rowspan="1" colspan="1"><code class="ph codeph">sr-change-script-manager-file</code> <var class="keyword varname">CHANGES DATA</var></td><td class="entry" headers="concept-7489--en__generated-table-id-1__entry__1 concept-7489--en__generated-table-id-1__entry__2 " rowspan="1" colspan="1">Creates, updates, moves, renames, or deletes a Script Manager file.</td></tr><tr class="row"><td class="entry" headers="concept-7489--en__generated-table-id-1__entry__1 concept-7489--en__generated-table-id-1__entry__2 " rowspan="1" colspan="1"><code class="ph codeph">sr-list-executions</code></td><td class="entry" headers="concept-7489--en__generated-table-id-1__entry__1 concept-7489--en__generated-table-id-1__entry__2 " rowspan="1" colspan="1">Shows recent runs of a configuration.</td></tr><tr class="row"><td class="entry" headers="concept-7489--en__generated-table-id-1__entry__1 concept-7489--en__generated-table-id-1__entry__2 " rowspan="1" colspan="1"><code class="ph codeph">sr-read-execution-logs</code></td><td class="entry" headers="concept-7489--en__generated-table-id-1__entry__1 concept-7489--en__generated-table-id-1__entry__2 " rowspan="1" colspan="1">Reads the logs from a run, handy for figuring out what went wrong.</td></tr><tr class="row"><td class="entry" headers="concept-7489--en__generated-table-id-1__entry__1 concept-7489--en__generated-table-id-1__entry__2 " rowspan="1" colspan="1"><code class="ph codeph">sr-search-hapi</code>, <code class="ph codeph">sr-get-hapi</code></td><td class="entry" headers="concept-7489--en__generated-table-id-1__entry__1 concept-7489--en__generated-table-id-1__entry__2 " rowspan="1" colspan="1">Look things up in the ScriptRunner HAPI API.</td></tr><tr class="row"><td class="entry" headers="concept-7489--en__generated-table-id-1__entry__1 concept-7489--en__generated-table-id-1__entry__2 " rowspan="1" colspan="1"><code class="ph codeph">sr-explore-rest-api</code></td><td class="entry" headers="concept-7489--en__generated-table-id-1__entry__1 concept-7489--en__generated-table-id-1__entry__2 " rowspan="1" colspan="1">Looks things up in the Atlassian REST API specifications.</td></tr><tr class="row"><td class="entry" headers="concept-7489--en__generated-table-id-1__entry__1 concept-7489--en__generated-table-id-1__entry__2 " rowspan="1" colspan="1"><code class="ph codeph">sr-check-agent-access</code></td><td class="entry" headers="concept-7489--en__generated-table-id-1__entry__1 concept-7489--en__generated-table-id-1__entry__2 " rowspan="1" colspan="1">Helps sort out access problems.</td></tr></tbody></table>

## Good to know

-   Your agent works as you, with your Jira permissions, and its changes go live straight away. Trying something new? A test site is a great place to start.
    
-   MCP changes don't appear in the ScriptRunner audit log yet, so use your agent's history to see what it changed.
    
-   If your agent connects but can't find any ScriptRunner tools, or says an admin must enable external MCP access for this app, MCP tools haven't been turned on for your site yet. Ask an admin to complete Step 1.
    
-   For now, MCP is available for ScriptRunner for Jira Cloud only. Script fragments, the Script Console, and built-in scripts aren't supported yet.
    

Want to dig deeper? Check out the [MCP specification](https://modelcontextprotocol.io/specification/latest) and the [ScriptRunner skills](https://www.skills.sh/adaptavist/scriptrunner-skills).
