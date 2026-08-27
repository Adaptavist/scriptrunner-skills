---
name: scriptrunner-platform-guidance
description: Local ScriptRunner platform and product guidance for Jira Cloud, Confluence Cloud, and Jira Data Center. Use before platform-specific implementation, migration analysis, Confluence scripting, or Data Center to Cloud conversion work.
metadata:
    author: sms-core
    version: '1.0'
---

# ScriptRunner Platform Guidance Skill

Use this skill whenever you need ScriptRunner platform operating rules.

## Activation Signals

- The user asks for ScriptRunner for Jira or Confluence implementation help on Cloud or Data Center.
- The user asks for a Data Center to Cloud migration or conversion.
- The task involves HAPI, Java APIs, REST APIs, Behaviours, workflow functions, listeners, CQL jobs, custom macros, scripted fields, or Dev and Deployment YAML.

## Workflow

1. Identify the source and target platforms and products.
2. Read `references/INDEX.md`.
3. Read the matching guidance file:
    - `references/cloud.md` for ScriptRunner for Jira Cloud.
    - `references/confluence-cloud.md` for ScriptRunner for Confluence Cloud.
    - `references/data-center.md` for ScriptRunner for Jira Data Center.
4. For Data Center to Cloud migrations, read `references/data-center.md` and the target product's Cloud guidance before producing code: Data Center explains the source semantics, while the Jira or Confluence Cloud file explains the target constraints.
5. Apply the guidance together with focused documentation, example, REST spec, and validator lookups.

## Notes

- Keep platform and product assumptions explicit.
- The guidance files are intentionally complete prompt references. The full-read rule applies to platform guidance only, not product documentation, examples, or OpenAPI specs.
- When reading `references/cloud.md` or `references/confluence-cloud.md`, the read tool may cap the output and print an `offset` to continue. The parent agent must keep reading the selected guidance file with the suggested offsets until the output contains `(End of file` before producing code, running API lookups, or validating an answer. Do not delegate this full read to a subagent.
