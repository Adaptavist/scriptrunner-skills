# Code Editor

- Platform: confluence-data-center
- Space: SR4C
- Hierarchy: Best Practices and App Management
- Doc ID: doc-sr4c-0ce0082d-edd9-46e6-9729-99c1a72f3713-fbbd1449a84a17d8
- Source: https://docs.adaptavist.com/sr4c/latest/best-practices-and-app-management#code-editor--en

Use the _Code Editor_ to write scripts in ScriptRunner.

The browser-based _Code Editor_ provides code completions, inline Javadoc lookups, inline find and replace, and error line indication.

## Completions

The code editor automatically displays suggestions as you type. Suggestions are filtered as you type, so only relevant options are displayed. Use the arrow keys and Enter or Tab to select a suggestion. You can manually trigger completions with Control+Space.

When referring to a class, the code editor will automatically add the required import.

To save typing, use camel case abbreviations. For example, type `ComLoc.comLoc` to get `ComponentLocator.componentLocator.`

### Smart Completions

Press Ctrl+Alt+Space to show a list of completions that match the expected type of assignment or parameter type.

### Parameters

When typing method parameters, it is easy to forget the expected types. Parameter types, and where possible names, are shown for the given method. Use the up/down cursor keys to scroll through any available overloads.

Press Command+Shift+Space to view parameters when inside a method.

## Javadoc

The code editor can help you understand the purpose of classes, methods, and properties by loading the associated Javadoc. The Javadoc is shown in the editor as a pop-up. To view the Javadoc, press Control+Space with completions open. It will be displayed automatically from then on. To close it, press Control+Space again.

## Find and Replace

The code editor allows you to use find and replace in the code editor. To access find and replace, press ⌘+F (mac) or Ctrl+F (windows).

To search for text, enter it in the _Find_ field. To access find and replace, press ⌘+H (mac) or Ctrl+H (windows).

## Error Line Indicator

Errors in your script are highlighted in the right-hand panel of the script editor. Errors are highlighted inline, on the scroll bar, and in the right-hand overview ruler. When you have located an error, hover over the error with the cursor to see a summary.

## Full Screen Editing

1.  To open the script editor in full screen, click the icon or press F11 when the cursor is in the editor.
2.  To exit the full screen, press F11 or Esc twice when the cursor is in the editor.

## Restrictions

There are some limitations to the code editor; work is ongoing to reduce these limitations. As mentioned, Javadoc for Bamboo APIs, and ScriptRunner's API (e.g. Behaviours) is not available. However, completions and parameter hints are available for all.
