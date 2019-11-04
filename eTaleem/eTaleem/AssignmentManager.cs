using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace eTaleem
{
    public class AssignmentManager
    {


        /*
         * Inputs the date on which the the assignment will end and whether it is graded or not  
         * Outputs the color which will get appended to a CSS style class from where the function was called
         */

        public static string getPanelColor(DateTime endDate, bool isGraded)
        {

            return endDate < DateTime.Now.Date ? isGraded ? "success" : "danger" : "primary";
        }
    }
}