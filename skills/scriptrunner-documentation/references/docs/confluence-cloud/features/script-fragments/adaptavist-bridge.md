# Adaptavist Bridge

- Platform: confluence-cloud
- Space: SR4CC
- Hierarchy: features > script-fragments
- Doc ID: doc-sr4cc-343605319
- Source: https://docs.adaptavist.com/sr4cc/latest/features/script-fragments/adaptavist-bridge

The Adaptavist bridge is a Javascript library that allows your [Script Fragments](https://docs.adaptavist.com/sr4cc/latest/features/script-fragments) to get Confluence information. The Adaptavist bridge also allows the script to use Confluence [REST APIs](https://developer.atlassian.com/cloud/confluence/rest/v2/intro/#about). The bridge serves as a wrapper for the [Confluence AP module](https://developer.atlassian.com/cloud/confluence/jsapi/request/) and allows your scripts to communicate with Confluence.

How the Adaptavist Bridge is injected into your script is determined by what you select for your **Source** on the Script Fragments form:

![](/sr4cc/files/latest/343605319/343605321/1/1741119123000/source-bridge.png)

You can choose either a [Separate HTML, CSS, and Javascript URL](#id-.AdaptavistBridgevCurrent-separate) or a [Single URL](#id-.AdaptavistBridgevCurrent-single) for the **Source**.

## Separate HTML, CSS, and Javascript URL source

The bridge is automatically injected, and you can call it in your script.

## Single URL source

If you are hosting your own site, you must include a script tag for our `bridge.js`. You can find the bridge by referencing `window.AdaptavistBridge` in your Javascript. This contains a context object, which provides more information on the current environment.

The bridge is injected into the page as a global variable, which can be accessed via `window.AdaptavistBridge` and `window.AdaptavistBridgeContext`. The bridge can be loaded from [https://assets.hydrogen.sagittarius.connect.product.adaptavist.com/public/js/bridge.js](https://assets.hydrogen.sagittarius.connect.product.adaptavist.com/public/js/bridge.js?_ga=2.124797770.1741109699.1627303464-966992592.1626337931).

The `AdaptavistBridge` object provides access to the `request` property for making HTTP AJAX requests. The `AdaptavistBridgeContext` object provides a `context` property. The two properties, [Request](#id-.AdaptavistBridgevCurrent-request) and [Context](#id-.AdaptavistBridgevCurrent-context), are broken down in this section.

### Request property

The `[request](https://developer.atlassian.com/cloud/confluence/jsapi/request/)` property on `AdaptavistBridge` is a function. This function takes an object as an argument that includes the following properties:

-   `url:` This property should be a relative URL to a Confluence REST API. 
-   `type`: This property should be one of the following HTTP methods: 
    -   `GET`
    -   `POST`
    -   `PUT`
    -   `DELETE`
-   Any of the other options from Confluence's AP Request options

An example of the script with the [`request`](https://developer.atlassian.com/cloud/confluence/jsapi/request/) property: 

```
requestOptions = {
    `/api/v2/spaces?keys=${AdaptavistBridgeContext.context.entityKey}`
    type: 'GET'
};
```

### Context property

The `context` property on `AdaptavistBridgeContext` is an object that can have the following possible properties:

-   `entityKey`
-   `location`
-   `pageId`
-   `spaceId`
-   `pageVersion`
-   `contentId`
-   `contentVersion`
-   `contentType`
-   `contentPlugin`

These properties allow accessing the Confluence APIs.  Here is an example of what the `context` object might contain:

```
AdaptavistBridgeContext.context = { 		
	"entityKey":"SPACE",
	"location":"atl.general0",
	"pageId":"125132",
	"spaceId":"56732934",
	"pageVersion":"6",
	"contentId":"125132",
	"contentVersion":"6",
	"contentType":"page",
	"contentPlugin":""
};
```

## Example 

The bridge will make a request to the [Confluence REST APIs](https://developer.atlassian.com/cloud/confluence/rest/v2/intro/#auth) with space data taken from the context object:

```
AdaptavistBridge.request({
    url: `/api/v2/spaces?keys=${AdaptavistBridgeContext.context.entityKey}`,
    type: 'GET'
})
    .then(d => {
        console.log('data', d)
    });
```

To receive one type of data, like the space name, use a script like this: 

```
AdaptavistBridge.request({
    url: `/api/v2/spaces?keys=${AdaptavistBridgeContext.context.entityKey}`,
    type: 'GET'
})
    .then(d => {
       console.log('data', d.results[0].name)
    });
```

Here is sample code written in HTML: 

```
<!DOCTYPE html>
<html lang="en">
<head>
<title>Script Fragment Example</title>
<script src="https://assets.hydrogen.sagittarius.connect.product.adaptavist.com/public/js/bridge.js"></script>
</head>
<body>
<p id="spaceName"></p>
<script>
console.log(AdaptavistBridgeContext.context);
 
AdaptavistBridge.request({
    url: `/wiki/api/v2/spaces/${AdaptavistBridgeContext.context.spaceId}`,
    type: 'GET'
})
    .then(space => {
        console.log('space', space)
        document.getElementById("spaceName").value = `Space with key ${space.key} has name of  ${space.name}`;
    });
</script>
</body>
</html>
```

## Limitations

Users must have the correct permissions set in the corresponding applications to view the content displayed in the iframes.
