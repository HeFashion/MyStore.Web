﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site_Admin.Master" Inherits="System.Web.Mvc.ViewPage<MyStore.App.Models.MyData.Ref_Product_Type>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Edit Catalog
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <h2>Edit Catalog</h2>

    <% using (Html.BeginForm())
       { %>
    <%: Html.AntiForgeryToken() %>
    <%: Html.ValidationSummary(true) %>

    <fieldset>
        <legend>Edit For <%:Model.product_type_title_vn %></legend>
        <%:Html.HiddenFor(model=>model.product_type_id) %>
        <%:Html.HiddenFor(model=>model.product_type_order) %>
        <%:Html.HiddenFor(model=>model.parent_product_type_id) %>
        <%:Html.HiddenFor(model=>model.product_type_code) %>
        <div class="editor-label">
            <%: Html.LabelFor(model => model.parent_product_type_id) %>
        </div>
        <div class="editor-field">
            <%: Html.DropDownList("parent_product_type_id", Convert.ToString(Model.parent_product_type_id)) %>
            <%: Html.ValidationMessageFor(model => model.parent_product_type_id) %>
        </div>

        <div class="editor-label">
            <%: Html.LabelFor(model => model.product_type_title_vn) %>
        </div>
        <div class="editor-field">
            <%: Html.EditorFor(model => model.product_type_title_vn) %>
            <%: Html.ValidationMessageFor(model => model.product_type_title_vn) %>
        </div>

        <div class="editor-label">
            <%: Html.LabelFor(model => model.product_type_title_en) %>
        </div>
        <div class="editor-field">
            <%: Html.EditorFor(model => model.product_type_title_en) %>
            <%: Html.ValidationMessageFor(model => model.product_type_title_en) %>
        </div>
        <div class="editor-label">
            <%: Html.Label("Is Active") %>
        </div>
        <div class="editor-field">
            <%: Html.CheckBoxFor(model => model.is_active) %>
        </div>
        <p>
            <input type="submit" value="Save" />
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
</asp:Content>
