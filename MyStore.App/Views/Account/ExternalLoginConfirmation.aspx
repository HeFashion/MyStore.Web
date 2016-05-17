<%@ Page Language="C#" MasterPageFile="~/Views/Shared/SubSite.Master" Inherits="System.Web.Mvc.ViewPage<MyStore.App.Models.Authentication.RegisterExternalLoginModel>" %>

<asp:Content ID="externalLoginConfirmationTitle" ContentPlaceHolderID="TitleContent" runat="server">
    Đăng ký
</asp:Content>

<asp:Content ID="externalLoginConfirmationContent" ContentPlaceHolderID="MainContent" runat="server">
    <section id="form">
        <div class="container">
            <div class="row">
                <div class="col-sm-4">
                    <div class="signup-form">
                        <% using (Html.BeginForm("ExternalLoginConfirmation", "Account", new { ReturnUrl = ViewBag.ReturnUrl }))
                           { %>
                        <%: Html.AntiForgeryToken()%>
                        <%: Html.ValidationSummary(true)%>
                        <ol>
                            <li>
                                <%: Html.Label("1. Tên hiển thị trên website:")%>
                                <%: Html.TextBoxFor(m => m.UserName)%>
                            </li>
                            <li>
                                <%: Html.Label("2. Họ tên:")%>
                                <%: Html.DisplayFor(m => m.FullName)%>
                            </li>
                            <li>
                                <%: Html.Label("3. Địa chỉ email:")%>
                                <%: Html.DisplayFor(m => m.Email)%>
                            </li>
                        </ol>
                        <%: Html.HiddenFor(m => m.ExternalLoginData)%>
                        <%: Html.HiddenFor(m=> m.Verified) %>
                        <%: Html.HiddenFor(m => m.FullName)%>
                        <%: Html.HiddenFor(m => m.Email)%>
                        <button type="submit" class="btn btn-default">Hoàn Tất</button>
                        <% } %>
                    </div>

                </div>
            </div>
        </div>
    </section>

</asp:Content>

<asp:Content ID="scriptsContent" ContentPlaceHolderID="ScriptsSection" runat="server">
</asp:Content>
