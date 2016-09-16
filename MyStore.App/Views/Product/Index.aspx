<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<System.Collections.Generic.IList<MyStore.App.ViewModels.ProductModel>>" %>

<%@ Import Namespace="PagedList.Mvc" %>
<asp:Content ID="indexMeta" ContentPlaceHolderID="MetaContent" runat="server">
    <meta property="og:title" content="<%:ViewBag.ProductTypeName %>" />
    <meta property="og:description" content="<%:ViewBag.ProductTypeDescription %>" />
    <%var result = string.Empty;
      Uri requestUrl = HttpContext.Current.Request.Url;

      result = string.Format("{0}://{1}{2}",
                             requestUrl.Scheme,
                             requestUrl.Authority,
                             VirtualPathUtility.ToAbsolute(Url.Content(System.IO.Path.Combine("~/Images/shop/catalogue", ViewBag.ImageName)))); %>
    <meta property="og:image" content="<%: result%>" />
    <meta property="og:url" content="<%:Request.Url.AbsoluteUri%>" />
</asp:Content>

<asp:Content ID="indexTitle" ContentPlaceHolderID="TitleContent" runat="server">
    Hè Vải Sợi - <%:ViewBag.ProductTypeName %>
</asp:Content>

<asp:Content ID="indexFeatured" ContentPlaceHolderID="FeaturedContent" runat="server">
    <section id="advertisement">
        <div class="container">
            <img src="<%: Url.Content("~/Images/shop/panel.gif") %>" alt="Hè vải sợi panel" />
        </div>
    </section>

</asp:Content>

<asp:Content ID="indexContent" ContentPlaceHolderID="MainContent" runat="server">
    <%:Html.Partial("_BreadCrumbPartial", ViewData["BreadCrumbs"]) %>
    <%:Html.Action("FeatureItemPartial", new {strListTitle = string.Format("Các Sản Phẩm Thuộc {0}", ViewBag.ProductTypeName), partialModel = Model.ToList()}) %>
</asp:Content>
<asp:Content ID="scripSection" ContentPlaceHolderID="ScriptsSection" runat="server">
    <%:Scripts.Render("~/bundles/home/index")%>

    <script type="text/javascript">
        SendProductAction(":button.add-to-cart", "<%:HttpContext.Current.Request.RawUrl%>");
        SortAction();
        var nextIndex = 0;
        var isEnded = false;
        var isLocked = true;
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
            });
        });
        $(document).ready(function () {
            isLocked = false;
        });
    </script>
</asp:Content>
