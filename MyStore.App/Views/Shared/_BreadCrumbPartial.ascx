<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<System.Collections.Generic.IDictionary<string, string>>" %>
<div class="breadcrumbs">
    <ol class="breadcrumb">
        <li>
            <a href="<%:Url.Action("Index", "Home") %>">
                <i class="fa fa-home"></i>
            </a>
        </li>
        <%foreach (var item in Model.Keys)
          { %>

        <li class="<%:string.IsNullOrEmpty(Model[item])?"active":string.Empty %>">
            <%if (!string.IsNullOrEmpty(Model[item]))
              { %>
            <a href="<%:Model[item] %>">
                <%:item %>
            </a>
            <%} %>
            <%else
              {%>
            <%:item %>
            <%} %>
        </li>

        <%} %>
    </ol>
</div>
