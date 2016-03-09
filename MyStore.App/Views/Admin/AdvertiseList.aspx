<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site_Admin.Master" Inherits="System.Web.Mvc.ViewPage<IEnumerable<MyStore.App.Models.MyData.Ad_Sliders>>" %>

<asp:Content ID="titleContent" ContentPlaceHolderID="TitleContent" runat="server">
    Advertisement
</asp:Content>

<asp:Content ID="mainContent" ContentPlaceHolderID="MainContent" runat="server">

    <h2>Advertisement List</h2>

    <p>
        <%: Html.ActionLink("Create New", "Create") %>
    </p>
    <table>
        <tr>
            <th>
                <%: Html.DisplayName("Title") %>
            </th>
            <th>
                <%: Html.DisplayName("Description") %>
            </th>
            <th>
                <%: Html.DisplayName("Link") %>
            </th>
            <th>
                <%: Html.DisplayName("Active") %>
            </th>
            <th>
                <%: Html.DisplayName("Image") %>
            </th>
            <th>
                <%: Html.DisplayName("Sub Image") %>
            </th>
            <th></th>
        </tr>

        <% foreach (var item in Model)
           { %>
        <tr>

            <td>
                <%: Html.DisplayFor(modelItem => item.slider_title) %>
            </td>
            <td>
                <%: Html.DisplayFor(modelItem => item.slider_desc) %>
            </td>
            <td>
                <%: Html.DisplayFor(modelItem => item.slider_link) %>
            </td>
            <td>
                <%: Html.DisplayFor(modelItem => item.slider_active) %>
            </td>
            <td>
                <%: Html.DisplayFor(modelItem => item.slider_main_img) %>
            </td>
            <td>
                <%: Html.DisplayFor(modelItem => item.slider_sub_img) %>
            </td>
            <td>
                <%: Html.ActionLink("Edit", "Edit", new { /* id=item.PrimaryKey */ }) %> |
                <%: Html.ActionLink("Delete", "Delete", new { /* id=item.PrimaryKey */ }) %>
            </td>
        </tr>
        <% } %>
    </table>

</asp:Content>

<asp:Content ID="featureContent" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>

<asp:Content ID="scriptContent" ContentPlaceHolderID="ScriptsSection" runat="server">
    <%:Styles.Render() %>
</asp:Content>
