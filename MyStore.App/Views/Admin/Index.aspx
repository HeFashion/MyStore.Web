<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site_Admin.Master" Inherits="System.Web.Mvc.ViewPage<PagedList.IPagedList<MyStore.App.Models.MyData.Product>>" %>

<%@ Import Namespace="PagedList.Mvc" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Index
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <h2>Index</h2>
    <p>
        <%: Html.ActionLink("Create New", 
                            "Create", 
                            null, 
                            new {@id="btnNew" })%>

        <%: Ajax.ActionLink("Import Product Images",
                            "ImportProduct",
                            null,
                            new AjaxOptions
                            {
                                HttpMethod = "Get",
                                InsertionMode = InsertionMode.Replace,
                                UpdateTargetId = "modalContent",
                                OnComplete = "OpenDialog(200,300)"
                            },
                            new { @id="btnImport" })%>

        <%: Ajax.ActionLink("Import Product Excel",
                            "GetImportProductExcel",
                            null,
                            new AjaxOptions
                            {
                                HttpMethod = "Get",
                                InsertionMode = InsertionMode.Replace,
                                UpdateTargetId = "modalContent",
                                OnComplete = "OpenDialog(200,400)"
                            },
                            new { @id="btnImportExcel" })%>

        <%: Ajax.ActionLink("Move Product", 
                            "GetMoveProductPartial",
                            null,
                            new AjaxOptions
                            {
                                HttpMethod = "Get",
                                InsertionMode = InsertionMode.Replace,
                                UpdateTargetId = "modalContent",
                                OnComplete = "OpenDialog(150,380)"
                            },
                            new { @id="btnMove" })%>

        <%: Ajax.ActionLink("Delete All",
                            "DeleteCheckedPartial",
                            null,
                            new AjaxOptions
                            {
                                HttpMethod = "Get",
                                InsertionMode = InsertionMode.Replace,
                                UpdateTargetId = "modalContent",
                                OnComplete = "OpenDialog(150,380)"
                            },
                            new { @id="btnDeleteAll" })%>
    </p>

    <%using (Html.BeginForm("Index", "Admin", FormMethod.Get))
      { %>
    <p>
        <input type="hidden" name="sortOrder" value="<%:ViewBag.SortOrder %>" />
        Find by name: <%:Html.TextBox("searchString")%>

        <input type="submit" value="Search" />
    </p>
    <%} %>
    <%:Html.PagedListPager(Model, 
                           page=>Url.Action("Index",
                                            new {sortOrder = ViewBag.SortOrder,
                                                 searchString = ViewBag.SearchString,
                                                 page})) %>
    <table class="product-table">
        <tr>
            <th colspan="10">
                <label>
                    <%: Html.CheckBox("IsSelectedAll")%>
                    Check/Uncheck All
                </label>
            </th>
        </tr>

        <tr>
            <th></th>
            <th></th>
            <th>ID</th>

            <th>
                <%:Html.ActionLink("Type","Index", new { sortOrder= "Type", searchString=ViewBag.SearchString })%>
            </th>
            <th>
                <%:Html.ActionLink("Name","Index", new { sortOrder= "Name", searchString=ViewBag.SearchString })%>
            </th>
            <th>
                <%: Html.DisplayName("UOM") %>
            </th>
            <th>
                <%: Html.DisplayName("Price") %>
            </th>
            <th>
                <%: Html.DisplayName("Desc") %>
            </th>
            <th>
                <%: Html.DisplayName("Long Desc") %>
            </th>

            <th></th>
        </tr>

        <% foreach (var item in Model)
           { %>
        <tr>
            <td>
                <%: Html.CheckBox("IsSelected", new {@value=item.product_id}) %>
            </td>
            <td>
                <a href="<%: Url.Action("Edit", "Admin", new {returnUrl=HttpContext.Current.Request.RawUrl , id=item.product_id }) %>">
                    <img src="<%:Url.Content(System.IO.Path.Combine("~/Images/shop",item.product_image,"cart.jpg")) %>" alt="<%:item.product_name %>" />
                </a>
            </td>
            <td><%: Html.DisplayFor(modelItem => item.product_id)%></td>
            <td>
                <%: Html.DisplayFor(modelItem => item.Ref_Product_Type.product_type_title_vn) %>
            </td>
            <td>
                <%: Html.DisplayFor(modelItem => item.product_name) %>
            </td>
            <%using (Ajax.BeginForm("QuickEditProduct", "Admin", new AjaxOptions
              {
                  HttpMethod = "Post",
                  InsertionMode = InsertionMode.Replace,
                  UpdateTargetId = string.Format("status{0}", item.product_id)
              }))
              {  %>
            <%: Html.AntiForgeryToken()%>
            <%:Html.HiddenFor(model => item.product_id)%>
            <td>
                <%: Html.DropDownListFor(modelItem => item.product_uom_id, new SelectList(ViewBag.UOMSelectList, "Id", "Description", item.product_uom_id))%>
            </td>

            <td>
                <%:Html.TextBoxFor(modelItem => item.product_price, new { @class = "price" , Value=MyStore.App.Utilities.DecimalHelper.ToString(item.product_price, "#,###.#")})%>
            </td>
            <td>
                <%: Html.TextBoxFor(modelItem => item.product_description, new { @class = "description" })%>
            </td>
            <td>
                <%: Html.TextAreaFor(modelItem => item.other_detail)%>
            </td>
            <td>
                <label id="<%:string.Format("status{0}", item.product_id) %>"></label>
                <input type="submit" value="Save" />
            </td>
            <%}%>

            <%--  
              <td>
                <%: Html.ActionLink("Delete", 
                                    "Delete", 
                                    new {returnUrl=HttpContext.Current.Request.RawUrl , id=item.product_id}) %>
            </td>
            --%>
        </tr>
        <% } %>
    </table>

    <%-- Modal popup for details --%>
    <div id="myModal" class="modal fade" role="dialog">
        <div id="modalContent" class="modal-dialog">
        </div>
    </div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="ScriptsSection" runat="server">

    <script type="text/javascript">
        $(document).ready(function () {
            $("#btnNew").button();
            $("#btnImport").button();
            $("#btnImportExcel").button();
            $("#btnMove").button();
            $("#btnDeleteAll").button();
            $("#IsSelectedAll").change(function () {
                $("input:checkbox").prop('checked', $(this).prop("checked"));
            });
            $("input.price").keyup(function (event) {

                // skip for arrow keys
                if (event.which >= 37 && event.which <= 40) return;

                // format number
                $(this).val(function (index, value) {
                    return value.replace(/\D/g, "")
                                .replace(/\B(?=(\d{3})+(?!\d))/g, ",");
                });
            });

            tinymce.init({
                selector: 'textarea',  // change this value according to your HTML
            });

        });
    </script>
</asp:Content>
