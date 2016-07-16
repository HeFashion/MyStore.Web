<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site_Admin.Master" Inherits="System.Web.Mvc.ViewPage<IEnumerable<MyStore.App.ViewModels.OrderViewModel>>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Index - Orders
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <h2>List of Orders</h2>
    <%:Html.ValidationSummary() %>
    <div id="tabs">
        <%var orderStatus = ViewData["OrderStatus"] as List<string>; %>

        <ul>
            <%foreach (string status in orderStatus)
              { %>
            <li><a href="<%:string.Format("#tb{0}", status) %>"><%:string.Format("{0}({1})", status, Model.Count(p=>p.Status==status)) %></a></li>

            <%} %>
        </ul>
        <%foreach (string status in orderStatus)
          {%>
        <div id="<%:string.Format("tb{0}", status) %>">
            <table>
                <tr>
                    <th></th>
                    <th>
                        <%: Html.DisplayNameFor(model => model.OrderNumber) %>
                    </th>
                    <th>
                        <%: Html.DisplayNameFor(model => model.DateCreated) %>
                    </th>
                    <th>
                        <%: Html.DisplayNameFor(model => model.Address) %>
                    </th>
                    <%if (status == "Shipping")
                      { %>
                    <th>
                        <%: Html.DisplayNameFor(model => model.ShippingCode) %>
                    </th>
                    <th>
                        <%: Html.DisplayNameFor(model => model.ShippingDate) %>
                    </th>
                    <%} %>
                    <%else
                      {%>
                    <th>
                        <%: Html.DisplayNameFor(model => model.PhoneNumber) %>
                    </th>
                    <th>
                        <%: Html.DisplayNameFor(model => model.ReceiverName) %>
                    </th>
                    <%} %>
                    <th></th>
                </tr>
                <%var groupModel = from q in Model
                                   where q.Status == status
                                   select q; %>
                <% foreach (var item in groupModel)
                   { %>
                <tr>
                    <td>
                        <%: Html.CheckBox("IsSelected", new {@value=item.OrderNumber}) %>
                    </td>
                    <td>
                        <%: Html.DisplayFor(modelItem => item.OrderNumber) %>
                    </td>
                    <td>
                        <%: Html.DisplayFor(modelItem => item.DateCreated) %>
                    </td>
                    <td>
                        <%: Html.DisplayFor(modelItem => item.Address) %>
                    </td>
                    <%if (status == "Shipping")
                      { %>
                    <td>
                        <%: Html.DisplayFor(modelItem => item.ShippingCode) %>
                    </td>
                    <td>
                        <%: Html.DisplayFor(modelItem => item.ShippingDate) %>
                    </td>
                    <%} %>
                    <%else
                      { %>
                    <td>
                        <%: Html.DisplayFor(modelItem => item.PhoneNumber) %>
                    </td>
                    <td>
                        <%: Html.DisplayFor(modelItem => item.ReceiverName) %>
                    </td>
                    <%} %>
                    <td>
                        <%: Ajax.ActionLink("Chi Tiết", 
                                            "Details",
                                            "Admin",
                                            new { id=item.OrderNumber }, 
                                            new AjaxOptions{HttpMethod="Get", 
                                                InsertionMode=InsertionMode.Replace, 
                                                UpdateTargetId="modalContent", 
                                                OnComplete="OpenDialog(400,800)"}) %>
                    </td>
                </tr>
                <% } %>
            </table>

        </div>
        <%} %>
        <p>
            <a href="#" id="btnShip">Ship To</a>
            <a href="#" id="btnDone">Completed</a>
            <a href="#" id="btnCancel">Cancel</a>
        </p>
    </div>

    <%-- Modal popup for details --%>
    <div id="myModal" class="modal fade" role="dialog">
        <div id="modalContent" class="modal-dialog">
        </div>
    </div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="ScriptsSection" runat="server">
    <%: Styles.Render("~/Content/themes/base/css") %>
    <%: Scripts.Render("~/bundles/jqueryui") %>
    <%: Scripts.Render("~/bundles/jqueryval") %>
    <%: Scripts.Render("~/Scripts/main.admin.js") %>
    <%: Scripts.Render("~/Scripts/numericInput.js") %>

    <script type="text/javascript">

        $(document).ready(function () {
            var btnShip = $("#btnShip").button();
            var btnDone = $("#btnDone").button();
            var btnCancel = $("#btnCancel").button();

            $("#tabs").tabs({
                select: function (e, ui) {
                    var selected = $(ui.tab).attr("href");
                    if (selected == "#tbNew")
                        btnShip.show();
                    else
                        btnShip.hide();

                    if (selected == "#tbDone" ||
                        selected == "#tbCancel") {
                        btnDone.hide();
                        btnCancel.hide();
                    }
                    else {
                        btnDone.show();
                        btnCancel.show();
                    }
                }
            });

            btnShip.click(function (e) {
                e.preventDefault();
                var selectedList = GetCheckedList();
                if (selectedList != null &&
                    selectedList.length > 0) {
                    var postData = { selectedOrder: selectedList };
                    $.ajax({
                        type: "POST",
                        url: "<%:Url.Action("ShipOrders", "Admin")%>",
                        data: postData,
                        datatype: "json",
                        traditional: true,
                        content: "application/json; charset=utf-8",
                        success: function (data) {
                            $("#modalContent").html(data);
                            OpenDialog(400, 800);
                        }
                    });
                }

            });

            btnDone.click(function (e) {
                e.preventDefault();
                var selectedList = GetCheckedList();
                if (selectedList != null &&
                    selectedList.length != 0) {
                    var msgResult = confirm("You will mark all of selected is Done. Are you sure?");
                    if (msgResult) {
                        var postData = { selectedOrder: selectedList };
                        $.ajax({
                            type: "POST",
                            url: "<%:Url.Action("ChangeOrderToComplete")%>",
                            data: postData,
                            datatype: "json",
                            traditional: true,
                            success: function (data) {
                                location.reload(true);
                            }
                        });
                    }
                }
            });

            btnCancel.click(function (e) {
                e.preventDefault();
                var selectedList = GetCheckedList();
                if (selectedList != null &&
                    selectedList.length != 0) {
                    var msgResult = confirm("You will mark all of selected is Cancle. Are you sure?");
                    if (msgResult) {
                        var postData = { selectedOrder: selectedList };
                        $.ajax({
                            type: "POST",
                            url: "<%:Url.Action("ChangeOrderToCancel")%>",
                            data: postData,
                            datatype: "json",
                            traditional: true,
                            success: function (data) {
                                location.reload(true);
                            }
                        });
                    }
                }
            });
        });
    </script>
</asp:Content>
