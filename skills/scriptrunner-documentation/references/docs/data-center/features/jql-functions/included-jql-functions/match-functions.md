# Match Functions

- Platform: data-center
- Space: SR4JS
- Hierarchy: Features > JQL Functions > Included JQL Functions
- Doc ID: doc-sr4js-bb1a763b-856d-43ab-9689-cffc0431700f-c22eba94fc850a85
- Source: https://docs.adaptavist.com/sr4js/latest/features#jql-functions--en#included-jql-functions--en#match-functions--en

This page provides information on functions used to find issues using text and regular expressions:

-   [Find issues using a regular expression to match specific fields (issueFieldMatch)](https://docs.adaptavist.com/sr4js/latest/features#find-issues-using-a-regular-expression-to-match-specific-fields-issuefieldmatch--en)
-   [Find issues where a specific field exactly matches given text (issueFieldExactMatch)](https://docs.adaptavist.com/sr4js/latest/features#find-issues-where-a-specific-field-exactly-matches-given-text-issuefieldexactmatch--en)
-   [Find issues using a regular expression to match specific projects (projectMatch)](https://docs.adaptavist.com/sr4js/latest/features#find-issues-using-a-regular-expression-to-match-specific-projects-projectmatch--en)
-   [Find issues using a regular expression to match specific components (componentMatch)](https://docs.adaptavist.com/sr4js/latest/features#find-issues-using-a-regular-expression-to-match-specific-components-componentmatch--en)
-   [Find issues using a regular expression to match specific versions (versionMatch)](https://docs.adaptavist.com/sr4js/latest/features#find-issues-using-a-regular-expression-to-match-specific-versions-versionmatch--en)

Note: What are regular expressions?

A regular expression (regexp) is a sequence of characters that specifies a pattern. For a tutorial on how to write a regular expression, see [Oracle's Regular Expressions tutorial.](https://docs.oracle.com/javase/tutorial/essential/regex/)

We recommend you [test your regular expression](https://regex101.com/) before running your query.

## Find issues using a regular expression to match specific fields (`issueFieldMatch`)

Use `issueFieldMatch()` to find issues using a regular expression to match specific fields:

Tip: Performance

Performance is directly proportional to the number of issues selected by the subquery. For optimal results, use the most specific subquery possible, such as limiting to relevant projects. This approach minimizes the issue set to be processed. On a typical development machine, this function can process approximately 20,000 issues per second.

```
issueFieldMatch ("subquery", "fieldname", "regexp")
```

### issueFieldMatch example

We want to find all issues where the description contains ABC0000 where 0000 is any number, you could use:

```
issueFunction in issueFieldMatch("project = JRA", "description", "ABC\d{4}")
```

Tip: For a case-insensitive match, prefix the match string with `(?i)`. For example: 

```
issueFunction in issueFieldMatch("project = JRA", "description", "(?i)ABC\d{4}")
```

Warning: Exact matches

The function searches for the regular expression anywhere within the field. If you want the regular expression to match the entire content of the field (rather than just finding the pattern anywhere within it) use [boundary matchers](https://docs.oracle.com/javase/tutorial/essential/regex/bounds.html) such as `^` and `$`. For example `^ABC\d{4}$.`

## Find issues where a specific field exactly matches given text (issueFieldExactMatch)

Use `issueFieldExactMatch()` to find issues where a specific field exactly matches given text:

```
issueFieldExactMatch("subquery", "fieldname", "text")
```

### issueFieldExactMatch example

We want to find all issues in the _JRA_ project with the error code _ERR-404_ in the _Error Code_ custom text field:

```
issueFunction in issueFieldExactMatch("project = JRA", "Error Code", "ERR-404")
```

## Find issues using a regular expression to match specific projects (projectMatch)

Use `projectMatch()` to find issues using a regular expression to match the project name:

```
project in projectMatch("regexp")
```

### projectMatch example

We want to find all issues in projects that begin with _Test_:

```
project in projectMatch("^Test.*")
```

## Find issues using a regular expression to match specific components (componentMatch)

Use `componentMatch()` to find issues using a regular expression to match the component name:

```
component in componentMatch("regexp")
```

### componentMatch example

We want to find all issues that have a component beginning with _Web_:

```
component in componentMatch("^Web.*")
```

## Find issues using a regular expression to match specific versions (versionMatch)

Use `versionMatch()` to find issues using a regular expression to match the version name:

```
fixVersion in versionMatch("regexp")
```

### versionMatch example

We want to find all issues in the _JRA_ project that have a fix version beginning with _RC_:

```
project = JRA and fixVersion in versionMatch("^RC.*")
```

## Related content

-   [JQL Functions](https://docs.adaptavist.com/sr4js/latest/features/jql-functions)
-   [Included JQL Functions](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions)
-   [JQL Functions Tutorial](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/jql-functions-tutorial)
