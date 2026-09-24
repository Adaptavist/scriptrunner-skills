# Add Label Macro

- Platform: confluence-data-center
- Space: SR4C
- Hierarchy: Features > Macros > Built-In Macros
- Doc ID: doc-sr4c-e7a12892-ca71-43ff-98c6-4eeeefc8f1b8-4db464f8deaaa4d1
- Source: https://docs.adaptavist.com/sr4c/latest/features#macros--en#built-in-macros--en#add-label-macro--en

The _Add Label_ macro adds specified labels to a page if they are not already present.

Some predefined variables are allowed, and you can overwrite these variables or add specified custom variables.

Note: This macro cannot be edited, but you can disable it.

If you disable it in the instance, users will not be able to use the macro when working with Confluence pages in the instance.

## Video walkthrough

You can watch our video to see the Add Label macro in action.

[Media](https://player.vimeo.com/video/677656510?h=83454a5794)

## Use the Add Label macro on a Confluence page

When you are editing or creating a page in Confluence, you can use ScriptRunner for Confluence to add a label to the page.

1.  Select Insert, and then select Other Macros.
    
2.  Select the Add Label macro from the provided list.
    
3.  Add the labels you want on the page to the Labels field.
    
    Tip: Labels must obey naming restrictions imposed by Atlassian. Certain characters (:, ;, ., ,, ?, &, \[, \], (, ), #, ^, \*, @, !, ', \`, spaces) are not allowed.
    
    When possible, some restricted characters are modified to allow the successful application of labels.
    
    Use Provided Variables as Labels: ScriptRunner provides several variables that you can use to add specific labels to your script. To use them, add the variables to the Labels field as you would any standard label.
    
    -   _$username_ - Username of the person who created and/or edited the page.
    -   _$fullname_ - The full name of the person who created and/or edited the page.
    -   _$year_ - The year when the page was created and/or edited.
    -   _$month_ - The month when the page was created and/or edited.
    -   _$day_ - The day when the page was created and/or edited.
    -   _$parent_ - The parent title of the current page.
    
    Once you save the macro and the page loads, variable labels load with the correct data. The added labels can be seen on the bottom right of the page.
    
4.  Click Insert and the label module appears on the page when the page is in edit mode.
    
5.  Save the Confluence page.

When the page where the macro is located is saved or refreshed, the labels are applied. If some of the labels are already present, only the missing labels are applied. If all the labels are already present, no action is taken.
