﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.master" Inherits="System.Web.Mvc.ViewPage<PagedList.IPagedList<MyStore.App.ViewModels.ProductModel>>" %>

<%@ Import Namespace="PagedList.Mvc" %>

<asp:Content ID="indexTitle" ContentPlaceHolderID="TitleContent" runat="server">
    Sản phẩm - Danh sách
</asp:Content>

<asp:Content ID="indexFeatured" ContentPlaceHolderID="FeaturedContent" runat="server">
    <section id="advertisement">
        <div class="container">
            <img src="<%: Url.Content("~/Images/shop/panel.jpg") %>" alt="" />
        </div>
    </section>

</asp:Content>

<asp:Content ID="indexContent" ContentPlaceHolderID="MainContent" runat="server">

    <%:Html.Action("FeatureItemPartial", new {strListTitle = string.Format("Các Sản Phẩm Thuộc {0}", ViewBag.ProductTypeName), partialModel = Model.ToList()}) %>
    <%:Html.PagedListPager(Model, 
                           page=>Url.Action("Index",
                                            new {prodType = Convert.ToInt32(ViewData["prodType"]),
                                                 page,
                                                 searchString=ViewBag.SearchString})) %>
</asp:Content>
<asp:Content ID="scripSection" ContentPlaceHolderID="ScriptsSection" runat="server">
    <%:Scripts.Render("~/bundles/jqueryui") %>
    <%:Scripts.Render("~/Scripts/addtocart.js") %>
    <script type="text/javascript">
        $(document).ready(function () {
            SendProductAction(":button.add-to-cart");
        });
    </script>
</asp:Content>
