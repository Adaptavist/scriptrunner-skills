# Jira Expression Examples

The Jira expression examples highlighted in this section can be used for either conditions or validators and on all transitions unless noted otherwise.

## Framework Limitations

### Nested Conditions

Jira expressions do not support nested if statements. For example, the following expression will fail:

```jira-expression
if (issue.summary.length > 10 ) {
   if(issue.assignee) {
      // ...
   }
}
```

You can instead combine this into a single expression:

```jira-expression
if (issue.summary.length > 10 && issue.assignee) {
    // ...
}
```

> **Note:** Atlassian's new transition experience in Jira is being permanently rolled out in April 2025. As a consequence, how your Jira expressions (conditions and validators) work will change. Check out our Breaking Changes section for more information.

## Attachment Requirements

### Require Attachments

You want a PDF of the contract agreement attached to an issue before work can begin, so developers know what was agreed with the client. This script ensures at least one PDF file is attached before the Start Progress transition is available for the issue.

```jira-expression
issue.attachments.some(attachment => attachment.mimeType == 'application/pdf')
```

### Require Minimum Number of PDFs

If you want to require a specific minimum number of PDFs, use the following script:

```jira-expression
issue.attachments.filter(attachment => attachment.mimeType == 'application/pdf').length > 2
```

Edit `length > 0` to the minimum number of PDFs required.

### Issue Must Have at Least One PDF Attachment

```jira-expression
issue.attachments.some(attachment => attachment.mimeType == 'application/pdf')
```

### Issue Must Have at Least Three PDF Attachments

```jira-expression
issue.attachments.filter(attachment => attachment.mimeType == 'application/pdf').length > 3
```

### Require Attachments Added During Current Transition

```jira-expression
issue.attachments.filter(attachment => attachment.id == null).length == 3
```

Change `length == 3` to specify the minimum number of required attachments. The transition screen must be configured with the Attachments field, to allow users to submit the attachments during the transition.

### Require at least Two PDF Attachments During Current Transition

```jira-expression
issue.attachments.filter(attachment => attachment.id == null && attachment.mimeType == 'application/pdf').length > 1
```

## User and Permission Restrictions

### Restrict Transition Permissions

As a team lead, you want to restrict the transition of issues to specific status for certain user groups or project roles. This condition only shows a certain transition option to users belonging to the groups or roles specified.

#### Restrict to Project Role

```jira-expression
user.getProjectRoles(project).some(p => p.name == "userrole")
```

Replace `userrole` with the project role you want to be able to transition the issue (for example, Developers). Roles apply to projects only, whereas user groups are global.

#### Restrict to User Groups

```jira-expression
user.groups.includes('usergroup')
```

Replace `usergroup` with the group of users you want to be able to transition the issue (for example, Administrators).

### User Validation

#### Check Current User is in Specified List

```jira-expression
['User A','User B','User C'].includes(user.displayName)
```

#### Check Current User is in Specified Group List

```jira-expression
['Group A','Group B', 'Group C'].some(g => user.groups.includes(g))
```

#### Specify Current User Must be in Defined List of Users

The example checks by user account ID, but you can also use `user.displayName`:

```jira-expression
['accountIdHere', 'accountIdHere'].includes(user.accountId)
```

#### Current Logged-in User Has Added at Least One Comment

```jira-expression
issue.comments.some(c => c.author.accountId == user.accountId)
```

## Sub-Task Management

### Require Sub-Tasks

As a project manager, you want developers to add sub-tasks to issues so you can see the steps required to complete an issue. You want to prevent the transition of an issue if it has no sub-tasks. This script only shows the transition option if the issue has at least one sub-task.

```jira-expression
issue.subtasks.length > 0
```

Edit `length > 0` to the minimum number of sub-tasks required.

### Sub-Tasks Must be Done

You want to enforce that Done means all sub-tasks are completed by hiding the Done transition option of an issue when there are outstanding sub-tasks. This script only shows the transition option when all sub-tasks have the Done resolution.

```jira-expression
issue.subtasks.every(subtask => subtask.status.name == 'Done')
```

Edit `subtask.status.name == 'Done'` if you require a different sub-task resolution or status.

### Sub-Tasks Must Have Assignee

You want to make sure all sub-tasks have been assigned before the parent issue can be transitioned to In Progress. This script only shows the In Progress transition option on a parent issue when all sub-tasks have assignees.

