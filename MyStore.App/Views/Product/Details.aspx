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
    Chi Tiết | Hè-Vải Sợi
</asp:Content>

<asp:Content ID="indexContent" ContentPlaceHolderID="MainContent" runat="server">
    <%:Html.Partial("_BreadCrumbPartial", ViewData["BreadCrumbs"]) %>

    <!--product-details-->
    <div class="product-details">
        <div class="col-sm-5">
            <div class="view-product">
                <img id="<%:Model.Name %>"
                    src="<%:Url.Content(System.IO.Path.Combine("~/Images/shop",Model.Image, "detail.jpg")) %>"
                    alt="<%:Model.Image %>"
                    data-zoom-image="<%:Url.Content(System.IO.Path.Combine("~/Images/shop", Model.Image,"original.jpg")) %>" />
                <%if (!MyStore.App.Utilities.DeviceHelper.IsSmartPhone(Request.UserAgent))
                  { %>
                <h3>Rê chuột để Zoom</h3>
                <%}
                  else
                  {%>
                <h3>Chọn vào hình để Zoom</h3>
                <%} %>
            </div>
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
                <img src="<%:Url.Content(srcImage) %>" class="newarrival" alt="" />
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
                        <button type="button" value="<%:Model.Id %>" class="btn btn-default cart">
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
        $(document).ready(function () {
            <%if (!MyStore.App.Utilities.DeviceHelper.IsSmartPhone(Request.UserAgent))
              {%>
            $("<%:"#"+ Model.Name %>").elevateZoom();
            <%}
              else
              {%>
            $("<%:"#"+ Model.Name %>").elevateZoom({
                zoomType: "inner",
                cursor: "crosshair"
            });
            <%}%>
            $("#txtQuantity").numericInput({ allowFloat: true });

            Rating_Initialize("<%:ViewBag.BlogRate%>",
                              "<%:Model.Id%>",
                              "<%:(short)MyStore.App.Models.MyData.VoteType.Product %>");

            SendProductAction(":button.add-to-cart", "<%:HttpContext.Current.Request.RawUrl%>");

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
