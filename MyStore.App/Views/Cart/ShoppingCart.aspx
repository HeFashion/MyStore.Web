<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/SubSite.Master" Inherits="System.Web.Mvc.ViewPage<System.Collections.Generic.IList<MyStore.App.ViewModels.ShoppingCartViewModel>>" %>

<asp:Content ID="titleContent" ContentPlaceHolderID="TitleContent" runat="server">
    Sản phẩm - Giỏ hàng
</asp:Content>
<asp:Content ID="panelContent" ContentPlaceHolderID="FeaturedContent" runat="server">
    <section id="advertisement">
        <div class="container">
            <img src="<%: Url.Content("~/Images/shop/delivery-process.jpg") %>" alt="" />
        </div>
    </section>
</asp:Content>

<asp:Content ID="mainContent" ContentPlaceHolderID="MainContent" runat="server">
    <%-- Begin Cart Items --%>
    <section id="cart_items">
        <div class="container">
            <%IDictionary<string, string> dCrumbs = new Dictionary<string, string>(); %>
            <%dCrumbs.Add("Giỏ Hàng", string.Empty); %>
            <%:Html.Partial("_BreadCrumbPartial", dCrumbs) %>

            <div class="table-responsive cart_info">
                <%:Html.Partial("_CartTablePartial", Model) %>
            </div>
        </div>
    </section>
    <%-- End Cart Items --%>
    <%if (Model != null && Model.Count > 0)%>
    <%{ %>
    <%-- Begin Do Action --%>
    <section id="do_action">
        <div class="container">
            <div class="heading">
                <h3>Bạn có muốn tính tiền hay không?</h3>
                <p>Quý khách vui lòng kiểm tra bảng thanh toán bên trên và click vào <b>Thanh Toán</b>, sau đó làm theo các bước hướng dẫn để nhận hàng</p>
            </div>
            <div class="row">
                <div class="col-sm-6">
                    <div class="total_area">
                        <a class="btn btn-default check_out" href="<%:Url.Action("Index", "Checkout") %>">
                            <i class="fa fa-money"></i>
                            Thanh toán
                        </a>
                        <%if (!string.IsNullOrEmpty(ViewBag.ReturnUrl))
                          { %>
                        <a class="btn btn-default check_out" href="<%:ViewBag.ReturnUrl %>">
                            <i class="fa fa-reply"></i>
                            Quay lại
                        </a>
                        <%} %>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <%-- End Do Action --%>
    <%} %>
</asp:Content>

<asp:Content ID="scriptContent" ContentPlaceHolderID="ScriptsSection" runat="server">
    <%: Scripts.Render("~/bundles/cart/shopping") %>
</asp:Content>
