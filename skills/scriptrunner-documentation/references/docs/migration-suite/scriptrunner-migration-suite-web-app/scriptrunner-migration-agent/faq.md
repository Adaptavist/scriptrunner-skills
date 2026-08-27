# FAQ

- Platform: migration-suite
- Space: SMS
- Hierarchy: scriptrunner-migration-suite-web-app > scriptrunner-migration-agent
- Doc ID: doc-sms-448135901
- Source: https://docs.adaptavist.com/sms/latest/scriptrunner-migration-suite-web-app/scriptrunner-migration-agent/faq

Check out the answers to frequently asked questions: 

**Q: Can the ScriptRunner Migration Agent actually test the code?**

A: No, it can't connect to live Jira instances or execute code. But it validates syntax, checks for type errors, and bases everything on verified API documentation.

**Q: How do I know the code actually works?**

A: The ScriptRunner Migration Agent researches every API call, validates syntax automatically, and follows ScriptRunner best practices. However, you should always test in a development environment first.

**Q: What if the code has errors when I copy it into my Jira instance?**

A: The ScriptRunner Migration Agent automatically checks for syntax errors, but runtime issues can still occur. Always test in development first, and the ScriptRunner Migration Agent can help debug issues when they arise.

**Q: How long does it take to get a solution?**

A: Simple scripts take a few minutes. Complex solutions take longer as the ScriptRunner Migration Agent researches APIs and validates everything thoroughly.

**Q: What's the difference between HAPI and REST API approaches?**

A: HAPI is a simplified Groovy language designed specifically for ScriptRunner (for example, `Issues.getByKey('KEY-1').update { setSummary('New title') }`). The ScriptRunner Migration Agent uses HAPI whenever possible and only falls back to REST API calls when HAPI doesn't provide the needed functionality.

**Q: Can the ScriptRunner Migration Agent help with Jira expressions for workflow conditions?**

A: Yes! Workflow conditions and validators use Jira expressions (JavaScript-like syntax), not Groovy. The ScriptRunner Migration Agent generates these expressions for conditions that control when transitions are available and validators that check data before transitions.

**Q: How does the ScriptRunner Migration Agent ensure the code uses current APIs?**

A: The ScriptRunner Migration Agent researches current API documentation, including Atlassian REST API, performs detailed lookups to verify methods and parameters, and validates all generated code before providing it. This ensures you get up-to-date, working implementations.

**Q: How can the ScriptRunner Migration Suite help you?**

A: Accelerates migration projects: Makes script rewriting a lot faster. Less time = more projects = increased revenue.  
Reduces Risk: Staged deployment enables dry runs and sign-offs to test your scripts before they land on any live environments.  
Early access to migration support: Use ScriptRunner Intelligence (AI) for context-aware answers and helpful guidance on migrations, script conversion, and reporting well beyond what's feasible with manual analysis today.

**Q: Does the ScriptRunner Migration Suite replace the need for a technical consultant?**

A: No, it does not replace the need for a Technical Consultant. Instead, it aims to empower Technical Consultants by enhancing their productivity, reducing the time spent on script migration, and allowing them to focus on tasks that matter most.

**Q: Which provider powers the Migration Agent's AI?**

A: Anthropic and OpenAI.

**Q: How does the Migration Agent use and store the data from the prompts I provide?**

A: Please note that we will share the following data with our AI service provider(s) to enable the functionality of this tool:  
What you have entered into the text box—to protect your privacy, we recommend not inputting personal or sensitive data unnecessarily.  
No issue data will be shared with our AI provider(s).  
By using this tool, you agree to the terms of:  
[The Adaptavist Group's EULA](https://www.theadaptavistgroup.com/policy/adaptavist-eula "https://www.theadaptavistgroup.com/policy/adaptavist-eula")  
[Adaptavist's DPA](https://trust.theadaptavistgroup.com/resources?s=aq4zoo2n8zxfvfj6883wo&name=data-processing-addendum-adaptavist-march-2024-.pdf) and [Privacy Policy](https://www.theadaptavistgroup.com/policy/privacy "https://www.theadaptavistgroup.com/policy/privacy")  
As well as specific addendums and supplementary terms which apply for this product:  
[ScriptRunner Migration Suite EULA Addendum](https://www.theadaptavistgroup.com/policy/annexe-to-adaptavist-eula-for-scriptrunner-migration-suite-sms "https://www.theadaptavistgroup.com/policy/annexe-to-adaptavist-eula-for-scriptrunner-migration-suite-sms")  
[ScriptRunner Migration Suite DPA Addendum](https://static.adaptavistassets.com/downloads/Supplement-to-DPA-for-ScriptRunner-Migration-Suite.pdf "https://static.adaptavistassets.com/downloads/Supplement-to-DPA-for-ScriptRunner-Migration-Suite.pdf")  
Please note, as indicated in the ScriptRunner Migration Suite EULA addendum, that we will share data you provide in ScriptRunner Migration Suite with our AI service provider(s) to enable the ScriptRunner Migration Suite functionality.  
To protect your privacy, you should not input personal or sensitive data.  
You must agree to and abide by relevant AI provider-specific terms which are referenced in the ScriptRunner Migration Suite EULA Addendum document.  
ScriptRunner Migration Suite does not automatically integrate with ScriptRunner or Jira. Therefore, Jira issue or product data, or ScriptRunner scripts, will not be shared with our AI provider(s) unless you actively upload or import this information into ScriptRunner Migration Suite.

**Q: Does the Migration Agent retain or learn from the scripts I provide?**

A: No - we do not use your prompts or scripts to train or fine-tune the Agent. Inputs are used to generate results for your session only.

**Q: Where can I access the terms and conditions?**

A: Select **EULA & Terms** in the left navigation to access the _Terms of Service_. Links appear for the [Terms and Conditions](https://www.theadaptavistgroup.com/policy/terms), [Privacy Policy](https://www.theadaptavistgroup.com/policy/privacy), [EULA](https://www.theadaptavistgroup.com/policy/adaptavist-eula), and [Legal Notice](https://www.theadaptavistgroup.com/policy/legal-notice). By using this tool, you agree to the terms. 

**Q:** **Why can’t I access or use the ScriptRunner Migration Suite on my phone or tablet?**

A: The ScriptRunner Migration Suite is a web application specifically designed and optimised for desktop browsers (Windows, macOS, Linux). It’s not optimised for mobile devices (smartphones or tablets). To experience the intended functionality and full capabilities of ScriptRunner Migration Suite, please ensure you’re accessing it on a desktop browser and not a mobile device.
