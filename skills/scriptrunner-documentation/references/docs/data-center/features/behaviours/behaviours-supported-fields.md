# Behaviours Supported Fields

- Platform: data-center
- Space: SR4JS
- Hierarchy: Features > Behaviours
- Doc ID: doc-sr4js-b603355e-56b8-4155-8cee-0ce4a036f4a5-ea4b993331dae28e
- Source: https://docs.adaptavist.com/sr4js/latest/features#behaviours--en#behaviours-supported-fields--en

Many third-party apps provide users with additional fields in Jira. Below is a list of all fields supported by ScriptRunner Behaviours.

## Supported

-   Single and Multi-select Insight fields.
-   All ScriptRunner fields. Such as pickers and other custom field types.
-   Most out-of-the-box Jira Software and Jira Service Management fields. See below for exceptions.
-   Reference Assets (formerly Insight) fields

## Unsupported

### Jira fields

The Attachment field is not supported by Behaviours. This is because it is not a standard form field and it can not be manipulated in the same way as other fields. If you want to add rules to your attachments, we recommend using our workflow validators. For more information, see our [Validating Attachments/Links In Transitions](https://docs.adaptavist.com/sr4js/latest/features/workflows/validators/validating-attachments-links-in-transitions) documentation.

### Other fields

All other fields provided by plugins are unsupported. However, Atlassian Marketplace Vendors can use our [Vendors API](../../integrations/vendors-api.md) to make their custom fields compatible with our [Behaviours](https://docs.adaptavist.com/sr4js/latest/features/behaviours).
