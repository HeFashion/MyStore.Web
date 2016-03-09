<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<IEnumerable<MyStore.App.ViewModels.ProductModel>>" %>

<!--features_items-->

<div class="features_items">
    <h2 class="title text-center"><%:ViewBag.ListTitle %></h2>
    <% foreach (var item in Model)%>
    <%{%>
    <div class="col-sm-4">
        <div class="product-image-wrapper">
            <div class="single-products">
                <div class="productinfo text-center">
                    <img src="<%: Url.Content(System.IO.Path.Combine("~/Images/shop/product", item.Image)) %>" alt="" />
                    <h2><%: MyStore.App.Utilities.DecimalHelper.ToString(item.Price, "#,###.#")  %></h2>
                    <p><%: item.Description %></p>
                </div>
                <div class="product-overlay">
                    <div class="overlay-content">
                        <h2><%: MyStore.App.Utilities.DecimalHelper.ToString(item.Price, "#,###.#") %></h2>
                        <p><%: item.Description %></p>
                        <a href="<%:Url.Action("Details", "Product", new {id = item.Id })%>" class="btn view-details">
                            <i class="fa fa-external-link"></i>
                            Chi tiết
                        </a>
                        <a id="<%: item.Id %>" href="#" class="btn add-to-cart">
                            <i class="fa fa-shopping-cart"></i>Thêm vào giỏ hàng
                        </a>
                    </div>
                </div>
                <%int dateDiff = Convert.ToInt32((DateTime.Now - item.DateCreated).TotalDays); %>
                <%-- <%dateDiff = Math.Abs(dateDiff); %>--%>
                <%if (dateDiff <= ViewBag.DateCompare)%>
                <%{%>
                <img src="<%:Url.Content("~/Images/home/new.png") %>" class="new" alt="" />
                <%} %>
            </div>
            <%-- <div class="choose">
                <ul class="nav nav-pills nav-justified">

                    <li>
                        <%if (User.IsInRole("Admin"))%>
                        <%{ %>
                        <a href="<%:Url.Action("Delete", "Product", new { id=item.Id })%>">
                            <i class="fa fa-plus-square"></i>
                            Delete
                        </a>
                        <%} %>
                            
                    </li>
                </ul>
            </div>--%>
        </div>
    </div>
    <%} %>
</div>
<!--features_items-->
