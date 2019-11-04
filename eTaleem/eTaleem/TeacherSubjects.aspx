<%@ Page Title="" Language="C#" MasterPageFile="~/master.Master" AutoEventWireup="true" CodeBehind="TeacherSubjects.aspx.cs" Inherits="eTaleem.TeacherSubjects" %>

<asp:Content ID="Content1" ContentPlaceHolderID="SidebarPlaceholder" runat="server">
    <li>
        <a class="waves-effect" href="TeacherHome.aspx"><i class="mdi mdi-home"></i><span>Home </span></a>
    </li>
    <li>
        <a class="waves-effect active" href="TeacherSubjects.aspx"><i class="mdi mdi-book-open-page-variant"></i><span>Subjects </span></a>
    </li>
    <li>
        <a class="waves-effect" href="TeacherStudents.aspx"><i class="mdi mdi-account"></i><span>Students </span></a>
    </li>
    <li>
        <a class="waves-effect" href="TeacherAssignments.aspx"><i class="mdi mdi-pen"></i><span>Assignments </span></a>
    </li>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceholder" runat="server">
    <asp:MultiView runat="server" ID="mvTeacherSubjects" OnActiveViewChanged="mvTeacherSubjects_ActiveViewChanged">
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
                                <a href="TeacherHome.aspx">Teacher</a>
                            </li>
                            <li class="active">Subjects
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
                <asp:Panel runat="server" ID="pEdit" Visible="false">
                    <div class="alert alert-icon alert-success alert-dismissible fade in" role="alert">
                        <button class="close" aria-label="Close" type="button" data-dismiss="alert">
                            <span aria-hidden="true">×</span>
                        </button>
                        <i class="mdi mdi-check-all"></i>
                        <strong>Success!</strong> Subject has been edited!
                                           
                    </div>
                </asp:Panel>
                <asp:Panel runat="server" ID="pDelete" Visible="false">
                    <div class="alert alert-icon alert-success alert-dismissible fade in" role="alert">
                        <button class="close" aria-label="Close" type="button" data-dismiss="alert">
                            <span aria-hidden="true">×</span>
                        </button>
                        <i class="mdi mdi-check-all"></i>
                        <strong>Success!</strong> Subject has been deleted!
                                           
                    </div>
                </asp:Panel>
            </div>
            <!-- ============================================================== -->
            <!-- Subject Table Start -->
            <!-- ============================================================== -->

                <div class="row form-group text-right" style="margin: 0 0 20px 0">
                    <asp:LinkButton runat="server" class="btn btn-primary" ID="btnSubjectsAdd" OnClick="btnSubjectAdd_Click1">
                        <i class="mdi mdi-plus"></i> Add New
                    </asp:LinkButton>
                </div>

                <table class="table m-0 table-colored table-primary">
                    <thead>
                        <tr>
                            <th>Title</th>
                            <th>Code</th>
                            <th>Group</th>
                            <th colspan="2"></th>

                        </tr>
                    </thead>
                    <tbody class=".table-striped">
                        <asp:Repeater runat="server" ID="subjectListRepeater" EnableViewState="false">
                            <ItemTemplate>
                                <tr style="height: 2em">
                                    <asp:TableCell runat="server" ID="tcSubjectTitle" Text='<%# Eval("subjectTitle") %>'></asp:TableCell>
                                    <asp:TableCell runat="server" ID="tcSubjectCode" Text='<%# Eval("subjectCode") %>'></asp:TableCell>
                                    <asp:TableCell runat="server" ID="tcSubjectGroup" Text='<%# Eval("subjectGroup") %>'></asp:TableCell>
                                    <td>
                                        <asp:LinkButton runat="server" CssClass="btn btn-success" ID="btnSubjectEdit" OnClick="btnSubjectEdit_Click"><i class="mdi mdi-clipboard-text"></i> Edit</asp:LinkButton>
                                    </td>
                                    <td>
                                        <asp:LinkButton runat="server" CssClass="btn btn-danger" ID="btnSubjectDelete" OnClick="btnSubjectDelete_Click"><i class="mdi mdi-delete"></i> Delete</asp:LinkButton>
                                            </td>
                                </tr>
                            </ItemTemplate>
                        </asp:Repeater>
                    </tbody>
                </table>
            <!-- ============================================================== -->
            <!-- Subject Table End -->
            <!-- ============================================================== -->
        </asp:View>
        <asp:View ID="vForm" runat="server">
            <div class="row">
                <div class="col-xs-12">
                    <div class="page-title-box">
                        <h4 class="page-title">Add New Subject</h4>
                        <ol class="breadcrumb p-0 m-0">
                            <li>
                                <a href="#">eTaleem</a>
                            </li>
                            <li>
                                <a href="TeacherHome.aspx">Teacher</a>
                            </li>
                            <li>
                                <a href="TeacherSubjects.aspx">Subjects</a>
                            </li>
                            <li class="active">Add New Subject
                            </li>
                        </ol>
                        <div class="clearfix"></div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-sm-12">
                    <div class="card-box">
                        <div class="row">
                            <div class="form-horizontal" role="form">
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label class="col-md-3 control-label">Code<span class="text-danger">*</span></label>
                                        <div class="col-md-9">
                                            <asp:TextBox runat="server" ID="txtSubjectCode" CssClass="form-control" placeholder="Code" autocomplete="off"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-md-3 control-label">Group<span class="text-danger">*</span></label>
                                        <div class="col-md-9">
                                            <asp:DropDownList runat="server" ID="ddlSubjectGroup" CssClass="form-control">
                                                <asp:ListItem>Creative and professional</asp:ListItem>
                                                <asp:ListItem>Humanities and social sciences</asp:ListItem>
                                                <asp:ListItem>Languages</asp:ListItem>
                                                <asp:ListItem>Mathematics</asp:ListItem>
                                                <asp:ListItem>Sciences</asp:ListItem>
                                            </asp:DropDownList>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-2">
                                    <div class="form-group" style="height: 63px">
                                        <label class="col-md-12 control-label" style="text-align: left">
                                            <asp:RequiredFieldValidator runat="server" ID="rfvSubjectCode" Text="Field is required" ControlToValidate="txtSubjectCode" ForeColor="IndianRed" Display="Dynamic"></asp:RequiredFieldValidator>
                                            <asp:RegularExpressionValidator runat="server" ValidationExpression="^\d+$" ControlToValidate="txtSubjectCode" ID="revSubjectCode1" Text="Digits only<br />" ForeColor="IndianRed" Display="Dynamic"></asp:RegularExpressionValidator>
                                            <asp:RegularExpressionValidator runat="server" ValidationExpression="^[\d]{4}$" ControlToValidate="txtSubjectCode" ID="revSubjectCode2" Text="Must be 4 digits long" ForeColor="IndianRed" Display="Dynamic"></asp:RegularExpressionValidator>
                                            <asp:Label runat="server" Visible="false" ForeColor="IndianRed" ID="lblSubjectCode" Text="Subject Code already exists"></asp:Label>
                                        </label>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group" style="height: 63px">
                                        <label class="col-md-3 control-label">Title<span class="text-danger">*</span></label>
                                        <div class="col-md-9">
                                            <asp:TextBox runat="server" ID="txtSubjectTitle" CssClass="form-control" placeholder="Title" autocomplete="off"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-md-3 control-label">Description<span class="text-danger">*</span></label>
                                        <div class="col-md-9">
                                            <asp:TextBox runat="server" ID="txtSubjectDescription" CssClass="form-control" TextMode="MultiLine" placeholder="Description" autocomplete="off"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-2">
                                    <div class="form-group" style="height: 63px">
                                        <label class="col-md-12 control-label" style="text-align: left">
                                            <asp:RequiredFieldValidator runat="server" ID="rfvSubjectTitle" Text="Field is required" ControlToValidate="txtSubjectTitle" ForeColor="IndianRed" Display="Dynamic"></asp:RequiredFieldValidator>
                                            <asp:RegularExpressionValidator runat="server" ValidationExpression="^[a-zA-Z ]+$" ControlToValidate="txtSubjectTitle" ID="revSubjectTitle" Text="Letters only" ForeColor="IndianRed" Display="Dynamic"></asp:RegularExpressionValidator>
                                        </label>
                                    </div>
                                    <br />
                                    <div class="form-group" style="height: 63px">
                                        <label class="col-md-12 control-label" style="text-align: left">
                                            <asp:RequiredFieldValidator runat="server" ID="rfvSubjectDescription" Text="Field is required" ControlToValidate="txtSubjectDescription" ForeColor="IndianRed" Display="Dynamic"></asp:RequiredFieldValidator>
                                        </label>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row form-group text-right m-b-0" style="width: 83.3%">
                <asp:Button runat="server" class="btn btn-danger" Text="Cancel" ID="btnCancel" OnClick="btnSubjectCancel_Click" CausesValidation="false"></asp:Button>
                <asp:MultiView runat="server" ID="mvForm">
                    <asp:View ID="vFormNew" runat="server">
                        <asp:Button runat="server" class="btn btn-primary" Text="Add" ID="btnNewSubjectAdd" OnClick="btnNewSubjectAdd_Click"></asp:Button>
                    </asp:View>
                    <asp:View ID="vFormEdit" runat="server">
                        <asp:Button runat="server" class="btn btn-primary" Text="Edit" ID="btnNewSubjectEdit" OnClick="btnNewSubjectEdit_Click"></asp:Button>
                    </asp:View>
                </asp:MultiView>
            </div>
        </asp:View>
    </asp:MultiView>
</asp:Content>
