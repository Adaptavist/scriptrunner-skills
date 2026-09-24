# Inherit Parent Permissions For New Pages Listener

- Platform: confluence-data-center
- Space: SR4C
- Hierarchy: Features > Event Listeners > Built-In Listeners
- Doc ID: doc-sr4c-883d1aea-f0eb-4819-8e28-f229d9dad827-6a49967adbf1fdc5
- Source: https://docs.adaptavist.com/sr4c/latest/features#event-listeners--en#built-in-listeners--en#inherit-parent-permissions-for-new-pages-listener--en

Use the _Inherit Parent Permissions For New Pages_ built-in listener to create pages that inherit the parent page restrictions.

In Confluence, by default, view restrictions are inherited. This means that a view restriction applied to one page will cascade down to any child pages. Edit restrictions are not inherited, which means pages need to be restricted individually. _Inherit Parent Permissions For New Pages_ offers administrators the option to specify which spaces should inherit parent page view and edit restrictions automatically.

Follow these steps to configure the listener:

1.  Navigate to General Configuration > ScriptRunner > Event Listeners.
2.  Select Create Listener.
3.  Select Inherit Parent Permissions For New Pages.
4.  Enter a Name to describe your listener.
5.  Fill out the Location field:
    
    -   Choose All Spaces to inherit restrictions in all spaces across the instance.
    -   Choose Select Spaces to inherit restrictions only on a subset of spaces.
        
        If you choose this option, Space(s) appears for you to designate the space you want to work with.
        
    
6.  Select Add.
    

The _Inherit Parent Permissions For New Pages_ listener considers only the immediate parent page restrictions and applies them to newly created pages. The listener does not apply cumulative restrictions from all the ancestors of a page.

Note: Read more about page restrictions in the [Confluence Page Restrictions](https://confluence.atlassian.com/doc/page-restrictions-139414.html) documentation.
