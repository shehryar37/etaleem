<%@ Page Title="" Language="C#" MasterPageFile="~/loginMaster.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="eTaleem.Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder" runat="server">
    <%--<asp:ScriptManager EnablePartialRendering="true" ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <asp:UpdatePanel runat="server" ID="upSubjects">
        <ContentTemplate>--%>
            <asp:MultiView runat="server" ID="mvLogin" 
                OnActiveViewChanged="mvLogin_ActiveViewChanged">
                <%-- mvLogin(0) Login Page --%>
                <asp:View runat="server" ID="vLogin">
                    <div style="padding: 20px">
                        <div class="topbar-left" style="text-align: center">
                            <a class="logo"><span>E<span>Taleem</span></span><i class="mdi mdi-layers"></i></a>
                        </div>
                        <%-- Email & Password Input Start --%>
                        <div role="form" class="form-horizontal">
                            <div class="form-group">
                                <label>Email address</label>
                                <asp:TextBox runat="server" CssClass="form-control" ID="txtLoginEmail" placeholder="Enter email"></asp:TextBox>
                            </div>
                            <div class="form-group">
                                <label>Password</label>
                                <asp:TextBox runat="server" CssClass="form-control" ID="txtLoginPassword" placeholder="Enter password" TextMode="Password"></asp:TextBox>
                            </div>
                            <%-- Panel that only appears when the email and password combination is incorrect --%>
                            <asp:Panel runat="server" ID="pUnsuccessful" Visible="false">
                                <div class="alert alert-icon alert-danger alert-dismissible fade in" role="alert">
                                    <button class="close" aria-label="Close" type="button" data-dismiss="alert">
                                        <span aria-hidden="true">×</span>
                                    </button>
                                    <i class="mdi mdi-exclamation"></i>
                                    <strong>Login Unsuccessful!</strong> Invalid username or password!                 
                                </div>
                            </asp:Panel>
                            <%-- Panel that only appears when a user has registered and is redirected to mvLogin(0) --%>
                            <asp:Panel runat="server" ID="pRegister" Visible="false">
                                <div class="alert alert-icon alert-success alert-dismissible fade in" role="alert">
                                    <button class="close" aria-label="Close" type="button" data-dismiss="alert">
                                        <span aria-hidden="true">×</span>
                                    </button>
                                    <i class="mdi mdi-check-all"></i>
                                    <strong>Registration Successful!</strong> Account created!        
                                </div>
                            </asp:Panel>
                            <div style="float: right">
                                <%-- Button that redirects the user to the portal --%>
                                <asp:Button runat="server" CssClass="btn btn-primary" Text="Login" ID="btnLogin" OnClick="btnLogin_Click"></asp:Button>
                            </div>
                            <div class="form-group" style="margin-top: 20px">
                                <p>
                                    Don't have an account?
                            <asp:LinkButton runat="server" Style="color: #167ccb" ID="lbtnRegister" OnClick="lbtnRegister_Click">Register</asp:LinkButton>
                                </p>
                            </div>
                        </div>
                        <%-- Email & Password Input End --%>
                    </div>
                </asp:View>
                <%-- mvLogin(1) Register Page --%>
                <asp:View runat="server" ID="vRegister">
                    <asp:MultiView runat="server" ID="mvRegister">
                        <%-- mvRegister(0) Select user type(teacher or student) --%>
                        <asp:View runat="server" ID="vUserType">
                            <div style="margin: 10% 20%;">
                                <div class="row">
                                    <div class="form-group">
                                        <%-- Button that redirects to mvRegister(1) and mvSubjects(0) --%>
                                        <asp:Button runat="server" CssClass="btn btn-primary btn-bordered btn-block" Text="I am a teacher" ID="btnUserTypeTeacher" OnClick="btnUserTypeTeacher_Click"></asp:Button>
                                    </div>
                                </div>
                                <br />
                                <div class="row">
                                    <div class="form-group">
                                        <%-- Button that redirects to mvRegister(1) and mvSubjects(1) --%>
                                        <asp:Button runat="server" CssClass="btn btn-danger btn-bordered btn-block" Text="I am a student" ID="btnUserTypeStudent" OnClick="btnUserTypeStudent_Click"></asp:Button>
                                    </div>
                                </div>
                            </div>
                        </asp:View>
                        <%-- mvRegister(1) Opens a form where users and teachers enter their user information --%>
                        <asp:View runat="server" ID="vRegisterForm">
                            <div class="row" style="padding: 20px">
                                <div role="form" class="form-horizontal">
                                    <div class="topbar-left" style="text-align: center">
                                        <a class="logo"><span>E<span>Taleem</span></span><i class="mdi mdi-layers"></i></a>
                                    </div>
                                    <style>
                                        .col-md-5, .col-md-7 {
                                            padding: 0px;
                                        }

                                        .col-md-7 {
                                            text-align: right;
                                        }
                                    </style>
                                    <div class="col-md-12">
                                        <div class="form-group">
                                            <div class="col-md-5">
                                                <label>Full Name<span class="text-danger">*</span></label>
                                            </div>
                                            <div class="col-md-7">
                                                <label>
                                                    <asp:RequiredFieldValidator runat="server" ID="rfvRegisterName" Text="Field is required" ControlToValidate="txtRegisterName" ForeColor="IndianRed" Display="Dynamic"></asp:RequiredFieldValidator>
                                                    <asp:RegularExpressionValidator runat="server" ValidationExpression="^[a-zA-Z ]+$" ControlToValidate="txtRegisterName" ID="revRegisterName" Text="Letters only" ForeColor="IndianRed" Display="Dynamic"></asp:RegularExpressionValidator>
                                                </label>
                                            </div>
                                            <asp:TextBox runat="server" CssClass="form-control" ID="txtRegisterName" placeholder="Enter name" autocomplete="off"></asp:TextBox>
                                        </div>
                                        <div class="form-group">
                                            <div class="col-md-5">
                                                <label>Email address<span class="text-danger">*</span></label>
                                            </div>
                                            <div class="col-md-7">
                                                <label>
                                                    <asp:RequiredFieldValidator runat="server" ID="rfvRegisterEmail" Text="Field is required" ControlToValidate="txtRegisterEmail" ForeColor="IndianRed" Display="Dynamic"></asp:RequiredFieldValidator>
                                                    <asp:RegularExpressionValidator runat="server" ValidationExpression="^([a-zA-Z0-9_\-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([a-zA-Z0-9\-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$" ControlToValidate="txtRegisterEmail" ID="revRegisterEmail" Text="Invalid Email" ForeColor="IndianRed" Display="Dynamic"></asp:RegularExpressionValidator>
                                                    <asp:Label runat="server" Visible="false" ForeColor="IndianRed" ID="lblRegisterEmail" Text="Email already exists"></asp:Label>
                                                </label>
                                            </div>
                                            <asp:TextBox runat="server" CssClass="form-control" ID="txtRegisterEmail" placeholder="Enter email" autocomplete="off"></asp:TextBox>
                                        </div>
                                        <div class="form-group">
                                            <div class="col-md-5">
                                                <label>Password<span class="text-danger">*</span></label>
                                            </div>
                                            <div class="col-md-7">
                                                <label>
                                                    <asp:RequiredFieldValidator runat="server" ID="rfvRegisterPassword" Text="Field is required" ControlToValidate="txtRegisterPassword" ForeColor="IndianRed" Display="Dynamic"></asp:RequiredFieldValidator>
                                                    <asp:RegularExpressionValidator runat="server" ID="revRegisterPassword" ControlToValidate="txtRegisterPassword" ForeColor="IndianRed" Display="Dynamic" Text="Invalid Password" ValidationExpression="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)\S{6,20}$"></asp:RegularExpressionValidator>
                                                </label>
                                            </div>
                                            <asp:TextBox runat="server" CssClass="form-control" ID="txtRegisterPassword" placeholder="Enter password" TextMode="Password" autocomplete="off"></asp:TextBox>
                                        </div>
                                        <div class="form-group">
                                            <div class="col-md-5">
                                                <label>Confirm Password<span class="text-danger">*</span></label>
                                            </div>
                                            <div class="col-md-7">
                                                <label>
                                                    <asp:RequiredFieldValidator runat="server" ID="revRegisterPasswordConfirm" Text="Field is required" ControlToValidate="txtRegisterPasswordConfirm" ForeColor="IndianRed" Display="Dynamic"></asp:RequiredFieldValidator>
                                                    <asp:CompareValidator runat="server" ControlToCompare="txtRegisterPassword" ControlToValidate="txtRegisterPasswordConfirm" ID="cvRegisterPasswordConfirm" Text="Passwords to not match" ForeColor="IndianRed" Display="Dynamic"></asp:CompareValidator>
                                                </label>
                                            </div>
                                            <asp:TextBox runat="server" CssClass="form-control" ID="txtRegisterPasswordConfirm" placeholder="Confirm password" TextMode="Password" autocomplete="off"></asp:TextBox>
                                        </div>
                                        <asp:MultiView runat="server" ID="mvSubject">
                                            <%-- mvSubject(0) Teachers choose a subject from the DropDownList TODO: Fix Selection Bug --%>
                                            <asp:View runat="server" ID="vSubjectTeacher">
                                                <div class="form-group">
                                                    <label>Subject<span class="text-danger">*</span></label>
                                                    <asp:DropDownList runat="server" CssClass="form-control" ID="ddlRegisterSubject">
                                                    </asp:DropDownList>
                                                    <div class="checkbox checkbox-primary">
                                                        <asp:CheckBox runat="server" Text=" My subject is not on this list" ID="cbNoSubject" OnCheckedChanged="cbNoSubject_CheckedChanged"/>
                                                    </div>
                                                </div>
                                            </asp:View>
                                            <%-- mvSubject(1) Students do not pick their subjects on this page --%>
                                            <asp:View runat="server" ID="vSubjectStudent">
                                            </asp:View>
                                        </asp:MultiView>
                                    </div>
                                </div>
                            </div>
                            <asp:MultiView runat="server" ID="mvButton">
                                <asp:View runat="server" ID="vButtonTeacher">
                                    <div class="row">
                                        <div style="float: right; padding: 0 20px 20px 0">
                                            <asp:Button runat="server" CssClass="btn btn-primary" Text="Register" ID="btnRegisterTeacher" OnClick="btnRegisterTeacher_Click"></asp:Button>
                                        </div>
                                    </div>
                                </asp:View>
                                <asp:View runat="server" ID="vButtonStudent">
                                    <div style="float: right; padding: 0 20px 20px 0">
                                        <asp:Button runat="server" CssClass="btn btn-primary" Text="Next" ID="btnStudentNext" OnClick="btnStudentNext_Click"></asp:Button>
                                    </div>
                                </asp:View>
                            </asp:MultiView>

                        </asp:View>
                        <%-- mvRegister(2) Opens a form where students pick their subjects --%>
                        <asp:View runat="server" ID="vRegisterSubjects">
                            <div class="row" style="padding: 20px">
                                <div role="form" class="form-horizontal">
                                    <div class="topbar-left" style="text-align: center">
                                        <a class="logo"><span>E<span>Taleem</span></span><i class="mdi mdi-layers"></i></a>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <label>Subjects to choose from:</label>
                                    </div>
                                    <br />
                                </div>
                                <%--<asp:ScriptManager EnablePartialRendering="true" ID="ScriptManager1" runat="server"></asp:ScriptManager>--%>

                                <div role="form" class="form-horizontal">
                                    <asp:Repeater runat="server" ID="rRegisterSubjects">
                                        <ItemTemplate>
                                            <asp:Button runat="server" ID="btnSubjects" CssClass='<%# "btn btn-" + eTaleem.ControlManager.setPanelColor(Eval("subjectGroup").ToString()) %>' Style="border-radius: 20px; margin: 5px 2px; font-size: 13px" Text='<%# Eval("subjectName")%>' OnClick="btnSubjects_Click"></asp:Button>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </div>
                                <br />
                                <div class="row">
                                    <div class="col-md-12">
                                        <label>Your subjects:</label>
                                    </div>

                                </div>
                                <div role="form" class="form-horizontal">
                                    <asp:Repeater runat="server" ID="rRegisterSubjectsSelected">
                                        <ItemTemplate>
                                            <asp:Button runat="server" ID="btnSubjectsSelected" CssClass='<%# "btn btn-" + eTaleem.ControlManager.setPanelColor(Eval("subjectGroup").ToString()) %>' Style="border-radius: 20px; margin: 5px 2px; font-size: 13px" Text='<%# Eval("subjectName")%>' OnClick="btnSubjectsSelected_Click"></asp:Button>
                                        </ItemTemplate>
                                    </asp:Repeater>

                                </div>

                                <br />

                                <%-- Alert Panel that only appears when no subjects are picked --%>
                                <asp:Panel runat="server" ID="pNoSubjects" Visible="false">
                                    <div class="alert alert-icon alert-danger alert-dismissible fade in" role="alert">
                                        <button class="close" aria-label="Close" type="button" data-dismiss="alert">
                                            <span aria-hidden="true">×</span>
                                        </button>
                                        <i class="mdi mdi-exclamation"></i>
                                        <strong>Registration Unsuccessful!</strong> You did not pick any subjects!                 
                                    </div>
                                </asp:Panel>
                                <%-- Alert Panel that only appears when less than 3 subjects are picked --%>
                                <asp:Panel runat="server" ID="pLessThan3Subjects" Visible="false">
                                    <div class="alert alert-icon alert-danger alert-dismissible fade in" role="alert">
                                        <button class="close" aria-label="Close" type="button" data-dismiss="alert">
                                            <span aria-hidden="true">×</span>
                                        </button>
                                        <i class="mdi mdi-exclamation"></i>
                                        <strong>Registration Unsuccessful!</strong> You picked less than 3 subjects!                 
                                    </div>
                                </asp:Panel>
                                <%-- Warning Panel that only appears when more than 3 subjects are picked --%>
                                <asp:Panel runat="server" ID="p3OrMoreSubjects" Visible="false">
                                    <div class="alert alert-icon alert-danger alert-dismissible fade in" role="alert">
                                        <button class="close" aria-label="Close" type="button" data-dismiss="alert">
                                            <span aria-hidden="true">×</span>
                                        </button>
                                        <i class="mdi mdi-alert"></i>
                                        <strong>Registration Warning!</strong> Selecting more than 3 subjects may lead to
                                <p class=".alert-warning">depression, anxiety and in some cases: suicide!</p>
                                    </div>
                                </asp:Panel>
                                <br />
                                <div class="row">
                                    <div style="float: right; padding: 0 20px 20px 0">
                                        <asp:MultiView runat="server" ID="mvRegisterStudentButton">
                                            <%-- mvStudentRegisterButton(0) If three subjects or less are selected or btnConfirmStudent is clicked--%>
                                            <asp:View ID="v1" runat="server">
                                                <asp:Button runat="server" CssClass="btn btn-primary" Text="Submit" ID="btnNextStudent" OnClick="btnNextStudent_Click"></asp:Button>
                                            </asp:View>
                                            <%-- mvStudentRegisterButton(1) If three subjects or less are selected or btnConfirmStudent is clicked--%>
                                            <asp:View ID="v2" runat="server">
                                                <asp:Button runat="server" CssClass="btn btn-danger" Text="Confirm" ID="btnConfirmStudent" OnClick="btnConfirmStudent_Click"></asp:Button>
                                            </asp:View>
                                        </asp:MultiView>
                                    </div>
                                </div>
                           </div>
                        </asp:View>
                        <%-- mvRegister(3) After students select their subjects, they have to choose appropriate teachers --%>

                        <%--<asp:View runat="server" ID="vRegisterTeachers">
                            <asp:ScriptManager EnablePartialRendering="true" ID="ScriptManager1" runat="server">
                            </asp:ScriptManager>
                            <%--<asp:UpdatePanel runat="server" ID="upTeachers">
                                <ContentTemplate>
                                    <div class="row" style="padding: 20px">
                                        <div role="form" class="form-horizontal">
                                            <div class="topbar-left" style="text-align: center">
                                                <a class="logo"><span>E<span>Taleem</span></span><i class="mdi mdi-layers"></i></a>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-12">
                                                <asp:Label runat="server" Text="Choose your teachers:"></asp:Label>
                                            </div>
                                        </div>
                                        <div role="form" class="form-horizontal" style="padding: 20px">
                                            <asp:Repeater runat="server" ID="rRegisterTeachers">
                                                <ItemTemplate>
                                                    <div class="form-group">
                                                        <asp:Label runat="server" Text='<%# Eval("subjectName")%>' ID="lblSubjectName"></asp:Label>
                                                        <asp:DropDownList runat="server" CssClass="form-control" ID="ddlRegisterTeacher">
                                                        </asp:DropDownList>
                                                    </div>
                                                </ItemTemplate>
                                            </asp:Repeater>

                                        </div>
                                        <div class="row">
                                            <div style="float: right; padding: 0 20px 20px 0">
                                                <asp:Button runat="server" CssClass="btn btn-primary" Text="Next" ID="btnRegisterStudent" OnClick="btnRegisterStudent_Click"></asp:Button>
                                            </div>
                                        </div>
                                    </div>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </asp:View>--%>
                    </asp:MultiView>
                </asp:View>
            </asp:MultiView>
        <%--</ContentTemplate>
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="btnStudentNext" EventName="Click" />
        </Triggers>
    </asp:UpdatePanel>--%>
</asp:Content>
            
