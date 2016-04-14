<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site_Admin.Master" Inherits="System.Web.Mvc.ViewPage<IEnumerable<MyStore.App.Models.MyData.Ad_Sliders>>" %>

<asp:Content ID="titleContent" ContentPlaceHolderID="TitleContent" runat="server">
    Advertisement
</asp:Content>

<asp:Content ID="mainContent" ContentPlaceHolderID="MainContent" runat="server">

    <h2>Advertisement List</h2>

    <p>
        <%: Html.ActionLink("Create New", "CreateAd") %>
    </p>
    <div class="filter-form">
        <label>
            Filter by:
        </label>

        <%using (Html.BeginForm("ListOfSlider", "Admin", FormMethod.Get, new { @id = "frmFilter" }))
          { %>
        <label>
            <%:Html.RadioButton("isActive", true, ViewData["IsActive"])%>
                Active
        </label>
        <label>
            <%:Html.RadioButton("isActive", false, !Convert.ToBoolean(ViewData["IsActive"]))%>
                Unactive
        </label>
        <%} %>
    </div>
    <div class="filte-table">
        <%if (Model.Count() > 0)
          { %>
        <table>
            <tr>
                <th>
                    <%: Html.DisplayName("Title") %>
                </th>
                <th>
                    <%: Html.DisplayName("Description") %>
                </th>
                <th>
                    <%: Html.DisplayName("Link") %>
                </th>

                <th></th>
            </tr>

            <% foreach (var item in Model)
               { %>
            <tr>

                <td>
                    <%: Html.DisplayFor(modelItem => item.slider_title) %>
                </td>
                <td>
                    <%: Html.DisplayFor(modelItem => item.slider_desc) %>
                </td>
                <td>
                    <%: Html.DisplayFor(modelItem => item.slider_link) %>
                </td>

                <td>
                    <%: Html.ActionLink("Edit", "EditSlider", new { id=item.slider_id }) %> |
                    <%: Html.ActionLink("Delete", "DeleteAd", new { id=item.slider_id }) %> | 
                </td>
            </tr>

            <% } %>
        </table>
        <%} %>
    </div>


</asp:Content>

<asp:Content ID="featureContent" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>

<asp:Content ID="scriptContent" ContentPlaceHolderID="ScriptsSection" runat="server">
    <%:Scripts.Render("~/bundles/jqueryui") %>
    <%--  <%:Scripts.Render("~/Scripts/jquery.unobtrusive-ajax.min.js") %>
    <%:Scripts.Render("~/Scripts/bootstrap.js") %>
    <%:Styles.Render("~/bundles/bootstapadmin") %>--%>
    <script type="text/javascript">
        $(document).ready(function () {
            $(':radio[name="isActive"]').change(function () {
                $('#frmFilter').submit();
            });
        });

    </script>
</asp:Content>
