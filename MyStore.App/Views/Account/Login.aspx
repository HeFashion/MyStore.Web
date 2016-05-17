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

                    <div class="external-login-form social-icons pull-left">
                        <h2>Đăng nhập với:</h2>
                        <%:Html.Action("ExternalLoginsList", "Account", new {returnUrl= ViewBag.ReturnUrl}) %>
                    </div>
                </div>
            </div>
        </div>
    </section>

</asp:Content>

<asp:Content ID="scriptsContent" ContentPlaceHolderID="ScriptsSection" runat="server">
    
</asp:Content>
