# LDAP Connection

- Platform: data-center
- Space: SR4JS
- Hierarchy: features > resources
- Doc ID: doc-sr4js-442889080
- Source: https://docs.adaptavist.com/sr4js/latest/features/resources/ldap-connection

Adding an LDAP resource allows you to query your LDAP servers in a similar way to database connections.

Use an LDAP resource to:

-   Validate that a username provided in a custom field is a member of an LDAP group.
    
-   Write a REST endpoint to list office addresses.
    
-   In a _Leavers_ workflow, use a post function to mark a user as having left the company.
    

## Setting up an LDAP connection

To set up an LDAP connection, and make the connection available to scripts:

1.  Navigate to **ScriptRunner** **\>** **Resources** **\>** **Create Resource** **\>** **LDAP connection**.
    
2.  Provide a name for the connection in **Pool Name**.
    
3.  Enter the **Host**.
    
4.  Optionally, check **Use TLS** to use TLS/SSL encryption.
    
5.  Enter the **Port** the LDAP connection is using.
    
6.  Enter the base dn into the **Base** field.
    
7.  Optionally, check **Anonymous bind** to bind anonymously.
8.  Add the **User dn**.
    
9.  Enter the LDAP **Password**.
    
    Contact your directory services administrator for LDAP details. If you have set up an LDAP server as an application _User Directory_, and it’s the same LDAP server, you can copy and paste the values.
    
    The password provided can be viewed by administrators.
    
10.  Select **Add**.
     
     Selecting **Preview** validates that a successful connection and query can be made to the LDAP server.
     
     ![](/sr4js/files/latest/442889080/442889081/1/1758746994000/LDAP_connection.png)

## Use LDAP resources in scripts

Having set up an LDAP connection, you can use it in a script as follows:

This example uses the LDAP connection with the **Pool Name** _corporate_.

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

`LdapUtil.withTemplate` takes two arguments:

1.  The name of the connection as defined by you in the **Pool Name** parameter when adding the connection (in this example _corporate_),
    
2.  A closure. The closure receives a [`org.springframework.ldap.core.LdapOperations`](https://docs.spring.io/spring-ldap/docs/current/apidocs/org/springframework/ldap/core/LdapOperations.html) object as an argument.
    

See [spring ldap](https://docs.spring.io/spring-ldap/docs/2.3.2.RELEASE/reference/#basic-usage) for more information on querying. Where the documentation refers to an `LdapTemplate`, this is equivalent to the above-mentioned `LdapOperations`.
