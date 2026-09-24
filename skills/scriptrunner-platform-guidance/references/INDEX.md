# ScriptRunner Platform Guidance Index

- `cloud.md` - ScriptRunner for Jira Cloud guidance (platform: `cloud`)
- `confluence-cloud.md` - ScriptRunner for Confluence Cloud guidance (platform: `confluence-cloud`)
- `data-center.md` - ScriptRunner for Jira Data Center guidance (platform: `data-center`)

## Selection Rules

- Use `cloud.md` when the target runtime is ScriptRunner for Jira Cloud.
- Use `confluence-cloud.md` when the target runtime is ScriptRunner for Confluence Cloud.
- Use `data-center.md` when the target runtime is ScriptRunner for Jira Data Center or when you need to understand source Jira Data Center semantics.
- For Jira Data Center to Cloud migration work, load `data-center.md` first, then the target product's Cloud guidance.
- For Confluence Data Center to Cloud migration work, use `references/INDEX-CONFLUENCE-DATA-CENTER.md` in the `scriptrunner-documentation` skill for the source semantics, then `confluence-cloud.md` for the target. Confluence Data Center has no guidance file, and `data-center.md` describes Jira Data Center only.
