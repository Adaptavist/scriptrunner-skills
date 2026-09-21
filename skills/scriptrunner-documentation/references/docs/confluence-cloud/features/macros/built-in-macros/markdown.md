# Markdown

- Platform: confluence-cloud
- Space: SR4CC
- Hierarchy: Features > Macros > Built-In Macros
- Doc ID: doc-sr4cc-84442b89-50c7-4400-852a-827a0d6eff52-ca4832e4b31b132c
- Source: https://docs.adaptavist.com/sr4cc/latest/features/macros/built-in-macros/markdown

Instructions for the Markdown macro.

The _Markdown_ macro lets you use Markdown to format Confluence pages as needed. You can use this macro to insert your own [Markdown](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet) inline tags or to render them from a URL.

Note: Migration

The Markdown macro supports migrated content from ScriptRunner for Confluence DC to our Cloud-based app

## Use the Markdown Macro

How to use the Markdown macro:

1.  Open a desired page in Confluence in _Edit_ mode.
2.  Click or type to insert an element and select Markdown.
    
    The _Insert Markdown dialog_ opens.
    
3.  Select Link to a Markdown file to fetch content from an external URL or Paste Markdown content, to type or paste directly into the macro.
    
    Warning: Link to a Markdown file requirements and limitations
    
    Before adding a URL to the Markdown Macro, be sure to consult the documentation below on the requirements and limitations.
    
4.  Optional: Click the Preview tab and Refresh preview to see what your content will look like on the published page.
5.  Click Save to save your changes and view the macro.

## Link to a markdown file

