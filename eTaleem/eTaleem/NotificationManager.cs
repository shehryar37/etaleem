using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace eTaleem
{
    public static class NotificationManager
    {
        // Activates when a teacher removes a student
        public static void removeStudentNotification(int userID)
        {
            using (DatabaseDataContext db = new DatabaseDataContext())
            {
                tblTeacher teacher = db.tblTeachers.Where(x => x.userID == SessionManager.UserID).FirstOrDefault();

                string subjectTitle = db.tblSubjects.Where(x => x.subjectCode == teacher.subjectCode).FirstOrDefault().subjectTitle;

                tblNotification notification = new tblNotification
                {
                    notificationMessage = teacher.teacherFullName + " removed you from " + subjectTitle + "(" + teacher.subjectCode + ")",
                    userID = userID,
                    notificationDateTime = DateTime.UtcNow,
                    notificationType = "S",
                    notificationLink = "StudentSubjects.aspx",
                    isSeen = false
                };

                db.tblNotifications.InsertOnSubmit(notification);
                db.SubmitChanges();
            }
        }

        // Activates when a student enrolls into a teacher's class
        public static void enrollSubjectNotification(int userID)
        {
            using (DatabaseDataContext db = new DatabaseDataContext())
            {

                //int userID = db.tblTeachers.Where(x => x.teacherID == teacherID).FirstOrDefault().userID;

                tblStudent student = db.tblStudents.Where(x => x.userID == SessionManager.UserID).FirstOrDefault();

                tblNotification notification = new tblNotification
                {
                    notificationMessage = student.studentFullName + " enrolled into your class",
                    userID = userID,
                    notificationDateTime = DateTime.UtcNow,
                    notificationType = "S",
                    notificationLink = "TeacherStudents.aspx",
                    isSeen = false
                };

                db.tblNotifications.InsertOnSubmit(notification);
                db.SubmitChanges();

            }
        }

        //Activates when a student leaves a subject
        public static void leaveSubjectNotification(int userID)
        {
            //if(teacherID == null)
            //{
            //    return;
            //}

            using (DatabaseDataContext db = new DatabaseDataContext())
            {

                //int userID = db.tblTeachers.Where(x => x.teacherID == teacherID).FirstOrDefault().userID;

                tblStudent student = db.tblStudents.Where(x => x.userID == SessionManager.UserID).FirstOrDefault();

                tblNotification notification = new tblNotification
                {
                    notificationMessage = student.studentFullName + " left your class",
                    userID = userID,
                    notificationDateTime = DateTime.UtcNow,
                    notificationType = "S",
                    notificationLink = "TeacherStudents.aspx",
                    isSeen = false
                };

                db.tblNotifications.InsertOnSubmit(notification);
                db.SubmitChanges();

            }
        }

        public static void assignmentCreateNotification(int userID)
        {
            using (DatabaseDataContext db = new DatabaseDataContext())
            {


                tblTeacher teacher = db.tblTeachers.Where(x => x.userID == SessionManager.UserID).FirstOrDefault();
                tblSubject subject = db.tblSubjects.Where(x => x.subjectCode == teacher.subjectCode).FirstOrDefault();



                tblNotification notification = new tblNotification
                {
                    notificationMessage = "You have a new assignment for " + subject.subjectTitle + "(" + subject.subjectCode + ")",
                    userID = userID,
                    notificationDateTime = DateTime.UtcNow,
                    notificationType = "A",
                    notificationLink = "StudentAssignments.aspx",
                    isSeen = false
                };

                db.tblNotifications.InsertOnSubmit(notification);
                db.SubmitChanges();

            }
        }

        // Gets the number of unread notifications by a user
        public static string unseenNotificationCount()
        {
            using(DatabaseDataContext db = new DatabaseDataContext())
            {
                int count = db.tblNotifications.Where(x => x.userID == SessionManager.UserID && x.isSeen == false).ToList().Count;

                return count.ToString();
            }
            
        }

        // Sets the icon displayed alongside the notification based on the type of notification 
        public static string notificationType(string type)
        {
            type = type.Trim();

            switch(type)
            {
                case "S":
                    return "account";
                case "A":
                    return "pen";
                default:
                    return null;
            }
        }

        //Gets the difference from when the notification was created till the present time
        public static string notificationTimeElapsed(DateTime dateTime)
        {
            TimeSpan timeSpan = DateTime.UtcNow - dateTime;

            MidpointRounding mode = MidpointRounding.ToEven;

            return Math.Round(timeSpan.TotalSeconds, mode) < 60
                ? "A few seconds ago"
                : Math.Round(timeSpan.TotalMinutes, mode) >= 1 && Math.Round(timeSpan.TotalMinutes, mode) < 60
                    ? Math.Round(timeSpan.TotalMinutes, mode) == 1
                                    ? "1 minute ago"
                                    : Math.Round(timeSpan.TotalMinutes, mode).ToString() + " minutes ago"
                    : Math.Round(timeSpan.TotalHours, mode) >= 1 && Math.Round(timeSpan.TotalHours, mode) < 24
                                    ? Math.Round(timeSpan.TotalHours, mode) == 1 ? "An hour ago" : Math.Round(timeSpan.TotalHours, mode) + " hours ago"
                                    : Math.Round(timeSpan.TotalDays, mode) >= 1 && Math.Round(timeSpan.TotalDays, mode) <= 7
                                                    ? Math.Round(timeSpan.TotalDays, mode) == 1
                                                                    ? "Yesterday"
                                                                    : Math.Round(timeSpan.TotalDays, mode) == 7 ? "A week ago" : dateTime.DayOfWeek.ToString()
                                                    : dateTime.Date.ToLongDateString();
        }
    }
}