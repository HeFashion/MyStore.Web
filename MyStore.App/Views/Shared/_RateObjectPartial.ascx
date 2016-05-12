<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<dynamic>" %>

<div class="rating-area">
    <ul class="ratings">
        <li class="rate-this"><%:ViewBag.RateTitle %></li>
        <li>
            <div id="rateit" />
        </li>
        <li class="color"><%:string.Format("({0} votes)", ViewBag.RatedCount) %></li>
    </ul>
    <%-- <ul class="tag">
                <li>TAG:</li>
                <li><a class="color" href="">Pink <span>/</span></a></li>
                <li><a class="color" href="">T-Shirt <span>/</span></a></li>
                <li><a class="color" href="">Girls</a></li>
            </ul>--%>
</div>
