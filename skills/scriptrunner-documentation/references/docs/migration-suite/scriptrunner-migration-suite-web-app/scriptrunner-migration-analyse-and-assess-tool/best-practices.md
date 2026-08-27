# Best Practices

- Platform: migration-suite
- Space: SMS
- Hierarchy: scriptrunner-migration-suite-web-app > scriptrunner-migration-analyse-and-assess-tool
- Doc ID: doc-sms-448135877
- Source: https://docs.adaptavist.com/sms/latest/scriptrunner-migration-suite-web-app/scriptrunner-migration-analyse-and-assess-tool/best-practices

## Convert scripts best practices

Use the following tips when rewriting your scripts:

-   Create a list of in instance-critical scripts. From there, you can prioritize based on readiness. Focus on _INFO_ scripts first, then move to _WARNING_ scripts and leave _BLOCKER_ scripts last.
    
-   When converting your scripts to Cloud use our [Migration Agent](https://docs.adaptavist.com/sms/latest/scriptrunner-migration-suite-web-app/scriptrunner-migration-agent). This can be accessed through the _Agent_ tab.
    
-   For any scripts with blockers that can’t be fixed, consider if you need the script/configuration. Consider if it can be removed completely or replaced with a native Jira solution.
    
-   House your scripts in an external IDE so they’re easy to manage and iterate on.
    

## Embrace Cloud-native solutions

Instead of direct script translations, especially for _BLOCKER_ items, reassess the underlying business needs and explore Cloud-native features. The migration agent can explain what a script does, especially if you inherited it or no longer remember an older script

## Use iterative migration and testing processes

Implement a phased migration approach, moving and testing scripts in small batches. This allows for continuous improvement and reduces risk during the transition.

For example:

-   Phase 1: Migrate mission critical scripts to establish core functionality quickly.
    
-   Phase 2: Address important scripts, adapting as necessary for Cloud.
    
-   Phase 3: Tackle nice-to-have scripts.
