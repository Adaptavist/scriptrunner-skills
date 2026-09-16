# Create Page

- Platform: confluence-cloud
- Space: SR4CC
- Hierarchy: Features > Macros > Built-In Macros
- Doc ID: doc-sr4cc-619ce06d-ab29-4692-b897-284bf52fdfa9-b19ffd70221d7705
- Source: https://docs.adaptavist.com/sr4cc/latest/features/macros/built-in-macros/create-page

Instructions for the Create Page macro.

The Create Page macro enables you to add new pages in the right place, with the right template, and a correctly formatted page title.

When you are editing or creating a page in Confluence Cloud, you can use ScriptRunner for Confluence Cloud to create a page.

1.  Select Insert, then search for and add Create Page.
    
    The _Create Page Macro_ dialog opens.
    
2.  Give your new page a Title.
    
    Tip: Find available variables
    
    Type a $ in the Title, Prefix, or Suffix field to see all available variables.
    
3.  Ensure the Target Mode field is set to your needs. This field determines whether the new page opens in View or Edit Mode. It's set to _View Mode_ by default.
4.  Optional fields
    1.  _Parent page_: this field defaults to $self, which indicates that the new page's parent is the current one from which it's being created.
    2.  _Source_: This field lets you choose how the new page is pre-filled:
        1.  _None:_ creates a blank page
        2.  _From page:_ copies content and attachments from an existing page
        3.  _From template:_ starts the page from a global template.
    3.  _Prefix, Suffix_, and _Indent:_ these fields allow you to format the title of the new page as desired.
    4.  _Add space:_ add a space between the prefix, title and suffix.
    5.  _Button text:_ the words shown on the button that will create new pages when clicked.
    6.  _Open in new tab_: specifies whether the newly created page will open in a new browser tab.
    7.  _Labels:_ specify labels that will be attached to the newly created page.
5.  Click Save.The macro saves and appears on the page in _Edit_ mode.
6.  Update the page to see the macro as it will appear to others.

## Edit the Create Page Macro

To edit the Create Page macro:

1.  View the page with the previously created macro in Edit mode.
2.  Click the Create Page macro settings and select Edit.
3.  Make your desired changes and click Save.
