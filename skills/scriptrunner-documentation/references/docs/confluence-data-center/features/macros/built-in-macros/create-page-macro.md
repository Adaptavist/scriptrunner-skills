# Create Page Macro

- Platform: confluence-data-center
- Space: SR4C
- Hierarchy: Features > Macros > Built-In Macros
- Doc ID: doc-sr4c-200d6654-7e0d-4349-97fd-ef9cddf6d606-4759b9e5f3ba7539
- Source: https://docs.adaptavist.com/sr4c/latest/features#macros--en#built-in-macros--en#create-page-macro--en

The Create Page macro helps users create pages in the right place, with the correct template, and a correctly formatted page title.

## Walkthrough

Watch our video to see the Create Page macro in action.

[Media](https://player.vimeo.com/video/686660964?h=a51e0cbf80)

## Use the Create Page macro on a Confluence page

Follow these steps to use the Create Page macro:

1.  Click Insert > Other Macros.
    
2.  Select Create Page from the provided list.
    
3.  Complete the desired fields.
    
    Tip: Variables
    
    You can use the following variables in the _Create Macro_ editor fields. When you use a variable, the field will be filled when the field is generated.
    
    -   $day: The current day
    -   $fullname: The full name of the user who created the page
    -   $increment: A number which increments each time a new page is created
    -   $ident: A number which increments each time a new page is created if the title exists
    -   $month: The current month
    -   $parent: Parent page title
        
        Note: Difference from $parenttitle
        
        In the Parent field, this variable is for the page folder. The newly created page will be inside the parent folder structure.
        
    -   $parenttitle: The title of the parent page
        
        Note: Difference from $parent
        
        In the Title field, use this variable to pull the parent title name.
        
    -   $pagetitle: The page title
    -   $self: The current page
    -   $username: The username of the user that created the page
    -   $year: The current year
    
    -   Parent: By default, the created page will use the current page as its parent. However, you can specify a different parent page by supplying the page title. This field also accepts the variables: $self, $parent, $username, $fullname, $year, $month, and $day.
        
        Note: _$fullname_, _$year_, _$month_, and _$day_ only work if the name of the parent exists.For example, if you set $year here, there has to be a page with the title _2023_. Now, the macro can create a new page under this parent page.
        
    -   Title: Specifies the title of the new page. This field also accepts the following variables: $parenttitle, $ident, $username, $fullname, $year, $month and $day.
    -   From Page: Specifies an existing page from which the new page will copy content
    -   Labels: Add labels to the newly created page. Accepts several labels in a comma-separated list. The following variables can be used: $parenttitle, $pagetitle, $username, $fullname, $year, $month, and $day.
        
        Note: Labels must obey naming restrictions imposed by Atlassian. The following characters will be removed (:, ;, ,, ., , ?, &, \[, \], (, ), #, ^, \*, @, !, ' ' spaces ).
        
    -   Title Prefix: Prefix to be applied to the page title given by the user.
    -   Title Suffix: Suffix to be applied to the name given by the user.
    -   Target Mode: Options are _view_ and _edit_. Whether to go to view or edit mode when creating the page. This field is required. The default is _View_.
    -   Template: The name of the template that will be used when creating the new page. If you select a template with variables, you are redirected to a Page Template Wizard when you use the macro to create a new page.
    -   AUI Class: Optional AUI Class to help with styling. Use "aui-button" to represent a button or "aui-message" for an alert-style message. More information can be found at [https://docs.atlassian.com/aui/](https://docs.atlassian.com/aui/) .
    -   CSS: (Optional) Basic CSS to help with styling. Please provide CSS in a comma-separated list, for example: "font-size: 20px, background-color: red". More information can be found at [https://www.w3schools.com/css/default.asp](https://www.w3schools.com/css/default.asp) .
    -   Indent Index: Allow the $ident parameter to start from a specific number.
    -   Add Space: Add a space between prefix and postfix variables. The default is checked.
    -   Prompt Title: Customise the title used in the prompt dialog. If left empty, then the title will be _Please enter the new page title_.
    -   Suppress Notification: Suppress notification while creating the page. The default is unchecked.
    -   Open in a New Tab: Open the created page in a new tab. The default is unchecked.
    
4.  Supply the text that is going to be used to display the _Create Page_ link.
    
5.  Save the Confluence page.
6.  To create the new page, select the link.
    

CAUTION: This is when the _Page Template Wizard_ appears if you selected a template with variables. The wizard gives you the option to fill in variables before the page is created. When you're ready for the finished page, select Next to see the created page.

If you select Open in a New Tab when you create your macro, the Back button on the _Page Template Wizard_ does not work.

The new page looks like this:
