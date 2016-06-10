<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<System.Collections.Generic.IList<MyStore.App.ViewModels.ProductModel>>" %>

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
    <%: Html.Action("FeatureItemPartial", "Product", new {strListTitle = ViewBag.ListTitle,partialModel= Model}) %>
    <div id="progress" style="display: none">
        <img src="<%:Url.Content("~/Images/loading.gif") %>" alt="load" />
    </div>

</asp:Content>
<asp:Content ID="scriptSection" ContentPlaceHolderID="ScriptsSection" runat="server">
    <%:Scripts.Render("~/Scripts/addtocart.js")%>
    <%:Scripts.Render("~/Scripts/main.js")%>
    <%:Scripts.Render("~/Scripts/jquery.scrollUp.js")%>

    <script type="text/javascript">
        var nextIndex = 1;
        var isEnded = false;
        var isLocked = false;

        //var obj = $();
        SendProductAction(":button.add-to-cart");

        $(document).ready(function () {

            $(window).scroll(function () {
                if (!isEnded && !isLocked) {
                    if ($(this).scrollTop() + $(window).height() > $('#footer').offset().top + 50) {
                        GetData(nextIndex);
                    }
                }
            });
        });

    </script>
</asp:Content>
