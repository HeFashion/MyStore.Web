<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<System.Collections.Generic.IList<MyStore.App.ViewModels.ProductModel>>" %>

<%@ Import Namespace="PagedList.Mvc" %>
<asp:Content ID="indexMeta" ContentPlaceHolderID="MetaContent" runat="server">
    <meta property="og:title" content="Hè-Vải Sợi" />
    <%var result = string.Empty;
      Uri requestUrl = HttpContext.Current.Request.Url;

      result = string.Format("{0}://{1}{2}",
                             requestUrl.Scheme,
                             requestUrl.Authority,
                             VirtualPathUtility.ToAbsolute(Url.Content("~/Images/home/metaImg.jpg"))); %>
    <meta property="og:image" content="<%: result%>" />
    <meta property="og:url" content="<%:Request.Url.AbsoluteUri%>" />
    <meta property="og:description" content="Chuyên bán các loại vải sợi cho Nam & Nữ, uy tín, giao hàng toàn quốc. Xem hàng ngay" />
</asp:Content>

<asp:Content ID="indexTitle" ContentPlaceHolderID="TitleContent" runat="server">
    Hè Vải Sợi - Bán cái loại vải sợi Nam & Nữ.
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
    <%: Html.Action("FeatureItemPartial", "Product", new {strListTitle = ViewBag.ListTitle,partialModel= Model}) %>
</asp:Content>
<asp:Content ID="scriptSection" ContentPlaceHolderID="ScriptsSection" runat="server">
    <%:Scripts.Render("~/bundles/home/index")%>

    <script type="text/javascript">
        var nextIndex = 0;
        var isEnded = false;
        var isLocked = true;

        SendProductAction(":button.add-to-cart", "<%:HttpContext.Current.Request.RawUrl%>");
        SortAction();
        $(window).on("load", function () {
            $(window).scroll(function () {

                if (!isEnded && !isLocked) {
                    if ($(this).scrollTop() + $(window).height() > $('#footer').offset().top + 30) {
                        var sendData = {
                            "page": nextIndex,
                            "prodType": "<%:ViewData["prodType"]%>",
                            "searchString": "<%:ViewData["SearchString"]%>",
                            "sortKey": $.cookie("selectedSortString")
                        };
                        getData(sendData);
                    }
                }

                //var mydiv = $("#left-menu");
                //if ($(window).scrollTop() > $(window).height() + mydiv.scrollTop()
                //      && $(this).scrollTop() + $(window).height() < $('#footer').offset().top
                //    ) {
                //    mydiv.css({
                //        "marginTop": $(window).scrollTop() - $(window).height() + "px"
                //    });
                //}
                //else {
                //    mydiv.css({
                //        "marginBottom": "0"
                //    });
                //}

                //mydiv.stop()
                //     .animate({
                //         "marginTop": $(this).scrollTop() - $(window).height() + "px"
                //     }, "slow");

            });
        });
        $(document).ready(function () {
            isLocked = false;

        });

    </script>
</asp:Content>
