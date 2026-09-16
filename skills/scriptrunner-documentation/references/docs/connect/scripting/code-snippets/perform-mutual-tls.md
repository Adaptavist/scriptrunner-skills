# Perform Mutual TLS

- Platform: connect
- Space: SRC
- Hierarchy: Scripting > Code Snippets
- Doc ID: doc-src-2214f382-8bcf-49f5-996b-035704d2c7f3-488eeb89af394efe
- Source: https://docs.adaptavist.com/src/latest/scripting#code-snippets--en#perform-mutual-tls--en

Learn how to perform mutual TLS with the Fetch API.

The following example demonstrates how to perform [mutual TLS](https://www.cloudflare.com/en-gb/learning/access-management/what-is-mutual-tls/) with the Fetch API, which is non-standardized and specific to how ScriptRunner Connect supports it:

```
export default async function(event: any, context: Context): Promise<void> {
    const ca = `-----BEGIN CERTIFICATE-----
        CERT CONTENT IN PEM FORMAT...
        -----END CERTIFICATE-----`;
 
    const cert = `-----BEGIN CERTIFICATE-----
        CERT CONTENT IN PEM FORMAT...
        -----END CERTIFICATE-----`;
 
    const key = `-----BEGIN EC PRIVATE KEY-----
        KEY CONTENT IN PEM FORMAT...
        -----END EC PRIVATE KEY-----`;
 
    const response = await fetch('URL', {
        agent: {
            ca,
            cert,
            key
        }
    });
 
 if (!response.ok) {
 throw Error(`Invalid status code: ${response.status}`);
    }
 
 // Do something with the response
}
```

Note: Best practice ⭐

This example hardcodes the certificates and the key in the code for simplicity. However, for security reasons, this is not recommended.

Please consider using [Record Storage](https://docs.adaptavist.com/src/latest/scripting/record-storage) to store the content of the certificates and the key instead.
