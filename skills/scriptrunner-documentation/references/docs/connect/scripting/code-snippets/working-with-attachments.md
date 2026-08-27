# Working with Attachments

- Platform: connect
- Space: SRC
- Hierarchy: scripting > code-snippets
- Doc ID: doc-src-194676584
- Source: https://docs.adaptavist.com/src/latest/scripting/code-snippets/working-with-attachments

When working with ScriptRunner Connect's Managed API, you can easily work with attachments using supported methods. As a convention, when adding an attachment, you should be able to specify either a `string`  type (plain text) or an `ArrayBuffer` type (binary) as the content/body of the attachment.

For example, in Jira Cloud, the content is either a type of `string`  or an `ArrayBuffer`:

![Snippet of TypeScript code for an asynchronous function adding an attachment in JiraCloud, with a tooltip showing content type as string or ArrayBuffer.](/src/files/latest/194676584/194676583/1/1695224948000/Screenshot+2023-06-20+at+15.24.25.png)

Here is a code snippet that will create an attachment in Jira Cloud with a file named `hello.txt`  and with a plain text content of `hello world` :

```
import JiraCloud from './api/jira/cloud';

export default async function(event: any, context: Context): Promise<void> {
	await JiraCloud.Issue.Attachment.addAttachments({
		issueIdOrKey: 'ISSUE-1',
		body: [{
			fileName: 'hello.txt',
			content: 'hello world'
		}]
	});
}
```

The following code snippet demonstrates how to work with binary data. In this case, the script fetches a random kitten image and then uploads it to Jira as an attachment. Notice how the .arrayBuffer() method is used to extract the binary representation of the image and is then passed directly into the `content` field:

```
import JiraCloud from './api/jira/cloud';

export default async function(event: any, context: Context): Promise<void> {
	// Fetch a kitten image using Fetch API
	const response = await fetch('https://placekitten.com/300/400');

    // Check if the response is OK
    if (!response.ok) {
        // If not then throw an error
        throw Error(`Unexpected response: ${response.status}`)
    }

	// Extract the kitten image as ArrayBuffer
    const kittenImage = await response.arrayBuffer();

	// Add an attachment with the kitten image
	await JiraCloud.Issue.Attachment.addAttachments({
		issueIdOrKey: 'ISSUE-1',
		body: [{
			fileName: 'kitten.jpg',
			content: kittenImage
		}]
	});
}
```

## Fetch API

If you don't want to use the Managed API directly, you can use the [Fetch API](https://docs.adaptavist.com/src/managed-apis/managed-api-abstractions#fetch-api) as an alternative, but you'll likely need to construct the FormData manually unless the service you're connecting to accepts the attachment in another format. You could use, for example, a base64 string along with the [@stitch-it/convert](https://www.npmjs.com/package/@stitch-it/convert) package to convert `ArrayBuffer` into a base64 `string`.

