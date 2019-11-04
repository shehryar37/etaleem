<%@ Page Title="" Language="C#" MasterPageFile="~/master.Master" AutoEventWireup="true" CodeBehind="TeacherAssignments.aspx.cs" Inherits="eTaleem.TeacherAssignments" %>

<asp:Content ID="Content1" ContentPlaceHolderID="SidebarPlaceholder" runat="server">
    <li>
        <a class="waves-effect" href="TeacherHome.aspx"><i class="mdi mdi-home"></i><span>Home </span></a>
    </li>
    <li>
        <a class="waves-effect" href="TeacherSubjects.aspx"><i class="mdi mdi-book-open-page-variant"></i><span>Subjects </span></a>
    </li>
    <li>
        <a class="waves-effect" href="TeacherStudents.aspx"><i class="mdi mdi-account"></i><span>Students </span></a>
    </li>
    <li>
        <a class="waves-effect active" href="TeacherAssignments.aspx"><i class="mdi mdi-pen"></i><span>Assignments </span></a>
    </li>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceholder" runat="server">
    <asp:MultiView runat="server" ID="mvTeacherAssignments">
        <asp:View runat="server" ID="vSubjects">
            <div class="row">
                <div class="col-xs-12">
                    <div class="page-title-box">
                        <h4 class="page-title">Assignments</h4>
                        <ol class="breadcrumb p-0 m-0">
                            <li>
                                <a href="#">eTaleem</a>
                            </li>
                            <li>
                                <a href="TeacherHome.aspx">Teacher</a>
                            </li>
                            <li>
                                <a>Assignments</a>
                            </li>
                        </ol>
                        <div class="clearfix"></div>
                    </div>
                </div>
            </div>
            <asp:Panel runat="server" ID="pCreate" Visible="false">
                <div class="alert alert-icon alert-success alert-dismissible fade in" role="alert">
                    <button class="close" aria-label="Close" type="button" data-dismiss="alert">
                        <span aria-hidden="true">×</span>
                    </button>
                    <i class="mdi mdi-check-all"></i>
                    <strong>Success!</strong> Assignment has been created!                 
                </div>
            </asp:Panel>
            <div class="row form-group text-right" style="margin: 0 0 20px 0">
                <asp:LinkButton runat="server" class="btn btn-danger" ID="btnViewArchives" OnClick="btnViewArchives_Click">
                        <i class="mdi mdi-archive"></i> View Archives
                </asp:LinkButton>
                <asp:LinkButton runat="server" class="btn btn-primary" ID="btnViewAssignments" OnClick="btnViewAssignments_Click" Visible="false">
                        <i class="mdi mdi-pen"></i> View Assignments
                </asp:LinkButton>
                <asp:LinkButton runat="server" class="btn btn-primary" ID="btnAssignmentAdd" OnClick="btnAssignmentAdd_Click">
                        <i class="mdi mdi-plus"></i> New Assignment
                </asp:LinkButton>
            </div>
            <br />
            <%--<asp:ScriptManager EnablePartialRendering="true" ID="ScriptManager1" runat="server">
        </asp:ScriptManager>--%>
            <asp:UpdatePanel runat="server" ID="upAssignment" UpdateMode="Conditional">
                <ContentTemplate>
                    <asp:Repeater runat="server" ID="rAssignment" EnableViewState="false" OnItemDataBound="rAssignment_ItemDataBound">
                        <ItemTemplate>
                            <div class="panel panel-color panel-<%#eTaleem.AssignmentManager.getPanelColor(Convert.ToDateTime(Eval("assignmentEndDate")), (bool)Eval("IsGraded")) %>">
                                <div class="panel-heading" style="height: 46.5px">
                                    <asp:Label runat="server" ID="lblAssignmentID" Visible="false" Text='<%# Eval("assignmentID") %>'></asp:Label>
                                    <h3 class="panel-title col-md-11"><%#Eval("assignmentTitle") %></h3>
                                    <div class="col-md-1" style="text-align: right;">
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
                                    </div>
                                </div>
                                <br />
                                <asp:Panel runat="server" ID="pAssignmentBody" class="panel-body">
                                    <div class="col-md-9">
                                        <div class="card-box" style="height: 22em">
                                            <label style="font-size: 18px;">Question Statement</label>
                                            <p style="height: 14em">
                                                <%# Eval("assignmentQuestionStatement") %>
                                            </p>
                                            <div class="row form-group text-center" style="margin-bottom: 0">
                                                <asp:LinkButton runat="server" ID="btnDownloadFiles" CssClass="btn btn-primary" OnClick="btnDownloadFiles_Click">
                                <i class="mdi mdi-download"></i> Download Supplementary files
                                                </asp:LinkButton>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-3" style="height: 15em">
                                        <div class="card-box" style="padding: 0px; height: 22em">
                                            <div style="padding: 20px">
                                                <label style="font-size: 18px;">Start time</label>
                                                <p><%# Eval("assignmentStartDate") %></p>
                                                <br />
                                                <label style="font-size: 18px;">End time</label>
                                                <p><%# Eval("assignmentEndDate") %></p>
                                                <br />
                                                <p><strong>X</strong> out of <strong>Y</strong> students have completed this assignment</p>
                                            </div>
                                            <asp:UpdatePanel runat="server" ID="upTimer" UpdateMode="Conditional">
                                                <ContentTemplate>
                                                    <div style="width: 100%; background-color: red; height: 34px; color: white; text-align: center;">
                                                        <asp:Label runat="server" ID="lDeadline" Style="padding-top: 100%; padding: 5px; font-size: 20px; margin: 0"></asp:Label>
                                                        <asp:Timer runat="server" Interval="1000" ID="tDeadline" OnTick="tDeadline_Tick"></asp:Timer>
                                                    </div>
                                                    <asp:Label runat="server" Visible="false" ID="lEndDate" Text='<%# Eval("assignmentEndDate") %>'></asp:Label>
                                                </ContentTemplate>
                                                <Triggers>
                                                    <asp:AsyncPostBackTrigger ControlID="tDeadline" EventName="Tick" />
                                                </Triggers>
                                            </asp:UpdatePanel>
                                            <asp:Button runat="server" ID="btnExtend" CssClass="btn-block btn-primary" Text="Extend" Height="34px" Style="border-bottom-left-radius: 4px; border-bottom-right-radius: 4px" />
                                        </div>
                                    </div>
                                </asp:Panel>
                                <div class="panel-footer" style="height: 50px">
                                    <div style="float: right">
                                        <asp:Button runat="server" ID="btnArchive" CssClass="btn btn-danger" Text="Archive" OnClick="btnArchive_Click"/>
                                        <asp:Button runat="server" ID="btnGrade" CssClass="btn btn-success" Text="Grade" OnClick="btnGrade_Click"/>
                                    </div>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </ContentTemplate>
            </asp:UpdatePanel>
        </asp:View>
        <asp:View runat="server" ID="vForm">
            <div class="row">
                <div class="col-xs-12">
                    <div class="page-title-box">
                        <h4 class="page-title">Subjects</h4>
                        <ol class="breadcrumb p-0 m-0">
                            <li>
                                <a href="#">eTaleem</a>
                            </li>
                            <li>
                                <a href="Home.aspx">Teacher</a>
                            </li>
                            <li>
                                <a href="TeacherAssignments.aspx">Assignments</a>
                            </li>
                            <li class="active">New Assignments
                            </li>
                        </ol>
                        <div class="clearfix"></div>
                    </div>
                </div>
            </div>
            <div class="card-box">
                <div class="row">
                    <div class="form-horizontal">
                        <div class="col-md-4">
                            <div class="form-group">
                                <label class="col-md-3 control-label">Assignment Title<span class="text-danger">*</span></label>
                                <div class="col-md-9">
                                    <asp:TextBox runat="server" ID="txtAssignmentTitle" CssClass="form-control" autocomplete="off"></asp:TextBox>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-md-3 control-label">Question Statement<span class="text-danger">*</span></label>
                                <div class="col-md-9">
                                    <asp:TextBox runat="server" TextMode="MultiLine" ID="txtQuestionStatement" Height="10em" CssClass="form-control" autocomplete="off"></asp:TextBox>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-md-3 control-label">Supplementary Files</label>
                                <div class="col-md-9">
                                    <asp:FileUpload runat="server" ID="fuSupplementaryFiles" CssClass="form-control" />
                                </div>
                            </div>
                        </div>
                        <div class="col-md-2">
                            <div class="form-group" style="height: 37px">
                                <label class="col-md-12 control-label" style="text-align: left">
                                    <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator1" Text="Field is required" ControlToValidate="txtAssignmentTitle" ForeColor="IndianRed" Display="Dynamic"></asp:RequiredFieldValidator>
                                </label>
                            </div>
                            <div class="form-group" style="height: 37px">
                                <label class="col-md-12 control-label" style="text-align: left">
                                    <asp:RequiredFieldValidator runat="server" ID="rfvQuestionStatement" Text="Field is required" ControlToValidate="txtQuestionStatement" ForeColor="IndianRed" Display="Dynamic"></asp:RequiredFieldValidator>
                                    
                                    <asp:RegularExpressionValidator runat="server" ID="revQuestionStatement" Text="Cannot exceed 500 characters" ControlToValidate="txtQuestionStatement" ForeColor="IndianRed" Display="Dynamic" ValidationExpression="^\w{0,500}$"></asp:RegularExpressionValidator>
                                </label>
                            </div>

                            <%-- Check this --%>
                            <div class="form-group" style="height: 100px">
                                <asp:Label runat="server" ForeColor="IndianRed" Visible="false" ID="lSupplementaryFiles" Text="Upload a .docx or .pdf file"></asp:Label>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <label class="col-md-3 control-label">Start Date<span class="text-danger">*</span></label>
                            <div class="col-md-9">
                                <div class="form-group">
                                    <asp:TextBox runat="server" TextMode="Date" ID="dtStartDate" CssClass="form-control" autocomplete="off">

                                    </asp:TextBox>
                                </div>
                            </div>
                            <label class="col-md-3 control-label">End Date<span class="text-danger">*</span></label>
                            <div class="col-md-9">
                                <div class="form-group">
                                    <asp:TextBox runat="server" TextMode="Date" ID="dtEndDate" CssClass="form-control" autocomplete="off">
                                    </asp:TextBox>
                                </div>
                            </div>
                            <label class="col-md-3 control-label">Maximum Marks<span class="text-danger">*</span></label>
                            <div class="col-md-9">
                                <div class="form-group">
                                    <asp:TextBox runat="server" ID="txtMaximumMarks" CssClass="form-control" autocomplete="off">

                                    </asp:TextBox>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-2">
                        <div class="form-horizontal">
                            <div class="form-group" style="height: 37px">
                                <label class="col-md-12 control-label" style="text-align: left">
                                    <asp:RequiredFieldValidator runat="server" ID="rfvStartDate" Text="Field is required" ControlToValidate="dtStartDate" ForeColor="IndianRed" Display="Dynamic"></asp:RequiredFieldValidator>
                                </label>
                                <asp:Label runat="server" ForeColor="IndianRed" Visible="false" ID="regStartDate">Please set a future date</asp:Label>
                            </div>
                            <div class="form-group" style="height: 37px">
                                <label class="col-md-12 control-label" style="text-align: left">
                                    <asp:RequiredFieldValidator runat="server" ID="rfvEndDate" Text="Field is required" ControlToValidate="dtEndDate" ForeColor="IndianRed" Display="Dynamic"></asp:RequiredFieldValidator>
                                </label>
                                <asp:Label runat="server" ForeColor="IndianRed" Visible="false" ID="regEndDate">Assignment cannot end before starting</asp:Label>
                            </div>
                            <div class="form-group">
                                <label class="col-md-12 control-label" style="text-align: left">
                                    <asp:RequiredFieldValidator runat="server" ID="rfvMaximumMarks" Text="Field is required" ControlToValidate="txtMaximumMarks" ForeColor="IndianRed" Display="Dynamic"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator runat="server" ID="revMaximumMarks" Text="Enter digits only" ControlToValidate="txtMaximumMarks" ForeColor="IndianRed" Display="Dynamic" ValidationExpression="^[0-9]+$"></asp:RegularExpressionValidator>
                                </label>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row form-group text-right m-b-0" style="width: 83.3%">
                    <asp:Button runat="server" class="btn btn-primary" Text="Submit" ID="btnSubmit" OnClick="btnSubmit_Click"></asp:Button>
                </div>
            </div>
        </asp:View>
        <asp:View ID="vGrade">
            <div class="row">
                <div class="col-xs-12">
                    <div class="page-title-box">
                        <h4 class="page-title">Subjects</h4>
                        <ol class="breadcrumb p-0 m-0">
                            <li>
                                <a href="#">eTaleem</a>
                            </li>
                            <li>
                                <a href="Home.aspx">Teacher</a>
                            </li>
                            <li>
                                <a href="TeacherAssignments.aspx">Assignments</a>
                            </li>
                            <li class="active">Grading
                            </li>
                        </ol>
                        <div class="clearfix"></div>
                    </div>
                </div>
            </div>
        </asp:View>
    </asp:MultiView>
</asp:Content>
