<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<IEnumerable<MyStore.App.ViewModels.ShoppingCartViewModel>>" %>

<div class="modal-content">
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="title text-center">Chi tiết đơn hàng</h4>
    </div>
    <div class="modal-body">
        <section id="order_items">
            <div class="table-responsive" id="order_details">
                <table class="table table-condensed order_info">
                    <thead>
                        <tr class="order_menu">
                            <th class="image">
                                <%: Html.DisplayNameFor(model => model.ProductImage) %>
                            </th>
                            <th></th>
                            <th class="price">
                                <%: Html.DisplayNameFor(model => model.Price) %>
                            </th>
                            <th class="quantity">
                                <%: Html.DisplayNameFor(model => model.TotalQuantity) %>
                            </th>
                            <th class="total">
                                <%: Html.DisplayNameFor(model => model.TotalAmount) %>
                            </th>

                            <th></th>
                        </tr>
                    </thead>
                    <tbody>
                        <%if (Model == null || Model.Count() == 0)%>
                        <%{ %>
                        <tr>
                            <td colspan="6" class="text-center">Quý khách chưa có bất kỳ sản phẩm nào trong giỏ hàng
                            </td>
                        </tr>
                        <%} %>
                        <%else%>
                        <%{ %>
                        <%foreach (var item in Model)%>
                        <%{ %>
                        <tr>
                            <td>
                                <a href="<%:Url.Action("Details", "Product", new { id = item.ProductId })%>">
                                    <img src="<%:Url.Content(System.IO.Path.Combine("~/Images/shop", item.ProductImage,"cart.jpg")) %>" alt="">
                                </a>
                            </td>
                            <td>
                                <p>
                                    <a href="<%:Url.Action("Details", "Product", new { id = item.ProductId })%>">
                                        <%:item.ProductDescription %>
                                    </a>
                                    <br />
                                    Mã hàng: <%:item.ProductName %>
                                </p>
                            </td>
                            <td class="price">
                                <p><%:item.Price.ToString("#,###.#") %></p>
                            </td>
                            <td class="quantity">
                                <p><%:item.TotalQuantity %></p>
                            </td>
                            <td class="total">
                                <span><%:item.TotalAmount.ToString("#,###.#") %></span>
                            </td>
                        </tr>
                        <%} %>
                        <tr>
                            <td colspan="2">&nbsp;</td>
                            <td colspan="3">
                                <table class="table table-condensed total-result">
                                    <tr>
                                        <td>Tổng tiền hàng</td>
                                        <td><%:Model.Sum(p=>p.TotalAmount).ToString("#,###.#") %> VND</td>
                                    </tr>
                                    <tr>
                                        <td>Thuế VAT</td>
                                        <td>0 VND</td>
                                    </tr>
                                    <tr class="shipping-cost">
                                        <td>Chi phí vận chuyển</td>
                                        <td>Free</td>
                                    </tr>
                                    <tr>
                                        <td>Tổng cộng</td>
                                        <td><span><%:Model.Sum(p=>p.TotalAmount).ToString("#,###.#") %> VND</span></td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <%} %>
                    </tbody>
                </table>
            </div>
        </section>
    </div>
    <div class="modal-footer">
        <a class="btn btn-default get" data-dismiss="modal">Đóng</a>
    </div>
</div>
