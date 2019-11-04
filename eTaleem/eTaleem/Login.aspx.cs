using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace eTaleem
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Session["User"] = null;
                Session["panelShow"] = null;

                mvLogin.ActiveViewIndex = 0;
                using (DatabaseDataContext db = new DatabaseDataContext())
                {
                    var subjects = db.tblSubjects.Where(x => x.isVisible).Select(s => new
                    {
                        subjectName = s.subjectTitle + " - " + s.subjectCode,
                        s.subjectCode
                    });

                    ddlRegisterSubject.DataTextField = "subjectName";
                    ddlRegisterSubject.DataValueField = "subjectCode";

                    ControlManager.populateControl(subjects, ddlRegisterSubject);
                }
            }

            //Hides the panels in all MultiViews

            //ControlManager.hidePanels(mvRegister);
            //ControlManager.hidePanels(mvLogin);
            //ControlManager.hidePanels(mvSubject);
            //ControlManager.hidePanels(mvButton);

          

        }

        
        protected void mvLogin_ActiveViewChanged(object sender, EventArgs e)
        {
            ControlManager.hidePanels(mvLogin);

        }

        //----------- mmLogin(0) ------ //

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            using (DatabaseDataContext db = new DatabaseDataContext())
            {
                tblUser user = db.tblUsers.Where(x => x.userEmail == txtLoginEmail.Text && x.userPassword == txtLoginPassword.Text).FirstOrDefault();

                if (user != null)
                {
                    Session["User"] = user;

                    SessionManager.UserID = user.userID;

                    if (user.userType.ToString().Equals("T"))
                    {
                        SessionManager.TeacherID = db.tblUsers.Join(
                                        db.tblTeachers,
                                        x => x.userID,
                                        y => y.userID,
                                        ((x, y) => new { tblUser = x, tblTeacher = y })).Where(x => x.tblUser.userEmail == user.userEmail).FirstOrDefault().tblTeacher.teacherID;

                        Response.Redirect("TeacherHome.aspx");
                    }
                    else if (user.userType.ToString().Equals("S"))
                    {
                        SessionManager.StudentID = db.tblUsers.Join(
                                        db.tblStudents,
                                        x => x.userID,
                                        y => y.userID,
                                        ((x, y) => new { tblUser = x, tblStudent = y })).Where(x => x.tblUser.userEmail == user.userEmail).FirstOrDefault().tblStudent.studentID;

                        Response.Redirect("StudentHome.aspx");
                    }
                }
                else
                {
                    pUnsuccessful.Visible = true;
                }

            }
        }

        protected void lbtnRegister_Click(object sender, EventArgs e)
        {
            mvLogin.ActiveViewIndex = 1;
            mvRegister.ActiveViewIndex = 0;
        }

        //----------- mvLogin(1) mvRegister(0) Select User Type View ----------//

        protected void btnUserTypeTeacher_Click(object sender, EventArgs e)
        {
            mvRegister.ActiveViewIndex = 1;
            mvSubject.ActiveViewIndex = 0;
            mvButton.ActiveViewIndex = 0;
        }

        protected void btnUserTypeStudent_Click(object sender, EventArgs e)
        {
            mvRegister.ActiveViewIndex = 1;
            mvSubject.ActiveViewIndex = 1;
            mvButton.ActiveViewIndex = 1;
        }

        //----------- mvLogin(1) mvRegister(1) Register Information View ---------//

        protected void cbNoSubject_CheckedChanged(object sender, EventArgs e)
        {
            if (cbNoSubject.Checked)
            {
                ddlRegisterSubject.Enabled = false;
            }
            else
            {
                ddlRegisterSubject.Enabled = true;
            }
        }

        protected void btnRegisterTeacher_Click(object sender, EventArgs e)
        {
            tblUser user = new tblUser
            {
                userEmail = txtRegisterEmail.Text,
                userPassword = txtRegisterPassword.Text,
                userType = 'T'
            };

            using (DatabaseDataContext db = new DatabaseDataContext())
            {

                //Check if the field that has been entered already exists
                if (db.tblUsers.Where(x => x.userEmail.Equals(txtRegisterEmail.Text)).FirstOrDefault() != null)
                {
                    //Make the label visible and break the onClick() function
                    lblRegisterEmail.Visible = true;
                    return;
                }

                db.tblUsers.InsertOnSubmit(user);
                db.SubmitChanges();

                int subjectCode = cbNoSubject.Checked ? 0 : Convert.ToInt32(ddlRegisterSubject.SelectedValue);

                tblTeacher teacher = new tblTeacher
                {
                    teacherFullName = txtRegisterName.Text,
                    subjectCode = subjectCode,
                    userID = db.tblUsers.Where(x => x.userEmail == txtRegisterEmail.Text).FirstOrDefault().userID
                };

                db.tblTeachers.InsertOnSubmit(teacher);
                db.SubmitChanges();
            }

            ControlManager.clearTextBoxes(vRegisterForm);

            lblRegisterEmail.Visible = false;
            mvLogin.ActiveViewIndex = 0;
            pRegister.Visible = true;
        }

        protected void btnStudentNext_Click(object sender, EventArgs e)
        {

            tblUser user = new tblUser
            {
                userEmail = txtRegisterEmail.Text,
                userPassword = txtRegisterPassword.Text,
                userType = 'S'
            };

            using (DatabaseDataContext db = new DatabaseDataContext())
            {

                //Check if the field that has been entered already exists
                if (db.tblUsers.Where(x => x.userEmail.Equals(txtRegisterEmail.Text)).FirstOrDefault() != null)
                {
                    //Make the label visible and break the onClick() function
                    lblRegisterEmail.Visible = true;
                    return;
                }

                lblRegisterEmail.Visible = false;

                db.tblUsers.InsertOnSubmit(user);
                db.SubmitChanges();

                tblStudent student = new tblStudent
                {
                    studentFullName = txtRegisterName.Text,

                    userID = db.tblUsers.Where(x => x.userEmail == txtRegisterEmail.Text).FirstOrDefault().userID
                };

                db.tblStudents.InsertOnSubmit(student);
                db.SubmitChanges();

                //Populating the Repeater in the next View


                //for (int i = 0; i < rRegisterTeachers.Items.Count; i++)
                //{
                //    DropDownList ddl = (DropDownList)rRegisterTeachers.Items[i].FindControl("ddlRegisterTeacher");

                //    Label label = (Label)rRegisterTeachers.Items[i].FindControl("lblSubjectName");
                //    int subjectCode = Convert.ToInt32(label.Text.Substring(label.Text.Length - 4));

                //    var teachers = db.tblTeachers.Where(x => x.subjectCode == subjectCode);

                //    ddl.DataTextField = "teacherFullName";
                //    ddl.DataValueField = "teacherID";

                //    ControlManager.populateControl(teachers, ddl);

                //    if (teachers.FirstOrDefault() == null)
                //    {
                //        ddl.Items.Insert(0, new ListItem("There are no teachers available for this subject", "0"));
                //        ddl.Enabled = false;
                //    }
                //}



                ControlManager.populateControl(getSubjectsQuery(db), rRegisterSubjects);

                mvRegister.ActiveViewIndex = 2;
                mvRegisterStudentButton.ActiveViewIndex = 0;
            }
        }

        //----------- mvLogin(0) mvRegister(2) ---------- //

        protected object getSubjectsQuery(DatabaseDataContext db)
        {
            var subjects = db.tblSubjects.Where(x => x.isVisible).Select(s => new
            {
                subjectName = s.subjectTitle + " - " + s.subjectCode,
                s.subjectGroup
            }).ToList();

            for (int i = 0; i < rRegisterSubjectsSelected.Items.Count; i++)
            {
                Button button = (Button)rRegisterSubjectsSelected.Items[i].FindControl("btnSubjectsSelected");

                //TODO: Edit so that it works with subjectCode

                string subjectName = button.Text;

                subjects = subjects.Where(x => x.subjectName != subjectName).ToList();
            }

            return subjects;
        }

        protected object getSubjectsSelectedQuery(DatabaseDataContext db)
        {
            var subjects = db.tblUsers.Join(
                db.tblStudents,
                x => x.userID,
                y => y.userID,
                ((x, y) => new { tblUser = x, tblStudent = y })).Join(
                    db.tblStudentSubjects,
                    y => y.tblStudent.studentID,
                    z => z.studentID,
                    ((y, z) => new { tblStudent = y, tblStudentSubject = z })).Join(
                        db.tblSubjects,
                        z => z.tblStudentSubject.subjectCode,
                        w => w.subjectCode,
                        ((z, w) => new { tblStudentSubject = z, tblSubject = w })).Where(x => x.tblStudentSubject.tblStudent.tblUser.userEmail == txtRegisterEmail.Text && x.tblSubject.isVisible && x.tblStudentSubject.tblStudentSubject.isVisible).Select(s => new
                        {
                            subjectName = s.tblSubject.subjectTitle + " - " + s.tblSubject.subjectCode,
                            s.tblSubject.subjectGroup,
                            s.tblSubject.subjectTitle
                        }).ToList();

            return subjects;

        }

        protected void btnSubjects_Click(object sender, EventArgs e)
        {
            int hashCode = sender.GetHashCode();

            for (int i = 0; i < rRegisterSubjects.Items.Count; i++)
            {
                Button button = (Button)rRegisterSubjects.Items[i].FindControl("btnSubjects");

                if (button.GetHashCode() == hashCode)
                {
                    using (DatabaseDataContext db = new DatabaseDataContext())
                    {
                        tblStudentSubject studentSubject = new tblStudentSubject
                        {
                            studentID = db.tblUsers.Join(
                                db.tblStudents,
                                x => x.userID,
                                y => y.userID,
                                ((x, y) => new { tblUser = x, tblStudent = y })).Where(x => x.tblUser.userEmail == txtRegisterEmail.Text).FirstOrDefault().tblStudent.studentID,
                            subjectCode = Convert.ToInt32(button.Text.Substring(button.Text.Length - 4)),
                            isVisible = true
                        };

                        db.tblStudentSubjects.InsertOnSubmit(studentSubject);
                        db.SubmitChanges();


                        ControlManager.populateControl(getSubjectsSelectedQuery(db), rRegisterSubjectsSelected);
                        ControlManager.populateControl(getSubjectsQuery(db), rRegisterSubjects);

                    }
                }
            }
        }

        protected void btnSubjectsSelected_Click(object sender, EventArgs e)
        {
            int hashCode = sender.GetHashCode();

            for (int i = 0; i < rRegisterSubjectsSelected.Items.Count; i++)
            {
                Button button = (Button)rRegisterSubjectsSelected.Items[i].FindControl("btnSubjectsSelected");

                if (button.GetHashCode() == hashCode)
                {
                    int id = Convert.ToInt32(button.Text.Substring(button.Text.Length - 4));

                    using (DatabaseDataContext db = new DatabaseDataContext())
                    {
                        tblStudentSubject studentSubject = db.tblStudentSubjects.Where(x => x.subjectCode == id && x.tblStudent.tblUser.userEmail == txtRegisterEmail.Text).FirstOrDefault();
                        studentSubject.isVisible = false;

                        db.SubmitChanges();

                        ControlManager.populateControl(getSubjectsSelectedQuery(db), rRegisterSubjectsSelected);
                        ControlManager.populateControl(getSubjectsQuery(db), rRegisterSubjects);
                    }
                }
            }

            if (rRegisterSubjectsSelected.Items.Count <= 3)
            {
                mvRegisterStudentButton.ActiveViewIndex = 0;
            }
        }

        protected void btnConfirmStudent_Click(object sender, EventArgs e)
        {
            mvRegister.ActiveViewIndex = 3;
            mvRegisterStudentButton.ActiveViewIndex = 0;


        }

        protected void btnNextStudent_Click(object sender, EventArgs e)
        {
            if (rRegisterSubjectsSelected.Items.Count != 0)
            {
                if (rRegisterSubjectsSelected.Items.Count > 3)
                {
                    pNoSubjects.Visible = false;
                    p3OrMoreSubjects.Visible = true;
                    pLessThan3Subjects.Visible = false;
                    mvRegisterStudentButton.ActiveViewIndex = 1;
                }
                else if (rRegisterSubjectsSelected.Items.Count < 3)
                {
                    pNoSubjects.Visible = false;
                    p3OrMoreSubjects.Visible = false;
                    pLessThan3Subjects.Visible = true;


                }
                else
                {

                    //Populating the repeater in the next view

                    //using (DatabaseDataContext db = new DatabaseDataContext())
                    //{
                    //    ControlManager.populateControl(getSubjectsSelectedQuery(db), rRegisterTeachers);

                    //    for (int i = 0; i < rRegisterTeachers.Items.Count; i++)
                    //    {
                    //        DropDownList ddl = (DropDownList)rRegisterTeachers.Items[i].FindControl("ddlRegisterTeacher");

                    //        Label label = (Label)rRegisterTeachers.Items[i].FindControl("lblSubjectName");
                    //        int subjectCode = Convert.ToInt32(label.Text.Substring(label.Text.Length - 4));

                    //        List<tblTeacher> teachers = db.tblTeachers.Where(x => x.subjectCode == subjectCode).ToList();
                    //        ControlManager.populateControl(teachers, ddl);

                    //        ddl.DataTextField = "teacherFullName";
                    //        ddl.DataValueField = "teacherID";

                    //    }

                    //    mvRegister.ActiveViewIndex = 3;

                    mvLogin.ActiveViewIndex = 0;
                    pRegister.Visible = true;
                }
            }
            else
            {
                pNoSubjects.Visible = true;
                p3OrMoreSubjects.Visible = false;
                pLessThan3Subjects.Visible = false;
                mvRegisterStudentButton.ActiveViewIndex = 0;

            }
        }

        //----------- Teachers Page ---------- //

        protected void btnRegisterStudent_Click(object sender, EventArgs e)
        {
            using (DatabaseDataContext db = new DatabaseDataContext())
            {
                int studentID = db.tblUsers.Join(
                                db.tblStudents,
                                x => x.userID,
                                y => y.userID,
                                ((x, y) => new { tblUser = x, tblStudent = y })).Where(x => x.tblUser.userEmail == txtRegisterEmail.Text).FirstOrDefault().tblStudent.studentID;



                //for (int i = 0; i < rRegisterTeachers.Items.Count; i++)
                //{
                //    Label label = (Label)rRegisterTeachers.Items[i].FindControl("lblSubjectName");
                //    int subjectCode = Convert.ToInt32(label.Text.Substring(label.Text.Length - 4));

                //    tblStudentSubject studentSubject = db.tblStudentSubjects.Where(x => x.studentID == studentID && x.subjectCode == subjectCode).First();

                //    DropDownList ddl = (DropDownList)rRegisterTeachers.Items[i].FindControl("ddlRegisterTeacher");

                //    studentSubject.teacherID = (int?)Convert.ToInt32(ddl.SelectedValue);
                //    studentSubject.joiningDate = DateTime.Now.Date.ToLongDateString();

                //    db.SubmitChanges();
                //}
            }

            mvLogin.ActiveViewIndex = 0;
            pRegister.Visible = true;

        }
    }
}