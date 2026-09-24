# HAPI Script Format Help

- Platform: confluence-data-center
- Space: SR4C
- Hierarchy: Get Help
- Doc ID: doc-sr4c-7d80ab82-d664-4522-bdd3-f2f501d2b519-29677c0d3b35bf12
- Source: https://docs.adaptavist.com/sr4c/latest/get-help#hapi-script-format-help--en

There are a few [Groovy](https://groovy-lang.org/index.html) elements that are crucial in [HAPI](../uncategorized/h/hapi.md) scripting. Review this guide for a few quick reminders.

## Closures { }

A [closure](https://groovy-lang.org/closures.html) in Groovy is an open, anonymous, block of code that can take arguments, return a value, and be assigned to a variable.

Here is an example in HAPI scripts:

```
Pages.create("DS", "2023 Page 1") {
    setParentPage("2023 Pages")
}
```

The `create` method on the Pages API allows you to create a new page by specifying the `spaceKey` and pageTitle. The closure, which is the last parameter you provide, acts as a "specification" for additional properties to supply to the page, such as setting the parent page.

### Arrow ->

The arrow operator is optional and can be used to explicitly define separate parameters in a closure by adding an arrow (->). The 'it' parameter is defined by default for a closure.

Here is an some examples in HAPI scripts:

```
Pages.search("space = DS and title = '2023 Page 2'").each { page ->
    page.addLabels("new")
}
```

Here, the arrow (->) defines a page parameter for the closure. The label will be added to each page found by the script.

## Other scripting elements

For more information about Groovy operators or defining variables in Groovy, visit the [Groovy website](https://groovy-lang.org/index.html).
