# Working in ScriptRunner Connect through the CLI

Load this before the first CLI call. It says what to do at each step and which verb does it. What a verb takes is `npx @sr-connect/cli <group> <verb> --explain`; the contract, meaning exit codes, raw output, locks and local copies, is `npx @sr-connect/cli cli get-readme`. Neither needs credentials. Nothing here repeats them.

Read `references/scripting.md` before writing or editing a script. Read `references/testing.md` only when the user asks for tests.

## Posture

- Pass `--agent --raw` on every call, or export `SR_CONNECT_CLI_AGENT=1` and `SR_CONNECT_CLI_RAW=1` once. `--agent` turns every question into exit 2 and tells the API an agent is driving; `--raw` gives one JSON document on stdout and a JSON error envelope on failure. Two verbs read better without it, `log list-console-logs` and `log list-http-logs`, whose stored files are mostly wrapper; the CLI README names them and any others.
- Those two flags are for your own calls only. A command you hand the user to run themselves carries neither `--agent` nor `--raw`, so the CLI can ask them questions and print for a person. Strip them from every example in this skill before quoting it, including the `auth login` line, and never tell them to export the two environment variables.
- Read the exit code before the output. 0 ok. 1 the API or the run failed. 2 usage or a missing value. 3 not authenticated. 4 not found or an empty lookup. 130 cancelled.
- Run `--explain` on a verb before the first call to it. A body key is often a flag under another spelling and the rules say which.
- Credentials never ride in argv. `auth login --credentials-stdin`, or `SR_CONNECT_CLI_USERNAME` and `SR_CONNECT_CLI_PASSWORD`. Never print a key into a log, a message or a file you keep.
- Destructive verbs need `--yes`. Before passing it, confirm the intent with the user unless the ask left no room for doubt.
- Scope is `--team`, `-w`, `-e`, or the env vars `SR_CONNECT_CLI_TEAM`, `SR_CONNECT_CLI_WORKSPACE`, `SR_CONNECT_CLI_ENVIRONMENT`. Inside a cloned workspace directory, `workspace.json` supplies all three. Session defaults from `cli set-session` are read too.
- Cache `app list` for the session. Every event listener, API connection and connector verb takes IDs from it.
- If the clone carries an `AGENTS.md` or `CLAUDE.md`, read it. It wins on that project's own conventions: naming, code structure, review rules, which files may be touched. It also wins on permission. Anything it forbids or restricts, a deployment, an environment, a resource it says not to touch, stands, and this skill never authorises what that document refuses. What it does not settle is mechanics: where it describes how to create, configure or deploy workspace resources, or how to move scripts between the workspace and disk, the verb to use is this skill's and the CLI's. Where the two disagree on something that changes what you would do, stop and ask the user which applies rather than picking one.

## Preflight

1. Node 22 or newer: `node --version`. If missing or older, ask whether to install it, then install the current LTS for the user's OS.
2. The CLI, and its version. `command -v sr-connect` decides the command: a hit means every call in the session is `sr-connect ...`, a miss means `npx @sr-connect/cli ...` with the first call pinned to `@latest`. Then `cli check-updates`, and offer the upgrade when one is available. Both steps, including the upgrade line per install kind, are Before the first CLI call in `SKILL.md`. If npx cannot find the package, ask before installing anything.
3. `cli get-readme`. Read it once per session.
4. `auth status`. Exit 3 means not logged in; go to Authentication. Note the instance it reports.
5. `cli settings --raw`. Find the row with `"key":"agenticFeedback"`. When `enabled` is true, keep feedback notes as you work; see Feedback below. When it is false, feedback is off for the whole session and you do not bring it up.
6. `team list` for the team ID. `team get <teamId>` only when the work needs event queues: `features.eventQueues` says whether the plan has them.

## Authentication

Ask the user which they prefer.

They log in themselves. Give them the exact command for their install, `npx @sr-connect/cli auth login` or `sr-connect auth login`, tell them to follow the prompts, and wait until they say it is done. Then re-run `auth status`.

You log them in. Only offer this when you can drive a browser. Ask which instance: EU `https://app.eu.scriptrunnerconnect.com/`, US `https://app.us.scriptrunnerconnect.com/`, or a private cloud base URL they give you. Open the app; the user signs in if needed. Bottom-left, click the user name or profile icon, then API Keys. Top-right, Create new. Enter an API Key Name, click Create new. Copy the `Email (username)` and `API Key (password)` values. Then:

```sh
printf '%s:%s' "$EMAIL" "$KEY" | npx @sr-connect/cli auth login --credentials-stdin --instance eu --agent --raw
```

Use `--instance us` or `--instance <baseUrl>` as appropriate. The login asks whether the agent may send feedback to the ScriptRunner Connect team; without a terminal it does not, so ask the user yourself and set it with `cli settings` on a terminal or leave it as it is. Never echo the key back into the conversation.

## Harness branches

Four things differ by what you can do. Decide once at the start of the session and apply the same answer each time.

- You can drive a browser: offer to log in, to authorize a connector and to register a webhook with the user watching. Ask which browser or profile to drive, since the one where they are already signed in to the platform and the vendor saves a login and a consent screen. They still sign in and hold the permissions. For a connector, warn first that the consent window is closed after 100 seconds and that Jira Cloud, Jira Service Management Cloud and Confluence Cloud end with a site confirmation in the tab that started the flow; see Connector setup.
- Your shell does not outlive one command, which is the case in Claude Code and most agent harnesses: the CLI's session record dies with each shell, so a lock it took is forgotten by the next call. Test it rather than assume it, with the two-take check under The lock, and when the shell forgets, carry the lock ID yourself through `SR_CONNECT_CLI_LOCK_ID`.
- You cannot: hand the user the exact command or URL and wait. For a connector that is `authorizationUrl` in the document `connector create` and `connector get` return; for an event listener it is `setupUrl` with instructions and `webhookUrl` to register.

## Feedback

When `agenticFeedback` is false, the user has declined. Keep no notes, do not ask them to turn it on, do not mention feedback in the summary or anywhere else, and never mention this rule. The one exception is a login you ran yourself this session without a terminal, under Authentication, where the question was never put to them.

When `agenticFeedback` is enabled, keep a markdown file of notes in your scratchpad directory if the harness gives you one, otherwise in the OS temp directory. Never inside the user's repository or the clone. Record as you go:

