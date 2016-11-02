<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<System.Collections.Generic.IList<MyStore.App.ViewModels.ProductModel>>" %>


<div class="modal-content">
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h2 class="title text-center">Đã thêm vào giỏ hàng</h2>
    </div>
    <div class="modal-body">
        <h4 class="title text-center"><%:ViewBag.RecommendTitle %></h4>

        <div id="similar-product" class="carousel slide" data-ride="carousel">

            <!-- Wrapper for slides -->
            <div class="carousel-inner">

                <div class="item active">
                    <%foreach (MyStore.App.ViewModels.ProductModel recommendItem in Model.Take(4))%>
                    <%{ %>

                    <a href="<%:Url.Action("Details", "Product", new { id=recommendItem.GenerateSlug() })%>">
                        <img src="<%:Url.Content(System.IO.Path.Combine("~/Images/shop",recommendItem.Image, "cart.jpg")) %>" alt="<%:recommendItem.Name %>" />
                    </a>

                    <%} %>
                </div>
                <%for (int i = 4; i < Model.Count; i += 4)%>
                <%{ %>
                <div class="item">
                    <%var takeList = Model.Skip(i).Take(4); %>
                    <%foreach (MyStore.App.ViewModels.ProductModel recommendItem in takeList)%>
                    <%{%>
                    <a href="<%:Url.Action("Details", "Product", new { id=recommendItem.GenerateSlug() })%>">
                        <img src="<%:Url.Content(System.IO.Path.Combine("~/Images/shop",recommendItem.Image, "cart.jpg")) %>" alt="<%:recommendItem.Name %>" />
                    </a>
                    <%} %>
                </div>
                <%} %>
            </div>

            <!-- Controls -->
            <a class="left item-control" href="#similar-product" data-slide="prev">
                <i class="fa fa-angle-left"></i>
            </a>
            <a class="right item-control" href="#similar-product" data-slide="next">
                <i class="fa fa-angle-right"></i>
            </a>
        </div>
    </div>
    <div class="modal-footer">
        <a class="btn btn-primary" href="<%:Url.Action("Index", "Cart", new {returnUrl=ViewBag.ReturnUrl })%>">
            <i class="fa fa-shopping-cart"></i>
            Giỏ hàng
        </a>
        <%--<a class="btn btn-default get" href="<%:Url.Action("Index", "Checkout") %>">
            <i class="fa fa-money"></i>
            Thanh toán
        </a>--%>
        <a class="btn btn-primary" data-dismiss="modal">Tiếp Tục>></a>
    </div>
</div>
