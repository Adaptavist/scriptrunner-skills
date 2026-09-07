---
name: scriptrunner-documentation
description: Local ScriptRunner documentation bundle for Jira Cloud, Confluence Cloud, ScriptRunner Connect, Jira Data Center, and ScriptRunner Migration Suite. Use when users ask about ScriptRunner capabilities, setup, migrations, Migration Suite workflows, Dev and Deployment Tool guidance, REST integrations, listeners, macros, behaviours, jobs, or platform-specific constraints.
metadata:
    author: sms-core
    version: '1.0'
    generated-doc-count: '355'
    generated-cloud-doc-count: '150'
    generated-confluence-cloud-doc-count: '106'
    generated-connect-doc-count: '65'
    generated-data-center-doc-count: '0'
    generated-migration-suite-doc-count: '34'
---

# ScriptRunner Documentation Skill

Use this skill for bundled local documentation. Prefer it over remote documentation search tools.

## Activation signals

- User asks how a ScriptRunner feature works.
- User needs product documentation evidence before migration or implementation work.
- User asks for platform-specific behavior, limitations, or supported contexts.

## Workflow

1. Open `references/ROUTING.md` first.
2. Read the relevant platform index:
    - `references/INDEX-CLOUD.md`
    - `references/INDEX-CONFLUENCE-CLOUD.md`
    - `references/INDEX-CONNECT.md`
    - `references/INDEX-DATA-CENTER.md`
    - `references/INDEX-MIGRATION-SUITE.md`
3. Use focused local reads against the matching files in `references/docs/...`.
4. Use a subagent only for bounded discovery across a large search space. Ask it for concise findings, local file paths, original source URLs, headings, and line ranges, not full file contents.
5. Cite both the local file path and the original source URL when answering.

## Resource map

- `references/ROUTING.md` - first-pass routing guidance.
- `references/INDEX-CLOUD.md` - Cloud page inventory.
- `references/INDEX-CONFLUENCE-CLOUD.md` - ScriptRunner for Confluence Cloud page inventory.
- `references/INDEX-CONNECT.md` - ScriptRunner Connect page inventory.
- `references/INDEX-DATA-CENTER.md` - Data Center page inventory.
- `references/INDEX-MIGRATION-SUITE.md` - ScriptRunner Migration Suite and Dev and Deployment Tool page inventory.
- `references/docs/...` - extracted page-level documentation.
- `assets/documents.json` - machine-readable manifest.

## Notes

- Prefer index-first lookup, then open only the 1-3 most relevant files.
- Use local file paths to direct subagents precisely when discovery benefits from parallelism.
- Do not ask subagents to return full documentation pages or large excerpts; the parent agent should perform any final focused reads directly.
- Keep platform assumptions explicit.
