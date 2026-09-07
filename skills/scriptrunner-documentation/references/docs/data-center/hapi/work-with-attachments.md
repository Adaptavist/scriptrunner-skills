# Work with Attachments

- Platform: data-center
- Space: SR4JS
- Hierarchy: hapi
- Doc ID: doc-sr4js-442888519
- Source: https://docs.adaptavist.com/sr4js/latest/hapi/work-with-attachments

With HAPI, we've made it easy for you to add, access, and delete attachments.

## Adding attachments

You can add attachments when you are creating, updating or transitioning an issue. Alternatively, you can add an attachment to an issue without having to update or transition it. To add an attachment you must specify a `[File](https://docs.oracle.com/javase/8/docs/api/java/io/File.html)` object or a path to the file.

The file must be accessible by the path given on the Jira node running this code.

### Adding attachments to an issue

You can attachments to any given issue:

```
            def issue = Issues.getByKey('SR-1')
            issue.addAttachment(new File('/path/to/file'))

            // or
            issue.addAttachment('/path/to/file')
```

You must have permission to create attachments on the project of the given issue.

![Image showing how you add an attachment with HAPI](/sr4js/files/latest/442888519/442888524/1/1758746947000/Attachments_add_attachment.png)

### Adding attachments when creating, updating, or transitioning an issue

Enter the following into the script console:

In this example we're adding an attachment to the issue we're creating. You can also use `addAttachment` when updating or transitioning an issue.

```
            Issues.create('JRA', 'Bug') {
                setSummary('help me!')

                // by File
                addAttachment(new File('/path/to/file'))

                // by String 
                addAttachment('/path/to/other/file')
            }
```

#### Transient data

If you have transient data you wish to add as an attachment, write it to a file, then add the file as an attachment as above, and then delete the file.

## Accessing attachments

You can get access to the attachments of an issue by using the `getAttachments()` extension method, for example:

```
            Issues.getByKey('SR-1').attachments.each { attachment ->
                // do something with "attachment"
                log.warn(attachment.filename)
            }
```

### ![Image showing how you access attachment with HAPI](/sr4js/files/latest/442888519/442888523/1/1758746947000/Attachments_accessing_attachments.png)

### Accessing attachments during transitions

If a user adds attachments in a workflow transition, normally you cannot validate them because the attachment is not accessible via the Jira API until the transition is complete.

However, with HAPI you can access these with the `getAllAttachments()` extension on `[MutableIssue](https://docs.atlassian.com/software/jira/docs/api/latest/com/atlassian/jira/issue/MutableIssue.html)`. Because the attachment has not been committed to the database, `getAllAttachments()` returns a collection of objects that have the following methods: `getMimetype()`, `getFilename()`, `getFilesize()`, `getCreated()`, and `withInputStream`.

This is enough that you can write workflow validators that can check file size, file names, or the content of attachments, without worrying about distinguishing between attachments previously added to the issue and attachments added during this transition.

As an example, you could check in a workflow validator that any attachment on the issue has the contents `blah`:

```
            issue.allAttachments.any {
                it.withInputStream {
                    it.text.trim() == 'blah'
                }
            }
```

Check out our [Validating Attachments/Links In Transitions](https://docs.adaptavist.com/sr4js/latest/features/workflows/validators/validating-attachments-links-in-transitions) documentation for more examples.

## Download URL

We have made it easy to get the download URL for any attachment. This method is useful for reports or email notifications:

```
            issue.attachments*.downloadUrl
```

## Deleting attachments

You can delete attachments using the `delete()` extension method of [Attachment](https://docs.atlassian.com/software/jira/docs/api/latest/com/atlassian/jira/issue/attachment/Attachment.html). For example, to delete all the attachments on a given issue:

```
            issue.attachments.each {
                it.delete()
            }
```

To override security, use:

```
            issue.attachments.each {
                it.deleteOverrideSecurity()
            }
```

  

* * *

## Related content

-   [Javadocs link](https://docs.adaptavist.com/api/javadoc/dc/scriptrunner/8.10.0/hapi/jira/groovydoc/com/adaptavist/hapi/jira/attachments/package-summary.html)
-   [Validating Attachments/Links In Transitions](https://docs.adaptavist.com/sr4js/latest/features/workflows/validators/validating-attachments-links-in-transitions)
-   [Update Fields](https://docs.adaptavist.com/sr4js/latest/hapi/update-fields)
