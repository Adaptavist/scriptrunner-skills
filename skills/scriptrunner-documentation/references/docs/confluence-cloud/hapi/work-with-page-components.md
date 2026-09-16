# Work with Page Components

- Platform: confluence-cloud
- Space: SR4CC
- Hierarchy: HAPI
- Doc ID: doc-sr4cc-c577b68e-034c-4135-8131-dfcff56c7122-36f2a818514e7655
- Source: https://docs.adaptavist.com/sr4cc/latest/hapi/work-with-page-components

Learn about using HAPI to complete tasks associated with page components.

Use HAPI to easily work with Confluence content like attachments and comments!

## Attachments

### Get all attachments of a page

You can get all attachments of a page using a script like this:

```
def attachmentIterator = Pages.getById(16252929).getAttachments()
def attachments = []
while (attachmentIterator.hasNext()) {
 def nextAttachment = attachmentIterator.next()
    attachments.add(nextAttachment.title)
}
attachments
```

The results look like this:

You can customize this script by replacing the page ID.

## Comments

### Add a footer comment to a page

You can add a footer comment to a page. Specify the page by ID and add your comment in a script like this:

```
Pages.getById(123).addComment("Please review this page.")
```

Your comment should look like this:

You can customize this script by replacing the page ID and comment text.
