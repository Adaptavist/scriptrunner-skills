# Web Panel Breaking Change Deprecation for Confluence 9

- Platform: confluence-data-center
- Space: SR4C
- Hierarchy: Release Notes > Breaking changes
- Doc ID: doc-sr4c-6f32b171-92dd-4eab-8801-64d28c438059-1970f1316de02c8b
- Source: https://docs.adaptavist.com/sr4c/latest/release-notes/breaking-changes#web-panel-breaking-change-deprecation-for-confluence-9--en

The way you can add a `provider class/script` for [web panels](https://docs.adaptavist.com/sr4c/latest/features/fragments/web-panel) is different after [upgrading to Confluence 9.0](https://docs.adaptavist.com/sr4c/latest/get-started/update/compatibility-with-confluence#confluence-9--en).

Tip: Most simple scripts, like `writer.write("some HTML")`, will continue to work correctly.

This breaking change only impacts users who used class implementations of the Atlassian WebPanel interface for the `Provider class/script`

We recommend you fix/update the Show a web panel `provider class/scripts`, as described below.

## Fix/Update the Show a web panel provider class/scripts

The following is an example of an outdated `provider class/script`:

```
import com.atlassian.plugin.web.model.WebPanel
 
class MyWebPanel implements WebPanel {
    @Override
    String getHtml(Map<String, Object> context) {
        ""
    }
    
    @Override
    void writeHtml(Writer writer, Map<String, Object> context) throws IOException {
        writer.write("<div>Hello World!</div>")
    }
}
```

In this script the `writeHtml` method will be ignored with Confluence 9.0 and the import has been deprecated. You can update these as follows:

-   Update the `getHtml/writeHtml` methods:
    -   Problem: The `writeHtml` method will be ignored, so any content generated using this method alone will not be rendered.
    -   Solution: From now on, only use the `getHtml` method to return the HTML content that you want the panel to render.
-   Update the WebPanel interface:
    -   Problem: If you're using Atlassian's `com.atlassian.plugin.web.api.model.WebPanel` interface, this has now been deprecated. Using the deprecated interface will still compile until Atlassian fully removes it in a later release. However, we recommend you update to the new interface now if you were using it in your script to avoid this breaking in the future.
    -   Solution: Replace the \``com.atlassian.plugin.web.model.WebPanel`\` Import with \``` com.atlassian.plugin.web.api.model.WebPanel` `` instead.

The fixed/updated script would look something like this:

```
import com.atlassian.plugin.web.api.model.WebPanel
 
class MyWebPanel implements WebPanel {
    @Override
    String getHtml(Map<String, Object> context) {
        "<div>Hello World!</div>"
    }
    
    @Override
    void writeHtml(Writer writer, Map<String, Object> context) throws IOException {
        // not used
    }
}
```
