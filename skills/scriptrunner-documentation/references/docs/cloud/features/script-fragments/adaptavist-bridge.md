# Adaptavist Bridge

- Platform: cloud
- Space: SR4JC
- Hierarchy: features > script-fragments
- Doc ID: doc-sr4jc-115708698
- Source: https://docs.adaptavist.com/sr4jc/latest/features/script-fragments/adaptavist-bridge

## Additional functionality with the Adaptavist bridge

We provide some functionality, so your web panel can communicate with the Jira instance. If you are using the Separate HTML CSS Javascript source, then this feature is available to you by default.

If you are hosting your own site, you need to include a script tag to our `bridge.js`, as outlined below. You can find the bridge by referencing `window.AdaptavistBridge` in your Javascript. This contains a context object, which provides more information of the current environment. Eg. If the panel is displayed inside a work item, the context will contain the issueKey. You can also make calls to the Jira REST API, with the context.request function. You can find more information about the [endpoint](https://developer.atlassian.com/cloud/jira/platform/rest/v2/), and the [usage](https://developer.atlassian.com/cloud/jira/platform/jsapi/request/) here.

## Include a script tag

The bridge is a Javascript library that allows your scripts in the "web panel" feature of ScriptRunner to obtain information about the work item that users are viewing and also to use the Jira REST APIs.

The bridge can be loaded from [https://assets.hydrogen.sagittarius.connect.product.adaptavist.com/public/js/bridge.js](https://assets.hydrogen.sagittarius.connect.product.adaptavist.com/public/js/bridge.js?_ga=2.124797770.1741109699.1627303464-966992592.1626337931)

If a script provides HTML/CSS/JS URLs, then the bridge is automatically injected, but it will need to be manually injected for single URL Web Panels.

The bridge serves as a wrapper for the [Jira AP module](https://developer.atlassian.com/cloud/jira/software/jsapi/request/) and allows your scripts to communicate with Jira.

## Features

The bridge is automatically injected into the page as a global variable, which can be accessed via `window.AdaptavistBridge` and `window.AdaptavistBridgeContext`.

The `AdaptavistBridge` object provides access to the `request` property for making HTTP AJAX requests. The `AdaptavistBridgeContext` object provides a `context` property for obtaining the project and issue keys (spaces and work keys).

### Request

The `request` property on `AdaptavistBridge` is a function.

This function takes an object as an argument that includes `url` and `type` properties, plus any of the other options from Jira’s AP Request options, for example:

```
requestOptions = {
    url: `/rest/api/2/issue/${AdaptavistBridgeContext.context.issueKey}`,
    type: 'GET'
};
```

The `url` property should be a relative url to a Jira REST API and the `type` property should be one of the following HTTP methods: GET, POST, PUT, DELETE.

### Context

The `context` property on `AdaptavistBridgeContext` is an object that can have the following possible properties:

```
{
    location,
    issueKey,
    projectKey
}
```

These properties allow accessing the Jira APIs with these given properties.

Here is an example of what the `context` object might contain:

```
AdaptavistBridgeContext.context = {
    projectKey: 'SHOP',
    issueKey: 'SHOP-1',
    location: 'atl.jira.view.issue.right.context'
};
```

### Example

The bridge will make a request to the [Jira](https://developer.atlassian.com/cloud/jira/platform/rest/) REST APIs with an issue key taken from the context object:

```
AdaptavistBridge.request({
    url: `/rest/api/2/issue/${AdaptavistBridgeContext.context.issueKey}`,
    type: 'GET'
})
    .then(d => {
        console.log('data', d)
    });
```

This request will receive all the data for this issue (work item).

### HTML example

```
<!DOCTYPE html>
<html lang="en">
<head>
<title>Script Fragment Example</title>
<script src="https://assets.hydrogen.sagittarius.connect.product.adaptavist.com/public/js/bridge.js"></script>
</head>
<body>
<p id="issueType"></p>
<script>
console.log(AdaptavistBridgeContext.context);

AdaptavistBridge.request({
    url: `/rest/api/2/issue/${AdaptavistBridgeContext.context.issueKey}`,
    type: 'GET'
})
    .then(issue => {
        console.log('issue', issue)
        document.getElementById("issueType").value = `${issue.key} is a ${issue.fields.issuetype.name} in ${issue.fields.status.name}`;
    });
</script>
</body>
</html>
```

## Limitations

Users must have correct permissions set in the corresponding applications to view displayed content in the iframes.
