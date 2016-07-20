<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/SubSite.Master" Inherits="System.Web.Mvc.ViewPage<MyStore.App.Models.Authentication.RecoveryModel>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Mật Khẩu
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <section id="form">
        <div class="container">
            <div class="row">
                <div class="col-sm-4">
                    <!--sign up form-->
                    <div class="signup-form">
                        <h2>Khôi phục mật khẩu</h2>
                        <% using (Html.BeginForm("PasswordRecoverySend", "Account"))
                           { %>
                        <%: Html.AntiForgeryToken() %>
                        <%: Html.ValidationSummary() %>
                        <%: Html.TextBoxFor(m => m.UserName,new {@placeholder="Địa chỉ email của bạn" }) %>
                        <button type="submit" class="btn btn-default">Gửi Email Khôi Phục</button>
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
