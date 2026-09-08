# Avoid Cross-site Scripting Vulnerabilities

- Platform: data-center
- Space: SR4JS
- Hierarchy: best-practices > write-code
- Doc ID: doc-sr4js-442888178
- Source: https://docs.adaptavist.com/sr4js/latest/best-practices/write-code/avoid-cross-site-scripting-vulnerabilities

Cross-Site Scripting (XSS) is a type of vulnerability that arises when a web application renders data as HTML from an untrusted source.

See [Database Picker Customization](https://docs.adaptavist.com/sr4js/latest/features/script-fields/built-in-script-fields/database-picker/database-picker-customizations) for information on avoiding XSS attacks in a Database Picker field.

  
An XSS vulnerability can allow an attacker to impersonate a verified user, carry out tasks as the user, and gain access to all of the user's data. This is particularly dangerous if an attacker gains access to an account of someone with administrative rights.

## Identifying Vulnerabilities

ScriptRunner features are vulnerable to XSS attacks anywhere an administrator renders user-provided data on the screen as HTML, for example:

-   A script field that displays a value obtained from other user-editable fields.
-   A web panel that shows user display names. 
-   A confluence macro that displays a list of page names.

Testing for vulnerability is relatively easy. Enter valid HTML or Javascript into any input(s) your script uses; if it renders as HTML or the Javascript executes, your app is vulnerable.

### Example Testing Strings

For example, you have a script field that shows the current issue's summary. To test this field, enter the following HTML into the issue summary:

```
<details open ontoggle=prompt`12345`>
```

If a pop-up displays when your script field etc renders, the app is vulnerable. If you see the string as written above, the field is safe. 

You can also test using simple HTML tags such as bold (<b>).

```
I contain <b>HTML</b>
```

If the text displays with the HTML formatting, the app is vulnerable. If you see the angled brackets, the field is safe. 

## Fix Vulnerability Issues

To fix potential security vulnerabilities, you must escape all inputs from users when rendering HTML derived from these inputs. There are two ways of doing this: 

1.  Use `[MarkupBuilder](https://docs.groovy-lang.org/latest/html/api/groovy/xml/MarkupBuilder.html)`. This is the easiest solution as `MarkupBuilder` will automatically escape any strings and does not allow you to write invalid HTML, ensuring all tags are closed. 
    
    ```
import groovy.xml.MarkupBuilder

def writer = new StringWriter()
new MarkupBuilder(writer).p {
	span(issue.summary)
}
return writer.toString()
```
    
2.  Alternatively, escape all input from users manually as required:
    
    ```
import com.opensymphony.util.TextUtils

TextUtils.htmlEncode(issue.summary)
```
    

## Example

### Demonstrating an XSS Vulnerability

In this example, we create a Jira custom script field and show how you can check if it is vulnerable to XSS attacks.

1.  Create a basic script field using the _Text Field(multi-line)_ template that returns the summary of an issue.
2.  Enter `issue.summary` into the **Script** field.  
    With this vulnerable script, when any user enters HTML into the issue **Summary**, the script field returns the raw HTML which the browser renders.  
    ![](/files/106358879/209688577/1/1701272672000/XSS_vulnerability_1.png)
3.  To test the vulnerability, navigate to an issue containing the test script field. 
4.  Enter the following into the **Summary** field. 
    
    ```
<details open ontoggle=prompt '12345'>
```
    
    ![](/files/106358879/112137477/1/1621523208000/Screenshot+2021-04-01+at+11.27.47.png)
    
    Because the script we have created is vulnerable, the browser shows the prompt when the script fields execution result is rendered:
    
    ![](/files/106358879/112137476/1/1621523208000/Screenshot+2021-04-01+at+11.30.19.png)

A user should not be able to execute code by entering HTML or Javascript into a user input field. To ensure our instance is safe from XSS attacks we need to fix this.

### Fixing an XSS vulnerability

The script field we created above is vulnerable to XSS attacks. Here we show how you can modify your script to escape any executable code (in this example `<details open ontoggle=prompt '12345'>`) entered into the input field before it is returned to the browser to be displayed.

Here we use the groovy XML/HTML `Markup` helper class called the [MarkupBuilder](https://docs.groovy-lang.org/latest/html/api/groovy/xml/MarkupBuilder.html). This class allows us to automatically escape the content entered by the user, turning it into a standard string that the browser does not treat as executable HTML or Javascript.

1.  Edit the **Script** to use the MarkupBuilder class. 
    
    ```
import groovy.xml.MarkupBuilder

def writer = new StringWriter()
new MarkupBuilder(writer).p {
	span(issue.summary)
}
return writer.toString()
```
    
    ![](/files/106358879/209688576/1/1701272672000/XSS_vulnerability_2.png)
    
2.  Return to the issue showing the script field we created above and refresh the page.
    
    Any executable HTML or Javascript entered into the **Summary** field is now shown as a string and not executed by the browser.
    
    ![](/files/106358879/112137474/1/1621523208000/Screenshot+2021-04-01+at+11.35.17.png)
    

The example here is to illustrate how to stop HTML or Javascript executing via the output result of your script fields. Although this example does not pose a threat, in reality an attacker can execute any HTML or Javascript via the inputs used by your script fields if they are not processed correctly before being rendered. An attacker can use this vulnerability to steal cookies or execute REST requests on a users behalf.
