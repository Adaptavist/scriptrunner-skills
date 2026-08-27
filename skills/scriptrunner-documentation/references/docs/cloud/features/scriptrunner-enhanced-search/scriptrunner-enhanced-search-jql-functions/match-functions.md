# Match Functions

- Platform: cloud
- Space: SR4JC
- Hierarchy: features > scriptrunner-enhanced-search > scriptrunner-enhanced-search-jql-functions
- Doc ID: doc-sr4jc-313196623
- Source: https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-functions/match-functions

These ScriptRunner Enhanced Search JQL functions allow you to perform granular searches based on specific criteria. This is especially beneficial if you need to filter issues by versions, components, or custom field values.

## componentMatch

The `componentMatch` function allows you to find issues based on components whose names match a specified text pattern. This functionality is helpful for:

-   Segmenting issues by specific component categories
    
-   Enhancing the organisation of issues within larger projects, where components may be numerous and varied
    
-   Grouping issues according to component characteristics defined by text patterns
    

### Syntax **and parameters:**

```
componentMatch(Pattern Match)
```

-   **Pattern match:** A specific text pattern to be matched by component names.
    
-   **Syntax**: Our example below uses regex syntax. You can refer to this [website](https://regexr.com/) which is a regular expressions builder that can help you build an expression and provides definitions for each of the characters. 
-   **Project keys (optional):** A comma-separated list of project keys to narrow down the search. Specifying project keys improves query performance by limiting the search scope.
    

### **Example**

1.  **Finding issues with components starting with 'Web':**
    
    For teams looking to manage or review all tasks related to web components:
    
    ```
component in componentMatch("^Web.*")
```
    
    This query is particularly useful for teams responsible for web development or web-based services, enabling them to easily gather all relevant issues.
    
2.  **Restricting the search to find specific projects:**
    
    To enhance performance and focus on specific projects:
    
    ```
component in componentMatch("^Web.*", "DEMO, EXAMPLE, TEST")
```
    
      
    

-   **Use precise pattern match:** To ensure that your queries return the most relevant results, specifically match the naming conventions used for components within your projects.
    
-   **Regular updates and reviews:** As projects evolve and new components are added, regularly update and review your component-based queries to ensure they continue to meet your project management needs.
    
-   **Combine with other queries:** Use `componentMatch` in conjunction with other JQL functions for more comprehensive issue searches. For example, combining component matching with `issueType` or `status` filters can refine your issue management process further.
    

## issueFieldExactMatch

The `issueFieldExactMatch` function provides an exact text match within the specified fields of issues selected by a subquery. This is particularly useful for:

-   Ensuring precise data retrieval when the exact text is known and variations or partial matches are not acceptable.
    
-   Enabling strict compliance checks, where exact wording or data entry must be verified against predefined standards.
    
-   Streamlining searches that require absolute accuracy, such as matching exact error messages, specific labels, or unique identifiers.
    

### **Syntax and parameters:**

```
issueFieldExactMatch(Subquery, FieldName, Pattern Match)
```

-   **Subquery:** A JQL query that narrows down the set of issues to be searched. It's important to limit this to a manageable subset to optimize performance.
    
-   **Field name:** The name of the field in which to search for an exact match. This can be any standard or custom field within Jira.
    
-   **Pattern match:** The text pattern that must be matched exactly within the specified field.
    
-   **Syntax**: Our example below uses regex syntax. You can refer to this [website](https://regexr.com/) which is a regular expressions builder that can help you build an expression and provides definitions for each of the characters. 

### **Examples**

1.  **Finding issues with exactly matched error codes:**
    
    To locate issues where a custom field exactly matches a specific error code:
    
    ```
issueFunction in issueFieldExactMatch("project = ERRORS", "customfield_10022", "^ERROR-0123$")
```
    
    This query ensures that only issues with the custom field `customfield_10022` containing precisely "ERROR-0123" are retrieved, crucial for tracking specific errors or issues.
    
2.  **Ensuring compliance with documentation standards:**
    
    For verifying that certain documentation standards are exactly met within issue descriptions:
    
    ```
issueFunction in issueFieldExactMatch("project = DOCS", "description", "^Documented as per standard$")
```
    
    This can be used in scenarios where precise language use is critical, such as legal clauses or regulatory compliance statements in issue tracking.
    
    -   **Precise Pattern Match:** Ensure they are designed to match the entire field content from start to end using anchors (`^` and `$`) to avoid partial matches.
        
    -   **Optimise Performance Through Subquery:** Since performance is dependent on the number of issues processed, refine your subquery to be as specific as possible, reducing the workload on the system.
        
    -   **Regular Audits and Checks:** Utilise this function for regular audits and checks to ensure ongoing compliance with operational or regulatory standards.
        
    

## issueFieldMatch

The `issueFieldMatch` function allows you to search any issue field by specifying a search pattern. This pattern helps you find text that follows a particular format within issue fields.

This is helpful for:

-   Extracting specific patterns or data from various issue fields, such as descriptions, comments, or custom fields.
    
-   Allowing for precise matching criteria, particularly useful in large datasets where standard searches might fall short.
    
-   Filtering issues based on nuanced textual content or specific formatting.
    

### How to use the issueFieldMatch JQL function demo video

&amp;amp;amp;lt;p&amp;amp;amp;gt;&amp;amp;amp;lt;br/&amp;amp;amp;gt;&amp;amp;amp;lt;/p&amp;amp;amp;gt;

### **Syntax and parameters:**

```
issueFieldMatch(Subquery, FieldName, Pattern Match)
```

-   **Subquery:** A JQL query that defines the set of issues to search within. It is essential to make this as specific as possible to optimize performance.
    
-   **Field name:** The name of the field to search within. This can be a standard field like `description` or `summary`, or a custom field identified by its name.
    
-   **Pattern match:** The pattern of text to match against the field content.
    
-   **Syntax**: Our example below uses regex syntax. You can refer to this [website](https://regexr.com/) which is a regular expressions builder that can help you build an expression and provides definitions for each of the characters.

### Examples

1.  **Finding issues with a specific pattern in descriptions:**
    
    To identify issues where the description contains a specific alphanumeric code pattern (e.g., ABC followed by any four digits):
    
    ```
issueFunction in issueFieldMatch("project = DEMO", "description", "ABC\\d{4}")
```
    
    This query is particularly useful for tracking issues related to specific features or errors that are tagged systematically within descriptions.
    
2.  **Matching entire field content:**
    
    For cases where the entire field content must match a pattern (not just contain it):
    
    ```
issueFunction in issueFieldMatch("project = DEMO", "customfield_1234", "^ABC\\d{4}$")
```
    
    This ensures that the custom field `customfield_1234` contains nothing other than the specified pattern, useful for strict data integrity checks.
    

-   **Optimise the subquery:** Ensure the subquery filters down the issues to the smallest possible set to enhance performance and reduce processing time.
    
-   **Use for custom data extraction:** Leverage this function to extract custom data patterns from fields for reports or analytics, especially when such data is not easily accessible through standard JQL.
    

## projectMatch

The `projectMatch` function allows you to find issues based on projects whose keys match a specified text pattern. This function is particularly helpful for:

-   Managing large-scale Jira instances with numerous projects, allowing for quick segmentation and access to relevant projects.
    
-   Facilitating cross-project reporting and analytics by dynamically grouping projects according to naming conventions or identifiers.
    
-   In environments where projects are consistently named according to specific patterns or standards.
    

### **Syntax and parameters:**

```
projectMatch(Pattern Match)
```

-   **Pattern match:** A text pattern for matching project keys.
    
-   **Syntax**: Our example below uses regex syntax. You can refer to this [website](https://regexr.com/) which is a regular expressions builder that can help you build an expression and provides definitions for each of the characters.

### **Example**

**Identifying all projects with a common prefix:**

To find all projects that start with a common prefix, such as "`DEV`" for development projects:

```
project in projectMatch("^DEV.*")
```

This query is invaluable for quickly accessing all development-related projects, particularly in organizations where projects are systematically named.

-   **Careful construction of the pattern match:** Ensure that the Pattern Match used is precise to avoid including unintended projects in your results.
    
-   **Regular review of naming conventions:** Maintain and review project naming conventions regularly to ensure that they continue to support effective use of the `projectMatch` function.
    
-   **Combine with other JQL functions:** To further refine your queries, combine `projectMatch` with other JQL functions and filters, such as `status`, `issueType`, or `component`, to create comprehensive views of project data.
    

## versionMatch

The `versionMatch` function allows you to search for issues where version fields contain specific text patterns you define.

This function is highly beneficial for:

-   Streamlining the management of releases by enabling teams to quickly identify all issues associated with specific versions or version patterns.
    
-   Enhancing the accuracy of queries about version-related tasks, particularly useful in large projects where numerous versions are released over time.
    
-   Facilitating targeted actions or reports related to certain release cycles, especially when preparing for a version rollout or audit.
    

### How to use the versionMatch JQL function demo video

&amp;amp;amp;lt;p&amp;amp;amp;gt;&amp;amp;amp;lt;br/&amp;amp;amp;gt;&amp;amp;amp;lt;/p&amp;amp;amp;gt;

### **Syntax and parameters:**

```
versionMatch(Pattern Match, [Project Keys])
```

-   **Pattern match:** the specific pattern of text you are looking for in version fields. This helps you to find versions that start with certain letters or numbers, contain specific characters, or meet other criteria you define.
    
-   **Syntax**: Our example below uses regex syntax. You can refer to this [website](https://regexr.com/) which is a regular expressions builder that can help you build an expression and provides definitions for each of the characters. 
-   **Project keys (optional):** A comma-separated list of project keys to narrow down the search. Specifying project keys improves query performance by limiting the search scope.
    

### Examples

1.  **Finding issues with versions starting with RC across all projects:**
    
    For teams needing to track release candidate versions:
    
    ```
fixVersion in versionMatch("^RC.*")
```
    
    This query helps in quickly identifying all issues that are part of any release candidate versions across all projects, useful for status reviews or release preparations.
    
2.  **Restricting the search to specific projects:**
    
    To enhance performance and focus on specific projects:
    
    ```
fixVersion in versionMatch("^RC.*", "DEMO, EXAMPLE, TEST")
```
    
    By specifying projects, the function narrows down the search, making it more efficient and tailored to particular project needs.
    

-   **Use a specific pattern match:** Allows you to accurately capture the versions of interest without being overly broad, which could impact performance.
-   **Regularly update project keys:** Keep the list of project keys up-to-date in your queries to reflect any changes in project configurations or priorities.
-   **Monitor query performance:** Be aware that using `versionMatch` across a large number of versions or projects without specifying project keys can lead to slow performance. Always try to use project keys where practical.
