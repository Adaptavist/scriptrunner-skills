# GDPR Migration

- Platform: confluence-cloud
- Space: SR4CC
- Hierarchy: migration
- Doc ID: doc-sr4cc-112159983
- Source: https://docs.adaptavist.com/sr4cc/latest/migration/gdpr-migration

Atlassian Cloud REST APIs were updated in response to the General Data Protection Regulation (GDPR) legislation.

If you are using ScriptRunner for Confluence Cloud, you must update any scripts that inspect or modify user fields when interacting with the Cloud REST APIs.

The full details of the changes Atlassian made can be found on the [Deprecation notice and migration guide for major changes to Confluence Cloud REST APIs to improve user privacy](https://developer.atlassian.com/cloud/confluence/deprecation-notice-user-privacy-api-migration-guide/).

## What Changed?

Atlassian removed the userkey and username from their REST APIs, webhooks, and CQL.

From 29th April 2019, it is no longer possible to identify a user based on their username or userkey.

Additionally, there are new privacy settings that each user may use to control whether their display name and email address are available to add-ons.

## What Do I Need to Do?

-   If your scripts refer to a user by their username or userkey (e.g. when setting the value of a user field on an issue adding a watcher to some content), those scripts need to be updated to use accountIds instead.
    
-   If you run a CQL query from within your script and that query refers to a user field, that query must be updated to use accountIds instead of userkeys or usernames.
    
-   If your scripts read/inspect the value of a user field in order to make a decision, you must update your script to only inspect the accountId property of the user field.
    
-   If your scripts make REST API calls to endpoints that take a username or userkey as a query parameter, those REST API requests must be updated to use the new query parameter for accountId as documented in the [migration guide](https://developer.atlassian.com/cloud/confluence/deprecation-notice-user-privacy-api-migration-guide/).
    
-   If your scripts read the email address of users, those scripts need to be modified to handle null email addresses (because individual users may change their privacy settings so that ScriptRunner cannot view the email address)
    

In other words, only the accountId will be a valid way to set the user on one of those Confluence entities, and only the accountId will be a guaranteed way to identify the user specified for that Confluence entity.

## Can Adaptavist Help Me?

Yes, we have released a migration tool within ScriptRunner that tells you which scripts we think you need to update and which user fields those scripts reference.

If you have scripts that we think need updating, you’ll see the following banner in the ScriptRunner admin section of your Confluence Cloud instance.

Once you click on the _Show_ S_cripts_ link at the bottom of the banner, you see this modal dialog which tells you which scripts we think need updating and which user properties those scripts reference. You can click on the name of a script to go to the edit page for that script.

## Examples

Here a few examples of scripts before and after the GDPR migration that you need to do. You can find accountIds by searching for users in the /people section of your Confluence Cloud instance.

### Setting a user as a watcher

```
// Before 29th April 2019

def contentId = blog.id
def username = 'bsimpson'
def result = post("/wiki/rest/api/user/watch/content/${contentId}")
        .header('Content-Type', 'application/json')
        .queryString("username", username)
        .asString()

/* -------------------------------------------------------------------------------- */

// After 29th April 2019 the REST APIs will not accept username or userKey in query parameters

def contentId = blog.id
def accountId = '123456:12345a67-bbb1-12c3-dd45-678ee99f99g0'
def result = post("/wiki/rest/api/user/watch/content/${contentId}")
        .header('Content-Type', 'application/json')
        .queryString("accountId", accountId)
        .asString()
```

  

### Inspecting user details on a blog Script Listener

```
// Before 29th April 2019

logger.info("'${blog.title}' was written by ${blog.creatorName}")

/* -------------------------------------------------------------------------------- */

// After 29th April 2019 the creatorName and creatorKey properties won't exist any more on webhooks from Confluence

logger.info("'${blog.title}' was written by ${blog.creatorAccountId}")
```

### Inspecting user details on content from the REST API

```
// Before 29th April 2019

def resp = get("/wiki/rest/api/content/${contentId}")
    .asObject(Map)
    .body

logger.info("${resp.version.by.username} made change #${resp.version.number} to '${resp.title}'")

/* -------------------------------------------------------------------------------- */

// After 29th April 2019 the REST APIs will only return accountId and displayName (this may be hidden by privacy controls)

def resp = get("/wiki/rest/api/content/${contentId}")
        .asObject(Map)
        .body

logger.info("${resp.version.by.accountId} made change #${resp.version.number} to '${resp.title}'")

// or

logger.info("${resp.version.by.displayName} made change #${resp.version.number} to '${resp.title}'")
```

### Searching for content based on a user

```
// Before 29th April 2019

def username = 'bsimpson'
def query = "type = comment AND creator = ${username}"
def result = get("/wiki/rest/api/search")
        .queryString("cql", query)
        .asObject(Map)

/* -------------------------------------------------------------------------------- */

// After 29th April 2019 CQL queries will only support accountIds to identify users

def user = '123450:pqrst-98765-uvwxyz-43210-abc'
def query = "type = comment AND creator = ${user}"
def result = get("/wiki/rest/api/search")
        .queryString("cql", query)
        .asObject(Map)
```
