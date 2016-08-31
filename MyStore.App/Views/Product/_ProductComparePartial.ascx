<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<System.Collections.Generic.IList<MyStore.App.ViewModels.ProductModel>>" %>

<div class="modal-content">
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h2 class="title text-center">Danh sách so sánh</h2>
    </div>
    <div class="modal-body">
        <h4 class="title text-center"><%:ViewBag.CompareListTitle %></h4>

        <div id="compare-product-selected" class="carousel slide" data-ride="carousel">

            <!-- Wrapper for slides -->
            <%if (Model != null && Model.Count > 0)
              { %>
            <div class="carousel-inner">
                <%int activeSize = 4; %>
                <div class="item active">
                    <%foreach (MyStore.App.ViewModels.ProductModel recommendItem in Model.Take(activeSize))%>
                    <%{ %>
                    <div class="col-sm-3">
                        <div class="product-image-wrapper">
                            <div class="single-products">
                                <div class="productinfo text-center">
                                    <% var actionLink = Ajax.ActionLink("ListCompare",
                                       "RemoveFromCompareProduct",
                                       "Product",
                                       new { productId = recommendItem.Id },
                                       new AjaxOptions
                                       {
                                           HttpMethod = "Get",
                                           InsertionMode = InsertionMode.Replace,
                                           UpdateTargetId = "modalContent",
                                           OnComplete = "ShowModal()"
                                       },
                                       new { @class = "btn remove-from-compare" });%>
                                    <%:Html.Raw(actionLink.ToString().Replace("ListCompare","<i class='fa fa fa-times'></i>Hủy bỏ")) %>

                                    <a href="<%:Url.Action("Details", "Product", new { id=recommendItem.GenerateSlug() })%>">
                                        <img src="<%:Url.Content(System.IO.Path.Combine("~/Images/shop",recommendItem.Image, "cart.jpg")) %>" alt="<%:recommendItem.Name %>" />
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>

                    <%} %>
                </div>
                <%for (int i = activeSize; i < Model.Count; i += activeSize)%>
                <%{ %>
                <div class="item">
                    <%var takeList = Model.Skip(i)
                                          .Take(activeSize); %>
                    <%foreach (MyStore.App.ViewModels.ProductModel recommendItem in takeList)%>
                    <%{%>
                    <div class="col-sm-3">
                        <div class="product-image-wrapper">
                            <div class="single-products">
                                <div class="productinfo text-center">
                                    <% var actionLink = Ajax.ActionLink("ListCompare",
                                       "RemoveFromCompareProduct",
                                       "Product",
                                       new { productId = recommendItem.Id },
                                       new AjaxOptions
                                       {
                                           HttpMethod = "Get",
                                           InsertionMode = InsertionMode.Replace,
                                           UpdateTargetId = "modalContent",
                                           OnComplete = "ShowModal()"
                                       },
                                       new { @class = "btn remove-from-compare" });%>
                                    <%:Html.Raw(actionLink.ToString().Replace("ListCompare","<i class='fa fa fa-times'></i>Hủy bỏ")) %>

                                    <a href="<%:Url.Action("Details", "Product", new { id=recommendItem.GenerateSlug() })%>">
                                        <img src="<%:Url.Content(System.IO.Path.Combine("~/Images/shop",recommendItem.Image, "cart.jpg")) %>" alt="<%:recommendItem.Name %>" />
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>

                    <%} %>
                </div>
                <%} %>
            </div>

            <!-- Controls -->
            <a class="left item-control" href="#compare-product-selected" data-slide="prev">
                <i class="fa fa-angle-left"></i>
            </a>
            <a class="right item-control" href="#compare-product-selected" data-slide="next">
                <i class="fa fa-angle-right"></i>
            </a>
            <%} %>
        </div>
    </div>
    <div class="modal-footer">
        <%if (Model != null && Model.Count >= 2)
          { %>
        <a class="btn btn-default get"
            href="<%:Url.Action("Compare", "Product") %>">Bắt đầu so sánh
        </a>
        <%} %>
        <a class="btn btn-default get" data-dismiss="modal">Tiếp Tục>></a>
    </div>
</div>