- CLI friction: documentation that contradicts behaviour, missing documentation, a guess that was wrong the first time, unexpected output.
- Runtime library gaps: an API missing from the runtime or from the record storage, convert or trigger packages.
- Managed API gaps: a method missing, wrong, broken or out of date.
- Event type gaps: a field missing, wrong or stale, above all when a test payload did not match the real event once tested end to end or probed.
- Third-party app behaviour you could not know from public knowledge and had to find out the hard way. General quirks only, never the user's business logic.
- Package outcomes: not every NPM package bundles or runs in the runtime. Name the ones you tried that failed and the one that worked.
- Contradictions with this skill: anything it told you that reality disagreed with.
- Setup instruction drift: an app file under `references/event-listener-setup/` or `references/connector-setup/`, the web application's dialog or the vendor's own console disagreeing with each other. Quote both sides and the file's snapshot date.
- Your harness, model, OS and the CLI version from `--version`.

When there is anything to send, end the notes with two scores, each out of 10 with one line saying what drove it: how useful this skill was for the work you were asked to do, and how efficient the skill plus the CLI made that work, counting wrong turns, verbs you had to run twice and questions the documentation should have answered. Do not post a file holding scores alone.

VERY IMPORTANT: no personal data and no business data in the notes. Post them once the first round of work is done rather than holding them to the end of the session; the user may never follow up, and notes nobody sent help nobody. Post again when later work turned up new findings and you are fairly certain the ask is complete, carrying only what accumulated since the last post.

```sh
npx @sr-connect/cli feedback post --message "Agent feedback" --attachment <notes.md> --agent --raw
```

Then delete the notes file, and start a fresh one if the work carries on. If the user asked to preview feedback first, show them the file and post only when they approve. When the CLI writes a crash report, which the failure message names, send it right away with `feedback post-crash-report`. Both verbs exit 2 when the switch is off and nobody can be asked; that is the answer, not a bug.

## Session protocol

### The lock

Take the lock before working on a workspace and release it when you are done, even though every write takes one on its own:

```sh
npx @sr-connect/cli workspace-lock take -w <workspaceId> --agent --raw
npx @sr-connect/cli workspace-lock release -w <workspaceId> --agent --raw
```

The CLI remembers the lock in a session record keyed to the shell that took it, and every later write in that shell renews it. That record is gone when each command runs in a fresh shell, which is how Claude Code's Bash tool and most agent harnesses work. The next write then finds no lock, takes one of its own, and the API refuses it with `WORKSPACE_LOCKED` and a hint that the holder is another session of yours, taken through the API. That is you colliding with yourself, not a stale lock.

Find out which case you are in with the first lock of the session. `workspace-lock take --raw` answers with `lockId`, and no read reports it later, so capture it from that one document. Then, as a separate tool call, run the same `workspace-lock take` again. Exit 0 means the shell remembered the lock and renewed it: state persists, and nothing below applies. Exit 1 `WORKSPACE_LOCKED` naming another session of yours means the shell forgot: keep the ID yourself for the rest of the session. Put it in front of every later call, renewals and the release included:

```sh
SR_CONNECT_CLI_LOCK_ID=<lockId> npx @sr-connect/cli script update -w <workspaceId> ... --agent --raw
SR_CONNECT_CLI_LOCK_ID=<lockId> npx @sr-connect/cli workspace-lock release -w <workspaceId> --agent --raw
```

`--lock-id <lockId>` on the call does the same. Keep the ID in your scratchpad notes for the session, never in the clone or the user's repository, and do not print it in the closing summary. A lock belongs to the account that took it, so the ID is useless to anyone else and there is nothing to hand over. If you lose it, take the lock again with `--force`, which the next rule allows when the holder is you, and capture the new `lockId`.

Rules:

- At the start, run `workspace-lock check -w <workspaceId>`. Nobody holding it is exit 4 `NO_WORKSPACE_LOCK`, which is the answer you want. A holder is exit 0 with their name and how they took it; if it is not you, name them and ask the user whether it is safe to take the lock with `--force`.
- Mid-session, if a write is refused with `WORKSPACE_LOCKED` and the holder is someone else, stop and ask before forcing.
- If the holder is you, which the refusal states as another session of yours, first check whether you dropped the ID: present the `lockId` you captured and retry. Only when you have no ID take it back with `--force`, without asking, and capture the new one.
- After re-taking a lock while working from a clone, run `local-workspace clone --force` in the clone directory before touching files. Update mode rewrites workspace content and keeps your scaffolding. Something may have changed while you did not hold the lock. `--force` is for a directory that is already a clone of the same workspace; a directory holding a clone of another workspace keeps that workspace's scripts and would push them into this one, so delete it and clone fresh.
- `--no-lock` writes past whoever holds the lock. Never use it to get around a conflict.

### Where the clone lives

Decide before the first `local-workspace clone`, with the other up-front questions. Two places a clone can go, and the working directory earns a question when it looks like one of these:

- Empty, or nearly: nothing in it but a `.git`, harness files such as `.agents/`, `.claude/`, an `AGENTS.md` or `CLAUDE.md`, a `.gitignore`, a `README.md`.
- Already a clone: a `workspace.json` beside a `package.json`. Read `workspace.json` first; it must name the workspace you are about to work in. A clone of another workspace is not a candidate, since update mode would keep its scripts and push them into this one.

In either case ask the user whether the clone should go into the working directory itself, and say why it might: the copy stays behind when the session ends, so they can put it under version control, and the CLI keeps it current as you work. Pass `--force`, which every non-empty directory needs without a terminal, whether or not it is already a clone; on an existing clone that is update mode, which rewrites workspace content and keeps the scaffolding listed under Never. If they decline, or the directory holds anything else, clone into a scratch directory instead and say where it is.

Probing happens in the same clone that is meant to be the final copy. Standing in it, `script create` writes the probe under `scripts/` and `script delete` removes it, so a probe leaves nothing behind once deleted. Before the closing summary, check the clone holds only what the user asked for: no probe scripts, no probe payloads under `test-payloads/`, no notes or scratch files of yours.

### Which environment

Find out what you are working against before changing anything.

