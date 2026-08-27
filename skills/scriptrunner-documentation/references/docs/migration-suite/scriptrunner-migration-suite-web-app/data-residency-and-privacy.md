# Data Residency and Privacy

- Platform: migration-suite
- Space: SMS
- Hierarchy: scriptrunner-migration-suite-web-app
- Doc ID: doc-sms-484576458
- Source: https://docs.adaptavist.com/sms/latest/scriptrunner-migration-suite-web-app/data-residency-and-privacy

There are two main sections of this page:

-   [Data residency](#id-.DataResidencyvCurrent-res): Visit this section to learn about how data is stored and pinned. 
-   [Security and privacy](#id-.DataResidencyvCurrent-security): Visit this section to learn about The Adaptavist Group's commitment to security and privacy. 

## Data Residency 

Data residency gives you control over where your in-scope data for the ScriptRunner Migration Suite is hosted. It allows you to choose whether it's globally distributed or held in place in a defined geographic location, such as the European Union (EU).

If you work in a regulated industry like finance, government, or healthcare, data residency may be a necessity for operating in a cloud environment. More generally, it can also help you meet company data management requirements.

### Choose where your data is hosted

You can select your preferred data residency region when you first sign in:

![](/sms/files/latest/484576458/484576462/1/1765317667000/region.png)

-   **Global**: Choose _Global_ for all Cloudfare Data Centers worldwide. By default, ScriptRunner Migration Suite operates in the Global region, which includes all Cloudflare Data Centers worldwide. For these users, we dynamically determine where data is located and optimise performance by placing data close to where it is accessed.
-   **European Union**: Choose _European Union_ for Cloudcare Data Centers within the EU juridsiction. If you require your in-scope data to stay within the European Union, you can select the European Union region. When this option is selected, ScriptRunner Migration Suite uses Cloudflare's jurisdiction restrictions to ensure that in-scope data only runs and persists within EU data centers.

### Change where your data is stored

Region selection is per-user. You can switch regions instantly at any time using the region selector in the top navigation:

![](/sms/files/latest/484576458/484576459/1/1765478635000/region-selector.png)

When you switch regions:

-   The change takes effect immediately.
    
-   No data is transferred between regions.
    
-   You will only see data created in the selected region.
    
-   Data created in other regions remains accessible by switching back.
    

This design allows users who work with data across multiple regions to easily switch context as needed.

### What data can be pinned?

"Pinned" means that data is stored and can be fixed to a region.

This table lists in-scope data types that can be pinned and out-of-scope data that cannot be pinned:

![check mark button](/plugins/servlet/twitterEmojiRedirector?id=2705 "check mark button") Can be pinned

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg) Cannot be pinned

[Migration Agent](https://docs.adaptavist.com/sms/latest/scriptrunner-migration-suite-web-app/scriptrunner-migration-agent) chat history

User account information

[Migration Agent](https://docs.adaptavist.com/sms/latest/scriptrunner-migration-suite-web-app/scriptrunner-migration-agent) conversation context

Migration Analyser data

AI response data

AI data in transit

  

Operational logs

  

User analytics

#### User account information

ScriptRunner Migration Suite uses [Clerk](https://clerk.com/legal/privacy) as our identity provider. User account information, including name, email address, and avatar, is stored and managed by Clerk's central identity service. ScriptRunner Migration Suite does not store any personally identifiable information (PII) directly. We only reference masked unique identifiers which we use to resolve user details from Clerk on demand.

For information on where and how Clerk stores user data, visit [Clerk's Privacy Policy](https://clerk.com/legal/privacy) and [Data Processing Addendum](https://clerk.com/legal/dpa).

#### Migration Analyser data

The [Migration Analyser](https://docs.adaptavist.com/sms/latest/scriptrunner-migration-suite-web-app/scriptrunner-migration-analyse-and-assess-tool) processes ScriptRunner configuration exports to assess migration readiness. Processing occurs in AWS us-east-1, but no data is retained server-side. All analysis results are stored locally in your browser using IndexedDB. Since this data never persists on our servers, data residency pinning does not apply.

The Migration Analyser **does not** utilise any AI or ScriptRunner Intelligence powered services.

Coming soon

Migration Analyser results will soon be stored server-side and managed in the same way as chat history, with full data residency pinning available based on your selected region.

### How does data residency work for ScriptRunner Intelligence?

ScriptRunner Intelligence-powered features, such as the Migration Agent, use [Anthropic](https://www.anthropic.com/) as our third-party AI provider. [OpenAI](https://openai.com/about/) is used for generating chat titles and to power searches of ScriptRunner documentation and other sources via the OpenAI embeddings API. Your data is never used to train AI models. Both Anthropic and OpenAI are discussed in the [Adaptavist Data Processing Amendum](https://www.theadaptavistgroup.com/policy/dpa).

However, data processing for AI interactions may occur in any global region where Anthropic and OpenAI operate. Pinning is not possible for in-flight interactions with AI-powered features. Once responses are received, they are stored as part of your chat history in accordance with your selected data residency region.

## Our commitment to security and privacy 

For more information about our security practices and compliance certifications, visit the [Adaptavist Trust Centre](https://www.adaptavist.com/trust).

### Data security: Encryption at rest

All data stored in the ScriptRunner Migration Suite is encrypted at rest using AES-256, a widely tested, highly performant, and industry-standard encryption algorithm. Encryption and decryption are automatic and do not require user configuration.

### Data security: Encryption in transit

All data transfer within ScriptRunner Migration Suite is secured using Transport Layer Security (TLS/SSL), which includes:

-   Data transfer between your browser and ScriptRunner Migration Suite
    
-   Data transfer between Cloudflare Workers and Durable Objects
    
-   API access and all network communications
    

### Data retention

Chat history and conversation data is retained indefinitely until you choose to delete it.

### Delete your data

You can delete your data in the following ways:

-   **Delete individual chats**: Remove specific conversations from the chat interface
    
-   **Delete your account**: Self-serve account deletion is available by clicking your user profile icon in the top navigation
    

## Future enhancements

We will explore additional regions and enhance our data residency capabilities on an ongoing basis, based on user feedback. If you have specific data residency requirements, please [contact us](https://the-adaptavist-group-support.atlassian.net/servicedesk/customer/portal/1069/user/login?destination=portal%2F1069).

## Glossary

Term

Definition

Chat history

Conversation data from interactions with the Migration Agent, including user messages and AI responses.

Cloudflare Durable Objects

Cloudflare's serverless stateful storage used by ScriptRunner Migration Suite for persistent data.

Jurisdiction restriction

A Cloudflare feature that ensures Durable Objects only store and process data within a specified geographic region.

[Migration Agent](https://docs.adaptavist.com/sms/latest/scriptrunner-migration-suite-web-app/scriptrunner-migration-agent)

ScriptRunner Migration Suite's AI-powered assistant that helps with ScriptRunner migration questions and script conversion.

[Migration Analyser](https://docs.adaptavist.com/sms/latest/scriptrunner-migration-suite-web-app/scriptrunner-migration-analyse-and-assess-tool)

A tool that processes ScriptRunner configuration exports to assess migration readiness.

Operational logs

System logs used for operational maintenance and diagnostic purposes.

User analytics

Events used for in-app user experience optimisation and performance.
