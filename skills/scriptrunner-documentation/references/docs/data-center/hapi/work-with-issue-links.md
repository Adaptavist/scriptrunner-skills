# Work with Issue Links

- Platform: data-center
- Space: SR4JS
- Hierarchy: hapi
- Doc ID: doc-sr4js-442888559
- Source: https://docs.adaptavist.com/sr4js/latest/hapi/work-with-issue-links

![](/sr4js/files/latest/442888559/441364737/1/1750779959000/sr-icon-cloud.png)

**Migrating to Jira Cloud? This feature is available in Cloud. Check out our** **[HAPI Cloud documentation](https://docs.adaptavist.com/display/SR4JC/Work+with+Issues#updateissues)** **for more details.** 

## Creating and deleting links

With HAPI you can quickly and easily link issues. Link two issues as follows:

```
            def source = Issues.getByKey('SR-1')
            def destination = Issues.getByKey('SR-2')
            
            source.link('blocks', destination)
```

![Image showing how you create links with HAPI](/sr4js/files/latest/442888559/442888561/1/1758746950000/Links_creating_links.png)

Removing a link is just as easy. Remove a link as follows:

```
            def source = Issues.getByKey('SR-1')
            def destination = Issues.getByKey('SR-2')
            
            source.unlink('blocks', destination)
```

## Accessing links in transition

You may wish to validate that an issue has particular links in a workflow validator. Typically, you cannot access links added during the current transition or issue update until it's complete. However, we have made it easy using the extension methods `getAllInwardLinks()` and `getAllOutwardLinks()` on `[MutableIssue](https://docs.atlassian.com/software/jira/docs/api/latest/com/atlassian/jira/issue/MutableIssue.html)`.

For example, you want to use a workflow validator to check that there is at least one outward "Blocker" link:

```
issue.allOutwardLinks*.issueLinkType.outward == ['blocks']
```

  

* * *

## Related content

-   [Javadocs link](https://docs.adaptavist.com/api/javadoc/dc/scriptrunner/8.10.0/hapi/jira/groovydoc/com/adaptavist/hapi/jira/links/implementation/LinksImplementation.html)
-   [Update Issues](https://docs.adaptavist.com/sr4js/latest/hapi/update-issues)
-   [Validating Attachments/Links In Transitions](https://docs.adaptavist.com/sr4js/latest/features/workflows/validators/validating-attachments-links-in-transitions)
