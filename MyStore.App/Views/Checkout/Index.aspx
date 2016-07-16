<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/SubSite.Master" Inherits="System.Web.Mvc.ViewPage<MyStore.App.ViewModels.CheckoutViewModel>" %>

<asp:Content ID="titleContent" ContentPlaceHolderID="TitleContent" runat="server">
    Thông tin giao hàng
</asp:Content>
<asp:Content ID="panelContent" ContentPlaceHolderID="FeaturedContent" runat="server">
    <section id="advertisement">
        <div class="container">
            <img src="<%: Url.Content("~/Images/shop/delivery-process.jpg") %>" alt="" />
        </div>
    </section>
</asp:Content>

<asp:Content ID="mainContent" ContentPlaceHolderID="MainContent" runat="server">
    <section id="cart_items">
        <div class="container">
            <%:Html.Partial("_BreadCrumbPartial", ViewData["BreadCrumbs"]) %>

            <%if (Model.CurrentStep == MyStore.App.ViewModels.CheckoutStep.Authentication)%>
            <%{ %>
            <%:Html.Partial("_AuthenticationPartial", Model) %>
            <%} %>
            <%else if (Model.CurrentStep == MyStore.App.ViewModels.CheckoutStep.BillingInfo)%>
            <%{ %>
            <%:Html.Partial("_DeliveryInfoPartial", Model) %>
            <%} %>
            <%-- <%else%>
            <%{ %>
            <%:Html.Partial("_PaymentInfoPartial", Model) %>
            <%} %>--%>
        </div>
    </section>

</asp:Content>

<asp:Content ID="scriptsSection" ContentPlaceHolderID="ScriptsSection" runat="server">
    <%:Scripts.Render("~/bundles/jqueryval") %>
    <%:Scripts.Render("~/Scripts/check_out.js") %>
</asp:Content>
