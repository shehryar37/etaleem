using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace eTaleem
{
    public partial class TeacherHome : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            using (DatabaseDataContext db = new DatabaseDataContext())
            {
                var list = db.tblUsers.Join(
                        db.tblStudents,
                        x => x.userID,
                        y => y.userID,
                        (x, y) => new { tblUser = x, tblStudent = y }).Join(
                            db.tblStudentSubjects,
                            y => y.tblStudent.studentID,
                            z => z.studentID,
                            (y, z) => new { tblStudent = y, tblStudentSubject = z }).Where(
                                x => x.tblStudentSubject.teacherID == SessionManager.TeacherID &&
                                x.tblStudentSubject.isVisible && x.tblStudentSubject.teacherID != null).Select(s => new
                                {
                                    s.tblStudent.tblStudent.studentFullName,
                                    s.tblStudent.tblUser.userEmail,
                                    s.tblStudentSubject.joiningDate
                                });

                ControlManager.populateControl(list, studentListRepeater);
            }
        }

        protected void btnStudentRemove_Click(object sender, EventArgs e)
        {
            int hash = sender.GetHashCode();

            for (int i = 0; i < studentListRepeater.Items.Count; i++)
            {
                LinkButton button = (LinkButton)studentListRepeater.Items[i].FindControl("btnStudentRemove");
                if (button.GetHashCode() == hash)
                {
                    TableCell tc = (TableCell)studentListRepeater.Items[i].FindControl("tcUserEmail");
                    string userEmail = tc.Text;

                    using (DatabaseDataContext db = new DatabaseDataContext())
                    {
                        int userID = db.tblUsers.Where(x => x.userEmail.Equals(userEmail)).FirstOrDefault().userID;

                        int studentID = db.tblUsers.Join(
                        db.tblStudents,
                        x => x.userID,
                        y => y.userID,
                        (x, y) => new { tblUser = x, tblStudent = y }).Where(
                                x => x.tblUser.userID == userID).FirstOrDefault().tblStudent.studentID;

                        tblStudentSubject studentSubject = db.tblStudentSubjects.Where(x => x.studentID == studentID && x.teacherID == SessionManager.TeacherID).FirstOrDefault();

                        studentSubject.teacherID = null;
                        studentSubject.isVisible = false;
                        db.SubmitChanges();

                        var list = db.tblUsers.Join(
                        db.tblStudents,
                        x => x.userID,
                        y => y.userID,
                        (x, y) => new { tblUser = x, tblStudent = y }).Join(
                            db.tblStudentSubjects,
                            y => y.tblStudent.studentID,
                            z => z.studentID,
                            (y, z) => new { tblStudent = y, tblStudentSubject = z }).Where(
                                x => x.tblStudentSubject.teacherID == SessionManager.TeacherID &&
                                x.tblStudentSubject.isVisible && x.tblStudentSubject.teacherID != null).Select(s => new
                                {
                                    s.tblStudent.tblStudent.studentFullName,
                                    s.tblStudent.tblUser.userEmail,
                                    s.tblStudentSubject.joiningDate
                                }).SortBy("joiningDate");

                        list.Reverse();

                        ControlManager.populateControl(list, studentListRepeater);

                        NotificationManager.removeStudentNotification(userID);
                    }

                    break;
                }
            }
        }
    }
}