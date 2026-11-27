# CLI (Command Line Interface)

- Platform: connect
- Space: SRC
- Hierarchy: External Coding
- Doc ID: doc-src-819f3a15-3a22-4983-a22e-419b72420505-04b2f6261cc55836
- Source: https://docs.adaptavist.com/src/latest/external-coding/cli-command-line-interface

The CLI (Command Line Interface) allows you to perform most actions from your terminal that you would otherwise perform via the web UI.

The main benefit of using the CLI is the local workspace copy. You can clone a workspace to a folder on your machine, edit scripts in your own IDE with full type checking, manage them in Git, and push changes back. You can then execute a script and watch console output stream directly into your terminal, all without leaving your local development environment.

You can also interact with ScriptRunner Connect through an AI assistant over the CLI using the [sr-connect skill](https://www.skills.sh/adaptavist/scriptrunner-skills/sr-connect).

## Installation

Prerequisite: Install [Node.js](https://nodejs.org/) 22 or newer.

To run the CLI without a global installation:

```
npx @sr-connect/cli
```

To install the CLI globally for everyday use (recommended):

```
npm i -g @sr-connect/cli
sr-connect
```

The rest of this guide uses the sr-connect command.

## Get started

1.  Log in to authenticate your session: `sr-connect auth login`
    
    The command prompts for the instance to use, your email address, and your API key. The key is securely stored in your operating system's credential store.
    
2.  Run commands interactively and respond to prompts for any required parameters:
    
    ```
    sr-connect team list
    sr-connect workspace list
    sr-connect script list
    ```
    
    Without explicit flags, `sr-connect script list` prompts you to choose a team, workspace, and environment. The CLI then offers to save these choices as session defaults for your current terminal window. For more details, see [Session defaults](https://www.npmjs.com/package/@sr-connect/cli#session-defaults).
    
3.  Display accepted flags for any command by passing `-h` or `--help`. For a detailed description of command behaviour and parameters, pass `--explain`:
    
    ```
    sr-connect script create -h
    sr-connect script create --explain
    ```
    

## Command structure

Commands consist of a group and a verb (for example, in `script get`, `script` is the group and `get` is the verb). Run a group name on its own to list its verbs, or run `sr-connect` to list all available groups.

| Verb | Description |
| --- | --- |
| `list` | Displays all items of that kind |
| `get` | Displays a single item |
| `create` | Creates a new item |
| `update` | Modifies an existing item |
| `delete` | Deletes one item after a confirmation |

### Group exceptions and aliases

-   Exceptions:
    
    -   The `package` group uses `add` and `remove`.
        
    -   The `log` group uses operational verbs such as `list-console-logs` and `get-invocation-payload`.
        
    -   The `script` group includes execution verbs: `trigger`, `replay-invocation`, and `abort-invocation`.
        
    -   Read-only groups (`app`, `team`, `template`) only support query verbs.
        
-   Short aliases: Use `lw` for `local-workspace`, `el` for `event-listener`, and `env` for `environment`.
    

For a full list of commands and concepts, see [Commands](https://www.npmjs.com/package/@sr-connect/cli#commands) and [Concepts](https://www.npmjs.com/package/@sr-connect/cli#concepts).

## Work from a local copy of a workspace

Clone a workspace into a local directory:

```
sr-connect local-workspace clone my-workspace
```

Select the team, workspace, and environment when prompted. Specify a target directory name, or omit it to clone into the current working directory. The CLI creates a Node TypeScript project:

```
my-workspace/
    scripts/                                one .ts file per script
        api/                                generated code for your API connections, do not edit
            <API connection path>/
                index.ts
    test-payloads/                          your event listeners' test payloads, as JSON files
        <App→Event (listenerId)>/
            <payload name>.json
    node/                                   API mocks and Jest setup for local tests
        tests/                              your own tests go here
        apiRegistry.ts
        runtimeMocks.ts
        global.d.ts
        jest.config.ts
        tsconfig.json
    .vscode/
        extensions.json
    ev-params.ts                            types for your environment parameters, never their values
    README.md                               the workspace README
    package.json                            PS! do not add dependencies directly, use `sr-connect package add` instead, adding dev dependencies locally is safe
    tsconfig.json
    tsconfig.base.json
    eslint.config.js
    .prettierrc
    .gitignore
    pnpm-workspace.yaml
    workspace.json                          workspace metadata file, do not edit
```

Manage dependencies and test scripts using standard package manager workflows:

```
cd my-workspace
pnpm install      # installs the dependencies
pnpm typecheck    # checks your scripts and tests with the TypeScript compiler
pnpm test         # runs your Jest tests in node/tests against API and runtime mocks
```

Note: Recommended tool: While you can use `npm` or `yarn`, we strongly recommend pnpm v10 or newer. It blocks untrusted dependency lifecycle scripts by default, helping to protect your local workspace from supply-chain risks.

Cloning performs a read-only operation and does not alter the server workspace. Sensitive parameter values and passwords are never written to disk, making the repository safe to commit.

When cloning into an existing local workspace directory, the CLI prompts before overwriting files. The following customisable configuration files and directories are preserved:

-   Tooling configurations: `tsconfig.json`, `tsconfig.base.json`, `eslint.config.js`, .`prettierrc`, `.gitignore`, `pnpm-workspace.yaml`, and `.vscode/extensions.json`.
    
-   Local testing files in `node/`: `apiRegistry.ts`, `runtimeMocks.ts`, `global.d.ts`, `jest.config.ts`, and `tsconfig.json`.
    
-   Custom `package.json` entries (except the managed `dependencies` block). Always use `sr-connect package add` to register server dependencies. Adding packages under `devDependencies` is safe and preserved across clones.
    

For more details, see [Work from a local copy](https://www.npmjs.com/package/@sr-connect/cli#work-from-a-local-copy).

## Local workspace scoping

Commands executed inside a cloned workspace directory automatically target the team, workspace, and environment declared in `workspace.json` (do not edit this file). The CLI displays the active scope and requests confirmation.

Direct CLI changes affecting local files (such as saving a script or updating the README) automatically sync to your local directory without requiring an explicit re-clone. For more details, see [Local sync](https://www.npmjs.com/package/@sr-connect/cli#local-sync).

### Push your changes to the server

To push local scripts, test payloads, and the README to the server:

```
sr-connect local-workspace push
```

The CLI outlines the changes before uploading and reports any TypeScript compiler errors found afterwards. TypeScript errors do not abort the push unless a bundling failure prevents the workspace from running.

Considerations when pushing:

-   Pushes are only accepted by environments running the `HEAD` version. Released (non-HEAD) environments reject updates.
    
-   Deleting a local script file does not delete the script on the server. Delete scripts using `sr-connect script delete` (recommended) or pass the `--delete-missing` flag during push.
    
-   Renaming files locally will update server scripts after a push; however, renaming explicitly via `sr-connect script update` is recommended.
    
-   For very large workspaces prone to network timeouts, pass the `--async` flag.
    
-   Pushing overwrites the server copy. If changes were made concurrently via the web UI, clone to a fresh directory and inspect differences before pushing.
    

### Development loop example

```
sr-connect local-workspace clone     # once
# edit scripts in your IDE
pnpm typecheck && pnpm test          # fast, local
sr-connect local-workspace push      # push changes to server
sr-connect script trigger            # run it and watch the output
```

### Editing lock

Write operations (including `push`) acquire the workspace editing lock. If another user holds the lock, the CLI prompts to cancel, take over the lock, or proceed without it.

Tip: Common editing courtesy: Taking over a lock is instantaneous and ends the other person's active browser session. Give your teammate a quick heads-up before taking control so they can save their progress.

Editing locks expire automatically after 15 minutes of inactivity. Release an active lock immediately when finished by running:

```
sr-connect workspace-lock release
```

For more details, see [Workspace locks](https://www.npmjs.com/package/@sr-connect/cli#workspace-locks).

## Trigger a script and stream its logs

Scripts execute server-side against the saved workspace state. Ensure local changes are pushed before triggering.

```
sr-connect script trigger
```

The interactive prompt guides you through the following:

1.  Selecting the script to execute.
    
2.  Configuring a test event payload (entered in an editor, loaded from a file, or selected from the `test-payloads/` directory).
    
3.  Choosing whether to wait for the return value (waiting limits execution time to a 20-second threshold).
    
4.  Enabling live console streaming.
    

When console streaming is active, `console.log`, warning, and error outputs print to your terminal in real time. The CLI exits with a corresponding exit code upon failure, making it suitable for CI/CD pipelines and automated scripts.

### Log streaming notes

-   Streamed entries may occasionally arrive slightly out of sequence. To inspect exact ordering, fetch stored logs using `sr-connect log list-console-logs`.
    
-   Pressing Ctrl+C terminates the terminal log stream, not the remote script execution.
    

To inspect logs from previous executions, run `sr-connect log list-invocation-logs`, followed by `sr-connect log list-console-logs` or `sr-connect log list-http-logs`. To replay an invocation, use `sr-connect script replay-invocation`. To abort an active invocation, `run sr-connect script abort-invocation`.

For more details, see [Output](https://www.npmjs.com/package/@sr-connect/cli#output) and [Exit codes](https://www.npmjs.com/package/@sr-connect/cli#exit-codes).

## The cli group and diagnostics

The `cli` command group provides management and diagnostic utilities for the CLI tool itself:

| Command | Description |
| --- | --- |
| `cli get-readme` | Outputs the offline reference documentation |
| `cli check-updates` | Checks for newer CLI package versions |
| `cli settings` | Configures optional features, including API recording, workspace locking, local file synchronisation, crash reports, and agent feedback |
| `cli set-session` | Manually sets session defaults (team, workspace, environment) |
| `cli clear-session` | Clears stored session defaults |
| `cli list-api-logs` | Displays locally recorded CLI API requests |
| `cli list-crash-reports` | Displays saved diagnostic crash reports |

-   Session defaults:
    
    -   Selected team, workspace, and environment parameters persist in the active terminal window for 12 hours. Clear them anytime with `sr-connect cli clear-session`.
        
-   Local workspace precedence:
    
    -   Inside a cloned directory, `workspace.json` settings override session defaults. Explicit command flags and environment variables take precedence over both.
        
-   API call recording:
    
    -   The CLI logs outbound API calls locally for seven days with sensitive credentials redacted. View logs using `sr-connect cli list-api-logs`.
        
-   Crash reports:
    
    -   If an internal CLI error occurs, diagnostic reports are stored locally. Inspect them with `sr-connect cli list-crash-reports` before submitting.
        
-   Settings:
    
    -   Run `sr-connect cli settings` to toggle API recording, workspace locking, local file synchronisation, crash reports, and agent feedback.
        
-   Exit codes:
    
    -   `0` (Success), `1` (Failure), `2` (Usage error), `3` (Authentication error), `4` (Resource not found), and `130` (Cancelled).
        

## Related information

-   Full reference documentation: [ScriptRunner Connect CLI on npm](https://www.npmjs.com/package/@sr-connect/cli), including [Global switches](https://www.npmjs.com/package/@sr-connect/cli#global-switches) and [How commands work](https://www.npmjs.com/package/@sr-connect/cli#how-commands-work).
    
-   Command explanations: Run `sr-connect <group> <verb> --explain` for specific command documentation.
    

### Have feedback or ideas? 📬

We're always looking for ways to improve your CLI experience. Run `sr-connect feedback post` from your terminal to send suggestions and feature requests directly to the team.
