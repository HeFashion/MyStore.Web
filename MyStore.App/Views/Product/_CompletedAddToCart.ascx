<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<System.Collections.Generic.IList<MyStore.App.ViewModels.ProductModel>>" %>


<div class="modal-content">
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="title text-center">Đã thêm vào giỏ hàng</h4>
    </div>
    <div class="modal-body">
        <%:Html.Partial("_RecommendItemsPartial",Model) %>
    </div>
    <div class="modal-footer">
        <a class="btn btn-default get" href="<%:Url.Action("Index", "Checkout") %>">
            <i class="fa fa-money"></i>
            Thanh toán
        </a>
        <a class="btn btn-default get" data-dismiss="modal">Tiếp Tục>></a>
    </div>
</div>
