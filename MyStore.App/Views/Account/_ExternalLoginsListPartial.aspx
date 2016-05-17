<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<ICollection<Microsoft.Web.WebPages.OAuth.AuthenticationClientData>>" %>

<% if (Model.Count == 0)
   { %>
<div class="message-info">
    <p>
        There are no external authentication services configured. See <a href="http://go.microsoft.com/fwlink/?LinkId=252166">this article</a>
        for details on setting up this ASP.NET application to support logging in via external services.
    </p>
</div>
<% } %>
<% else %>
<% { %>
<%using (Html.BeginForm("ExternalLogin", "Account", new { ReturnUrl = ViewBag.ReturnUrl }, FormMethod.Post, new { id = "externalLoginForm" }))
  { %>
<%: Html.AntiForgeryToken() %>
<% foreach (Microsoft.Web.WebPages.OAuth.AuthenticationClientData p in Model) %>
<% { %>

<button type="submit" name="provider" value="<%:p.AuthenticationClient.ProviderName %>" class="btn btn-block btn-social btn-<%:p.AuthenticationClient.ProviderName %>" title="<%:p.DisplayName %>">
    <span class="fa fa-<%:p.AuthenticationClient.ProviderName %>"></span>
    Đăng nhập với <%:p.DisplayName %>
</button>


<% }%>
<% }%>
<%} %>