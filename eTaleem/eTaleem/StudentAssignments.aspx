<%@ Page Title="" Language="C#" MasterPageFile="~/master.Master" AutoEventWireup="true" CodeBehind="StudentAssignments.aspx.cs" Inherits="eTaleem.StudentAssignments" %>

<asp:Content ID="Content1" ContentPlaceHolderID="SidebarPlaceholder" runat="server">
    <li>
        <a class="waves-effect" href="StudentHome.aspx"><i class="mdi mdi-home"></i><span>Home </span></a>
    </li>
    <li>
        <a class="waves-effect" href="StudentSubjects.aspx"><i class="mdi mdi-book-open-page-variant"></i><span>Subjects </span></a>
    </li>
    <li>
        <a class="waves-effect active" href="StudentAssignments.aspx"><i class="mdi mdi-pen"></i><span>Assignments </span></a>
    </li>
    <li>
        <a class="waves-effect" href="StudentPerformance.aspx"><i class="mdi mdi-chart-line"></i><span>Performance </span></a>
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
    <div class="row">
        <div class="col-xs-12">
            <div class="page-title-box">
                <h4 class="page-title">Assignments</h4>
                <ol class="breadcrumb p-0 m-0">
                    <li>
                        <a href="#">eTaleem</a>
                    </li>
                    <li>
                        <a href="StudentHome.aspx">Student</a>
                    </li>
                    <li class="active">Assignments
                    </li>
                </ol>
                <div class="clearfix"></div>
            </div>
        </div>
    </div>
    <asp:UpdatePanel ID="upRepeater" runat="server" UpdateMode="Conditional">
        <ContentTemplate>
            <div class="row">
                <asp:Repeater runat="server" ID="rAssignment" EnableViewState="false">
                    <ItemTemplate>
                        <div class="col-md-6">
                            <div class="panel panel-color panel-<%#eTaleem.AssignmentManager.getPanelColor(Convert.ToDateTime(Eval("assignmentEndDate")), (bool)Eval("IsGraded")) %>">
                                <div class="panel-heading" style="height: 46.5px">
                                    <asp:Label runat="server" ID="lblAssignmentID" Visible="false" Text='<%# Eval("assignmentID") %>'></asp:Label>
                                    <h3 class="panel-title col-md-11"><%#Eval("assignmentTitle") %></h3>
                                    <div class="col-md-1" style="text-align: right;">
                                        <div class="col-md-1" style="text-align: right; float: right">
                                            <asp:MultiView runat="server" ID="mvToggle">
                                                <asp:View runat="server">
                                                    <a runat="server" id="aHide">
                                                        <i class="mdi mdi-minus" style="color: white"></i>
                                                    </a>
                                                </asp:View>
                                                <asp:View runat="server">
                                                    <a runat="server" id="aShow">
                                                        <i class="mdi mdi-plus" style="color: white"></i>
                                                    </a>
                                                </asp:View>
                                            </asp:MultiView>
                                        </div>
                                    </div>
                                </div>
                                <asp:Panel ID="pSubjectBody" CssClass="panel-body" runat="server" Style="text-align: justify; height: 17em">
                                    <asp:MultiView runat="server" ID="mvPanelBody">
                                        <%-- (0) Starting View with Subject Description --%>
                                        <asp:View runat="server">
                                            <div class="card-box" style="height: 22em">
                                                <label style="font-size: 18px;">Question Statement</label>
                                                <p style="height: 14em">
                                                    <%# Eval("assignmentQuestionStatement") %>
                                                </p>
                                                <div class="row form-group text-center" style="margin-bottom: 0">
                                                    <asp:LinkButton runat="server" ID="btnDownloadFiles" CssClass="btn btn-primary">
                                <i class="mdi mdi-download"></i> Download Supplementary files
                                                    </asp:LinkButton>
                                                </div>
                                            </div>
                                        </asp:View>
                                        <%-- (1) Dropdown List to choose teacher --%>
                                        <asp:View runat="server">
                                            <div class="row">
                                                <div class="form-group">
                                                    <label>Upload Answer</label>
                                                    <asp:FileUpload runat="server" ID="fuStudentResponse" CssClass="form-control" Enabled="false" CausesValidation="false"></asp:FileUpload>
                                                </div>
                                            </div>
                                        </asp:View>
                                    </asp:MultiView>
                                </asp:Panel>
                                <div class="panel-footer" style="height: 50px">
                                    <div style="float: right;">
                                        <asp:MultiView runat="server" ID="mvPanelFooter">
                                            <%-- (0) If student is already enrolled, "Change Teacher" + "Leave" --%>
                                            <asp:View runat="server">
                                                <asp:Button runat="server" ID="btnChangeTeacher" CssClass="btn btn-orange" Width="140px" Text="Change Teacher"></asp:Button>
                                                <asp:Button runat="server" ID="btnLeave" CssClass="btn btn-danger" Width="80px" Text="Leave" CausesValidation="false"></asp:Button>
                                            </asp:View>
                                            <%-- (1) If student is not enrolled, "Enroll" --%>
                                            <asp:View runat="server">
                                                <asp:Button runat="server" ID="btnEnroll" CssClass="btn btn-primary" Width="80px" Text="Enroll" CausesValidation="false"></asp:Button>
                                            </asp:View>
                                        </asp:MultiView>
                                    </div>
                                </div>
                            </div>
                        </div>
                        </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
