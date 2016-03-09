<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site_Admin.Master" Inherits="System.Web.Mvc.ViewPage<MyStore.App.Models.MyData.Unit_Of_Measure>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    EditUOM
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <h2>EditUOM</h2>

    <% using (Html.BeginForm())
       { %>
    <%: Html.AntiForgeryToken() %>
    <%: Html.ValidationSummary(true) %>
    <%: Html.HiddenFor(model => model.UOM_id) %>

    <fieldset>
        <legend>Unit_Of_Measure</legend>

        <div class="editor-label">
            <%: Html.LabelFor(model => model.UOM_description) %>
        </div>
        <div class="editor-field">
            <%: Html.EditorFor(model => model.UOM_description) %>
            <%: Html.ValidationMessageFor(model => model.UOM_description) %>
        </div>

        <div class="editor-label">
            <%: Html.LabelFor(model => model.Del_Flag) %>
        </div>
        <div class="editor-field">
            <%: Html.EditorFor(model => model.Del_Flag) %>
            <%: Html.ValidationMessageFor(model => model.Del_Flag) %>
        </div>

        <p>
            <input type="submit" value="Save" />
        </p>
    </fieldset>
    <% } %>

    <div>
        <%: Html.ActionLink("Back to List", "ListOfUOM") %>
    </div>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="ScriptsSection" runat="server">
    <%: Scripts.Render("~/bundles/jqueryval") %>
</asp:Content>
