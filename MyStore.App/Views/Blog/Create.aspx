<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.master" Inherits="System.Web.Mvc.ViewPage<MyStore.App.Models.MyData.Blog>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Create
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<h2>Create</h2>

<% using (Html.BeginForm()) { %>
    <%: Html.AntiForgeryToken() %>
    <%: Html.ValidationSummary(true) %>

    <fieldset>
        <legend>Blog</legend>

        <div class="editor-label">
            <%: Html.LabelFor(model => model.blog_id) %>
        </div>
        <div class="editor-field">
            <%: Html.EditorFor(model => model.blog_id) %>
            <%: Html.ValidationMessageFor(model => model.blog_id) %>
        </div>

        <div class="editor-label">
            <%: Html.LabelFor(model => model.blog_title) %>
        </div>
        <div class="editor-field">
            <%: Html.EditorFor(model => model.blog_title) %>
            <%: Html.ValidationMessageFor(model => model.blog_title) %>
        </div>

        <div class="editor-label">
            <%: Html.LabelFor(model => model.blog_content) %>
        </div>
        <div class="editor-field">
            <%: Html.EditorFor(model => model.blog_content) %>
            <%: Html.ValidationMessageFor(model => model.blog_content) %>
        </div>

        <div class="editor-label">
            <%: Html.LabelFor(model => model.blog_description) %>
        </div>
        <div class="editor-field">
            <%: Html.EditorFor(model => model.blog_description) %>
            <%: Html.ValidationMessageFor(model => model.blog_description) %>
        </div>

        <div class="editor-label">
            <%: Html.LabelFor(model => model.blog_date_create) %>
        </div>
        <div class="editor-field">
            <%: Html.EditorFor(model => model.blog_date_create) %>
            <%: Html.ValidationMessageFor(model => model.blog_date_create) %>
        </div>

        <div class="editor-label">
            <%: Html.LabelFor(model => model.blog_total_vote) %>
        </div>
        <div class="editor-field">
            <%: Html.EditorFor(model => model.blog_total_vote) %>
            <%: Html.ValidationMessageFor(model => model.blog_total_vote) %>
        </div>

        <div class="editor-label">
            <%: Html.LabelFor(model => model.blog_total_score) %>
        </div>
        <div class="editor-field">
            <%: Html.EditorFor(model => model.blog_total_score) %>
            <%: Html.ValidationMessageFor(model => model.blog_total_score) %>
        </div>

        <p>
            <input type="submit" value="Create" />
        </p>
    </fieldset>
<% } %>

<div>
    <%: Html.ActionLink("Back to List", "Index") %>
</div>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="ScriptsSection" runat="server">
    <%: Scripts.Render("~/bundles/jqueryval") %>
</asp:Content>
