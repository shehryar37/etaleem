using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace eTaleem
{
    public static class HomeManager
    {
        public static string getStudentCount()
        {
            using(DatabaseDataContext db = new DatabaseDataContext())
            {
                return db.tblStudentSubjects.Where(x => x.isVisible && x.teacherID == SessionManager.TeacherID).Count().ToString();
            }
        }

        public static string getAssignmentCount()
        {
            using (DatabaseDataContext db = new DatabaseDataContext())
            {
                return db.tblAssignments.Where(x => x.teacherID == SessionManager.TeacherID).Count().ToString();
            }
        }

        public static string getSubjectCount()
        {
            using (DatabaseDataContext db = new DatabaseDataContext())
            {
                return db.tblSubjects.Where(x => x.isVisible).Count().ToString();
            }
        }
    }
}