<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<MyStore.App.ViewModels.BlogVoteViewModel>" %>

<div class="post-meta">
    <ul>
        <li><i class="fa fa-user"></i>Cao Hoành</li>
        <li><i class="fa fa-clock-o"></i><%:string.Format("{0:hh:mm tt}", Model.blog_date_create) %></li>
        <li><i class="fa fa-calendar"></i><%:string.Format("{0:dd, MM, yyyy}", Model.blog_date_create) %></li>
    </ul>
    <span>
        <%float totalStar = ((float)(Model.blog_total_score ?? 0) / (float)(Model.blog_total_vote ?? 1)); %>
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
