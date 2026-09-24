# Include All Child Pages

- Platform: confluence-data-center
- Space: SR4C
- Hierarchy: Features > Macros > Create Custom Macro > Reuse Existing Macros
- Doc ID: doc-sr4c-7255ed2d-27f3-4f72-bb58-90209a6d5792-3ac4090f6e105f35
- Source: https://docs.adaptavist.com/sr4c/latest/features#macros--en#create-custom-macro--en#reuse-existing-macros--en#include-all-child-pages--en

You can include the content of all child pages using the _Including All Child Pages_ macro.

It is an excellent example of a common technique in macros, which is to write the XML for one or more other macros, and then pass the resulting XML through the rendering engine which converts storage XML to view format.

The following image is an example of an _Including All Child Pages_ macro:

```
import com.atlassian.confluence.pages.Page
import com.atlassian.confluence.xhtml.api.MacroDefinition
import com.atlassian.confluence.xhtml.api.XhtmlContent
import com.atlassian.renderer.v2.RenderUtils
import com.atlassian.sal.api.component.ComponentLocator
import groovy.xml.MarkupBuilder

def xhtmlContent = ComponentLocator.getComponent(XhtmlContent)
def writer = new StringWriter()
def builder = new MarkupBuilder(writer)
def entity = context.getEntity()

if (entity instanceof Page) {
    builder.div('class': "child-page") {
        def content = (entity as Page).children.collect { child ->
            def macroContent = xhtmlContent.convertMacroDefinitionToStorage(MacroDefinition.builder()
                .withName("include")
                .withMacroBody(null)
                .withParameters([
                    "0": "${context.spaceKey}:${child.title}".toString()
                ]).build(), context) // <1>
            h2(child.title) // <2>
            mkp.yield(xhtmlContent.convertStorageToView(macroContent, context)) // <3>
        }
    }

    return xhtmlContent.convertStorageToView(writer.toString(), context)
} else {
    RenderUtils.blockError("Error", "Should only be used on pages, not comments, blog posts, etc")
}
```

Line 21: This line creates the storage format XML for the Include Page macro.

Line 22: This line creates a heading with the child page's title.

Line 23: The line renders the content of the Page macro from its storage format XML.

To create one, take the immediately descending child pages and write the [Include Page](https://confluence.atlassian.com/doc/include-page-macro-139514.html) macro XML. You can pick and choose sub-pages, like selecting just pages with labels.

Tip: To make this include children recursively, use `descendants` instead of `children`.

The following image is an example of another configuration form:
