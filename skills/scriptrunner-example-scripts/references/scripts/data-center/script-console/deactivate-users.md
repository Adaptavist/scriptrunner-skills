# Deactivate Users

- Platform: data-center
- Feature: script-console
- Tags: automate, user, hapi
- Language: groovy
- Doc ID: example-dataCenter-deactivate-list-of-users-onPrem
- Source: https://examples.scriptrunner.io/scripts/deactivate-list-of-users-onPrem

## Overview

Run this script in the Script Console to deactivate specified users. Use this script to deactivate multiple users with 
one action, saving time manually finding and deleting users.

## Example

I have received a list of users who have left the company from our HCM system. For system security, I need to remove 
these users as soon as possible. Usually, I would need to search for each name individually and manually delete each user. 
With this script, I can enter the list of user names and bulk deactivate all of them with one action.

## Good to Know

If any users from the list cannot be deactivated (for instance if they are currently a component lead) a message will be logged.
You can then fix this and re-run your script. No harm will come from deactivating a user that is already inactive.

## Script

```groovy
[
    'jdoe',
    'bob',
].each { username ->
    log.warn("Deactivating user ${username}")
    try {
        Users.getByName(username).deactivate()
    } catch (Exception exception) {
        log.warn("Update of ${username} failed: ${exception.message}")
    }
}
```

