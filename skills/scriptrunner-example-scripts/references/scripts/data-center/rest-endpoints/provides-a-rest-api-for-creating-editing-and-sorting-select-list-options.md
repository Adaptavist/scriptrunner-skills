# Provides a REST API for creating, editing and sorting select list options

- Platform: data-center
- Feature: rest-endpoints
- Tags: fields
- Language: groovy
- Doc ID: example-dataCenter-custom-field-option-endpoint-onPrem
- Source: https://examples.scriptrunner.io/scripts/custom-field-option-endpoint-onPrem

## Overview

Use this custom REST Endpoint to provide a REST API for maintaining custom field options.

See [https://jira.atlassian.com/browse/JRASERVER-36112](https://jira.atlassian.com/browse/JRASERVER-36112) for the background.

---

**NOTE**

A single select list custom field can have multiple *contexts*, mapped to different projects or issue types.
Each context can have a different sets of options. A context is identified by its `fieldConfigId`.

Adding a new option, and sorting existing options are operations on the context, rather than the custom field, so you need to find the `fieldConfigId` of the context you wish to modify.

You can do that by going to the Edit Options page for the context you want to update programmatically. The URL in your browser will have the form:

`<base-url>/secure/admin/EditCustomFieldOptions!default.jspa?fieldConfigSchemeId=10222&fieldConfigId=10222&customFieldId=10020`

Copy the number for the `fieldConfigId` parameter, in the case above `10222`, and use it in the examples below.

![Getting the fieldConfigId](https://gist.githubusercontent.com/jechlin-adaptavist/4099caeec2c37d3cbe35987d0ec58bc8/raw/6d6e34654b7d14a6192a2f6f5e8c494ecf53d14d/CustomFieldOptionEndpoint-fieldConfigId.png)

---

## Example

For example, to create a new custom field option named "My New Value":

`curl -X POST  -H 'X-Atlassian-token: no-check' -u <user>:<password> "<base-url>/rest/scriptrunner/latest/custom/customFieldOption?fieldConfigId=10222&value=My%20New%20Value"`

To rename the custom field option with ID: `10003` to "Changed value":

`curl -X PUT -H 'X-Atlassian-token: no-check' -u <user>:<password> "<base-url>/rest/scriptrunner/latest/custom/customFieldOption?optionId=10003&value=Changed%20value"`

To sort all custom field options alphabetically:

`curl -X POST  -H 'X-Atlassian-token: no-check' -u <user>:<password> "<base-url>/rest/scriptrunner/latest/custom/customFieldOptionSort?fieldConfigId=10222"`

## Description

#### Overview

Use this custom REST Endpoint to provide a REST API for maintaining custom field options.

See [https://jira.atlassian.com/browse/JRASERVER-36112](https://jira.atlassian.com/browse/JRASERVER-36112) for the background.

---

**NOTE**

A single select list custom field can have multiple *contexts*, mapped to different projects or issue types.
Each context can have a different sets of options. A context is identified by its `fieldConfigId`.

Adding a new option, and sorting existing options are operations on the context, rather than the custom field, so you need to find the `fieldConfigId` of the context you wish to modify.

You can do that by going to the Edit Options page for the context you want to update programmatically. The URL in your browser will have the form:

`<base-url>/secure/admin/EditCustomFieldOptions!default.jspa?fieldConfigSchemeId=10222&fieldConfigId=10222&customFieldId=10020`

Copy the number for the `fieldConfigId` parameter, in the case above `10222`, and use it in the examples below.

![Getting the fieldConfigId](https://gist.githubusercontent.com/jechlin-adaptavist/4099caeec2c37d3cbe35987d0ec58bc8/raw/6d6e34654b7d14a6192a2f6f5e8c494ecf53d14d/CustomFieldOptionEndpoint-fieldConfigId.png)

---

#### Example

For example, to create a new custom field option named "My New Value":

`curl -X POST  -H 'X-Atlassian-token: no-check' -u <user>:<password> "<base-url>/rest/scriptrunner/latest/custom/customFieldOption?fieldConfigId=10222&value=My%20New%20Value"`

To rename the custom field option with ID: `10003` to "Changed value":

`curl -X PUT -H 'X-Atlassian-token: no-check' -u <user>:<password> "<base-url>/rest/scriptrunner/latest/custom/customFieldOption?optionId=10003&value=Changed%20value"`

To sort all custom field options alphabetically:

`curl -X POST  -H 'X-Atlassian-token: no-check' -u <user>:<password> "<base-url>/rest/scriptrunner/latest/custom/customFieldOptionSort?fieldConfigId=10222"`

## Script

```groovy
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.issue.customfields.MultipleSettableCustomFieldType
import com.atlassian.jira.issue.fields.config.FieldConfig
import com.atlassian.jira.issue.fields.config.manager.FieldConfigManager
import com.atlassian.jira.permission.GlobalPermissionKey
import com.atlassian.sal.api.ApplicationProperties
import com.atlassian.sal.api.UrlMode
import com.onresolve.scriptrunner.runner.rest.common.CustomEndpointDelegate
import groovy.json.JsonOutput
import groovy.transform.BaseScript
import org.apache.commons.lang3.StringUtils

import javax.ws.rs.core.MultivaluedMap
import javax.ws.rs.core.Response

import static javax.ws.rs.core.Response.Status.BAD_REQUEST

@BaseScript CustomEndpointDelegate delegate

def fieldConfigManager = ComponentAccessor.getComponent(FieldConfigManager)
def optionsManager = ComponentAccessor.optionsManager
def applicationProperties = ComponentAccessor.getOSGiComponentInstanceOfType(ApplicationProperties)
def authenticationContext = ComponentAccessor.jiraAuthenticationContext
def permissionManager = ComponentAccessor.globalPermissionManager

Closure<FieldConfig> getFieldConfig = { Long fieldConfigId ->
    def fieldConfig = fieldConfigManager.getFieldConfig(fieldConfigId)
    if (!fieldConfig) {
        throw new Exception(authenticationContext.i18nHelper.getText('Cannot find this fieldConfig'))
    }

    if (!permissionManager.hasPermission(GlobalPermissionKey.ADMINISTER, authenticationContext.getLoggedInUser())) {
        throw new Exception('Requires admin permissions')
    }

    fieldConfig
}

Closure<FieldConfig> getFieldConfigAndValidateForAddOrUpdate = { Long fieldConfigId, String optionValue ->
    if (!optionValue) {
        throw new Exception(authenticationContext.i18nHelper.getText('admin.options.empty.name'))
    }

    if (optionValue.size() > 255) {
        throw new Exception(authenticationContext.i18nHelper.getText('admin.options.too.long', optionValue))
    }

    def fieldConfig = getFieldConfig(fieldConfigId)

    def customFieldType = fieldConfig.customField.customFieldType
    if (customFieldType !instanceof MultipleSettableCustomFieldType) {
        throw new Exception(authenticationContext.i18nHelper.getText('admin.errors.customfields.cannot.set.options', "'$customFieldType'"))
    }

    def options = optionsManager.getOptions(fieldConfig)

    if (options*.value*.toLowerCase().contains(optionValue.toLowerCase())) {
        throw new Exception(authenticationContext.i18nHelper.getText('admin.errors.customfields.value.already.exists'))
    }

    fieldConfig
}

/*
    Add custom field option.

    The fieldConfigId can be retrieved from the URL when editing existing custom field options, with the name fieldConfigId.

    For example to create a new value named "My New Value":
    curl -X POST  -H 'X-Atlassian-token: no-check' -u <user>:<password> "<base-url>/rest/scriptrunner/latest/custom/customFieldOption?fieldConfigId=10222&value=My%20New%20Value"
*/
customFieldOption(
    httpMethod: 'POST'
) { MultivaluedMap queryParams ->
    def fieldConfigId = queryParams.getFirst('fieldConfigId') as Long
    def optionValue = StringUtils.stripToNull(queryParams.getFirst('value') as String)

    try {
        def fieldConfig = getFieldConfigAndValidateForAddOrUpdate(fieldConfigId, optionValue)

        def options = optionsManager.getOptions(fieldConfig)
        def createdOption = optionsManager.createOption(fieldConfig, null, options.size(), optionValue)

        Response.temporaryRedirect(URI.create(applicationProperties.getBaseUrl(UrlMode.ABSOLUTE) + '/rest/api/2/customFieldOption/' + createdOption.optionId)).build()
    }
    catch (any) {
        return Response.status(BAD_REQUEST).entity(JsonOutput.toJson(any.message)).build()
    }
}

/*
    Update text of existing custom field option.

    The optionId can be retrieved from the URL when editing the text of a custom field option, or via the existing REST API.

    For example to rename the option with ID: 10003 to "Changed value":
    curl -X PUT -H 'X-Atlassian-token: no-check' -u <user>:<password> "<base-url>/rest/scriptrunner/latest/custom/customFieldOption?optionId=10003&value=Changed%20value"
*/
customFieldOption(
    httpMethod: 'PUT'
) { MultivaluedMap queryParams ->
    def optionId = queryParams.getFirst('optionId') as Long
    def optionValue = queryParams.getFirst('value') as String

    def option = optionsManager.findByOptionId(optionId)
    if (!option) {
        return Response.status(BAD_REQUEST).entity(JsonOutput.toJson('Missing option')).build()
    }

    try {
        getFieldConfigAndValidateForAddOrUpdate(option.relatedCustomField.id, optionValue)
        optionsManager.setValue(option, optionValue)
        Response.temporaryRedirect(URI.create(applicationProperties.getBaseUrl(UrlMode.ABSOLUTE) + '/rest/api/2/customFieldOption/' + option.optionId)).build()
    }
    catch (any) {
        return Response.status(BAD_REQUEST).entity(JsonOutput.toJson(any.message)).build()
    }
}

/*
 * Sort existing options alphabetically
 *
 * Example:
 * curl -X POST  -H 'X-Atlassian-token: no-check' -u <user>:<password> "<base-url>/rest/scriptrunner/latest/custom/customFieldOptionSort?fieldConfigId=10222"
 */
customFieldOptionSort(
    httpMethod: 'POST'
) { MultivaluedMap queryParams ->
    def fieldConfigId = queryParams.getFirst('fieldConfigId') as Long
    def fieldConfig = getFieldConfig(fieldConfigId)
    def options = optionsManager.getOptions(fieldConfig)

    options.sortOptionsByValue(null)
    Response.noContent().build()
}
```

