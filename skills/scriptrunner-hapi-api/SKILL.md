---
name: scriptrunner-hapi-api
description: Local, version-pinned ScriptRunner HAPI API lookup for Jira Cloud and Confluence Cloud. Use when writing or reviewing HAPI Groovy, resolving classes or methods, inspecting @DelegatesTo closure APIs, checking return types, or verifying whether a Jira or Confluence HAPI capability exists.
metadata:
    author: sms-core
    version: '1.0'
    hapi-version: '0.2.104'
    hapi-sha256: '15a925b32e27cd1ff77d7f2d62b1855b2b3115160ba78354f94e058252dcec74'
---

# ScriptRunner HAPI API Skill

Use the bundled HAPI JAR as the authority for available Cloud HAPI bytecode signatures. The normal lookup command reads class files with `javap`; it does not load or execute HAPI classes.

## Required workflow

1. Read the target product guidance from `scriptrunner-platform-guidance` first.
2. Find a class when necessary:
   - `sms-hapi-lookup --product jira --search Issues`
   - `sms-hapi-lookup --product confluence --search Pages`
3. Inspect every class used by generated HAPI code:
   - `sms-hapi-lookup --product jira com.adaptavist.hapi.cloud.jira.issues.Issues`
   - `sms-hapi-lookup --product confluence com.adaptavist.hapi.cloud.confluence.pages.Pages`
4. Use `--member <name>` to narrow large classes. The command follows HAPI superclasses and `@DelegatesTo` targets by default; with `--depth 0` it still names them under "Related but not expanded" so nothing is hidden.
5. Inspect return types before chaining. Run a separate lookup for a returned HAPI class when its members are not already shown.
6. Pair signature evidence with the bundled ScriptRunner documentation for behaviour, examples, permissions, and platform constraints. A method's presence does not prove it is appropriate in every script context.
7. Validate the final Groovy with `sms-groovy-check --platform cloud --product jira|confluence --context <context>`.

## Commands

- `sms-hapi-lookup <class>` — inspect an FQCN or an unambiguous simple class name.
- `sms-hapi-lookup <class> --member <name>` — show matching members and related delegate types.
- `sms-hapi-lookup --search <term> [--product jira|confluence]` — search the bundled class index.
- `sms-hapi-lookup --version` — print the exact artifact coordinate and SHA-256.
- `sms-hapi-lookup --self-test` — verify that Java can inspect Jira and Confluence classes at the baked VM paths; the runtime entrypoint runs this automatically.
- `sms-hapi-lookup <class> --raw` — print verbose `javap` metadata for difficult generic or annotation questions.

## Interpretation rules

- Prefer exact observed signatures over memory or examples written for another HAPI version.
- Closure parameters annotated with `@DelegatesTo` expose the delegate class's public methods inside the closure.
- Ignore Groovy compiler plumbing such as `getMetaClass`, `setMetaClass`, `$getLookup`, and `__$stMC`; the normal command filters it.
- Always follow up on classes listed under "Related but not expanded"; the depth and size limits never hide names, only member detail.
- Groovy plumbing classes (closures, anonymous classes, trait helpers) are hidden from normal search but remain addressable by exact FQCN for diagnostics.
- This artifact covers Jira Cloud and Confluence Cloud. It is not a Jira or Confluence Data Center Java API reference.
- Never modify, execute, upload, or replace the bundled JAR. Do not pass untrusted option-like text as a class name.

## Artifact

- Coordinate: `com.adaptavist.scriptrunner.cloud:hapi:0.2.104`
- Version: `0.2.104`
- SHA-256: `15a925b32e27cd1ff77d7f2d62b1855b2b3115160ba78354f94e058252dcec74`
- Indexed HAPI and API model classes: 3631
- JAR: `assets/hapi-0.2.104.jar`
- Class index: `assets/classes.json`
- Machine-readable provenance: `assets/artifact.json`
