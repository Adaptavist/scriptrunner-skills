# FAQ

- Platform: migration-suite
- Space: SMS
- Hierarchy: scriptrunner-migration-suite-web-app > scriptrunner-migration-analyse-and-assess-tool
- Doc ID: doc-sms-578290149
- Source: https://docs.adaptavist.com/sms/latest/scriptrunner-migration-suite-web-app/scriptrunner-migration-analyse-and-assess-tool/faq

Check out the answers to frequently asked questions: 

**Q: Does the ScriptRunner Migration Assess and Analyse Tool use AI?**

A: No. It’s classic deterministic software; the output is designed to feed AI agents if/when you want them, but no “AI” is baked into this tool.

**Q: Will the ScriptRunner Migration Assess and Analyse Tool rewrite my scripts?**

A: Not this tool. It tells you how feasible a rewrite is and points to Cloud equivalents. Use the [ScriptRunner Migration Agent](https://docs.adaptavist.com/sms/latest/scriptrunner-migration-suite-web-app/scriptrunner-migration-agent) to help rewrite your scripts.

**Q: Can we contribute our own rules and heuristics?**

A: Yes, we are aiming to create simple abstractions so additional analysers can be added quickly, without intimate knowledge of the Groovy compiler and tooling.

**Q: How can the ScriptRunner Migration Suite help you?**

-   Analysing and assessing scripts and configurations for Cloud readiness.
-   Simplifies and speeds up every stage of the ScriptRunner migration process:
    -   Makes script rewriting a lot faster.
    -   Less time = more projects = increased revenue.  
        
-   Reduces Risk: 
    -   Staged deployment enables dry runs and sign-offs to test your scripts before they land on any live environments.
-   Early access to migration support:
    -   Use ScriptRunner Intelligence (AI) for context-aware answers and helpful guidance on migrations, script conversion, and reporting well beyond what's feasible with manual analysis today.

**Q: Does the ScriptRunner Migration Suite replace the need for a technical consultant:**

A: No, it does not replace the need for a Technical Consultant. Instead, it aims to empower Technical Consultants by enhancing their productivity, reducing the time spent on script migration, and allowing them to focus on tasks that matter most.

**Q: Where can I access the terms and conditions?**

A: Select **EULA & Terms** in the left navigation to access the _Terms of Service_. Links appear for the [Terms and Conditions](https://www.theadaptavistgroup.com/policy/terms), [Privacy Policy](https://www.theadaptavistgroup.com/policy/privacy), [EULA](https://www.theadaptavistgroup.com/policy/adaptavist-eula), and [Legal Notice](https://www.theadaptavistgroup.com/policy/legal-notice). By using this tool, you agree to the terms. 

**Q: Why can’t I access or use the ScriptRunner Migration Suite on my phone or tablet?**

A: The ScriptRunner Migration Suite is a web application specifically designed and optimised for desktop browsers (Windows, macOS, Linux). It’s not optimised for mobile devices (smartphones or tablets). To experience the intended functionality and full capabilities, please ensure you’re accessing it on a desktop browser and not a mobile device.

**Q: Can ScriptRunner Migration Suite give a migration time estimate?**

A: Every migration is different - the level of effort depends on your team, their experience, and your specific usage of ScriptRunner - so ScriptRunner Migration Suite doesn’t yet provide a fixed time estimate. That said, we’re currently running trials on real migrations, and in future this data may help surface high-level predictions.  
  
What ScriptRunner Migration Suite does provide is data to feed into your own estimation process, whether you’re working with an Atlassian partner or planning independently. A migration involves more than just converting and rewriting scripts, so our aim is to give you the information you need to plan with confidence from the start.  
  
ScriptRunner Migration Suite uses a migration readiness grading system. Each configuration or script is classified into one of three categories:

-   -   Critical findings - these scripts or configurations likely have no direct feature parity in Cloud, or may need a significantly different approach. They typically require the highest relative investment to migrate.
    -   Review findings - these are highly likely to be replicable in Cloud, but may need minor tweaks and verification, particularly around areas like permission management. These require relatively more effort than Info findings, but should transfer to Cloud with the same functionality.
    -   Info findings (no warning/critical) - these should transfer to Cloud without any change in functionality or behaviour. They’ll still need converting, and the Migration Agent - using ScriptRunner Intelligence, purpose-built for ScriptRunner and Jira Cloud APIs - can support that conversion.
