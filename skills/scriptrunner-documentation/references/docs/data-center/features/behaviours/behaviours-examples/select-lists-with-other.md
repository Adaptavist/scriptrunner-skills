# Select Lists with Other

- Platform: data-center
- Space: SR4JS
- Hierarchy: features > behaviours > behaviours-examples
- Doc ID: doc-sr4js-442889133
- Source: https://docs.adaptavist.com/sr4js/latest/features/behaviours/behaviours-examples/select-lists-with-other

As an Administrator, you may want to create a select list where users are asked to select an option. To accommodate preferences not included in the predefined options, _Other_ is provided as a choice. When selected, you want this option to reveal an additional text input field.

In this example, we build a behaviour so that when the **Other** option is selected in a **Favourite Fruit** select list (single choice), the **Favourite Fruit (Other)** custom field appears and allows you to type what the _Other_ answer is. Additionally, the **Favourite Fruit (Other)** custom field is hidden if the _Other_ option is not selected. 

Before you start this example, [create a select list (single choice) custom field](https://confluence.atlassian.com/adminjiraserver/adding-custom-fields-1047552713.html#Addingcustomfields-Creatinganewcustomfield) called **Favourite Fruit** with the following options:

-   Apple
    
-   Orange
-   Banana
-   Grapes
-   Other

Also create a text field custom field called **Favourite Fruit (Other)**. If you're using a test project, make sure the custom fields are associated with the appropriate screens in your test project.

If you want the **Favourite Fruit (Other)** field to display below the **Favourite Fruit** field, you may have to [configure the screen(s)](https://confluence.atlassian.com/adminjiraserver/defining-a-screen-938847288.html#Definingascreen-Configuringscreen%27stabsandfields) the fields are associated with.

1.  From ScriptRunner, navigate to **Behaviours**. 
2.  Select **Create Behaviour**.
3.  Enter a name for the behaviour. In this case we enter `Select list with 'other' as a writable or hidden option`.
4.  Optional: Enter a description for the behaviour.
5.  Select **Create Mapping**.
6.  Then select the project and issue type(s) to map this behaviour to.
7.  Select **Add Mapping** to confirm the mapping.
8.  Select **Create** to create the behaviour.   
    ![](/sr4js/files/latest/442889133/441364084/1/1730980915000/Behaviour_tutorial_other_1.png)  
    You're taken to a screen where you can configure this behaviour further.
    
9.  Scroll to the **Add Field** field, select the **Favourite Fruit** field, and then select **Add**.
    
    We now need to add a server-side script to the field for it to show the additional text field when someone selects **Other** from the **Favourite Fruit** select list.
    
10.  Select **Create Script.  
     ![](/sr4js/files/latest/442889133/441364085/1/1730980915000/Behaviour_tutorial_other_2.png)  
     **
     
11.   Copy the following code into the inline script editor:
     
     ```
def otherFaveField = getFieldByName("Favourite Fruit (Other)")
def faveFruitField = getFieldById(getFieldChanged())

def selectedOption = faveFruitField.getValue() as String
def isOtherSelected = selectedOption == "Other"

otherFaveField.setHidden(!isOtherSelected)
otherFaveField.setRequired(isOtherSelected)
```
     
       
     
     This example makes use of `getFieldChanged()`, which always returns the field ID of the field the behaviour fires for.
     
     Be aware if you used something other than the examples we have shown, the script needs to be changed to work for your situation.
     
12.  Select **Save Changes**.
     
     You can now test to see if this behaviour works!
     
     ![](/sr4js/files/latest/442889133/441364086/1/1730980915000/Favorite_fruit_gif.gif)
     

  

* * *

## Related content

-   [Behaviours Examples](https://docs.adaptavist.com/sr4js/latest/features/behaviours/behaviours-examples)
-   [Behaviours](https://docs.adaptavist.com/sr4js/latest/features/behaviours)
-   [Behaviours Tutorial](https://docs.adaptavist.com/sr4js/latest/features/behaviours/behaviours-tutorial)