1. `environment list -w <workspaceId>`. An environment whose row carries a `release` object runs that release; one with no `release` field at all runs HEAD. A clone's `workspace.json` spells the same thing as `"release": null`. HEAD is where edits land; a non-HEAD environment refuses script pushes and refuses a differing value on anything its release captured.
2. Count the HEAD environments. Normally there is one, and its name is not prod, production or live. If the only HEAD environment sounds like production, stop and ask; that does not look right. If several run HEAD, prefer the one that does not sound like production and whose connectors do not sound like production connectors, then confirm with the user.
3. Production means at least one attached connector points at a production installation. Ask the user first. When they do not know, read the hosts rather than guessing from names. `api-connection list -e <env>` reports the connector on each connection in that environment, and `connector get <connectorId>` reports the `baseUrl` that connector was authorized against. A host carrying sandbox, dev, test, staging or uat answers the question; a bare company domain is usually the live site. Event listeners hold a per-environment connector too, so read those as well. It is evidence and not proof, and an absent base URL is never an answer in itself, because two different things cause it. A connector that is not yet authorized has none. So does any connector for an app that records no host at all: GitHub, Azure DevOps, Bitbucket Cloud, Microsoft Teams, NetSuite, Zoom and Statuspage report none even when authorized, and Slack reports its app's configuration page on api.slack.com, which separates nothing; for those you have to ask. A connector that reached the workspace implicitly, owned by another user, answers 404 through any team, and there `api-connection get` names its owner, who is the person to ask. A domain can also lie, so put your reading to the user before treating an environment as safe.
4. Working in production, ask whether a safe partition can be created: a throwaway Jira project, Confluence space or equivalent to work against, swapped for the real one later.
5. Non-production, staging, dev and UAT carry less risk. Use the terminology the user uses.

### Probing

Before building or changing, probe the systems you work against. A probe is a throwaway script that reads something back through an API connection, pushed, triggered, then deleted. Always ask before probing. Say plainly when a probe would mutate anything in the target app; mutation probes need a safe environment or explicit consent.

```sh
npx @sr-connect/cli script create -w <ws> -e <env> --name Probe --file ./probe.ts --agent --raw
npx @sr-connect/cli script trigger -w <ws> -e <env> <scriptId> --stream-logs --agent --raw
npx @sr-connect/cli script delete -w <ws> -e <env> <scriptId> --yes --agent --raw
```

`--file` takes the source from disk, `--content` inline. Standing in the clone, the create writes `scripts/Probe.ts` for you and the delete removes it, which is why a probe may run in the clone that will become the final copy; see Where the clone lives.

### Simulation loop

Prefer running without a human in the loop. Event listener test payloads trigger a listener's script with a stored event, so the cycle is edit, push, trigger, read logs. Ask the user once, with the other up-front questions, whether you may work in a simulation loop and involve them for the end-to-end test, or whether they want to trigger every run themselves. Make the case for the loop; it is faster unless you can trigger the real app yourself. The loop does not replace a follow-up question: when something you meet in it was not covered by the answers you have, ask before building on a guess.

- A new listener arrives with a seeded Default payload sampling its event type. `event-listener-test-payload create` with no content seeds the sample too; `event-listener-test-payload get` reads it back.
- The clone holds payloads under `test-payloads/<App→Event (listenerId)>/<name>.json`. Edit them there and push, or pass one straight to `script trigger --payload-file`.
- Do not change the user's default payload with `set-default`. You do not need it to trigger from the CLI.
- Templates can be stale, and some apps, ServiceNow among them, let the sender define the payload, so the sample may be wrong. Zoom, Azure DevOps, Microsoft, NetSuite, Salesforce and ServiceNow ship no sample at all. When a payload contradicts what you know, ask the user to fire the real event once, log the incoming event in the script, and read it from `log list-console-logs`.

When the loop has gone as far as simulation allows, ask the human to try it end to end. On a bad result read the logs, fix, repeat until they are satisfied.

## Strategies by ask

### Theoretical

Whether something can be done. Answer from `SKILL.md`; the CLI is often not needed. If the ask names an existing workspace, probe it first to establish the baseline: `workspace get`, `environment list`, `api-connection list`, `event-listener list`, `scheduled-trigger list`, `script list`, `package list`. To read the scripts themselves, `local-workspace clone` into a scratch directory beats `script get` one at a time; a read-only look does not earn the working-directory question.

### Troubleshooting

Start with the logs. Ask what the user can give you: team, workspace, time span, script name. Then:

1. `log list-invocation-logs` with filters. Statuses worth reading: Function Error, Timed out, Runtime Error, Malformed Payload Error, Denied.
2. For an invocation: `log list-console-logs`, `log list-http-logs`, `log get-invocation-payload`. A console line too large to store is `log get-large-log-message`.
3. Read the script, `script get` for one or `local-workspace clone` when several are involved, and the workspace setup. Explain the cause.
4. Offer to fix it in the affected workspace. A fix follows Building below. `script replay-invocation` re-runs an event-triggered invocation, optionally with an edited payload, once the fix is in; always ask the user before replaying.

### Building or changing a workspace

Gather requirements first. If the ask looks impossible in SR Connect, say why, then offer to try anyway.

Connectors. Probe what the user already has: `connector list --team <teamId>`, then `connector get` on the candidates. A connector for the right app, authorized, pointing at the right host is the answer, and whose account it runs as is a question for the user rather than a reason to make another. When nothing fits, or the fit is unauthorized or expired, follow Connector setup below: which method to offer, what to do when the user refuses them all, and what the handoff looks like.

Environments. Run the checks under Which environment above. Recommend non-production. Find out how many environments there will be in the end: prod only, prod and staging, live, UAT and dev, whatever the user calls them. Skip connector and environment probing when the ask is to work in an existing workspace that already has them; infer from `environment list` and the attached connectors and confirm with the user.

Create the workspace:

