# AWS

Authorized with IAM credentials typed into a wizard: a role the platform assumes with a trust policy it generates, or an IAM user's access key. No consent window. Snapshot 2026-10-12 from the web application's authorization wizard, whose console labels were checked against the IAM console on 2026-10-08, and against https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_create_for-custom.html. AWS has no event listener type; the connector is for API connections only, and requests are signed with SigV4 by the platform.

## Before you hand over

`connector create --team <teamId> --app-id <id> --name <name> --api-connection-type-id <id>`, IDs from `app list`; no listener type exists to pass. Then `authorizationUrl`. The wizard records no host for this app, so expect `connector get` to report no `baseUrl` even once authorized (not read back from an authorized connector); the AWS account is not recorded, so ask. Creating a role or a user needs IAM permissions in the account.

The credentials are saved through the web application alone; the public API has no field for them, so the CLI cannot finish this connector. The wizard at `authorizationUrl` is the only way.

## Methods the wizard offers

The wizard is titled "Authorize connector". Under "Authorization method", "Choose how you would like to configure your connection.":

- "Temporary credentials". An IAM role with a trust policy the wizard generates for this connector; the platform assumes the role and gets session tokens for the "Duration" chosen. The wizard's description: "Temporary credentials use session tokens and role policies. These credentials last from a few minutes to several hours. As long as the role policy is active, new session tokens will be generated as needed. AWS will not recognize expired session tokens."
- "Permanent credentials". An IAM user's "Access key" and "Secret access key". The wizard's description: "Permanent credentials require an access key ID and a secret key. An IAM user represents either a person or an application within AWS. Credentials remain valid as long as the access key and secret remain active in AWS." It warns: "AWS best practices suggest using temporary credentials. They are renewed as needed. Permanent credentials are not recommended."

Recommend temporary credentials; the wizard, AWS and the platform agree. Permanent credentials are for an account where nobody can create a role with a custom trust policy.

## Steps

Temporary credentials. "Role setup" asks "Do you have a role previously set up with the required policy?" with "Yes, I will use the credentials from my existing policy." and "No, I will need to create a new role." Either answer makes the wizard generate a new trust policy for this connector, and that policy has to go into IAM; an old one, even this connector's own, no longer matches. "Yes" means an existing role whose trust policy gets replaced. The wizard warns under it: "Each time you reauthorize this connector, a new policy will be generated." Replacing the trust policy cuts off anything else that assumed the role through the old one, another connector included, so pick "Yes" only for a role this connector alone uses.

New role:

1. Open `authorizationUrl`, sign in, "Temporary credentials", "Continue", "No, I will need to create a new role.", "Continue".
2. "Create role": "Visit the Identity and Access Management (IAM) Roles page in AWS." and "Click on Create role in the top right hand corner."
3. "Trusted entity": "Select Custom trust policy when prompted to select the trusted entity." Then "Replace all the content in the Policy Editor window with the trust policy below. It is located under the Custom trust policy section. Copy and paste it there." The wizard shows the policy in a "Trust policy" field with a copy button; it names the platform's principal and an external ID unique to this connector. "Click Next to configure the role permissions."
4. "Permissions": "Add the permissions you wish to grant to this role.", whatever the Managed API calls will touch. "Next". "In the Role details section, add a name and description." "Create role".
5. "Credentials": "Select the role you would like to use." and "Copy the ARN and paste below." into "Role ARN".
6. "Edit the role summary if you wish to change the Maximum session duration." Then enter "Duration" in seconds, default 3600; the wizard says "Note that the duration should be between 900 seconds (15 minutes) and 43200 seconds (12 hours)." and refuses anything outside with "Duration out of range." The role's own "Maximum session duration" in IAM has to be at least as long, or the assume call fails.
7. "Authorize app".

Existing role:

