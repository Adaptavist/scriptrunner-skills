# Security

- Platform: connect
- Space: SRC
- Hierarchy: n/a
- Doc ID: doc-src-ded6dc10-2eab-4f03-89a9-edcd8e44c33d-cdc226ca9d15404e
- Source: https://docs.adaptavist.com/src/latest/security

Learn about the security measures in place for our app.

ScriptRunner Connect, developed by The Adaptavist Group, is a cloud-based, Atlassian-focused, code-first integration Platform as a Service (iPaaS) product. Designed to connect to third-party systems, ScriptRunner Connect enables users to focus on writing business logic in JavaScript or TypeScript, while the ScriptRunner Connect team handles the complexities of infrastructure and security. A key aspect of ScriptRunner Connect's mission is the emphasis on rigorous security standards and privacy protections. To learn more, please visit our [Trust Center.](https://trust.theadaptavistgroup.com/)

## Security measures

ScriptRunner Connect is a multi-tenant SaaS product that ensures the separation of customer data through logical partitioning and robust security checks at our API endpoints. These checks, verified through automated testing, ensure that users can only access data they are authorized to view based on the least-privilege principle.

The app achieved positive results from a penetration test conducted by a third-party, [CREST-certified vendor](https://www.crest-approved.org/).

ScriptRunner Connect is also part of a public [bug bounty program](https://www.bugcrowd.com/).

To proactively identify potential vulnerabilities, we operate vulnerability scanners for third-party packages and ensure all security-related changes are thoroughly peer-reviewed. Our team is also trained in secure coding practices, reinforcing our commitment to maintaining a secure environment.

As we introduce new features, we perform risk assessments that consider reliability and security, ensuring all additions to ScriptRunner Connect meet our high standards.

ScriptRunner Connect utilizes AWS services hosted in EU (Ireland) and US (Oregon). You can choose either hosting option when signing up. However, even when using a US-based instance, your first name, last name, email, company name, and credit card details (if you pay via credit card) are stored in the EU region.

For script executions, ScriptRunner Connect uses [V8 Isolates](https://v8.dev/) technology for secure isolation. Each script execution occurs in a new V8 Isolate, which is immediately destroyed afterwards. This is the same technology that powers [Chromium](https://www.chromium.org/chromium-projects/) -based browsers and is used in shared cloud resources like [Cloudflare Workers](https://workers.cloudflare.com/). This approach ensures the highest level of security while running untrusted JavaScript code. Refer to ScriptRunner Connect's [Runtime](https://docs.adaptavist.com/src/latest/scripting/runtime) user documentation for additional information. For added security, you can optionally enable [enhanced isolation mode](https://docs.adaptavist.com/src/latest/scripting/runtime#enhanced-isolation-mode--en), which will enable per-tenant Lambda isolation by spooling V8 Isolates and running your code within them. This added isolation ensures that, in the unlikely event the V8 Isolate sandbox is compromised, the malicious actor cannot corrupt the runtime environment of Lambda instances exclusively reserved for your team.

Access to ScriptRunner Connect's AWS account and other cloud services is strictly limited to the ScriptRunner Connect engineering team.

We also use private network subnets for added security where appropriate.

## Private cloud hosting

For the strictest requirements, ScriptRunner Connect can run in your own AWS account instead of our shared service. We deploy and maintain it there, so your data and integrations stay in your infrastructure. You can also deploy it into your company's VPC, where it can reach your internal services directly and be cut off from the internet. Private cloud hosting includes single sign-on (SAML, OAuth or LDAP) through Auth0, so it supports the identity providers Auth0 can connect to.

For more, see [Private cloud hosting](https://www.scriptrunnerhq.com/scriptrunner-connect/private-cloud-hosting).

## Data retention and security

Operational and user-facing logs are retained for six months and can only be accessed by the ScriptRunner Connect team. Analytical logs, however, are kept indefinitely, enabling us to understand trends over time and leverage them to improve our service. A broader Adaptavist group can access analytical logs, though PII (Personally Identifiable Information) in analytical logs is anonymized.

In terms of data security, we only use cloud services that offer encryption both at rest and in transit. Sensitive information like end-user authentication keys is additionally encrypted using [AWS KMS](https://aws.amazon.com/kms/) symmetric encryption with key rotation (256-bit AES-GCM). TLS version 1.2 with strong cyphers is used with HTTPS by default.

## Incident management

ScriptRunner Connect features a robust incident-management process, including a post-incident review process that enables learning from prior incidents, as well as various monitoring and alerting systems. Our team also runs automated tests periodically to detect incidents as early as possible.

### Script failure notifications

You may want to be notified if a script execution fails. We've made this simple and easy within our _Email notifications_ section in _Profile settings_.

To enable email notifications:

1.  Click your user profile icon at the bottom of the _left-hand menu_. A list of related options appears.
2.  Click Profile settings.
3.  Scroll down to the _Email notifications_ section.
4.  Toggle _Script failure_ to On.
5.  Select Save Changes.

Note: Custom filtering

If you'd like to customize this process, we offer a public REST API that includes access to the invocation logs. This allows you to filter the information you'd like to receive. For more info, see the [REST API](../r/rest-api.md) section of the documentation.

## Compliance

ScriptRunner Connect is GDPR compliant and [ISO 27001](https://www.iso.org/standard/27001) and [SOC 2 Type 2](https://www.imperva.com/learn/data-security/soc-2-compliance/) certified.

While we aim to reduce the PII (Personally Identifiable Information) data in our logs, we may occasionally temporarily increase our logging levels, which could contain PII data, for troubleshooting.

For further information, you may refer to the following related compliance documents:

-   [AWS](https://aws.amazon.com/compliance/)
    
-   [The Adaptavist Group Terms and Conditions](https://www.theadaptavistgroup.com/policy/terms)
    
-   [The Adaptavist Group Privacy Policy](https://www.theadaptavistgroup.com/policy/privacy)
    
-   [The Adaptavist Group EULA](https://www.theadaptavistgroup.com/policy/adaptavist-eula)
    
    -   [Annexe to The Adaptavist Group EULA](https://www.theadaptavistgroup.com/policy/annexe-to-adaptavist-eula-for-scriptrunner-connect)
        
-   [The Adaptavist Group Data Processing Addendum](https://www.theadaptavistgroup.com/policy/dpa)
    
    -   [Supplement to the Data Processing Addendum](https://cdn.sanity.io/files/qec1bdmb/production/ba361187a8752e8a17885cb2c09597053420f81f.pdf)
        

## AI features

ScriptRunner Connect has an AI agent built into the web app, the embedded agent. It replaces the previous AI assistant, which some teams still see while the embedded agent is being rolled out.

### The embedded agent

-   Models
    -   The embedded agent uses Anthropic's Claude models. You pick the model for each task.
-   When it runs
    -   The embedded agent is available to every team, and it runs only when a member starts a task. A Super Admin can turn it off for the whole team in Team settings > AI agent.
-   What is sent to Anthropic?
    -   Your messages, the files you attach, and what the agent reads to do the work. Scripts, workspace settings and invocation, console and HTTP logs, which can contain data from the systems your integrations connect to. The agent cannot read connector credentials or the values of _Password_ parameters. With limited access, it reads other parameter values only once you approve.
-   Where is it processed?
    -   Calls to the model are not bound to your ScriptRunner Connect region: Anthropic routes them through its global data centres, mainly in the US. Your tasks and attached files are stored in your ScriptRunner Connect region.
-   What is kept?
    -   A task is kept until you delete it. A task with no activity for 180 days is deleted. We do not write your messages or the agent's replies to our logs.
-   Training
    -   We do not train AI models on your data. For how Anthropic handles the data it receives, see Anthropic's commercial terms.
-   Isolation
    -   Each task runs in its own temporary sandbox. The agent acts as you, using a temporary API key that expires within an hour and can be revoked. It can never do more than you can, and with limited access, it does only what the task's access policy grants or you approve. Its changes are recorded in the team's audit log.
-   Controls in each task
    -   Under Security below the message box, you decide whether the agent has internet access, whether it can call your event listeners' URLs, and whether it sends the ScriptRunner Connect team agentic feedback: short notes on what got in its way, without personal data, business data, credentials or script content. Agentic feedback is on by default.
-   Share with us
    -   The ScriptRunner Connect team reads a task only if you share it, with Share chat when you send feedback.

For more, see [Work with the embedded agent](../../work-with-ai-agents/work-with-the-embedded-agent.md).

### The AI assistant

The previous AI assistant uses OpenAI's GPT models and OpenAI's embeddings to search the ScriptRunner Connect documentation.

-   Before it sends the code you selected, it asks you to confirm, until you tick Don't ask me again.
-   Your chat history is stored so you can view your previous conversations.
-   We do not train AI models on your data, including the code you paste into the AI chat prompt. Chat content is sent to OpenAI for processing and handled in line with our privacy policy.

### Private cloud hosting

In private cloud hosting, AI features are off. Upon request, we enable the embedded agent with your own Anthropic API key. Its calls to the model then leave your network and go to Anthropic.

### Checking what AI produces

AI output can be wrong or incomplete. Review the agent's plan before you confirm it, build and test against a non-production environment first, and check the results before you deploy a release to production.

### Terms of use

Your use of the AI features is covered by these terms:

-   [Adaptavist's End User License Agreement](https://www.theadaptavistgroup.com/policy/adaptavist-eula)
-   [Adaptavist's Data Processing Addendum](https://www.theadaptavistgroup.com/policy/dpa) and [privacy policy](https://www.theadaptavistgroup.com/policy/privacy?_gl=1*1hdgrpx*_gcl_au*MjA4NDk3NjM4NC4xNzMyMDk5NDQ3*_ga*NDk1MzY2ODEyLjE3MDczMDIxMDA.*_ga_E36BNDVDTN*MTczMzg1MDQzOS42OS4wLjE3MzM4NTA0MzkuNjAuMC4xNjAxNzIxNTc2)
-   [Anthropic's commercial terms](https://www.anthropic.com/legal/commercial-terms) and [usage policy](https://www.anthropic.com/legal/aup), for the embedded agent
-   OpenAI's [privacy policy](https://openai.com/policies/privacy-policy) and [Data Processing Addendum](https://openai.com/policies/data-processing-addendum), for the AI assistant

## Backups

Backups are kept for a minimum of one week. Additional backup copies are stored in accounts other than the host accounts and in another geographic region for enhanced security and disaster recovery. All backups are encrypted to protect your data. In the event of an incident, the RPO (Recovery Point Objective) is no more than 4 hours for critical data and 24 hours for non-critical data (mostly logs).

## Multi-factor authentication

ScriptRunner Connect offers Multi-Factor Authentication (MFA) to enhance the app's security.

Multi-factor authentication (MFA) is a multi-step login process that enhances security by requiring users to provide more information than just a username and password. To log in with MFA enabled, users will use a one-time password (OTP) generated from an authenticator app. Popular options include Authy, Google Authenticator, Auth0 Guardian, and Microsoft Authenticator, all of which can be downloaded from the Google Play Store or Apple App Store.

Users receive a prompt to enable MFA when they sign up for the app. MFA preferences can be managed under user profile settings:

## Controlling access

Access policies

Limitations to what an API key or an AI agent can do. In which teams, workspaces and environments, and which external API endpoints the scripts it triggers can call.

Egress Firewall

Let your team approve the host scripts that can call. Calls to any other host are blocked.

Fixed outbound IP addresses

Calls from your scripts leave from a single IP address per region, so your firewall can allow them in: `34.251.34.27` in the EU and `35.163.23.171` in the US. A dedicated outbound IP address for your company can be requested separately.

Audit logs

Record every change in a team and who made it, the embedded agent's changes included. They are kept for six months.

Password parameters

Once saved, their values are never displayed or returned by the REST API.

Turn the embedded agent off

A Super Admin can turn off the embedded agent for the whole team, in Team settings > AI agent.

## Conclusion

At ScriptRunner Connect, we deeply understand the significance of security, privacy, reliability, and trustworthiness in our digital era. Our steadfast values in these domains drive us to continuously refine our practices and maintain stringent security and privacy controls. The measures outlined in this document underscore our commitment to offering a reliable and secure integration platform, giving our customers peace of mind and the freedom to focus on building their business logic for integrations.
