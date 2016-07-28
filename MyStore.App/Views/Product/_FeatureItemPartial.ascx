<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<IEnumerable<MyStore.App.ViewModels.ProductModel>>" %>

<!--features_items-->

<div id="featureItems" class="features_items">
    <div class="header_items">
        <h2 class="title text-center"><%:ViewBag.ListTitle %></h2>
        <%if (Model != null && Model.Count() > 0)
          {%>
        <div class="btn-group" id="sortArea">
            <%var sortList1 = ViewData["SortList1"] as IList<SelectListItem>; %>
            <div class="btn-group" id="sortArea1">
                <%var seletedItem = sortList1.Where(p => p.Selected == true).SingleOrDefault(); %>
                <button type="button"
                    class="btn btn-default dropdown-toggle usa"
                    data-toggle="dropdown"
                    value="<%:seletedItem.Value %>">
                    <%:seletedItem.Text %>
                    <span class="caret"></span>
                </button>
                <ul class="dropdown-menu dropdown-menu-right">
                    <%var otherItem = sortList1.Where(p => p.Selected == false).SingleOrDefault(); %>
                    <li>
                        <a href="#" id="<%:otherItem.Value %>">
                            <%:otherItem.Text %>
                        </a>
                    </li>
                </ul>
            </div>

            <%var sortList2 = ViewData["SortList2"] as IList<SelectListItem>; %>
            <div class="btn-group" id="sortArea2">
                <%seletedItem = sortList2.Where(p => p.Selected == true).SingleOrDefault(); %>
                <button type="button"
                    class="btn btn-default dropdown-toggle usa"
                    data-toggle="dropdown"
                    value="<%:seletedItem.Value %>">
                    <%:seletedItem.Text %>
                    <span class="caret"></span>
                </button>
                <ul class="dropdown-menu dropdown-menu-right">
                    <%otherItem = sortList2.Where(p => p.Selected == false).SingleOrDefault(); %>
                    <li>
                        <a href="#" id="<%:otherItem.Value %>">
                            <%:otherItem.Text %>
                        </a>
                    </li>
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
