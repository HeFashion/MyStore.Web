<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/SubSite.master" Inherits="System.Web.Mvc.ViewPage<IEnumerable<MyStore.App.ViewModels.OrderViewModel>>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Đơn Hàng - Danh Sách
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <section id="order_items">
        <div class="container">
            <h2 class="title text-center">Đơn Hàng Của Quý Khách</h2>
            <div class="table-responsive" id="orderResult">
                <table class="table table-bordered order_info">
                    <thead>
                        <tr class="order_menu">
                            <th class="order_code">
                                <%: Html.DisplayNameFor(model => model.OrderNumber) %>
                            </th>
                            <th>
                                <%: Html.DisplayNameFor(model => model.DateCreated) %>
                            </th>
                            <th>
                                <%: Html.DisplayNameFor(model => model.Address) %>
                            </th>
                            <th>
                                <%: Html.DisplayNameFor(model => model.ShippingCode) %>
                            </th>
                            <th>
                                <%: Html.DisplayNameFor(model => model.ShippingDate) %>
                            </th>
                            <th>
                                <%: Html.DisplayNameFor(model => model.Status) %>
                            </th>

                            <th></th>
                        </tr>
                    </thead>
                    <tbody>
                        <% foreach (var item in Model)
                           { %>
                        <tr>
                            <td class="order_code">
                                <%: Html.DisplayFor(modelItem => item.OrderNumber) %>
                            </td>
                            <td>
                                <%: Html.DisplayFor(modelItem => item.DateCreated) %>
                            </td>
                            <td>
                                <%: Html.DisplayFor(modelItem => item.Address) %>
                            </td>
                            <td>
                                <%: Html.DisplayFor(modelItem => item.ShippingCode) %>
                            </td>
                            <td>
                                <%: Html.DisplayFor(modelItem => item.ShippingDate) %>
                            </td>
                            <td>
                                <%switch (item.StatusId)%>
                                <%{ %>
                                <%case MyStore.App.Models.MyData.OrderStatus.New: %>
                                <p class="order_new">
                                    <%break;%>
                                    <%case MyStore.App.Models.MyData.OrderStatus.Shipping: %>
                                <p class="order_shipping">
                                    <%break;%>
                                    <%case MyStore.App.Models.MyData.OrderStatus.Cancel: %>
                                <p class="order_cancel">
                                    <%break;%>
                                    <%case MyStore.App.Models.MyData.OrderStatus.Done: %>
                                <p class="order_done">
                                    <%break;%>
                                    <%default:%>
                                <p class="order_new">
                                    <%break;%>
                                    <%} %>
                                    <%: Html.DisplayFor(modelItem => item.Status) %>
                                </p>
                            </td>

                            <td>
                                <%: Ajax.ActionLink("Chi Tiết", 
                                                    "Details",
                                                    new { id=item.OrderNumber }, 
                                                    new AjaxOptions{HttpMethod="Get", 
                                                        InsertionMode=InsertionMode.Replace, 
                                                        UpdateTargetId="modalContent", 
                                                        OnComplete="ShowModal()"}) %>
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>
    </section>
  
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="ScriptsSection" runat="server">
    <%: Scripts.Render("~/bundles/jqueryui") %>
</asp:Content>
