# Atlassian Epic and Parent Fields Jira REST API Deprecation

- Platform: cloud
- Space: SR4JC
- Hierarchy: Release Notes > Breaking Changes
- Doc ID: doc-sr4jc-91ebe8ac-8573-4f18-9b7e-b83c8edfba26-5118dd42f5ee90c1
- Source: https://docs.adaptavist.com/sr4jc/latest/release-notes/breaking-changes#atlassian-epic-and-parent-fields-jira-rest-api-deprecation--en

Atlassian have announced that parent and child issue associations are being standardised for company-managed and team-managed projects. As a result, they are deprecating the `Epic Link` and `Parent Link` custom fields in the REST API and webhooks.

## Rewrite scripts with HAPI

We recommend using [HAPI](../../uncategorized/h/hapi.md) to access issues and their fields. HAPI gives you full access to all fields of the `Parent` issue, simplifies your code, improves readability, and helps safeguard it against future Atlassian deprecations.

You'll see these fields when working with Jira issues. See the before and after deprecation examples below:

-   [(Before) Non-HAPI](https://docs.adaptavist.com/sr4jc/latest/release-notes/breaking-changes/atlassian-epic-and-parent-fields-jira-rest-api-deprecation#concept-2934--en__codeblock-2072)
-   [(After) HAPI](https://docs.adaptavist.com/sr4jc/latest/release-notes/breaking-changes/atlassian-epic-and-parent-fields-jira-rest-api-deprecation#concept-2934--en__codeblock-2077)

```
def issueKey = 'TEST-1'
def issue = get("/rest/api/2/issue/${issueKey}")
  .header('Content-Type', 'application/json')
  .asObject(Map)
  
//get Epic Link
def epic = issue.fields.customfield_10014
epic
```

```
def issueKey = 'TEST-1'
def issue = Issues.getByKey(issueKey)
issue.getParentObject().getKey()
```

Similarly, with the `Parent` link, you can use HAPI to replace its usages and get access to the issue fields of the parent object.

Atlassian has published a detailed guide that provides examples, various API responses, and information on how they're changing. For cases where rewriting the code to use HAPI isn't straightforward, please refer to the guidance in [Atlassian's documentation](https://community.developer.atlassian.com/t/deprecation-of-the-epic-link-parent-link-and-other-related-fields-in-rest-apis-and-webhooks/54048).

## Endpoints with fields deprecated

### Issue retrieval APIs

<table class="table" id="issue-retrieval-apis--en__generated-table-id-1"><caption></caption><thead class="thead"><tr class="row"><th class="entry" id="issue-retrieval-apis--en__generated-table-id-1__entry__1">Endpoints affected</th><th class="entry" id="issue-retrieval-apis--en__generated-table-id-1__entry__2">Recommended alternative field</th><th class="entry" id="issue-retrieval-apis--en__generated-table-id-1__entry__3">Type</th></tr></thead><tbody class="tbody"><tr class="row"><td class="entry" headers="issue-retrieval-apis--en__generated-table-id-1__entry__1 issue-retrieval-apis--en__generated-table-id-1__entry__2 issue-retrieval-apis--en__generated-table-id-1__entry__3 ">&#10;                                <p class="p"><code class="ph codeph">GET /rest/api/[2|3]/issue/{issueIdOrKey}</code>&#10;                                </p>&#10;                                <p class="p">Deprecated fields:</p>&#10;                                <ul class="ul"><li class="li"><code class="ph codeph">customfield_10014</code> <code class="ph codeph">(Epic Link)</code></li><li class="li"><code class="ph codeph">`customfield_10018` (Parent Link)</code></li><li class="li"><code class="ph codeph">epic</code></li></ul>&#10;                            </td><td class="entry" headers="issue-retrieval-apis--en__generated-table-id-1__entry__1 issue-retrieval-apis--en__generated-table-id-1__entry__2 issue-retrieval-apis--en__generated-table-id-1__entry__3 "><code class="ph codeph">Parent</code>&#10;                            </td><td class="entry" headers="issue-retrieval-apis--en__generated-table-id-1__entry__1 issue-retrieval-apis--en__generated-table-id-1__entry__2 issue-retrieval-apis--en__generated-table-id-1__entry__3 ">Company-managed projects</td></tr></tbody></table>

### Issue creation & update APIs

<table class="table" id="issue-creation-update-apis--en__generated-table-id-1"><caption></caption><thead class="thead"><tr class="row"><th class="entry" id="issue-creation-update-apis--en__generated-table-id-1__entry__1">Endpoints affected</th><th class="entry" id="issue-creation-update-apis--en__generated-table-id-1__entry__2">Recommended alternative field</th><th class="entry" id="issue-creation-update-apis--en__generated-table-id-1__entry__3">Type</th></tr></thead><tbody class="tbody"><tr class="row"><td class="entry" headers="issue-creation-update-apis--en__generated-table-id-1__entry__1 issue-creation-update-apis--en__generated-table-id-1__entry__2 issue-creation-update-apis--en__generated-table-id-1__entry__3 ">&#10;                                <ul class="ul"><li class="li"><code class="ph codeph">POST /rest/api/[2|3]/issue</code></li><li class="li"><code class="ph codeph">POST /rest/api/[2|3]/issue/bulk</code></li><li class="li"><code class="ph codeph">PUT /rest/api/[2|3]/issue/{issueIdOrKey}</code></li></ul>&#10;                                <p class="p">Deprecated fields:</p>&#10;                                <ul class="ul"><li class="li"><code class="ph codeph">customfield_10014</code> (Epic Link) </li><li class="li"><code class="ph codeph">customfield_10018</code> (Parent Link) </li></ul>&#10;                            </td><td class="entry" headers="issue-creation-update-apis--en__generated-table-id-1__entry__1 issue-creation-update-apis--en__generated-table-id-1__entry__2 issue-creation-update-apis--en__generated-table-id-1__entry__3 "> <code class="ph codeph">Parent</code>&#10;                            </td><td class="entry" headers="issue-creation-update-apis--en__generated-table-id-1__entry__1 issue-creation-update-apis--en__generated-table-id-1__entry__2 issue-creation-update-apis--en__generated-table-id-1__entry__3 ">Company-managed projects and team-managed projects</td></tr></tbody></table>

### Issue type metadata APIs

<table class="table" id="issue-type-metadata-apis--en__generated-table-id-1"><caption></caption><thead class="thead"><tr class="row"><th class="entry" id="issue-type-metadata-apis--en__generated-table-id-1__entry__1">Endpoints affected</th><th class="entry" id="issue-type-metadata-apis--en__generated-table-id-1__entry__2">Recommended alternative field</th></tr></thead><tbody class="tbody"><tr class="row"><td class="entry" headers="issue-type-metadata-apis--en__generated-table-id-1__entry__1 issue-type-metadata-apis--en__generated-table-id-1__entry__2 ">&#10;                <p class="p"><code class="ph codeph">POST /rest/api/[2|3]/issuetype</code></p>&#10;                <p class="p">Deprecated field:</p>&#10;                <ul class="ul"><li class="li"><code class="ph codeph">type</code></li></ul>&#10;              </td><td class="entry" headers="issue-type-metadata-apis--en__generated-table-id-1__entry__1 issue-type-metadata-apis--en__generated-table-id-1__entry__2 ">&#10;                <code class="ph codeph">hierarchyLevel</code>&#10;              </td></tr></tbody></table>

## Webhooks affected

All webhook events where the payload includes issues with their fields for company-managed projects:

-   issuelink\_created \*
-   issuelink\_deleted \*
-   jira:issue\_created
-   jira:issue\_updated

\* Where style is: `jira_gh_epic_story` or `jira_subtask.`

### Issue data

<table class="table" id="issue-data--en__generated-table-id-1"><caption></caption><thead class="thead"><tr class="row"><th class="entry" id="issue-data--en__generated-table-id-1__entry__1">Webhook payloads affected</th><th class="entry" id="issue-data--en__generated-table-id-1__entry__2">Recommended alternative field</th><th class="entry" id="issue-data--en__generated-table-id-1__entry__3">Type</th></tr></thead><tbody class="tbody"><tr class="row"><td class="entry" headers="issue-data--en__generated-table-id-1__entry__1 issue-data--en__generated-table-id-1__entry__2 issue-data--en__generated-table-id-1__entry__3 ">&#10;                                <p class="p">All webhook events returning issue fields (e.g., <code class="ph codeph">jira:issue_created</code>, <code class="ph codeph">jira:issue_updated</code>, etc.) </p>&#10;                                <p class="p">Deprecated fields:</p>&#10;                                <ul class="ul"><li class="li"><code class="ph codeph">Epic Link</code></li><li class="li"><code class="ph codeph">Parent Link</code></li><li class="li"><code class="ph codeph">epic</code></li></ul>&#10;                            </td><td class="entry" headers="issue-data--en__generated-table-id-1__entry__1 issue-data--en__generated-table-id-1__entry__2 issue-data--en__generated-table-id-1__entry__3 "><code class="ph codeph">Parent</code></td><td class="entry" headers="issue-data--en__generated-table-id-1__entry__1 issue-data--en__generated-table-id-1__entry__2 issue-data--en__generated-table-id-1__entry__3 ">Company-managed projects</td></tr></tbody></table>

### Issue links

<table class="table" id="issue-links--en__generated-table-id-1"><caption></caption><thead class="thead"><tr class="row"><th class="entry" id="issue-links--en__generated-table-id-1__entry__1">Events affected</th><th class="entry" id="issue-links--en__generated-table-id-1__entry__2">Recommended alternative field</th><th class="entry" id="issue-links--en__generated-table-id-1__entry__3">Type</th></tr></thead><tbody class="tbody"><tr class="row"><td class="entry" headers="issue-links--en__generated-table-id-1__entry__1 issue-links--en__generated-table-id-1__entry__2 issue-links--en__generated-table-id-1__entry__3 ">&#10;                            <p class="p"><code class="ph codeph">issuelink_created</code> and <code class="ph codeph">issuelink_deleted</code></p>&#10;                            <p class="p">Deprecated styles:</p>&#10;                            <ul class="ul"><li class="li"><code class="ph codeph">jira_gh_epic_story</code></li><li class="li"><code class="ph codeph">jira_subtask</code></li></ul>&#10;                        </td><td class="entry" headers="issue-links--en__generated-table-id-1__entry__1 issue-links--en__generated-table-id-1__entry__2 issue-links--en__generated-table-id-1__entry__3 ">&#10;                            <ul class="ul"><li class="li">Use <code class="ph codeph">parent</code> field from <code class="ph codeph">jira:issue_created</code> or <code class="ph codeph">jira:issue_updated</code></li><li class="li">Use <code class="ph codeph">changelog</code> → <code class="ph codeph">IssueParentAssociation</code></li></ul>&#10;                        </td><td class="entry" headers="issue-links--en__generated-table-id-1__entry__1 issue-links--en__generated-table-id-1__entry__2 issue-links--en__generated-table-id-1__entry__3 ">Company-managed projects and team-managed projects</td></tr></tbody></table>

### Changelog

<table class="table" id="changelog--en__generated-table-id-1"><caption></caption><thead class="thead"><tr class="row"><th class="entry" id="changelog--en__generated-table-id-1__entry__1">Events affected</th><th class="entry" id="changelog--en__generated-table-id-1__entry__2">Recommended alternative field</th><th class="entry" id="changelog--en__generated-table-id-1__entry__3">Type</th></tr></thead><tbody class="tbody"><tr class="row"><td class="entry" headers="changelog--en__generated-table-id-1__entry__1 changelog--en__generated-table-id-1__entry__2 changelog--en__generated-table-id-1__entry__3 ">&#10;                            <p class="p">Any webhook with changelog (e.g., <code class="ph codeph">jira:issue_updated</code>) </p>&#10;                            <p class="p">Deprecated changelog fields:</p>&#10;                            <ul class="ul"><li class="li"><code class="ph codeph">Epic Link</code></li><li class="li"><code class="ph codeph">Parent Link</code></li><li class="li"><code class="ph codeph">Parent</code></li></ul>&#10;                        </td><td class="entry" headers="changelog--en__generated-table-id-1__entry__1 changelog--en__generated-table-id-1__entry__2 changelog--en__generated-table-id-1__entry__3 "> <code class="ph codeph">IssueParentAssociation</code>&#10;                        </td><td class="entry" headers="changelog--en__generated-table-id-1__entry__1 changelog--en__generated-table-id-1__entry__2 changelog--en__generated-table-id-1__entry__3 ">Company-managed projects and team-managed projects</td></tr></tbody></table>
