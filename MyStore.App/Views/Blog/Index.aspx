﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.master" Inherits="System.Web.Mvc.ViewPage<IEnumerable<MyStore.App.Models.MyData.Blog>>" %>

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
                <span>
                    <%float totalStar = ((float)(item.blog_total_score ?? 0) / (float)(item.blog_total_vote ?? 1)); %>
                    <%for (int i = 0; i < 5; i++)
                      {%>
                    <%if (totalStar > 0.5)
                      { %>
                    <i class="fa fa-star"></i>
                    <%} %>
                    <%else if (totalStar == 0.5)
                      { %>
                    <i class="fa fa-star-half-o"></i>
                    <%} %>
                    <%else
                      { %>
                    <i class="fa fa-star-o"></i>
                    <%} %>
                    <%totalStar -= 1; %>
                    <%} %> 
                </span>
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

        <div class="pagination-area">
            <ul class="pagination">
                <li><a href="" class="active">1</a></li>
                <li><a href="">2</a></li>
                <li><a href="">3</a></li>
                <li><a href=""><i class="fa fa-angle-double-right"></i></a></li>
            </ul>
        </div>
    </div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="ScriptsSection" runat="server">
</asp:Content>
