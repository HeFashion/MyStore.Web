<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.master" Inherits="System.Web.Mvc.ViewPage<PagedList.IPagedList<MyStore.App.Models.MyData.Blog>>" %>

<%@ Import Namespace="PagedList.Mvc" %>

<asp:Content ID="titleContent" ContentPlaceHolderID="TitleContent" runat="server">
    Index
</asp:Content>

<asp:Content ID="mainContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="blog-post-area">
        <h2 class="title text-center">Danh Sách Các Bài Viết</h2>
        <%foreach (var item in Model)
          { %>
        <div class="single-blog-post">
            <h3><%:item.blog_title %></h3>
            <div class="post-meta">
                <ul>
                    <li><i class="fa fa-user"></i>Cao Hoành</li>
                    <li><i class="fa fa-clock-o"></i><%:string.Format("{0:hh:mm tt}", item.blog_date_create) %></li>
                    <li><i class="fa fa-calendar"></i><%:string.Format("{0:dd, MM, yyyy}", item.blog_date_create) %></li>
                </ul>
                <%:Html.Partial("_BlogVotePartial", new MyStore.App.ViewModels.BlogVoteViewModel(){TotalScore=item.blog_total_score, TotalVote=item.blog_total_vote}) %>
            </div>
            <a href="<%: Url.Action("Details", new { id=item.blog_id })%>">
                <img src="<%:Url.Content(System.IO.Path.Combine("~", 
                                                                "Images",
                                                                "blog",
                                                                string.Format("Blog_{0}", item.blog_id), 
                                                                item.blog_img_title)) %>"
                    alt="<%:item.blog_img_title %>">
            </a>
            <p><%:item.blog_description %></p>
            <a class="btn btn-default get" href="<%:Url.Action("Details", new { id=item.blog_id})%>">Read More</a>
        </div>
        <%} %>
        <%:Html.PagedListPager(Model, 
                               page=>Url.Action("Index",
                                                new {page})) %>
    </div>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="ScriptsSection" runat="server">
</asp:Content>
