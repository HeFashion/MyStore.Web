<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.master" Inherits="System.Web.Mvc.ViewPage<MyStore.App.Models.MyData.Blog>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Delete
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<h2>Delete</h2>

<h3>Are you sure you want to delete this?</h3>
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
<% using (Html.BeginForm()) { %>
    <%: Html.AntiForgeryToken() %>
    <p>
        <input type="submit" value="Delete" /> |
        <%: Html.ActionLink("Back to List", "Index") %>
    </p>
<% } %>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="ScriptsSection" runat="server">
</asp:Content>
