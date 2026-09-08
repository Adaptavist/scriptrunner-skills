# Update Issues

- Platform: data-center
- Space: SR4JS
- Hierarchy: hapi
- Doc ID: doc-sr4js-442888194
- Source: https://docs.adaptavist.com/sr4js/latest/hapi/update-issues

![](/sr4js/files/latest/442888194/441364725/1/1750778141000/sr-icon-cloud.png)

**Migrating to Jira Cloud? This feature is available in Cloud. Check out our** **[HAPI Cloud documentation](https://docs.adaptavist.com/display/SR4JC/Work+with+Issues#updateissues)** **for more details.** 

Updating an issue is equivalent to doing **Edit Issue** in the user interface. You can update an issue as follows:

In this example we're updating the summary of an issue and setting the description.

```
            def issue = Issues.getByKey('ABC-1')
             
            issue.update {
                setSummary('an updated summary')
                setDescription('hello *world*')
            }
```

The image example below shows that you can update multiple fields at once: 

![Image showing how you update issues with HAPI](/sr4js/files/latest/442888194/442888195/1/1758746916000/Update_an_issue.png)

The `issue` variable above is a standard `[com.atlassian.jira.issue.Issue](https://docs.atlassian.com/software/jira/docs/api/9.6.0/com/atlassian/jira/issue/Issue.html?_ga=2.215806871.1616100431.1676882043-2029362582.1658496808)`. So you can update an issue like this anywhere you have a `com.atlassian.jira.issue.Issue` object.

## Avoiding notifications and event dispatches

If you are bulk updating issues you may not want other users to receive notifications of this update. You can stop an event from being fired, and emails being sent, as follows:

```
import com.atlassian.jira.event.type.EventDispatchOption

issue.update {
    setSummary('New summary')
    setEventDispatchOption(EventDispatchOption.DO_NOT_DISPATCH)
    setSendEmail(false)
}
```

## Limitations on working with estimates

When updating estimates on your issues, it's important to know the limitations of `setOriginalEstimate()` and `setRemainingEstimate()`. When both methods are used to update estimates on an issue, only the last `set` statement for estimates will be executed.

For example, if you use the following script to update estimates only the `setRemainingEstimate("20h")` will be executed, and **the original estimate will not be updated**:

```
issue.update { 
	setOriginalEstimate("80h")
	setRemainingEstimate("20h")
}
```

### Solution

To update both the original and remaining estimates simultaneously, use `setOriginalAndRemainingEstimate()`. This method allows you to set both estimates in a single operation. For example, if you use the following script, both the original estimate (to 80 hours) and the remaining estimate (to 20 hours) for the specified issue will be successfully updated:

```
issue.update { 
    setOriginalAndRemainingEstimate("80h", "20h")
}
```

## Working with post-functions

When working with a transitioning issue, for example within a scripted post-function, you should generally `issue.set()` instead of `issue.update`. Using `issue.set()` modifies the issue in memory during the post-function execution, so changes to the issue occur in the same transaction, without triggering a redundant update. 

Sometimes, for example when in a post-function, you need to change the fields on an instance of an issue without saving the changes to the database. In these cases, you will have an instance of `MutableIssue`—for example, the `issue` variable in a workflow post-function.

You can use the same API to set system and custom fields as described below. For example, to add a named fix-version in a post-function:

```
                issue.set {
                    setFixVersions {
                        add('v2.0')
                    }
                }
```

The Jira API provides many setters on `MutableIssue`, and you can mix and match with ours:

```
                issue.setSummary('Hello')
                issue.set {
                    setFixVersions {
                        add('v2.0')
                    }
                }
```

Check out the [Transition Issues](https://docs.adaptavist.com/sr4js/latest/hapi/transition-issues) page for examples of transitioning issues. 

  

* * *

## Related content

-   [Javadocs link](https://docs.adaptavist.com/api/javadoc/dc/scriptrunner/8.10.0/hapi/jira/groovydoc/com/adaptavist/hapi/jira/issues/delegate/IssueUpdateDelegate.html)
-   [Transition Issues](https://docs.adaptavist.com/sr4js/latest/hapi/transition-issues)
-   [Update Fields](https://docs.adaptavist.com/sr4js/latest/hapi/update-fields)
