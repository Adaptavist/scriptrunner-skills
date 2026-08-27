# Work with Pages

- Platform: confluence-cloud
- Space: SR4CC
- Hierarchy: hapi
- Doc ID: doc-sr4cc-416678065
- Source: https://docs.adaptavist.com/sr4cc/latest/hapi/work-with-pages

With HAPI, we've made it easy for you to work with pages!

Create a page

A note about parent pages

-   The parent page must already exist. If you don't specify a parent page, the space's homepage is the default parent page.
-   A user **will** have access to the page they create, even if they don’t have access to the parent page.

To create a new page, run a script like this:

```
Long  parentPageId = 196721
def parentPage = Pages.getById(parentPageId)
def page = Pages.create("TEST", "FAQ")
{
setParentPage(parentPage)
}
```

When the script finishes running, you see a log entry. This script creates a new page called `FAQ` in the Test space: 

![](/sr4cc/files/latest/416678065/416678069/1/1753895712000/FAQ.png)

You can customize the script by changing the space key, page title, and parent page ID.

## Create a new page with labels

To learn about HAPI labels, visit [Work with Labels](https://docs.adaptavist.com/sr4cc/latest/hapi/work-with-labels).

We'll build on the above script to add a new page with labels. Run a script like this:

```
def newHapiDoc = Pages.create("TEST", "HAPI Documentation")
newHapiDoc.addLabels("documentation")
newHapiDoc.getLabels()
```

Again, you'll see a log entry when the script finishes running. And here is your new page called `HAPI Documentation` with the `documentation` label: 

![](/sr4cc/files/latest/416678065/416678067/1/1753906509000/new-page-with-labels.png)

You can customize the script by changing the space key, page title, and labels.

## Delete a page

Learn how to find the page ID [here](https://confluence.atlassian.com/confkb/how-to-get-confluence-page-id-648380445.html).

To delete a page, run a script like this:

```
Long pageId = 370573362
def pageToBeDeleted = Pages.getById(pageId)
pageToBeDeleted.delete()
```

This script deletes a page, which is identified by its page ID. You can see the _Return Page ID_ page was deleted from the _Test_ space. 

![](/sr4cc/files/latest/416678065/416678068/1/1753896766000/delete-2.png)

You can customize this script by changing the page ID.

## Get a page by ID

Learn how to find the page ID [here](https://confluence.atlassian.com/confkb/how-to-get-confluence-page-id-648380445.html).

To access a page by ID, run a script like this:

```
Pages.getById(196721).id
```

After running this script, the page with the specified ID is retrieved and the page title appears in the _Result_.

![](/sr4cc/files/latest/416678065/419662110/1/1754684637000/page-id-hapi.png)

You can customize the script by changing the page ID. 

### Set the body format

You can set the body format when getting a page. For example:

```
def page = Pages.getById(196721){
	setBodyFormat("storage") // this could also be view or atlas_doc_format
}
```

Once the body format is set for a page, you can access the body of the page, if it exists. For example:

```
page.body.storage.value // this could also be page.body.view.value or page.body.atlasDocFormat.value
```

Body format options when getting a page

You must understand the following whenever you want to access a page’s body:

-   You need to set the body format each time you fetch the page
-   `storage` and `view` return the body as a string
-   `atlas_doc_format` returns the body in Atlassian Document Format (ADF), for example:
    -   `{"type":"doc","content":[{"type":"paragraph","content":[{"text":"Example","type":"text"}]}],"version":1}`

## Move a page to a new space

You can move an existing page to a different space.

You must be an administrator of both the page and the space to run this script.

The page will be moved to the top level of the specified space. Identify the page by ID and the space by space key, like this:

```
Pages.getById(196721).moveToSpace("TEST")
```

The page appears in the specified space:

![](/sr4cc/files/latest/416678065/445218887/1/1759350208000/hapi-move-page.png)

You can customize this script by replacing the page ID and the space key.

## Update a page

Learn how to find the page ID [here](https://confluence.atlassian.com/confkb/how-to-get-confluence-page-id-648380445.html).

Using the same page ID, 196731, we are going to update the page. The following script updates the page's title: 

```
def page = Pages.getById(196721)
 page.update {
     title = "Updated HAPI Documentation"
     status = "current"
 
 }
```

After running the script, the page's title will be updated to what the script specifies: 

![](/sr4cc/files/latest/416678065/423166405/1/1755275867000/page-update.png)

You can customize the script by updating the page ID and title.

### Update the body text of a page

Learn how to find the page ID [here](https://confluence.atlassian.com/confkb/how-to-get-confluence-page-id-648380445.html).

Using the page ID, you can update the body text of a page with a script like this: 

```
Pages.getById(196721).update { body = "Please update this page with new enhancements." }
```

This will replace the current existing body of the page. Any existing text, images, or macros will be removed and replaced with what is specified in this script.

After running this script, the page's body will be updated to what the script specifies: 

![](/sr4cc/files/latest/416678065/477865062/1/1765224242000/update-body.png)

You can customize the script by updating the page ID and body text.
