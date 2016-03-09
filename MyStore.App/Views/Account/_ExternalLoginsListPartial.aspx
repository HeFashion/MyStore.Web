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
<% if (Microsoft.Web.WebPages.OAuth.OAuthWebSecurity.IsAuthenticatedWithOAuth) %>
<% { %>
You are using <strong><%: String.Join(",", Microsoft.Web.WebPages.OAuth.OAuthWebSecurity.GetAccountsFromUserName(User.Identity.Name).Select(p=>p.Provider).ToList()) %> </strong>for loging to this website.
<% } %>
<% else %>
<% { %>
<ul id="socialLoginList" class="nav navbar-nav">
    <%using (Html.BeginForm("ExternalLogin", "Account", new { ReturnUrl = ViewBag.ReturnUrl }, FormMethod.Post, new { id = "externalLoginForm" }))
      { %>
    <%: Html.AntiForgeryToken() %>
    <% foreach (Microsoft.Web.WebPages.OAuth.AuthenticationClientData p in Model) %>
    <% { %>

    <li>
        <button type="submit" name="provider" value="<%:p.AuthenticationClient.ProviderName %>" class="btn btn-social-icon btn-<%:p.AuthenticationClient.ProviderName %>" title="<%:p.DisplayName %>">
            <%switch (p.AuthenticationClient.ProviderName)%>
            <%{%>
            <%case "facebook":%>
            <i class="fa fa-facebook-square fa-2x"></i>
            <%break;%>
            <%case "twitter":%>
            <i class="fa fa-twitter-square fa-2x"></i>
            <%break;%>
            <%case "linkedin":%>
            <%break;%>
            <%case "dribbble":%>
            <%break;%>
            <%case "google":%>
            <i class="fa fa-google-plus-square fa-2x"></i>
            <%break;%>
            <%default:%>
            <i class="fa fa-facebook-square fa-2x"></i>
            <%break;%>

            <%} %>
        </button>

    </li>

    <%}%>
</ul>
<% }%>
<% } %>

<% }%>
