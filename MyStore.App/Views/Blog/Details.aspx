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
            <%: Html.Raw(Model.blog_content) %>
            <div class="pager-area">
                <ul class="pager pull-right">
                    <%if (Model.blog_id > ViewBag.MinId)
                      {%>
                    <li><%:Html.ActionLink("Lùi","PrevBlog", new{currentId = Model.blog_id}) %></li>
                    <%} %>
                    <%if (Model.blog_id < ViewBag.MaxId)
                      {%>
                    <li><%:Html.ActionLink("Tới","NextBlog", new{currentId = Model.blog_id}) %></li>
                    <%} %>
                </ul>
            </div>
        </div>

        <div class="rating-area">
            <ul class="ratings">
                <li class="rate-this">Điểm của bạn:</li>
                <li>
                    <div id="rateit" />
                </li>
                <li class="color"><%:string.Format("({0} votes)", Model.blog_total_vote) %></li>
            </ul>
            <%-- <ul class="tag">
                <li>TAG:</li>
                <li><a class="color" href="">Pink <span>/</span></a></li>
                <li><a class="color" href="">T-Shirt <span>/</span></a></li>
                <li><a class="color" href="">Girls</a></li>
            </ul>--%>
        </div>
    </div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="ScriptsSection" runat="server">
    <%:Styles.Render("~/Content/themes/mystyle/jquery.rateyo.css") %>
    <%:Scripts.Render("~/Scripts/jquery.rateyo.js") %>

    <script type="text/javascript">
        $(document).ready(function () {

            var rateControl = $("#rateit").rateYo({
                fullStar: true,
                starWidth: "15px",
                rating: "<%:((float)(Model.blog_total_score ?? 0) / (float)(Model.blog_total_vote ?? 1))%>"
            })

            rateControl.on("rateyo.set", function (e, data) {
                alert("The rating is set to " + data.rating + "!");
            });
        });
    </script>
</asp:Content>
