# Converting Include Pages Macro to Include Version

- Platform: confluence-data-center
- Space: SR4C
- Hierarchy: Features > Macros > Built-In Macros > Include Macros
- Doc ID: doc-sr4c-f4b166a6-604e-42ac-8a3b-9cfd1c032797-91c07f6546f7a1d7
- Source: https://docs.adaptavist.com/sr4c/latest/features#macros--en#built-in-macros--en#include-macros--en#converting-include-pages-macro-to-include-version--en

It's difficult to manage multiple _Include Page_ macros on one page. A REST endpoint is included in ScriptRunner for Confluence, which converts all instances of _Include Page_ to _Include Version_.

The version number is specified to be the current latest version, so the page contents should be identical in all instances. The page contents remain identical until one of the includes is modified.

## Create the REST endpoint

You can easily hook up this REST endpoint using a [web item](https://docs.adaptavist.com/sr4c/latest/features/fragments/web-item). Follow these steps to create the web item:

1.  Navigate to General Configuration > ScriptRunner > Fragments.
2.  Click Create Fragment, and then click Custom Web Item.
3.  Fill out the fields that appear in the image:
    
    Note: Help with Condition and Link fields
    
    For the code in the Condition field, select Example Scripts and then copy the _Current page contains particular macros_ code.
    
    The text for the Link field is `/rest/scriptrunner-confluence/latest/content-info/convert-includes?pageId=${page.id}&#url_xsrfToken()`.
    
4.  Click Add.

The following image is the result of this web item being configured:

Note: This result only appears on the pages that contain the _Include Page_ macro.
