<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<IEnumerable<MyStore.App.ViewModels.ProductModel>>" %>

<!--features_items-->

<div id="featureItems" class="features_items">
    <h2 class="title text-center"><%:ViewBag.ListTitle %></h2>
     <%:Html.Partial("_ListItemsPartial", Model) %>
</div>
<!--features_items-->
