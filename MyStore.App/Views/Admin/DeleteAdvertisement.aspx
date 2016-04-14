<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site_Admin.Master" Inherits="System.Web.Mvc.ViewPage<MyStore.App.Models.MyData.Ad_Sliders>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Advertisement
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <h2>Delete Advertisement</h2>

    <h3>Are you sure you want to delete this?</h3>
    <fieldset>
        <legend>Ad_Sliders</legend>

        <div class="display-label">
            <%: Html.DisplayNameFor(model => model.slider_id) %>
        </div>
        <div class="display-field">
            <%: Html.DisplayFor(model => model.slider_id) %>
        </div>

        <div class="display-label">
            <%: Html.DisplayNameFor(model => model.slider_title) %>
        </div>
        <div class="display-field">
            <%: Html.DisplayFor(model => model.slider_title) %>
        </div>

        <div class="display-label">
            <%: Html.DisplayNameFor(model => model.slider_desc) %>
        </div>
        <div class="display-field">
            <%: Html.DisplayFor(model => model.slider_desc) %>
        </div>

        <div class="display-label">
            <%: Html.DisplayNameFor(model => model.slider_link) %>
        </div>
        <div class="display-field">
            <%: Html.DisplayFor(model => model.slider_link) %>
        </div>

        <div class="display-label">
            <%: Html.DisplayNameFor(model => model.slider_active) %>
        </div>
        <div class="display-field">
            <%: Html.DisplayFor(model => model.slider_active) %>
        </div>

        <div class="display-label">
            <%: Html.DisplayNameFor(model => model.slider_main_img) %>
        </div>
        <div class="display-field">
            <img id="mainImg" src="<%:Url.Content(System.IO.Path.Combine("~/Images/home", Model.slider_main_img)) %>" alt="main image" height="100" />
        </div>

        <div class="display-label">
            <%: Html.DisplayNameFor(model => model.slider_sub_img) %>
        </div>
        <div class="display-field">
            <%string urlContent = string.IsNullOrEmpty(Model.slider_sub_img) ? "#" : Url.Content(System.IO.Path.Combine("~/Images/home", Model.slider_sub_img)); %>
            <img id="subImg" src="<%:urlContent %>" alt="main image" height="100" />
        </div>
    </fieldset>
    <% using (Html.BeginForm("DeleteAdConfirmed", "Admin", new { id = Model.slider_id }, FormMethod.Post))
       { %>
    <%: Html.AntiForgeryToken()%>
    <p>
        <input type="submit" value="Delete" />
        |
        <%: Html.ActionLink("Back to List", "ListOfSlider")%>
    </p>
    <% } %>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="ScriptsSection" runat="server">
</asp:Content>
