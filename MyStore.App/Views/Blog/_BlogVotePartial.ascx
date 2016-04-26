<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<MyStore.App.ViewModels.BlogVoteViewModel>" %>

<span id="voteArea">
    <%float totalStar = Model.Average; %>
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
