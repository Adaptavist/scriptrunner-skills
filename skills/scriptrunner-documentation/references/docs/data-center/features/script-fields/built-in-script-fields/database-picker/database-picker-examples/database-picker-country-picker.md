# Database Picker Country Picker

- Platform: data-center
- Space: SR4JS
- Hierarchy: features > script-fields > built-in-script-fields > database-picker > database-picker-examples
- Doc ID: doc-sr4js-442887940
- Source: https://docs.adaptavist.com/sr4js/latest/features/script-fields/built-in-script-fields/database-picker/database-picker-examples/database-picker-country-picker

What follows is a longer, worked example of using the database picker in case any concepts need reinforcing.

We will attempt to implement a country picker, using the various customizations outlined on the [Database Picker Customizations](https://docs.adaptavist.com/sr4js/latest/features/script-fields/built-in-script-fields/database-picker/database-picker-customizations) page. For our source of countries, we can use [https://github.com/ghusta/docker-postgres-world-db](https://github.com/ghusta/docker-postgres-world-db) \- which is a docker image containing both PostgreSql and a sample database that contains a list of countries of the world.

The sample database represents any external database - possibly your sales, CRM database, configuration management database, etc. But using this container should allow you to follow along with this tutorial using any non-production Jira instance.

## Resource Setup

1.  Firstly, run the docker container:
    
    ```
docker run -d -p 5432:5432 ghusta/postgres-world-db:2.4
```
    
    This should give you a postgres instance listening on `localhost:5432`. For Windows users, this will be `<docker-ip>:5432`. See the documentation for running docker on Windows.
    
2.  Next, in your Jira instance, set up a Database connection [Resource](https://docs.adaptavist.com/sr4js/latest/features/resources) that points to this database. The username and password are taken from the instructions at [https://github.com/ghusta/docker-postgres-world-db](https://github.com/ghusta/docker-postgres-world-db).  
    ![](/sr4js/files/latest/442887940/442887962/1/1758746893000/Resource_screen.png)
    
3.  Click **Preview** to make sure that you can connect. If there are problems, check the hostname in the **JDBC URL**, and validate that the docker container is working properly.  
    There is only a single table that we will make use of initially - `country`. Get a feel for the shape of the data by entering the following SQL in the `SQL` field and pressing **Preview**.
    
    ```
select * from country
```
    
    ![](/sr4js/files/latest/442887940/442887963/2/1758746893000/world-db-country+%282%29.png)  
    We’re only going to be interested in a few of the columns here, but there are many other columns you could use for interesting exercises.
    
4.  **Add** the resource so that it’s available to be used in scripts and picker fields.
    

## Country Picker Field

Let’s start with a basic **Country Picker** field.

As a reminder, for a database picker, we need to provide two queries.

1.  One specifying what search to do based on what the user has typed in the field, and a unique identifier to be saved in the Jira database.
    
2.  A second one that, given the unique identifier, will retrieve the record to display to the end-user. It also serves to validate the ID (particular required when using the REST API to create issues, where the picker is not shown).
    

So our first decision is what will uniquely identify a country using this table. Let’s go for the 2-letter country code which is an [ISO standard](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2) \- this is in our table as `code2`. Meaning, if the country name changes (it happens), it won’t affect our stored data. Normally, a database table would be expected to have an auto-generated numeric counter, but this one doesn’t. Where possible, always use a unique counter, as customers and products etc undergo name changes over time.

The attribute that we will search on according to what the user types will be the country name.

Given the above, our two queries will be:

Retrieval/Validation SQL:

```
select code2, name from country where code2 = ?
```

  
Search SQL:

```
select code2, name
from country
where lower(name) like lower(?) || '%'
```

Both the country and search query are lower-cased to avoid the end-user having to worry about the capitalisation of country names.

You should end up with the field configured like the following. You can test it before creation by entering any valid issue key and clicking **Preview**.

![](/sr4js/files/latest/442887940/442887965/1/1758746893000/Database_picker_2.png)

Now, add this field to a screen so you can test it. Verify basic operations such as searching, and updating an issue:

![](/sr4js/files/latest/442887940/442887953/1/1758746893000/world-db-search.png)

## Customizing the Appearance

### Setting a drop-down icon

This is a perfectly serviceable country picker, with a data source that can be modified outside of Jira. However, we can jazz it up a bit by showing the country’s flag, which might aid selection and recognition.

As discussed in [Database Picker Customizations](https://docs.adaptavist.com/sr4js/latest/features/script-fields/built-in-script-fields/database-picker/database-picker-customizations), we can modify picker field behaviour using the **Configuration Script**.

Browsing the internet, we find that there is a site where you can get any flag by the two-letter country code - for example **Zimbabwe** \- [https://flagpedia.net/data/flags/small/zw.png](https://flagpedia.net/data/flags/small/zw.png).

Let’s set the icon in the drop-down:

```
import groovy.sql.GroovyRowResult

getDropdownIcon = { GroovyRowResult row ->
    "https://flagpedia.net/data/flags/small/${row.code2.toString().toLowerCase()}.png"
}
```

Here we just return a URL that extracts the `code2` field from the object representing the database row for each record.

Enter this in the **Configuration Script**, either inline, or into a file that you point to:

![](/sr4js/files/latest/442887940/442887966/1/1758746894000/Configuration_script.png)

Update the field and verify we see the icons:

![](/sr4js/files/latest/442887940/442887956/1/1758746893000/world-db-search-flags.png)

Using a file rather than an inline script is far faster to develop with, as any changes will be reflected instantly. There is no need to keep updating the field configuration, and if you have set it up properly, you could also attach a debugger.

The **Snippets** drop-down contains a number of templates for commonly-used customisations, as a starting point.

## Customising the view

When viewing the issue, we could make the selected value a bit more informative.

We specify the HTML to be displayed by implementing the `renderViewHtml` closure. We want it to display as shown:

![](/sr4js/files/latest/442887940/442887960/1/1758746893000/world-db-view-flag.png)

Note, that will we will show the continent, which we can get from the database table. So we will adjust the retrieval query to also return the `continent`.

```
select code2, name, continent from country where code2 = ?
```

  
We can put any number of other columns after the first two (which have special significance), that we can use in our customizations.

```
renderViewHtml = { String displayValue, GroovyRowResult row ->

    def writer = new StringWriter()
    def builder = new MarkupBuilder(writer)
    builder {
        div {
            div(style: 'width: 50px; float: left') {
                img(
                    style: 'width: 40px; height: 40px',
                    src: "https://flagpedia.net/data/flags/small/${row.code2.toString().toLowerCase()}.png"
                )
            }
            div(style: 'margin-left: 50px') {
                span(displayValue)
                div(style: 'color: grey; font-size: small;') {
                    i(row.CONTINENT)
                }

            }
        }
    }
    writer.toString()
}
```

See the complete listing at the end of this page for the necessary `import` lines.

Using `OutputFormatter.markupBuilder` avoids the possibility that a bad actor could modify the linked database, insert `<script>` tags into the `continent` column, and conduct an XSS attack. Read more on avoiding XSS attacks.

## Dependent Fields

You may have data which would be unmanageable to search on using a single attribute. For instance, **customers** and their **orders**. In this case, the end-user might find it easier to use if they could first select the **Customer**, then select from the **Orders** relevant only to that **Customer**.

In our example, we will allow the user to choose the continent, then the country, showing only relevant countries. (This is purely for the purposes of an example, if we did want a **Country Picker** field, choosing the continent would just be an irritation)

Let’s start by creating a standard select list containing options for each continent, which we can get from our database using:

```
select distinct continent from country order by continent
```

![](/sr4js/files/latest/442887940/442887958/1/1758746893000/world-db-select-list.png)

Now, we will modify our code to implement the `getSearchSql` closure. We’ll get the value of the _Continent_ custom field, and use it in the SQL. If it hasn’t been set, then no countries will be available. Optionally you could just ignore it in this case so all countries are shown.

```
getSearchSql = { String inputValue, Issue issue, String originalValue ->
    def continent = issue.getCustomFieldValue('Continent')

    new SqlWithParameters(
        "select code2, name, continent from country where name like ? || '%' and continent = ?",
        [inputValue, continent?.value]
    )
}
```

Optionally, you could include **validation** that both fields match. Whether you implement validation is really dependent on whether the other fields are just intended to be a guide, or whether they really must match.

To validate the continent matches use:

```
getValidationSql = { String id, Issue issue, String originalValue ->
    def continent = issue.getCustomFieldValue('Continent')

    new SqlWithParameters("select code2, name, continent from country where code2 = ? and continent = ?", [id, continent?.value])
}
```

### Disabled Values

To experiment with disabled values, add a column to the `country` table representing whether the country is disabled or not:

```
ALTER TABLE country
    ADD COLUMN "disabled" BOOLEAN DEFAULT FALSE;
```

Then as discussed in [Disabled Values](https://docs.adaptavist.com/sr4js/latest/features/script-fields/built-in-script-fields/database-picker/database-picker-customizations#id-.DatabasePickerCustomizationsv9.x-disablingoptions), modify your SQL to take our additional column into account:

```
import com.atlassian.jira.issue.Issue
import com.atlassian.jira.issue.customfields.option.Option
import com.onresolve.scriptrunner.canned.jira.fields.editable.database.SqlWithParameters

getSearchSql = { String inputValue, Issue issue, String originalValue ->
    def continent = issue.getCustomFieldValue('Continent') as Option

    new SqlWithParameters(
        """
            select code2, name, continent from country 
            where 
                lower(name) like lower(?) || '%' and 
                continent = ? and 
                (disabled = false or code2 = ?)
            """,
        [inputValue, continent?.value, originalValue]
    )
}

getValidationSql = { String id, Issue issue, String originalValue ->
    def continent = issue.getCustomFieldValue('Continent') as Option

    new SqlWithParameters("""
        select code2, name, continent from country 
        where 
            code2 = ? and 
            continent = ? and 
            (disabled = false or ? = ?)
        """, [id, continent?.value, id, originalValue])
}
```

#### Full Configuration Script Listing

```
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.issue.Issue
import com.onresolve.scriptrunner.canned.jira.fields.editable.database.SqlWithParameters
import groovy.sql.GroovyRowResult
import groovy.xml.MarkupBuilder

def customFieldManager = ComponentAccessor.customFieldManager

renderViewHtml = { String displayValue, GroovyRowResult row ->

    def writer = new StringWriter()
    def builder = new MarkupBuilder(writer)
    builder {
        div {
            div(style: 'width: 50px; float: left') {
                img(
                    style: 'width: 40px; height: 40px',
                    src: "https://flagpedia.net/data/flags/small/${row.code2.toString().toLowerCase()}.png"
                )
            }
            div(style: 'margin-left: 50px') {
                span(displayValue)
                div(style: 'color: grey; font-size: small;') {
                    i(row.CONTINENT)
                }

            }
        }
    }
    writer.toString()
}

getDropdownIcon = { GroovyRowResult row ->
    "https://flagpedia.net/data/flags/small/${row.code2.toString().toLowerCase()}.png"
}

getSearchSql = { String inputValue, Issue issue, String originalValue ->
    def continent = issue.getCustomFieldValue('Continent')

    new SqlWithParameters(
        "select code2, name, continent from country where name like ? || '%' and continent = ?",
        [inputValue, continent?.value]
    )
}

getValidationSql = { String id, Issue issue, String originalValue ->
    def continent = issue.getCustomFieldValue('Continent')

    new SqlWithParameters("select code2, name, continent from country where code2 = ? and continent = ?", [id, continent?.value])
}

renderColumnHtml = { String displayValue ->
    displayValue
}
```
