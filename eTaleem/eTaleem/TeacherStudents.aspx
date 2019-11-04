<%@ Page Title="" Language="C#" MasterPageFile="~/master.Master" AutoEventWireup="true" CodeBehind="TeacherStudents.aspx.cs" Inherits="eTaleem.TeacherStudents" %>

<asp:Content ID="Content1" ContentPlaceHolderID="SidebarPlaceholder" runat="server">
    <li>
        <a class="waves-effect" href="TeacherHome.aspx"><i class="mdi mdi-home"></i><span>Home </span></a>
    </li>
    <li>
        <a class="waves-effect" href="TeacherSubjects.aspx"><i class="mdi mdi-book-open-page-variant"></i><span>Subjects </span></a>
    </li>
    <li>
        <a class="waves-effect active" href="TeacherStudents.aspx"><i class="mdi mdi-account"></i><span>Students </span></a>
    </li>
    <li>
        <a class="waves-effect" href="TeacherAssignments.aspx"><i class="mdi mdi-pen"></i><span>Assignments </span></a>
    </li>
    <li></li>
    <%--<li class="menu-title">Personal</li>
    <li>
        <a class="waves-effect"><i class="mdi mdi-inbox"></i><span>Messages </span></a>
    </li>--%>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceholder" runat="server">
    <div class="row">
        <div class="col-xs-12">
            <div class="page-title-box">
                <h4 class="page-title">Students</h4>
                <ol class="breadcrumb p-0 m-0">
                    <li>
                        <a href="#">eTaleem</a>
                    </li>
                    <li>
                        <a href="TeacherHome.aspx">Teacher</a>
                    </li>
                    <li class="active">Students
                    </li>
                </ol>
                <div class="clearfix"></div>
            </div>
        </div>
    </div>

    <div class="row">
        <asp:Panel runat="server" ID="pAdd" Visible="false">
            <div class="alert alert-icon alert-success alert-dismissible fade in" role="alert">
                <button class="close" aria-label="Close" type="button" data-dismiss="alert">
                    <span aria-hidden="true">×</span>
                </button>
                <i class="mdi mdi-check-all"></i>
                <strong>Success!</strong> Subject has been added!                 
            </div>
        </asp:Panel>
    </div>

    <!-- ============================================================== -->
    <!-- Subject Table Start -->
    <!-- ============================================================== -->
        <table class="table m-0 table-colored table-primary">
            <thead>
                <tr>
                    <th>Full Name</th>
                    <th>Email</th>
                    <th>Joining Date</th>
                    <th colspan="2"></th>

                </tr>
            </thead>
            <tbody class=".table-striped">
                <asp:Repeater runat="server" ID="studentListRepeater" EnableViewState="false">
                    <ItemTemplate>
                        <tr style="height: 2em;">
                            <asp:TableCell runat="server" ID="tcStudentFullName" Text='<%# Eval("studentFullName") %>'></asp:TableCell>
                            <asp:TableCell runat="server" ID="tcUserEmail" Text='<%# Eval("userEmail") %>'></asp:TableCell>
                            <asp:TableCell runat="server" ID="tcJoiningDate" Text='<%# Eval("joiningDate") %>'></asp:TableCell>
                            <td>
                                <asp:LinkButton runat="server" CssClass="btn btn-warning" ID="btnStudentMessage"><i class="mdi mdi-message-text"></i> Message</asp:LinkButton>
                            </td>
                            <td>
                                <asp:LinkButton runat="server" CssClass="btn btn-danger" ID="btnStudentRemove"><i class="mdi mdi-account-remove"></i> Remove</asp:LinkButton>

                            </td>
                        </tr>
                    </ItemTemplate>
                </asp:Repeater>
            </tbody>
        </table>
    <!-- ============================================================== -->
    <!-- Subject Table End -->
    <!-- ============================================================== -->
</asp:Content>
