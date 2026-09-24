# LDAP Connection

- Platform: confluence-data-center
- Space: SR4C
- Hierarchy: Features > Resources
- Doc ID: doc-sr4c-744ddfb7-fdab-4c33-8843-ebef4f11edd6-7e9d8ae70d59b01f
- Source: https://docs.adaptavist.com/sr4c/latest/features#resources--en#ldap-connection--en

Adding an LDAP resource allows you to query your LDAP servers in a similar way to database connections.

Use an LDAP resource to:

-   Validate that a username provided in a custom field is a member of an LDAP group.
-   Write a REST endpoint to list office addresses.
-   In a _Leavers_ workflow, use a post function to mark a user as having left the company.

To set up an LDAP connection, and make the connection available to scripts:

1.  Navigate to ScriptRunner > Resources > Add New Item > LDAP Connection.
2.  Provide a name for the connection in Pool Name.
3.  Enter the Host.
4.  Optionally, check Use TLS to use TLS/SSL encryption.
5.  Enter the Port the LDAP connection is using.
6.  Enter the base dn into the Base field.
7.  Add the User dn.
8.  Enter the LDAP Password.
    
    Tip: Contact your directory services administrator for LDAP details. If you have set up an LDAP server as an application _User Directory_, and it's the same LDAP server, you can copy and paste the values.
    
9.  Click Add.
    
    Clicking Preview validates that a successful connection and query can be made to the LDAP server.
    

## Use LDAP Resources in Scripts

Having set up an LDAP connection, you can use it in a script as follows:

This example uses the LDAP connection with the Pool Name corporate.

```
import com.onresolve.scriptrunner.ldap.LdapUtil
import org.springframework.ldap.core.AttributesMapper

import javax.naming.directory.SearchControls

def cnList = LdapUtil.withTemplate('corporate') { template ->
    template.search("", "(sn=Smi*)", SearchControls.SUBTREE_SCOPE, { attributes ->
        attributes.get('cn').get()
    } as AttributesMapper<String>)
}

// cnList now contains the list of common names of users whose surnames begin with "Smi"...
```

`LdapUtil.withTemplate` takes two arguments:

1.  The name of the connection as defined by you in the Pool Name parameter when adding the connection (in this example corporate),
2.  A closure. The closure receives a `org.springframework.ldap.core.LdapOperations` object as an argument.

See [spring ldap](https://docs.spring.io/spring-ldap/docs/2.3.2.RELEASE/reference/#basic-usage) for more information on querying. Where the documentation refers to an `LdapTemplate`, this is equivalent to the above-mentioned `LdapOperations`.
