<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="aboutTitle" ContentPlaceHolderID="TitleContent" runat="server">
    Hè Vải Sợi - Giới Thiệu
</asp:Content>

<asp:Content ID="aboutContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="blog-post-area">
        <%:Html.Partial("_BreadCrumbPartial", ViewData["BreadCrumbs"]) %>

        <h2 class="title text-center"><%:ViewBag.Message %></h2>

        <div class="single-blog-post">
            <div class="post-meta">
                <ul>
                    <li><i class="fa fa-user"></i>Cao Hoành</li>
                    <li><i class="fa fa-clock-o"></i>1:33 pm</li>
                    <li><i class="fa fa-calendar"></i>DEC 5, 2016</li>
                </ul>

            </div>
            <p>Với kinh nghiệm hơn <b>10 năm</b> trong lĩnh vực vải sợi, <strong>Hè - Vải Sợi</strong> chuyên bán các loại vải phù hợp mọi lứa tuổi, đặc biệt là <strong>vải áo dài</strong>.</p>
            <a href="<%: Url.Content("~/images/home/banner.jpg") %>" rel="prettyPhoto[myShop]" title="Áo dài">
                <img src="<%: Url.Content("~/images/home/banner.jpg") %>" alt="shop outside">
            </a>
            <p><strong>Hè - Vải Sợi</strong> chuyên Bán các loại vải áo dài cho mọi đối tượng, từ bình dân cho đến cao cấp nhằm phục vụ nhu cầu làm đẹp của tất cả chị em phụ nữ Việt Nam, đặc biệt là ở thị trấn <b>Long Thành, Đồng Nai</b>. <strong>Hè - Vải Sợi</strong> là địa chỉ đáng tin cậy của bạn.</p>
            <a href="<%: Url.Content("~/images/home/left_shop.jpg") %>" rel="prettyPhoto[myShop]" title="Hè vải sợi">
                <img src="<%: Url.Content("~/images/home/left_shop.jpg") %>" alt="left_shop.jpg">
            </a>
            <p>
                Ngoài ra, chúng tôi còn bán cả những loại vải khác như <strong>Sơ-mi, quần tây, đồ bộ..</strong>. cho cả nam lẫn nữ. <strong>Hè - Vải Sợi</strong> luôn luôn mong muốn đem lại vẻ đẹp hoàn hảo cho tất cả mọi người.
            </p>
            <br>
            <a href="<%: Url.Content("~/images/home/texture_focus.jpg") %>" rel="prettyPhoto[myShop]" title="Một góc của shop">
                <img alt="texture focus" src="<%: Url.Content("~/images/home/texture_focus.jpg") %>">
            </a>
            <a href="<%: Url.Content("~/images/home/right_shop.jpg") %>" rel="prettyPhoto[myShop]" title="Một góc của shop">
                <img src="<%: Url.Content("~/images/home/right_shop.jpg") %>" alt="right shop">
            </a>
            <p>
                Mỗi dịp lễ hỏi, lễ cưới, sinh nhật....sự kiện, hội nghị, lễ kỷ niệm... 
                <strong>Hè - Vải Sợi</strong> luôn đồng hành cũng chị em phụ nữ. 
                Nét đẹp duyên dáng,  nét quí phái nhưng gần gũi tạo <b>Sự Tự Tin</b> và <b>Trẻ Trung</b>. 
                Bạn muốn có một bộ vải hợp với vóc dáng và làn da của cơ thể?
                Hãy Liên Hệ Với Chúng Tôi ngay khi quý khách có nhu cầu.
            </p>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ScriptsSection" runat="server">
    <%--<%: Scripts.Render("~/Scripts/facebook.js") %>
    <%: Scripts.Render("~/Scripts/googleplus.js") %>--%>
    <script type="text/javascript" charset="utf-8">
        $(document).ready(function () {
            $("a[rel^='prettyPhoto']").prettyPhoto({ social_tools: false });
        });

    </script>
</asp:Content>
