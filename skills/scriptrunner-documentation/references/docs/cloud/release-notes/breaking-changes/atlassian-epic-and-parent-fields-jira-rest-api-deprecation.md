# Atlassian Epic and Parent Fields Jira REST API Deprecation

- Platform: cloud
- Space: SR4JC
- Hierarchy: release-notes > breaking-changes
- Doc ID: doc-sr4jc-375193781
- Source: https://docs.adaptavist.com/sr4jc/latest/release-notes/breaking-changes/atlassian-epic-and-parent-fields-jira-rest-api-deprecation

Atlassian have announced that parent and child issue associations are being standardised for company-managed and team-managed projects. As a result, they are deprecating the `Epic Link` and `Parent Link` custom fields in the REST API and webhooks.

## Rewrite scripts with HAPI

We recommend using [HAPI](https://docs.adaptavist.com/sr4jc/latest/hapi) to access issues and their fields. HAPI gives you full access to all fields of the `Parent` issue, simplifies your code, improves readability, and helps safeguard it against future Atlassian deprecations.

You'll see these fields when working with Jira issues. See the before and after deprecation examples below:

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

Similarly, with the `Parent` link, you can use HAPI to replace its usages and get access to the issue fields of the parent object.

Atlassian has published a detailed guide that provides examples, various API responses, and information on how they’re changing. For cases where rewriting the code to use HAPI isn’t straightforward, please refer to the guidance in [Atlassian's documentation](https://community.developer.atlassian.com/t/deprecation-of-the-epic-link-parent-link-and-other-related-fields-in-rest-apis-and-webhooks/54048).  

## Endpoints with fields deprecated

### Issue retrieval APIs

Endpoints affected

Recommended alternative field

Type

`GET /rest/api/[2|3]/issue/{issueIdOrKey}`  
Deprecated fields:

-   `customfield_10014` `(Epic Link)`
    
-   `` `customfield_10018` (Parent Link) ``
    
-   `epic`
    

`Parent`

Company-managed projects

### Issue creation & update APIs

Endpoints affected

Recommended alternative field

Type 

-   `POST /rest/api/[2|3]/issue`
-   `POST /rest/api/[2|3]/issue/bulk`
-   `PUT /rest/api/[2|3]/issue/{issueIdOrKey}`  
    Deprecated fields:  
    -   `customfield_10014` (Epic Link)
    -   `customfield_10018` (Parent Link)

`Parent`

Company-managed projects and team-managed projects

### Issue type metadata APIs

Endpoints affected

Recommended alternative field

`POST /rest/api/[2|3]/issuetype`  
Deprecated field:

-   `type`
    

`hierarchyLevel`

## Webhooks affected

All webhook events where the payload includes issues with their fields for company-managed projects:

-   issuelink\_created \*
    
-   issuelink\_deleted \*
    
-   jira:issue\_created
    
-   jira:issue\_updated
    

\* Where style is: `jira_gh_epic_story` or `jira_subtask.`

### Issue d**ata**

Webhook payloads affected

Recommended alternative field

Type 

All webhook events returning issue fields (e.g., `jira:issue_created`, `jira:issue_updated`, etc.)  
Deprecated fields:

-   `Epic Link`
    
-   `Parent Link`
    
-   `epic`
    

`Parent`

Company-managed projects

### Issue l**inks**

Events affected

Recommended alternative field

Type

`issuelink_created` and `issuelink_deleted`  
Deprecated styles:

-   `jira_gh_epic_story`
    
-   `jira_subtask`
    

-   Use `parent` field from `jira:issue_created` or `jira:issue_updated`
    
-   Use `changelog` → `IssueParentAssociation`
    

Company-managed projects and team-managed projects

### **Changelog**

Events affected

Recommended alternative field

Type

Any webhook with changelog (e.g., `jira:issue_updated`)  
Deprecated changelog fields:

-   `Epic Link`
    
-   `Parent Link`
    
-   `Parent`
    

`IssueParentAssociation`

Company-managed projects and team-managed projects
