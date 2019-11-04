using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace eTaleem
{
    public static class SessionManager
    {
        private static int userID;
        private static int studentID;
        private static int teacherID;

        //Each variable stores an int; acts like a global variable

        public static int UserID { get => userID; set => userID = value; }
        public static int StudentID { get => studentID; set => studentID = value; }
        public static int TeacherID { get => teacherID; set => teacherID = value; }
    }
}