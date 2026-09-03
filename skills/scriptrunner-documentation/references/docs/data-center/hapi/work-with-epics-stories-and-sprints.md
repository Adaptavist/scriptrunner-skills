# Work with Epics, Stories and Sprints

- Platform: data-center
- Space: SR4JS
- Hierarchy: hapi
- Doc ID: doc-sr4js-442888705
- Source: https://docs.adaptavist.com/sr4js/latest/hapi/work-with-epics-stories-and-sprints

With HAPI, we've made it easy for you to work with epics, stories, and sprints. 

## Creating an epic 

You can create an epic as follows:

```
Issues.create('SSPA', 'Epic') {
    setSummary('x')
    setEpicName('my epic')
}
```

![Image showing you how to create an epic with HAPI](/sr4js/files/latest/442888705/442888708/1/1758746963000/Creating_an_epic.png)

## Creating a story and associating with an epic 

You may want to create a story and link it with an epic. To do so, proceed as follows:

```
def epic = Issues.getByKey('SSPA-24')
 
def story = Issues.create('SSPA', 'Story') {
    setSummary('my new feature')
     
    // set by Issue reference
    setEpic(epic)
 
    // alternatively, set by key
    setEpic('SSPA-24')
}
```

## Setting the flagged status:

Enter the following script into your script console:

In this example we're creating an issue and setting the Flagged status.

```
def story = Issues.create('SSPA', 'Story') {
    setSummary('my new (blocked) feature')
    setCustomFieldValue('Flagged') {
        set('Impediment')
    }
}
// alternatively flag/unflag an issue independently of an update// set flagged 
story.flag()
// unflag
story.unflag()
// is flagged?
log.warn (story.flagged)
```

If the _Flagged_ custom field value doesn't appear, it could be because you don't have any flagged issues in your instance.

![Image showing you how to set flagged status](/sr4js/files/latest/442888705/442888707/1/1758746963000/Set_flagged_status.png)

## Working with sprints

A common task is to add the issue either to current sprint, or to the next sprint. The terms **current** and **next** sprint only make sense in context of a board, therefore we recommend you provide a board name. The first board associated with this issue is used if you don't.

Any issue can be associated with any number of boards, and you cannot control which boards an issue appears in.

```
issue.update {
    setSprints {
        // set the sprint to the (first) active sprint on this board
        active('My SCRUM board')
 
        // set the sprint to the next, unstarted sprint
        next('My SCRUM board')
 
        // issue goes in the backlog, sprint is unset
        backlog()
    }
}
```

![Image showing you how to set issues to a sprint backlog](/sr4js/files/latest/442888705/442888706/1/1758746963000/Set_issues_to_sprints.png)

You can also set the sprint by name:

```
issue.update {
    setSprints {
        set('SCRUM Sprint 1')
 
        // note that an issue can be part of multiple sprints so this is valid to add to both:
        set('SCRUM Sprint 1', 'SCRUM Sprint 2')
 
        // alternatively use sprint IDs
        set(14)
 
        // or Sprint objects, perhaps copied from another issue
    }
}
```

If you use a sprint name, the first sprint with that name, and associated with the issue, is retrieved. This could cause a problem if the issue is in multiple sprints with the same name. Please note:

-   It is possible to create a board with no project associations
-   Board names are not unique

If this causes a problem then use sprint IDs.

  

* * *

## Related content

-   [Update Issues](https://docs.adaptavist.com/sr4js/latest/hapi/update-issues)
-   [Update Fields](https://docs.adaptavist.com/sr4js/latest/hapi/update-fields)
-   [Work with Projects](https://docs.adaptavist.com/sr4js/latest/hapi/work-with-projects)
