<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<PagedList.IPagedList<MyStore.App.ViewModels.ProductModel>>" %>

<%@ Import Namespace="PagedList.Mvc" %>

<asp:Content ID="indexTitle" ContentPlaceHolderID="TitleContent" runat="server">
    Trang Chủ | Hè-Vải Sợi
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
                            <% ViewBag.ActiveItem = sliderData.IndexOf(item) == 0 ? true : false; %>
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
    <%var recommendList = ViewData["RecommendList"] as IList<MyStore.App.ViewModels.ProductModel>;%>
    <%: Html.Action("RecommendProductPartial", "Product", new{model=recommendList})%>

    
    <div class="home_items">
        <h2 class="title text-center"><%:ViewBag.ListTitle %></h2>
        <%:Html.PagedListPager(Model, 
                           page=>Url.Action("Index",
                                            new {page})) %>
        <% foreach (var item in Model)%>
        <%{%>
        <div class="col-sm-3">
            <div class="product-image-wrapper">
                <div class="single-products">
                    <div class="productinfo text-center">
                        <img src="<%: Url.Content(System.IO.Path.Combine("~/Images/shop", item.Image, "index.jpg")) %>" alt="" />
                        <h2><%: MyStore.App.Utilities.DecimalHelper.ToString(item.Price, "#,###.#")  %> <sup>đ</sup></h2>
                        <p><%: item.Description %></p>
                    </div>
                    <div class="product-overlay">
                        <div class="overlay-content">
                            <h2><%: MyStore.App.Utilities.DecimalHelper.ToString(item.Price, "#,###.#") %> <sup>đ</sup></h2>
                            <p><%: item.Description %></p>
                            <a href="<%:Url.Action("Details", "Product", new {id = item.Id })%>" class="btn view-details">
                                <i class="fa fa-external-link"></i>
                                Chi tiết
                            </a>
                            <a id="<%: item.Id %>" href="#" class="btn add-to-cart">
                                <i class="fa fa-shopping-cart"></i>+1 giỏ hàng
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
    <%:Html.PagedListPager(Model, 
                           page=>Url.Action("Index",
                                            new {page})) %>
    <!--features_items-->
</asp:Content>
<asp:Content ID="scriptSection" ContentPlaceHolderID="ScriptsSection" runat="server">
    <%:Scripts.Render("~/bundles/jqueryui")%>
    <%:Scripts.Render("~/Scripts/addtocart.js")%>
    <script type="text/javascript">
        $(document).ready(function () {
            var obj = $(".add-to-cart");
            SendProductAction(obj, "<%: Url.Action("AddToCart", "Cart")%>");
        });

    </script>
</asp:Content>
