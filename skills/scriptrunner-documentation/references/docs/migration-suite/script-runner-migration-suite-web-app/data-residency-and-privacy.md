# Data Residency and Privacy

- Platform: migration-suite
- Space: SMS
- Hierarchy: ScriptRunner Migration Suite Web App
- Doc ID: doc-sms-727a198b-44f8-4d26-a391-6bac2921ab58-251e04a1a7b3ae2c
- Source: https://docs.adaptavist.com/sms/latest/scriptrunner-migration-suite-web-app/data-residency-and-privacy

There are two main sections of this page:

-   [Data residency](https://docs.adaptavist.com/sms/latest/scriptrunner-migration-suite-web-app/data-residency-and-privacy#data-residency--en): Visit this section to learn about how data is stored and pinned.
-   [Security and privacy](https://docs.adaptavist.com/sms/latest/scriptrunner-migration-suite-web-app/data-residency-and-privacy#our-commitment-to-security-and-privacy--en): Visit this section to learn about The Adaptavist Group's commitment to security and privacy.

## Data Residency

Data residency gives you control over where your in-scope data for the ScriptRunner Migration Suite is hosted. It allows you to choose where it is held, either the European Union (EU) or the United States (US). However, the Migration Agent workloads will be processed by Anthropic in their datacenters in various regions.

If you work in a regulated industry like finance, government, or healthcare, data residency may be a necessity for operating in a cloud environment. More generally, it can also help you meet company data management requirements.

### Choose where your data is hosted

You can select your preferred data residency region when you first sign in:

-   European Union: Choose _European Union_ for AWS Data Centers within the EU juridsiction. If you require your in-scope data to stay within the European Union, you can select the European Union region. When this option is selected, your data is held in Frankfurt, Germany. The Migration Agent workloads are processed by Anthropic in their own regions and data centers.
-   United States: Choose _United States_ for AWS Data Centers in the United States. When this option is selected, your data is held in Oregon. The Migration Agent workloads are processed by Anthropic in their own regions and data centers.
    

### Change where your data is stored

Region selection is per-user. You can switch regions instantly at any time using the region selector. To navigate to the region selector, select the icon next to your username, and then select Switch Region.  
  

The Switch region dialog box appears, where you can choose:  
  

When you switch regions:

-   The change takes effect immediately.
-   No data is transferred between regions.
-   You will only see data created in the selected region.
-   Data created in other regions remains accessible by switching back.
-   Log in credentials won't be carried over between regions.

This design allows users who work with data across multiple regions to easily switch context as needed.

### What data can be pinned?

Tip: "Pinned" means that data is stored and can be fixed to a region.

This table lists in-scope data types that can be pinned and out-of-scope data that cannot be pinned:

| ✓ Can be pinned | ✗ Cannot be pinned |
| --- | --- |
| [ScriptRunner Migration Agent](script-runner-migration-agent.md) chat history | AI data in transit |
| [ScriptRunner Migration Agent](script-runner-migration-agent.md) conversation context | User analytics |
| AI response data |  |
| User account information |  |
| Migration Analyser data |  |
| Operational logs |  |

#### User account information

ScriptRunner Migration Suite stores the usernames and email as personally identifiable information (PII) directly.

#### Migration Analyser data

The [ScriptRunner Migration Analyse and Assess Tool](script-runner-migration-analyse-and-assess-tool.md) results are stored server-side and managed in the same way as chat history, with full data residency pinning available based on your selected region.

The Migration Analyser does not utilise any AI or ScriptRunner Intelligence powered services.

### How does data residency work for ScriptRunner Intelligence?

ScriptRunner Intelligence-powered features, such as the Migration Agent, use [Anthropic](https://www.anthropic.com/) as our third-party AI provider. Your data is never used to train AI models. Anthropic is discussed in the [Adaptavist Data Processing Amendum](https://www.theadaptavistgroup.com/policy/dpa).

However, data processing for AI interactions may occur in any global region where Anthropic operates. Pinning is not possible for in-flight interactions with AI-powered features. Once responses are received, they are stored as part of your chat history in accordance with your selected data residency region.

## Our commitment to security and privacy

For more information about our security practices and compliance certifications, visit the [Adaptavist Trust Centre](https://www.adaptavist.com/trust).

### Data security: Encryption at rest

All data stored in the ScriptRunner Migration Suite is encrypted at rest using AES-256, a widely tested, highly performant, and industry-standard encryption algorithm. Encryption and decryption are automatic and do not require user configuration.

### Data retention

Chat history and conversation data is retained indefinitely until you choose to delete it.

### Delete your data

You can delete individual chats from the chat interface.

## Future enhancements

We will explore additional regions and enhance our data residency capabilities on an ongoing basis, based on user feedback. If you have specific data residency requirements, please [contact us](https://the-adaptavist-group-support.atlassian.net/servicedesk/customer/portal/1069/user/login?destination=portal%2F1069).

## Glossary

| Term | Definition |
| --- | --- |
| Chat history | Conversation data from interactions with the Migration Agent, including user messages and AI responses. |
| Jurisdiction restriction | AWS resources are only stored in the judicial region that you have selected, including backups which are stored in an AWS account in another region, but still in the same judiciary. |
| [Migration Agent](script-runner-migration-agent.md) | ScriptRunner Migration Suite's AI-powered assistant that helps with ScriptRunner migration questions and script conversion. |
| [Migration Analyser](script-runner-migration-analyse-and-assess-tool.md) | A tool that processes ScriptRunner configuration exports to assess migration readiness. |
| Operational logs | System logs used for operational maintenance and diagnostic purposes. |
| User analytics | Events used for in-app user experience optimisation and performance. |