1. `workspace create --team <teamId> --name <name> --language ts-strict`. From a template: `template list`, then `--source-template-id`; the language is then inherited, so read it back with `workspace get` and fix it with `workspace update --language ts-strict`.
2. Rename the default environment to match what it targets: `environment update`.
3. Start from the safest environment. Add the others once the work is confirmed, unless the user asks for them up front. Each environment you add gets every listener with no URL: `event-listener get -e <newEnv> <id>` reports `urlPath` and `webhookUrl` as null while `disabled` is false, and `event-listener list` and `environment list` say nothing. Fix it per listener before calling the environment ready. A generic listener takes `event-listener update -e <env> <id> --url-path <path>`; `--url-path` is refused for any other type. For those, any update touching the listener in that environment generates a path when it had none, so a no-op such as `--disabled false` echoing the current state is enough. A connector is not part of that: most listener types take none, and `event-listener get` reports `connectionRequired` for the ones that do. Attach one all the same when the team already has an authorized connector for the app, `--connector-id` with the environment's connector, because the handoff block's deep link is built on that connector's `baseUrl` and the setup instructions are better for it. No connector for the app means no connector on the listener, not a new connector. The new `webhookUrl` is not HEAD's, so the app-side webhook is registered again; give a handoff block per listener per environment.
4. Set up API connections: `api-connection create`, which is workspace-scoped, then attach the connector per environment with `api-connection update`.
5. Parameters: `environment-parameter create`. Parametrize everything configurable. Never hardcode configuration, and never hardcode a credential. Mark values the user must supply as required. Requiredness is documentation and a web-app save check, not a runtime guarantee: every parameter is declared optional in `ev-params.ts`, `GREETING?: string`, so under ts-strict the code checks each one is present before using it. Default values seed new environments and copies; the value itself does not carry over. Secrets: recommend the user sets those values themselves and give them the exact `environment-parameter create` or `update` command with a placeholder where the value goes. If they insist you do it, take the value through `--input <file>`, never on argv, and delete the file after.
6. Clone: `local-workspace clone <dir> --team <teamId> -w <ws> -e <env>`, into the working directory or a scratch directory as decided under Where the clone lives. Then install dependencies. Prefer pnpm when installed; ask whether to install it, and fall back to NPM if not allowed. Run the clone's `lint:fix`, then `lint` for what it could not fix, and `typecheck` before a push.
7. Switch an existing workspace to `ts-strict` with `workspace update --language ts-strict`. Fix the errors the switch surfaces before adding anything.
8. Packages. In a workspace you created this session, skip the version check: every package arrives at the version current when it was added, so there is nothing to upgrade. A package you added at an older version on purpose, one the verified table in `references/scripting.md` pins, stays where you put it, and goes into the README under Pinned packages with the version and the reason, so the next reader has something to check `package list` against. In an existing workspace, `package list`, then hold each version against two lists, the README's Pinned packages section and the verified table: a version either one names is deliberate and stays. For the rest, `package list-npm-versions <name>`; when a newer stable version exists, ask whether to upgrade, and recommend it. A package sitting behind latest that neither list explains may still be pinned for a reason nobody wrote down, so say what you found and let the user decide, and never upgrade one on your own. Whatever they decide to keep pinned, write into the README's Pinned packages section before you finish. Add with `package add`; add `@types/<name>` beside a package not written in TypeScript. Never edit the `dependencies` section of `package.json` in the clone; `devDependencies` and the rest are yours for local tooling. Standing in the clone, the CLI regenerates the dependencies after a package change; run the install again. A package change recompiles on the next push.

Event listeners:

- Create with `event-listener create --script-name <NameInPascalCase>`, `OnIssueCreated` for example, so the API generates the entry point with the right event type. Read `appId`, listener type and event type IDs from `app get <app>`.
- The response carries `webhookUrl`, the callback to register in the app, and `setupUrl`, the same steps in the web application behind a login, where for some apps the webhook secret is entered as well. Most apps cannot register webhooks programmatically. Registering is the user's job, or yours with them when you can drive a browser, and what you owe them is one handoff block per listener, written at the end and not while building; see Webhook handoff below. Load the app's file from `references/event-listener-setup/` only then.
- The listener's script opens with an input check on the field that scopes the integration, the project key, the repository, the board, the table, and returns early otherwise; see Event listeners in code in `references/scripting.md`. Where the app can filter on its own side, ask for that too: it cuts invocations and logs. The check in the script is what makes the integration correct; the vendor filter only makes it cheaper.
- Not every workspace needs a listener. One-off and scheduled jobs do not. A single-app automation, listening in an app and acting in the same app, needs one connector.
- Use a listener as a probe too: create it, ask the user to fire the event, read the payload from the logs, and decide whether events or polling fit.
- A listener's URL path and connector are per environment. In an environment that has never had them the listener is enabled and unreachable, and only `event-listener get -e <env>` shows it, as null `urlPath` and `webhookUrl`. See step 3 under Create the workspace for the fix by listener type.
- Racing events: when order matters, put the listener on an event queue: `event-queue create`, then the listener's `--event-queue-id` and groupings. Paid plans only; check `features.eventQueues`.

Scheduled triggers: `scheduled-trigger create`. Minimum interval 15 minutes. Create it with `--disabled` so unfinished code does not run, enable with `scheduled-trigger update` when done.

Scripts beyond the listener entry points: `script create`, `script update --name` to rename, `script delete`. Always the CLI, never a push, for creating, renaming and deleting; `/` in a name makes a folder. Standing in the clone, the CLI mirrors each change to disk.

Iteration:

1. Edit under `scripts/` in the clone. Read `references/scripting.md` first.
2. `local-workspace push`. It sends every changed script at once; do not use `script update` for content. TypeScript diagnostics are reported and do not fail the push.
3. `script trigger --stream-logs`, or with `--test-payload-id` or `--payload-file`. The stream prints on stderr; stdout carries only the invocation document, so capture both. When the order of two lines matters read `log list-console-logs` after the run; the live stream can print two rows swapped. Without a run permission, ask the user to fire the event and read `log list-console-logs`.
4. Repeat until the user is happy.

Definition of done for a change:

- Every configurable value is a parameter; no credential in code.
- Workspace language is `ts-strict` and the push reports no diagnostics you introduced.
- Every throwaway script is deleted.
- Scheduled triggers you created are enabled only when the code is finished.
- The README, written with `readme update`, describes setup and usage for an end user; it never mentions the CLI, local copies or the agent.
- Packages are at the versions the user agreed to.
- Additional environments, if any, are created and parametrized.
- Release: when the workspace has more than one environment, ask whether to cut a release and deploy it to the staging or production environment. Never deploy without asking. Once they say yes, the normal path is one call: `release create -w <ws> -e <targetEnv>` cuts the release and deploys it into that environment, and `-e` repeats for several. Here `-e` is the deploy target, not the scope it is on every other verb, so do not pass the HEAD environment. `environment target-release` is for moving an environment onto a release that already exists, or back to `--head`; it is not a second step after `release create -e`. Standing in a clone of an environment deployed into, re-clone afterwards.
- The lock is released.

### Ad-hoc, one-off task

A script or two, triggered manually, in a workspace with no listeners or triggers. The recipe, shorter than a build:

