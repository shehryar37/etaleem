<%@ Page Title="" Language="C#" MasterPageFile="~/master.Master" AutoEventWireup="true" CodeBehind="StudentPerformance.aspx.cs" Inherits="eTaleem.StudentPerformance" %>
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
        <a class="waves-effect active" href="StudentPerformance.aspx"><i class="mdi mdi-chart-line"></i><span>Performance </span></a>
    </li>
    <li class="menu-title">Personal</li>
    <%--<li>
        <a class="waves-effect" href="Notifications.aspx"><i class="mdi mdi-bell"></i><span>Notifications </span><span class="label label-success pull-right"><%= eTaleem.NotificationManager.unseenNotificationCount() %></span></a>
    </li>
    <li>
        <a class="waves-effect" href="Messages.aspx"><i class="mdi mdi-message"></i><span>Messages </span><span class="label label-danger pull-right">2</span></a>
    </li>--%>
    <li>
        <a class="waves-effect" href="Account.aspx"><i class="mdi mdi-account-card-details"></i><span>Account </span></a>
    </li>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceholder" runat="server">
</asp:Content>
