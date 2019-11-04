using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace eTaleem
{
    public partial class TeacherAssignments : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            List<tblAssignment> assignments = new List<tblAssignment>();

            if (!IsPostBack)
            {
                mvTeacherAssignments.ActiveViewIndex = 0;
                Session["panelShow"] = null;

                using (DatabaseDataContext db = new DatabaseDataContext())
                {
                    assignments = db.tblAssignments.Where(x => x.teacherID == SessionManager.TeacherID && x.isArchived == false).SortBy("assignmentEndDate").ToList();

                    Session["assignmentList"] = assignments;

                    ControlManager.populateControl(assignments, rAssignment);

                    panelSetup(assignments);
                }
            }
            else
            {
                using (DatabaseDataContext db = new DatabaseDataContext())
                {
                    assignments = Session["assignmentList"] as List<tblAssignment>;

                    //Populates the Panels
                    ControlManager.populateControl(assignments, rAssignment);

                    panelSetup(assignments);
                }
            }
        }

        protected void panelSetup(List<tblAssignment> assignments)
        {
            bool[] panelShow = new bool[assignments.Count];

            if (Session["panelShow"] == null)
            {
                Session["panelShow"] = panelShow;
            }

            panelShow = Session["panelShow"] as bool[];

            foreach (RepeaterItem item in rAssignment.Items)
            {

                MultiView mv = item.FindControl("mvToggle") as MultiView;
                Panel pAssignmentBody = item.FindControl("pAssignmentBody") as Panel;

                if (panelShow[item.ItemIndex])
                {
                    mv.ActiveViewIndex = 0;
                    pAssignmentBody.Visible = true;
                }
                else
                {
                    mv.ActiveViewIndex = 1;
                    pAssignmentBody.Visible = false;
                }
            }

        }

        protected void btnAssignmentAdd_Click(object sender, EventArgs e)
        {
            mvTeacherAssignments.ActiveViewIndex = 1;
        }

        // -------------- Form View --------------- //

        protected void btnSubmit_Click(object sender, EventArgs e)
        {

            if(DateTime.Parse(dtStartDate.Text).Date <= DateTime.Now.Date)
            {
                regStartDate.Visible = true;
                return;
            }
            else
            {
                regStartDate.Visible = false;
            }

            if (DateTime.Parse(dtStartDate.Text).Date >= DateTime.Parse(dtEndDate.Text).Date)
            {
                regEndDate.Visible = true;
                return;
            }
            else
            {
                regEndDate.Visible = false;
            }

            string extension;

            var postedFileExtension = Path.GetExtension(fuSupplementaryFiles.FileName);
            if (!string.Equals(postedFileExtension, ".pdf", StringComparison.OrdinalIgnoreCase)
                && !string.Equals(postedFileExtension, ".docx", StringComparison.OrdinalIgnoreCase)) {

                lSupplementaryFiles.Visible = true;

                return;
            }
            else
            {

                if(string.Equals(postedFileExtension, ".pdf", StringComparison.OrdinalIgnoreCase)) {
                    extension = ".pdf";
                }
                else
                {
                    extension = ".docx";
                }

                lSupplementaryFiles.Visible = false;
            }

            using (DatabaseDataContext db = new DatabaseDataContext())
            {
                string fileName = fuSupplementaryFiles.HasFile ? (txtAssignmentTitle.Text + SessionManager.TeacherID + extension) : null;

                tblAssignment assignment = new tblAssignment
                {
                    assignmentQuestionStatement = txtQuestionStatement.Text,
                    assignmentTitle = txtAssignmentTitle.Text,
                    assignmentStartDate = DateTime.Parse(dtStartDate.Text),
                    assignmentEndDate = DateTime.Parse(dtEndDate.Text),
                    isGraded = false,
                    isArchived = false,
                    assignmentMaximumMarks = Convert.ToInt32(txtMaximumMarks.Text),
                    teacherID = SessionManager.TeacherID,
                    fileName = fileName
                };

                db.tblAssignments.InsertOnSubmit(assignment);

                if (assignment.fileName != null)
                {
                    //Saves file to a folder located inside the server
                    string savePath = Server.MapPath("~/Files/SupplementaryFiles");

                    //Renames the file such that there cannot be any duplicates
                    string saveFileName = fileName;

                    string imgSavePath = Path.Combine(savePath, saveFileName);
                    fuSupplementaryFiles.SaveAs(imgSavePath);
                }

                db.SubmitChanges();

                //assignment = (tblAssignment)db.GetChangeSet().Inserts.FirstOrDefault();

                var assignments = db.tblAssignments.ToList();
                int assignmentID = assignments.LastOrDefault().assignmentID;

                var students = db.tblStudentSubjects.Where(x => x.teacherID == SessionManager.TeacherID && x.isVisible);

                int userID;

                foreach (tblStudentSubject student in students)
                {

                    userID = db.tblStudents.Where(x => x.studentID == student.studentID).FirstOrDefault().userID;

                    tblStudentAssignment studentAssignment = new tblStudentAssignment
                    {
                        studentID = student.studentID,
                        assignmentID = assignmentID,
                        studentAssignmentStatus = false,
                        studentAssignmentMarks = null
                    };

                    db.tblStudentAssignments.InsertOnSubmit(studentAssignment);
                    db.SubmitChanges();

                    NotificationManager.assignmentCreateNotification(userID);
                }

                var list = db.tblAssignments.Where(x => x.teacherID == SessionManager.TeacherID).SortBy("assignmentEndDate");

                assignments = db.tblAssignments.Where(x => x.teacherID == SessionManager.TeacherID && x.isArchived == false).SortBy("assignmentEndDate").ToList();

                Session["assignmentList"] = assignments;

                ControlManager.populateControl(assignments, rAssignment);
            }

            ControlManager.clearTextBoxes(vForm);
            mvTeacherAssignments.ActiveViewIndex = 0;
            pCreate.Visible = true;
        }


        protected void btnDownloadFiles_Click(object sender, EventArgs e)
        {

            int hash = sender.GetHashCode();


            foreach (RepeaterItem item in rAssignment.Items)
            {
                LinkButton button = item.FindControl("btnDownloadFiles") as LinkButton;

                if (button.GetHashCode() == hash)
                {
                    using (DatabaseDataContext db = new DatabaseDataContext())
                    {
                        string path = "Files/SupplementaryFiles/";

                        Label label = item.FindControl("lblAssignmentID") as Label;
                        int assignmentID = Convert.ToInt32(label.Text);

                        string fileName = db.tblAssignments.Where(x => x.assignmentID == assignmentID).FirstOrDefault().fileName;

                        Response.Redirect(path + fileName);
                        break;
                    }
                }
            }
        }

        protected void rAssignment_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            MultiView mv = e.Item.FindControl("mvToggle") as MultiView;
            mv.ActiveViewIndex = 0;

            Label label = e.Item.FindControl("lblAssignmentID") as Label;
            int assignmentID = Convert.ToInt32(label.Text);

            using(DatabaseDataContext db = new DatabaseDataContext())
            {
                tblAssignment assignment = db.tblAssignments.Where(x => x.assignmentID == assignmentID).FirstOrDefault();
                LinkButton linkButton = e.Item.FindControl("btnDownloadFiles") as LinkButton;

                if (assignment.fileName == null)
                {
                    linkButton.Visible = false;
                }

                if(assignment.assignmentEndDate > DateTime.Now)
                {
                    Button button = e.Item.FindControl("btnArchive") as Button;
                    button.Enabled = false;

                    button = e.Item.FindControl("btnGrade") as Button;
                    button.Enabled = false;
                }
            }
        }

        protected void tDeadline_Tick(object sender, EventArgs e)
        {
            int hash = sender.GetHashCode();

            foreach (RepeaterItem item in rAssignment.Items)
            {
                Timer timer = item.FindControl("tDeadline") as Timer;
                Label label = item.FindControl("lDeadline") as Label;
                Label lEndDate = item.FindControl("lEndDate") as Label;

                if (timer.GetHashCode() == hash)
                {
                    DateTime EndDate = Convert.ToDateTime(lEndDate.Text);

                    TimeSpan timeSpan = EndDate - DateTime.Now;

                    if (timeSpan.TotalSeconds > 0)
                    {
                        double hours = Math.Floor(timeSpan.TotalHours);
                        double minutes = Math.Floor(timeSpan.TotalMinutes - hours * 60);
                        double seconds = Math.Floor(timeSpan.TotalSeconds - hours * 3600 - minutes * 60);


                        label.Text = "Time left: ";
                        label.Text += hours.ToString();
                        label.Text += ":";
                        label.Text += minutes.ToString().Length == 1 ? "0" + minutes.ToString() : minutes.ToString();
                        label.Text += ":";
                        label.Text += seconds.ToString().Length == 1 ? "0" + seconds.ToString() : seconds.ToString();
                    }
                    else
                    {
                        label.Text = "Time has ended";
                    }
                }
            }
        }

        protected void aHide_ServerClick(object sender, EventArgs e)
        {
            int hash = sender.GetHashCode();

            foreach (RepeaterItem item in rAssignment.Items)
            {
                Control a = item.FindControl("aHide") as Control;
                Panel panel = item.FindControl("pAssignmentBody") as Panel;

                if (a.GetHashCode() == hash)
                {
                    panel.Visible = false;

                    MultiView mv = item.FindControl("mvToggle") as MultiView;

                    mv.ActiveViewIndex = 1;

                    bool[] panelShow = Session["panelShow"] as bool[];
                    panelShow[item.ItemIndex] = false;
                    Session["panelShow"] = panelShow;

                    break;
                }
            }
        }

        protected void aShow_ServerClick(object sender, EventArgs e)
        {
            int hash = sender.GetHashCode();

            foreach (RepeaterItem item in rAssignment.Items)
            {
                Control a = item.FindControl("aShow") as Control;
                Panel panel = item.FindControl("pAssignmentBody") as Panel;

                if (a.GetHashCode() == hash)
                {
                    panel.Visible = true;

                    MultiView mv = item.FindControl("mvToggle") as MultiView;
                    mv.ActiveViewIndex = 0;

                    bool[] panelShow = Session["panelShow"] as bool[];
                    panelShow[item.ItemIndex] = true;
                    Session["panelShow"] = panelShow;

                    break;
                }
            }
        }

        protected void btnViewArchives_Click(object sender, EventArgs e)
        {
            using (DatabaseDataContext db = new DatabaseDataContext())
            {
                Session["panelShow"] = null;

                List<tblAssignment> assignments = db.tblAssignments.Where(x => x.teacherID == SessionManager.TeacherID && x.isArchived).SortBy("assignmentEndDate").ToList();

                Session["assignmentList"] = assignments;

                btnViewAssignments.Visible = true;
                btnViewArchives.Visible = false;

                ControlManager.populateControl(assignments, rAssignment);
                panelSetup(assignments);
            }
        }

        protected void btnViewAssignments_Click(object sender, EventArgs e)
        {
            using (DatabaseDataContext db = new DatabaseDataContext())
            {

                Session["panelShow"] = null;

                List<tblAssignment> assignments = db.tblAssignments.Where(x => x.teacherID == SessionManager.TeacherID && x.isArchived == false).SortBy("assignmentEndDate").ToList();

                Session["assignmentList"] = assignments;

                btnViewAssignments.Visible = false;
                btnViewArchives.Visible = true;

                ControlManager.populateControl(assignments, rAssignment);
                panelSetup(assignments);
            }
        }

        protected void btnArchive_Click(object sender, EventArgs e)
        {
            int hash = sender.GetHashCode();

            foreach(RepeaterItem item in rAssignment.Items)
            {
                Button button = item.FindControl("btnArchive") as Button;

                if(button.GetHashCode() == hash)
                {
                    Label label = item.FindControl("lblAssignmentID") as Label;
                    int assignmentID = Convert.ToInt32(label.Text);

                    using(DatabaseDataContext db = new DatabaseDataContext())
                    {
                        tblAssignment assignment = db.tblAssignments.Where(x => x.assignmentID == assignmentID).FirstOrDefault();

                        assignment.isArchived = true;
                        db.SubmitChanges();
                    }
                }
            }

        }

        protected void btnGrade_Click(object sender, EventArgs e)
        {
            mvTeacherAssignments.ActiveViewIndex = 2;
        }
    }
}