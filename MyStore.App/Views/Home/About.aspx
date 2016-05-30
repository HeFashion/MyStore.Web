<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="aboutTitle" ContentPlaceHolderID="TitleContent" runat="server">
    Giới Thiệu
</asp:Content>

<asp:Content ID="aboutContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="blog-post-area">
        <h2 class="title text-left"><%:ViewBag.Message %></h2>
        <div class="single-blog-post">
            <div class="post-meta">
                <ul>
                    <li><i class="fa fa-user"></i>Cao Hoành</li>
                    <li><i class="fa fa-clock-o"></i>1:33 pm</li>
                    <li><i class="fa fa-calendar"></i>DEC 5, 2016</li>
                </ul>

            </div>
            <p>Với hơn <b>50 năm</b> kinh nghiệm trong nghề may áo dài, nhà may Hè chuyên May Đo, Bán các loại áo dài.</p>
            <a href="<%: Url.Content("~/images/home/ao_dai.jpg") %>" rel="prettyPhoto[myShop]" title="Áo dài">
                <img class="vertical-img" src="<%: Url.Content("~/images/home/ao_dai.jpg") %>" alt="ao dai">
            </a>
            <p>Nhà may Hè chuyên Bán các loại vải áo dài cho mọi đối tượng, từ bình dân cho đến cao cấp nhằm phục vụ nhu cầu làm đẹp của tất cả chị em phụ nữ Việt Nam, đặc biệt là ở thị trấn <b>Long Thành, Đồng Nai</b>. Nhà may Hè là địa chỉ đáng tin cậy của bạn.</p>
            <a href="<%: Url.Content("~/images/home/left_shop.jpg") %>" rel="prettyPhoto[myShop]" title="Hè vải sợi">
                <img src="<%: Url.Content("~/images/home/left_shop.jpg") %>" alt="left_shop.jpg">
            </a>
            <p>
                Ngoài ra, chúng tôi còn bán cả những loại vải khác như Sơ mi, quần tây, đồ bộ cả nam lẫn nữ. Nhà may Hè luôn luôn mong muốn đem lại vẻ đẹp hoàn hảo cho tất cả mọi người.
            </p>
            <br>
            <a href="<%: Url.Content("~/images/home/texture_focus.jpg") %>" rel="prettyPhoto[myShop]" title="Một góc của shop">
                <img src="<%: Url.Content("~/images/home/texture_focus.jpg") %>" alt="texture focus">
            </a>
            <a href="<%: Url.Content("~/images/home/right_shop.jpg") %>" rel="prettyPhoto[myShop]" title="Một góc của shop">
                <img src="<%: Url.Content("~/images/home/right_shop.jpg") %>" alt="right shop">
            </a>
            <p>
                Mỗi dịp lễ hỏi, lễ cưới, sinh nhật....sự kiện, hội nghĩ, lễ kỷ niệm... 
                Nhà may Hè luôn đồng hành cũng chị em phụ nữ. 
                Nét đẹp duyên dáng,  nét quí phái nhưng gần gũi tạo <b>Sự Tự Tin</b> và <b>Trẻ Trung</b>. 
                Bạn muốn có một bộ trang phục áo dài hợp với đường cong cơ thể. 
                Hãy Liên Hệ Với Chúng Tôi ngay khi quý khách có nhu cầu.
            </p>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ScriptsSection" runat="server">
    <%: Scripts.Render("~/Scripts/facebook.js") %>
    <%: Scripts.Render("~/Scripts/googleplus.js") %>
    <script type="text/javascript">
        $(document).ready(function () {
            $("a[rel^='prettyPhoto']").prettyPhoto();
        });
    </script>
</asp:Content>
