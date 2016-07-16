<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.master" Inherits="System.Web.Mvc.ViewPage<MyStore.App.Models.MyData.Blog>" %>

<asp:Content ID="indexMeta" ContentPlaceHolderID="MetaContent" runat="server">
    <meta property="og:title" content="<%:Model.blog_title %>" />
    <meta property="og:description" content="<%:Model.blog_description %>" />
    <%var result = string.Empty;
      Uri requestUrl = HttpContext.Current.Request.Url;

      result = string.Format("{0}://{1}{2}",
                             requestUrl.Scheme,
                             requestUrl.Authority,
                             VirtualPathUtility.ToAbsolute(Url.Content(System.IO.Path.Combine("~",
                                                                "Images",
                                                                "blog",
                                                                string.Format("Blog_{0}", Model.blog_id),
                                                                Model.blog_img_title)))); %>
    <meta property="og:image" content="<%: result%>" />
    <meta property="og:url" content="<%:Request.Url.AbsoluteUri%>" />
</asp:Content>
<asp:Content ID="detailTitle" ContentPlaceHolderID="TitleContent" runat="server">
    <%:Model.blog_title %>
</asp:Content>

<asp:Content ID="detailContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="blog-post-area">
        <%:Html.Partial("_BreadCrumbPartial", ViewData["BreadCrumbs"]) %>

        <h2 class="title text-center"><%:Model.blog_title %></h2>
        <div class="single-blog-post">

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
                <ul class="pager">
                    <%if (ViewBag.PrevId != 0)
                      {%>
                    <li class="pull-left">
                        <%:Html.ActionLink("<< Bài cũ", "Details", new { id = ViewBag.PrevId })%>
                    </li>
                    <%} %>
                    <%if (ViewBag.NextId != 0)
                      {%>
                    <li class="pull-right">
                        <%:Html.ActionLink("Bài mới >>","Details", new{id = ViewBag.NextId})%>
                    </li>
                    <%} %>
                </ul>
            </div>
        </div>

        <%ViewBag.RateTitle = "Đánh Giá Bài Viết:";
          ViewBag.RatedCount = Model.blog_total_vote ?? 0;%>
        <%:Html.Partial("_RateObjectPartial") %>
        <!--/socials-share-->
        <table class="socials-share">
            <tr>
                <td class="facebook-like">
                    <a class="fb-like"
                        data-href="<%:Request.Url.AbsoluteUri %>"
                        data-layout="button_count"
                        data-action="like"
                        data-show-faces="true"></a>
                </td>
                <td class="facebook-share">
                    <a class="fb-share-button"
                        data-href="<%:Request.Url.AbsoluteUri %>"
                        data-layout="button_count"></a>
                </td>
                <td class="google-plus">
                    <!-- Google + one -->
                    <a class="g-plusone" data-href="<%:Request.Url.AbsoluteUri %>"></a>
                </td>
            </tr>
        </table>
        <!--/socials-share-->
        <%MyStore.App.Models.MyData.Blog_Actors actor = ViewData["BlogActor"] as MyStore.App.Models.MyData.Blog_Actors; %>
        <%if (actor != null)
          {%>
        <div class="media commnets">
            <a class="pull-left" href="#">
                <img class="media-object" src="<%:Url.Content(System.IO.Path.Combine("~/Images/blog/actor/", actor.actor_image)) %>" alt="<%:actor.actor_name %>">
            </a>
            <div class="media-body">
                <h4 class="media-heading"><%:actor.actor_name %></h4>
                <p>
                    <%:actor.actor_description %>
                </p>
            </div>
        </div>
        <%} %>


        <div class="response-area">
            <div class="fb-comments" data-href="<%:Request.Url.AbsoluteUri %>" data-numposts="5"></div>
        </div>
    </div>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="ScriptsSection" runat="server">
    <%: Styles.Render("~/Content/themes/mystyle/jquery.rateyo.css") %>
    <%: Scripts.Render("~/bundles/blog/details") %>

    <script type="text/javascript">
        $(document).ready(function () {
            Rating_Initialize("<%:ViewBag.BlogRate%>",
                              "<%:Model.blog_id%>",
                              "<%:(short)MyStore.App.Models.MyData.VoteType.Blog %>");
            $("a[rel^='prettyPhoto']").prettyPhoto();
        });
    </script>
</asp:Content>
