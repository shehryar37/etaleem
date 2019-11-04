<%@ Page Title="" Language="C#" MasterPageFile="~/master.Master" AutoEventWireup="true" CodeBehind="Messages.aspx.cs" Inherits="eTaleem.Messages" %>

<asp:Content ID="Content1" ContentPlaceHolderID="SidebarPlaceholder" runat="server">
    <li>
        <a class="waves-effect" href="StudentHome.aspx"><i class="mdi mdi-home"></i><span>Home </span></a>
    </li>
    <li>
        <a class="waves-effect" href="StudentSubjects.aspx"><i class="mdi mdi-book-open-page-variant"></i><span>Subjects </span></a>
    </li>
    <li>
        <a class="waves-effect" href="StudentAssignments.aspx"><i class="mdi mdi-pen"></i><span>Assignments </span></a>
    </li>
    <li>
        <a class="waves-effect" href="StudentPerformance.aspx"><i class="mdi mdi-chart-line"></i><span>Performance </span></a>
    </li>
    <li class="menu-title">Personal</li>
    <li>
        <a class="waves-effect" href="Notifications.aspx"><i class="mdi mdi-bell"></i><span>Notifications </span><span class="label label-success pull-right"><%= eTaleem.NotificationManager.unseenNotificationCount() %></span></a>
    </li>
    <li>
        <a class="waves-effect active" href="Messages.aspx"><i class="mdi mdi-message"></i><span>Messages </span><span class="label label-danger pull-right">2</span></a>
    </li>
    <li>
        <a class="waves-effect" href="Account.aspx"><i class="mdi mdi-account-card-details"></i><span>Account </span></a>
    </li>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceholder" runat="server">
    <div class="row">
        <div class="col-xs-12">
            <div class="page-title-box">
                <h4 class="page-title">Messages</h4>
                <ol class="breadcrumb p-0 m-0">
                    <li>
                        <a href="#">eTaleem</a>
                    </li>
                    <li>
                        <a href="StudentHome.aspx">Student</a>
                    </li>
                    <li class="active">Messages
                    </li>
                </ol>
                <div class="clearfix"></div>
            </div>
        </div>
    </div>
</asp:Content>
