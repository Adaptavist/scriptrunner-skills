# Connected Apps

- Platform: cloud
- Space: SR4JC
- Hierarchy: manage-app
- Doc ID: doc-sr4jc-128389384
- Source: https://docs.adaptavist.com/sr4jc/latest/manage-app/connected-apps

## ScriptRunner Leap app

The ScriptRunner Leap app is a legitimate Adaptavist application used to facilitate the connection between your Jira Cloud instance and the [ScriptRunner Leap Jira Expression Generator](https://leap.scriptrunnerhq.com/expression?_gl=1*1114qdi*_gcl_au*MzgzNTY2MDgxLjE3NzYzNDM0MzA.*_ga*MzE5ODgwNDI3LjE3NTk5MTYzNTU.*_ga_C6V1F2HSMM*czE3NzcwMTc4NzYkbzI0NyRnMSR0MTc3NzAxODU2OSRqNjAkbDAkaDE4NTI4MjUzOTM.). This allows you to create and explore Jira Expressions used by ScriptRunner features such as [Restrict Transitions](https://docs.adaptavist.com/sr4jc/latest/features/workflow-rules/restrict-transitions) and [Validate Details](https://docs.adaptavist.com/sr4jc/latest/features/workflow-rules/validate-details).

The app is visible in **Jira Settings > Connected apps / Marketplace apps** after a Jira administrator signs in to the [Jira Expression Generator](https://leap.scriptrunnerhq.com/expression?_gl=1*1114qdi*_gcl_au*MzgzNTY2MDgxLjE3NzYzNDM0MzA.*_ga*MzE5ODgwNDI3LjE3NTk5MTYzNTU.*_ga_C6V1F2HSMM*czE3NzcwMTc4NzYkbzI0NyRnMSR0MTc3NzAxODU2OSRqNjAkbDAkaDE4NTI4MjUzOTM.) using Atlassian OAuth and accepts the relevant terms.

![](/sr4jc/files/latest/128389384/537854427/1/1777027433000/leap+app.png)

Marketplace branding

The icon or name of the ScriptRunner Leap app may look different from the standard ScriptRunner marketplace branding, but it is an official Adaptavist app. This can happen because connected OAuth apps may display differently inside Atlassian's Connected Apps area.

### Why am I seeing the ScriptRunner Leap app?

When a user or Jira administrator connects their Jira Cloud instance to the Jira Expression Generator, the app is automatically installed.

During installation, Atlassian OAuth authorization is given to grant the connection. Once approved, the connected app appears in Jira in the same way as other OAuth-connected applications.

### Does ScriptRunner Leap change Jira data?

No. ScriptRunner Leap does not modify data in Jira as part of the connection. It may read metadata such as custom fields, or configuration information to help suggest relevant Jira expressions within the generator.

Refer to our [Data Residency](https://docs.adaptavist.com/sr4jc/latest/get-started/data-residency) section for information related to data storage.

### Can I remove the app?

Yes. The app can be removed safely if you no longer use the Jira Expression Generator connection. Doing so does not impact the core performance or execution of ScriptRunner.

### Security, privacy, and compliance information

For more information about Adaptavist security, privacy, and compliance standards, please refer to:

-   [The Adaptavist Group Trust Centre](https://www.theadaptavistgroup.com/trust-and-security "https://www.theadaptavistgroup.com/trust-and-security")
    
-   [Adaptavist EULA](https://www.theadaptavistgroup.com/policy/adaptavist-eula "https://www.theadaptavistgroup.com/policy/adaptavist-eula") (Governs the use of Adaptavist Products)
    
-   [The Adaptavist Group Terms and Conditions](https://www.theadaptavistgroup.com/policy/terms "https://www.theadaptavistgroup.com/policy/terms")
    
-   [The Adaptavist Group Privacy Policy](https://www.theadaptavistgroup.com/policy/privacy "https://www.theadaptavistgroup.com/policy/privacy")
    
-   [The Adaptavist Group Data Processing Addendum](https://www.theadaptavistgroup.com/policy/dpa "https://www.theadaptavistgroup.com/policy/dpa") (Applies to the use of Adaptavist Products)
    
-   [Data Residency docs](https://docs.adaptavist.com/sr4jc/latest/get-started/general-information/data-residency "https://docs.adaptavist.com/sr4jc/latest/get-started/general-information/data-residency") (For Adaptavist Product ScriptRunner Cloud only)
    

### Need more help?

If you need assistance reviewing connected apps or understanding permissions in your Jira Cloud instance please contact [Support](https://the-adaptavist-group-support.atlassian.net/servicedesk/customer/portal/27).