Usually, you would want to include Markdown from a [Gist](https://gist.githubusercontent.com/evanmoran/2041020/raw/2b565d7c92cfebe10ce769c76223359d1c3c2f85/markdown.md) or a repository in [GitHub](https://raw.githubusercontent.com/atlassian/commonmark-java/master/README.md) or [Bitbucket](https://bitbucket.org/atlassian/atlassian-spring-scanner/raw/master/README.md). In GitHub and Bitbucket, use the raw content URL to link to the original Markdown file.

If you want to display Markdown from another Atlassian product (such as Bitbucket Server), the macro automatically detects whether you have an application link configured for the URL you entered and uses it to retrieve the content. If you place Markdown in the body of the macro and you provide a URL, the Markdown in the body of the macro will be ignored.

Warning: Limitations

The _Link to Markdown file_ option only works with publicly accessible URLs that don't require authentication and meet the requirements below.

### Requirements

Markdown files loaded from a URL must meet these requirements:

-   The URL must use `http` or `https`.
-   The URL must not contain embedded credentials.
-   The URL must resolve to a public internet address.
-   The URL must return a successful `2xx` response.
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

### Limitations

The Markdown macro does not support:

-   `file://` URLs
-   FTP, SFTP, or FTPS URLs
-   Localhost URLs
-   Private network or intranet URLs
-   URLs that require authentication
-   URLs that only work when viewed in a browser session
-   Repository webpage URLs that return HTML instead of raw Markdown.

Note: Character limit

The character limit for a Markdown macro is 9000 characters. If more characters are entered, the macro configuration will not save.

As a workaround, you can use multiple macros to contain your desired content.

## Edit the Markdown Macro

To edit the Markdown macro:

1.  View the page with the previously created macro in Edit mode.
2.  Click the Markdown macro settings and select Edit.
3.  Make your desired changes and click Save.

### Supported markdown in the editor

<table class="table" id="topic-1274--en__generated-table-id-1"><caption></caption><colgroup><col><col></colgroup><thead class="thead"><tr class="row"><th class="entry" id="topic-1274--en__generated-table-id-1__entry__1">Format</th><th class="entry" id="topic-1274--en__generated-table-id-1__entry__2">Markdown shortcut</th></tr></thead><tbody class="tbody"><tr class="row"><td class="entry" headers="topic-1274--en__generated-table-id-1__entry__1 topic-1274--en__generated-table-id-1__entry__2 " rowspan="1" colspan="1">Bold</td><td class="entry" headers="topic-1274--en__generated-table-id-1__entry__1 topic-1274--en__generated-table-id-1__entry__2 " rowspan="1" colspan="1"><code class="ph codeph">**Bold**</code></td></tr><tr class="row"><td class="entry" headers="topic-1274--en__generated-table-id-1__entry__1 topic-1274--en__generated-table-id-1__entry__2 " rowspan="1" colspan="1">Italic</td><td class="entry" headers="topic-1274--en__generated-table-id-1__entry__1 topic-1274--en__generated-table-id-1__entry__2 " rowspan="1" colspan="1"><code class="ph codeph">*Italic*</code></td></tr><tr class="row"><td class="entry" headers="topic-1274--en__generated-table-id-1__entry__1 topic-1274--en__generated-table-id-1__entry__2 " rowspan="1" colspan="1">Strikethrough</td><td class="entry" headers="topic-1274--en__generated-table-id-1__entry__1 topic-1274--en__generated-table-id-1__entry__2 " rowspan="1" colspan="1"><code class="ph codeph">~~Strikethrough~~</code></td></tr><tr class="row"><td class="entry" headers="topic-1274--en__generated-table-id-1__entry__1 topic-1274--en__generated-table-id-1__entry__2 " rowspan="1" colspan="1">Code</td><td class="entry" headers="topic-1274--en__generated-table-id-1__entry__1 topic-1274--en__generated-table-id-1__entry__2 " rowspan="1" colspan="1"><code class="ph codeph">`Code`</code></td></tr><tr class="row"><td class="entry" headers="topic-1274--en__generated-table-id-1__entry__1 topic-1274--en__generated-table-id-1__entry__2 " rowspan="1" colspan="1">Heading 1</td><td class="entry" headers="topic-1274--en__generated-table-id-1__entry__1 topic-1274--en__generated-table-id-1__entry__2 " rowspan="1" colspan="1"><code class="ph codeph">#</code> <code class="ph codeph">Space</code></td></tr><tr class="row"><td class="entry" headers="topic-1274--en__generated-table-id-1__entry__1 topic-1274--en__generated-table-id-1__entry__2 " rowspan="1" colspan="1">Heading 2</td><td class="entry" headers="topic-1274--en__generated-table-id-1__entry__1 topic-1274--en__generated-table-id-1__entry__2 " rowspan="1" colspan="1"><code class="ph codeph">##</code> <code class="ph codeph">Space</code></td></tr><tr class="row"><td class="entry" headers="topic-1274--en__generated-table-id-1__entry__1 topic-1274--en__generated-table-id-1__entry__2 " rowspan="1" colspan="1">Heading 3</td><td class="entry" headers="topic-1274--en__generated-table-id-1__entry__1 topic-1274--en__generated-table-id-1__entry__2 " rowspan="1" colspan="1"><code class="ph codeph">###</code> <code class="ph codeph">Space</code></td></tr><tr class="row"><td class="entry" headers="topic-1274--en__generated-table-id-1__entry__1 topic-1274--en__generated-table-id-1__entry__2 " rowspan="1" colspan="1">Heading 4</td><td class="entry" headers="topic-1274--en__generated-table-id-1__entry__1 topic-1274--en__generated-table-id-1__entry__2 " rowspan="1" colspan="1"><code class="ph codeph">####</code> <code class="ph codeph">Space</code></td></tr><tr class="row"><td class="entry" headers="topic-1274--en__generated-table-id-1__entry__1 topic-1274--en__generated-table-id-1__entry__2 " rowspan="1" colspan="1">Heading 5</td><td class="entry" headers="topic-1274--en__generated-table-id-1__entry__1 topic-1274--en__generated-table-id-1__entry__2 " rowspan="1" colspan="1"><code class="ph codeph">#####</code> <code class="ph codeph">Space</code></td></tr><tr class="row"><td class="entry" headers="topic-1274--en__generated-table-id-1__entry__1 topic-1274--en__generated-table-id-1__entry__2 " rowspan="1" colspan="1">Heading 6</td><td class="entry" headers="topic-1274--en__generated-table-id-1__entry__1 topic-1274--en__generated-table-id-1__entry__2 " rowspan="1" colspan="1"><code class="ph codeph">######</code> <code class="ph codeph">Space</code></td></tr><tr class="row"><td class="entry" headers="topic-1274--en__generated-table-id-1__entry__1 topic-1274--en__generated-table-id-1__entry__2 " rowspan="1" colspan="1">Numbered list</td><td class="entry" headers="topic-1274--en__generated-table-id-1__entry__1 topic-1274--en__generated-table-id-1__entry__2 " rowspan="1" colspan="1"><ol class="ol"><li class="li"><p class="p"><code class="ph codeph">Space</code></p></li></ol></td></tr><tr class="row"><td class="entry" headers="topic-1274--en__generated-table-id-1__entry__1 topic-1274--en__generated-table-id-1__entry__2 " rowspan="1" colspan="1">Bulleted list</td><td class="entry" headers="topic-1274--en__generated-table-id-1__entry__1 topic-1274--en__generated-table-id-1__entry__2 " rowspan="1" colspan="1"><code class="ph codeph">*</code> <code class="ph codeph">Space</code></td></tr><tr class="row"><td class="entry" headers="topic-1274--en__generated-table-id-1__entry__1 topic-1274--en__generated-table-id-1__entry__2 " rowspan="1" colspan="1">Quote</td><td class="entry" headers="topic-1274--en__generated-table-id-1__entry__1 topic-1274--en__generated-table-id-1__entry__2 " rowspan="1" colspan="1"><code class="ph codeph">&gt;</code> <code class="ph codeph">Space</code></td></tr><tr class="row"><td class="entry" headers="topic-1274--en__generated-table-id-1__entry__1 topic-1274--en__generated-table-id-1__entry__2 " rowspan="1" colspan="1">Code snippet</td><td class="entry" headers="topic-1274--en__generated-table-id-1__entry__1 topic-1274--en__generated-table-id-1__entry__2 " rowspan="1" colspan="1"><code class="ph codeph">```</code> <code class="ph codeph">Space</code></td></tr><tr class="row"><td class="entry" headers="topic-1274--en__generated-table-id-1__entry__1 topic-1274--en__generated-table-id-1__entry__2 " rowspan="1" colspan="1">Divider</td><td class="entry" headers="topic-1274--en__generated-table-id-1__entry__1 topic-1274--en__generated-table-id-1__entry__2 " rowspan="1" colspan="1"><code class="ph codeph">---</code> <code class="ph codeph">Space</code></td></tr><tr class="row"><td class="entry" headers="topic-1274--en__generated-table-id-1__entry__1 topic-1274--en__generated-table-id-1__entry__2 " rowspan="1" colspan="1">Link</td><td class="entry" headers="topic-1274--en__generated-table-id-1__entry__1 topic-1274--en__generated-table-id-1__entry__2 " rowspan="1" colspan="1"><p class="p"><code class="ph codeph">[LinkTitle](<a class="xref j-external-link" href="http://a.com/" target="_blank">http://a.com</a>)</code></p></td></tr><tr class="row"><td class="entry" headers="topic-1274--en__generated-table-id-1__entry__1 topic-1274--en__generated-table-id-1__entry__2 " rowspan="1" colspan="1">Action item</td><td class="entry" headers="topic-1274--en__generated-table-id-1__entry__1 topic-1274--en__generated-table-id-1__entry__2 " rowspan="1" colspan="1"><code class="ph codeph">[]</code> <code class="ph codeph">Space</code></td></tr><tr class="row"><td class="entry" headers="topic-1274--en__generated-table-id-1__entry__1 topic-1274--en__generated-table-id-1__entry__2 " rowspan="1" colspan="1">Decision</td><td class="entry" headers="topic-1274--en__generated-table-id-1__entry__1 topic-1274--en__generated-table-id-1__entry__2 " rowspan="1" colspan="1"><code class="ph codeph">&lt;&gt;</code> <code class="ph codeph">Space</code></td></tr></tbody></table>
