# Detect Broken Filters Using an Analyzer

- Platform: cloud
- Space: SR4JC
- Hierarchy: Features > ScriptRunner Enhanced Search > Troubleshoot ScriptRunner Enhanced Search
- Doc ID: doc-sr4jc-e0cb4917-2166-4e4f-9291-e29858baefd0-6a181cb673011ecc
- Source: https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search#troubleshoot-scriptrunner-enhanced-search--en#detect-broken-filters-using-an-analyzer--en

If a filter requires attention, an error symbol indicator appears alongside it.

This indicator:

-   Highlights filters that are at high risk of failing during migration.
-   Includes a link to additional information about the issue.

Note:

There are two limits:

-   Result limit of 1,000 issues
-   Timeout limit of 55 seconds

Both of these limits are per precomputation. A precomputation is an individual use of an Enhanced Search function. Filters can contain multiple precomputations, and each one can return up to 1,000 issues and run for 55 seconds.

Example: `issueFunction` in `linkedIssuesOf("project = test")` and `issueFunction` in `addedAfterSprintStart(1)`. Each use of a function, or precomputation, can return 1000 issues, so the entire filter could return 2,000 issues since there are two. For timeout limits, each function, or precomputation, can take 55 seconds to process. They will run at the same time.

Each symbol relates to a different error type:

|  |  |
| --- | --- |
| Results exceeding 1,000 issues |  |
| Taking 55 seconds or longer to load |  |
| Returning errors |  |

Once the issue is resolved, the indicator will disappear.

## Fixing broken filters

You must review and update your saved filters that have been flagged with an error symbol. Refer to the [Troubleshoot](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/troubleshoot-scriptrunner-enhanced-search) section for guidance on resolving filter errors or other issues.
