<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.master" Inherits="System.Web.Mvc.ViewPage<MyStore.App.Models.MyData.Blog>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    <%:Model.blog_title %>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="blog-post-area">
        <h2 class="title text-center"><%:Model.blog_title %></h2>
        <div class="single-blog-post">
            <%--<h3><%:Model.blog_title %></h3>--%>
            <div class="post-meta">
                <ul>
                    <li><i class="fa fa-user"></i>Cao Hoành</li>
                    <li><i class="fa fa-clock-o"></i><%:string.Format("{0:hh:mm tt}", Model.blog_date_create) %></li>
                    <li><i class="fa fa-calendar"></i><%:string.Format("{0:dd, MM, yyyy}", Model.blog_date_create) %></li>
                </ul>
                <%:Html.Partial("_BlogVotePartial", new MyStore.App.ViewModels.BlogVoteViewModel(){TotalScore=Model.blog_total_score, TotalVote=Model.blog_total_vote}) %>
            </div>
            <%: Html.Raw(Model.blog_content) %>
            <div class="pager-area">
                <ul class="pager pull-right">
                    <%if (Model.blog_id > ViewBag.MinId)
                      {%>
                    <li><%:Html.ActionLink("<< Lùi","PrevBlog", new{currentId = Model.blog_id}) %></li>
                    <%} %>
                    <%if (Model.blog_id < ViewBag.MaxId)
                      {%>
                    <li><%:Html.ActionLink("Tới >>","NextBlog", new{currentId = Model.blog_id}) %></li>
                    <%} %>
                </ul>
            </div>
        </div>

        <%ViewBag.RateTitle = "Đánh Giá Bài Viết:";
          ViewBag.RatedCount = Model.blog_total_vote ?? 0;%>
        <%:Html.Partial("_RateObjectPartial") %>

        <table class="socials-share">
            <tr>
                <td class="facebook-like">
                    <a class="fb-like" data-href="<%:Request.Url.AbsoluteUri %>" data-layout="button_count" data-action="like" data-show-faces="true"></a>
                </td>
                <td class="google-plus">
                    <!-- Google + one -->
                    <a class="g-plusone" data-href="<%:Request.Url.AbsoluteUri %>"></a>
                </td>
            </tr>
        </table>
        <!--/socials-share-->

        <div class="media commnets">
            <div class="fb-comments" data-href="<%:Request.Url.AbsoluteUri %>" data-numposts="5"></div>
        </div>
    </div>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="ScriptsSection" runat="server">
    <%: Styles.Render("~/Content/themes/mystyle/jquery.rateyo.css") %>
    <%: Scripts.Render("~/Scripts/jquery.rateyo.js") %>
    <%: Scripts.Render("~/Scripts/facebook.js") %>
    <%: Scripts.Render("~/Scripts/googleplus.js") %>
    <%: Scripts.Render("~/Scripts/rateObject.js") %>

    <script type="text/javascript">
        $(document).ready(function () {
            Rating_Initialize("<%:ViewBag.BlogRate%>",
                              "<%:Model.blog_id%>",
                              "<%:(short)MyStore.App.Models.MyData.VoteType.Blog %>",
                              "<%:Url.Action("VoteTo", "Vote")%>");
        });
    </script>
</asp:Content>
