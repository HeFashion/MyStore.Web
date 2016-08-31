<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<MyStore.App.ViewModels.ProductModel>" %>

<div class="product-image-wrapper">
    <div class="view-product">
        <a href="<%:Url.Action("Details", "Product", new { id = Model.GenerateSlug() })%>" target="_blank">
            <img src="<%: Url.Content(System.IO.Path.Combine("~/Images/shop", Model.Image,"detail.jpg")) %>"
                alt="<%:Model.Image %>" />
        </a>
    </div>
    <div class="product-compare">
        <span class="compare-details">
            <%:Html.Action("BlogVotePartial", "Blog", new {totalScore=Model.Total_Score, totalVoted=Model.Total_Voted})%>
            <br />
            <%:Model.Description %>
            <br />
            <span class="compare-price">
                <%:MyStore.App.Utilities.DecimalHelper.ToString(Model.Price, "#,###.#") %> <sup>đ</sup> / <%:Model.UOM %>
            </span>
            <%:Html.Raw(Model.OtherDetails) %>
        </span>
        <button type="button" value="<%:Model.Id %>" class="btn btn-default cart">
            <i class="fa fa-shopping-cart"></i>
            +1 giỏ hàng
        </button>
    </div>
</div>
