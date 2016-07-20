<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/SubSite.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Hoàn Thành | Hè-Vải Sợi
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="register-req">
        <h2>Đơn Hàng Đã Được Gửi</h2>
        <p>
            Đơn hàng của quý khách đã hoàn thành, chúng tôi sẽ xử lý đơn hàng và phản hồi 
            với quý khách lâu nhất là 2 ngày làm việc.
        </p>
        <p>
            Quý khách có thể bấm vào 
            <a class="btn btn-primary" href="<%:Url.Action("Index", "Home") %>">
                <i class="fa fa-home"></i>
                Trang Chủ
            </a>để tiếp tục mua sắm.
        </p>
    </div>



</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="ScriptsSection" runat="server">
</asp:Content>
