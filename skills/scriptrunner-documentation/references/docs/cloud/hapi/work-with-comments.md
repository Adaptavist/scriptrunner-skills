# Work with Comments

- Platform: cloud
- Space: SR4JC
- Hierarchy: hapi
- Doc ID: doc-sr4jc-288524078
- Source: https://docs.adaptavist.com/sr4jc/latest/hapi/work-with-comments

With HAPI, you can easily add comments to work items and retrieve comments from work items. 

## Add comments to a work item

You can add comments to a work item in Jira to provide updates, share progress, or communicate important information. Here's an example of how to add a comment:

```
workItem.addComment('Comment for administrators')
```

## ![](/sr4jc/files/latest/288524078/524224136/1/1774349979000/add+comments.png)

JSM internal notes

Currently, `workitem.addComment()` adds only public comments in JSM using HAPI. Adding internal/private comments is not supported, however, a workaround is available using the REST API. For example:

```
def comment = """
                Hi, ${issue.fields.reporter.displayName} from ${issue.fields.customfield_12818.value} office,

                Thank you for creating this ticket in our service desk. You have requested a laptop replacement delivered to following destination:

                ${issue.fields.customfield_12831}

                Please make sure the address is correct. We will respond to your request shortly.

                Kindly also note if the ticket remains inactive for a period of 10 days then will automatically be closed.
            """

def addComment = post("/rest/servicedeskapi/request/${issue.key}/comment")
        .header('Content-Type', 'application/json')
        .body([
                body: comment,
                // Make comment visible in the customer portal
                public: true,
        ])
        .asObject(Map)

assert addComment.status >= 200 && addComment.status <= 300
```

  

## Retrieve all comments from a work item

You can use the `getComments` function to fetch all comments associated with a work item.

```
def workItem = WorkItems.getByKey('JRA-1')
workItem.getComments()

// To retrieve specific properties of comments, such as the body, you can use:
workItem.getComments().collect { it.body }
```

![](/sr4jc/files/latest/288524078/524224135/1/1774350064000/retrieve+all+comments.png)

Your browser does not support the HTML5 video element

  

* * *

## Related content

-   [Example scripts](https://www.scriptrunnerhq.com/help/example-scripts?ScriptRunner%5Bquery%5D=get%20all%20comments&ScriptRunner%5BrefinementList%5D%5Bapp%5D%5B0%5D=script-runner-jira&ScriptRunner%5BrefinementList%5D%5Bplatform%5D%5B0%5D=cloud)
-   [Javadocs (Groovy) Class Comment Creation](https://docs.adaptavist.com/api/javadoc/cloud/scriptrunner/latest/hapi/jira/groovydoc/com/adaptavist/hapi/jira/exceptions/issues/CommentCreationException.html)
-   [Javadocs (Groovy) Class Comment Retrieval](https://docs.adaptavist.com/api/javadoc/cloud/scriptrunner/latest/hapi/jira/groovydoc/com/adaptavist/hapi/jira/exceptions/issues/CommentRetrievalException.html)
