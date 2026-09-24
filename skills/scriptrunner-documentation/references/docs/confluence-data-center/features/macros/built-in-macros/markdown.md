# Markdown

- Platform: confluence-data-center
- Space: SR4C
- Hierarchy: Features > Macros > Built-In Macros
- Doc ID: doc-sr4c-3a0ee7ec-f123-4da7-b89e-16c63eca2a39-b3c650cc13785ff7
- Source: https://docs.adaptavist.com/sr4c/latest/features#macros--en#built-in-macros--en#markdown--en

The _Markdown_ macro enables you to use Markdown to format Confluence pages according to your needs.

You can use this macro to insert your own [Markdown](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet) inline tags or to render them from a URL.

## Walkthrough

Watch our video to see the Markdown macro in action.

[Media](https://player.vimeo.com/video/680469852?h=dffe71c15d)

## Use the Markdown Macro

Usually, you would want to include Markdown from a [Gist](https://gist.githubusercontent.com/evanmoran/2041020/raw/2b565d7c92cfebe10ce769c76223359d1c3c2f85/markdown.md) or a repository in [GitHub](https://raw.githubusercontent.com/atlassian/commonmark-java/master/README.md) or [Bitbucket](https://bitbucket.org/atlassian/atlassian-spring-scanner/raw/master/README.md). In GitHub and Bitbucket, use the raw content URL, which links to the original Markdown file.

| Github | Bitbucket |
| --- | --- |
|  |  |

If you want to display Markdown from another Atlassian product (such as Bitbucket Server), the macro automatically detects if you have an application link set up for the URL you entered and uses it to retrieve the content.

You may also place Markdown directly into the body of the _Markdown_ macro:

If you place Markdown in the body of the macro and you provide a URL, the Markdown in the body of the macro will be ignored.

Note: URL for Attachments

The Markdown macro does not support preview URL links. To get a full link for an attachment, go to the _Attachments_ page, right-click on an attachment, then click Copy Link Address.

The _Markdown_ macro only supports the [CommonMark](http://commonmark.org/) specification of Markdown, which means that different versions of the Markdown specification may not render correctly.

For information about using external links in the _Markdown_ macro, see the _Adding URLs to the Allowlist_ section.

## Adding URLs to the Allowlist

Using external URLs in a _Markdown_ macro requires adding them to the [allowlist](https://confluence.atlassian.com/doc/configuring-the-allowlist-381255821.html) for outgoing requests.

Warning: If the Confluence allowlist is disabled, you cannot use URLs with the _Markdown_ macro at all, but inline Markdown still works. This is necessary in order to prevent [Server Side Request Forgery](https://www.owasp.org/index.php/Server_Side_Request_Forgery) (SSRF) vulnerabilities.

[Linked Atlassian applications](https://confluence.atlassian.com/doc/linking-to-another-application-360677690.html) are allowlisted by default, but you'll likely want to allowlist common Markdown sources such as these:

-   [https://bitbucket.org](https://bitbucket.org/)
-   [https://raw.github.com](https://raw.github.com/)
-   [https://raw.githubusercontent.com](https://raw.githubusercontent.com/)

You may want to be more restrictive and, for example, only allow data from your company's Bitbucket project. For that, you could use a wildcard expression rule like `https://bitbucket.org/MyCompany/*`.

Confluence's allowlist tester may still display a red mark for the incoming URLs depending on your company's firewall settings. The _Markdown_ macro does not require incoming allowlisting, so this should not become a problem.

The following image is an example of the red mark that could display on an incoming link based on firewall settings:

## Files, FTP, and other data

You may have Markdown files in places that can't be accessed over HTTP that you still want to render in Confluence. For example, you may have a network file share on your Confluence server where permitted users add Markdown documents.

Tip: In the past, ScriptRunner for Confluence automatically allowed specifying file & FTP URLs for the _Markdown_ macro. To support the added security of the URL allowlist, this feature is no longer automatic. Fortunately, you can still use a [Scripted REST Endpoint](https://docs.adaptavist.com/sr4c/latest/features/rest-endpoints) to use those documents.

### Files

To use a file in the allowlist URL, create a REST endpoint with code similar to the following example, with appropriate changes for your environment.

Use the following features (match the number of the list item to the number in the above image) to read the Markdown files from a directory in your Confluence server's home directory:

```
import com.onresolve.scriptrunner.runner.ScriptRunnerImpl
import com.onresolve.scriptrunner.runner.diag.ClusterHomeLocatorService
import com.onresolve.scriptrunner.runner.rest.common.CustomEndpointDelegate
import groovy.transform.BaseScript

import javax.ws.rs.core.MediaType
import javax.ws.rs.core.MultivaluedMap
import javax.ws.rs.core.Response

@BaseScript CustomEndpointDelegate delegate

getMarkdownFile( // <1>
    httpMethod: "GET", // <2>
    groups: ["confluence-users"] // <3>
) { MultivaluedMap queryParams ->
    def fileName = queryParams.getFirst("filename") as String // <4>

    if (!fileName) {
        return Response.status(Response.Status.BAD_REQUEST)
            .type(MediaType.TEXT_PLAIN_TYPE)
            .entity("Must specify a markdown file.").build()
    }

    def homeDirectory = ScriptRunnerImpl.getOsgiService(ClusterHomeLocatorService).sharedHomeDir
    def markdownFiles = new File(homeDirectory, "markdown-files/") // <5>
    def file = new File(markdownFiles, fileName) // <6>

    boolean pathIsCanonical = file.path == file.canonicalPath // <7>
    boolean fileIsMarkdown = [".md", ".markdown", ".mdx"].any { extension -> fileName.endsWith(extension) }

    if (!pathIsCanonical || !fileIsMarkdown || !file.exists()) {
        return Response.status(Response.Status.BAD_REQUEST)
            .type(MediaType.TEXT_PLAIN_TYPE)
            .entity("You may only specify markdown files in the appropriate directory.").build()
    }

    String fileContents = file.getText()
    Response.status(Response.Status.ACCEPTED)
        .type(MediaType.TEXT_PLAIN_TYPE)
        .entity(fileContents).build()
}
```

Line 12: This is the name of the REST endpoint; the name forms part of the URL. In this example, the name is `getMarkdownFile`.

Line 13: This is the httpMethod, which must be _GET_ for the endpoint to work with the Markdown macro.

Line 14: This line should be used to restrict use of the REST endpoint to specific groups of authenticated users. Don't allow access unless it is needed.

Line 16: This line retrieves the filename from the URL's query parameters.

Line 25: On this line, we assume that the directory where the Markdown files lie is inside your [Confluence home directory](https://confluence.atlassian.com/doc/confluence-home-and-other-important-directories-590259707.html) . If it is somewhere else on the server, you can specify a path as a string (e.g. `new File("/opt/path/to/markdown-files/"`).

Line 26: This variable points to the individual Markdown file.

Line 28: These are basic checks against directory traversal attacks. This checks the path against the canonical path.

Warning: Be extremely careful that your endpoint doesn't allow users to read arbitrary files from the Confluence server.

Once you have configured the REST endpoint for your environment, your users can configure the _Markdown_ macro to point to a URL like `https://confluence.mycompany.com/rest/scriptrunner/latest/custom/getmarkdownFile?filename=somefile.md`. Replace _confluence.mycompany.com_ with your Confluence instance's base URL.

### FTP, SFTP, or FTPS

Alternatively, you may want to set up a REST endpoint that can read files from an FTP, SFTP, or FTPS server.

```
import com.onresolve.scriptrunner.runner.rest.common.CustomEndpointDelegate
import groovy.transform.BaseScript

import javax.ws.rs.core.MediaType
import javax.ws.rs.core.MultivaluedMap
import javax.ws.rs.core.Response

@BaseScript CustomEndpointDelegate delegate

markdownSftp( // <1>
    httpMethod: "GET", // <2>
    groups: ["confluence-users"] // <3>
) { MultivaluedMap queryParams ->
    def fileName = queryParams.getFirst("filename") as String // <4>

    if (!fileName) {
        return Response.status(Response.Status.BAD_REQUEST)
            .type(MediaType.TEXT_PLAIN_TYPE)
            .entity("Must specify a markdown file.").build()
    }

    def sftpRootUrl = "ftp://myftp.host.com/root/allowed" // <5>    def pathToFile = "$sftpRootUrl/$fileName" // <6>

    boolean pathIsPermissible = ['../', '$', '*'].every { !pathToFile.contains(it) } // <7>
    boolean fileIsMarkdown = [".md", ".markdown", ".mdx"].any {
        extension -> fileName.endsWith(extension) // <8>
    }

    if (!pathIsPermissible || !fileIsMarkdown) {
        return Response.status(Response.Status.BAD_REQUEST)
            .type(MediaType.TEXT_PLAIN_TYPE)
            .entity("You may only specify markdown files in the appropriate directory.").build()
    }

    def url = new URL(pathToFile) // <9>
    String fileContents
    try {
        fileContents = url.text
    } catch (Exception e) {
        return Response.status(Response.Status.BAD_REQUEST)
            .type(MediaType.TEXT_PLAIN_TYPE)
            .entity("File $fileName does not exist or is unreadable.".toString()).build()
    }
    Response.status(Response.Status.ACCEPTED)
        .type(MediaType.TEXT_PLAIN_TYPE)
        .entity(fileContents).build()
}
```

Line 10: This is the name of the REST endpoint; the name forms part of the URL. In this example, the name is `getMarkdownFile`.

Line 11: This is the httpMethod, which must be _GET_ for the endpoint to work with the Markdown macro.

Line 12: This line should be used to restrict use of the REST endpoint to specific groups of authenticated users. Don't allow access unless it is needed.

Line 14: This line retrieves the filename from the URL's query parameters.

Line 22: This FTP URL points to both the server and subdirectory that you want to access. Modify this as necessary for your specific environment.

Line 23: On this line, the root path is combined with the FTP site and the file name.

Line 25: These are basic checks against directory traversal attacks. This checks that the path doesn't contain characters which could permit users to add malicious attempts to access the FTP server or other URLs.

Line 27: This line validates the file type accessed by extension. Only Markdown files are accepted.

Line 36: Note that the URL is only created once all validation is passed. This differs from `[java.net](http://java.net/).URL` instances, which perform a DNS lookup on creation.

Once you have configured the REST endpoint for your environment, your users can configure the _Markdown_ macro to point to a URL like `https://confluence.mycompany.com/rest/scriptrunner/latest/custom/markdownSftp?filename=somefile.md`. Replace _confluence.mycompany.com_ with your Confluence instance's base URL.
