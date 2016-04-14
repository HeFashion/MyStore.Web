<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.master" Inherits="System.Web.Mvc.ViewPage<MyStore.App.Models.MyData.Blog>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Details
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<h2>Details</h2>

<fieldset>
    <legend>Blog</legend>

    <div class="display-label">
        <%: Html.DisplayNameFor(model => model.blog_id) %>
    </div>
    <div class="display-field">
        <%: Html.DisplayFor(model => model.blog_id) %>
    </div>

    <div class="display-label">
        <%: Html.DisplayNameFor(model => model.blog_title) %>
    </div>
    <div class="display-field">
        <%: Html.DisplayFor(model => model.blog_title) %>
    </div>

    <div class="display-label">
        <%: Html.DisplayNameFor(model => model.blog_content) %>
    </div>
    <div class="display-field">
        <%: Html.DisplayFor(model => model.blog_content) %>
    </div>

    <div class="display-label">
        <%: Html.DisplayNameFor(model => model.blog_description) %>
    </div>
    <div class="display-field">
        <%: Html.DisplayFor(model => model.blog_description) %>
    </div>

    <div class="display-label">
        <%: Html.DisplayNameFor(model => model.blog_date_create) %>
    </div>
    <div class="display-field">
        <%: Html.DisplayFor(model => model.blog_date_create) %>
    </div>

    <div class="display-label">
        <%: Html.DisplayNameFor(model => model.blog_total_vote) %>
    </div>
    <div class="display-field">
        <%: Html.DisplayFor(model => model.blog_total_vote) %>
    </div>

    <div class="display-label">
        <%: Html.DisplayNameFor(model => model.blog_total_score) %>
    </div>
    <div class="display-field">
        <%: Html.DisplayFor(model => model.blog_total_score) %>
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
