using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Web;
using System.Web.UI.WebControls;

namespace eTaleem
{
    public static class ControlManager
    {

        /*
         * Inputs the DatabaseContext class required, the name of the method in that class and the name of the Repeater that needs to be populated
         * Populates the Repeater 
         * No output
         */

        public static void populateControl(object db, string method, Repeater repeater)
        {

            Type type = db.GetType();                                   //Gets the type of the specified object
            PropertyInfo propertyInfo = type.GetProperty(method);       //Gets specified property from the object
            object values = propertyInfo.GetValue(db, null);            //Gets value at the specified property
            
            repeater.DataSource = values;                               //Populates Repeater
            repeater.DataBind();

        }

        /*
         * Inputs the list which is populated with the data to populate the Repeater and the name of the Repeater that needs to be populated
         * Populates the GridView 
         * No output
         */

        // Use if the entire table is not required to be fetched
        public static void populateControl(object list, Repeater repeater) 
        {
            repeater.DataSource = list;                               //Populates Repeater 
            repeater.DataBind();
        }

        /*
         * Inputs the list which is populated with the data to populate the DropDownList and the name of the Repeater that needs to be populated
         * Populates the DropDownList
         * No output
         */

        public static void populateControl(object list, DropDownList dropDownList)
        {

            dropDownList.DataSource = list;                           //Populates DropDownList 
            dropDownList.DataBind();

        }

        /*
         * Inputs a View
         * Finds all controls of type TextBox in that view and clears their text
         * No output
         */

        public static void clearTextBoxes(View view)
        {
            foreach (TextBox textBox in view.Controls.OfType<TextBox>())
            {
                textBox.Text = null;
            }
        }

        /*
         * Inputs a MultiView
         * Finds all controls of type TextBox in each of its Views and hides all the panels
         * No output
         */

        public static void hidePanels(MultiView multiView)
        {
            foreach(View view in multiView.Controls.OfType<View>())
            {
                foreach (Panel panel in view.Controls.OfType<Panel>())
                {
                    panel.Visible = false;
                }
            }
        }

        /*
         * Inputs the type (SubjectType in database)
         * Returns value based on the type, which will get appended to and become part of a CSS Style class from where the function was called
         */

        public static string setPanelColor(string type)
        {
            switch (type)
            {
                case "Languages":
                    return "success";
                case "Humanities and social sciences":
                    return "primary";
                case "Mathematics":
                    return "inverse";
                case "Creative and professional":
                    return "orange";
                case "Sciences":
                    return "teal";
                default:
                    return null;
            }
        }
    }
}