# AWS

Authorized with IAM credentials typed into a wizard: a role the platform assumes with a trust policy it generates, or an IAM user's access key. No consent window. Snapshot 2026-09-15 from the web application's authorization wizard, cross-checked the same day against https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_create_for-custom.html. AWS has no event listener type; the connector is for API connections only, and requests are signed with SigV4 by the platform.

## Before you hand over

`connector create --team <teamId> --app-id <id> --name <name> --api-connection-type-id <id>`, IDs from `app list`; no listener type exists to pass. Then `authorizationUrl`. The wizard records no host for this app, so expect `connector get` to report no `baseUrl` even once authorized (not read back from an authorized connector); the AWS account is not recorded, so ask. Creating a role or a user needs IAM permissions in the account.

The credentials are saved through the web application alone; the public API has no field for them, so the CLI cannot finish this connector. The wizard at `authorizationUrl` is the only way.

## Methods the wizard offers

The wizard is titled "Authorize connector". Under "Authorization method", "Choose how you would like to configure your connection.":

- "Temporary credentials", the default. An IAM role with a trust policy the wizard generates for this connector; the platform assumes the role and gets session tokens for the "Duration" chosen. The wizard's description: "Temporary credentials use session tokens and role policies. These credentials last from a few minutes to several hours. As long as the role policy is active, new session tokens will be generated as needed. AWS will not recognize expired session tokens."
- "Permanent credentials". An IAM user's "Access key" and "Secret access key". The wizard warns: "AWS best practices suggest using temporary credentials. They are renewed as needed. Permanent credentials are not recommended."

Recommend temporary credentials; the wizard, AWS and the platform agree. Permanent credentials are for an account where nobody can create a role with a custom trust policy.

## Steps

Temporary credentials. The wizard first asks "Do you have a role previously set up with the required policy?" with "Yes, I will use the credentials from my existing policy." and "No, I will need to create a new role." A role created for another connector does not fit: the trust policy is generated per connector, so answer no unless this connector's own policy was already applied.

1. Open `authorizationUrl`, sign in, "Temporary credentials", "Continue", "No, I will need to create a new role.", "Continue".
2. "Create role": open the IAM console's Roles page, "Click on Create role in the top right hand corner."
3. "Trusted entity": "Select Custom trust policy" as the trusted entity type. "Replace all the content in the Policy Editor window with the trust policy below. It is located under the Custom Trust Policy section. Copy and paste it there." The wizard shows the policy under "Role policy" with a copy button; it names the platform's principal and an external ID unique to this connector. "Next" in AWS.
4. "Permissions": attach the permission policies the integration needs, whatever the Managed API calls will touch. "Next".
5. Give the role a "Role name", review, "Create role". Open the role and copy its ARN.
6. "Credentials": paste the ARN into "Role ARN". Set "Duration" in seconds, default 3600; the wizard says "Note that the duration should be between a value between 900 seconds (15 minutes) and 43200 seconds (12 hours)." and refuses anything outside with "Duration out of range." The role's own "Maximum session duration" in IAM has to be at least as long, or the assume call fails.
7. "Authorize app".

Permanent credentials. The wizard asks "Have you set up a user?" with "Yes, I already have a user." and "No, I will need to create a user."

1. "User": IAM console, Users, "Create user", a name, no console access.
2. "Permissions": attach the policies the integration needs. "Review", "Create user".
3. "Access key": open the user, "Security credentials", "Create access key", pick a use case, "Create access key". The wizard warns "Do not navigate away from the AWS page. Instead, proceed to the next step below." and "If you lose or forget your access key, it cannot be retrieved. Instead, create a new access key and deactivate the old one."
4. "Credentials": paste "Access key" and "Secret access key"; the wizard says "All credentials will be stored securely on our platform." "Authorize app".

## Saving

No callback and no window. "Authorize app" saves the credentials and, for a role, tries the assume call; the connector reads "Authorized" on success. Read `connector get` back for `authorized: true`; there is no `baseUrl`, so confirm the account with the user.

## Fixed-key alternative through a Generic connector

None. AWS APIs want every request signed with SigV4 over the request itself, which a header a Generic connector sends once cannot be. The connector's own flow is the only route.

## Expiry and re-authorization

Session tokens under a role are renewed by the platform for as long as the trust policy stands. Re-authorizing at `authorizationUrl` regenerates the trust policy; the Manage connector dialog warns "For security reasons, a new IAM role policy will be generated if you choose to use temporary credentials. Please ensure you update the IAM role with the new policy.", and the wizard repeats "Each time you reauthorize this connector, a new policy will be generated." So a re-authorization means editing the role's trust policy in IAM too. Switching from a role to permanent credentials shows "If you choose this option, your current credentials will be deleted and cannot be recovered." An access key lives until deactivated in IAM, and AWS flags keys older than 90 days in its own console.

## Known differences from the wizard

- The wizard's "Role policy" is a trust policy, the document that says who may assume the role; AWS's console calls the tab "Trust relationships". The permission policies are separate and the wizard leaves them to the user.
- The wizard's duration sentence reads "between a value between"; a typo, the range is 900 to 43200 seconds.
- AWS's console has moved "Create access key" under the user's "Security credentials" tab and asks for a use case first; the wizard's steps predate that.

## Verify before trusting

The role's "Maximum session duration" against the "Duration" entered; that the trust policy pasted is this connector's and not one copied from another connector; the permission policies against the Managed API calls, since a missing one answers `AccessDenied` per action; and which account the role or user lives in.
