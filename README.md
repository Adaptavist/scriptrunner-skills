# ScriptRunner Agent Skills

```bash
npx skills add Adaptavist/scriptrunner-skills
```

Agent skills for working with ScriptRunner products, APIs, documentation, and
examples.

## Available skills

- `atlassian-cloud-rest-api`
- `atlassian-community-search`
- `scriptrunner-documentation`
- `scriptrunner-example-scripts`
- `scriptrunner-hapi-api`
- `scriptrunner-platform-guidance`

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

## Publishing

This repository is generated from the ScriptRunner Migration Suite pipeline.
The `skills/` directory and this README are replaced when their source content
changes; tagged publications use
`sms-<sms-core-short-sha>-pipeline-<GitLab-pipeline-id>`.
