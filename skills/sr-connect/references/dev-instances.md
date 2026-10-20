# Getting a non-production instance

Load this when the work has nothing but production to run against, under Which environment in `references/cli-workflow.md`. It says, per app, how the user gets an instance of their own to build in, how long it takes and what it costs. Snapshot 2026-10-17 from each vendor's sign-up, pricing or help pages; offers and limits change, so open the link before quoting a number. The times are estimates: vendors rarely state one.

## When to offer one

Offer it when the work needs to write, probe or test end to end and the only installation the user has is production, or when using production means waiting for someone to grant permissions or create a project. For many apps a free developer instance is minutes away, and building the prototype there is often faster than the permission request. The working integration then moves to production by attaching a production connector in a production environment; nothing in the scripts changes when every project key, channel and ID is a parameter, which the build requires anyway.

Do not offer one when production is a safe partition already, a throwaway project or space the user created for this, or when the user said the work stays on the systems they named. Some organisations forbid personal or unmanaged tenants for company work, so ask, and never copy production data into an instance outside the organisation's control.

## How to offer it

Name the option for each app the work touches, with its time and cost from the table, and what the user does. They sign up and own the account. Driving a browser, you may open the sign-up page for them, but the account, its password and any verification code stay theirs. Then say what the switch costs:

- A connector for the new instance, authorized as under Connector setup in `references/cli-workflow.md`, and its Egress Firewall entry.
- Test data the integration needs: a project, a channel, some issues or records. Offer to create it through the connector once it exists, as a probe the user has agreed to.
- An environment for the instance in the workspace, Development or whatever the user calls it, with the production environment added once the work is confirmed.
- Anything that differs between the two: app-level configuration, custom fields, workflows, plan-gated features. Where the integration depends on one, check the developer instance has it before building there.

Leave the choice to the user. When they decline, carry on under Which environment with a safe partition in production.

## Options by app

| App | What to get | Time | Cost and limits |
| --- | --- | --- | --- |
| Jira Cloud, Jira Service Management Cloud, Confluence Cloud | A free Atlassian developer site, https://go.atlassian.com/cloud-dev, with Jira, Jira Service Management and Confluence on one site | Minutes | Free; 5 users each for Jira and Confluence and 1 Jira Service Management agent; for development and testing only, and Atlassian may delete it without notice; the site name says what it is, which helps the production check later |
| Tempo Cloud | Install it from the Atlassian Marketplace on the developer site above | Minutes after the site | Marketplace free trial, then paid |
| Slack | A new workspace, https://slack.com/get-started#/createnew | Minutes | Free plan, up to 10 app integrations; the creator is its owner and can install the Slack app the connector needs |
| GitHub | A free organization, https://github.com/organizations/plan | Minutes | Free; unlimited private repositories |
| GitLab | A free group on gitlab.com, https://gitlab.com/users/sign_up | Minutes | Free tier: 5 users per private top-level group, 400 compute minutes a month; GitLab-hosted runners need a verified card |
| Bitbucket Cloud | A free workspace, https://www.atlassian.com/try/cloud/signup?bundle=bitbucket | Minutes | Free for up to 5 users, 50 Pipelines build minutes a month |
| Azure DevOps | A free organization, https://azure.microsoft.com/products/devops/, signing in with a Microsoft or GitHub account | Minutes | First 5 Basic users free, Stakeholders free; 1 Microsoft-hosted parallel job with 1,800 minutes a month |
| Salesforce | A Developer Edition org, https://developer.salesforce.com/signup | Minutes, then the Connected App or External Client App propagation wait | Free, and deleted after a stretch without use; a Salesforce sandbox is the alternative when the user's org has one |
| ServiceNow | A Personal Developer Instance, https://developer.servicenow.com | Minutes to hours; there is a queue when demand is high | Free; it hibernates when idle, and one 90 days or older is reclaimed after 10 days without a login to the instance itself (logins to the developer site do not count) |
| Google Sheets, Google Drive, Google Calendar | A separate Google account, https://accounts.google.com/signup, or a test calendar or folder in the user's own account | Minutes | Free |
| Trello | A free workspace, https://trello.com/signup | Minutes | Free for up to 10 collaborators per workspace and 10 boards |
| Zoom | A Basic account, https://zoom.us/signup | Minutes | Basic plan is free, meetings up to 40 minutes; Zoom's pricing lists REST API access under the paid plans, so check the plan has the API features the work needs |
| Statuspage | A free page, https://www.atlassian.com/try/cloud/signup?bundle=statuspage | Minutes | Free plan: 100 subscribers, 25 components, 2 team members, REST API included |
| monday.com | A trial account, https://auth.monday.com/users/sign_up_new | Minutes | 14-day Pro trial; the Free plan has no API calls |
| Zendesk | A trial account, https://www.zendesk.com/register/ | Minutes | 14-day free trial, no credit card |
| Microsoft (Teams) | A Microsoft 365 developer sandbox, https://developer.microsoft.com/microsoft-365/dev-program | Minutes once qualified | Free, but only with Visual Studio Professional or Enterprise, an eligible Microsoft partner program, or Premier or Unified Support, and setup needs a billing account; otherwise a trial tenant, or a test team in the user's own tenant |
| NetSuite | A sandbox account, bought through the NetSuite account manager | Days | Not self-serve; a paid add-on, which an administrator of the production account requests |
| AWS | A separate account, https://aws.amazon.com/free, or a sandbox account in the user's AWS organization | Minutes to days | Free plan: credits rather than a free tier, and the account closes after 6 months or when the credits run out unless upgraded; the organization's administrators may own account creation |
| Jira, Confluence or Bitbucket Data Center | A trial license for a server of the user's, for existing Data Center customers only, requested through https://www.atlassian.com/company/contact/purchasing | Days | Self-serve trial licenses ended on 30 March 2026, so a user who is not already a Data Center customer cannot get one; the user runs the server, and SRC has to reach it as `SKILL.md` describes under Can it integrate X |
| Anything else | A test instance from the vendor, or a Generic listener and a script of your own standing in for the app while the rest is built | Varies | Ask the user what the vendor offers |
