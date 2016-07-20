<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/SubSite.Master" Inherits="System.Web.Mvc.ViewPage<MyStore.App.Models.Authentication.RecoveryModelConfirmed>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Khôi Phục Mật Khẩu
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <section id="form">
        <div class="container">
            <div class="row">
                <div class="col-sm-4">
                    <!--sign up form-->
                    <div class="signup-form">
                        <h2>Xác Nhận Mật Khẩu Mới</h2>
                        <% using (Html.BeginForm("PasswordRecoveryAction", "Account"))
                           { %>
                        <%: Html.AntiForgeryToken() %>
                        <%: Html.ValidationSummary() %>
                        <%: Html.HiddenFor(m=>m.RecoveryToken) %>
                        <%: Html.PasswordFor(m => m.NewPassword,new {@placeholder="Mật khẩu mới" }) %>
                        <%: Html.PasswordFor(m => m.ConfirmPassword,new {@placeholder="Nhập lại mật khẩu" }) %>
                        <button type="submit" class="btn btn-default">Hoàn thành</button>
                        <% } %>
                    </div>
                    <!--/sign up form-->
                </div>
            </div>
        </div>
    </section>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="ScriptsSection" runat="server">
</asp:Content>
