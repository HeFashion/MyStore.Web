<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site_Admin.Master" Inherits="System.Web.Mvc.ViewPage<MyStore.App.Models.MyData.Unit_Of_Measure>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Delete UOM
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <h2>DeleteUOM</h2>

    <h3>Are you sure you want to delete this?</h3>
    <fieldset>
        <legend>Unit Of Measure</legend>

        <div class="display-label">
            <%: Html.DisplayNameFor(model => model.UOM_id) %>
        </div>
        <div class="display-field">
            <%: Html.DisplayFor(model => model.UOM_id) %>
        </div>

        <div class="display-label">
            <%: Html.DisplayNameFor(model => model.UOM_description) %>
        </div>
        <div class="display-field">
            <%: Html.DisplayFor(model => model.UOM_description) %>
        </div>

        <div class="display-label">
            <%: Html.DisplayNameFor(model => model.Del_Flag) %>
        </div>
        <div class="display-field">
            <%: Html.CheckBoxFor(model => model.Del_Flag, new {  @disabled="disabled" })%>
        </div>
    </fieldset>
    <% using (Html.BeginForm("DeleteUOMConfirmed", "Admin", FormMethod.Post))
       { %>
    <%: Html.AntiForgeryToken() %>
    <%: Html.ValidationSummary() %>
    <p>
        <button type="submit" value="<%:Model.UOM_id %>" name="id">Delete</button>
        |
        <%: Html.ActionLink("Back to List", "ListOfUOM") %>
    </p>
    <% } %>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="ScriptsSection" runat="server">
</asp:Content>
