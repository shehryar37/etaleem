<%@ Page Title="" Language="C#" MasterPageFile="~/master.Master" AutoEventWireup="true" CodeBehind="StudentSubjects.aspx.cs" Inherits="eTaleem.Subjects" %>

<asp:Content ID="SidebarContent" ContentPlaceHolderID="SidebarPlaceholder" runat="server">
    <li>
        <a class="waves-effect" href="StudentHome.aspx"><i class="mdi mdi-home"></i><span>Home </span></a>
    </li>
    <li>
        <a class="waves-effect active" href="StudentSubjects.aspx"><i class="mdi mdi-book-open-page-variant"></i><span>Subjects </span></a>
    </li>
    <li>
        <a class="waves-effect" href="StudentAssignments.aspx"><i class="mdi mdi-pen"></i><span>Assignments </span></a>
    </li>
    <%--<li>
        <a class="waves-effect" href="StudentPerformance.aspx"><i class="mdi mdi-chart-line"></i><span>Performance </span></a>
    </li>
    <li class="menu-title">Personal</li>
    <li>
        <a class="waves-effect" href="Messages.aspx"><i class="mdi mdi-message"></i><span>Messages </span><span class="label label-danger pull-right">2</span></a>
    </li>--%>
    <li>
        <a class="waves-effect" href="Account.aspx"><i class="mdi mdi-account-card-details"></i><span>Account </span></a>
    </li>
</asp:Content>
<asp:Content ID="ContentContent" ContentPlaceHolderID="ContentPlaceholder" runat="server">
    <asp:MultiView runat="server" ID="mvSubjects">
        <asp:View ID="vMain" runat="server">
            <div class="row">
                <div class="col-xs-12">
                    <div class="page-title-box">
                        <h4 class="page-title">Subjects</h4>
                        <ol class="breadcrumb p-0 m-0">
                            <li>
                                <a href="#">eTaleem</a>
                            </li>
                            <li>
                                <a href="StudentHome.aspx">Student</a>
                            </li>
                            <li class="active">Subject Catalog
                            </li>
                        </ol>
                        <div class="clearfix"></div>
                    </div>
                </div>
            </div>
            <div class="row">
                <%--<asp:ScriptManager EnablePartialRendering="true" ID="ScriptManager1" runat="server">
    </asp:ScriptManager>--%>
                <asp:UpdatePanel ID="upRepeater" runat="server" UpdateMode="Conditional">
                    <ContentTemplate>
                        <div class="row">
                            <div class="col-md-12" style="padding: 5px 20px">
                                <div class="col-md-12">
                                    <div class="form-horizontal">
                                        <div class="col-md-4">
                                            <div class="form-group">
                                                <label class="col-md-2 control-label">Title</label>
                                                <div class="col-md-10">
                                                    <asp:TextBox runat="server" ID="txtTitle" CssClass="form-control" placeholder="Title" />
                                                </div>
                                            </div>
                                        </div>

                                        <div class="col-md-4">
                                            <div class="form-group">
                                                <label class="col-md-2 control-label">Category</label>
                                                <div class="col-md-10">
                                                    <asp:DropDownList runat="server" ID="ddlSubjectGroup" CssClass="form-control">
                                                        <asp:ListItem>Any</asp:ListItem>
                                                        <asp:ListItem>Creative and professional</asp:ListItem>
                                                        <asp:ListItem>Humanities and social sciences</asp:ListItem>
                                                        <asp:ListItem>Languages</asp:ListItem>
                                                        <asp:ListItem>Mathematics</asp:ListItem>
                                                        <asp:ListItem>Sciences</asp:ListItem>
                                                    </asp:DropDownList>
                                                </div>
                                            </div>
                                            </div>
                                            <div class="col-md-4">
                                                <asp:LinkButton runat="server" ID="lbtnFilter" OnClick="lbtnFilter_Click">
                                                    <div style="text-align: right">
                                                    <div class="btn btn-primary">
                                                        Filter
                                        <i class="mdi mdi-filter"></i>
                                                    </div>
                                                </div>
                                            </asp:LinkButton>
                                        </div>
                                    </div>
                                </div>
                                <div class="clearfix"></div>
                            </div>
                        </div>
                        <br />
                        <asp:Repeater runat="server" ID="rSubjectsCatalog" EnableViewState="false" OnItemDataBound="rSubjectsCatalog_ItemDataBound1">
                            <ItemTemplate>
                                <div>
                                <div class="col-md-6">
                                   <div class="panel panel-color panel-<%# eTaleem.ControlManager.setPanelColor(Eval("subjectGroup").ToString()) %>">
                                        <div class="panel-heading">
                                            <asp:Label runat="server" CssClass="h3 panel-title" Text='<%# Eval("subjectTitle")%>'></asp:Label>
                                            <div class="col-md-1" style="text-align: right; float: right">
                                                <asp:MultiView runat="server" ID="mvToggle">
                                                    <asp:View runat="server">
                                                        <a runat="server" id="aHide" onserverclick="aHide_ServerClick">
                            <i class="mdi mdi-minus" style="color: white"></i>
                                                        </a>
                                                    </asp:View>
                                                    <asp:View runat="server">
                                                        <a runat="server" id="aShow" onserverclick="aShow_ServerClick">
                            <i class="mdi mdi-plus" style="color: white"></i>
                                                        </a>
                                                    </asp:View>
                                                </asp:MultiView>
                                            </div>
                                            <br />
                                            <asp:Label runat="server" ID="lblSubjectCode" CssClass="panel-sub-title font-13 text-muted" Text='<%# Eval("subjectCode")%>'></asp:Label>
                                        </div>
                                        <br />
                                        <asp:Panel ID="pSubjectBody" CssClass="panel-body" runat="server" style="text-align: justify; height: 17em">
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
                                                        <div class="form-group">
                                                            <label>Current teacher:</label>
                                                            <asp:TextBox runat="server" ID="txtCurrentTeacher" CssClass="form-control" Enabled="false" CausesValidation="false"></asp:TextBox>
                                                        </div>
                                                        <div class="form-group">
                                                            <label>Choose a new teacher:</label>
                                                            <asp:DropDownList runat="server" ID="ddlChangeTeacher" CssClass="form-control" AutoPostBack="false">
                                                            </asp:DropDownList>
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
                                    </div>
                            </ItemTemplate>
                        </asp:Repeater>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
        </asp:View>
    </asp:MultiView>
</asp:Content>
