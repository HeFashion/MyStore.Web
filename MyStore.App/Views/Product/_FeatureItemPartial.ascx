<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<IEnumerable<MyStore.App.ViewModels.ProductModel>>" %>

<!--features_items-->

<div id="featureItems" class="features_items">
    <div class="header_items">
        <h2 class="title text-center"><%:ViewBag.ListTitle %></h2>
        <%if (Model != null && Model.Count() > 0)
          {%>
        <div class="btn-group">
            <div class="btn-group">
                <button type="button" class="btn btn-default dropdown-toggle usa" data-toggle="dropdown">
                    Ngày Tạo
				<span class="caret"></span>
                </button>
                <ul class="dropdown-menu dropdown-menu-right">
                    <li><a href="#">Giá</a></li>
                </ul>
            </div>

            <div class="btn-group">
                <button type="button" class="btn btn-default dropdown-toggle usa" data-toggle="dropdown">
                    Giảm Dần
				<span class="caret"></span>
                </button>
                <ul class="dropdown-menu dropdown-menu-right">
                    <li><a href="#">Tăng Dần</a></li>
                </ul>
            </div>
        </div>

        <%} %>
    </div>

    <%:Html.Partial("_ListItemsPartial", Model) %>
</div>

<div id="progress" style="display: none">
    <img src="<%:Url.Content("~/Images/loading.gif") %>" alt="load" />
</div>

<!--features_items-->
