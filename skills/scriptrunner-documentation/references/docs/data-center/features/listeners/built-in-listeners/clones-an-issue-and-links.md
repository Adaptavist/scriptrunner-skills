# Clones an Issue and Links

- Platform: data-center
- Space: SR4JS
- Hierarchy: features > listeners > built-in-listeners
- Doc ID: doc-sr4js-442888800
- Source: https://docs.adaptavist.com/sr4js/latest/features/listeners/built-in-listeners/clones-an-issue-and-links

Use this listener to clone the current issue to a new one and create a link between the two. You can specify which fields are being copied, either all fields, no fields, or specific fields, from the source issue to the new one.

For example, you might want to:

-   Clone an issue and specific fields to a _Security Issue Tracker_ project when a user updates a **CVE Level** custom select list field to _Critical_.
-   Clone an issue and all fields to a new project so you can easily create multiple similar linked issues.

This listener allows you to copy both custom fields and system fields. You can also specify which user the issue is cloned on behalf of; this sets the **Creator** and **Reporter** fields. 

Required fields

When cloning an issue from one project to another, there may be times when a field is required in the target project but not required in the project of the issue being cloned, and therefore that field may be empty in the issue being cloned. In such a situation the issue is still cloned and the field will remain empty until you go into the target issue and edit it manually. 

## Run this listener

1.  Navigate to **ScriptRunner > Listeners**. 
2.  Select **Create Listener**.
3.  Select the **Clones an issue, and links** listener.
4.  Enter a description of the listener in **Name**.
5.  Define which project(s) the listener should be **Applied to**.  
    You can either check _Global_ to apply the listener to all projects or check _Select projects(s)_ and define the projects you want to assign the listener to. 
6.  Select the **Events** on which the listener fires.   
    For example, to clone an issue on creation, choose the **Issue Created** event. 
7.  You can further refine when the listener fires by entering a **C****ondition**, for instance, if you wanted to restrict this behaviour to just certain components or certain priorities of issue.
8.  Specify the **Target Project(s)**. This will be the project(s) the issue is cloned to. Leave blank to clone the issue to the same project as the source issue.
9.  Specify the **Target Issue Type**. This will be the issue type of the cloned issue. Leave blank to use the same issue type as the source issue. 
    
    The issue type selected must be valid for the target project selected.
    
10.  Next, select the fields to copy. This is either:
     -   All - The values of all system and custom fields are copied.
     -   None - No field values are copied. 
     -   Custom - Values of the defined fields are copied.
11.  Optionally, select to clone the comments, organisations, and sub-tasks of the source issue.
12.  In the **As User** field, there is the possibility to select a user. The issue is then cloned on their behalf, making the selected user the Creator and Reporter of the new issue. If empty, the current user is assigned.
13.  You can use the **Additional Issue Actions** field to customise the newly cloned issue. If you want to override some field values, rather than have them inherited from the source issue, you can specify that here.  
     For example, the following snippet will set the **Summary** field, and a custom field called **MyCustomFieldType** to _my value_:
     
     ```
issue.summary = 'Cloned issue'
issue.setCustomFieldValue('My custom field name', "my value")
```
     
14.  Specify the **Issue Link Type / Direction**. This will typically be _Clones_, but you can select any from the drop-down. See the [Control of Cloning Links](#id-.ClonesanIssueandLinks1v9.x-control-of-cloning-links) for more information on cloning links.
15.  Select **Add.** 

## Additional Issue Actions

### Control of cloning links

Both outward and inward links are copied. So if issue A _depends on_ issue B, after cloning to issue C then issue C will also _depend on_ issue B. And similarly if issue B was _depended on_ by issue A.

You can override this behaviour to copy links selectively or disable altogether by providing a callback (a closure) called `checkLink` in the **Additional Issue Actions** field. The callback will be called for every link found and should return true or false. This is passed one parameter, the [IssueLink](https://docs.atlassian.com/software/jira/docs/api/latest/com/atlassian/jira/issue/link/IssueLink.html) object. For example, to disable the cloning of links altogether use this code:

```
checkLink = {link -> false};
```

To enable cloning of all links except links of the type _Clones_ use:

```
checkLink = {link -> link.issueLinkType.name != "Clones"}
```

### Control of cloning attachments

In a similar way, you can control which attachments are copied. To disable attachment copying completely:

```
checkAttachment = {attachment -> false}
```

To clone only the attachments added by the user _jbloggs_:

```
checkAttachment = {attachment -> attachment.authorKey == 'jbloggs'}
```

### After Create actions

There are some actions that can take place only after the creation of the issue (add watcher, create issue links etc), in this case you can apply additional actions **after** the creation of the new issue, using the `doAfterCreate` callback (closure).

For example, add watchers to the new issue:  

```
doAfterCreate = {
    issue.addWatcher('anuser')
}
```

Another use of it could be, linking the new issue to another one. For example create a 'duplicates' issue link between the new issue and an issue with key JRA-24:

```
doAfterCreate = {
    def issueToLinkTo = Issues.getByKey("SSPA-1")

    issue.link('duplicates', issueToLinkTo)
}
```

The variable `issue` **outside** the doAfterCreate closure is not yet created and trying to access it will result to an error (the `issue.getKey()` will throw a `NullPointerException`). On the other hand the `issue` **inside** the doAfterCreate callback is created and exists (therefore the `issue.getKey()` will return the key of the new issue).
