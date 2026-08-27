# Script Execution

- Platform: confluence-cloud
- Space: SR4CC
- Hierarchy: get-started > general-information
- Doc ID: doc-sr4cc-114204787
- Source: https://docs.adaptavist.com/sr4cc/latest/get-started/general-information/script-execution

## Asynchronous Execution

Asynchronous execution is at the center of the Atlassian Connect Framework that ScriptRunner must use to extend Confluence Cloud. Confluence fires webhooks when events occur, and any user interface elements are loaded in iframes. It is impossible to veto, cancel, or otherwise prevent Confluence from executing an action using ScriptRunner. Scripts are written synchronously, meaning REST API calls are made in a blocking style (although asynchronous methods are provided). [This page](https://developer.atlassian.com/cloud/confluence/integrating-with-confluence-cloud/) has an excellent introduction to the Atlassian Connect framework if you are interested.

## Isolated Execution

All user-provided code executes in an isolated container. ScriptRunner for Confluence Cloud is a service that many customers share, so isolation is essential when executing scripts. Isolation is a goal that has been core to the design of ScriptRunner for Confluence from its inception. Each customer has a container that is theirs and theirs only. The code of one customer can't run in the container of another.  
Containers are designed to be single-use. However, containers may be re-used for execution occasionally, but script writers should not rely on this. Disk storage in these containers is short, and any changes written to the disk are discarded.
