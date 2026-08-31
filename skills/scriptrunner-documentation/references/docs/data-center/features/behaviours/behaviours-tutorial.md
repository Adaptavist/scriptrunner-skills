# Behaviours Tutorial

- Platform: data-center
- Space: SR4JS
- Hierarchy: features > behaviours
- Doc ID: doc-sr4js-273486399
- Source: https://docs.adaptavist.com/sr4js/latest/features/behaviours/behaviours-tutorial

For a video on behaviours, see the [Using Behaviours](https://docs.adaptavist.com/sr4js/latest/training/course-introduction-to-scriptrunner-for-jira-data-center-server/1-2-video-using-behaviours-in-scriptrunner-for-jira-data-center-server) training video.

Before you start this tutorial, make sure you've read the [Behaviours](https://docs.adaptavist.com/sr4js/latest/features/behaviours) page to understand what behaviours are and how to use them. You may also find it useful to learn about the [limitations](https://docs.adaptavist.com/sr4js/latest/features/behaviours/behaviour-limitations) of behaviours. 

Continue below for an overview of the screens you see when you're creating a behaviour. Once you're happy with your understanding of behaviours, try out some [examples](#id-.BehavioursTutorialv9.x-examples) we've provided below. 

## Behaviour screen overview

When you create a new behaviour, the following sections display:

-   **Mappings**: Where you set the project/issue type mapping. For **Service Desk** projects this is where you set the project/request type mappings. The mappings determine what contexts trigger the configured behaviour.
-   **Behaviour Settings**: Where you give your behaviour a name and description. You can also define a guide workflow.
    
-   **Initialiser**: Where you define a script that runs as soon as the issue create, edit, or transition screen displays (use to set default field states, values, and options). 
-   **Fields**: Where you can define field states using simple toggle options. For more advanced control you can use a Groovy script (server-side script). With a server-side script you can define more complex conditions to control the field state, value, and options using Groovy. In addition, you can control how the field impacts other fields when changed.
    

Hover over each section in the image below to find out more.

You start a behaviour with a Name and Description. This required name should identify the behaviour. The description is optional, but it can help other Jira administrators understand the purpose of the behaviour and how they can use it. Guide workflow helps when you add a condition to a field. When you're adding a condition, this option allows you to look at the workflow steps from the workflow you have selected. You can add mappings to choose what project(s) and issue types this behavior runs on. If you want your behaviour to run once you need to set an Initialiser script. The script won’t run again if that user edits the issue, because they only need it to run the first time. Not all behaviours need or use an initialiser. You can set additional options on fields in Jira. When you add a field to a behaviour, you can work with pre-built options available—similar to what you find in a field configuration. These options include optional/required, writable/read-only, and shown/hidden. You can also add a pre-built condition on a field that allows you to set additional restrictions or requirements based on the field you choose.

When you choose **Add Mapping** more options display. Hover over each section in the image below to find out more.

Choose this option to map the behaviour to specific projects and issue types. Choose this option to map the behaviour to selected service desks and request types. This option allows behaviours to be mapped to fields within customer portals. These options change if you select "Use Service Desk mapping"

If you choose **Add a Field** more options display. Hover over each section in the image below to find out more.

You can configure the added field so it's optional/required, writable/read-only, and shown/hidden. You can add predefined conditions to determine if the behaviour should run for the field you are configuring. You can add a server-side script if you need a script to run on this field each time a user interacts with it.

If you choose **Add new condition** more options display. Hover over each section in the image below to find out more.

You can choose whether the behaviour will run or not when the condition you set is true. You can set a condition to further define the field you are configuring.

## Using multiple conditions on a field 

You can set conditions on fields to control when they should be shown or hidden depending on the context provided. When setting a condition you can choose **When** (the behaviour will happen if condition is true) or **Except** (the behaviour will not happen if condition is true). When you have multiple conditions on the same field, the **behaviour runs** provided that:

-   No **Except** conditions are `true`,
-   **AND** at least one **When** condition is `true` , **OR** there are no **When** conditions.

For example...

If you have a **mix** of **Except** and **When** conditions:

-   If **any** of the **Except** conditions are `true`, the behaviour **does not run**.
-   If **any** of the **When** conditions are `true`, and **none** of the **Except** conditions are `true`, the behaviour **runs**.
-   If **none** of the **When** conditions, and **none** of the **Except** conditions are `true`, the behaviour **does not run**.

If you have **only** **Except** conditions:

-   If **any** of the **Except** conditions are `true`, the behaviour **does not run**.

If you have **only When** conditions:

-   If **any** of the **When** conditions are `true`, the behaviour **runs**.
-   If **none** of the **When** conditions are `true`, the behaviour **does not run**.

If there are **no conditions**, the behaviour **runs**.

## Should I add an initialiser or server-side script?

You do not need to set up an initialiser or server-side script for every behaviour, only when you want the behaviour to run as described below.

When setting up a behaviour you may want to determine when your behaviour runs:

-   If you want the behaviour to run when the _Create Issue_, _Edit Issue_, or _Transition issue_ page loads, set up an **Initialiser**. For example, you can use an initialiser in a behaviour to set a [default description every time an issue is created](#id-.BehavioursTutorialv9.x-default-description).
-   If you want the behaviour to run every time a user updates the value of a field, set up a server-side script to react to the user input**.** The option to add a server-side script appears once you have added a field. With a server-side script you can define more complex conditions to control the field state, value, and options. In addition, you can control how the field impacts other fields when changed. For example, you can use a server-side script in a behaviour to [validate if "other" is selected in a select-list](#id-.BehavioursTutorialv9.x-list-with-other) and show or hide an additional "other" option field. 

## Examples of behaviours

The following are simple examples for you to follow so you understand how behaviours work. Check out our [Behaviours Examples](https://docs.adaptavist.com/sr4js/latest/features/behaviours/behaviours-examples) documentation for more examples. 

### Create a simple behaviour (make a field read-only except for a certain role)

Before you start this tutorial, [create a select list custom field](https://confluence.atlassian.com/adminjiraserver/adding-custom-fields-1047552713.html#Addingcustomfields-Creatinganewcustomfield) called **Customer Type** with the following options:

-   Small Business - For-profit
    
-   Large Business - For-profit
    
-   General Training License
    

If you're using a test project, make sure this custom field is associated with the appropriate screens in your test project.

For this activity we're going to build a behaviour that restricts a custom field called **Customer Type** to only project administrators. You can use this same approach in your lab environment, or you can experiment with a different field or behaviour condition.

Expand to view steps...

1.  From ScriptRunner, navigate to **Behaviours**. 
2.  Select **Create Behaviour**.
3.  Enter a name for the behaviour. In this case we enter `Admins Only Customer Type Field`.
4.  Enter a description for the behaviour. This field is optional but in this case we enter `Restrict the Customer Type custom field to admins only`. 
5.  Select **Create Mapping**.
6.  Then select the project and issue type(s) to map this behaviour to. In this case we chose the **Great Adventure Tours** project and **All issue types**.
7.  Select **Add Mapping** to confirm the mapping.
8.  Select **Create** to create the behaviour.   
    ![](/sr4js/files/latest/273486399/273486392/1/1723732126000/Behaviour_tutorial_1.png)  
    You're taken to a screen where you can configure the behaviour further.
    
9.  Scroll to the **Add Field** field, select the **Customer Type** field, and then select **Add**.  
    ![](/sr4js/files/latest/273486399/273486394/1/1723732126000/Behaviour_tutorial_2.png)  
    You can now configure the options for **Customer Type.**
    
10.  Edit the **Writable/Readonly** field so it displays **Readonly**. This makes the field read only.   
     ![](/sr4js/files/latest/273486399/273486393/1/1723732126000/Behaviour_tutorial_3.png)
11.  Select **Add new condition**. The _Add condition_ pop-up displays. 
12.  Configure the condition as follows:
     1.  Select **Except** for _Applicability_. 
     2.  Select **User in project role** for _Condition_. 
     3.  Select **Administrators** for _Project role_.
     4.  Select **Add**.  
         ![](/sr4js/files/latest/273486399/273486395/1/1723732126000/Behaviour_tutorial_4.png)  
         This condition means that the **Readonly** configuration does not occur if the condition is true. The condition is true if the logged in user belongs to the **Administrators** project role. 
         
         If you only had one administrator or had a group specific to Administrators then you could also use the **Current user is** or **Current user in group** condition. 
         
13.  Select **Save Changes**.   
     Congratulations! You've created a behaviour! 
     
     You can test to see if this behaviour works by using the [switch user](https://docs.adaptavist.com/sr4js/latest/get-started/settings/switch-user-function#switchuser) function.
     

### Create a select list with 'other' as a writable or hidden option

Before you start this tutorial, [create a select list (single choice) custom field](https://confluence.atlassian.com/adminjiraserver/adding-custom-fields-1047552713.html#Addingcustomfields-Creatinganewcustomfield) called **Favorite Fruit** with the following options:

-   Apple
    
-   Orange
-   Banana
-   Grapes
-   Other

Also create a text field custom field called **Favorite Fruit (Other)**. If you're using a test project, make sure the custom fields are associated with the appropriate screens in your test project.

If you want the **Favorite Fruit (Other)** field to display below the **Favorite Fruit** field, you may have to [configure the screen(s)](https://confluence.atlassian.com/adminjiraserver/defining-a-screen-938847288.html#Definingascreen-Configuringscreen%27stabsandfields) the fields are associated with.

For this activity we're going to build a behaviour so that when the **Other** option is selected in a **Favorite Fruit** select list (single choice), the **Favorite Fruit (Other)** custom field appears and allows you to type what the 'Other' answer is. Additionally, the **Favorite Fruit (Other)** custom field is hidden if the 'Other' option is not selected. 

Expand to view steps...

1.  From ScriptRunner, navigate to **Behaviours**. 
2.  Select **Create Behaviour**.
3.  Enter a name for the behaviour. In this case we enter `Select list with 'other' as a writable or hidden option`.
4.  Enter a description for the behaviour. This field is optional but in this case we enter `When a user selects other as an option they're prompted to enter the option in another text field`. 
5.  Select **Create Mapping**.
6.  Then select the project and issue type(s) to map this behaviour to. In this case we chose the **Great Adventure Tours** project and **All issue types**.
7.  Select **Add Mapping** to confirm the mapping.
8.  Select **Create** to create the behaviour.   
    ![](/sr4js/files/latest/273486399/273486397/1/1723732126000/Behaviour_tutorial_other_1.png)  
    You're taken to a screen where you can configure the behaviour further.
    
9.  Scroll to the **Add Field** field, select the **Favorite Fruit** field, and then select **Add**.  
    We now need to add a server-side script to the field for it to show the additional text field when someone selects **Other** from the **Favorite Fruit** select list.
10.  Select **Create Script.  
     ![](/sr4js/files/latest/273486399/273486396/1/1723732126000/Behaviour_tutorial_other_2.png)  
     **
     
11.   Copy the following code into the inline script editor:
     
     ```
def otherFaveField = getFieldByName("Favorite Fruit (Other)")
def faveFruitField = getFieldById(getFieldChanged())

def selectedOption = faveFruitField.getValue() as String
def isOtherSelected = selectedOption == "Other"

otherFaveField.setHidden(!isOtherSelected)
otherFaveField.setRequired(isOtherSelected)
```
     
     Be aware if you used something other than the examples we have shown, the script needs to be changed to work for your situation.
     
12.  Select **Save Changes**.  
     Congratulations! You've created a behaviour!**![](/sr4js/files/latest/273486399/273486375/1/1723732127000/Favorite_fruit_gif.gif)  
     **
     
     You can now test to see if this behaviour works!
     

### Add a default description when creating an issue

Before you start this tutorial, create a sample project with the name _Great Adventure Licensing and Finance._

In this example, we set a default description for renewal issues in the Great Adventure Licensing and Finance project. This description contains set text to help the licensing specialists complete the issues, acting as a template to gather the correct information.

Expand to view steps...

1.  From ScriptRunner, navigate to **Behaviours**. 
2.  Select **Create Behaviour**.
3.  Enter a name for the behaviour. In this case we enter `Renewal Description`.
4.  Enter a description for the behaviour. This field is optional but in this case we enter `This behaviour adds a default description to new renewal issues`. 
5.  Select **Create Mapping**.
6.  Then select the project and issue type(s) to map this behaviour to. In this case we chose the **Great Adventure Licensing and Finance** project and **All issue types**.
7.  Select **Add Mapping** to confirm the mapping.
8.  Select **Create** to create the behaviour.   
    ![](/sr4js/files/latest/273486399/273486398/1/1723732126000/Behaviour_tutorial_renewal_1.png)  
    You're taken to a screen where you can configure the behaviour further.
    
9.  Select **Create Script** under **Initialiser**.
10.   Copy the following code into the inline script editor:  
     
     ```
def desc = getFieldById("description")

def defaultValue = """\
        h2. Renewal Information
        * Confirm Company Name:
        * Confirm Existing License:
        * Confirm Number of Users:
        * Confirm Type of License:
        
        h3. Notes
        Provide any notes on renewal. Copy/pate from proposals and email correspondence as needed.

        h3. Final Actions
        * Update Jira Issue with appropriate information.
        * Assign issue to Licensing lead for approval.
    """.stripIndent()

if (!desc.formValue) {
    desc.setFormValue(defaultValue)
}
```
     
11.  Select **Save Changes**.  
     Congratulations! You've created a behaviour!**  
     ![](/sr4js/files/latest/273486399/273486376/1/1723732127000/Behaviour_tutorial_renewal_gif.gif)**
     
     You can now test to see if this behaviour works!
     

  

* * *

## Related content

-   [Behaviours Examples](https://docs.adaptavist.com/sr4js/latest/features/behaviours/behaviours-examples)
-   [Using Behaviours Video](https://docs.adaptavist.com/sr4js/latest/training/course-introduction-to-scriptrunner-for-jira-data-center-server/1-2-video-using-behaviours-in-scriptrunner-for-jira-data-center-server)
-   [Get Help with Behaviours](https://docs.adaptavist.com/sr4js/latest/get-help/get-help-with-behaviours)
-   [Troubleshooting Behaviours](https://docs.adaptavist.com/sr4js/latest/get-help/troubleshooting/troubleshooting-behaviours)
