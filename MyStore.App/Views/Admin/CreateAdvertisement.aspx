<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site_Admin.Master" Inherits="System.Web.Mvc.ViewPage<MyStore.App.Models.MyData.Ad_Sliders>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Advertisement
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <h2>Create Advertisement</h2>

    <% using (Html.BeginForm("CreateAd", "Admin", FormMethod.Post))
       { %>
    <%: Html.AntiForgeryToken() %>
    <%: Html.ValidationSummary(true) %>

    <fieldset>
        <legend>New Advertisement</legend>

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

            <%: Html.CheckBoxFor(model => model.slider_active, new { @checked="checked" })%>
            <%: Html.ValidationMessageFor(model => model.slider_active) %>
        </div>

        <div class="editor-label">
            <%: Html.LabelFor(model => model.slider_main_img) %>
        </div>
        <div class="editor-field">
            <%:Html.HiddenFor(model=>model.slider_main_img) %>
            <img id="mainImg" src="#" alt="main image" height="100" />
            <a href="#" class="btn btn-default" id="btnMainImg">Change</a>
            <%: Html.ValidationMessageFor(model => model.slider_main_img) %>
        </div>

        <div class="editor-label">
            <%: Html.LabelFor(model => model.slider_sub_img) %>
        </div>
        <div class="editor-field">
            <%:Html.HiddenFor(model=>model.slider_sub_img) %>
            <img id="subImg" src="#" alt="main image" height="100" />
            <a href="#" class="btn btn-default" id="btnSubImg">Change</a>
        </div>

        <p>
            <input type="submit" value="Create" />
        </p>
    </fieldset>
    <% } %>

    <div>
        <%: Html.ActionLink("Back to List", "ListOfSlider") %>
    </div>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="FeaturedContent" runat="server">
    <!-- Modal -->
    <div id="myModal" class="modal fade" role="dialog" data-url="<%:Url.Action("GetFileListPartial", new { folderName="home" })%>">
        <input type="hidden" id="hdSelectedType" value="" />

        <div id="modalContent" class="modal-dialog">
        </div>
    </div>
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="ScriptsSection" runat="server">
    <%: Styles.Render("~/bundles/bootstapadmin") %>
    <%: Scripts.Render("~/bundles/jqueryval") %>
    <%: Scripts.Render("~/Scripts/bootstrap.js")%>
    <%:Scripts.Render("~/Scripts/edit.advertisement.js") %>
</asp:Content>
