# Vulnerabilities and Security

- Platform: data-center
- Space: SR4JS
- Hierarchy: get-started
- Doc ID: doc-sr4js-442888312
- Source: https://docs.adaptavist.com/sr4js/latest/get-started/vulnerabilities-and-security

All software can have security vulnerabilities. ScriptRunner uses a number of open-source libraries, similar to most apps on the Marketplace. This page covers how we scan for vulnerabilities and common security concerns. 

Privacy and security information on Atlassian Marketplace

You can also view security details when you select the **Privacy and Security** tab on the ScriptRunner Atlassian Marketplace listing. 

## Vulnerability scanning

During every build, we scan all dependencies for known vulnerabilities as cataloged by the [National Vulnerability Database](https://nvd.nist.gov/). Where we find a vulnerability we endeavor to upgrade that dependency to a version without the vulnerability. 

### Exceptions

We do not always take action when a vulnerability is identified. This is because:

-   Some vulnerabilities are not exploitable through ScriptRunner, or to exploit them would require system administrator access. 
-   Some vulnerabilities are disputed by the library authors.
-   Sometimes the scanner produces false positives.

Read Atlassian's [Security](https://www.atlassian.com/trust/security) page for more details on security, advisories, and best practices. 

### Cross-site Scripting (XSS) vulnerability example

We do not classify reported XSS  issues, that derive from user code, as vulnerabilities because we expect Administrators to handle defensive coding practices by sanitizing or escaping any output derived from untrusted inputs. On occasion, when an XSS vulnerability is identified, we do look at the areas of the codebase susceptible to XSS vulnerabilities and sanitize the area.

Our documentation on [Cross-site Scripting Vulnerabilities](https://docs.adaptavist.com/sr4js/latest/best-practices/write-code/avoid-cross-site-scripting-vulnerabilities) explicitly addresses this topic and provides guidance on how to avoid these issues using tools like groovy.xml.MarkupBuilder or HTML-escaping output strings. Administrators must be responsible for sanitizing output, as this approach also allows them to utilize HTML and JavaScript for richer customizations.

### Vulnerabilities in 3rd party dependencies

Using ScriptRunner to exploit vulnerabilities in 3rd party dependencies requires specific conditions to be met that are not always exploitable, such as having system administrator permission. We may therefore not take action when such vulnerabilities are identified in 3rd party dependencies.

### Security concerns

We use [OWASP security scanner](https://owasp.org/www-community/Vulnerability_Scanning_Tools) as part of our build pipeline, and Atlassian scan our dependencies as part of the [terms of being in marketplace](https://developer.atlassian.com/platform/marketplace/dc-apps-security-scanner/#ams). However, even with the OWASP scanner, there will be features of ScriptRunner that are working as designed but are flagged as issues.

Sometimes we get reports that ScriptRunner is insecure because, for instance, you can execute a command line program on the Jira server using the [Script Console](https://docs.adaptavist.com/sr4js/latest/features/script-console).

The philosophy of ScriptRunner is to make programming tasks easy. You could write an app in Java, install it in Jira, and it could execute a command line program, or you could do it in ScriptRunner. Therefore, everything you can do in an app you can do in ScriptRunner. 

Bug bounty

We participate in a private invite-only bug bounty program on Bugcrowd. The program's scope includes products we develop at Adaptavist for the Atlassian marketplace.

#### Restricting scripting permissions

To upload an app you, need Jira System administrator permission. By default, to author and/or run a ScriptRunner script, you must have Jira administrator permissions.

Use the [Enable System Admin Only Script Edit Permissions](https://docs.adaptavist.com/sr4js/latest/get-started/settings/system-admin-only-script-edit-permission) setting to restrict which Jira Administrators can edit scripts, based on groups. When enabled, this setting gives script editing permission to groups with the **Jira System administrator** permissions **only.**

For more details, check out the [Permissions](https://docs.adaptavist.com/sr4js/latest/get-started/permissions) page.