1. `workspace create --team <teamId> --name <name> --language ts-strict`, then `workspace-lock take -w <ws>`.
2. `environment-parameter create` for each value the script needs.
3. `local-workspace clone <dir> --team <teamId> -w <ws> -e <env>`, placed as decided under Where the clone lives, then install.
4. `script create` from inside the clone, edit under `scripts/`, `local-workspace push`.
5. `script trigger -w <ws> -e <env> <scriptId> --stream-logs`; `log list-console-logs` when line order matters.
6. Show the output. Ask whether the job will recur and would benefit from parameters. If yes the workspace stays and the build definition of done applies. If no, `workspace-lock release`, then `workspace delete <ws> --team <teamId> --yes` after the user confirms the result. Always ask before deleting.

Skipped for a throwaway: renaming the default environment, the package review, the README, the release question. The lock, `ts-strict` and cleanup are not skipped.

## Connector setup

What to do when no existing connector fits, when one has to be re-authorized, or when you are about to drive the wizard yourself. The per-app text lives under `references/connector-setup/`, one file per connector type; load a file only at one of those three moments, never while probing and never at skill load.

Reuse before you create. `connector list --team <teamId>`, then `connector get` on the candidates for `authorized` and `baseUrl`. A connector for the right app, authorized and pointing at the right host, is the answer. Whose account it runs as is a question for the user, not a reason to make another.

Offer what the wizard offers; a refused method means Generic or a workaround. Each file names the methods the web application's wizard shows for that app, with their labels, and nothing else. When the user declines every one of them and wants a method the wizard does not have, the standing example being an API token for Jira Cloud, offer the fixed-key alternative in the file's Generic section: a Generic connector with the vendor's own token header or basic authentication, and the app's Managed API constructed on it as `references/scripting.md` shows under "A Managed API on a Generic connector". Where no fixed-key form exists, Microsoft, Salesforce, Zoom, NetSuite, AWS and the Google apps among them, the file says so and points at the OAuth recipe in `references/scripting.md` or back at the wizard. The choice is the user's; the file only makes the cost of each visible.

Managed app by default, self-managed when scopes or least privilege demand it. Jira Cloud, Jira Service Management Cloud and Confluence Cloud offer "ScriptRunner Connect OAuth 2.0 app" against "Self-managed OAuth 2.0 app"; GitLab, Microsoft and Azure DevOps offer "Fully managed ... by ScriptRunner Connect" against "Self-managed ...". Default to the platform's app when the user accepts its pre-approved scopes; the wizard rates it "Less than 1 minute" against "10 minutes +". Recommend self-managed when the user wants only the scopes the integration needs, or when the integration needs scopes the platform's app lacks. The wizard names the known gaps: Jira Cloud's app does not cover the Jira Software API or the Compass GraphQL API, and Microsoft's app is scoped for Microsoft Teams alone. Beyond those the managed scope list is not readable from the CLI or the wizard; you find out when a vendor call answers 401 or 403 for a scope the account holds. Then tell the user the connector has to be swapped for a self-managed one, create it, re-attach it on the API connection per environment with `api-connection update`, and carry on. Say in the plan up front that this can happen.

Driving the browser: offer it, warn, never leave a half-authorized connector. When you can drive a browser, offer to run the wizard with the user signed in, and ask which browser or profile to use, since the one where they are already signed in to the platform and to the vendor saves a login and a consent screen. Warn before starting: the consent window is closed after 100 seconds and the run is then reported as "Authorization cancelled."; and for Jira Cloud, Jira Service Management Cloud and Confluence Cloud the run ends with an "Authorize site" dialog pushed to the tab that started it, so two things have to go right inside one window. Recommend the user runs those three themselves. If they still want you to try and it fails, do not retry silently: hand them `authorizationUrl`, tell them the connector reads "Incomplete", and ask them to finish. Confirm with `connector get` afterwards: `authorized: true`, and `baseUrl`, where the app records one, naming the host they meant.

Credentials the CLI cannot store, and the ones it can. AWS, Jira Service Management Cloud Assets, NetSuite, Opsgenie, Slack, Statuspage and Trello take a key, a token or a certificate mapping rather than a consent screen, and every one of them is saved only in the web application; the public API has no field for them. The handoff is the same as for OAuth: `connector create`, then `authorizationUrl`, then the file's steps. For Opsgenie, Statuspage, Slack and Jira Service Management Cloud Assets, a Generic connector carrying the same key is something the CLI can create authorized; offer it second, after the web application path, with the costs the file names, and never for Slack when the workspace has or will have a Slack listener, because the Generic connector holds no signing secret. A Generic connector's credentials are its configuration. Prefer that the user configures it in the web application so no key passes through you; if they hand you one anyway, take it through `--input <file>` and the basic-auth password through `SR_CONNECT_CLI_BASIC_AUTH_PASSWORD`, never on argv, and delete the file afterwards.

Re-authorization is the same wizard. `connector get` reports `authorizationUrl` for every connector, authorized or not, and the button there reads "Reauthorize". Each file's Expiry section says what runs out and what a re-authorization invalidates: the on-premise Atlassian key pair and the NetSuite certificate are regenerated and have to be pasted into the vendor again, and AWS regenerates its trust policy.

The block, one per connector left for a human, in the closing summary:

```md
### <connector name> (<connectorId>) · <App> · team <name>

Authorize at <authorizationUrl> (needs a login; opens the connector with the wizard on top)
Method <the wizard's label for the method agreed, and why: the platform's app for speed, self-managed for these scopes, Generic because ...>
Steps <the file's steps for that method, numbered, with the vendor console links>
Values to copy <the read-only values the wizard shows: Name, Redirect or Callback URL, scopes, whichever apply; say "the value the wizard shows", never a guessed URL>
After the callback <"Authorize site", pick the site, "Confirm"> or <nothing; the connector reads "Authorized">
Then attach it <api-connection update -e <env> --connector-id ..., or event-listener update>, and I read it back with connector get.
Snapshot <the file's date>. Differs from the vendor's current console: <what, or none found>.
```

Index, one file per connector type. The file name is `connectionType.name` from `app list` lower-cased, spaces and dots to hyphens, the same rule as the listener files; the apps sharing the Jira On-Premise connector share its file.

