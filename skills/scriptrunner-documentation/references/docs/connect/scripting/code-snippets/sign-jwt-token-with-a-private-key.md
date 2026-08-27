# Sign JWT Token with a Private Key

- Platform: connect
- Space: SRC
- Hierarchy: scripting > code-snippets
- Doc ID: doc-src-227149275
- Source: https://docs.adaptavist.com/src/latest/scripting/code-snippets/sign-jwt-token-with-a-private-key

The following example demonstrates how to sign a JWT token with a private key:

Third-party package 📦

This example requires that you import `jose-browser-runtime` (which is a port of [jose](https://www.npmjs.com/package/jose)) third-party package into your workspace.

```
import { importPKCS8, SignJWT } from 'jose-browser-runtime';

export default async function (event: any, context: Context): Promise<void> {
	// Define private key in PEM format, for example sake it's defined in the code, but consider using Record Storage to store the private key more securely
	const privateKeyPem = `-----BEGIN PRIVATE KEY-----
		PRIVATE_KEY_IN_PEM_FORMAT...
		-----END PRIVATE KEY-----`;

	// Define the algorithm for private key, possible values: https://github.com/panva/jose/issues/210
	const alg = 'RS256';

	// Import private key from PEM format
	const privateKey = await importPKCS8(privateKeyPem, alg);

	// Sign the JWT token
	const jwt = await new SignJWT({ 'urn:example:claim': true })
		.setProtectedHeader({ alg })
		.setIssuedAt()
		.setIssuer('urn:example:issuer')
		.setAudience('urn:example:audience')
		.setExpirationTime('2h')
		.sign(privateKey);

	// Print out the signed JWT token
	console.log('Signed JWT token: ', jwt);
}
```

Best practice: Record storage ⭐

This example hardcodes the private key in the code for simplicity. However, for security reasons, this is not recommended practice.

Please consider using [record storage](https://docs.adaptavist.com/src/latest/scripting/record-storage) to store the content of the certificates and the key instead.
