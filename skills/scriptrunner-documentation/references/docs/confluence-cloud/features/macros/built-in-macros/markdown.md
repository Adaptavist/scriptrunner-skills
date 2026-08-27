# Markdown

- Platform: confluence-cloud
- Space: SR4CC
- Hierarchy: features > macros > built-in-macros
- Doc ID: doc-sr4cc-574521570
- Source: https://docs.adaptavist.com/sr4cc/latest/features/macros/built-in-macros/markdown

The _Markdown_ macro lets you use Markdown to format Confluence pages as needed. You can use this macro to insert your own [Markdown](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet) inline tags or to render them from a URL.

Migration

The Markdown macro supports migrated content from ScriptRunner for Confluence DC to our Cloud-based app

## Use the Markdown Macro

How to use the Markdown macro:

1.  Open a desired page in Confluence in _Edit_ mode.
2.  Click or type to insert an element and select **Markdown**.  
    ![](/sr4cc/files/latest/574521570/574521576/1/1783970372000/insert_markdown_macro.png)  
    The _Insert_ _Markdown dialog_ opens.
3.  Select **Link to a Markdown file** to fetch content from an external URL or **P****aste Markdown content**, to type or paste directly into the macro.  
    
    Link to a Markdown file requirements and limitations
    
    Before adding a URL to the Markdown Macro, be sure to consult the documentation below on the requirements and limitations. 
    
    ![](/sr4cc/files/latest/574521570/578289674/1/1785360418000/example-markdown-macro-content.png)
4.  (Optional) Click the **Preview** tab and **Refresh preview** to see what your content will look like on the published page.
5.  Click **Save** to save your changes and view the macro.  
    ![](/sr4cc/files/latest/574521570/574521573/1/1783970371000/markdown-marcro-rendered.png)

## Link to a Markdown file

Usually, you would want to include Markdown from a [Gist](https://gist.githubusercontent.com/evanmoran/2041020/raw/2b565d7c92cfebe10ce769c76223359d1c3c2f85/markdown.md) or a repository in [GitHub](https://raw.githubusercontent.com/atlassian/commonmark-java/master/README.md) or [Bitbucket](https://bitbucket.org/atlassian/atlassian-spring-scanner/raw/master/README.md). In GitHub and Bitbucket, use the raw content URL to link to the original Markdown file.

If you want to display Markdown from another Atlassian product (such as Bitbucket Server), the macro automatically detects whether you have an application link configured for the URL you entered and uses it to retrieve the content. If you place Markdown in the body of the macro and you provide a URL, the Markdown in the body of the macro will be ignored.

Limitations

The _Link to Markdown file_ option only works with publicly accessible URLs that don't require authentication and meet the requirements below.

### Requirements

Markdown files loaded from a URL must meet these requirements:

-   The URL must use `http` or `https`.
-   The URL must not contain embedded credentials.
-   The URL must resolve to a public internet address.
-   The URL must return a successful `2xx` response.
-   Redirects are not followed, so the URL must point directly to the Markdown file.
-   The response must use one of these content types:
    -   `text/plain`
    -   `text/markdown`
    -   `text/x-markdown`
    -   `application/markdown`
    -   `application/x-markdown`
-   The response body must be 1 MB or smaller.
-   The remote server must respond within the request timeout.

If the URL cannot be fetched, the macro displays a generic fetch error.

#### Limitations

The Markdown macro does not support:

-   `file://` URLs
-   FTP, SFTP, or FTPS URLs
-   Localhost URLs
-   Private network or intranet URLs
-   URLs that require authentication
-   URLs that only work when viewed in a browser session
-   Repository webpage URLs that return HTML instead of raw Markdown.

## Edit the Markdown Macro

To edit the Markdown macro:

1.  View the page with the previously created macro in **Edit** mode.
2.  Click the **Markdown macro settings** and select **Edit**.  
    ![](/sr4cc/files/latest/574521570/574521572/2/1784038816000/edit_markdown_macro.png)
3.  Make your desired changes and click **Save**.

## Supported markdown in the editor

**Format**  
 

**Markdown shortcut**  
 

Bold

`**Bold**`

Italic

`*Italic*`

Strikethrough

`~~Strikethrough~~`

Code

`` `Code` ``

Heading 1

`#` `Space`

Heading 2

`##` `Space`

Heading 3

`###` `Space`

Heading 4

`####` `Space`

Heading 5

`#####` `Space`

Heading 6

`######` `Space`

Numbered list

1.  `Space`
    

Bulleted list

`*` `Space`

Quote

`>` `Space`

Code snippet

` ``` ` `Space`

Divider

`---` `Space`

Link

### `[LinkTitle]([http://a.com](http://a.com))`

Action item

`[]` `Space`

Decision

`<>` `Space`