```jira-expression
issue.subtasks.every(subtask => subtask.assignee != null)
```

### Sub-Tasks Must Be In Progress

As a project manager, you want to ensure all sub-tasks have been started before progress can start on the parent issue to keep issues aligned. Ensure all sub-tasks are In Progress before a parent issue can be transitioned to In Progress.

> **Note:** This example cannot be used on the Create transition. Use the Start Progress transition.

```jira-expression
issue.subtasks.every(subtask => subtask.status.name == 'In Progress')
```

### Subtask Type and Status

This expression checks whether all subtasks of a certain type are at a specific status:

```jira-expression
issue
    .subtasks
    .filter(s => s.issueType.name == 'Scope Change')
    .every(d => d.status.name == 'Done')
```

## Field Requirements

### Field(s) Required

For text fields, single, multi selects, and radio buttons, checkboxes, and cascading select fields:

```jira-expression
issue?.customfield_10040 != null
```

For cascading select field:

```jira-expression
// for parent value
issue?.customfield_10266?.value != null

// both parent and child (you cannot set the child without the parent)
issue?.customfield_10266?.child?.value != null
```

This example checks that a text field (possibly supporting rich text) is required:

```jira-expression
let plainTextValue = value => typeof value == 'Map' ? new RichText(value).plainText : value ;
plainTextValue(issue?.customfield_10080 != null) && plainTextValue(issue?.customfield_10080) != ''
```

### Multi-Select List or Checkbox Field Requirements

#### Must be Populated with Specific Value

You want to enforce that issues have a specific value selected in a multi-select list or checkbox before progressing.

```jira-expression
issue?.customfield_10263 ?
    issue?.customfield_10263.some(option => option.value == "End Users") :
    false
```

Replace `customfield_10263` in the example with the ID of the multi-select list or checkbox field of your instance. To find the custom field ID, navigate to `<JiraBaseURL>/secure/admin/ViewCustomFields.jspa` and Edit the required field. The field ID is shown.

#### Multi-Select or Checkbox Must be Populated with One Specific Value

```jira-expression
issue?.customfield_10214 ?
    issue?.customfield_10214.some(option => option.value == "A") :
    false
```

#### Multi-Select or Checkbox Field Equals Specific Set of Values

```jira-expression
issue?.customfield_10214 ?
    issue?.customfield_10214.map(option => option.value) == ['Yes', 'No'] :
    false
```

### One of Two Label Fields Must Have a Value

Note that you should replace 'customfield_12345' and 'customfield_67890' in the example below with IDs of the label fields inside your instance:

```jira-expression
issue?.customfield_12345 != null || issue?.customfield_67890 != null
```

Note that you can add an OR / AND logical operator where more than one field needs to be checked.

## User Field Validation

### User in Field(s)

This expression will check whether the current user is selected within a custom user picker field.

#### User Picker Single Select

```jira-expression
issue?.customfield_10213?.displayName == 'A User'

// or using accountId
issue?.customfield_10213?.accountId == '5cf7c174eba28b4ea84a7cb5'
```

#### User Picker Multi Select

```jira-expression
issue?.customfield_10219 ?
    issue?.customfield_10219.some(user => user.displayName == 'A User') :
    false
```

### Group Picker Fields

#### Group Picker Single Select

This expression will check whether the current user group is selected within a custom group picker field, either by account ID or username.

```jira-expression
issue?.customfield_10077?.name == 'jira-admins'
```

#### Group Picker Multi Select

```jira-expression
issue?.customfield_10078 ?
    issue?.customfield_10078.some(c => c.name == 'jira-admins') :
    false
```

## Text and Description Requirements

### Minimum Length of Issue Description

As a support manager, you want to ensure that all reported bugs have detailed descriptions so you can replicate and solve them as easily as possible. By setting a minimum character length, you can enforce thorough descriptions of all issues before they can be created.

```jira-expression
issue.description.plainText.length > 30
```

Change `length > 30` to specify the minimum number of required characters.

### Description Field Must Contain More Than 30 Characters

```jira-expression
issue.description.plainText.length > 30
```

### Minimum Length of All Comments

As a support manager, you want to ensure that all comments have detailed descriptions. By setting a minimum character length, you can enforce meaningful comments on all issues before they can be created.

```jira-expression
issue.comments.every(comment => comment.body.plainText.length > 10)
```

### All Comments Have a Minimum Length

