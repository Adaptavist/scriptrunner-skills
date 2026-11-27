# External Coding

- Platform: connect
- Space: SRC
- Hierarchy: n/a
- Doc ID: doc-src-80bbee24-87b4-4fd9-927e-dcc688014ea7-4abdbf567fa0e70f
- Source: https://docs.adaptavist.com/src/latest/external-coding

External coding lets you edit ScriptRunner Connect scripts locally in your preferred integrated development environment (IDE) and use your existing local development workflows.

ScriptRunner Connect offers two options for external coding:

-   [CLI (Command Line Interface)](../../external-coding/cli-command-line-interface.md): Recommended for local editing, workspace management, and local script triggering.
-   [SFTP (Remote Workspace)](../../external-coding/sftp-remote-workspace.md): Legacy interface for file-based synchronization.

The CLI provides expanded capabilities over SFTP, including full workspace lifecycle management and terminal-based script execution.

Coupled with the [agent skill](https://www.skills.sh/adaptavist/scriptrunner-skills/sr-connect), you can let your agent work autonomously in ScriptRunner Connect. Whether you are using terminal-based agents or GUI-based ones, you can also perform the action in ScriptRunner Connect via the (integrated) terminal without having to switch away from your agent interface. When using terminal-based agents, such as Codex, Claude Code, OpenCode, Pi or others, we recommend using [herdr](https://herdr.dev/) as an agent-aware multiplexer.

Use the following table to compare the available external coding interfaces:

| Capability | CLI | SFTP (Remote Workspace) |
| --- | --- | --- |
| Can edit scripts locally |  |  |
| Can edit README locally |  |  |
| Can edit test event payloads locally |  |  |
| Can create a workspace |  |  |
| Can auto-push saved files |  |   <br>  <br>(with correct IDE + extension setup) |
| Can take the workspace lock for you while editing externally |  |  |
| Can trigger scripts externally |  |  |
| Can stream triggered script logs back to the terminal |  |  |
| Can perform other operations in ScriptRunner Connect |  |  |
| Available on the Free plan |  |  |
| Push semantics | Synchronous (blocking) | Asynchronous (non-blocking) |

Note: The CLI does not currently support automatic push on file save. For synchronous synchronization, use the `lw push` command.

## Workspace file structure

The local file system structure remains largely identical to the SFTP-based file system. When you clone a workspace with the CLI, the local workspace includes a few specific additions compared with the SFTP structure:

-   `test-payloads/`: Event listener test payloads for local testing.
    
-   `workspace.json`: Metadata configuration used by the CLI clone and push commands.
    
-   `ev-params.ts`: Parameter definitions for event handling.
    

Tip: For AI agent workflows, configure agent instructions with the [sr-connect skill](https://www.skills.sh/adaptavist/scriptrunner-skills/sr-connect).

## Local editing workflow

Follow these steps to edit and test your workspace locally:

1.  Clone the workspace: Run `lw clone` to download the workspace files to your local environment.
    
2.  Edit files: Make changes to your scripts and test payloads using your local IDE.
    
3.  Push changes: Run `lw push` to sync local changes back to ScriptRunner Connect.
    
4.  Trigger scripts: Run `script trigger` to execute the script from your terminal and stream logs directly to the console.
    

Tip: To submit feedback or feature requests from your terminal, run the `feedback post` command.
