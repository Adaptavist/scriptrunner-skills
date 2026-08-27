# Example Restrictions and Validators

- Platform: cloud
- Space: SR4JC
- Hierarchy: features > workflow-rules
- Doc ID: doc-sr4jc-187992432
- Source: https://docs.adaptavist.com/sr4jc/latest/features/workflow-rules/example-restrictions-and-validators

The Jira expression examples highlighted in this section can be used for **either** [restrictions](https://docs.adaptavist.com/sr4jc/latest/features/workflow-rules/restrict-transitions) or [validators](https://docs.adaptavist.com/sr4jc/latest/features/workflow-rules/validate-details) and on **all transitions** unless noted otherwise. 

Jira expression framework limitation: nested condition

[Jira expressions](https://developer.atlassian.com/cloud/jira/platform/jira-expressions/#conditional-expressions) **do not** support nested `if` statements. For example, the following expression will _fail_:  

```
if (issue.summary.length > 10 ) {
   if(issue.assignee) {
      // ...
   }
}
```

You can instead combine this into a single expression, as shown in the example below:

```
if (issue.summary.length > 10 && issue.assignee) {
    // ...
}
```

Atlassian's [new transition experience](https://community.atlassian.com/forums/Jira-articles/Now-GA-try-the-new-issue-transition-experience-in-Jira/ba-p/2734436) in Jira is being permanently rolled out in **April 2025**. As a consequence, how your Jira expressions ([restrictions](https://docs.adaptavist.com/sr4jc/latest/features/workflow-rules/restrict-transitions) and [validators](https://docs.adaptavist.com/sr4jc/latest/features/workflow-rules/validate-details)) work will change. Check out our [Breaking Changes](https://docs.adaptavist.com/sr4jc/latest/release-notes/breaking-changes/compatibility-of-atlassian-s-new-transition-experience-with-jira-expressions) section for more information.

## Checks if the work item has been in a status previously

```
issue.changelogs.some(c =>
    c.items.some(i => i.toString == 'In Progress')
)
```

## Comments

### All comments have a minimum length:

```
issue.comments.every(comment => comment.body.plainText.length > 10)
```

### All existing comments must be public (for Jira Service Management):

```
issue.comments.every(c => !c.properties["sd.public.comment"].internal)
```

### If there is a comment on transition, it must be an internal comment (note that the \`internal\` property is a string during transition!):

```
issue.comments.every(c => c.id != null || c.properties["sd.public.comment"].internal == 'true')
```

### Require a comment during transition:

```
issue.comments.some(comment => comment.id == null)
```

## Current logged-in user has added at least one comment

```
issue.comments.some(c => c.author.accountId == user.accountId)
```

## Date comparison

The following system fields return a `[Date](https://developer.atlassian.com/cloud/jira/platform/jira-expressions-type-reference/#date)` object: `created`, `update`, and `resolutionDate`.

### Checks whether a date custom field is 30 days or more in the future from today's date:

```
 issue.customfield_10200 ? 
    new CalendarDate(issue.customfield_10200) >= new CalendarDate().plusDays(30) :
    false
```

`Date time` custom fields have a string value, but can be converted to a date time like so: `new Date(issue.customfield_10217)`

### Checks whether a date time custom field is less than 6 hours in the future:

```
 issue.customfield_10217 ? 
    new Date(issue.customfield_10217) <= new Date().plusHours(6) :
    false
```

### Checks whether a work item is due within the next 3 months:

The following system fields return a `[CalendarDate](https://developer.atlassian.com/cloud/jira/platform/jira-expressions-type-reference/#calendardate)` object: `dueDate`.

```
 issue.dueDate ? 
    issue.dueDate <= new CalendarDate().plusMonths(3) :
    false
```

 ![(warning)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/warning.svg) **Caution****:** `dueDate` and `resolutionDate`, along with custom fields, can be null. Always check for null values before performing operations on them.

`Date` custom fields have a string value, but can be converted to a calendar date like so: `new CalendarDate(issue.customfield_10200)`

### Checks whether a work item was created more than 7 days ago:

```
issue.created < new Date().minusDays(7)
```

### Checks whether a work item was resolved within the last 30 days:

```
issue.resolutionDate ? 
    issue.resolutionDate >= new Date().minusDays(30) :
    false
```

### Checks whether a work item was updated within the last 2 hours:

```
issue.updated > new Date().minusHours(2)
```

## Description field must contain more than 30 characters

```
issue.description.plainText.length > 30
```

## Field is not empty

The following examples verify that the field is not empty (i.e., it's a required field). 

At least one of two label fields must have a value:

### Checks if the work type is Bug or Task:

```
 ["Bug", "Task"].includes(issue.issueType.name)
```

### Require a comment during transition:

```
 issue.comments.some(comment => comment.id == null)
```

## Field(s) changed

Check whether a specified field has been changed in the work item's lifetime.

```
issue.changelogs.some(c => c.items.some(i => i.field == 'Field Name'))
```

## Field(s) required

For text fields, single, multi selects, radio buttons, checkboxes, and cascading select fields: 

```
issue.customfield_10040 != null
```

For cascading select field:

```
// for parent value
issue.customfield_10266?.value != null

// both parent and child (you cannot set the child without the parent)
issue.customfield_10266?.child?.value != null
```

This example checks that a text field (possibly supporting rich text) is **required**:

```
let plainTextValue = value => typeof value == 'Map' ? new RichText(value).plainText : value ;
plainTextValue(issue.customfield_10080 != null) && plainTextValue(issue.customfield_10080) != ''
```

## Incorrect condition script

The code will not run because the return value is a list of objects.

```
issue.comments.map(c => c.body)
```

## Work item must be in the current active sprint

As a space manager, you want to ensure that only work items planned in the current sprint are worked on. Allow work to start only on work items in the current active sprint.

```
issue.sprint?.state == 'active'
```

## Work item must have at least one PDF attachment

```
issue.attachments.some(attachment => attachment.mimeType == 'application/pdf')
```

## Work item must have at least three PDF attachments

```
issue.attachments.filter(attachment => attachment.mimeType == 'application/pdf').length > 3
```

## Last field changed

Check whether a specified field has been changed within the work item's lifetime.

```
issue.changelogs[0].items.some(i => i.field == 'Field Name')
```

## Linked work

Use the _Linked Work Condition_ to control whether or not a user can transition a work item based on the status or resolution of linked work.

```
// Check all linked work items are in a certain status
issue.links.every(l => l.linkedIssue.status.name == 'Done')

// Check all linked work items of a certain link type are at a certain status
issue.links
	.filter(l => l.direction == 'inward')
	.filter(l => l.type.inward == 'is blocked by')
	.every(l => l.linkedIssue.status.name == 'Done')

// Check all linked work items have a resolution
issue.links.every(l => l.linkedIssue.resolution != null)

// Check all linked work items of a certain link type have a resolution
issue.links
    .filter(l => l.type.inward == 'is blocked by')
    .every(l => l.linkedIssue.resolution != null)
```

## Minimum length of all comments

As a support manager, you want to ensure that all comments have detailed descriptions. By setting a minimum character length, you can enforce meaningful comments on all work items before they can be created.

```
 issue.comments.every(comment => comment.body.plainText.length > 10)
```

## Minimum length of work item description

As a support manager, you want to ensure that all reported bugs have detailed descriptions so you can replicate and solve them as easily as possible. By setting a minimum character length, you can enforce thorough descriptions of all work items before they can be created.

```
 issue.description.plainText.length > 30
```

Change `length > 30` to specify the minimum number of required characters.

## Multi-select or checkbox field equals a specific set of values

```
issue.customfield_10214 ?
    issue.customfield_10214.map(option => option.value) == ['Yes', 'No'] :
    false
```

## Multi-select list or checkbox field must be populated with specific value

You want to enforce that work items have a specific value selected in a multi-select list or checkbox before progressing.

```
issue.customfield_10263 ?
    issue.customfield_10263.some(option => option.value == "End Users") :
    false
```

Replace `customfield_10263` in the example with the ID of the multi-select list or checkbox field of your instance. To find the custom field ID, navigate to `<JiraBaseURL>/secure/admin/ViewCustomFields.jspa` and **Edit** the required field. The field ID is shown.

## Multi-select or checkbox must be populated with one specific value

```
issue.customfield_10214 ?
    issue.customfield_10214.some(option => option.value == "A") :
    false
```

## Regular expressions

The Regular Expression condition is only available on all strings, including text fields and option values.

Checks that the description contains the string \`SRJ-\` then any amount of digits, for example, to match a work tracker key:

```
issue.description.plainText.match("SRJ-\d+") != null
```

Checks if the regular expression exists in any part of the text field value.

```
issue.customfield_10206 ?
    issue.customfield_10206.match("SRJ-\d+") != null :
    false
```

## Require a comment on transition

```
issue.comments.some(comment => comment.id == null)
```

## Require all work in an epic must be done

```
issue.isEpic && issue.stories.every(story => story.status.name == 'Done')
```

## Require at least one component

```
issue.components.length > 0
```

## Require at least one fix version

```
issue.fixVersions.length > 0
```

## Require at least two PDF attachments are added during the current transition

```
issue.attachments.filter(attachment => attachment.id == null && attachment.mimeType == 'application/pdf').length > 1
```

## Require attachments

You want a PDF of the contract agreement attached to a work item before work can begin, so developers know what was agreed with the client. This script ensures that at least one PDF file is attached before the **Start Progress** transition is available for the work item. 

```
issue.attachments.some(attachment => attachment.mimeType == 'application/pdf')
```

If you want to require a specific minimum number of PDFs, use the following script:

```
issue.attachments.filter(attachment => attachment.mimeType == 'application/pdf').length > 2
```

Edit `length > 0` to the minimum number of PDFs required.

As a space manager, you want to ensure the required number of attachments have been added to a work item as it transitions, to align with business processes. Ensure a minimum number of attachments have been added as a work item transitions.

```
issue.attachments.filter(attachment => attachment.id == null).length == 3
```

Change `length ==3` to specify the minimum number of required attachments. The transition screen must be configured to include the _Attachments_ field so users can submit attachments during the transition.

## Require one linked work item

You have a support portal and a separate support development instance. You want to ensure that all work created on the support development instance is linked to its corresponding user-facing ticket on the support portal. Ensure all work items created on one Jira instance are linked with their corresponding items on another instance.

```
issue.links.length > 0
```

You can edit this script to make other fields required. For example, replace `links` with `fixVersions` or `components.`

## Require specific users in a space can create work of a specified type

In this example, only members of the Developers role can create Bug work types, but all users can create other work types.

```
issue.issueType.name == 'Bug' ? 
    user.getProjectRoles(project).map(p => p.name).includes("Developers") : 
    true
```

## Require sub-tasks

As a space manager, you want developers to add subtasks to work items so you can see the steps required to complete them. You want to prevent a work item from transitioning if it has no subtasks. This script only shows the transition option if the work item has at least one sub-task.

```
issue.subtasks.length > 0
```

Edit `length > 0` to the minimum number of sub-tasks required.

## Restrict transition permissions

As a team lead, you want to restrict the transition of work items to a specific status for certain user groups or space roles. This condition only shows a certain transition option to users belonging to the groups or roles specified.

### Restrict to space role

```
user.getProjectRoles(project).some(p => p.name == "userrole")
```

Replace `userrole` with the space role you want to be able to transition the work item (for example, _Developers_). Roles apply only to spaces, whereas user groups are global. See the [Atlassian documentation](https://confluence.atlassian.com/adminjiracloud/managing-project-roles-776636382.html) for information on managing space roles.

### Restrict to user groups

```
 user.groups.includes('usergroup')
```

Replace `usergroup` with the group of users you want to be able to transition work (for example, _Administrators_). See the [Atlassian documentation](https://confluence.atlassian.com/adminjiraserver/view-create-or-delete-a-group-938847038.html) for information on viewing, creating, or deleting groups.

## Specify that one of two label fields must have a value

Note that you should replace '`customfield_12345`' and '`customfield_67890`' in the example below with IDs of the label fields inside your instance:

```
issue.customfield_12345 != null || customfield_67890 != null
```

Note that you can add an OR / AND logical operator where more than one field needs to be checked.

## Specify the current user must be in a defined list of users

The example checks by user account ID, but you can also use user.displayName.

```
['accountIdHere', 'accountIdHere'].includes(user.accountId)
```

## Subtask type and status

This expression checks whether all subtasks of a certain type are at a specific status. 

```
issue
    .subtasks
    .filter(s => s.issueType.name == 'Scope Change')
    .every(d => d.status.name == 'Done')
```

## Sub-tasks must be done

You want to enforce that _Done_ means all sub-tasks are completed by hiding the _Done_ transition option of a work item when there are outstanding sub-tasks. This script only shows the transition option when all sub-tasks have the _Done_ resolution.

```
issue.subtasks.every(subtask => subtask.status.name == 'Done')
```

Edit `[subtask.status.name](http://subtask.status.name)` `== 'Done'` if you require a different sub-task resolution or status.

## Sub-tasks must be in progress

As a space manager, you want to ensure all sub-tasks have been started before progress can start on the parent work item to keep work aligned. Ensure all sub-tasks are _In Progress_ before a parent work item can be transitioned to _In Progress_.

This example cannot be used on the **Create** transition. Use the **Start Progress** transition.

```
issue.subtasks.every(subtask => subtask.status.name == 'In Progress')
```

## Sub-Tasks must have assignee

You want to make sure all sub-tasks have been assigned before the parent work item can be transitioned to _In Progress_. This script only shows the _In Progress_ transition option on a parent work item when all sub-tasks have assignees.

```
issue.subtasks.every(subtask => subtask.assignee != null)
```

## User(s) and user group(s) 

Check whether the current user is on a specified list.

```
['User A','User B','User C'].includes(user.displayName)
```

Check if the current user is within a group of a specified list

```
['Group A','Group B', 'Group C'].some(g => user.groups.includes(g))
```

## User in field(s)

This expression checks whether the current user is selected in a custom user picker field.

For user picker single select:

```
issue.customfield_10213?.displayName == 'A User'

// or using accountId
issue.customfield_10213?.accountId == '5cf7c174eba28b4ea84a7cb5'
```

For user picker multi select:

```
issue.customfield_10219 ?
    issue.customfield_10219.some(user => user.displayName == 'A User') :
    false
```

This expression checks whether the current user group is selected in a custom group picker field, either by account ID or username.

For group picker single select:

```
issue.customfield_10077?.name == 'jira-admins'
```

For group picker multi-select:

```
issue.customfield_10078 ?    
    issue.customfield_10078.some(c => c.name == 'jira-admins') :
    false
```

## Verify work type

Returns **true** for work with work type: Bug or Task.

```
["Bug", "Task"].includes(issue.issueType.name)
```
