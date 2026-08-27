# AI Training and Usage

- Platform: migration-suite
- Space: SMS
- Hierarchy: scriptrunner-migration-suite-web-app
- Doc ID: doc-sms-524228818
- Source: https://docs.adaptavist.com/sms/latest/scriptrunner-migration-suite-web-app/ai-training-and-usage

For in depth information about data privacy, please read our terms and conditions. By using this tool, you agree to the terms of:

-   [The Adaptavist Group's EULA](https://www.theadaptavistgroup.com/policy/adaptavist-eula "https://www.theadaptavistgroup.com/policy/adaptavist-eula")
-   [Adaptavist's DPA](https://trust.theadaptavistgroup.com/resources?s=aq4zoo2n8zxfvfj6883wo&name=data-processing-addendum-adaptavist-march-2024-.pdf) and [Privacy Policy](https://www.theadaptavistgroup.com/policy/privacy "https://www.theadaptavistgroup.com/policy/privacy")
-   Specific addendums and supplementary terms which apply for this product:  
    -   [ScriptRunner Migration Suite EULA Addendum](https://www.theadaptavistgroup.com/policy/annexe-to-adaptavist-eula-for-scriptrunner-migration-suite-sms "https://www.theadaptavistgroup.com/policy/annexe-to-adaptavist-eula-for-scriptrunner-migration-suite-sms")
    -   [ScriptRunner Migration Suite DPA Addendum](https://static.adaptavistassets.com/downloads/Supplement-to-DPA-for-ScriptRunner-Migration-Suite.pdf "https://static.adaptavistassets.com/downloads/Supplement-to-DPA-for-ScriptRunner-Migration-Suite.pdf")
-   [Legal Notice](https://www.theadaptavistgroup.com/policy/legal-notice)

## AI models

We _do not_ train custom AI models with your use of the tool or your data. ScriptRunner Migration Suite is powered by models provided by third parties. Currently, it is powered by Claude 4.6 Sonnet from Anthropic. View more about Anthropic [below](#id-.AITraining,Ownership,andProcessingvCurrent-anthropi).

-   **Assess and Analyse Tool**: This tool does not use AI. It’s deterministic software. The output is designed to feed AI agents if/when you want them, but no AI is baked into this tool.
-   **ScriptRunner Migration Agent**: We do not train custom AI models for the Migration Agent. We do not use your prompts or scripts to train or fine tune the underlying model powering the Migration Agent. Inputs are used to generate results for your session only. OpenAI is used for generating chat titles and to power searches of ScriptRunner documentation and other sources via the OpenAI embeddings API.

ScriptRunner Migration Suite does not automatically integrate with ScriptRunner or Jira. Jira issue data, product data, and ScriptRunner scripts will not be shared with our AI provider(s) unless you actively upload or import this information into ScriptRunner Migration Suite.

## How your AI-generated content is shared 

Please read our [Privacy Policy](https://www.theadaptavistgroup.com/policy/privacy), [The Adaptavist Group's EULA](https://www.theadaptavistgroup.com/policy/adaptavist-eula "https://www.theadaptavistgroup.com/policy/adaptavist-eula"), and the [ScriptRunner Migration Suite EULA Addendum](https://www.theadaptavistgroup.com/policy/annexe-to-adaptavist-eula-for-scriptrunner-migration-suite-sms) for in-depth information regarding sharing and ownership of data. Additionally, view Anthropic's [Usage Policy.](https://www.anthropic.com/legal/aup)

Anthropic powers the Migration Agent's AI. We will share what you have entered into the text box with our AI service provider(s) to enable the functionality of this tool. Please do not input personal or sensitive data unnecessarily. Additionally, no issue data will be shared with our AI provider(s).

What happens to your data after AI processing

Please review the [Privacy Policy](https://www.theadaptavistgroup.com/policy/privacy) for more information.

## How to evaluate AI output

AI output is provided "as is" and may contain inaccuracies or incomplete information. We recommend that you evaluate and verify any output. Please read the [ScriptRunner Migration Suite EULA Addendum](https://www.theadaptavistgroup.com/policy/annexe-to-adaptavist-eula-for-scriptrunner-migration-suite-sms "https://www.theadaptavistgroup.com/policy/annexe-to-adaptavist-eula-for-scriptrunner-migration-suite-sms") for more information.

Use these methods to evaluate and verify output from the ScriptRunner Migration Suite Web App: 

-   Always test output in your sandbox in Jira Cloud first
-   Review code before deploying to production
-   Ask the Migration Agent to explain its reasoning if you are unsure of an answer
-   Challenge suggestions from the Migration Agent that seem wrong
-   Use version control in your Jira Cloud instance so you can roll back changes if needed
-   Monitor execution history in your Jira Cloud instance after deployment

### When the Migration Agent makes mistakes

The Migration Agent has validation checks to catch syntax and type errors but not logic errors. Test and review everything given to you by the ScriptRunner Migration Suite Web App. You can also ask the Migration Agent questions and challenge it to make sure your content is correct. Always follow the best practices on this page and in the [Best Practices for the ScriptRunner Migration Agent](https://docs.adaptavist.com/sms/latest/scriptrunner-migration-suite-web-app/scriptrunner-migration-agent/best-practices).

The Migration Agent is here to assist you, not dictate what you put in your instance. If you receive advice that won't work on your instance or is incorrect, you can ask the Migration Agent to modify the suggestion or take a different approach.

### Performance

The Migration Agent does not affect your Jira performance because it is a separate AI-assistant tool that runs outside of your instance. Depending on the size and complexity of scripts, they could slow down your Jira instance. To make sure scripts won't slow down your instance, test your scripts and follow [Rewrite Scripts for Cloud Hints and Tips](https://docs.adaptavist.com/sr4jc/current/scriptrunner-migration-to-cloud/rewrite-scripts-for-cloud-hints-and-tips).  

## Why the Migration Agent is better at helping you migrate

Check out our [How ScriptRunner Migration Suite outperforms generic AI in Cloud migrations](https://www.scriptrunnerhq.com/inspiration/blog/how-scriptrunner-migration-suite-outperforms-generic-ai-in-cloud-migrations) blog post for an in depth explanation of how the ScriptRunner Migration Suite performance stacks up against OpenAI’s Codex, and get a closer insight into what puts ScriptRunner Migration Suite ahead of generic AI when it comes to script conversion.

Unlike manual migration or generic tooling, the Migration Agent is specialized specifically for converting ScriptRunner Data Center scripts to Cloud using ScriptRunner Intelligence (AI). To help you easily create, convert, and optimize Data Center to Cloud scripts, this custom-built agent is specialized to:

-   Research current ScriptRunner and Jira API docs
-   Perform recursive lookups
-   Validate generated code

Check out the [Migrate to Cloud Using the ScriptRunner Migration Suite](https://docs.adaptavist.com/sms/latest/migrate-to-cloud-using-the-scriptrunner-migration-suite) and [FAQ: Migration and ScriptRunner Migration Suite](https://docs.adaptavist.com/sms/latest/migrate-to-cloud-using-the-scriptrunner-migration-suite/faq-migration-and-scriptrunner-migration-suite) pages to learn more about using ScriptRunner Migration Suite during your migration. 

## Need help?

If you have questions or need more information, please reach out to [customer support](https://the-adaptavist-group-support.atlassian.net/servicedesk/customer/portal/1069/user/login?destination=portal%2F1069).
