<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site_Admin.Master" Inherits="System.Web.Mvc.ViewPage<MyStore.App.Models.MyData.Ref_Product_Type>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    DeleteCatalog
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <h2>DeleteCatalog</h2>

    <h3>Are you sure you want to delete this?</h3>
    <fieldset>
        <legend>Ref_Product_Type</legend>

        <div class="display-label">
            <%: Html.DisplayNameFor(model => model.product_type_id) %>
        </div>
        <div class="display-field">
            <%: Html.DisplayFor(model => model.product_type_id) %>
        </div>

        <div class="display-label">
            <%: Html.DisplayNameFor(model => model.parent_product_type_id) %>
        </div>
        <div class="display-field">
            <%: Html.DisplayFor(model => model.parent_product_type_id) %>
        </div>

        <div class="display-label">
            <%: Html.DisplayNameFor(model => model.product_type_title_vn) %>
        </div>
        <div class="display-field">
            <%: Html.DisplayFor(model => model.product_type_title_vn) %>
        </div>

        <div class="display-label">
            <%: Html.DisplayNameFor(model => model.product_type_title_en) %>
        </div>
        <div class="display-field">
            <%: Html.DisplayFor(model => model.product_type_title_en) %>
        </div>
    </fieldset>
    <% using (Html.BeginForm("DeleteCatalogConfirmed", "Admin", new { id = Model.product_type_id }))
       { %>
    <%: Html.AntiForgeryToken()%>
    <%: Html.ValidationSummary() %>
    <p>
        <input type="submit" value="Delete" />
        |
        <%: Html.ActionLink("Back to List", "ListOfCatalog")%>
    </p>
    <% } %>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="ScriptsSection" runat="server">
</asp:Content>
