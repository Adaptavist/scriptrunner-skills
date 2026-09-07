# Behaviours FAQs

- Platform: data-center
- Space: SR4JS
- Hierarchy: get-help > frequently-asked-questions
- Doc ID: doc-sr4js-442888328
- Source: https://docs.adaptavist.com/sr4js/latest/get-help/frequently-asked-questions/behaviours-faqs

### How do I get the Service Management **Request Type** name in behaviours?

From ScriptRunner 6.1.0, you can call the [getRequestTypeName](https://docs.adaptavist.com/sr4js/latest/features/behaviours/api-quick-reference#id-.APIQuickReferencev9.x-getRequestTypeName\(\)) method within your behaviour scripts to get the name of the current Service Management **Request Type** that the user is interacting with.

### How do I get the value of the current issue’s custom fields with behaviours when on the edit screen?

Use the `underlyingIssue` variable in a behaviours script to find the value of current issue’s fields. This variable is available in any behaviour script, however, it will be null on the _Create_ screen because the issue does not exist at that point.

```
import com.atlassian.jira.component.ComponentAccessor

def myField = ComponentAccessor.getCustomFieldManager().getCustomFieldObjects().findByName("TextFieldA")
def fieldValue = underlyingIssue?.getCustomFieldValue(myField)
```

When using the `underlyingIssue` to retrieve the values of the current issue’s fields those values are obtained from the issue and not the values within the current form.

  

* * *

## Related content

-   [Get Help with Behaviours](https://docs.adaptavist.com/sr4js/latest/get-help/get-help-with-behaviours)
-   [Troubleshooting Behaviours](https://docs.adaptavist.com/sr4js/latest/get-help/troubleshooting/troubleshooting-behaviours)
-   [Behaviours Supported Fields](https://docs.adaptavist.com/sr4js/latest/features/behaviours/behaviours-supported-fields)
