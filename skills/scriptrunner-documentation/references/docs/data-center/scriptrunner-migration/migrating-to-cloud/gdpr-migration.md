# GDPR Migration

- Platform: data-center
- Space: SR4JS
- Hierarchy: scriptrunner-migration > migrating-to-cloud
- Doc ID: doc-sr4js-348414805
- Source: https://docs.adaptavist.com/sr4js/latest/scriptrunner-migration/migrating-to-cloud/gdpr-migration

Atlassian Cloud REST APIs were updated in response to the GDPR legislation.

Customers using ScriptRunner for Jira Cloud must update any scripts that inspect or modify user fields when interacting with the Cloud REST APIs.

The full details of the changes Atlassian made can be found on their [Deprecation notice and migration guide for major changes to Jira Cloud REST APIs to improve user privacy](https://developer.atlassian.com/cloud/jira/platform/deprecation-notice-user-privacy-api-migration-guide/).

## What Changed?

Atlassian removed the userkey and username from their REST APIs, webhooks and JQL.

From the 29th April 2019 it is no longer possible to identify a user based on their username or userkey.

Additionally there are new privacy settings that each user may use to control whether their display name and email address are available to add-ons.

## What Do I Need to Do?

1.  If your scripts refer to a user by their username or userkey (e.g. when setting the value of a user field on an issue), those scripts need updating to use accountIds instead.
    
2.  If you run a JQL query from within your script, and that query refers to a user field, that query must be updated to use accountIds instead of userkeys or usernames.
    
3.  If your scripts read/inspect the value of a user field in order to make a decision, you must update your script to only inspect the accountId property of the user field.
    
4.  If your scripts make REST API calls to endpoints that take a username or userkey as a query parameter, those REST API requests must be updated to use the new query parameter for accountId as documented in the [migration guide](https://developer.atlassian.com/cloud/jira/platform/deprecation-notice-user-privacy-api-migration-guide/).
    
5.  If your scripts read the email address of users, those scripts need to be modified to handle null email addresses (because individual users may change their privacy settings so that ScriptRunner cannot view the email address)
    

The system user fields for issues are: creator, assignee, reporter

Additionally: comment authors, project leads, component leads, component assignee, filter owners, filter shared users, group members and attachment authors are also affected by this change.

**In other words, only the accountId will be a valid way to set the user on one of those Jira entities, and only the accountId will be a guaranteed way to identify the user specified for that Jira entity.**

## Can Adaptavist Help Me?

Yes, we have released a migration tool within ScriptRunner that tells you which scripts we think you need to update and which user fields those scripts reference.

If you have scripts that we think need updating, you’ll see this banner in the ScriptRunner admin section of your Jira Cloud instance.

Once you click on the 'Show scripts' link at the bottom of the banner, you’ll see this modal dialog which will tell you which scripts we think need updating and which user-fields those scripts reference. You can click on the name of a script to go to the edit page for that script.

## What About Enhanced JQL Filters?

[Enhanced JQL Filters](#) will be automatically migrated by ScriptRunner to contain accountId references where usernames/userkeys are currently used.

The migrated version of each saved Enhanced Filter, including accountIds instead of usernames/userkeys, will be shown starting from the 29th April.

Matching user fields against full names or display names will work as normal after the GDPR deadline, subject to the new user privacy settings.

## What About JQL Keywords?

ScriptRunner provides a number of "[keywords](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search)" that can be used within regular Jira searches to filter issues based on additional issue data.

If you have any Jira filters that contain "commentedBy", "fileAttachedBy" or "lastCommentBy" then must be updated to use an accountId to reference users.

For example, if you have a Jira JQL filter that uses a username like this:

```
project = EXAMPLE AND fileAttachedBy = bsimpson
```

Then you’ll need to update that filter to use the equivalent accountId like this:

```
project = EXAMPLE AND fileAttachedBy = 123450:pqrst-98765-uvwxyz-43210-abc
```

## How Do I Make the Changes?

Here a few examples of scripts before and after the GDPR migration that you need to do. You can find accountIds by searching for users in the /people section of your Jira Cloud instance.

### Inspecting User Details on System Fields

```
// Before 29th April 2019

logger.info("${issue.field.reporter.name} reported issue ${issue.key}")
logger.info("${issue.field.creator.name} created issue ${issue.key}")
logger.info("${issue.field.assignee.name} is assigned to issue ${issue.key}")

/* -------------------------------------------------------------------------------- */

// After 29th April 2019 the name and key properties on reporter, creator and assignee will no longer exist

logger.info("${issue.field.reporter.displayName} reported issue ${issue.key}")
logger.info("${issue.field.creator.displayName} created issue ${issue.key}")
logger.info("${issue.field.assignee.displayName} is assigned to issue ${issue.key}")

// or

logger.info("${issue.field.reporter.accountId} reported issue ${issue.key}")
logger.info("${issue.field.creator.accountId} created issue ${issue.key}")
logger.info("${issue.field.assignee.accountId} is assigned to issue ${issue.key}")
```

### Inspecting User Details on Custom Fields

```
// Before 29th April 2019

logger.info("${issue.field.customfield_10234.name} approved this request")

def approvedCustomFieldId = get("/rest/api/2/field")
        .asObject(List)
        .body
        .find { it.custom && it.name == "Approved" }
        .id
def approved = issue.field[approvedCustomFieldId]
logger.info("${approved.name} approved this request")

/* -------------------------------------------------------------------------------- */

// After 29th April 2019 the name and key properties on custom user fields will no longer exist

logger.info("${issue.field.customfield_10234.displayName} approved this request")

def approvedCustomFieldId = get("/rest/api/2/field")
        .asObject(List)
        .body
        .find { it.custom && it.name == "Approved" }
        .id
def approved = issue.field[approvedCustomFieldId]
logger.info("${approved.displayName} approved this request")

// or

logger.info("${issue.field.customfield_10234.accountId} approved this request")

def approvedCustomFieldId = get("/rest/api/2/field")
        .asObject(List)
        .body
        .find { it.custom && it.name == "Approved" }
        .id
def approved = issue.field[approvedCustomFieldId]
logger.info("${approved.accountId} approved this request")
```

### Setting a User Field On an Issue

```
// Before 29th April 2019

def assignee = "bsimpson"

put("/rest/api/2/issue/${issue.key}")
        .header('Content-Type', 'application/json')
        .body([
            fields: [
                assignee: [
                    key: assignee
                ]
            ]
        ])
        .asObject(Map)

/* -------------------------------------------------------------------------------- */

// After 29th April 2019 you must use accountIds to identify users when updating/setting user fields

// this is Bart Simpson's accountId
def assignee = "123450:pqrst-98765-uvwxyz-43210-abc"

put("/rest/api/2/issue/${issue.key}")
        .header('Content-Type', 'application/json')
        .body([
            fields: [
                assignee: [
                    id: assignee
                ]
            ]
        ])
        .asObject(Map)
```

### Searching Using JQL That Contains a User Reference

```
// Before 29th April 2019

def query = "project = ${issue.fields.project.key} AND reporter = bsimpson"

def resp = get("/rest/api/2/search")
    .queryString("jql", query)
    .queryString("fields", 'priority')
    .asObject(Map)
    .body

logger.info("Found ${resp.total} issues assigned to Bart Simpson")

/* -------------------------------------------------------------------------------- */

// After 29th April 2019 JQL queries will only support accountIds to identify users

def query = "project = ${issue.fields.project.key} AND reporter = 123450:pqrst-98765-uvwxyz-43210-abc"

def resp = get("/rest/api/2/search")
        .queryString("jql", query)
        .queryString("fields", 'priority')
        .asObject(Map)
        .body

logger.info("Found ${resp.total} issues assigned to Bart Simpson")
```

### Inspecting User Email Addresses

```
// Before 29th April 2019

def issueKey = 'GDPR-123'
def firstComment = get("/rest/api/3/issue/${issueKey}/comment")
    .asObject(Map)
    .body
    .comments[0]

def commentAuthorEmail = firstComment.author.emailAddress
def commentUpdaterEmail = firstComment.updateAuthor.emailAddress

logger.info("The first comment on ${issueKey} was written by ${commentAuthorEmail} and updated by ${commentUpdaterEmail}")

/* -------------------------------------------------------------------------------- */

// After 29th April 2019 email addresses may be null, depending on users' privacy settings

def issueKey = 'GDPR-123'
def firstComment = get("/rest/api/3/issue/${issueKey}/comment")
        .asObject(Map)
        .body
        .comments[0]

def commentAuthorEmail = firstComment.author.emailAddress ?: 'email address hidden'
def commentUpdaterEmail = firstComment.updateAuthor.emailAddress ?: 'email address hidden'

logger.info("The first comment on ${issueKey} was written by ${commentAuthorEmail} and updated by ${commentUpdaterEmail}")
```

### Migrating Issue Updated changelog

```
// Get the fieldIds of the fields, which evaluate true to the condition.
static List<String> getFieldIds(List<Map> fields, Closure<Boolean> condition) {
    fields.findAll { it.schema && condition(it) }.collect { it.id }
}

// Get the values from a changelog, where the field evaluates true to the condition.
static List<String> getChangelogFieldValues(List<Map> changelogItems, List<String>fieldIds, Closure<List<String>> getValue) {
    return changelogItems.findAll{ it.fieldId in fieldIds }.collectMany {
        def results = []
        if (it.from) {
            results.add(getValue(it.from as String))
        }
        if (it.to) {
            results.add(getValue(it.to as String))
        }
        return results.collectMany { it }
    }
}

// Makes a request, to get the accountIds related to the userNames.
static List<Map> makeBulkMigrateRequest(Set<String> userNames) {
    String queryParameters = userNames.collect { "username=${it}" }.join("&")
    Unirest.get("/rest/api/2/user/bulk/migration?${queryParameters}").asObject(List).body
}

// Converts user names array string (`[<username1>, <username2>, ...]`) to a list ([username1, username2, ...]).
static List<String> getUserArrayFieldValues(String userNames) {
    userNames.substring(1, userNames.length() -1).trim().split(",").collect { it.trim() }
}

// Converts user names list ([username1, username2, ...]) to an array string (`[<username1>, <username2>, ...]`) .
static String createUserArrayFieldValues(List<String> values) {
    "[${values.join(', ')}]"
}

// Get the accountId for a user name.
static String getAccountId(List<Map> accountIds, String userName) {
    accountIds.find { it.username == userName }.accountId
}

// Migrate an array field value of user names to the same format of account ids.
static String migrateArrayField(List<Map> accountIds, String userNameArray) {
    if (userNameArray) {
        List<String> userNames = getUserArrayFieldValues(userNameArray as String)
        List<String> migratedAccountIds = userNames.collect { getAccountId(accountIds, it) }
        createUserArrayFieldValues(migratedAccountIds)
    } else {
        userNameArray
    }
}

// Migrate an user field value of user names to the same format of account ids.
static String migrateUserField(List<Map> accountIds, String userName) {
    if (userName) {
        getAccountId(accountIds, userName)
    } else {
        userName
    }
}

// Main method. Replaces the user names with account ids on user or user array type fields, in the changelog items.
Map migrateChangelog(Map changelog) {
    List<Map> fields = Unirest.get("/rest/api/2/field").asObject(List).body
    List<String> userFieldIds = getFieldIds(fields, { it.schema.type == 'user' })
    List<String> userArrayFieldIds = getFieldIds(fields, { it.schema.type == 'array' && it.schema.items == 'user' })

    List<String> userFieldNamesToMigrate = getChangelogFieldValues(
            changelog.items as List<Map>,
            userFieldIds,
            {
                [it as String]
            }
    )
    List<String> userArrayFieldNamesToMigrate = getChangelogFieldValues(
            changelog.items as List<Map>,
            userArrayFieldIds,
            {
                getUserArrayFieldValues(it as String)
            }
    )

    // Get unique user names
    Set<String> userNamesToMigrate = (userFieldNamesToMigrate + userArrayFieldNamesToMigrate).toSet()
    List<Map> accountIds = makeBulkMigrateRequest(userNamesToMigrate)

    // Replace the user names with account ids.
    changelog.items = changelog.items.collect {
        if (it.fieldId in userFieldIds) {
            it.from = migrateUserField(accountIds, it.from as String)
            it.to = migrateUserField(accountIds, it.to as String)
        }
        if (it.fieldId in userArrayFieldIds) {
            it.from = migrateArrayField(accountIds, it.from as String)
            it.to = migrateArrayField(accountIds, it.to as String)
        }
        it
    }

    changelog
}

migrateChangelog(changelog as Map)
```
