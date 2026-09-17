# ScriptRunner Agent Skills

```bash
npx skills add Adaptavist/scriptrunner-skills
```

Agent skills for working with ScriptRunner products, APIs, documentation, and
examples.

## Available skills

- `atlassian-cloud-rest-api`: OpenAPI specs for Jira Cloud platform v3, Jira
  Software Cloud, Jira Service Management Cloud, Assets Cloud, and Confluence
  Cloud v1/v2. Use when you need a REST path, its parameters, request body, or
  response schema.
- `atlassian-community-search`: searches public Atlassian Community questions,
  answers, and articles through the Khoros API. Use when a user asks to check
  the Community, or when practitioner workarounds and accepted answers would
  improve an Atlassian or ScriptRunner answer.
- `jira-expressions`: Jira Expressions DSL reference and examples for
  ScriptRunner for Jira Cloud workflow conditions and validators. Use before
  writing, reviewing, or converting any Jira expression.
- `scriptrunner-documentation`: local copy of the ScriptRunner docs for Jira
  Cloud, Confluence Cloud, ScriptRunner Connect, Jira Data Center, and
  Migration Suite. Use for questions about features, setup, migrations,
  listeners, macros, behaviours, jobs, and platform limits.
- `scriptrunner-example-scripts`: example scripts for Jira Cloud and Data
  Center, indexed by feature. Use when a user wants starter code or a pattern
  for a listener, job, behaviour, or workflow script.
- `scriptrunner-platform-guidance`: platform and product guidance for Jira
  Cloud, Confluence Cloud, and Jira Data Center. Use before platform-specific
  implementation, migration analysis, Confluence scripting, or Data Center to
  Cloud conversion.
- `sr-connect`: ScriptRunner Connect, the code-first integration platform.
  Covers whether an app can be integrated, workspaces, connectors, managed
  APIs, event listeners, scheduled triggers, record storage, limits, plans,
  and working through `@sr-connect/cli`. Use for any ScriptRunner Connect or
  Atlassian-integration question.

List the skills without installing them:

```bash
npx skills add Adaptavist/scriptrunner-skills --list
```

Install one skill:

```bash
npx skills add Adaptavist/scriptrunner-skills --skill scriptrunner-documentation
```

See the [`skills` CLI documentation](https://github.com/vercel-labs/skills) for
agent selection, global installation, and other options.
