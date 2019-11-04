using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace eTaleem
{
    public partial class Home : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

            }

            using (DatabaseDataContext db = new DatabaseDataContext())
            {
                var list = db.tblStudents.Join(
                        db.tblStudentSubjects,
                        x => x.studentID,
                        y => y.studentID,
                        (x, y) => new { tblStudent = x, tblStudentSubject = y }).Join(
                            db.tblSubjects,
                            y => y.tblStudentSubject.subjectCode,
                            z => z.subjectCode,
                            (y, z) => new { tblStudentSubject = y, tblSubject = z }
                            ).Where(x => x.tblStudentSubject.tblStudentSubject.isVisible && x.tblStudentSubject.tblStudent.studentID == SessionManager.StudentID).Select(s => new
                            {
                                s.tblSubject.subjectCode,
                                s.tblSubject.subjectGroup,
                                s.tblSubject.subjectDescription,
                                s.tblSubject.subjectTitle
                            });

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

        protected void btnHomeBrowseSubjects_Click(object sender, EventArgs e)
        {
            Response.Redirect("StudentSubjects.aspx");
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
                    Label label = (Label)subjectsCatalogRepeater.Items[i].FindControl("lblSubjectCode");

                    DropDownList ddl = (DropDownList)subjectsCatalogRepeater.Items[i].FindControl("ddlChangeTeacher");



                    using (DatabaseDataContext db = new DatabaseDataContext())
                    {
                        var teachers = db.tblTeachers.Where(x => x.subjectCode == Convert.ToInt32(label.Text));

                        ddl.DataTextField = "teacherFullName";
                        ddl.DataValueField = "teacherID";

                        ControlManager.populateControl(teachers, ddl);

                        Session["ddl"] = Convert.ToInt32(ddl.Items[0].Value);


                    }

                    MultiView mv = (MultiView)subjectsCatalogRepeater.Items[i].FindControl("mvPanelFooter");
                    mv.ActiveViewIndex = 2;

                    mv = (MultiView)subjectsCatalogRepeater.Items[i].FindControl("mvPanelBody");
                    mv.ActiveViewIndex = 1;
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

                    using (DatabaseDataContext db = new DatabaseDataContext())
                    {
                        var teachers = db.tblTeachers.Where(x => x.subjectCode == Convert.ToInt32(label.Text));

                        ddl.DataTextField = "teacherFullName";
                        ddl.DataValueField = "teacherID";

                        ControlManager.populateControl(teachers, ddl);

                        Session["ddl"] = Convert.ToInt32(ddl.Items[0].Value);


                    }

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
                Button button = (Button)subjectsCatalogRepeater.Items[i].FindControl("btnEnroll");

                if (button.GetHashCode() == hash)
                {

                    Label label = (Label)subjectsCatalogRepeater.Items[i].FindControl("lblSubjectCode");
                    DropDownList ddl = (DropDownList)subjectsCatalogRepeater.Items[i].FindControl("ddlChangeTeacher");

                    using (DatabaseDataContext db = new DatabaseDataContext())
                    {
                        tblStudentSubject studentSubject = db.tblStudentSubjects.Where(x => x.subjectCode == Convert.ToInt32(label.Text) && x.isVisible && x.studentID == SessionManager.StudentID).FirstOrDefault();

                        studentSubject.teacherID = Convert.ToInt32(ddl.SelectedValue.ToString());
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


                    using (DatabaseDataContext db = new DatabaseDataContext())
                    {
                        tblStudentSubject tbl = db.tblStudentSubjects.Where(x => x.studentID == SessionManager.UserID && x.subjectCode == Convert.ToInt32(label.Text) && x.teacherID == Convert.ToInt32(Session["ddl"])).FirstOrDefault();

                        if (tbl != null)
                        {
                            db.tblStudentSubjects.DeleteOnSubmit(tbl);
                            db.SubmitChanges();
                        }
                    }
                    using (DatabaseDataContext db = new DatabaseDataContext())
                    {
                        tblStudentSubject studentSubject = new tblStudentSubject
                        {
                            studentID = SessionManager.StudentID,
                            subjectCode = Convert.ToInt32(label.Text),
                            teacherID = Convert.ToInt32(Session["ddl"]),
                            isVisible = true
                        };


                        db.tblStudentSubjects.InsertOnSubmit(studentSubject);
                        db.SubmitChanges();
                    }

                    MultiView mv = (MultiView)subjectsCatalogRepeater.Items[i].FindControl("mvPanelBody");
                    mv.ActiveViewIndex = 0;

                    mv = (MultiView)subjectsCatalogRepeater.Items[i].FindControl("mvPanelFooter");
                    mv.ActiveViewIndex = 0;
                }
            }
        }

        protected void ddlChangeTeacher_SelectedIndexChanged(object sender, EventArgs e)
        {

            int hash = sender.GetHashCode();

            for (int i = 0; i < subjectsCatalogRepeater.Items.Count; i++)
            {
                if (subjectsCatalogRepeater.Items[i].FindControl("ddlChangeTeacher").GetHashCode() == hash)
                {
                    DropDownList ddl = (DropDownList)subjectsCatalogRepeater.Items[i].FindControl("ddlChangeTeacher");
                    Session["ddl"] = ddl.SelectedValue;
                }
            }
        }


    }
}