<%@ Page Title="" Language="C#" MasterPageFile="~/master.Master" AutoEventWireup="true" CodeBehind="StudentHome.aspx.cs" Inherits="eTaleem.Home" %>

<asp:Content ID="SidebarContent" ContentPlaceHolderID="SidebarPlaceholder" runat="server">
       <li class="menu-title">Category</li>
    <li>
        <a class="waves-effect active" href="StudentHome.aspx"><i class="mdi mdi-home"></i><span>Home </span></a>
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
<asp:Content ID="ContentContent" ContentPlaceHolderID="ContentPlaceHolder" runat="server">
    <div class="row">
        <div class="col-xs-12">
            <div class="page-title-box">
                <h4 class="page-title">Home</h4>
                <ol class="breadcrumb p-0 m-0">
                    <li>
                        <a href="#">eTaleem</a>
                    </li>
                    <li>
                        <a href="#">Student</a>
                    </li>
                    <li class="active">Home
                    </li>
                </ol>
                <div class="clearfix"></div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-sm-12">
            <h4 class="page-header">Your Subjects</h4>
        </div>
    </div>
    <div class="row form-group text-right" style="margin: 0 0 20px 0">
        <asp:Button runat="server" class="btn btn-primary" Text="Browse More >" ID="btnHomeBrowseSubjects" OnClick="btnHomeBrowseSubjects_Click"></asp:Button>
    </div>
    <div class="row">
        <%-- TODO: Add UpdatePanel and make changes to it according to the original panel in StudentSubjects.aspx --%>
        <asp:Repeater runat="server" ID="subjectsCatalogRepeater" EnableViewState="false">
            <ItemTemplate>
                <div class="col-lg-4">
                    <div class="panel panel-color panel-<%# eTaleem.ControlManager.setPanelColor(Eval("subjectGroup").ToString()) %>">
                        <div class="panel-heading">
                            <asp:Label runat="server" CssClass="h3 panel-title" Text='<%# Eval("subjectTitle")%>'></asp:Label><br />
                            <asp:Label runat="server" ID="lblSubjectCode" CssClass="panel-sub-title font-13 text-muted" Text='<%# Eval("subjectCode")%>'></asp:Label>
                        </div>
                        <div class="panel-body" style="text-align: justify; height: 17em">
                            <asp:MultiView runat="server" ID="mvPanelBody">
                                <%-- (0) Starting View with Subject Description --%>
                                <asp:View runat="server">
                                    <asp:Label runat="server" Text='<%# Eval("subjectDescription")%>'>
                                    </asp:Label>
                                </asp:View>
                                <%-- (1) Dropdown List to choose teacher --%>
                                <asp:View runat="server">
                                    <label>Choose a teacher</label>
                                    <div class="row">
                                        <div class="form-group" style="padding: 20px">
                                            <asp:DropDownList runat="server" ID="ddlChangeTeacher" CssClass="form-control" AutoPostBack="false" OnSelectedIndexChanged="ddlChangeTeacher_SelectedIndexChanged">
                                            </asp:DropDownList>
                                        </div>
                                    </div>
                                </asp:View>
                            </asp:MultiView>
                        </div>
                        <div class="panel-footer" style="height: 50px">
                            <div style="float: right;">
                                <asp:MultiView runat="server" ID="mvPanelFooter">
                                    <%-- (0) If student is already enrolled, "Change Teacher" + "Leave" --%>
                                    <asp:View runat="server">
                                        <asp:Button runat="server" ID="btnChangeTeacher" CssClass="btn btn-orange" Width="140px" Text="Change Teacher" OnClick="btnChangeTeacher_Click"></asp:Button>
                                        <asp:Button runat="server" ID="btnLeave" CssClass="btn btn-danger" Width="80px" Text="Leave" OnClick="btnLeave_Click" CausesValidation="false"></asp:Button>
                                    </asp:View>
                                    <%-- (1) If student is not enrolled, "Enroll" --%>
                                    <asp:View runat="server">
                                        <asp:Button runat="server" ID="btnEnroll" CssClass="btn btn-primary" Width="80px" Text="Enroll" CausesValidation="false" OnClick="btnEnroll_Click"></asp:Button>
                                    </asp:View>
                                    <%-- (2) clicking on "Change Teacher" --%>
                                    <asp:View runat="server">
                                        <asp:Button runat="server" ID="btnChangeTeacherCancel" CssClass="btn btn-danger" Width="80px" Text="Cancel" CausesValidation="false" OnClick="btnChangeTeacherCancel_Click"></asp:Button>
                                        <asp:Button runat="server" ID="btnChangeConfirmTeacher" CssClass="btn btn-primary" Width="140px" Text="Confrim Teacher" CausesValidation="false" OnClick="btnChangeConfirmTeacher_Click"></asp:Button>
                                    </asp:View>
                                    <%-- (3) clicking on "Leave" --%>
                                    <asp:View runat="server">
                                        <asp:Button runat="server" ID="btnLeaveCancel" CssClass="btn btn-danger" Width="80px" Text="Cancel" OnClick="btnLeaveCancel_Click" CausesValidation="false"></asp:Button>
                                        <asp:Button runat="server" ID="btnLeaveConfirmLeave" CssClass="btn btn-danger" Width="140px" Text="Confrim Leave" OnClick="btnLeaveConfirmLeave_Click" CausesValidation="false"></asp:Button>
                                    </asp:View>
                                    <%-- (4) clicking on "Enroll" --%>
                                    <asp:View runat="server">
                                        <asp:Button runat="server" CssClass="btn btn-danger" Width="80px" Text="Cancel" OnClick="btnEnrollCancel_Click" CausesValidation="false" ID="btnEnrollCancel"></asp:Button>
                                        <asp:Button runat="server" ID="btnEnrollConfirmEnroll" CssClass="btn btn-primary" Width="140px" Text="Confrim Enroll" OnClick="btnEnrollConfirmEnroll_Click" CausesValidation="false"></asp:Button>
                                    </asp:View>
                                </asp:MultiView>
                            </div>
                        </div>
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>
</asp:Content>
