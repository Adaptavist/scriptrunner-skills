# Search for Pages

- Platform: confluence-data-center
- Space: SR4C
- Hierarchy: HAPI
- Doc ID: doc-sr4c-7ae8e822-59e0-48a7-9740-3c1f8492af0c-b0b3ac74dcea0359
- Source: https://docs.adaptavist.com/sr4c/latest/hapi#search-for-pages--en

Using HAPI, you can search for pages easily!

You can use these methods to create a log or as a start to another HAPI script.

Tip: Tips for writing scripts with CQL and HAPI

-   You can use the methods outlined on this page with other HAPI methods.
-   Where there are CQL statements in example scripts, you can use any CQL statements to modify the scripts to work for you. Visit the [CQL Guide](https://docs.adaptavist.com/sr4c/latest/get-started/cql-guide) for help with CQL.

## Get a page by ID

Tip: Find the ID of a page

Learn how to find the page ID [here](https://confluence.atlassian.com/confkb/how-to-get-confluence-page-id-648380445.html).

The page ID of the page created on [Create a Page](https://docs.adaptavist.com/sr4c/latest/migration/migrating-to-or-from-cloud/rewrite-scripts-for-cloud/adapt-scripts-for-confluence-cloud#create-a-page--en) is `2031640`, so we will use that in the example. To access a page by ID, run a script like this in the [Script Console](https://docs.adaptavist.com/sr4c/latest/features/script-console):

1.  Run a script like this in the [Script Console](https://docs.adaptavist.com/sr4c/latest/features/script-console):
    
    ```
    Pages.getById(2031640).title
    ```
    
    After running this script, the page based on ID is retrieved and you will see the page title in the _Result._
    
2.  You can customize the script by changing the page ID:
    
    ```
    Pages.getById(PAGEID).title
    ```
    

## Search pages

To search for pages by space, use a script like this in the [Script Console](https://docs.adaptavist.com/sr4c/latest/features/script-console):

Use a script like the following in the [Script Console](https://docs.adaptavist.com/sr4c/latest/features/script-console):

```
Pages.search("space = DS")
```

After running this script, you will have a list of pages in the space and see the page creation date printed in the log.

## Related pages

-   [HAPI Script Format Help](https://docs.adaptavist.com/sr4c/latest/get-help/hapi-script-format-help)
-   [CQL Guide](https://docs.adaptavist.com/sr4c/latest/get-started/cql-guide)
-   [Work with Labels Using HAPI](https://docs.adaptavist.com/sr4c/latest/hapi/work-with-labels)
-   [Run Scripts as Other Users](https://docs.adaptavist.com/sr4c/latest/hapi/run-scripts-as-other-users)
