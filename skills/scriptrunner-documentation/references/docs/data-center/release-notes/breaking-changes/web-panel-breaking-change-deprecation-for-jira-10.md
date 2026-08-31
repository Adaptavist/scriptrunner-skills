# Web Panel Breaking Change/Deprecation for Jira 10

- Platform: data-center
- Space: SR4JS
- Hierarchy: release-notes > breaking-changes
- Doc ID: doc-sr4js-282689602
- Source: https://docs.adaptavist.com/sr4js/latest/release-notes/breaking-changes/web-panel-breaking-change-deprecation-for-jira-10

The way you can add a p`rovider class/script` for [web panels](https://docs.adaptavist.com/sr4js/latest/features/fragments/web-panel) is different after [upgrading to Jira 10.0](https://docs.adaptavist.com/sr4js/latest/get-started/update-scriptrunner/compatibility-with-jira). 

Most simple scripts, like `writer.write("some HTML``")`, will continue to work correctly.

This breaking change only impacts users who used **class** implementations of the Atlassian WebPanel interface for the \`Provider class/script\`  

We recommend you fix/update the **Show a web panel** `provider class/scripts`, as described below. 

## Fix/Update the **Show a web panel** `provider class/scripts`

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

In this script the `writeHtml` method will be ignored with Jira 10.0 and the import has been deprecated. You can update these as follows:

-   **Update the `getHtml/writeHtml` methods:**
    -   **Problem**: The `writeHtml` method will be ignored, so any content generated using this method alone will not be rendered.
    -   **Solution**: From now on, only use the `getHtml` method to return the HTML content that you want the panel to render.
-   **Update the WebPanel interface:**
    -   **Problem**: If you're using Atlassian's `com.atlassian.plugin.web.model.WebPanel` interface, this has now been deprecated. Using the deprecated interface will still compile until Atlassian fully removes it in a later release. However, we recommend you update to the new interface now if you were using it in your script to avoid this breaking in the future.
    -   **Solution**: Replace the \``com.atlassian.plugin.web.model.WebPanel`\` Import with \``` com.atlassian.plugin.web.api.model.WebPanel` `` instead.

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
