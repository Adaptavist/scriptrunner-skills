# Security

- Platform: connect
- Space: SRC
- Hierarchy: n/a
- Doc ID: doc-src-194676702
- Source: https://docs.adaptavist.com/src/latest/security

ScriptRunner Connect, developed by Adaptavist, is a cloud-based, Atlassian-focused, code-first integration Platform as a Service (iPaaS) product. Designed to connect to third-party systems, ScriptRunner Connect enables users to focus on writing business logic in JavaScript or TypeScript, while the ScriptRunner Connect team handles the complexities of infrastructure and security. A key aspect of ScriptRunner Connect's mission is the emphasis on rigorous security standards and privacy protections.

While ScriptRunner Connect is an independent product and does not directly integrate with Atlassian, our security policies align with [Adaptavist's trust, security, and privacy policies](https://www.adaptavist.com/company/trust-security-and-privacy).

## Security measures

ScriptRunner Connect is a multi-tenant SaaS product that ensures the separation of customer data through logical partitioning and robust security checks at our API endpoints. These checks, verified through automated testing, ensure that users can only access data they are authorized to view based on the least-privilege principle.

The app achieved positive results from a penetration test conducted by a third-party, [CREST-certified vendor](https://www.crest-approved.org/).

ScriptRunner Connect is also part of a public [bug bounty program](https://bugcrowd.com/adaptavist-og?preview=8286ea2b71d7eee1041c27b428aa0d14).

To proactively identify potential vulnerabilities, we operate vulnerability scanners for third-party packages and ensure all security-related changes are thoroughly peer-reviewed. Our team is also trained in secure coding practices, reinforcing our commitment to maintaining a secure environment.

As we introduce new features, we perform risk assessments that consider reliability and security, ensuring all additions to ScriptRunner Connect meet our high standards.

ScriptRunner Connect utilizes AWS services hosted in **EU (Ireland)** and **US (Oregon)**. You can choose either hosting option when signing up. However, even when using a US-based instance, your first name, last name, email, company name, and credit card details (if you pay via credit card) are stored in the EU region.

For script executions, ScriptRunner Connect uses [V8 Isolates](https://v8.dev/) technology for secure isolation. Each script execution occurs in a new V8 Isolate, which is immediately destroyed afterwards. This is the same technology that powers [Chromium](https://www.chromium.org/chromium-projects/)\-based browsers and is used in shared cloud resources like [Cloudflare Workers](https://workers.cloudflare.com/). This approach ensures the highest level of security while running untrusted JavaScript code. Refer to ScriptRunner Connect's [Runtime](https://docs.adaptavist.com/src/latest/scripting/runtime) user documentation for additional information. For added security, you can optionally enable [enhanced isolation mode](https://docs.adaptavist.com/src/latest/scripting/runtime#enhanced-isolation-mode), which will enable per-tenant Lambda isolation by spooling V8 Isolates and running your code within them. This added isolation ensures that, in the unlikely event the V8 Isolate sandbox is compromised, the malicious actor cannot corrupt the runtime environment of Lambda instances exclusively reserved for your team.

Access to ScriptRunner Connect's AWS account and other cloud services is strictly limited to the ScriptRunner Connect engineering team.

We also use private network subnets for added security where appropriate.

## Data retention and security

Operational and user-facing logs are retained for six months and can only be accessed by the ScriptRunner Connect team. Analytical logs, however, are kept indefinitely, enabling us to understand trends over time that we can leverage to improve our service. A broader Adaptavist group can access analytical logs, though PII (Personally Identifiable Information) in analytical logs is anonymized.

In terms of data security, we only use cloud services that offer encryption both at rest and in transit. Sensitive information like end-user authentication keys is additionally encrypted using [AWS KMS](https://aws.amazon.com/kms/) symmetric encryption with key rotation (256-bit AES-GCM). TLS version 1.2 with strong cyphers is used with HTTPS by default.

## Incident management

ScriptRunner Connect features a robust incident-management process, including a post-incident review process that enables learning from prior incidents, as well as various monitoring and alerting systems. Our team also runs automated tests periodically to detect incidents as early as possible.

### Script failure notifications

You may want to be notified if a script execution fails. We've made this simple and easy within our _Email notifications_ section in _Profile settings_.

To enable email notifications:

1.  Click your **user profile icon** at the bottom of the _left-hand menu_.  
    A list of related options appears.
2.  Click **Profile settings**.
3.  Scroll down to the _Email notifications_ section.
4.  Toggle _Script failure_ to **On**.
5.  Select **Save Changes**. 

Custom filtering

If you'd like to customize this process, we offer a public REST API that includes access to the invocation logs. This allows you to filter the information you'd like to receive.  
For more info, see the [REST API](https://docs.adaptavist.com/src/latest/rest-api) section of the documentation. 

## Compliance

ScriptRunner Connect is GDPR compliant and [ISO 27001](https://www.iso.org/standard/27001) and [SOC Type 2](https://www.imperva.com/learn/data-security/soc-2-compliance/) certified.

While we aim to reduce the PII (Personally Identifiable Information) data in our logs, we may occasionally temporarily increase our logging levels, which could contain PII data, for troubleshooting.

For further information, you may refer to the following related compliance documents: [AWS](https://aws.amazon.com/compliance/), [Adaptavist Terms and Conditions](https://www.adaptavist.com/terms-and-conditions), [Privacy Policy](https://www.adaptavist.com/privacy-policy), and the [Data Processing Addendum](https://www.adaptavist.com/dpa).

## AI features

ScriptRunner Connect offers an AI-assistant feature that uses OpenAI's GPT models to provide its services. This feature is opt-in, meaning it is only available with your explicit consent.

ScriptRunner Connect stores the AI assistant chat history for functional purposes only; no user data is processed or permanently stored.

The app does not use your code or any other personal data to train the models. However, if you copy and paste your own proprietary code into the AI chat prompt, the chat content will be sent to a third party, OpenAI, for processing. All interactions with OpenAI are secure, and user data is handled in accordance with our [privacy policy](https://www.theadaptavistgroup.com/policy/privacy?_gl=1*1hdgrpx*_gcl_au*MjA4NDk3NjM4NC4xNzMyMDk5NDQ3*_ga*NDk1MzY2ODEyLjE3MDczMDIxMDA.*_ga_E36BNDVDTN*MTczMzg1MDQzOS42OS4wLjE3MzM4NTA0MzkuNjAuMC4xNjAxNzIxNTc2), [OpenAI's privacy policy](https://openai.com/policies/privacy-policy), and [OpenAI's data processing addendum.](https://openai.com/policies/data-processing-addendum) 

## Backups

Backups are kept for a minimum of one week. Additional backup copies are stored in accounts other than the host accounts and in another geographic region for enhanced security and disaster recovery. All backups are encrypted to protect your data. In the event of an incident, the RPO (Recovery Point Objective) is no more than 4 hours for critical data and 24 hours for non-critical data (mostly logs).

## Multi-factor authentication

ScriptRunner Connect offers Multi-Factor Authentication (MFA) to enhance the app's security. 

Multi-factor authentication (MFA) is a multi-step login process that enhances security by requiring users to provide more information than just a username and password. To log in with MFA enabled, users will use a one-time password (OTP) generated from an authenticator app. Popular options include Authy, Google Authenticator, Auth0 Guardian, and Microsoft Authenticator, all of which can be downloaded from the Google Play Store or Apple App Store.

Users receive a prompt to enable MFA when they sign up for the app. MFA preferences can be managed under user profile settings:

![](/src/files/latest/194676702/266700667/1/1719511208000/MFA-toggle.png)

## Conclusion

At ScriptRunner Connect, we deeply understand the significance of security, privacy, reliability, and trustworthiness in our digital era. Our steadfast values in these domains drive us to continuously refine our practices and maintain stringent security and privacy controls. The measures outlined in this document underscore our commitment to offering a reliable and secure integration platform, giving our customers peace of mind and the freedom to focus on building their business logic for integrations.
