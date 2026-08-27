# Get members of an LDAP group

- Platform: data-center
- Feature: script-console
- Tags: customise, issue, workflow
- Language: groovy
- Doc ID: example-dataCenter-get-ldap-group-members-with-ldap-resource-onPrem
- Source: https://examples.scriptrunner.io/scripts/get-ldap-group-members-with-ldap-resource-onPrem

## Overview

This script uses the LDAP resource connection to retrieve LDAP users who are members of the provided LDAP group.

## Example

As a Jira admin, I want to retrieve the names of users who are members of a remote LDAP group to populate a `Team Members` custom field within my Jira issues.

## Good to Know

This script demonstrates how to get a List of LDAP user common names (CN's) who are members of a given group distinguished name (DN). You can test this script in the script console and then tweak it to fit your needs for other automation features such as a listener or a post-function script that automatically updates an issue field with this CN list.

* Use the `groupDn` variable to define the distinguished name of the group you want to get members from.
* Use the `ldapQueryFilter` variable to define the full LDAP [HarcodedFilter](https://docs.spring.io/spring-ldap/docs/current/apidocs/org/springframework/ldap/filter/HardcodedFilter.html) that will be used with the LdapQueryBuilder.
* Use the `resourcePoolName` to store the name of the LDAP Resource you created with ScriptRunners Resources feature.

You can read more on Advanced LDAP Queries using the LdapQueryBuilder [here](https://docs.spring.io/spring-ldap/docs/2.3.0.BUILD-SNAPSHOT/reference/html/query-builder-advanced.html).

## Script

```groovy
import com.onresolve.scriptrunner.ldap.LdapUtil
import org.springframework.LdapDataEntry
import org.springframework.ldap.core.support.AbstractContextMapper
import org.springframework.ldap.query.LdapQueryBuilder
import org.springframework.ldap.query.SearchScope

// Full 'dn' for the group you want to get members from
final groupDn = 'cn=testing_group,ou=Product Testing,dc=example,dc=org'

// LDAP HardcodedFilter that looks for inetOrgPerson objects with the provided memberOf Attribute
final ldapQueryFilter = "(&(objectClass=inetOrgPerson)(memberOf=${groupDn}))"

final resourcePoolName = 'testLdapResource'

LdapUtil.withTemplate(resourcePoolName) { ldap ->
    // Create the LDAP query
    def query = LdapQueryBuilder.query()
        .searchScope(SearchScope.SUBTREE)
        .filter(ldapQueryFilter)

    // Run the search, get the 'cn' attribute for each entry found and return a `List` of `cn` values
    ldap.search(query, {
        LdapDataEntry entry ->
            entry.attributes.get('cn').get()
    } as AbstractContextMapper<Object>)
}
```

