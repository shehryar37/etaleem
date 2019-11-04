using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace eTaleem
{
    public partial class master : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["User"] != null)
            {
                tblUser user = (tblUser)Session["User"];

                using(DatabaseDataContext db = new DatabaseDataContext())
                {

                    string userFullName;

                    if(user.userType.ToString().Equals("T"))
                    {
                        userFullName = db.tblTeachers.Where(x => x.userID == user.userID).FirstOrDefault().teacherFullName;
                    } 
                    else
                    {
                        userFullName = db.tblStudents.Where(x => x.userID == user.userID).FirstOrDefault().studentFullName;
                    }

                    lblUser.Text = userFullName;
                }
                
            }
            else
            {
                Response.Redirect("Login.aspx");
            }

            using(DatabaseDataContext db = new DatabaseDataContext())
            {
                var list = db.tblNotifications.Where(x => x.userID == SessionManager.UserID).SortBy("notificationID").ToList();

                list.Reverse();

                ControlManager.populateControl(list, rNotifications);
            }

            lNotifications.Text = NotificationManager.unseenNotificationCount();

            aNotifications.ServerClick += ANotifications_ServerClick;
        }

        private void ANotifications_ServerClick(object sender, EventArgs e)
        {
            using (DatabaseDataContext db = new DatabaseDataContext())
            {
                List<tblNotification> notifications = db.tblNotifications.Where(x => x.isSeen == false && x.userID == SessionManager.UserID).ToList();

                foreach (tblNotification notification in notifications)
                {
                    notification.isSeen = true;
                    db.SubmitChanges();
                }
            }
           
            if(notificationList.Visible)
            {
                notificationList.Visible = false;
                notificationContainer.Attributes.Remove("class");
                aNotifications.Attributes.Remove("aria-expanded");
            }
            else
            {
                
                notificationContainer.Attributes.Add("class", "open");
                aNotifications.Attributes.Add("aria-expanded", "true");
                notificationList.Visible = true;
            }

            lNotifications.Text = NotificationManager.unseenNotificationCount();
        }
    }
}