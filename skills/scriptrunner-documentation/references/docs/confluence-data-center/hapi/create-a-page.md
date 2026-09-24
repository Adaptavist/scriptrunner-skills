# Create a Page

- Platform: confluence-data-center
- Space: SR4C
- Hierarchy: HAPI
- Doc ID: doc-sr4c-6779c822-ee7c-4aa0-af74-fa2013a1a1b7-5ae3bad76ecb9881
- Source: https://docs.adaptavist.com/sr4c/latest/hapi#create-a-page--en

With HAPI, we've made it easy for you to create new pages in your Confluence instance!

## Create a new page

To create a new page, run a script like this in the [Script Console](https://docs.adaptavist.com/sr4c/latest/features/script-console):

```
Pages.create("DS", "2023 Page 1") {
    setParentPage("2023 Pages")
}
```

Warning: A note about parent pages

-   The parent page must already be created. If you don't specify a parent page, the space's homepage is used as the default.
-   A user will have access to the page they create even if they don't have access to the parent page.

This script creates a new page in the _Demonstration Space_ (_DS_), under the parent page _2023 Pages_.

Tip: Customize the above script

You can customize the script by changing the space, page title, and parent page.

```
Pages.create("SPACEKEY", "NEW PAGE TITLE") {
    setParentPage("PARENT PAGE TITLE")
}
```

## Create a new page with labels

We'll build on the above script to add a new page with labels!

Use the following script:

```
Pages.create("DS", "2023 Page 2") {
    setLabels("new", "2023")
    setParentPage("2023 Pages")
}
```

And here is your new page with labels:

To learn about HAPI labels, visit [Work with Labels](https://docs.adaptavist.com/sr4c/latest/hapi/work-with-labels).

Customize the above script

You can customize the script by changing the space, page title, labels and parent page.

```
Pages.create("SPACEKEY", "NEW PAGE TITLE") {
    setLabels("LABEL-1", "LABEL-2")
    setParentPage("PARENT PAGE TITLE")
}
```

## Related pages

-   [HAPI Script Format Help](https://docs.adaptavist.com/sr4c/latest/get-help/hapi-script-format-help)
-   [Script Console](https://docs.adaptavist.com/sr4c/latest/features/script-console)
-   [Work with Labels](https://docs.adaptavist.com/sr4c/latest/hapi/work-with-labels)
