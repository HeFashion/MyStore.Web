<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="indexTitle" ContentPlaceHolderID="TitleContent" runat="server">
    Home Page - My ASP.NET MVC Application
</asp:Content>

<asp:Content ID="indexFeatured" ContentPlaceHolderID="FeaturedContent" runat="server">
    <!--slider-->
    <section id="slider">
        <div class="container">
            <div class="row">
                <div class="col-sm-12">
                    <div id="slider-carousel" class="carousel slide" data-ride="carousel">

                        <ol class="carousel-indicators">
                            <% var sliderData = ViewData["slider"] as IList<MyStore.App.Models.MyData.Ad_Sliders>; %>
                            <%for (int i = 0; i < sliderData.Count; i++)
                              { %>
                            <%if (i == 0)
                              {%>
                            <li data-target="#slider-carousel" data-slide-to="<%:i%>" class="active"></li>
                            <%} %>
                            <%else
                              { %>
                            <li data-target="#slider-carousel" data-slide-to="<%:i%>"></li>
                            <%} %>
                            <%} %>
                        </ol>

                        <div class="carousel-inner">
                            <%foreach (var item in sliderData)
                              {%>
                            <%: ViewBag.ActiveItem = sliderData.IndexOf(item)==0 %>
                            <%: Html.Partial("_ItemSliderPartial", item)%>
                            <%} %>
                        </div>

                        <a href="#slider-carousel" class="left control-carousel hidden-xs" data-slide="prev">
                            <i class="fa fa-angle-left"></i>
                        </a>
                        <a href="#slider-carousel" class="right control-carousel hidden-xs" data-slide="next">
                            <i class="fa fa-angle-right"></i>
                        </a>
                    </div>

                </div>
            </div>
        </div>
    </section>
    <!--slider-->
</asp:Content>

<asp:Content ID="indexContent" ContentPlaceHolderID="MainContent" runat="server">
    <% var newProduct = ViewData["new_product"] as IList<MyStore.App.ViewModels.ProductModel>;%>
    <h2 class="title text-center"><%:"Hàng Mới Về" %></h2>

    <div class="category-tab">

        <!--category-tab-->
        <div class="col-sm-12">
            <%var productType = newProduct.Select(p => p.Type).Distinct(); %>
            <ul class="nav nav-tabs">
                <%var firstTypeString = productType.FirstOrDefault(); %>
                <li class="active"><a href="<%:string.Concat("#",firstTypeString.Replace(" ", "_")) %>" data-toggle="tab"><%:firstTypeString %></a></li>
                <%foreach (var item in productType.Skip(1))
                  { %>
                <li><a href="<%:string.Concat("#", item) %>" data-toggle="tab"><%:item %></a></li>
                <%} %>
            </ul>
        </div>
        <div class="tab-content">
            <%bool activeFlag = true; %>
            <%foreach (var category in newProduct.GroupBy(p => p.Type))
              {
                  var firstType = category.First();%>
            <div class="<%: activeFlag?"tab-pane fade active in": "tab-pane fade" %>" id="<%:firstType.Type.Replace(" ","_") %>">
                <%foreach (var item in category)
                  {%>
                <div class="col-sm-3">
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
                                    <a href="<%:Url.Action("Details", "Product", new {id = item.Id })%>" class="btn btn-default view-details">
                                        <i class="fa fa-external-link"></i>
                                        Chi tiết
                                    </a>
                                    <a id="<%: item.Id %>" href="#" class="btn btn-default add-to-cart">
                                        <i class="fa fa-shopping-cart"></i>Thêm vào giỏ hàng
                                    </a>
                                </div>
                            </div>
                            <%int dateDiff = Convert.ToInt32((DateTime.Now - item.DateCreated).TotalDays); %>
                            <%if (dateDiff <= ViewBag.DateCompare)%>
                            <%{%>
                            <img src="<%:Url.Content("~/Images/home/new.png") %>" class="new" alt="" />
                            <%} %>
                        </div>

                    </div>
                </div>
                <%} %>
            </div>
            <%activeFlag = false; %>
            <%} %>
        </div>

    </div>
    <!--/category-tab-->
    <!-- Modal -->
    <div id="myModal" class="modal fade" role="dialog" data-url="<%:Url.Action("RecommendProductPartial","Product") %>">
        <div id="modalContent" class="modal-dialog">
        </div>
    </div>
</asp:Content>
<asp:Content ID="scriptSection" ContentPlaceHolderID="ScriptsSection" runat="server">
    <%:Scripts.Render("~/bundles/jqueryui") %>
    <%:Scripts.Render("~/Scripts/addtocart.js") %>
    <script type="text/javascript">
        $(document).ready(function () {
            var obj = $(".add-to-cart");
            SendProductAction(obj, "<%: Url.Action("AddToCart", "Cart")%>");
        });

    </script>
</asp:Content>
