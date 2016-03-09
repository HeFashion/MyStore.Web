<%@ Page Language="C#" MasterPageFile="~/Views/Shared/SubSite.Master" Inherits="System.Web.Mvc.ViewPage<MyStore.App.Models.Authentication.LoginModel>" %>

<asp:Content ID="loginTitle" ContentPlaceHolderID="TitleContent" runat="server">
    Đăng nhập
</asp:Content>

<asp:Content ID="loginContent" ContentPlaceHolderID="MainContent" runat="server">
    <section id="form">
        <div class="container">
            <div class="row">
                <div class="col-sm-4 col-sm-offset-1">
                    <%:Html.Partial("_LoginFormPartial", Model) %>
                </div>

                <div class="col-sm-1">
                    <h2 class="or">HOẶC</h2>

                </div>
                <div class="col-sm-4">
                    <h5>Sử dụng các mạng xã hội bên dưới để Đăng Nhập</h5>

                    <div class="social-icons pull-left">
                        <%--<%:Html.Action("ExternalLoginsList", "Account", new {returnUrl= ViewBag.ReturnUrl}) %>--%>
                        <a class="btn btn-block btn-social btn-twitter">
                            <span class="fa fa-twitter"></span>Sign in with Twitter
                        </a>

                        <a class="btn btn-block btn-social btn-facebook">
                            <span class="fa fa-facebook"></span>Sign in with Facebook
                        </a>

                        <a class="btn btn-block btn-social btn-google">
                            <span class="fa fa-google"></span>Sign in with Google
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </section>

</asp:Content>

<asp:Content ID="scriptsContent" ContentPlaceHolderID="ScriptsSection" runat="server">
    <%: Scripts.Render("~/bundles/jqueryval") %>
</asp:Content>