| App                                       | File                                      | Methods                                                    | CLI can finish |
| ----------------------------------------- | ----------------------------------------- | ---------------------------------------------------------- | -------------- |
| AWS                                       | `aws.md`                                  | IAM role with a generated trust policy, or an access key   | no             |
| Azure DevOps                              | `azure-devops.md`                         | Platform's Azure app, or own app registration              | create only    |
| Bitbucket Cloud                           | `bitbucket-cloud.md`                      | Own OAuth consumer                                         | create only    |
| Bitbucket On-Premise                      | `bitbucket-on-premise.md`                 | Own incoming application link                              | create only    |
| Confluence Cloud                          | `confluence-cloud.md`                     | Platform's OAuth app, or own app; site confirmation after  | create only    |
| Confluence On-Premise                     | `confluence-on-premise.md`                | Application link with a generated key pair                 | create only    |
| Generic                                   | `generic.md`                              | None, basic authentication, custom headers                 | yes            |
| GitHub                                    | `github.md`                               | Platform's GitHub app, no wizard                           | create only    |
| GitLab                                    | `gitlab.md`                               | Platform's GitLab app on gitlab.com, or own application    | create only    |
| Google Calendar                           | `google-calendar.md`                      | Google sign-in, no wizard                                  | create only    |
| Google Drive                              | `google-drive.md`                         | Google sign-in; platform-created files only                | create only    |
| Google Sheets                             | `google-sheets.md`                        | Google sign-in, no wizard                                  | create only    |
| Jira Cloud                                | `jira-cloud.md`                           | Platform's OAuth app, or own app; site confirmation after  | create only    |
| Jira On-Premise                           | `jira-on-premise.md`                      | Application link with a generated key pair                 | create only    |
| Jira Service Management Cloud             | `jira-service-management-cloud.md`        | As Jira Cloud                                              | create only    |
| Jira Service Management Cloud Assets      | `jira-service-management-cloud-assets.md` | Email and API token                                        | no             |
| Jira Service Management On-Premise        | `jira-on-premise.md`                      | Shares the Jira On-Premise connector                       | create only    |
| Jira Service Management On-Premise Assets | `jira-on-premise.md`                      | Shares the Jira On-Premise connector                       | create only    |
| Microsoft                                 | `microsoft.md`                            | Platform's Azure app (Teams only), or own app registration | create only    |
| monday.com                                | `monday-com.md`                           | Platform's app, installed by an account admin first        | create only    |
| NetSuite                                  | `netsuite.md`                             | Client credentials with a generated certificate            | no             |
| Opsgenie                                  | `opsgenie.md`                             | API key from an API integration, plus region               | no             |
| Salesforce                                | `salesforce.md`                           | Own Connected App                                          | create only    |
| ServiceNow                                | `servicenow.md`                           | Own OAuth API endpoint for external clients                | create only    |
| Slack                                     | `slack.md`                                | App ID, signing secret, bot token from own Slack app       | no             |
| Statuspage                                | `statuspage.md`                           | API token                                                  | no             |
| Tempo Cloud                               | `tempo-cloud.md`                          | Own application registered in Tempo                        | create only    |
| Tempo Planner On-Premise                  | `jira-on-premise.md`                      | Shares the Jira On-Premise connector                       | create only    |
| Tempo Timesheets On-Premise               | `jira-on-premise.md`                      | Shares the Jira On-Premise connector                       | create only    |
| Trello                                    | `trello.md`                               | API key and token from own Power-Up                        | no             |
| Zendesk                                   | `zendesk.md`                              | Own OAuth client                                           | create only    |
| Zoom                                      | `zoom.md`                                 | Own General app                                            | create only    |

"Create only" means `connector create` works and the authorization is a browser session at `authorizationUrl`; "no" means the credentials are saved only in the web application, so the CLI creates the connector and the dialog at `authorizationUrl` does the rest.

## Webhook handoff

Every listener the work created or re-pointed gets one block in the closing summary, written for the person who will register the webhook. It is the last thing you write, so nothing under `references/event-listener-setup/` loads before then.

Before writing a block:

1. `event-listener get -e <env> <listenerId>` for `webhookUrl`, `setupUrl` and `connectorId`. Both URLs are per environment. A null `webhookUrl` means the environment has no path for this listener yet; assign one first, `--url-path` for a generic listener and a no-op `event-listener update -e <env> <listenerId> --disabled false` for the rest, and never write a block around a null. `connectorId` is null on a listener nobody attached a connector to, which is fine unless `connectionRequired` is true. When the team has an authorized connector for the app, attach it before writing the block anyway: step 2 reads `baseUrl` from it and the deep link depends on that.
2. `connector get <connectorId>` for `baseUrl`, the host the deep link is built on. It is absent on an unauthorized connector and on the apps the index below marks; then the block names the menu path and the app's own console URL from the file, never a guessed host.
3. Load `references/event-listener-setup/<file>.md` for the app, and only that file. It carries the steps, the event-type branches, the deep-link pattern, what the app can filter and how its webhook is secured, and a list of what to verify.
4. Cross-check the file against what you know of the app's current UI and docs. The snapshot is dated. Where the two disagree, give the user both versions and say which you trust, and record it in the feedback notes as setup instruction drift.

The block:

```md
### <script name> (<listenerId>) · <App> · <event type> · environment <name>

Webhook URL <webhookUrl>
Open <deep link from baseUrl and the file's pattern, or the menu path when there is no host>
Setup dialog <setupUrl> (needs a login; the same steps, and for Jira Cloud, JSM Cloud, Microsoft Teams and Zoom the only place the secret goes)
Steps <the file's steps, adapted to this event type, numbered>
Filter there <the vendor-side filter with the concrete value, or "none offered">. The script also checks <field> in <file:line>.
Secure it <the vendor-side secret or auth, who verifies it: the platform or the script, and where the value goes>
Snapshot <the file's date>. Differs from the app's current docs: <what, or none found>.
```

Rules for the block: the deep link is the file's pattern applied to `baseUrl` with any trailing slash removed. The setup URL is always present when the API returned one. The filter line names a concrete key, repository, board or table, and the script line that checks it. The secure line says who verifies. For Jira Cloud, Jira Service Management Cloud, Microsoft Teams, Zoom, and Slack through its connector, the platform checks the app's secret or signature before the script runs: say "checked by the platform, no further action needed". For every other app the line names what the app offers, says it goes unchecked, because an app listener hands the script the event body and nothing else, and says the webhook URL's secrecy is what is left.

