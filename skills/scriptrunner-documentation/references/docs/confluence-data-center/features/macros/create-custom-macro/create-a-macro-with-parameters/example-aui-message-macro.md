# Example: AUI Message Macro

- Platform: confluence-data-center
- Space: SR4C
- Hierarchy: Features > Macros > Create Custom Macro > Create a Macro with Parameters
- Doc ID: doc-sr4c-ed4d608e-07fd-4802-970d-fda793ad6a40-ed70c87eb0cdd3fd
- Source: https://docs.adaptavist.com/sr4c/latest/features#macros--en#create-custom-macro--en#create-a-macro-with-parameters--en#example-aui-message-macro--en

Instructions to create an AUI Message macro.

Follow these steps to create a macro that outputs an [AUI message](https://docs.atlassian.com/aui/latest/docs/messages.html):

1.  Select the Create Macro button on the Macro page.
2.  Select Custom Script Macro.
3.  Set the following fields:
    
    -   Key: message-macro
    -   Name: Message
    -   Description: Renders an AUI message
    -   Body Type: Rich text
    -   Output Type: Block
    
4.  Select the \+ Parameter button and set the following fields on the form that appears:
    
    -   Parameter Type: string
    -   Name: title
    -   Label: Title
    -   Tick the checkbox for Required
    
    Note: Description and Default are not required for this example.
    
5.  Select the +Parameter button and set the following fields on the form that appears:
    
    1.  Parameter Type: enum
    2.  Name: level
    3.  Label: Level
    4.  Tick the checkbox for Required
    
    Note: Description and Default are not required for this example.
    
    -   Select the +enum value button, and then enter info.
    -   Select the +enum value button, and then enter warning.
    -   Select the +enum value button, and then enter error.
    
    Note: The form should look after you've added your _Parameter_ fields:
    
    The Parameter Types _string_ and _enum_ determine the two parameters of the macro, which allow editors using the macro to determine the following components of the message:
    
    -   The title of the message is a _string_.
    -   The severity of the message is an enum because only a finite list of level types are accepted.
    
    Find out more about the different parameter types [here](https://developer.atlassian.com/confdev/confluence-plugin-guide/confluence-plugin-module-types/macro-module/including-information-in-your-macro-for-the-macro-browser).
    
6.  For Macro Code, you can type in the following code or put it in a file and enter the relative path to the file, under the script root (as usual).
    
    ```
    import groovy.xml.MarkupBuilder
    
    def writer = new StringWriter()
    def builder = new MarkupBuilder(writer)
    builder.div('class': "aui-message aui-message-${parameters.level}") {
        p('class': 'title') {
            strong(parameters.title)
        }
        mkp.yieldUnescaped(body)
    }
    writer.toString()
    ```
    
    Warning: The `mkp.yieldUnescaped` method is dangerous and should only be used with trusted data. In this particular case, the use of `mkp.yieldUnescaped` is safe because Confluence does not allow script tags or other potentially malicious HTML in the macro's `body` variable. Other user inputs like the ones you specify as macro parameters are _not_ checked in the same way and should _not_ be trusted. It's important that these inputs are handled securely, as discussed in our [documentation on custom macros and security](https://docs.adaptavist.com/sr4c/latest/features/macros/create-custom-macro/security-and-best-practices).
    
7.  Skip the Macro Javascript Code, Macro CSS Style, and Lazy Loaded fields.
8.  Click Add.
9.  View your new macro when the Macro page loads.
    
    Now you can take all ordinary macro actions.
