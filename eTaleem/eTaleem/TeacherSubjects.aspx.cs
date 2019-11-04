using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace eTaleem
{
    public partial class TeacherSubjects : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                mvTeacherSubjects.ActiveViewIndex = 0;
            }

            using (DatabaseDataContext db = new DatabaseDataContext())
            {
                List<tblSubject> subjects = db.tblSubjects.SortBy("subjectTitle").Where(x => x.isVisible).ToList();

                ControlManager.populateControl(subjects, subjectListRepeater);
            }

            
        }

        protected void mvTeacherSubjects_ActiveViewChanged(object sender, EventArgs e)
        {
            ControlManager.hidePanels(mvTeacherSubjects);
            
        }

        protected void btnSubjectAdd_Click1(object sender, EventArgs e)
        {
            txtSubjectCode.Enabled = true;
            mvTeacherSubjects.ActiveViewIndex = 1;
            mvForm.ActiveViewIndex = 0;
        }

        protected void btnSubjectEdit_Click(object sender, EventArgs e)
        {

            ///TODO: Make a function out of this

            int hashCode = sender.GetHashCode();

            for (int i = 0; i < subjectListRepeater.Items.Count; i++)
            {
                LinkButton button = (LinkButton)subjectListRepeater.Items[i].FindControl("btnSubjectEdit");

                if (button.GetHashCode() == hashCode)
                {

                    RepeaterItem items = subjectListRepeater.Items[i];                  // Fetches the items in the row
                    TableCell tc = (TableCell)items.FindControl("tcSubjectCode");       // Finds the item corresponding with the ID
                    int id = Convert.ToInt32(tc.Text);                                  // Gets the content of the TableCell

                    using (DatabaseDataContext db = new DatabaseDataContext())
                    {
                        tblSubject subject = db.tblSubjects.Where(x => x.subjectCode == id).FirstOrDefault();
                        txtSubjectCode.Text = Server.HtmlEncode(subject.subjectCode.ToString());
                        ddlSubjectGroup.SelectedValue = Server.HtmlEncode(subject.subjectGroup);
                        txtSubjectTitle.Text = Server.HtmlEncode(subject.subjectTitle);
                        txtSubjectDescription.Text = Server.HtmlEncode(subject.subjectDescription);

                        txtSubjectCode.Enabled = false;

                        mvTeacherSubjects.ActiveViewIndex = 1;
                        mvForm.ActiveViewIndex = 1;
                    }

                    break;
                }
            }
        }

        protected void btnSubjectDelete_Click(object sender, EventArgs e)
        {
            int hashCode = sender.GetHashCode();

            for(int i = 0; i < subjectListRepeater.Items.Count; i++)
            {
                LinkButton button = (LinkButton)subjectListRepeater.Items[i].FindControl("btnSubjectDelete");

                if(button.GetHashCode() == hashCode)
                {

                    RepeaterItem items = subjectListRepeater.Items[i];                  // Fetches the items in the row
                    TableCell tc = (TableCell)items.FindControl("tcSubjectCode");       // Finds the item corresponding with the ID
                    int id = Convert.ToInt32(tc.Text);                                  // Gets the content of the TableCell

                    using (DatabaseDataContext db = new DatabaseDataContext())
                    {
                        tblSubject subject = db.tblSubjects.Where(x => x.subjectCode == id).FirstOrDefault();
                        subject.isVisible = false;
                        db.SubmitChanges();

                        List<tblSubject> subjects = db.tblSubjects.SortBy("subjectTitle").Where(x => x.isVisible).ToList();

                        pDelete.Visible = true;
                        pEdit.Visible = false;
                        ControlManager.populateControl(subjects, subjectListRepeater);
                    }

                    break;
                }
            }
        }

        //--------------------- Form View Start -----------------------//

        protected void btnSubjectCancel_Click(object sender, EventArgs e)
        {
            ControlManager.clearTextBoxes(vForm);
            mvTeacherSubjects.ActiveViewIndex = 0;
        }

        protected void btnNewSubjectAdd_Click(object sender, EventArgs e)
        {
            using (DatabaseDataContext db = new DatabaseDataContext())
            {
                if(db.tblSubjects.Where(x => x.subjectCode == Convert.ToInt32(txtSubjectCode.Text)).FirstOrDefault() != null)
                {
                    lblSubjectCode.Visible = true;
                    return;
                }
               
            }


            tblSubject subject = new tblSubject
            {
                subjectCode = Convert.ToInt32(txtSubjectCode.Text),
                subjectTitle = txtSubjectTitle.Text,
                subjectGroup = ddlSubjectGroup.SelectedItem.Text,
                subjectDescription = txtSubjectDescription.Text,
                isVisible = true
            };

            using (DatabaseDataContext db = new DatabaseDataContext())
            {
                db.tblSubjects.InsertOnSubmit(subject);
                db.SubmitChanges();

                List<tblSubject> subjects = db.tblSubjects.SortBy("subjectTitle").Where(x => x.isVisible).ToList();

                ControlManager.populateControl(subjects, subjectListRepeater);
            }


            ControlManager.clearTextBoxes(vForm);
            lblSubjectCode.Visible = false;

            mvTeacherSubjects.ActiveViewIndex = 0;
            pAdd.Visible = true;
        }

        protected void btnNewSubjectEdit_Click(object sender, EventArgs e)
        {

            int id = Convert.ToInt32(txtSubjectCode.Text);

            using (DatabaseDataContext db = new DatabaseDataContext())
            {
                tblSubject subject = db.tblSubjects.Where(x => x.subjectCode == id).FirstOrDefault();
                subject.subjectTitle = txtSubjectTitle.Text;
                subject.subjectGroup = ddlSubjectGroup.SelectedValue;
                subject.subjectDescription = txtSubjectDescription.Text;

                db.SubmitChanges();

                List<tblSubject> subjects = db.tblSubjects.SortBy("subjectTitle").Where(x => x.isVisible).ToList();

                ControlManager.populateControl(subjects, subjectListRepeater);
            }

            ControlManager.clearTextBoxes(vForm);

            mvTeacherSubjects.ActiveViewIndex = 0;
            pEdit.Visible = true;
        }

        
    }
}