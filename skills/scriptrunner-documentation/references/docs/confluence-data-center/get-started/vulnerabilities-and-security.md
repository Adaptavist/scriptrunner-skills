# Vulnerabilities and Security

- Platform: confluence-data-center
- Space: SR4C
- Hierarchy: Get Started
- Doc ID: doc-sr4c-406f8820-ece0-482c-ab5f-f696172d54b1-97aa8d228183ee71
- Source: https://docs.adaptavist.com/sr4c/latest/get-started#vulnerabilities-and-security--en

This page covers how we scan for vulnerabilities and common security concerns.

All software can have security vulnerabilities. ScriptRunner uses a number of open-source libraries, similar to most apps on the Marketplace.

Note: Privacy and security information on Atlassian Marketplace

You can also view security details when you select the Privacy and Security tab on the ScriptRunner Atlassian Marketplace listing.

## Vulnerability scanning

During every build, we scan all dependencies for known vulnerabilities as cataloged by the [National Vulnerability Database](https://nvd.nist.gov/). Where we find a vulnerability we endeavor to upgrade that dependency to a version without the vulnerability.

### Exceptions

We do not always take action when a vulnerability is identified. This is because:

-   Some vulnerabilities are not exploitable through ScriptRunner, or to exploit them would require system administrator access.
-   Some vulnerabilities are disputed by the library authors.
-   Sometimes the scanner produces false positives.

Note: Read Atlassian's [Security](https://www.atlassian.com/trust/security) page for more details on security, advisories, and best practices.

### Security concerns

Sometimes we get reports that ScriptRunner is insecure because, for instance, you can execute a command line program on the Confluence server using the [Script Console](https://docs.adaptavist.com/sr4c/latest/features/script-console).

The philosophy of ScriptRunner is to make programming tasks easy. You could write an app in Java, install it in Confluence, and it could execute a command line program, or you could do it in ScriptRunner. Therefore, everything you can do in an app you can do in ScriptRunner.

#### Restricting scripting permissions

To upload an app, you need Confluence System administrator permission. By default, to author and/or run a ScriptRunner script, you must have Confluence administrator permissions.

Use the [Enable System Admin Only Script Edit Permissions](https://docs.adaptavist.com/sr4c/latest/get-started/settings/system-admin-only-script-edit-permission) setting to restrict which Confluence Administrators can edit scripts based on groups. When enabled, this setting gives script editing permission to groups with the Confluence System administrator permissions only.

For more details, check out the [Permissions](https://docs.adaptavist.com/sr4c/latest/get-started/permissions) page.
