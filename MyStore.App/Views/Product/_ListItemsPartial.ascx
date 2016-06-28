<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<IEnumerable<MyStore.App.ViewModels.ProductModel>>" %>
<% foreach (var item in Model)%>
<%{%>
<div class="col-sm-3">
    <div class="product-image-wrapper">
        <div class="single-products">
            <div class="productinfo text-center">
                <img src="<%: Url.Content(System.IO.Path.Combine("~/Images/shop", item.Image,"index.jpg")) %>" alt="" />
                <h2><%: MyStore.App.Utilities.DecimalHelper.ToString(item.Price, "#,###.#")  %> <sup>đ</sup></h2>
                <%--<p><%: item.Description %></p>--%>
            </div>
            <div class="product-overlay">
                <div class="overlay-content">
                    <h2><%: MyStore.App.Utilities.DecimalHelper.ToString(item.Price, "#,###.#") %> <sup>đ</sup></h2>
                    <p><%: item.Description %></p>
                    <a href="<%:Url.Action("Details", "Product", new {id = item.Id })%>" class="btn view-details">
                        <i class="fa fa-external-link"></i>
                        Chi tiết
                    </a>
                    <button value="<%: item.Id %>" class="btn add-to-cart">
                        <i class="fa fa-shopping-cart"></i>+1 giỏ hàng
                    </button>
                </div>
            </div>
            <%int dateDiff = Convert.ToInt32((DateTime.Now - item.DateCreated).TotalDays); %>
            <%if (dateDiff <= ViewBag.DateCompare)%>
            <%{%>
            <img src="<%:Url.Content("~/Images/home/new.png") %>" class="new" alt="" />
            <%} %>
        </div>
        <div class="choose">
            <ul class="nav nav-pills nav-justified">
                <li>
                    <% var actionLink = Ajax.ActionLink("ListCompare",
                                       "AddToCompareProduct",
                                       "Product",
                                       new { productId = item.Id },
                                       new AjaxOptions
                                       {
                                           HttpMethod = "Get",
                                           InsertionMode = InsertionMode.Replace,
                                           UpdateTargetId = "modalContent",
                                           OnComplete = "ShowModal()"
                                       });%>
                    <%:Html.Raw(actionLink.ToString().Replace("ListCompare","<i class='fa fa-plus-square'></i>Danh sách so sánh")) %>
                </li>
            </ul>
        </div>

    </div>
</div>
<%} %>
<%if (Convert.ToBoolean(ViewData["IsEnded"]))
  {%>
<script type="text/javascript">
    isEnded = true;
</script>
<%}%>
