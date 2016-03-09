<%@ Page Language="C#" MasterPageFile="~/Views/Shared/SubSite.Master" Inherits="System.Web.Mvc.ViewPage<MyStore.App.Models.Authentication.RegisterExternalLoginModel>" %>

<asp:Content ID="externalLoginConfirmationTitle" ContentPlaceHolderID="TitleContent" runat="server">
    Register
</asp:Content>

<asp:Content ID="externalLoginConfirmationContent" ContentPlaceHolderID="MainContent" runat="server">
    <section id="form">
        <div class="container">
            <div class="row">
                <div class="col-sm-4">
                    <div class="signup-form">
                        <% using (Html.BeginForm("ExternalLoginConfirmation", "Account", new { ReturnUrl = ViewBag.ReturnUrl }))
                           { %>
                        <%: Html.AntiForgeryToken() %>
                        <%: Html.ValidationSummary(true) %>

                        <%: Html.LabelFor(m => m.UserName) %>
                        <%: Html.TextBoxFor(m => m.UserName) %>

                        <%: Html.LabelFor(m=>m.FullName) %>
                        <br />
                        <%: Html.DisplayFor(m => m.FullName)%>
                        <br />
                        <%: Html.LabelFor(m=>m.Link) %>
                        <br />
                        <%: Html.DisplayFor(m => m.Link) %>
                        <%: Html.HiddenFor(m => m.ExternalLoginData) %>
                        <button type="submit" class="btn btn-default">Hoàn Tất</button>
                        <% } %>
                    </div>

                </div>
            </div>
        </div>
    </section>

</asp:Content>

<asp:Content ID="scriptsContent" ContentPlaceHolderID="ScriptsSection" runat="server">
    <%: Scripts.Render("~/bundles/jqueryval") %>
</asp:Content>
