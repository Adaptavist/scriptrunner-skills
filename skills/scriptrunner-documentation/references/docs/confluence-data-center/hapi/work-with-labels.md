# Work with Labels

- Platform: confluence-data-center
- Space: SR4C
- Hierarchy: HAPI
- Doc ID: doc-sr4c-f1d5e3a9-bf7d-43f8-9712-1de393439189-c028d73a804919b3
- Source: https://docs.adaptavist.com/sr4c/latest/hapi#work-with-labels--en

HAPI makes it easier for you to add, replace, and remove labels!

You can search for the labels based on different criteria, like labels in a space, labels created by a certain user, etc.

Tip: Tips for writing scripts with CQL and HAPI

-   Where there are CQL statements in example scripts, you can use any CQL statements to modify the scripts to work for you. Visit the [CQL Guide](https://docs.adaptavist.com/sr4c/latest/get-started/cql-guide) for help with CQL.
-   You can use the methods outlined on this page with other HAPI methods.

## Add labels

Using HAPI, you can add one or multiple labels designated in the script.

### Add a label to a specific page in a space

-   To add a label to a page in a space, use a script like this [Script Console](https://docs.adaptavist.com/sr4c/latest/features/script-console):
    
    ```
    Pages.search("space = DS and title = '2023 Page 2'").each { page ->
        page.addLabels("new")
    }
    ```
    
-   After runing this script, the _2023 Page 2_ in the _Demonstration Space (DS)_ has the new label:
-   You can customize the script by changing the space key, the title, or the labels.
    
    ```
    Pages.search("space = SPACEKEY and title = 'THE TITLE'").each { page ->
        page.addLabels("label-1")
    }
    ```
    

### Add labels to pages in a space created by a specific user

-   To add labels to pages in a space created by a user, use a script like this in the [Script Console](https://docs.adaptavist.com/sr4c/latest/features/script-console):
    
    ```
    Pages.search("space = DS and creator = admin").each { page ->
        page.addLabels("label-1", "label-2")
    }
    ```
    
    After running the script, any page created by the admin user in the _Demonstration Space_ ( _DS)_ will have the labels `label-1` and `label-2`.
    
-   You can customize the script by changing the space key, username, and labels.
    
    ```
    Pages.search("space = SPACEKEY and creator = USERNAME").each { page ->
        page.addLabels("label-1", "label-2")
    }
    ```
    

## Remove labels

Using HAPI, you can remove one or multiple labels designated in the script.

### Remove a label from all pages in a space

-   To remove a label from all pages in a space, use a script like this in the [Script Console](https://docs.adaptavist.com/sr4c/latest/features/script-console):
    
    ```
    Pages.search("space = DS").each { page ->
        page.removeLabels("new")
    }
    ```
    
    After running this script, the named label ( `new`) is removed from the _Demonstration Space_ ( _DS_). The results also list the pages that were updated.
    
-   You can customize the script by changing the space key and the label.
    
    ```
    Pages.search("space = SPACEKEY").each { page ->
        page.removeLabels("label")
    }
    ```
    

### Remove a label added by a specific user

-   To remove multiple labels from pages created by a user, use a script like this in the [Script Console](https://docs.adaptavist.com/sr4c/latest/features/script-console):
    
    ```
    Pages.search("creator = user4").each { page ->
        page.removeLabels("label-2")
    }
    ```
    
    After running this script, `label-2` labels will be removed from pages created by _user4_. The results show you what pages were updated.
    
-   You can customize this script by changing the username and labels.
    
    ```
    Pages.search("creator = USERNAME").each { page ->
        page.removeLabels("label-1", "label-2")
    }
    ```
    

## Replace labels

Using HAPI, you can replace labels designated in the script.

### Replace labels on a page

-   To rename labels on a page, use a script like this in the [Script Console](https://docs.adaptavist.com/sr4c/latest/features/script-console):
    
    ```
    Pages.search("space = DS").each { page ->
        page.replaceLabel {
            from = "new" //This is the existing label
            to = "old" //This is the new label you want to add
        }
    }
    ```
    
    The label `new` on pages in the _Demonstration Space_ ( _DS_) will be replaced with the label `old`.
    
-   You can customize the script by changing the space key and labels.
    
    ```
    Pages.search("space = SPACEKEY").each { page ->
        page.replaceLabel {
            from = "label-1"
            to = "label-2"
        }
    }
    ```
    

## Update labels

Using HAPI, you can update labels by adding, removing, replacing, setting, and clearing labels designated in the script.

### Add, replace, and remove labels in the same script

To add, rename, and remove labels to pages in a space, use a script like this:

```
Pages.search("space = DS").each { page ->
    page.updateLabels {
        add("one", "two", "three")
        replace("one", "ten") //One will be replaced with ten
        remove("ten")
    }
}
```

-   To add, rename, and remove labels to pages in a space, use a script like this:
    
    ```
    Pages.search("space = DS").each { page ->
        page.updateLabels {
            add("one", "two", "three")
            replace("one", "ten") //One will be replaced with ten
            remove("ten")
        }
    }
    ```
    
    After you run the script, the _Demonstration Space_ ( _DS_) pages will get the `one`, `two`, and `three` labels added. Then, `one` is replaced with `ten`. Then, the script removes the label `ten`. Ultimately, you are left with the labels two and three on each page. Since the `old` label was preexisting and not removed in the script, it still exists.
    
-   You can customize the script by changing the space key and labels.
    
    ```
    Pages.search("space = SPACEKEY").each { page ->
        page.updateLabels {
            add("label1", "label2", "label3")
            replace("label1", "label4")
            remove("label4")
        }
    }
    ```
    

### Remove all labels in a space

Warning: This step is not reversible. Please use a test space to attempt these scripts before you run them in production.

-   To remove all labels from pages in a space, use a script like this in the [Script Console](https://docs.adaptavist.com/sr4c/latest/features/script-console):
    
    ```
    Pages.search("space = DS").each { page ->
        page.updateLabels {
            clear()
        }
    }
    ```
    
    After running this script, your space will no longer have labels. The results show you what pages were updated.
    
-   You can customize the script by changing the space key.
    
    ```
    Pages.search("space = SPACEKEY").each { page ->
        page.updateLabels {
            clear()
        }
    }
    ```
    

### Remove all labels and then add a label to all pages in a space

-   To completely remove all labels from a space and then add a new label to pages in the space, use a script like this:
    
    ```
    Pages.search("space = DS").each { page ->
        page.updateLabels {
            set("completed")
        }
    }
    ```
    
    After running the script, pages in the space will all have the label `completed` as the only label.
    
-   You can customize the script by changing the space key and label.
    
    ```
    Pages.search("space = SPACEKEY").each { page ->
        page.updateLabels {
            set("label")
        }
    }
    ```
    

## Related pages

-   [HAPI Script Format Help](https://docs.adaptavist.com/sr4c/latest/get-help/hapi-script-format-help)
-   [CQL Guide](https://docs.adaptavist.com/sr4c/latest/get-started/cql-guide)
-   [Search for Pages Using HAPI](https://docs.adaptavist.com/sr4c/latest/hapi/search-for-pages)
