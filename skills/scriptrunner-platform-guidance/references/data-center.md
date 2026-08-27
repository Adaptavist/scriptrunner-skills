<platform_guidance>
<context>
ScriptRunner for Jira Data Center combines the HAPI DSL with unrestricted access to Atlassian's Java APIs via `ComponentAccessor`. You can mix high-level HAPI conveniences with low-level Java services to meet complex enterprise requirements.
</context>

    <hybrid_api_strengths>
        <extension_methods_lookup>
            HAPI exposes many Data Center-only extension classes. Look up helpers such as:
            - `com.adaptavist.hapi.jira.extensions.IssueExtensions`
            - `com.adaptavist.hapi.jira.extensions.MutableIssueExtensions`
            - `com.adaptavist.hapi.jira.extensions.UserExtensions`
            - `com.adaptavist.hapi.jira.extensions.BoardExtensions`
            These provide richer capabilities than their Cloud counterparts and are often the fastest path to a solution.
        </extension_methods_lookup>

        <java_api_fallback>
            When HAPI does not expose the functionality you need, fall back to Jira's Java API. Leverage your knowledge of server-side services, look up the relevant classes, and stitch them together with HAPI where it improves clarity.
        </java_api_fallback>
    </hybrid_api_strengths>

    <component_accessor_integration>
        <integration_approach>
            1. Identify the Jira managers or services you need and inspect them with `look_up_api`.
            2. Combine HAPI calls with direct Java API usage when you require advanced behaviour or performance.
            3. Reflect after each lookup to decide which service or class to explore next.
        </integration_approach>

        <api_knowledge_application>
            When formal documentation is sparse, rely on established Jira Server/Datacenter patterns, then verify each class or method with tool lookups before writing code.
        </api_knowledge_application>
    </component_accessor_integration>

    <secure_html_generation>
        <output_formatter_usage>
            Use `com.onresolve.scriptrunner.canned.util.OutputFormatter` whenever you render HTML (for example in reports, dashboards, or emails). This helper automatically escapes user-supplied values and prevents XSS.
        </output_formatter_usage>

        <secure_html_example>
            ```groovy
            import com.onresolve.scriptrunner.canned.util.OutputFormatter

            OutputFormatter.markupBuilder {
                table(class: "aui") {
                    thead { tr { th("Project Key") } }
                    tbody {
                        Projects.allProjects.each { project ->
                            tr { td(project.key) }
                        }
                    }
                }
            }
            ```
        </secure_html_example>
    </secure_html_generation>

    <data_center_practices>
        <logging_standards>
            Use the preconfigured `log` instance (`log.warn`, `log.info`, `log.error`) for diagnostics. This matches on-prem logging expectations and integrates with server logs.
        </logging_standards>

        <workflow_optimization>
            Minimize unnecessary reindexing and expensive updates. In workflow post functions prefer `issue.set { }` over `issue.update { }` when you only need to adjust fields, and batch HAPI/Java operations when possible.
        </workflow_optimization>
    </data_center_practices>

</platform_guidance>
