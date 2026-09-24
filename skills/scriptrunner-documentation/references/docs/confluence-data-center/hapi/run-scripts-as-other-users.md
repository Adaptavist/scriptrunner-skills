# Run Scripts as Other Users

- Platform: confluence-data-center
- Space: SR4C
- Hierarchy: HAPI
- Doc ID: doc-sr4c-f645b3c2-277a-4dbc-991c-7ead32dcc78c-c1dbbfaf2d3a3e50
- Source: https://docs.adaptavist.com/sr4c/latest/hapi#run-scripts-as-other-users--en

You can use HAPI to run scripts as other users or as an anonymous user!

Note: CQL and HAPI

Where there are CQL statements in example scripts, you can use any CQL statements to modify the scripts to work for you. Visit the [CQL Guide](https://docs.adaptavist.com/sr4c/latest/get-started/cql-guide) for help with CQL.

## Run script as another user

The script that follows adds a label to every page in a space as another user.

1.  To run a script as another user, use a script like this in the [Script Console](https://docs.adaptavist.com/sr4c/latest/features/script-console):
    
    ```
    Users.runAs("user3") {
        Pages.search("space = DS").each { page ->
            page.addLabels("2023")
        }
    }
    ```
    
    After running the script, the pages in the space will have `2023` added by user3.
    

Customize the above script

2.  You can customize this script by updating the username and label.
    
    ```
    Users.runAs("USERNAME") {
        Pages.search("space = DS").each { page ->
            page.addLabels("LABEL")
        }
    }
    ```
    

For tips on adding labels, visit [Work with Labels](https://docs.adaptavist.com/sr4c/latest/hapi/work-with-labels).

## Run script as anonymous user

To run this script, [turn on anonymous access](https://confluence.atlassian.com/doc/setting-up-public-access-156.html). To anonymously run a script to return all pages that have anonymous access, use a script like this in the [Script Console](https://docs.adaptavist.com/sr4c/latest/features/script-console):

1.  Use a script like this in the [Script Console](https://docs.adaptavist.com/sr4c/latest/features/script-console) to anonymously run a script to return all pages that have anonymous access.
    
    ```
    Users.runAnonymously {
        Pages.search("type = page")
    }
    ```
    
    After running this script, you will have a list of pages that have anonymous access:
    
2.  To customize this script, you can change the content type ( `blog`, `page`, `space`, etc.) to suit your needs.
    
    ```
    Users.runAnonymously {
        Pages.search("type = CONTENT")
    }
    ```
    

Warning: A note about permissions

If you use a script that searches pages by ID, you _can_ run the `Pages.getById` method even when global anonymous access is disabled.

## Related pages

-   [HAPI Script Format Help](https://docs.adaptavist.com/sr4c/latest/get-help/hapi-script-format-help)
-   [Search for Pages Using HAPI](https://docs.adaptavist.com/sr4c/latest/hapi/search-for-pages)
-   [Work with Labels Using HAPI](https://docs.adaptavist.com/sr4c/latest/hapi/work-with-labels)
-   [CQL Guide](https://docs.adaptavist.com/sr4c/latest/get-started/cql-guide)
