# Guardrails Built-in Scripts

- Platform: data-center
- Space: SR4JS
- Hierarchy: Features > Built-in scripts
- Doc ID: doc-sr4js-d451812c-12f2-4f6f-863d-78f54d39d5ad-93d8ac869884c2b0
- Source: https://docs.adaptavist.com/sr4js/latest/features#built-in-scripts--en#guardrails-built-in-scripts--en

Guardrails are suggested limits and thresholds that Atlassian recommend in order to keep your Jira instance performing well.

For example, they recommend a limit of 1000 comments per issue, and 7000 unarchived projects. You can read more about other guardrails and how they arrived at these figures [here](https://confluence.atlassian.com/adminjiraserver/jira-software-guardrails-1141488685.html).

It's not easy to check for guardrails that exceed the recommended guidelines using just Jira alone. With our _Guardrails_ built-in scripts and [guidance](../../best-practices/guardrails.md), you can check if certain guardrails exceed the recommended guidelines, and bring any that do within the correct limits.

## Guardrail built-in scripts

[Maximum Comments Per Issue](https://docs.adaptavist.com/sr4js/latest/features/built-in-scripts/guardrails-built-in-scripts/maximum-comments-per-issue)

Use this built-in script to find issues with more comments than the guardrail, and delete comments that exceed the threshold.

[Maximum Number of Unarchived Projects](https://docs.adaptavist.com/sr4js/latest/features/built-in-scripts/guardrails-built-in-scripts/maximum-number-of-unarchived-projects)

Use this built-in script to find projects that have not been updated for a specified amount of time, and archive them.

[Maximum Attachment Size](https://docs.adaptavist.com/sr4js/latest/features/built-in-scripts/guardrails-built-in-scripts/maximum-attachment-size)

Use this built-in script to find attachments over the specified size, and delete them.

[Maximum Number of Issue Links Per Issue](https://docs.adaptavist.com/sr4js/latest/features/built-in-scripts/guardrails-built-in-scripts/maximum-number-of-issue-links-per-issue)

Use this built-in script to find issues that contain more issue links than the recommended amount, and archive or delete the oldest.

[Maximum Change History Records Per Issue](https://docs.adaptavist.com/sr4js/latest/features/built-in-scripts/guardrails-built-in-scripts/maximum-change-history-records-per-issue)

Use this built-in script to find issues with change items that exceed the recommended amount, and delete the oldest.
