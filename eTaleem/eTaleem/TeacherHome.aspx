<%@ Page Title="" Language="C#" MasterPageFile="~/master.Master" AutoEventWireup="true" CodeBehind="TeacherHome.aspx.cs" Inherits="eTaleem.TeacherHome" %>

<asp:Content ID="Content1" ContentPlaceHolderID="SidebarPlaceholder" runat="server">
    <li>
        <a class="waves-effect active" href="TeacherHome.aspx"><i class="mdi mdi-home"></i><span>Home </span></a>
    </li>
    <li>
        <a class="waves-effect" href="TeacherSubjects.aspx"><i class="mdi mdi-book-open-page-variant"></i><span>Subjects </span></a>
    </li>
    <li>
        <a class="waves-effect" href="TeacherStudents.aspx"><i class="mdi mdi-account"></i><span>Students </span></a>
    </li>
    <li>
        <a class="waves-effect" href="TeacherAssignments.aspx"><i class="mdi mdi-pen"></i><span>Assignments </span></a>
    </li>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceholder" runat="server">
    <div class="row">
        <div class="col-xs-12">
            <div class="page-title-box">
                <h4 class="page-title">Home</h4>
                <ol class="breadcrumb p-0 m-0">
                    <li>
                        <a href="#">eTaleem</a>
                    </li>
                    <li>
                        <a href="#">Teacher</a>
                    </li>
                    <li class="active">Home
                    </li>
                </ol>
                <div class="clearfix"></div>
            </div>
        </div>
    </div>
    <style>
        p, h2 {
            color: white;
        }
    </style>
    <div class="row">
        <div class="col-lg-2 col-md-2 col-sm-6">
            <a href="TeacherStudents.aspx">
                <div class="card-box widget-box-one" style="background-color: forestgreen">
                    <i class="mdi mdi-account widget-one-icon"></i>
                    <div class="wigdet-one-content">
                        <p title="Students" class="m-0 text-uppercase font-600 font-secondary text-overflow">Students</p>
                        <h2><%= eTaleem.HomeManager.getStudentCount() %></h2>
                    </div>
                </div>
            </a>
        </div>
        <div class="col-lg-2 col-md-2 col-sm-6">
            <a href="TeacherAssignments.aspx">
                <div class="card-box widget-box-one" style="background-color: deepskyblue">
                    <i class="mdi mdi-book-open-page-variant widget-one-icon"></i>
                    <div class="wigdet-one-content">
                        <p title="Students" class="m-0 text-uppercase font-600 font-secondary text-overflow">Subjects</p>
                        <h2><%= eTaleem.HomeManager.getSubjectCount() %></h2>
                    </div>
                </div>
            </a>
        </div>
        <div class="col-lg-2 col-md-2 col-sm-6">
            <a href="TeacherAssignments.aspx">
                <div class="card-box widget-box-one" style="background-color: orange">
                    <i class="mdi mdi-pen widget-one-icon"></i>
                    <div class="wigdet-one-content">
                        <p title="Students" class="m-0 text-uppercase font-600 font-secondary text-overflow">Assignments</p>
                        <h2><%= eTaleem.HomeManager.getAssignmentCount() %></h2>
                    </div>
                </div>
            </a>
        </div>
    </div>
    <div class="row">
        <div class="col-md-6">
            <div style="background-color: #EEE; text-align: center; font-size: 18px; padding: 10px 0">Recently Enrolled Students</div>
            <table class="table m-0 table-colored table-primary">
            <thead>
                <tr>
                    <th>Name</th>
                    <th>Joining Date</th>
                    <th colspan="1"></th>
                </tr>
            </thead>
            <tbody class=".table-striped">
                <asp:Repeater runat="server" ID="studentListRepeater" EnableViewState="false">
                    <ItemTemplate>
                        <tr style="height: 2em">
                            <asp:TableCell runat="server" ID="tcStudentFullName" Text='<%# Eval("studentFullName") %>'></asp:TableCell>
                            <asp:TableCell runat="server" ID="tcJoiningDate" Text='<%# Eval("joiningDate") %>'></asp:TableCell>
                            <td>
                                <asp:LinkButton runat="server" CssClass="btn btn-danger" ID="btnStudentRemove" OnClick="btnStudentRemove_Click"><i class="mdi mdi-account-remove"></i> Remove</asp:LinkButton>

                            </td>
                        </tr>
                    </ItemTemplate>
                </asp:Repeater>
            </tbody>
        </table>
        </div>
        
    </div>
</asp:Content>
