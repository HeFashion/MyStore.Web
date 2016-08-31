<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.master" Inherits="System.Web.Mvc.ViewPage<MyStore.App.ViewModels.ProductModel>" %>

<asp:Content ID="indexMeta" ContentPlaceHolderID="MetaContent" runat="server">
    <meta property="og:title" content="<%:Model.Description %>" />
    <%var result = string.Empty;
      Uri requestUrl = HttpContext.Current.Request.Url;

      result = string.Format("{0}://{1}{2}",
                             requestUrl.Scheme,
                             requestUrl.Authority,
                             VirtualPathUtility.ToAbsolute(Url.Content(System.IO.Path.Combine("~/Images/shop", Model.Image, "detail.jpg")))); %>
    <meta property="og:image" content="<%: result%>" />
    <meta property="og:url" content="<%:Request.Url.AbsoluteUri%>" />
</asp:Content>

<asp:Content ID="indexTitle" ContentPlaceHolderID="TitleContent" runat="server">
    Hè Vải Sợi - <%:Model.Description %>
</asp:Content>

<asp:Content ID="indexContent" ContentPlaceHolderID="MainContent" runat="server">
    <%:Html.Partial("_BreadCrumbPartial", ViewData["BreadCrumbs"]) %>

    <!--product-details-->
    <div class="product-details">
        <div class="col-sm-5">
            <div class="view-product">
                <%:Html.Action("GetImageDetail", 
                "Product", 
                new 
                { 
                    selectedIndex=0, 
                    folderName = Model.Image 
                })%>
                <%if (!MyStore.App.Utilities.DeviceHelper.IsSmartPhone(Request.UserAgent))
                  { %>
                <h3>Rê chuột để Zoom</h3>
                <%}
                  else
                  {%>
                <h3>Chọn vào hình để Zoom</h3>
                <%} %>

                <img id="loadingImg"
                    src="<%:Url.Content(System.IO.Path.Combine("~/Images","loading-img.gif")) %>" />

            </div>
            <%if (ViewData.ContainsKey("DetailImg"))
              {%>
            <div id="slider-details"
                class="carousel slide"
                data-ride="carousel"
                data-interval="false">
                <% var listDetails = ViewData["DetailImg"] as System.Collections.Generic.IList<string>;
                   int detailSize = 3;%>

                <!-- Wrapper for slides -->
                <div class="carousel-inner">
                    <div class="item active">
                        <%foreach (string item in listDetails.Take(detailSize))
                          {%>

                        <a href="#" id="<%:listDetails.IndexOf(item) %>">
                            <img src="<%: Url.Content(System.IO.Path.Combine("~/Images/shop",Model.Image, Convert.ToString(item))) %>"
                                alt="<%:item %>"></a>
                        <%} %>
                    </div>
                    <%for (int i = detailSize; i < listDetails.Count; i += detailSize)%>
                    <%{ %>
                    <div class="item">
                        <%var takeList = listDetails.Skip(i).Take(detailSize); %>
                        <%foreach (string item in takeList)%>
                        <%{%>
                        <a href="#" id="<%:listDetails.IndexOf(item) %>">
                            <img src="<%: Url.Content(System.IO.Path.Combine("~/Images/shop",Model.Image, Convert.ToString(item))) %>"
                                alt="<%:item %>"></a>
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
            <%} %>
        </div>
        <div class="col-sm-7">
            <div class="product-information">
                <!--/product-information-->
                <%:Html.Action("BlogVotePartial", "Blog", new {totalScore=Model.Total_Score, totalVoted=Model.Total_Voted})%>
                <%string srcImage = string.Empty; %>
                <%switch (Model.Sale_Off)
                  {
                      case 10:
                          srcImage = "~/Images/shop/sale10.jpg";
                          break;
                      default:
                          int dateDiff = Convert.ToInt32((DateTime.Now - Model.DateCreated).TotalDays);
                          if (dateDiff <= ViewBag.DateCompare)
                              srcImage = "~/Images/shop/new.jpg";
                          break;
                  } %>
                <%if (!string.IsNullOrEmpty(srcImage)) %>
                <%{ %>
                <img src="<%:Url.Content(srcImage) %>" class="newarrival animated flash" alt="" />
                <%} %>
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
                        <button id="btnAddToCart" type="button" value="<%:Model.Id %>" class="btn btn-default cart">
                            <i class="fa fa-shopping-cart"></i>
                            vào giỏ hàng
                        </button>
                    </span>
                </span>

                <table class="socials-share">
                    <tr>
                        <td class="facebook-like">
                            <a class="fb-like" data-href="<%:Request.Url.AbsoluteUri %>" data-width="80px" data-layout="button_count" data-action="like" data-size="small" data-show-faces="true" data-share="true"></a>
                            <%--  --%>
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
                    <%:Html.Raw(Model.OtherDetails) %>
                    <p class="product-note">
                        (*) Nếu có điều kiện, Shop khuyên bạn nên đến địa chỉ 
                        <a href="<%:Url.Action("Contact", "Home") %>">
                            <%:Convert.ToString(System.Configuration.ConfigurationManager.AppSettings[MyStore.App.Utilities.GeneralContanstClass.PAGE_ADDRESS]) %>
                        </a>
                        để lựa vải, bạn sẽ cảm nhận được sự khác biệt, ưu điểm, khuyết điểm của từng loại vải. Từ đó, bạn sẽ chọn được cho mình những bộ vải ưng ý nhất.
                        <br />
                        <strong>Hè-Vải Sợi</strong> chuyên cung cấp các loại vải (đặc biệt là vải áo dài) rẻ & đẹp, đảm bảo chất lượng, nguồn gốc rõ ràng, bán hàng uy tín tại <strong>TT.Long Thành, T. Đồng Nai</strong>.
                    </p>
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
        var isSmartPhone = false;
        $(window).on("load", function () {
            ZoomImage(isSmartPhone);
            LoadingImage(false);
        });

        $(document).ready(function () {
            <%if (!MyStore.App.Utilities.DeviceHelper.IsSmartPhone(Request.UserAgent))
              {%>
            isSmartPhone = true;
            <%}
              else
              {%>
            isSmartPhone = false;
            <%}%>

            LoadingImage(true);

            $("#txtQuantity").numericInput({ allowFloat: true });
            //$("#txtQuantity").on("change", function (e) { alert($("#txtQuantity").val()); })

            Rating_Initialize("<%:ViewBag.BlogRate%>",
                              "<%:Model.Id%>",
                              "<%:(short)MyStore.App.Models.MyData.VoteType.Product %>");

            var btnAddToCart = $("#btnAddToCart");
            AddToCartWithNumber(btnAddToCart, "<%:Model.Id%>");

            SendProductAction(".add-to-cart", "<%:HttpContext.Current.Request.RawUrl%>");

            var imageDetail = $("#slider-details .carousel-inner .item a");
            SwapImageAsyn(imageDetail, "<%:Model.Image%>");
        });
    </script>
</asp:Content>
