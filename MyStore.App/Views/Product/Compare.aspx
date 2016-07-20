<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<IEnumerable<MyStore.App.ViewModels.ProductModel>>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    So Sánh | Hè-Vải Sợi
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <%:Html.Partial("_BreadCrumbPartial", ViewData["BreadCrumbs"]) %>

    <h2 class="title text-center">So Sánh Sản Phẩm</h2>
    <div class="compare-area">
        <%if (Model != null && Model.Count() > 0)
          {%>
        <%var firstProduct = Model.First(); %>
        <div class="col-sm-6">
            <%:Html.Partial("_CompareItemPartial", firstProduct) %>
        </div>
        <div class="col-sm-6">
            <div id="compare-product" class="carousel slide" data-ride="carousel" data-interval="false">
                <div class="carousel-inner">
                    <div class="item active">
                        <%var secondProduct = Model.Skip(1).First(); %>
                        <%:Html.Partial("_CompareItemPartial", secondProduct) %>
                    </div>
                    <%foreach (var product in Model.Skip(2))
                      { %>

                    <div class="item">
                        <%:Html.Partial("_CompareItemPartial", product) %>
                    </div>
                    <%} %>
                </div>
                <!-- Controls -->
                <a class="left item-control" href="#compare-product" data-slide="prev">
                    <i class="fa fa-angle-left"></i>
                </a>
                <a class="right item-control" href="#compare-product" data-slide="next">
                    <i class="fa fa-angle-right"></i>
                </a>
            </div>
        </div>
    </div>
    <%} %>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="ScriptsSection" runat="server">
    <%:Scripts.Render("~/bundles/product/compare") %>
    <script type="text/javascript">
        $(document).ready(function () {
            SendProductAction(":button.cart","<%:HttpContext.Current.Request.RawUrl%>");
        });
    </script>
</asp:Content>
