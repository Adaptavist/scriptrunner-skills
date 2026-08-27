# Compatibility of Atlassian's New Transition Experience with Jira Expressions

- Platform: cloud
- Space: SR4JC
- Hierarchy: release-notes > breaking-changes
- Doc ID: doc-sr4jc-345964672
- Source: https://docs.adaptavist.com/sr4jc/latest/release-notes/breaking-changes/compatibility-of-atlassian-s-new-transition-experience-with-jira-expressions

Since **April 2025**, Atlassian has permanently rolled out the [new transition experience](https://community.atlassian.com/forums/Jira-articles/Now-GA-try-the-new-issue-transition-experience-in-Jira/ba-p/2734436) in Jira. As a consequence, the way your Jira expressions ([conditions](https://docs.adaptavist.com/sr4jc/latest/features/workflow-rules/restrict-transitions) and [validators](https://docs.adaptavist.com/sr4jc/latest/features/workflow-rules/validate-details)) work will change.

When working with Jira Cloud, it's important to understand that there are two types of rich text fields:

-   **Pre-defined Atlassian fields**: These are built-in fields like `description` and `environment`. They are `RichText` type and have a built-in `plainText` property for easy access to their text content.
-   **Custom fields**: These are fields created by customers. They are stored as simple `Map` objects and require additional processing to access their text content.

Understanding this distinction is crucial for correctly handling rich text content in your Jira scripts and expressions. You can refer to [Atlassian's documentation](https://developer.atlassian.com/cloud/jira/platform/jira-expressions-type-reference/#jira-expressions-types) for more details on Jira expression types.

## Atlassian pre-defined fields (RichText type)

These fields, such as `description` and `environment`, are of `RichText` type and have a built-in `plainText` property. 

For pre-defined fields, always use .`plainText` directly.

Complex operations like checking for specific formatting or extracting links may require more advanced ADF parsing techniques. Remember you should always test your Jira expressions in your Jira environment to make sure they function as expected.

### Access plain text content

Before Atlassian's new transition experience:

```
issue.description != ""
issue.environment != ""
```

After Atlassian's new transition experience:

```
issue.description.plainText != ""
issue.environment.plainText != ""
```

### Check for specific content

Before Atlassian's new transition experience:

```
issue.description.toLowerCase().contains("urgent")
issue.environment.toLowerCase().contains("production")
```

After Atlassian's new transition experience:

```
issue.description.plainText.toLowerCase().includes("urgent")
issue.environment.plainText.toLowerCase().includes("production")
```

### Count words

Before Atlassian's new transition experience:

```
issue.description.split(/\s+/).length > 50
issue.environment.split(/\s+/).length > 20
```

After Atlassian's new transition experience:

```
issue.description.plainText.split(/\s+/).length > 50
issue.environment.plainText.split(/\s+/).length > 20
```

### Check for empty fields

Before Atlassian's new transition experience:

```
issue.description == ""
issue.environment == ""
```

After Atlassian's new transition experience:

```
issue.description.plainText == ""
issue.environment.plainText == ""
```

### Concatenate multiple rich text fields

Before Atlassian's new transition experience:

```
issue.description + " " + issue.environment
```

After Atlassian's new transition experience:

```
issue.description.plainText + " " + issue.environment.plainText
```

## Custom fields (Map type)

For custom fields, always use the `plainTextValue`() function to extract the text content.  Custom fields require a helper function to extract plain text content, as shown below:

```
/ function declaration
let plainTextValue = value =>
    typeof value == 'Map' ?
     new RichText(value).plainText :
      value ;
// the actual jira expression that returns a true or false
plainTextValue(issue.customfield_10076) == "text"
```

  

Complex operations like checking for specific formatting or extracting links may require more advanced ADF parsing techniques. Remember you should always test your Jira expressions in your Jira environment to make sure they function as expected.

### Access plain text content

Before Atlassian's new transition experience:

```
issue.customfield_10234 != ""
```

After Atlassian's new transition experience:

```
plainTextValue(issue.customfield_10234) != ""
```

### Check for specific content

Before Atlassian's new transition experience:

```
issue.customfield_10234.toLowerCase().contains("urgent")
```

After Atlassian's new transition experience:

```
plainTextValue(issue.customfield_10234).toLowerCase().includes("urgent")
```

### Count words

Before Atlassian's new transition experience:

```
issue.customfield_10234.split(/\s+/).length > 50
```

After Atlassian's new transition experience:

```
plainTextValue(issue.customfield_10234).split(/\s+/).length > 50
```

### Check for empty fields

Before Atlassian's new transition experience:

```
issue.customfield_10234 == ""
```

After Atlassian's new transition experience:

```
plainTextValue(issue.customfield_10234) == ""
```

### Concatenate custom fields with pre-defined fields

Before Atlassian's new transition experience:

```
issue.description + " " + issue.customfield_10234
```

After Atlassian's new transition experience:

```
issue.description.plainText + " " + plainTextValue(issue.customfield_10234)
```
