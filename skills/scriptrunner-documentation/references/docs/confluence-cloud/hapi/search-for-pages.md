# Search for Pages

- Platform: confluence-cloud
- Space: SR4CC
- Hierarchy: HAPI
- Doc ID: doc-sr4cc-d7314bd4-e906-45d6-9468-ae1c1e3140fe-32dd2722a9235611
- Source: https://docs.adaptavist.com/sr4cc/latest/hapi/search-for-pages

Learn how to find specific pages through search, using HAPI.

You can search for page using HAPI by entering CQL or a title search.

## Search for pages using the title

Searching for a massive page list that could be unlimited could lead to using a lot of memory. We recommend searching for a specific number:

-   For example, the top 10:
    
    ```
    Pages.search('title = Overview').take(10)
    ```
    
    The results show the following information for each page titled _Overview_.
    
    You can customize this search by replacing the title.
    
    Warning: DO NOT attempt to convert a potentially unlimited set to a List, like:
    
    ```
    Pages.search('title = Overview').toList()
    ```
    
-   If you need a list of results, limit it to a specific number like 100.
    
    The following script finds the top 100 results for that title and adds the label `review`.
    
    ```
    Pages.search('title = Overview').take(100).toList().each { it.addLabels("review") }
    ```
    
    Once this script is run, a label is added to the found pages. You can now see the label in the results:
    
    And you can see the label on the page:
    
    You can customize this script by changing the title, number of results, and the label.
    
-     
    
    Tip: You can filter results further with another condition:
    
    ```
    Pages.search('title = FOO').findAll { 
    // condition }
    ```
    

## Search for pages where the title contains certain words

-   To search for a page using part of the title, use a script like this:
    
    ```
    def pages = Pages.search("title~test")
    def selectedPages = []
    pages.each(page->{
        selectedPages.add(page.title)
    })
    selectedPages
    ```
    
    The results of the search provide you with titles that contain the word(s) you searched for:
    
-   You can customize the script by changing the title search.

## Search for pages using CQL

To search for a space in Confluence, enter a script like this:

```
Pages.search('valid CQL here').each {
     // do something with it
 }
```

The results of the search are page IDs in the result:

You can customize this script by changing the CQL.
