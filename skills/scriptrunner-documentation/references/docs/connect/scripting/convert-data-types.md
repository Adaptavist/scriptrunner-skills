# Convert Data Types

- Platform: connect
- Space: SRC
- Hierarchy: scripting
- Doc ID: doc-src-273485831
- Source: https://docs.adaptavist.com/src/latest/scripting/convert-data-types

Each ScriptRunner Connect workspace includes the [@sr-connect/convert](https://www.npmjs.com/package/@sr-connect/convert) package, which provides a set of convenient functions for converting between different data types:

-   convertBase64ToBuffer - Converts a base64 encoded string into an ArrayBuffer.
-   convertBase64ToText - Converts a base64 encoded string into plain text.
-   convertBufferToBase64 - Converts an ArrayBuffer into a base64 encoded string.
-   convertBufferToText - Converts an ArrayBuffer into plain text.
-   convertTextToBase64 - Converts plain text into a base64 encoded string.
-   convertTextToBuffer - Converts plain text into an ArrayBuffer.
-   convertTextToText - Converts plain text to plain text with a different encoding.
-   convertArrayBufferToFormDataBuffer - Converts an ArrayBuffer into a form-data-encoded ArrayBuffer, offering a more efficient solution than using FormData and Blob classes separately (strongly recommended). Read more about it in the ["Working with Attachments"](https://docs.adaptavist.com/src/latest/scripting/code-snippets/working-with-attachments) topic.

**Plain-text encoding ℹ️**

For all functions that involve converting to or from plain text, you can specify the text encoding as a second parameter. If not specified, the default encoding is `utf8`.

## Use the functions in your workspace

To use these functions, you need to import them into your script first.

You can import each function separately as follows:

```
import { convertTextToBase64 } from '@sr-connect/convert';

export default async function(event: any, context: Context): Promise<void> {
	console.log(convertTextToBase64('HELLO WORLD', 'utf8'));
}
```

Or you can import the entire namespace as follows:

```
import { Convert } from '@sr-connect/convert';

export default async function(event: any, context: Context): Promise<void> {
	console.log(Convert.textToBase64('HELLO WORLD', 'utf8'));
}
```

**Import suggestions** 🤓

To simplify the import process, you can use the editor's import-suggestions feature.

Start by typing the full name of the function you want to import, _then move the cursor back at least one position_. A light bulb icon will appear, offering import suggestions.

![Screenshot of code editor showing a syntax highlight on line 2 for ](/src/files/latest/273485831/273485832/1/1722940584000/Screenshot+2024-08-06+at+13.30.09.png)
