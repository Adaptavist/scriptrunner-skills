# FAQ

- Platform: migration-suite
- Space: SMS
- Hierarchy: ScriptRunner Migration Suite Web App > Projects
- Doc ID: doc-sms-2861da61-80f2-455f-afc7-06cae46396d2-b900336a0eb0c7ea
- Source: https://docs.adaptavist.com/sms/latest/scriptrunner-migration-suite-web-app/projects#concept-7838--en

Find answers to commonly asked questions about Projects here.

Q: How is a user's organization determined (e.g. email domain, Atlassian site/organization, invitation)?

A: A user's organization is determined by their email address and company domain that email address is associated with.

Q: Is there an admin role at all?

A: There is no admin role for organization members at the moment. Any organization management requests can be made to our support team.

Q: Can one user belong to more than one organization, and how do we switch between them?

A: We are working on a feature where organization members can request people with different email domains join their organization. This same feature will make it so that users can belong to multiple organizations and switch betweenthem in app through a toggle in the left-hand menu. You will be able to select if users who are added from a different email domain will be in a private or organization Project.

Q: When a Project is shared with the organization, can all members edit it (add chats, run analyses, rename/delete the Project), or is it view-only for anyone other than the creator?

A: If a Project is shared with the organization, the chats become read only. The owner can send messages, stop the agent, or delete it. Anyone else can read the conversation and open its files.

Non-owners can add new chats to the shared Project, run analyses, convert existing scripts from within the existing scripts in the shared Projects. However, they don't have the permissions to rename or delete the Project.

Q: Is it possible to share a Project with specific users or groups only, rather than the whole organization?

A: Not at the moment, but sharing with specific users is a planned feature.

Q: Can Project ownership be transferred, e.g. when a team member leaves?

A: No. Please contact support for help with this.

Q: If a shared Project is set back to Only me, what happens to the chats and analyses other members added to it?

A: They will not see them. Only the Project owner will see them.

Q: Are chats and analyses created by one member visible to others in a shared Project, including the full conversation history and analysis results?

A: Yes. Chats and analysis in a shared Project are visible to anyone in the organization including the full conversation history and analysis results.

Q: Are API keys personal or organization-wide, and can they be used by other members or for automation?

A: Personal. Keys are "personal credentials for scripts and integrations" that use the ScriptRunner Migration Suite API, so they can be used for automation. They inherit your access, expire after 1 day, 30 days, 90 days, 180 days or 1 year, and can be revoked.

An API key is personal, so it shouldn't be shared.

Q: Is there an audit log showing who changed what in a shared Project?

A: No audit log feature on an organization level exists at this time.

Q: Are finer-grained roles (viewer/editor/admin), comments or task assignment within Projects available?

A: Not at the moment, though more granular permissions options are planned.
