<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<System.Collections.Generic.IList<MyStore.App.ViewModels.ProductModel>>" %>

<!--recommended_items-->
<div class="recommended_items">
    <h2 class="title text-center"><%:ViewBag.RecommendTitle %></h2>

    <div id="recommended-item-carousel" class="carousel slide" data-ride="carousel">
        <%if (Model != null)
          { %>
        <div class="carousel-inner">
            <div class="item active">
                <%foreach (MyStore.App.ViewModels.ProductModel recommendItem in Model.Take(4))%>
                <%{ %>
                <div class="col-sm-3">
                    <div class="product-image-wrapper">
                        <div class="single-products">
                            <div class="productinfo text-center">
                                <a href="<%:Url.Action("Details", "Product", new { id=recommendItem.Id })%>">
                                    <img src="<%:Url.Content(System.IO.Path.Combine("~/Images/shop",recommendItem.Image, "recommend.jpg")) %>" alt="" />
                                </a>
                                <h2><%:MyStore.App.Utilities.DecimalHelper.ToString(recommendItem.Price, "#,###.#") %></h2>
                                <p><%:recommendItem.Description %></p>
                                <button class="btn add-to-cart" value="<%:recommendItem.Id %>">
                                    <i class="fa fa-shopping-cart"></i>+1 giỏ hàng
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
                <%} %>
            </div>
            <%for (int i = 3; i < Model.Count; i += 4)%>
            <%{ %>
            <div class="item">
                <%var takeList = Model.Skip(i).Take(4); %>
                <%foreach (MyStore.App.ViewModels.ProductModel recommendItem in takeList)%>
                <%{%>
                <div class="col-sm-3">
                    <div class="product-image-wrapper">
                        <div class="single-products">
                            <div class="productinfo text-center">
                                <a href="<%:Url.Action("Details", "Product", new { id=recommendItem.Id })%>">
                                    <img src="<%:Url.Content(System.IO.Path.Combine("~/Images/shop",recommendItem.Image, "recommend.jpg")) %>" alt="" />
                                </a>
                                <h2><%: MyStore.App.Utilities.DecimalHelper.ToString(recommendItem.Price, "#,###.#")%></h2>
                                <p><%: recommendItem.Description %></p>
                                <button type="button" class="btn btn-default add-to-cart"><i class="fa fa-shopping-cart"></i>+1 giỏ hàng</button>
                            </div>
                        </div>
                    </div>
                </div>
                <%}%>
            </div>
            <%} %>
        </div>
        <%} %>
        <a class="left recommended-item-control" href="#recommended-item-carousel" data-slide="prev">
            <i class="fa fa-angle-left"></i>
        </a>
        <a class="right recommended-item-control" href="#recommended-item-carousel" data-slide="next">
            <i class="fa fa-angle-right"></i>
        </a>
    </div>
</div>
<!--/recommended_items-->
