# Mindville Integration

- Platform: data-center
- Space: SR4JS
- Hierarchy: Integrations > Other Apps
- Doc ID: doc-sr4js-c4fa5b4a-9ed7-49f6-af70-c762a6a44780-7c189e58cac60912
- Source: https://docs.adaptavist.com/sr4js/latest/integrations/other-apps#mindville-integration--en

ScriptRunner _Behaviours_ supports the [Mindville](https://documentation.mindville.com/dashboard.action) _Insight Object/s_ select custom field type.

Note: We do not support [radio button or checkbox](https://documentation.mindville.com/display/INSSERV/Default+Insight+Custom+Field) insight custom field types.

Currently, we support all operations on Insight Object/s fields (such as, making read-only, changing value, making required).

For example, to hide a Mindville custom field type, you can add the following behaviour:

```
def currentCf = getFieldById('insight-field-id')
currentCf.setHidden(true)
```
