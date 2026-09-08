# Mindville Integration

- Platform: data-center
- Space: SR4JS
- Hierarchy: integrations > other-apps
- Doc ID: doc-sr4js-101624879
- Source: https://docs.adaptavist.com/sr4js/latest/integrations/other-apps/mindville-integration

ScriptRunner _Behaviours_ supports the [Mindville](https://documentation.mindville.com/dashboard.action) _Insight Object/s_ select custom field type.

We do not support [radio button or checkbox](https://documentation.mindville.com/display/INSSERV/Default+Insight+Custom+Field) insight custom field types.

Currently, we support all operations on _Insight Object/s_ fields (such as, making read-only, changing value, making required).

For example, to hide a Mindville custom field type, you can add the following behaviour:

```
def currentCf = getFieldById('insight-field-id')
currentCf.setHidden(true)
```
