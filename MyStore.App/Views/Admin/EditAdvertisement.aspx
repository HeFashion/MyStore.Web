<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site_Admin.Master" Inherits="System.Web.Mvc.ViewPage<MyStore.App.Models.MyData.Ad_Sliders>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Advertisement
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <h2>Edit Advertisement</h2>

    <% using (Html.BeginForm())
       { %>
    <%: Html.AntiForgeryToken() %>
    <%: Html.ValidationSummary(true) %>

    <fieldset>
        <legend>Ad_Sliders</legend>
        <%: Html.HiddenFor(model => model.slider_id) %>

        <div class="editor-label">
            <%: Html.LabelFor(model => model.slider_title) %>
        </div>
        <div class="editor-field">
            <%: Html.EditorFor(model => model.slider_title) %>
            <%: Html.ValidationMessageFor(model => model.slider_title) %>
        </div>

        <div class="editor-label">
            <%: Html.LabelFor(model => model.slider_desc) %>
        </div>
        <div class="editor-field">
            <%: Html.TextAreaFor(model => model.slider_desc) %>
            <%: Html.ValidationMessageFor(model => model.slider_desc) %>
        </div>

        <div class="editor-label">
            <%: Html.LabelFor(model => model.slider_link) %>
        </div>
        <div class="editor-field">
            <%: Html.EditorFor(model => model.slider_link) %>
            <%: Html.ValidationMessageFor(model => model.slider_link) %>
        </div>

        <div class="editor-label">
            <%: Html.LabelFor(model => model.slider_active) %>
        </div>
        <div class="editor-field">
            <%: Html.EditorFor(model => model.slider_active) %>
            <%: Html.ValidationMessageFor(model => model.slider_active) %>
        </div>

        <div class="editor-label">
            <%: Html.LabelFor(model => model.slider_main_img) %>
        </div>
        <div class="editor-field">
            <%:Html.HiddenFor(model=>model.slider_main_img) %>
            <img id="mainImg" src="<%:Url.Content(System.IO.Path.Combine("~/Images/home", Model.slider_main_img)) %>" alt="main image" height="100" />
            <a href="#" class="btn btn-default" id="btnMainImg">Change</a>

        </div>

        <div class="editor-label">
            <%: Html.LabelFor(model => model.slider_sub_img) %>
        </div>
        <div class="editor-field">
            <%: Html.HiddenFor(model=>model.slider_sub_img) %>
            <% string urlContent = string.IsNullOrEmpty(Model.slider_sub_img) ? "#" : Url.Content(System.IO.Path.Combine("~/Images/home", Model.slider_sub_img)); %>
            <img id="subImg" src="<%:urlContent %>" alt="main image" height="100" />
            <a href="#" class="btn btn-default" id="btnSubImg">Change</a>

            <a href="#" class="btn btn-default" id="btnDelete">Delete</a>
        </div>

        <p>
            <input type="submit" value="Save" />
        </p>
    </fieldset>
    <% } %>

    <div>
        <%: Html.ActionLink("Back to List", "ListOfSlider") %>
    </div>
    <!--/category-tab-->
    <!-- Modal -->
    <div id="myModal" class="modal fade" role="dialog" data-url="<%:Url.Action("GetFileListPartial", new { folderName="home" })%>">
        <input type="hidden" id="hdSelectedType" value="" />

        <div id="modalContent" class="modal-dialog">
        </div>
    </div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="ScriptsSection" runat="server">
    <%: Styles.Render("~/bundles/bootstapadmin") %>

    <%: Scripts.Render("~/Scripts/bootstrap.js")%>
    <%: Scripts.Render("~/Scripts/edit.advertisement.js") %>
</asp:Content>
