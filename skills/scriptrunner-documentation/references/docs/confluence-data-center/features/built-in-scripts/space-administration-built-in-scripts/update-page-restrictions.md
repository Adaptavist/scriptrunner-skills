# Update Page Restrictions

- Platform: confluence-data-center
- Space: SR4C
- Hierarchy: Features > Built-In Scripts > Space Administration Built-In Scripts
- Doc ID: doc-sr4c-7bb6b4bf-87d3-415d-9913-21539ab1cad5-a7c524dc0b2d9753
- Source: https://docs.adaptavist.com/sr4c/latest/features#built-in-scripts--en#space-administration-built-in-scripts--en#update-page-restrictions--en

Using the _Update Page Restrictions_ built-in script, you can easily manage the editing restrictions to the pages in your space.

Note: In Confluence without ScriptRunner, editing restrictions added to a parent page are not inherited to child pages; however, view restrictions are inherited. Pages need to be restricted individually for editing.

It is quick and easy to select multiple page trees or individual pages to set page restrictions in bulk rather than one-by-one. By selecting a parent page, you'll apply all the restrictions to that page and all of its descendants. Running this script will replace any existing restrictions that the selected content has.

## Run the script

Follow these steps to run the built-in script:

1.  Select Space Tools from the bottom left-hand corner of the screen.
2.  Select Advanced Space Functionality.
3.  Select Update Page Restrictions.
4.  Select the Space you want to work with.
5.  When Page(s) appears, select specific pages within the space to work with, or select the entire space.
6.  Choose one of the following three options for Restriction Level:
    
    -   Anyone can view and edit
    -   Anyone can view, only users and groups chosen in this script can edit
        
        When you select this option, two more fields appear: Groups and Users, where you determine which users and groups can edit.
        
    -   Only users and groups chosen in this script can view and edit
        
        When you select this option, two more fields appear: Groups and Users, where you determine which users and groups can view and edit.
        
    
7.  Select Run.
    
    Instead, you can select Preview to view changes before implementing them.
    

Once you run the script, the results of the script appear. Restrictions are applied to the selected page and all ancestors of the page. However, this feature does not override the Confluence permission hierarchy. If you change the restrictions of a page, or set of pages, the restrictions of an ancestor of the page with a higher level of restrictions are observed.

Tip: Read more about page restrictions in the [Confluence Page Restrictions](https://confluence.atlassian.com/doc/page-restrictions-139414.html) documentation.

## Examples

Restrict editing and viewing restrictions of certain pages to a certain group

Using this built-in script, you can restrict certain pages within a space to certain groups of users. In the following example, we will restrict pages in a _Customer Analytics_ section in the _Analytics_ space to the _customers_ group. Only they will be able to edit and view the pages.

To set up the script, follow these steps:

1.  Select Space Tools from the bottom left-hand corner of the screen.
2.  Select Advanced Space Functionality.
3.  Select Update Page Restrictions.
4.  Enter Analytics for Space.
5.  Select Customer Analytics for Pages.
6.  Pick Only users and groups chosen in this script can view and edit for Restriction Level.
7.  Enter customers for Groups.
8.  Select Run.
    

After running the script, you will see the Result:
