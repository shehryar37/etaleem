//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace eTaleem
{
    using System;
    using System.Collections.Generic;
    
    public partial class tblNotification
    {
        public int NotificationID { get; set; }
        public string NotificationMessage { get; set; }
        public string NotificationDateTime { get; set; }
        public string NotificationType { get; set; }
        public string NotificationLink { get; set; }
        public bool IsSeen { get; set; }
        public long UserID { get; set; }
    
        public virtual tblUser tblUser { get; set; }
    }
}