1. Open `authorizationUrl`, sign in, "Temporary credentials", "Continue", "Yes, I will use the credentials from my existing policy.", "Continue".
2. "Trusted entity": "Visit the Identity and Access Management (IAM) Roles page in AWS.", "Select the role you would like to use.", "Click on Trust relationships beneath the summary.", "Select Edit trust policy."
3. "Replace all the content in the Policy Editor window with the trust policy below. Copy and paste it there.", from the wizard's "Trust policy" field. "Click Update policy to confirm the changes."
4. "Credentials": "Copy the role ARN and paste below." into "Role ARN". Set "Duration" as in step 6 above, with the same range and the same check against the role's "Maximum session duration".
5. "Authorize". The button on this screen is "Authorize", not "Authorize app".

Permanent credentials. "IAM user and keys" asks "Have you set up a user?" with "Yes, I already have a user." and "No, I will need to create a user."

New user:

1. Open `authorizationUrl`, sign in, "Permanent credentials", "Continue", "No, I will need to create a user.", "Continue". "User": "Visit the Identity and Access Management (IAM) Users page in AWS.", "Click on Create user in the top right hand corner."
2. "User details": "Under User name, enter a username for the user.", "Next". Leave console access off; the integration needs none.
3. "Permissions": "Grant the user the necessary permissions by adding the new user to an existing group." or "Copy the permissions of a group or attach the necessary policies."
4. "Review": "Review user details", "Click Create user." Then "Continue" in the wizard.
5. "Access key": "Select User for making AWS API requests.", "Click on the Security credentials tab.", "Scroll down to Access keys.", "Click on Create access key."
6. "Key details": "Click on Other use case option.", "Next", "Provide a short description for your new credentials.", "Click on Create access key." "The access key and secret access key will be shown." The wizard warns "Do not navigate away from the AWS page. Instead, proceed to the next step below." and "If you lose or forget your access key, it cannot be retrieved. Instead, create a new access key and deactivate the old one."
7. "Credentials": the wizard says "All credentials will be stored securely on our platform." Paste "Access key" and "Secret access key". "Authorize app".

Existing user: "Yes, I already have a user.", "Continue", then the same "Access key", "Key details" and "Credentials" steps, starting from "Visit the Identity and Access Management (IAM) Users page in AWS." Check the user's policies against the Managed API calls first.

## Saving

No callback and no window. "Authorize app" (or "Authorize") saves the credentials and, for a role, tries the assume call; the connector reads "Authorized" on success. Read `connector get` back for `authorized: true`; there is no `baseUrl`, so confirm the account with the user.

## Fixed-key alternative through a Generic connector

None. AWS APIs want every request signed with SigV4 over the request itself, which a header a Generic connector sends once cannot be. The connector's own flow is the only route.

## Expiry and re-authorization

Session tokens under a role are renewed by the platform for as long as the trust policy stands. Re-authorizing at `authorizationUrl` regenerates the trust policy; the Manage connector dialog warns "For security reasons, a new IAM role policy will be generated if you choose to use temporary credentials. Please ensure you update the IAM role with the new policy." So a re-authorization means the existing-role steps above: answer "Yes" and paste the new policy into the role's trust relationships. The "Yes" option adds "If you choose this option, your current credentials will be deleted and cannot be recovered. Follow all the steps to reauthorize your connector to make sure your integrations keep working smoothly. You will get a new, unique credential to replace your old one." An access key lives until deactivated in IAM, and AWS flags keys older than 90 days in its own console.

## Known differences from the wizard

- The "Yes" answer reads "use the credentials from my existing policy", but the policy is regenerated whichever answer is given; what is reused is the role, and its trust policy is replaced.
- The trust policy says who may assume the role; AWS's console shows it under "Trust relationships". The permission policies are separate and the wizard leaves them to the user.
- The wizard's IAM links open the console in `us-east-1`. IAM is global, so the region does not matter.

## Verify before trusting

The role's "Maximum session duration" against the "Duration" entered; that the trust policy pasted is the one the wizard showed in this run, not one from an earlier run or another connector; that no other connector assumes a role whose trust policy was replaced; the permission policies against the Managed API calls, since a missing one answers `AccessDenied` per action; and which account the role or user lives in.
