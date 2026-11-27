# Vulnerabilities and Securities

- Platform: confluence-cloud
- Space: SR4CC
- Hierarchy: Manage App
- Doc ID: doc-sr4cc-d0af6ef5-6d9f-4ad6-b680-a0d3a3cc9212-8d13ceafb6644168
- Source: https://docs.adaptavist.com/sr4cc/latest/manage-app/vulnerabilities-and-securities

Information about the software vulnerabilities and security features within the app.

All software can have security vulnerabilities. ScriptRunner uses several open-source libraries, as do most apps on the Marketplace. This page covers how we scan for vulnerabilities and common security concerns.

Note: Privacy and security information on Atlassian Marketplace

You can also view security details when you select the Privacy and Security tab on the ScriptRunner Atlassian Marketplace listing.

## Vulnerability scanning

During every build, we scan all dependencies for known vulnerabilities as cataloged by the [National Vulnerability Database](https://nvd.nist.gov/). When we find a vulnerability, we endeavor to upgrade the dependency to a version does not contain it.

### Exceptions

We do not always take action when a vulnerability is identified. This is because:

-   Some vulnerabilities are not exploitable through ScriptRunner, or to exploit them would require system administrator access.
-   Some vulnerabilities are disputed by the library authors.
-   Sometimes the scanner produces false positives.

Note: Read Atlassian's [Security](https://www.atlassian.com/trust/security) page for more details on security, advisories, and best practices.

### Security concerns

Sometimes we get reports that ScriptRunner is insecure because, for instance, you can execute a command-line program on the Confluence Cloud using the [Script Console](../features/script-console.md).

The philosophy of ScriptRunner is to make programming tasks easy. You could write an app in Java, install it in Confluence Cloud, and it could execute a command-line program, or you could do it in ScriptRunner. Therefore, everything you can do in an app, you can do in ScriptRunner.

#### Restricting scripting permissions

To upload an app, you need Confluence Cloud System administrator permission. By default, to author and/or run a ScriptRunner script, you must have Confluence Cloud administrator permissions.

For more details, check out the [Permissions](../get-started/permissions.md) page.
