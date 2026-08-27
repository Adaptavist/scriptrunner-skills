# Copy Page Tree

- Platform: confluence-cloud
- Space: SR4CC
- Hierarchy: features > built-in-scripts > space-administration-built-in-scripts
- Doc ID: doc-sr4cc-114204444
- Source: https://docs.adaptavist.com/sr4cc/latest/features/built-in-scripts/space-administration-built-in-scripts/copy-page-tree

Using _Copy_ _Page Tree_, you can copy all pages within a page tree, that is a page and all of its children, to another space or to the same space. When copying you can rename pages or add a prefix to copied pages.

To use this feature, you must have _View_ permissions on all the pages you are copying and _Edit_ permission in the space that you are copying the page tree to.

## Run the script

To use this script, follow these steps: 

1.  Select the space where the page tree is currently located for **Source Space**. 
    
2.  Specify the page tree that you wish to copy in **Select a Space**. 
    
3.  Select the space you want to copy the page tree to **Target Space**. 
    
4.  Add a **Prefix** to be added to the copied pages. 
    
5.  Specify the part or whole page name you wish to transform in the **Search** and **Replace** boxes.
    
    If your **Target Space** is the space where the page tree originated, you must add a prefix or rename the pages since Confluence does not allow pages to have the same name in the same space.
    
6.  Select **Run.**
    
    Links and image links within the tree of pages you are copying will automatically be updated to reflect any new page titles.
    
    ![](/sr4cc/files/latest/114204227/128387455/2/1686598139000/image2021-12-14_13-5-26.png)
    

### Result

After selecting **Run**, the results appear and let you know how long the copy took. 

![](/sr4cc/files/latest/114204227/179608774/1/1684957804000/copy_page_tree_results.png)

## Example

### Copy page tree to have a larger demonstration space

If you have a client demonstration space and want to copy a page tree to have more content in your space, follow these steps: 

1.  For **Source Space**, enter the name of the space you want pages copied from. For this example, _Client Demonstration for CQL (CQLDS_). 
2.  For **Select a Space**, select the page trees you want to copy. For this example, the two demo sections.
3.  For **Target Space**, select the space you want to copy the page tress to. For this example, we are copying to the same space. 
4.  Select a **Parent Page to Copy To**. For this example, we chose the main page tree. 
5.  Enter _Copy_ in **Prefix** to indicate that the copied pages are copies. 
6.  Select **Run**.  
    ![](/sr4cc/files/latest/114204227/179608773/1/1684957835000/copy_page_tree_example.png)

To use **Search** and **Replace,** enter the words into the field. **Search** is the field for the word you want to remove, and **Replace** is for the new word you want to use. For example, you could replace Demo with Demonstration by filling out the fields like this: 

![](/sr4cc/files/latest/114204227/179608771/1/1689182038000/copy_replace.png)

#### Results

Once your script runs, the pages should be copied. Here is what the copied pages will look like in the Confluence space: 

![](/sr4cc/files/latest/114204227/179608770/1/1689182086000/copy_replace_results.png)
