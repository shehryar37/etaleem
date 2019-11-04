using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace eTaleem
{
    public partial class StudentAssignments : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                
            }

            using(DatabaseDataContext db = new DatabaseDataContext())
            {

                var assignments = db.tblStudentAssignments.Where(x => x.studentID == SessionManager.StudentID).Join(
                    db.tblAssignments,
                    x => x.assignmentID,
                    y => y.assignmentID,
                    (x, y) => new { tblStudentAssignment = x, tblAssignment = y }).ToList();
                    

                rAssignment.DataSource = assignments;
            }

            
        }
    }
}