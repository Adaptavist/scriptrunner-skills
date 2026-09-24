# Security and Best Practices

- Platform: confluence-data-center
- Space: SR4C
- Hierarchy: Features > Macros > Create Custom Macro
- Doc ID: doc-sr4c-c393abe6-9476-4ec9-9849-8906d1290cef-c83e344798fd7fce
- Source: https://docs.adaptavist.com/sr4c/latest/features#macros--en#create-custom-macro--en#security-and-best-practices--en

Security and best-practice reccomendations for Macro usage.

## Build Your HTML

When you generate HTML, use [MarkupBuilder](http://groovy-lang.org/processing-xml.html#_markupbuilder) for security purposes. MarkupBuilder encodes any malicious tags an editor might try to insert. Additionally, the tool ensures that the output of HTML is well-formed. For example, it checks for open tags, which would break the formatting of your page.

MarkupBuilder should be used instead of returning HTML strings whenever possible.

## Sanitize Your HTML

If you need to create custom HTML from strings, parse the input HTML and filter it through a list of safe tags and attributes. This can be done using the [Jsoup](https://jsoup.org/apidocs/org/jsoup/Jsoup.html) `clean()` method.

```
import org.jsoup.Jsoup
import org.jsoup.safety.Safelist

def potentiallyUnsafeHtml = "<p>${parameters.userInput}</p>" //a malicious user could put HTML in the userInput parameter
def cleanHtml = Jsoup.clean(potentiallyUnsafeHtml, Safelist.simpleText()) //This will clean out any potentially malicious HTML, while still allowing basic formatting tags
cleanHtml
```

Note: See the [Jsoup Whitelist API](https://jsoup.org/apidocs/org/jsoup/safety/Whitelist.html) documentation for more details on different whitelisting options.