Hardening. An app listener exposes no request headers and no sender address to the script, so a vendor secret, signature, basic-auth header or IP range that the platform does not verify cannot be verified in code either. Nothing then authenticates the caller: the webhook URL's secrecy is the only control, and anyone who learns it can post a body the script acts on. Say that in the secure line rather than leaving the unchecked secret to imply protection, so the user decides knowingly. Do not write a check that reads a header from an app listener's event, and do not choose a Generic listener for security alone: the regular listener is the default, with no extra checks, and the handoff block says so in one sentence. Only when the user asks for more security, offer the Generic route: a Generic listener receives headers and `sourceIp`, so a script behind one can verify the vendor's signature or a shared header against a masked TEXT parameter. It is a rework, not a switch: create a Generic listener, keep the event's shape you already developed against by typing the body as the same `@sr-connect/<app>/events` type, and hand the user the new URL to swap into the webhook they already registered. End every block whose app offers a secret with one line saying this option exists and what it costs; build it only on request.

Index, one file per app that has listener types. The file name is the app's `app list` name lower-cased, spaces and dots to hyphens.

| App                                | File                                    | Filter on the app side                                              | Secure it                                                                     | `baseUrl` |
| ---------------------------------- | --------------------------------------- | ------------------------------------------------------------------- | ----------------------------------------------------------------------------- | --------- |
| Azure DevOps                       | `azure-devops.md`                       | Service hook filters: repository, branch, area path, work item type | Basic auth or a custom header on the subscription; unchecked, Generic only    | no        |
| Bitbucket Cloud                    | `bitbucket-cloud.md`                    | Per repository, per event                                           | Webhook secret, `X-Hub-Signature`; unchecked, Generic only                    | no        |
| Bitbucket On-Premise               | `bitbucket-on-premise.md`               | Per project or repository, per event                                | Secret token or basic auth; unchecked, Generic only                           | yes       |
| Confluence On-Premise              | `confluence-on-premise.md`              | Event selection only                                                | Webhook secret, `X-Hub-Signature`; unchecked, Generic only                    | yes       |
| Generic                            | `generic.md`                            | Whatever the sender offers                                          | Shared-secret header, signature or `sourceIp`, all checked in the script      | yes       |
| GitHub                             | `github.md`                             | Scope, then individual events; also sends `ping`                    | Secret, `X-Hub-Signature-256`; unchecked, Generic only                        | no        |
| GitLab                             | `gitlab.md`                             | Group or project, per event; branch filter on push events           | Secret token or signing token; unchecked, Generic only                        | yes       |
| Jira Cloud                         | `jira-cloud.md`                         | JQL on the webhook, issue-related events only                       | Secret, `X-Hub-Signature`; checked by the platform once entered at `setupUrl` | yes       |
| Jira On-Premise                    | `jira-on-premise.md`                    | JQL on the webhook                                                  | Secret token or basic auth on 11.0 and later; unchecked, Generic only         | yes       |
| Jira Service Management Cloud      | `jira-service-management-cloud.md`      | JQL on the webhook, issue-related events only                       | As Jira Cloud                                                                 | yes       |
| Jira Service Management On-Premise | `jira-service-management-on-premise.md` | JQL on the webhook                                                  | As Jira On-Premise                                                            | yes       |
| Microsoft                          | `microsoft.md`                          | None; fires when the webhook is mentioned                           | Security token shown once; checked by the platform once entered at `setupUrl` | no        |
| monday.com                         | `monday-com.md`                         | Per board; column events pick the column                            | None on the board recipe                                                      | yes       |
| NetSuite                           | `netsuite.md`                           | Record type on the deployment; the SuiteScript can filter further   | A header the SuiteScript could send; unchecked, Generic only                  | no        |
| Opsgenie                           | `opsgenie.md`                           | Alert actions, assignee team; per-action filters on paid plans      | A custom header on the integration; unchecked, Generic only                   | yes       |
| Salesforce                         | `salesforce.md`                         | Object, fields to send, flow entry conditions                       | None on the message; published IP ranges, usable from a Generic listener only | yes       |
| ServiceNow                         | `servicenow.md`                         | Table and operations; business rule conditions                      | A header on the REST message; unchecked, Generic only                         | yes       |
| Slack                              | `slack.md`                              | Per bot event; nothing by channel                                   | Signing secret; checked by the platform through the connector                 | app page  |
| Statuspage                         | `statuspage.md`                         | Page and components; the API can subscribe for you                  | None offered                                                                  | no        |
| Zendesk                            | `zendesk.md`                            | Event subscription, or trigger conditions                           | Auth header or signing secret; unchecked, Generic only                        | yes       |
| Zoom                               | `zoom.md`                               | Per event on the app                                                | Secret token; checked by the platform once entered at `setupUrl` first        | no        |

"Unchecked, Generic only" means the app offers the mechanism, the platform does not verify it, and an app listener cannot; see Hardening above.

## Refusals decoded

- `WORKSPACE_LOCKED`: someone holds the lock. Read the hint; it says whether the holder is you, your browser tab, or someone else. Another session of yours, taken through the API, right after your own `workspace-lock take`, means the shell forgot the lock and you need `SR_CONNECT_CLI_LOCK_ID`. See The lock.
- `RELEASED_ENVIRONMENT` on a push, or a 400 on an update in a non-HEAD environment: you targeted an environment running a release. Switch `-e` to the HEAD environment, or move the environment with `environment target-release --head` only if the user wants that.
- A 403 naming `features.eventQueues`: the plan has no event queues.
- Exit 4 with a warning naming `workspace.json` or a session default: the scope came from a stale clone or a stale session default. Re-clone or pass the flags.
- Exit 2 `CONFIRMATION_REQUIRED`: a destructive verb without `--yes` and without a terminal.
- `bundlingError` in a script response: the workspace has no bundle until any script is saved again. `compilationErrors` are diagnostics for a bundle that was written. A `bundlingError` after `package add` can also mean the bundler cannot handle that package; try another, and put both in the feedback notes, the ones that failed and the one you settled on.
- `Cannot run deleted script`: the trigger targets a script that no longer exists.
- A vendor 401 or 403 through a connector authorized with the platform's own OAuth app, on a call the same account can make in the vendor's UI: a scope the platform's app lacks. Swap to a self-managed connector, see the app's file under `references/connector-setup/`, re-attach it per environment, and tell the user why.
- Events never arrive: `event-listener get -e <env>` first. A listener with `disabled: true`, no `webhookUrl` in that environment, `connectionRequired: true` with no connector, or a Slack listener on an unauthorized connector receives nothing. Then the app's file under `references/event-listener-setup/`: its Verify list names what a registration gets wrong most often.

