<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site_Admin.Master" Inherits="System.Web.Mvc.ViewPage<IEnumerable<MyStore.App.Models.MyData.Ref_Product_Type>>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Product Catalog
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <h2>Product Catalog</h2>

    <p>
        <%: Html.ActionLink("Create New", "CreateCatalog") %>
    </p>
    <table>
        <tr>
            <th>
                <%: Html.DisplayName("Vietnamese") %>
            </th>
            <th>
                <%: Html.DisplayName("English") %>
            </th>
            <th>
                <%: Html.DisplayName("Code") %>
            </th>
            <th></th>
        </tr>

        <% foreach (var item in Model)
           { %>
        <tr>
            <td style="font-weight: 500">
                <%: Html.DisplayFor(modelItem => item.product_type_title_vn) %>
            </td>
            <td style="font-weight: 500">
                <%: Html.DisplayFor(modelItem => item.product_type_title_en) %>
            </td>
            <td style="font-weight: 500">
                <%: Html.DisplayFor(modelItem => item.product_type_code) %>
            </td>
            <td>
                <%: Html.ActionLink("Edit", "EditCatalog", new {  id=item.product_type_id  }) %> |
                <%: Html.ActionLink("Delete", "DeleteCatalog", new { id=item.product_type_id }) %>
            </td>
        </tr>
        <%foreach (var childItem in item.Child_Product_Types)
          {%>
        <tr>
            <td style="text-indent: 50px">
                <%: Html.DisplayFor(modelItem => childItem.product_type_title_vn)%>
            </td>
            <td style="text-indent: 50px">
                <%: Html.DisplayFor(modelItem => childItem.product_type_title_en) %>
            </td>
            <td style="text-indent: 50px">
                <%: Html.DisplayFor(modelItem => childItem.product_type_code) %>
            </td>
            <td>
                <%: Html.ActionLink("Edit", "EditCatalog", new { id=childItem.product_type_id }) %> |
                <%: Html.ActionLink("Delete", "DeleteCatalog", new { id=childItem.product_type_id }) %>
            </td>
        </tr>
        <% } %>
        <% } %>
    </table>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="ScriptsSection" runat="server">
</asp:Content>
