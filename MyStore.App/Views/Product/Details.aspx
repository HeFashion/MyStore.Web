<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.master" Inherits="System.Web.Mvc.ViewPage<MyStore.App.ViewModels.ProductModel>" %>

<asp:Content ID="indexTitle" ContentPlaceHolderID="TitleContent" runat="server">
    Sản phẩm - Chi tiết
</asp:Content>

<asp:Content ID="indexContent" ContentPlaceHolderID="MainContent" runat="server">
    <!--product-details-->
    <div class="product-details">
        <div class="col-sm-5">
            <div class="view-product">
                <img id="<%:Model.Name %>"
                    src="<%:Url.Content(System.IO.Path.Combine("~/Images/shop",Model.Image, "detail.jpg")) %>"
                    alt="<%:Model.Image %>"
                    data-zoom-image="<%:Url.Content(System.IO.Path.Combine("~/Images/shop", Model.Image,"original.jpg")) %>" />
                <h3>Rê chuột(hoặc chọn vào hình) để Zoom</h3>
            </div>
        </div>
        <div class="col-sm-7">
            <div class="product-information">
                <!--/product-information-->
                <%:Html.Action("BlogVotePartial", "Blog", new {totalScore=Model.Total_Score, totalVoted=Model.Total_Voted})%>
                <%int dateDiff = Convert.ToInt32((DateTime.Now - Model.DateCreated).TotalDays); %>
                <%if (dateDiff < ViewBag.DateCompare)%>
                <%{%>
                <img src="<%:Url.Content("~/Images/shop/new.jpg") %>" class="newarrival" alt="" />
                <%}%>
                <h2><%:Model.Description %></h2>

                <p>Mã hàng: <%:Model.Name %></p>

                <span>
                    <span>
                        <%:MyStore.App.Utilities.DecimalHelper.ToString(Model.Price, "#,###.#") %> <sup>đ</sup> / <%:Model.UOM %>
                    </span>
                    <br />
                    <span>
                        <label>Thêm:</label>
                        <input type="text" value="1" id="txtQuantity" />
                        <button type="button" value="<%:Model.Id %>" class="btn btn-default cart">
                            <i class="fa fa-shopping-cart"></i>
                            vào giỏ hàng
                        </button>
                    </span>
                </span>

                <table class="socials-share">
                    <tr>
                        <td>
                            <a class="fb-like" data-href="<%:Request.Url.AbsoluteUri %>" data-layout="button_count" data-action="like" data-show-faces="true"></a>
                        </td>
                        <td class="google-plus">
                            <!-- Google + one -->
                            <a class="g-plusone" data-href="<%:Request.Url.AbsoluteUri %>"></a>
                        </td>
                    </tr>
                </table>

            </div>
            <!--/product-information-->
        </div>
    </div>
    <!--/product-details-->

    <!--category-tab-->
    <div class="category-tab shop-details-tab ">
        <div class="col-sm-12">
            <ul class="nav nav-tabs">
                <li class="active">
                    <a href="#details" data-toggle="tab">Giới Thiệu</a>
                </li>
                <li>
                    <a href="#reviews" data-toggle="tab" id="comments">Nhận Xét(
                        <span class="fb-comments-count" data-href="<%:Request.Url.AbsoluteUri %>"></span>
                        )
                    </a>
                </li>
            </ul>
        </div>
        <div class="tab-content">

            <div class="tab-pane fade  active in" id="details">
                <div class="col-sm-12">
                    <%--<p><%:Model.OtherDetails %></p>--%>
                    <%:Html.Raw(Model.OtherDetails) %>
                </div>
            </div>
            <div class="tab-pane fade" id="reviews">
                <div class="col-sm-12">
                    <%ViewBag.RateTitle = "Đánh Giá Sản Phẩm:";
                      ViewBag.RatedCount = Model.Total_Voted;%>
                    <%:Html.Partial("_RateObjectPartial") %>

                    <div class="fb-comments" data-href="<%:Request.Url.AbsoluteUri %>" data-numposts="5"></div>
                </div>
            </div>
        </div>
    </div>
    <!--/category-tab-->
    <%IList<MyStore.App.ViewModels.ProductModel> recommendItems = ViewData["RecommendProduct"] as IList<MyStore.App.ViewModels.ProductModel>; %>
    <%ViewBag.RecommendTitle = "Các Sản Phẩm Liên Quan"; %>
    <%:Html.Partial("_RecommendItemsPartial",  recommendItems)%>
</asp:Content>

<asp:Content ID="scriptContent" ContentPlaceHolderID="ScriptsSection" runat="server">
    <%: Styles.Render("~/Content/themes/mystyle/jquery.rateyo.css") %>
    <%: Scripts.Render("~/bundles/product/details") %>

    <script>
        $(document).ready(function () {
            $("<%:"#"+ Model.Name %>").elevateZoom();
            $("#txtQuantity").numericInput({ allowFloat: true });

            Rating_Initialize("<%:ViewBag.BlogRate%>",
                              "<%:Model.Id%>",
                              "<%:(short)MyStore.App.Models.MyData.VoteType.Product %>");

            SendProductAction(":button.add-to-cart");

            $(":button.cart").click(function (e) {
                e.preventDefault();

                var sendInfo = {
                    productId: "<%:Model.Id%>",
                    productQuantity: $("#txtQuantity").val()
                };
                AddToCart(sendInfo);
            });
        });
    </script>
</asp:Content>
