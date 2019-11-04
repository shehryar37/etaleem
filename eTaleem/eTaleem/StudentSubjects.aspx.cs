using System;
using System.Collections.Generic;
using System.Data.Linq;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace eTaleem
{
    public partial class Subjects : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                mvSubjects.ActiveViewIndex = 0;
            }

            using (DatabaseDataContext db = new DatabaseDataContext())
            {
                var list = db.tblSubjects.Where(x => x.isVisible).SortBy("subjectTitle").ToList();

                ControlManager.populateControl(list, subjectsCatalogRepeater);

                tblUser user = (tblUser)Session["User"];

                var studentSubjects = db.tblStudentSubjects.Where(x => x.studentID == SessionManager.StudentID).ToList();

                for (int i = 0; i < subjectsCatalogRepeater.Items.Count; i++)
                {
                    Label label = (Label)subjectsCatalogRepeater.Items[i].FindControl("lblSubjectCode");

                    if (studentSubjects.Where(x => x.subjectCode == Convert.ToInt32(label.Text) && x.isVisible).FirstOrDefault() == null)
                    {
                        MultiView mv = (MultiView)subjectsCatalogRepeater.Items[i].FindControl("mvPanelFooter");

                        mv.ActiveViewIndex = 1;
                    }
                    else
                    {
                        MultiView mv = (MultiView)subjectsCatalogRepeater.Items[i].FindControl("mvPanelFooter");

                        Button button = (Button)subjectsCatalogRepeater.Items[i].FindControl("btnChangeTeacher");

                        if (studentSubjects.Where(x => x.subjectCode == Convert.ToInt32(label.Text) && x.isVisible && x.studentID == SessionManager.StudentID && x.teacherID != null).FirstOrDefault() == null)
                        {

                            button = (Button)subjectsCatalogRepeater.Items[i].FindControl("btnChangeTeacher");

                            button.Text = "Choose teacher";
                            button.CssClass += "btn btn-info";

                        }
                        else
                        {
                            button.CssClass += "btn btn-orange";
                        }

                        mv.ActiveViewIndex = 0;
                    }

                    MultiView mvBody = (MultiView)subjectsCatalogRepeater.Items[i].FindControl("mvPanelBody");
                    mvBody.ActiveViewIndex = 0;

                }
            }
        }

        public string setPanelColor(string type)
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

        // ------------- Buttons on the Panel --------------- //

        protected void btnChangeTeacher_Click(object sender, EventArgs e)
        {

            int hash = sender.GetHashCode();

            for (int i = 0; i < subjectsCatalogRepeater.Items.Count; i++)
            {
                Button button = (Button)subjectsCatalogRepeater.Items[i].FindControl("btnChangeTeacher");

                if (button.GetHashCode() == hash)
                {
                    //        Label label = (Label)subjectsCatalogRepeater.Items[i].FindControl("lblSubjectCode");

                    //        DropDownList ddl = (DropDownList)subjectsCatalogRepeater.Items[i].FindControl("ddlChangeTeacher");

                    //        TextBox textBox = (TextBox)subjectsCatalogRepeater.Items[i].FindControl("txtCurrentTeacher");

                    //        using (DatabaseDataContext db = new DatabaseDataContext())
                    //        {
                    //            int? teacher = db.tblStudentSubjects.Where(x => x.studentID == SessionManager.StudentID && x.subjectCode == Convert.ToInt32(label.Text) && x.isVisible).FirstOrDefault().teacherID;

                    //            tblTeacher currentTeacher;

                    //            if (teacher == null)
                    //            {

                    //                textBox.Text = "No current teacher";
                    //            }
                    //            else
                    //            {
                    //                currentTeacher = db.tblTeachers.Where(x => x.teacherID == teacher).FirstOrDefault();
                    //                textBox.Text = currentTeacher.teacherFullName;

                    //            }

                    //            var teachers = db.tblTeachers.Where(x => x.subjectCode == Convert.ToInt32(label.Text) && x.teacherID != teacher);

                    //            ddl.DataTextField = "teacherFullName";
                    //            ddl.DataValueField = "teacherID";

                    //            ControlManager.populateControl(db, teachers, ddl);

                    //            if(ddl.Items.Count == 0)
                    //            {
                    //                ddl.Enabled = false;
                    //                Button confirmButton = (Button)subjectsCatalogRepeater.Items[i].FindControl("btnChangeConfirmTeacher");
                    //                confirmButton.Enabled = false;
                    //            }

                    //        }

                    MultiView mv = (MultiView)subjectsCatalogRepeater.Items[i].FindControl("mvPanelFooter");
                    mv.ActiveViewIndex = 2;

                    mv = (MultiView)subjectsCatalogRepeater.Items[i].FindControl("mvPanelBody");
                    mv.ActiveViewIndex = 1;

                    break;
                }
            }
        }

        protected void btnLeave_Click(object sender, EventArgs e)
        {
            int hash = sender.GetHashCode();

            for (int i = 0; i < subjectsCatalogRepeater.Items.Count; i++)
            {
                Button button = (Button)subjectsCatalogRepeater.Items[i].FindControl("btnLeave");

                if (button.GetHashCode() == hash)
                {

                    MultiView mv = (MultiView)subjectsCatalogRepeater.Items[i].FindControl("mvPanelFooter");
                    mv.ActiveViewIndex = 3;

                    mv = (MultiView)subjectsCatalogRepeater.Items[i].FindControl("mvPanelBody");
                    mv.ActiveViewIndex = 0;
                }
            }
        }

        protected void btnEnroll_Click(object sender, EventArgs e)
        {
            int hash = sender.GetHashCode();

            for (int i = 0; i < subjectsCatalogRepeater.Items.Count; i++)
            {
                Button button = (Button)subjectsCatalogRepeater.Items[i].FindControl("btnEnroll");

                if (button.GetHashCode() == hash)
                {
                    Label label = (Label)subjectsCatalogRepeater.Items[i].FindControl("lblSubjectCode");

                    DropDownList ddl = (DropDownList)subjectsCatalogRepeater.Items[i].FindControl("ddlChangeTeacher");

                    TextBox textBox = (TextBox)subjectsCatalogRepeater.Items[i].FindControl("txtCurrentTeacher");

                    using (DatabaseDataContext db = new DatabaseDataContext())
                    {
                        var teachers = db.tblTeachers.Where(x => x.subjectCode == Convert.ToInt32(label.Text));

                        ddl.DataTextField = "teacherFullName";
                        ddl.DataValueField = "teacherID";

                        textBox.Text = "No current teacher";

                        ControlManager.populateControl(teachers, ddl);
                       
                    }

                    if (ddl.Items.Count == 0)
                    {
                        ddl.Enabled = false;
                        Button confirmButton = (Button)subjectsCatalogRepeater.Items[i].FindControl("btnEnrollConfirmEnroll");
                        confirmButton.Enabled = false;
                    }

                    //AsyncPostBackTrigger trigger = new AsyncPostBackTrigger();
                    //trigger.ControlID = button.UniqueID;
                    //trigger.EventName = "Click";
                    //upRepeater.Triggers.Add(trigger);

                    MultiView mv = (MultiView)subjectsCatalogRepeater.Items[i].FindControl("mvPanelFooter");
                    mv.ActiveViewIndex = 4;

                    mv = (MultiView)subjectsCatalogRepeater.Items[i].FindControl("mvPanelBody");
                    mv.ActiveViewIndex = 1;
                }
            }
        }

        protected void Cancel(object sender, string buttonName, int mvPanelFooterIndex)
        {
            int hash = sender.GetHashCode();

            for (int i = 0; i < subjectsCatalogRepeater.Items.Count; i++)
            {
                Button button = (Button)subjectsCatalogRepeater.Items[i].FindControl(buttonName);

                if (button.GetHashCode() == hash)
                {
                    MultiView mv = (MultiView)subjectsCatalogRepeater.Items[i].FindControl("mvPanelBody");
                    mv.ActiveViewIndex = 0;

                    mv = (MultiView)subjectsCatalogRepeater.Items[i].FindControl("mvPanelFooter");
                    mv.ActiveViewIndex = mvPanelFooterIndex;
                }
            }
        }

        protected void btnChangeTeacherCancel_Click(object sender, EventArgs e)
        {
            Cancel(sender, "btnChangeTeacherCancel", 0);
        }

        protected void btnChangeConfirmTeacher_Click(object sender, EventArgs e)
        {
            int hash = sender.GetHashCode();

            for (int i = 0; i < subjectsCatalogRepeater.Items.Count; i++)
            {
                Button button = (Button)subjectsCatalogRepeater.Items[i].FindControl("btnChangeConfirmTeacher");

                if (button.GetHashCode() == hash)
                {

                    Label label = (Label)subjectsCatalogRepeater.Items[i].FindControl("lblSubjectCode");
                    DropDownList ddl = (DropDownList)subjectsCatalogRepeater.Items[i].FindControl("ddlChangeTeacher");

                    using (DatabaseDataContext db = new DatabaseDataContext())
                    {
                        tblStudentSubject studentSubject = db.tblStudentSubjects.Where(x => x.subjectCode == Convert.ToInt32(label.Text) && x.isVisible && x.studentID == SessionManager.StudentID).FirstOrDefault();

                        studentSubject.teacherID = Convert.ToInt32(ddl.SelectedValue);
                        studentSubject.joiningDate = DateTime.Now.ToLongDateString();
                        db.SubmitChanges();

                        NotificationManager.enrollSubjectNotification(Convert.ToInt32(ddl.SelectedValue));

                        TextBox textBox = (TextBox)subjectsCatalogRepeater.Items[i].FindControl("txtCurrentTeacher");

                        string currentTeacher = textBox.Text;

                        int teacherID = db.tblTeachers.Where(x => x.subjectCode == Convert.ToInt32(label.Text) && x.teacherFullName.Equals(textBox.Text)).FirstOrDefault().teacherID;

                        NotificationManager.leaveSubjectNotification(teacherID);
                    }
                }
            }
        }

        protected void btnLeaveCancel_Click(object sender, EventArgs e)
        {
            Cancel(sender, "btnLeaveCancel", 0);
        }

        protected void btnLeaveConfirmLeave_Click(object sender, EventArgs e)
        {
            int hash = sender.GetHashCode();

            for (int i = 0; i < subjectsCatalogRepeater.Items.Count; i++)
            {
                Button button = (Button)subjectsCatalogRepeater.Items[i].FindControl("btnLeaveConfirmLeave");

                if (button.GetHashCode() == hash)
                {

                    Label label = (Label)subjectsCatalogRepeater.Items[i].FindControl("lblSubjectCode");

                    using (DatabaseDataContext db = new DatabaseDataContext())
                    {
                        tblStudentSubject studentSubject = db.tblStudentSubjects.Where(x => x.subjectCode == Convert.ToInt32(label.Text) && x.isVisible && x.studentID == SessionManager.StudentID).FirstOrDefault();

                        studentSubject.isVisible = false;
                        db.SubmitChanges();

                        int userID = db.tblTeachers.Where(x => x.teacherID == studentSubject.teacherID).FirstOrDefault().userID;

                        NotificationManager.leaveSubjectNotification(userID);
                    }

                    MultiView mv = (MultiView)subjectsCatalogRepeater.Items[i].FindControl("mvPanelBody");
                    mv.ActiveViewIndex = 0;

                    mv = (MultiView)subjectsCatalogRepeater.Items[i].FindControl("mvPanelFooter");
                    mv.ActiveViewIndex = 1;
                }
            }
        }

        protected void btnEnrollCancel_Click(object sender, EventArgs e)
        {
            Cancel(sender, "btnEnrollCancel", 1);
        }

        protected void btnEnrollConfirmEnroll_Click(object sender, EventArgs e)
        {
            int hash = sender.GetHashCode();

            for (int i = 0; i < subjectsCatalogRepeater.Items.Count; i++)
            {
                Button button = (Button)subjectsCatalogRepeater.Items[i].FindControl("btnEnrollConfirmEnroll");

                if (button.GetHashCode() == hash)
                {

                    Label label = (Label)subjectsCatalogRepeater.Items[i].FindControl("lblSubjectCode");
                    DropDownList ddl = (DropDownList)subjectsCatalogRepeater.Items[i].FindControl("ddlChangeTeacher");

                    //ddl.DataValueField = "teacherID";
                    //ddl.DataTextField = "teacherFullName";
                    //ddl.DataBind();

                    using (DatabaseDataContext db = new DatabaseDataContext())
                    {
                        tblStudentSubject tbl = db.tblStudentSubjects.Where(x => x.studentID == SessionManager.StudentID && x.subjectCode == Convert.ToInt32(label.Text)).FirstOrDefault();

                        if (tbl != null)
                        {
                            db.tblStudentSubjects.DeleteOnSubmit(tbl);
                            db.SubmitChanges();
                        }
                    }
                    using (DatabaseDataContext db = new DatabaseDataContext())
                    {
                        tblStudentSubject studentSubject = new tblStudentSubject();


                        studentSubject.studentID = SessionManager.StudentID;
                        studentSubject.subjectCode = Convert.ToInt32(label.Text);
                        studentSubject.teacherID = Convert.ToInt32(ddl.SelectedValue);
                        studentSubject.isVisible = true;
                        studentSubject.joiningDate = DateTime.Now.Date.ToLongDateString();


                        db.tblStudentSubjects.InsertOnSubmit(studentSubject);
                        db.SubmitChanges();

                        int userID = db.tblTeachers.Where(x => x.teacherID == Convert.ToInt32(ddl.SelectedValue)).FirstOrDefault().userID;

                        NotificationManager.enrollSubjectNotification(userID);
                    }

                    MultiView mv = (MultiView)subjectsCatalogRepeater.Items[i].FindControl("mvPanelBody");
                    mv.ActiveViewIndex = 0;

                    mv = (MultiView)subjectsCatalogRepeater.Items[i].FindControl("mvPanelFooter");
                    mv.ActiveViewIndex = 0;

                    break;
                }
            }
        }

        protected void subjectsCatalogRepeater_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            Label label = (Label)e.Item.FindControl("lblSubjectCode");
            DropDownList ddl = (DropDownList)e.Item.FindControl("ddlChangeTeacher");
            TextBox textBox = (TextBox)e.Item.FindControl("txtCurrentTeacher");

            using (DatabaseDataContext db = new DatabaseDataContext())
            {
                tblStudentSubject teacher = db.tblStudentSubjects.Where(x => x.studentID == SessionManager.StudentID && x.subjectCode == Convert.ToInt32(label.Text) && x.isVisible).FirstOrDefault();

                tblTeacher currentTeacher;
                int? teacherID;

                object teachers;

                if (teacher == null)
                {
                    teacherID = null;
                    textBox.Text = "No current teacher";

                    teachers = db.tblTeachers.Where(x => x.subjectCode == Convert.ToInt32(label.Text)).ToList();
                }
                else
                {
                    currentTeacher = db.tblTeachers.Where(x => x.teacherID == teacher.teacherID).FirstOrDefault();
                    textBox.Text = currentTeacher.teacherFullName;
                    teacherID = teacher.teacherID;

                    teachers = db.tblTeachers.Where(x => x.subjectCode == Convert.ToInt32(label.Text) && x.teacherID != teacherID).ToList();

                }

                ddl.DataTextField = "teacherFullName";
                ddl.DataValueField = "teacherID";

                ControlManager.populateControl(teachers, ddl);

                if (ddl.Items.Count == 0)
                {
                    ddl.Enabled = false;
                    Button confirmButton = (Button)e.Item.FindControl("btnChangeConfirmTeacher");
                    confirmButton.Enabled = false;

                    confirmButton = (Button)e.Item.FindControl("btnEnrollConfirmEnroll");
                    confirmButton.Enabled = false;
                }
            }
        }
    }
}