## Never

- Edit the `dependencies` section of `package.json` in the clone. Use `package add`, `package update`, `package remove`.
- Edit `workspace.json`, `ev-params.ts` or `scripts/api/**`. A re-clone rewrites all three, so a change there is lost without a word. The rest of the scaffolding is yours to configure: a re-clone keeps `tsconfig.json`, `tsconfig.base.json`, `node/tsconfig.json`, `node/jest.config.ts`, `node/apiRegistry.ts`, `node/runtimeMocks.ts`, `node/global.d.ts`, `eslint.config.js`, `.prettierrc`, `.gitignore`, `pnpm-workspace.yaml` and `.vscode/extensions.json` once they exist. `package.json` is neither: it is merged, so your own fields and `devDependencies` survive while `dependencies` is rewritten from the workspace's packages.
- Create, rename or delete a script with a push. Use `script create`, `script update --name`, `script delete`.
- Change the user's default test payload.
- Hardcode a credential or configuration a parameter could hold.
- Leave a scheduled trigger enabled on unfinished code.
- Pass a credential on argv or paste one into the conversation.
- Pass `--force` on a lock someone else holds, or `--no-lock`, without the user's say-so.
- Put `--agent` or `--raw` in a command the user is going to run.
- Upgrade a package in a workspace you did not create this session without asking, and never one pinned at a version the README's Pinned packages section or the verified table in `references/scripting.md` names.
- Pin a package without writing the version and the reason into the README's Pinned packages section.
- Deploy a release, delete anything, move a workspace to another team, or make any other dangerous mutation without asking.

## Closing summary

End every session with a summary in the conversation, whatever the ask type. The user may not have watched the run and the workspace now differs from when they started, so write it for a reader who sees nothing else:

- What was done, in the user's terms, and which environment it landed in.
- Every resource created or changed, by name and ID: workspace, environments, parameters, connectors, API connections, event listeners, test payloads, event queues, scheduled triggers, scripts, packages, releases.
- What the probing created. Say what was deleted, and give the ID and location of anything you could not clean up, a parameter with no value, a probe script the lock refused to delete, a payload you seeded, a record-storage key, a test issue in the target app. Nothing may be left behind silently.
- Where the clone is, and whether it stays.
- What still needs a human: authorizing each connector you left unauthorized, as one block per connector under Connector setup, registering each listener's webhook as one block per listener under Webhook handoff, setting a secret parameter, the end-to-end test, enabling a trigger you left disabled, creating and deploying a release, deleting a one-off workspace. Give the exact command or URL for each.
- Whether feedback was posted, and where the notes went if it was not. Only when `agenticFeedback` is on; when it is off this line does not exist.
- A workspace the work created, named and linked, as the summary's last line, so the way in is what the user is left with. Nothing in the API carries that URL: build it from the ID `workspace create` returned as the web application's host for the instance plus `/workspace/<workspaceId>`, EU `https://app.eu.scriptrunnerconnect.com/workspace/<workspaceId>`, US `https://app.us.scriptrunnerconnect.com/workspace/<workspaceId>`, private cloud the base URL the user gave with the same path. More than one, one line each.
- The workspace README beside that link, when the clone was kept: its path in the clone, `<clone>/README.md`, so the user can read what the workspace does without opening the web application. Link it where the harness renders a link to a local file, and open it directly where the harness can open one; a terminal-only harness prints the path and nothing else.

## Session checklists

Start:

1. `node --version`, `npx @sr-connect/cli@latest cli get-readme`.
2. `auth status`, `cli settings --raw`, `team list`.
3. Decide the harness branch. Open the feedback notes file if allowed.
4. Identify the ask type and the target environment.
5. Decide where the clone lives, `workspace-lock take` and capture `lockId` when the shell does not persist, then `local-workspace clone`.

End:

1. Throwaway scripts and probe payloads deleted, in the workspace and in the clone; triggers in the intended state; README updated.
2. Release offered where there is more than one environment.
3. `workspace-lock release`, with the captured `lockId` when the shell does not persist; without it the release finds no lock to let go of.
4. `feedback post` with whatever accumulated since the last post, plus the two scores, then delete the file.
5. One-off job: `workspace delete <ws> --team <teamId> --yes` after confirmation.
6. The closing summary, in the conversation, ending with the link to any workspace the work created.

## Verb map

| Step                   | Verbs                                                                                                                                                                |
| ---------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Orientation            | `cli get-readme`, `<verb> --explain`, `auth status`, `cli settings`, `team list`, `team get`, `app list`, `app get`                                                  |
| Workspace              | `workspace list/get/create/update/delete`, `template list`, `readme get/update`                                                                                      |
| Environments           | `environment list/create/get/update/delete/target-release`, `environment-parameter list/create/update/delete`                                                        |
| Connectors             | `connector list/get/create/update/delete`, `connector-sharing list/get/set/remove/list-assignable-users`                                                             |
| API connections        | `api-connection create/list/get/update/delete`                                                                                                                       |
| Listeners and payloads | `event-listener list/get/create/update/delete`, `event-listener-test-payload list/get/create/update/set-default/delete`, `event-queue list/get/create/update/delete` |
| Schedules              | `scheduled-trigger create/list/get/update/delete`                                                                                                                    |
| Scripts and runs       | `script create/update/list/get/delete/trigger/replay-invocation/abort-invocation`                                                                                    |
| Local copy             | `local-workspace clone/push`                                                                                                                                         |
| Packages               | `package list/get/add/update/remove/list-npm-versions`                                                                                                               |
| Releases               | `release list/create`; `create -e <env>` cuts and deploys in one call, `environment target-release` only re-points an environment                                   |
| Locks                  | `workspace-lock check/take/release`                                                                                                                                  |
| Logs                   | `log list-audit-logs/list-invocation-logs/get-invocation-payload/list-console-logs/list-http-logs/get-large-log-message`                                             |
| Feedback               | `feedback post/post-crash-report`                                                                                                                                    |
| CLI state              | `cli set-session/clear-session/list-api-logs/clear-api-logs/list-crash-reports/get-crash-report/clear-crash-reports`                                                 |

Group aliases: `ac`, `con`, `cs`, `env`, `ep`, `el`, `tp`, `eq`, `lw`, `st`, `wl`.
