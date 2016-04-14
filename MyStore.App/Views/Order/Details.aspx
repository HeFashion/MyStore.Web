<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.master" Inherits="System.Web.Mvc.ViewPage<MyStore.App.Models.MyData.Order>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Details
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<h2>Details</h2>

<fieldset>
    <legend>Order</legend>

    <div class="display-label">
        <%: Html.DisplayNameFor(model => model.order_id) %>
    </div>
    <div class="display-field">
        <%: Html.DisplayFor(model => model.order_id) %>
    </div>

    <div class="display-label">
        <%: Html.DisplayNameFor(model => model.user_id) %>
    </div>
    <div class="display-field">
        <%: Html.DisplayFor(model => model.user_id) %>
    </div>

    <div class="display-label">
        <%: Html.DisplayNameFor(model => model.Order_Status_Codes.order_status_description) %>
    </div>
    <div class="display-field">
        <%: Html.DisplayFor(model => model.Order_Status_Codes.order_status_description) %>
    </div>

    <div class="display-label">
        <%: Html.DisplayNameFor(model => model.date_order_placed) %>
    </div>
    <div class="display-field">
        <%: Html.DisplayFor(model => model.date_order_placed) %>
    </div>

    <div class="display-label">
        <%: Html.DisplayNameFor(model => model.order_description) %>
    </div>
    <div class="display-field">
        <%: Html.DisplayFor(model => model.order_description) %>
    </div>

    <div class="display-label">
        <%: Html.DisplayNameFor(model => model.receipter_name) %>
    </div>
    <div class="display-field">
        <%: Html.DisplayFor(model => model.receipter_name) %>
    </div>

    <div class="display-label">
        <%: Html.DisplayNameFor(model => model.order_address) %>
    </div>
    <div class="display-field">
        <%: Html.DisplayFor(model => model.order_address) %>
    </div>

    <div class="display-label">
        <%: Html.DisplayNameFor(model => model.phone_number) %>
    </div>
    <div class="display-field">
        <%: Html.DisplayFor(model => model.phone_number) %>
    </div>

    <div class="display-label">
        <%: Html.DisplayNameFor(model => model.email_address) %>
    </div>
    <div class="display-field">
        <%: Html.DisplayFor(model => model.email_address) %>
    </div>
</fieldset>
<p>
    <%: Html.ActionLink("Edit", "Edit", new { /* id=Model.PrimaryKey */ }) %> |
    <%: Html.ActionLink("Back to List", "Index") %>
</p>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="ScriptsSection" runat="server">
</asp:Content>
