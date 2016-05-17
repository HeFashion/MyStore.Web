<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<ICollection<MyStore.App.Models.Authentication.ExternalLogin>>" %>

<% if (Model.Count > 0)
   { %>
<h3>Bạn đang sử dụng:</h3>
<table>
    <tbody>
        <% foreach (MyStore.App.Models.Authentication.ExternalLogin externalLogin in Model)
           { %>
        <tr>
            <td><%: externalLogin.ProviderDisplayName %></td>
            <td class="manage-form">
                <% if (ViewBag.ShowRemoveButton)
                   {
                       using (Html.BeginForm("Disassociate", "Account"))
                       { %>
                <%: Html.AntiForgeryToken() %>
                <div>
                    <%: Html.Hidden("provider", externalLogin.Provider) %>
                    <%: Html.Hidden("providerUserId", externalLogin.ProviderUserId) %>
                    <button class="btn btn-default" type="submit" title="Remove this <%: externalLogin.ProviderDisplayName %> credential from your account">Xoá liên kết</button>
                </div>
                <% }
                   }
                   else
                   { %>
                        &nbsp;
                    <% } %>
            </td>
        </tr>
        <% } %>
    </tbody>
</table>
<% } %>