The following code snippet performs the same function as the snippet above, but it utilises the low-level [Managed Fetch API](https://docs.adaptavist.com/src/managed-apis/managed-api-abstractions#managed-fetch-api) to upload the attachment. (Notice how `Blob`  and `FormData` need to be constructed manually in this case.)

```
import JiraCloud from './api/jira/cloud';

export default async function (event: any, context: Context): Promise<void> {
	const issueKey = 'ISSUE-1';   

    // Fetch a an image using Fetch API
	const response = await fetch('https://app.scriptrunnerconnect.com/js.png');

	// Check if the response is OK
	if (!response.ok) {
		// If not then throw an error
		throw Error(`Unexpected response while fetching the image: ${response.status}`)
	}

	// Extract the the image as ArrayBuffer
	const image = await response.arrayBuffer();

	// Construct the FormData that holds the attachment
	const blob = new Blob([image]);
	const formData = new FormData();
	formData.append('file', blob, 'js.png');

	// Add an attachment using Fetch API
	const attachmentResponse = await JiraCloud.fetch(`/rest/api/3/issue/${issueKey}/attachments`, {
		method: 'POST',
		body: formData,
		headers: {
			'Accept': 'application/json',
			'X-Atlassian-Token': 'no-check',
		}
	});

	// Check if the attachment response is OK
	if (!attachmentResponse.ok) {
		// If not then throw an error
		throw Error(`Unexpected response while uploading attachment: ${attachmentResponse.status}`);
	} }
```

**Content-type fix 🔧**

In the example above, the `Content-Type` header is not explicitly specified. When this happens, and `FormData` is being passed into the body, ScriptRunner Connect will automatically attach the appropriate `multipart/form-data` content-type header.

## Working with large attachments (<100MB)

When constructing a `FormData` object together with `Blob`, as shown in the example above, the underlying (attachment) data will be copied into memory multiple times. This is an inefficient use of CPU time and can cause runtime crashes due to excessive memory usage. To circumvent the issue, you can use the `convertArrayBufferToFormDataBuffer` (or `Convert.arrayBufferToFormDataBuffer`) utility function from the [@sr-connect/convert library](https://www.npmjs.com/package/@sr-connect/convert) to achieve the same outcome more efficiently, since data will only be copied once.

Here's an example that demonstrates this:

```
import JiraCloud from './api/jira/cloud';
import { Convert } from "@sr-connect/convert";

export default async function(event: any, context: Context): Promise<void> {
	const issueKey = 'ISSUE-1';

	// Fetch an image using Fetch API
	const response = await fetch('https://app.scriptrunnerconnect.com/js.png');

	// Check if the response is OK
	if (!response.ok) {
		// If not then throw an error
		throw Error(`Unexpected response while fetching the image: ${response.status}`)
	}

	// Extract the the image as ArrayBuffer
	const image = await response.arrayBuffer();

	// Convert the image to buffered form data
	const bufferedFormData = Convert.arrayBufferToFormDataBuffer({
		fileName: 'js.png',
		value: image
	});

	// Add an attachment using Fetch API
	const attachmentResponse = await JiraCloud.fetch(`/rest/api/3/issue/${issueKey}/attachments`, {
		method: 'POST',
		body: bufferedFormData.arrayBuffer, // Get and then set the encoded buffer
		headers: {
			'Accept': 'application/json',
			'X-Atlassian-Token': 'no-check',
			'Content-Type': bufferedFormData.contentType // Get and then set the content type
		}
	});

	// Check if the attachment response is OK
	if (!attachmentResponse.ok) {
		// If not then throw an error
		throw Error(`Unexpected response while uploading attachment: ${attachmentResponse.status}`);
	}
}
```

## Working with very large attachments (100MB+)

While the `convertArrayBufferToFormDataBuffer` utility function helps you transmit larger attachments by being more memory efficient, you may still run out of memory at some point. As a rule of thumb, attachments larger than 100MB will fail to be processed in memory, even with the aforementioned memory optimization. To work around this limitation, ScriptRunner Connect offers a feature that circumvents the memory limitation by not loading the attachment into runtime memory, but instead streaming it in the background, allowing it to process very large files. 

**Theoretical limit 🤓**

We've tested this feature with files as large as a few GBs and believe the theoretical limit attachment-wise is 5TB. The primary constraint remains the 15-minute limit for running your function, as you must fetch and upload the attachment within this timeframe.

### In practice

This feature requires you to first let us know which file you would like us to store temporarily, so that you can upload it later. To do this, add a custom header called `x-stitch-store-body: true` to indicate that the body received with this API call should be stored for future use. Instead of receiving the actual body in the response, you will receive the header `x-stitch-stored-body-id`, which contains a unique ID that references the body content that we stored for you.

When you are ready to make the API call and retrieve the stored attachment, pass the `x-stitch-stored-body-id` header with the unique ID you received earlier.

And we'll handle the rest! We'll retrieve the stored body, transform it into either `multipart/form-data` or `base64` format, swap out the request body with the transformed content, and make the API call.

Since the actual body of the request will be replaced with the transformed content, you don't need to specify the body yourself, since it will be ignored, except for `base64` transformation.

Header `x-stitch-transform-stored-body` is controlling which transformation to apply. Accepted values are `form-data` (default) or `embedded-base64.`

### Using multipart/form-data upload

Use the following custom headers to control the transformation process into multipart/form-data format:

-   **x-stitch-stored-body-form-data-file-name  
    **Use this header to specify the name of the file that is attached to the file entry. Defaults to: `file`.
-   **x-stitch-stored-body-form-data-additional-fields**  
    Use this header to add additional key pairs to the form data content. Key pairs are delimited by`;` and keys and pairs are delimited by `:`  
    For example, `key:value;foo:bar;` 
-   **x-stitch-stored-body-form-data-file-identifier**  
    Identifier for the file entry. Defaults to: `file`. Overwrite it if the service you're working with requires a different identifier. For example, ServiceNow requires the following identifier: `uploadFile`
-   **x-stitch-drop-body: true**  
    Although unrelated to uploading attachments, this header will drop the body from the request if you are only interested in the headers and the service does not support the `HEAD` method, which should be used otherwise. This option is always enabled when the `x-stitch-store-body` header is enabled.

#### An example

```
import JiraCloud from './api/jira/cloud';

const ISSUE_KEY = 'ISSUE-1';

export default async function (event: any, context: Context): Promise<void> {
	// Get the issue
	const issue = await JiraCloud.Issue.getIssue({
		issueIdOrKey: ISSUE_KEY
	});

	// Get the first attachment
	const attachment = issue.fields.attachment[0];

	// Fetch the attachment content
	const attachmentContentResponse = await JiraCloud.fetch(attachment.content, {
		headers: {			
			'x-stitch-store-body': 'true' // Ask this attachment to be stored
		}
	});

	// Check if the attachment content response is OK
	if (!attachmentContentResponse.ok) {
		// If not, then throw an error
		throw Error(`Failed to download attachment: ${attachmentContentResponse.status}`);
	}

	// Since we asked the attachment to be stored, we're expecting to receive the stored attachment body ID
	const storedBodyId = attachmentContentResponse.headers.get('x-stitch-stored-body-id');

	// Check if the stored body ID was found
	if (!storedBodyId) {
		// If not, throw an error
		throw Error('No stored body id found');
	}

	// Upload an attachment under the same issue with the same content but prepend `copy_of_` to the attachment name
	const uploadResponse = await JiraCloud.fetch(`/rest/api/3/issue/${ISSUE_KEY}/attachments`, {
		method: 'POST',
		headers: {
			'X-Atlassian-Token': 'no-check',
			'x-stitch-stored-body-id': storedBodyId, // Reference the stored attachment body ID
			'x-stitch-stored-body-form-data-file-name': `copy_of_${attachment.filename}`, // Specify the file name to be used in multipart/form-data
			'x-stitch-stored-body-form-data-additional-fields': 'key:value;foo:bar;', // Add additional fields to the multipart/form-data, although not required for Atlassian and thus gets ignored
			'x-stitch-stored-body-form-data-file-identifier': 'file' // Specify the multipart/form-data file upload identifier, although not necessary for Atlassian since it defaults to 'file' anyway
		}
	})

	// Check if the upload was successful
	if (!uploadResponse.ok) {
		// If it was not, throw an error
		throw Error(`Failed to upload attachment: ${uploadResponse.status}`)
	}

	// Log out the copied attachment name
	console.log(`Copied attachment: ${attachment.filename}`);
}
```

### Using base64 upload

To use the base64 streaming, you first have to specify the `x-stitch-transform-stored-body='embedded-base64'` header with the fetch call. Then, you can simply specify the `x-stitch-stored-body-id` header and include the `[storedBodyBase64]` marker somewhere in the body, where the transformed base64 output will be injected. Please use only one marker.

#### An example

```
await fetch('https://name.domain', {
	method: 'POST',
	headers: {
		'Content-Type': 'application/json',
		'x-stitch-transform-stored-body': 'embedded-base64', // Transform the stored body into embedded base64
		'x-stitch-stored-body-id': storedBodyId, // Reference the stored attachment body ID	
	},
	body: JSON.stringify({
		content: '[storedBodyBase64]' // Inject the transformed base64 output into here
	})
});
```

  

**Known limitations 👀**

-   Managed APIs do not currently support this feature. To use custom headers, you will need to use the [Fetch API](https://docs.adaptavist.com/src/latest/scripting/fetch-api).
-   At this time, we only support transforming the received body into the multipart/form-data format. We'll look to add other formats in the future. If you urgently need us to support other formats, please contact [ScriptRunner Connect support](https://the-adaptavist-group-support.atlassian.net/servicedesk/customer/portal/20).

**Related templates** 💡

Here are a few templates that might be beneficial to you:

-   [Keep two Jira Cloud projects in sync](https://stitchit.app/template/01GYW8F8WHZ8SAFCNVBAQY16D8)  
    In addition to other fields kept in sync between two Jira Cloud projects, this template also syncs attachments.
-   [Send back an image with the Generic HTTP Event](https://stitchit.app/template/01GAV5V540K4E3BMYK87H98G74)  
    This template demonstrates how to convert an `ArrayBuffer` into a `base64` string, should you need to perform such a conversion.

**Templates that manipulate attachments ✨**

-   [Sync ServiceNow Incidents with Jira Cloud Issues](https://templates.scriptrunnerconnect.com/template/01GMT114JSESH9PQRYX18X3A8W)
-   [Sync Jira Cloud issues](https://templates.scriptrunnerconnect.com/template/01GYW8F8WHZ8SAFCNVBAQY16D8)
-   [Sync Jira Cloud issues with Jira On-Premise issues](https://templates.scriptrunnerconnect.com/template/01HNFNQMDF7G1N8Y34D2SDPDDD)
-   [Sync Jira Cloud Issues and Salesforce Cases](https://templates.scriptrunnerconnect.com/template/01HZ79YD55DAW6G30AZZBHQR04)
-   [Sync Jira Cloud issues with Trello cards](https://templates.scriptrunnerconnect.com/template/01H57VJ2RRWNBSHEMW78V4WMTY)
