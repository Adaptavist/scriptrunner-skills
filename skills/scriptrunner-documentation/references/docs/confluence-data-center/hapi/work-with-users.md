# Work with Users

- Platform: confluence-data-center
- Space: SR4C
- Hierarchy: HAPI
- Doc ID: doc-sr4c-4de22a19-85c9-402b-937b-3864b0e9d6eb-e631bbfba656af44
- Source: https://docs.adaptavist.com/sr4c/latest/hapi#work-with-users--en

With HAPI, you can create scripts to gather lists of users based on different criteria and deactivate users.

Tip: Expanding on these scripts

You can use the methods outlined on this page with other HAPI methods.

## Get user by name

To get a user by username and return their email address, enter a script like this in the [Script Console](https://docs.adaptavist.com/sr4c/latest/features/script-console):

Enter a script like this in the [Script Console](https://docs.adaptavist.com/sr4c/latest/features/script-console):

```
Users.getByName('USERNAME').email
```

After you run this script, the user email is printed in the log:

## Deactivate users

To deactivate a user, enter a script like this in the [Script Console](https://docs.adaptavist.com/sr4c/latest/features/script-console):

Enter a script like the following in the [Script Console](https://docs.adaptavist.com/sr4c/latest/features/script-console):

```
Users.getByName('USERNAME').deactivate()
```

After you run this script, the user is deactivated. When you navigate to the Users screen, you can see the _disabled_ flag next to the user:

## Get inactive users

-   To get a list of inactive users, including deactivated users, use a script like this in the [Script Console](https://docs.adaptavist.com/sr4c/latest/features/script-console):
    
    ```
    import java.time.temporal.ChronoUnit
    import java.time.Duration
    
    Users.getInactiveUsers(Duration.of(90, ChronoUnit.DAYS)).collect { it.name }
    ```
    
    After you run the script, you will have a list of users that have been inactive for 90 days.
    
-   You can change the period of inactivity by adjusting the `Duration.of(90, ChronoUnit.Days))` to how long you need, like, `Duration.of(6, ChronoUnit.DAYS))`. Visit [Oracle ChronoUnit](https://docs.oracle.com/javase/8/docs/api/java/time/temporal/ChronoUnit.html) documentation for help.

## Get logged in user

To get the current logged in user, use a script like this in the [Script Console](https://docs.adaptavist.com/sr4c/latest/features/script-console):

Use a script like the following in the [Script Console](https://docs.adaptavist.com/sr4c/latest/features/script-console):

```
Users.getLoggedInUser()
```

After running this script, you get a list of users who are logged in:

## Related pages

-   [HAPI Script Format Help](https://docs.adaptavist.com/sr4c/latest/get-help/hapi-script-format-help)
-   [Script Console](https://docs.adaptavist.com/sr4c/latest/features/script-console)
