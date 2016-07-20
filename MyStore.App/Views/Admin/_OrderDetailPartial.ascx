<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<IList<MyStore.App.ViewModels.OrderDetailViewModel>>" %>

<%using (Html.BeginForm("UpdateDetails", "Admin", FormMethod.Post))
  {%>
<%:Html.AntiForgeryToken() %>
<table class="table table-condensed" id="cartResult">
    <thead>
        <tr class="cart-header">
            <td class="image">Sản phẩm</td>
            <td class="description">Mã</td>
            <td class="price">Giá</td>
            <td class="measure">ĐV</td>
            <td>SL</td>
            <td>Tiền dự bán</td>
            <td>Tiền bán</td>
            <td>Xóa</td>
        </tr>
    </thead>

    <tbody>
        <%if (Model == null || Model.Count() <= 0)%>
        <%{ %>
        <tr>
            <td colspan="6" class="text-center">Không có sản phẩm nào trong đơn hàng
            </td>
        </tr>
        <%} %>
        <%else%>
        <%{ %>
        <%for (int i = 0; i < Model.Count; i++)
          { %>
        <tr>
            <%:Html.HiddenFor(model=>Model[i].ItemId) %>

            <td class="cart-image">
                <a href="<%:Url.Action("Details", "Product", new { id = Model[i].ItemProductId })%>">
                    <img src="<%:Url.Content(System.IO.Path.Combine("~/Images/shop", Model[i].ItemImage, "cart.jpg"))%>" alt="">
                </a>
            </td>
            <td class="cart-description">
                <p><%:Model[i].ItemCode%></p>
            </td>
            <td class="cart-price">
                <p><%:Model[i].ItemPrice.ToString("#,###.#")%></p>
            </td>
            <td class="cart-price">
                <p><%:Model[i].ItemUnit%></p>
            </td>


            <td>
                <%:Html.TextBoxFor(modelItem => Model[i].ItemQuantity,
                                  new
                                  {
                                      @size = "2",
                                      @style = "width: 30px"
                                  })%>
            </td>
            <td>
                <%: ((decimal)Model[i].ItemQuantity * Model[i].ItemPrice).ToString("#,###.#")%>
            </td>
            <td class="cart-total-price">
                <%:Html.TextBoxFor(modelItem => Model[i].ItemTotalAmt,
                                  new
                                  {
                                      @size = "2",
                                      @style = "width: 100px"
                                  })%>
            </td>
            <td><%:Html.CheckBoxFor(model => Model[i].IsDelete)%></td>
        </tr>
        <%} %>
        <tr>
            <td>
                <input type="submit" value="Save" />
            </td>
        </tr>
        <%} %>
    </tbody>
</table>
<%} %>
<script>
    $("input[type='text']").numericInput({ allowFloat: true });
    $("input[type='text']").keyup(function (event) {
        if (event.which >= 37 && event.which <= 40) return;
        $(this).val(function (index, value) {
            return value
            .replace(/[^0-9\.]+/g, "")
            .replace(/\B(?=(\d{3})+(?!\d))/g, ",")
            ;
        });
    });
    $("form").submit(function () {
        $("input[type='text']").each(function (index) {
            var quantity = $(this).val().replace(',', '');
            $(this).val(quantity);
        });
    });
</script>

