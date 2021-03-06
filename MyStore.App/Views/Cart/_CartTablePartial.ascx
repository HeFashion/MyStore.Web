﻿<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<IEnumerable<MyStore.App.ViewModels.ShoppingCartViewModel>>" %>

<table class="table table-condensed" id="cartResult">
    <thead>
        <tr class="cart-header">
            <td class="image">Sản phẩm</td>
            <td class="description"></td>
            <td class="price">Giá</td>
            <td class="measure">Đơn Vị</td>
            <td>Số lượng</td>
            <td>Tổng tiền</td>
            <td></td>
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

            <td class="cart-image">
                <a href="<%:Url.Action("Details", "Product", new { id = item.ProductId })%>">
                    <img src="<%:Url.Content(System.IO.Path.Combine("~/Images/shop", item.ProductImage,"cart.jpg")) %>" alt="">
                </a>
            </td>
            <td class="cart-description">
                <h4><a href="<%:Url.Action("Details", "Product", new {id=item.ProductId}) %>"><%:item.ProductDescription %></a></h4>
                <p>Mã hàng: <%:item.ProductName %></p>
            </td>
            <td class="cart-price">
                <p><%:item.Price.ToString("#,###.#")%></p>
            </td>
            <td class="cart-price">
                <p><%:item.UOM%></p>
            </td>
            <td class="cart-quantity">
                <div class="cart_quantity_button">
                    <input class="cart_quantity_input"
                        type="text"
                        id="<%:item.ProductId %>"
                        name="quantity"
                        value="<%:item.TotalQuantity %>"
                        size="2">
                </div>
            </td>
            <td class="cart-total-price">
                <p><%:item.TotalAmount.ToString("#,###.#") %></p>
            </td>
            <td class="cart-delete">
                <a title="Xóa khỏi giỏ" href="<%:Url.Action("Remove", "Cart", new { prodId=item.ProductId })%>">
                    <i class="fa fa-times"></i>
                </a>
            </td>
        </tr>
        <%} %>
        <tr>
            <td colspan="4">&nbsp;</td>
            <td colspan="2">
                <table class="table table-condensed total-result">
                    <tr>
                        <td>Tổng cộng tiền hàng</td>
                        <td><%:Model.Sum(p=>p.TotalAmount).ToString("#,###.#") %> VND</td>
                    </tr>
                    <tr>
                        <td>Thuế VAT</td>
                        <td>0 VND</td>
                    </tr>
                    <tr class="shipping-cost">
                        <td>Chi phí vận chuyển</td>
                        <td>Thỏa thuận</td>
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
