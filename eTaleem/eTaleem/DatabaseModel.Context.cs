﻿//------------------------------------------------------------------------------
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
    using System.Data.Entity;
    using System.Data.Entity.Infrastructure;
    
    public partial class SmartTrafficDBEntities : DbContext
    {
        public SmartTrafficDBEntities()
            : base("name=SmartTrafficDBEntities")
        {
        }
    
        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            throw new UnintentionalCodeFirstException();
        }
    
        public virtual DbSet<tblCategory> tblCategories { get; set; }
        public virtual DbSet<tblComplaint> tblComplaints { get; set; }
        public virtual DbSet<tblEmergency> tblEmergencies { get; set; }
        public virtual DbSet<tblFeedback> tblFeedbacks { get; set; }
        public virtual DbSet<tblNotification> tblNotifications { get; set; }
        public virtual DbSet<tblSession> tblSessions { get; set; }
        public virtual DbSet<tblUser> tblUsers { get; set; }
        public virtual DbSet<tblUserType> tblUserTypes { get; set; }
    }
}