```jira-expression
issue.comments.every(comment => comment.body.plainText.length > 10)
```

## Issue Linking

### Require One Linked Issue

You have a support portal and a separate support development instance. You want to ensure that all issues created on the support development instance are linked to their corresponding user-facing ticket on the support portal. Ensure all issues created on one Jira instance are linked with their corresponding issue on another instance.

```jira-expression
issue.links.length > 0
```

You can edit this script to make other fields required. For example, replace `links` with `fixVersions` or `components`.

### Linked Issues Conditions

Use the Linked Issues Condition to control whether or not a user can transition an issue based on the status or resolution of linked issues.

#### Check All Linked Issues are in Certain Status

```jira-expression
issue.links.every(l => l.linkedIssue.status.name == 'Done')
```

#### Check All Linked Issues of Certain Link Type are at Certain Status

```jira-expression
issue.links
    .filter(l => l.type.inward == 'is blocked by')
    .every(l => l.linkedIssue.status.name == 'Done')
```

#### Check All Linked Issues Have a Resolution

```jira-expression
issue.links.every(l => l.linkedIssue.resolution != null)
```

#### Check All Linked Issues of Certain Link Type Have a Resolution

```jira-expression
issue.links
    .filter(l => l.type.inward == 'is blocked by')
    .every(l => l.linkedIssue.resolution != null)
```

## Sprint and Agile Requirements

### Issue Must be in the Current Active Sprint

As a project manager, you want to ensure that only issues planned in the current sprint are worked on. Allow work to be started only on issues that are in the current active sprint.

```jira-expression
issue.sprint?.state == 'active'
```

## Comments Management

### Require a Comment on Transition

```jira-expression
issue.comments.some(comment => comment.id == null)
```

### All Existing Comments Must be Public (for Jira Service Management)

```jira-expression
issue.comments.every(c => !c.properties["sd.public.comment"].internal)
```

### Check for Internal Comments (for Jira Service Desk / Jira Service Management)

Use this for existing comments that are already persisted on the issue. In this case, `comment.id` is not null and `c.properties["sd.public.comment"].internal` is a Boolean, so compare it to `true`. Use an explicit null check on the `sd.public.comment` property before reading `internal`:

```jira-expression
issue.comments.some(c => c.properties["sd.public.comment"] != null && c.properties["sd.public.comment"].internal == true)
```

### Internal Comment Requirement

Use this for a comment being added during the current transition. In this case, the new comment has `id == null`, and the `internal` property is a string during transition, so compare it to `'true'` rather than `true`:

```jira-expression
issue.comments.every(c => c.id != null || c.properties["sd.public.comment"].internal == 'true')
```

## Status and History Checks

### Checks the Issue Has Been in a Status Previously

```jira-expression
issue.changelogs.some(c =>
    c.items.some(i => i.toString == 'In Progress')
)
```

### Field(s) Changed

Check whether a specified field has been changed in the issue's lifetime:

```jira-expression
issue.changelogs.some(c => c.items.some(i => i.field == 'Field Name'))
```

### Last Field Changed

Check whether a specified field has been changed within the issue lifetime:

```jira-expression
issue.changelogs[0].items.some(i => i.field == 'Field Name')
```

## Version and Component Requirements

### Require at Least One Fix Version

```jira-expression
issue.fixVersions.length > 0
```

### Require at Least One Component

```jira-expression
issue.components.length > 0
```

## Epic Requirements

### Require All Issues in an Epic Must Be Done

```jira-expression
issue.isEpic && issue.stories.every(story => story.status.name == 'Done')
```

## Issue Type Restrictions

### Require Specific Users in a Project can Create Issues of a Specified Type

In this example, only members of the Developers role can create Bug issue types, but all users can create other issue types:

```jira-expression
issue.issueType.name == 'Bug' ?
    user.getProjectRoles(project).map(p => p.name).includes("Developers") :
    true
```

### Verify Issue Type

Returns true for issues with issue type: Bug or Task:

```jira-expression
["Bug", "Task"].includes(issue.issueType.name)
```

## Date Comparisons

The following system fields return a Date object: `created`, `update`, and `resolutionDate`.

### Date System Fields

#### Check if Issue was Created More Than 7 Days Ago

```jira-expression
issue.created < new Date().minusDays(7)
```

#### Check if Issue was Updated Within Last 2 Hours

