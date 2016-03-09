<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site_Admin.Master" Inherits="System.Web.Mvc.ViewPage<MyStore.App.Models.MyData.Ref_Product_Type>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Create Catalog
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <h2>Create Catalog</h2>

    <% using (Html.BeginForm())
       { %>
    <%: Html.AntiForgeryToken() %>
    <%: Html.ValidationSummary(true) %>

    <fieldset>
        <legend>Ref_Product_Type</legend>

        <div class="editor-label">
            <%: Html.LabelFor(model => model.parent_product_type_id) %>
        </div>
        <div class="editor-field">
            <%: Html.DropDownList("parent_product_type_id",string.Empty) %>
        </div>

        <div class="editor-label">
            <%: Html.LabelFor(model => model.product_type_description_vn) %>
        </div>
        <div class="editor-field">
            <%: Html.EditorFor(model => model.product_type_description_vn) %>
            <%: Html.ValidationMessageFor(model => model.product_type_description_vn) %>
        </div>

        <div class="editor-label">
            <%: Html.LabelFor(model => model.product_type_description_en) %>
        </div>
        <div class="editor-field">
            <%: Html.EditorFor(model => model.product_type_description_en) %>
            <%: Html.ValidationMessageFor(model => model.product_type_description_en) %>
        </div>

        <p>
            <input type="submit" value="Create" />
        </p>
    </fieldset>
    <% } %>

    <div>
        <%: Html.ActionLink("Back to List", "ListOfCatalog") %>
    </div>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="ScriptsSection" runat="server">
    <%: Scripts.Render("~/bundles/jqueryval") %>
</asp:Content>
