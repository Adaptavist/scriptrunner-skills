# Work with Spaces

- Platform: confluence-cloud
- Space: SR4CC
- Hierarchy: hapi
- Doc ID: doc-sr4cc-416678123
- Source: https://docs.adaptavist.com/sr4cc/latest/hapi/work-with-spaces

With HAPI, we've made it easy for you to work wtih spaces! 

## Create a new space with a title and key

To create a space with a space key in Confluence, enter a script like this:

```
def space = Spaces.create("Analytics and Data", "AD") {}
```

This script creates an _Analytics and Data_ space with a space key of _AD_: 

![](/sr4cc/files/latest/416678123/416678131/1/1753904606000/new-space.png)

You can customize the script by changing the space name and space key.

## Delete a space

Run a script like this to delete a space:

```
def space = Spaces.getById(172720132)
space.delete()
```

This message appears after the script runs:

![](/sr4cc/files/latest/416678123/437262832/1/1758300771000/delete-results.png)

You can customize the script by changing the space key. 

## Delete all pages in a space

You can delete all pages in a space with the following statuses:

-   Current
-   Archived
-   Historical
-   Draft

To run this script, you must be an administrator of the space.

To do this, specify the space key in a script like this:

```
Spaces.getByKey("DT").deleteAllPages()
```

When you run the script, the pages are deleted from the space if they had one of the above statuses:

![](/sr4cc/files/latest/416678123/445218908/1/1759351594000/delete-pages.png)

The homepage for the space is not deleted.

To customize this script, change the space key.

## Get all pages in a space

To get a list of pages in a space, enter a script like this:

```
def allPages = Spaces.getByKey("AD").getAllPages()
def allPageTitles = []
allPages.each(page ->
    allPageTitles.add(page.title)
)
allPageTitles
```

The results show a list of the pages:

![](/sr4cc/files/latest/416678123/437262830/1/1758302586000/get-all-pages.png)

You can customize this script by changing the space key.

## Get all pages and their body format in a space

Using HAPI, you can do the following three things with one script: 

1.  Get all pages in a space
2.  Set the body format of each page
3.  Fetch the body of each page

Run this script: 

```
def pages = Spaces.getByKey("TEST").getAllPages(){
        setBodyFormat("storage") 
}
pages.each { page ->
    logger.info("Extracting body contents for page '${page.title}'")
    def storage = page.body.storage.value
    logger.info(storage) //extracted contents of page here
}
```

The results of this script show a list of page keys: 

![](/sr4cc/files/latest/416678123/506009302/1/1770921822000/results-setbodyformat.png)

You can also view the **Logs** to see the page content:

![](/sr4cc/files/latest/416678123/506009301/1/1770921905000/result-pagecontent.png)

You can customize this script by changing the space key.

## Get space permissions

To get space permissions, enter a script like this:

  

```
def space = Spaces.getById(158072836) 
space.getPermissions()
```

The script returns the permission of the space:

![](/sr4cc/files/latest/416678123/437262831/1/1758302147000/space-permissions.png)

You can customize the script by changing the space key. 

## Retrieve a space with its space key

To retrieve a space with its space key in Confluence, enter a script like this:

```
def space = Spaces.getByKey("AD")
```

This script retrieves the space `AD`_:_ 

![](/sr4cc/files/latest/416678123/416678127/1/1753981299000/retrieve-space-with-key.png)

You can customize the script by changing the space key. 

## Retrieve a space with its ID

To retrieve a space with its space ID in Confluence, enter a script like this:

```
def space = Spaces.getById(158072836)
```

This script retrieves a space by the ID `158072836`: 

  

  ![](/sr4cc/files/latest/416678123/416678126/1/1753981423000/retrieve-space-with-id.png)

You can customize the script by changing the space ID.

## Search for spaces with CQL

To search for a space in Confluence with CQL, enter a script like this:

```
def spaces = Spaces.search("valid CQL here")
```

For example:

```
def spaces = Spaces.search("title~data")
```

The script returns a list of spaces containing the word `data` in the title:

![](/sr4cc/files/latest/416678123/416678125/1/1753981512000/cql-hapi.png)

You can customize the script by changing the CQL.

For more information about using CQL, visit [CQL Guide](https://docs.adaptavist.com/sr4cc/latest/features/cql-script-jobs/cql-guide). 

## Update the status of a space

To update the status of a space, enter a script like this:

```
def space = Spaces.getByKey("TST2")
space.update {
    status = "archived"
}
```

After you run the script, the updated status appears in the _Results_:

![](/sr4cc/files/latest/416678123/470057432/1/1763056201000/archived-status.png)

And the space is in the _Archived_ section (_Spaces_ > _Archived_):

![](/sr4cc/files/latest/416678123/470057431/1/1763056201000/archived.png)

You can customize the script by changing the space key and the status. The two accepted statuses are _archived_ and _current_.

## Update the name of the space

To update the space name, enter a script like this: 

```
def space = Spaces.getByKey("DOCS")
space.update {
    name = "Technical Documentation"
}
```

This script will update the name of the space from _Product Documentation_ to _Technical Documentation_. 

After you run the script, the new name appears in the _Results_:

![](/sr4cc/files/latest/416678123/470057430/1/1763410673000/name-change.png)

You can also see the new name in the space: 

![](/sr4cc/files/latest/416678123/470057429/1/1763410771000/tech-doc.png)

You can customize the script by changing the space key and the new name.