```jira-expression
issue.updated > new Date().minusHours(2)
```

#### Check if Issue was Resolved Within Last 30 Days

```jira-expression
issue.resolutionDate ?
    issue.resolutionDate >= new Date().minusDays(30) :
    false
```

### Calendar Date Fields

The following system fields return a CalendarDate object: `dueDate`.

#### Check if Issue is Due Within Next 3 Months

```jira-expression
issue.dueDate ?
    issue.dueDate <= new CalendarDate().plusMonths(3) :
    false
```

> **Caution:** `dueDate` and `resolutionDate`, along with custom fields, can be null. Always check for null values before performing operations on them.

### Custom Date Fields

Date custom fields have a string value, but can be converted to a calendar date like so: `new CalendarDate(issue?.customfield_10200)`

#### Check if Date Custom Field is 30+ Days in Future

```jira-expression
issue?.customfield_10200 ?
    new CalendarDate(issue?.customfield_10200) >= new CalendarDate().plusDays(30) :
    false
```

### Custom Date Time Fields

Date time custom fields have a string value, but can be converted to a date time like so: `new Date(issue?.customfield_10217)`

#### Check if Date Time Custom Field is Less Than 6 Hours in Future

```jira-expression
issue?.customfield_10217 ?
    new Date(issue?.customfield_10217) <= new Date().plusHours(6) :
    false
```

## Regular Expressions

The Regular Expression condition is only available on all strings, including text fields and option values.

When converting Groovy regex checks (for example, `==~ /.../`), preserve the regex pattern semantics exactly. Do not weaken or simplify character classes, quantifiers, anchors, or allowed URL/query characters unless the source logic explicitly changes them.

### Check Description Contains Pattern

Checks that the description contains the string `SRJ-` then any amount of digits, for example to match an issue tracker key:

```jira-expression
issue.description.plainText.match("SRJ-\d+") != null
```

### Check Custom Field Contains Pattern

Checks if the regular expression exists in any part of the text field value:

```jira-expression
issue?.customfield_10206 ?
    issue?.customfield_10206.match("SRJ-\d+") != null :
    false
```

## Common Mistakes

### Example of Incorrect Condition Script

Run code will not execute as the return result is a list of objects:

```jira-expression
// This will NOT work
issue.comments.map(c => c.body)
```

### Switch statements/expressions

When rewriting conditions that use switch statements/expressions, or map some keys to values, rewrite with a lookup table containing an inline map. Prefer this over if/else statements, concise is optimal.

## Issue Picker Custom Fields

Issue picker custom fields (type: ISSUE_PICKER) store the **issue ID or key as a raw value** (number or string), NOT an Issue object. You must wrap the value in the `Issue()` constructor to access Issue properties like `status`, `assignee`, etc.

```jira-expression
// WRONG — customfield value is just an ID, not an Issue object
issue.customfield_10500?.assignee != null

// CORRECT — wrap in Issue() to get an Issue object, guard for null
let linked = Issue(issue.customfield_10500);
linked != null && linked.assignee != null
```

Note: Use `Issue(value)` (function call), not `new Issue(value)`. The `Issue()` constructor returns `null` if the issue doesn't exist or the user lacks access. Always null-check the result before accessing properties.

## Transition Comments

In workflow validators, a comment being added **during the current transition** has not yet been persisted, so its `id` is `null`. Use `comment.id == null` to detect transition comments. This is the Jira Expression equivalent of Groovy's `transientVars.get("comment")`.

The existing example in the Comments Management section above shows the basic pattern. You can combine this check with other conditions using ternary expressions to conditionally require comments based on project, user role, issue type, or other criteria.

## Affected Versions vs Fix Versions

- `issue.versions` — the **Affects Versions** field (NOT `issue.affectedVersions`, which does not exist)
- `issue.fixVersions` — the **Fix Versions** field

Both return `List<Version>`. Each Version has `id`, `name`, `released`, `archived`, etc.

## Multi-Select Custom Fields

Multi-select custom fields are returned as a **List** (array) of option objects directly. Each option has a `value` property. To count how many options are selected, use `.length` on the field itself — the field IS the list, do not access `.value` first. For required checks, use `field != null && field.length > 0`.

## Summary

These Jira expressions provide powerful ways to control workflow transitions, validate data, and enforce business rules in your Jira instance. Remember to always test your expressions thoroughly before deploying them to production environments.
