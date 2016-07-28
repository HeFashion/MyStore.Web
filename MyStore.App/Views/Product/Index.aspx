<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<System.Collections.Generic.IList<MyStore.App.ViewModels.ProductModel>>" %>

<%@ Import Namespace="PagedList.Mvc" %>

<asp:Content ID="indexTitle" ContentPlaceHolderID="TitleContent" runat="server">
    Phân Loại | Hè-Vải Sợi
</asp:Content>

<asp:Content ID="indexFeatured" ContentPlaceHolderID="FeaturedContent" runat="server">
    <section id="advertisement">
        <div class="container">
            <img src="<%: Url.Content("~/Images/shop/panel.gif") %>" alt="" />
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
        $(window).load(function () {
            $(window).scroll(function () {
                if (!isEnded && !isLocked) {
                    if ($(this).scrollTop() + $(window).height() > $('#footer').offset().top + 30) {
                        var sendData = {
                            "page": nextIndex,
                            "prodType": "<%:ViewData["prodType"]%>",
                            "searchString": "<%:ViewData["SearchString"]%>"
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
