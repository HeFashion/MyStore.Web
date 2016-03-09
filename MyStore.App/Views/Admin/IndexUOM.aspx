<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site_Admin.Master" Inherits="System.Web.Mvc.ViewPage<IEnumerable<MyStore.App.Models.MyData.Unit_Of_Measure>>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    IndexUOM
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <h2>IndexUOM</h2>

    <p>
        <%: Html.ActionLink("Create New", "Create") %>
    </p>
    <table>
        <tr>
            <th>
                <%: Html.DisplayName("Name") %>
            </th>
            <th>
                <%:Html.DisplayName("Unactive") %>
            </th>
            <th></th>
        </tr>

        <% foreach (var item in Model)
           { %>
        <tr>
            <td>
                <%: Html.DisplayFor(modelItem => item.UOM_description) %>
            </td>
            <td>
                <%: Html.CheckBoxFor(modelItem => item.Del_Flag, new {  @disabled="disabled" })%>
            </td>
            <td>
                <%: Html.ActionLink("Edit", "EditUOM", new { id=item.UOM_id  }) %> |
                <%: Html.ActionLink("Delete", "DeleteUOM",  new { id=item.UOM_id  }) %>
            </td>
        </tr>
        <% } %>
    </table>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="ScriptsSection" runat="server">
</asp:Content>
