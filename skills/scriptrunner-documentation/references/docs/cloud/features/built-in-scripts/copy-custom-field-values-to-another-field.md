# Copy Custom Field Values to Another Field

- Platform: cloud
- Space: SR4JC
- Hierarchy: Features > Built-In Scripts
- Doc ID: doc-sr4jc-4bba3564-4d52-4ebb-9acc-d9a370812bce-f2ba936bde64aefc
- Source: https://docs.adaptavist.com/sr4jc/latest/features/built-in-scripts#copy-custom-field-values-to-another-field--en

Work items in Jira are made up of built-in fields along with fields that you can create and customise to meet the needs of your project team. Custom fields contain values that you can copy from one to another, allowing you to widen or narrow the custom field.

To copy custom field values to another field:

1.  Navigate to the _Copy_ _custom_ _field values to another field_ page from the Jira _Administration_ menu by selecting Apps > ScriptRunner > Built-in Scripts.
2.  Enter a Subquery (JQL) to identify work items containing this query.
3.  Select the _Source field_ and _Target field_.
4.  Click the Run button, or click the Choose another script button to repeat the process and identify more work items.
    

Each work item returned by the query will copy values from one custom field to another. This is useful if you want to convert the type of a custom field.

Note that if the two custom fields contain different types, you may not be able to use this feature. The following conversions are handled:

-   Single to multi, for example, single select to multi select, single user picker to multi user picker.
-   Multi to single, however, only the first value will be retained.
-   Multi to text, the values are concatenated with a comma.
-   Short text to unlimited text
