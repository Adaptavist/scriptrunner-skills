# Date of First Transition

- Platform: data-center
- Space: SR4JS
- Hierarchy: Features > Script fields > Built-In Script Fields
- Doc ID: doc-sr4js-23283629-c9f4-4128-949a-0e186c232987-fef0e2a03427d355
- Source: https://docs.adaptavist.com/sr4js/latest/features#script-fields--en#built-in-script-fields--en#date-of-first-transition--en

This sample script field gets the date that an issue was first transitioned through a particular action.

If it undergoes the same transition multiple times, only the first date is shown.

This can be useful for support workflows where you want to track when the customer was first responded to.

```
package com.onresolve.jira.groovy.test.scriptfields.scripts
 
import com.atlassian.jira.component.ComponentAccessor
 
def changeHistoryManager = ComponentAccessor.getChangeHistoryManager()
def created = changeHistoryManager.getChangeItemsForField(issue, "status").find {
    it.toString == "In Progress" 
}?.getCreated()
 
def createdTime = created?.getTime()
 
createdTime ? new Date(createdTime) : null
```

|  |  |
| --- | --- |
| Template | Date Time Picker |
| Searcher | Date Time Range picker |
