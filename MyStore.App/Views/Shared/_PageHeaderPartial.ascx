<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<dynamic>" %>
<div id="fb-root"></div>
<header id="header">
    <!--header_top-->
    <div class="header_top">
        <div class="container">
            <div class="row">
                <div class="col-sm-6 ">
                    <div class="contactinfo">
                        <ul class="nav nav-pills">
                            <li><a href="#"><i class="fa fa-phone"></i>0933 243 688</a></li>
                            <% var strEmail = System.Configuration.ConfigurationManager.AppSettings[MyStore.App.Utilities.GeneralContanstClass.PAGE_EMAIL]; %>
                            <li><a href="<%:string.Format("mailto:{0}", strEmail) %>"><i class="fa fa-envelope"></i><%:strEmail%></a></li>
                        </ul>
                    </div>
                </div>
                <div class="col-sm-6">
                    <div class="social-icons pull-right">
                        <ul class="nav navbar-nav">
                            <li><a href="#"><i class="fa fa-facebook"></i></a></li>
                            <li><a href="#"><i class="fa fa-google-plus"></i></a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--/header_top-->

    <!--header-middle-->
    <div class="header-middle">

        <div class="container">
            <div class="row">
                <div class="col-sm-4">
                    <div class="logo pull-left">
                        <a href="<%:Url.Action("Index", "Home") %>">
                            <img src="<%: Url.Content("~/Images/home/logo.png") %>" alt="" />
                        </a>
                    </div>
                </div>

                <div class="col-sm-8" style="left: 0px; top: 0px">
                    <div class="shop-menu pull-right">
                        <%:Html.Partial("_LoginPartial") %>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--/header-middle-->

    <!--header-bottom-->
    <div class="header-bottom">
        <div class="container">
            <div class="row">
                <div class="col-sm-9">
                    <div class="navbar-header">
                        <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                            <span class="sr-only">Toggle navigation</span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                        </button>
                    </div>
                    <div class="mainmenu pull-left">
                        <ul class="nav navbar-nav collapse navbar-collapse">
                            <li><%: Html.ActionLink("Trang Chủ","Index", "Home" ) %></li>
                            <li><%: Html.ActionLink("Bài Viết","Index", "Blog") %></li>
                            <li><%: Html.ActionLink("Giới Thiệu","About", "Home" ) %></li>
                            <li><%: Html.ActionLink("Địa Điểm", "Contact", "Home") %></li>
                            <%if (Request.IsAuthenticated)
                              {%>
                            <li><%: Html.ActionLink("Quản Lý Đơn Hàng", "Index", "Order" )%></li>
                            <%} %>
                        </ul>
                    </div>
                </div>
                <div class="col-sm-3">
                    <div class="search_box pull-right">
                        <%using (Html.BeginForm("Index", "Product", FormMethod.Get, new { @id = "frmSearch" }))
                          { %>
                        <%:Html.TextBox("searchString", string.Empty, new { @placeholder = "Tìm kiếm theo mã" })%>
                        <a href="javascript:document.getElementById('frmSearch').submit()">
                            <img src="<%:Url.Content("~/Images/searchicon.png") %>" />
                        </a>
                        <%} %>
                    </div>
                </div>
            </div>
            
        </div>
    </div>
    <!--header-bottom-->
</header>
<!-- Modal -->
<div id="myModal" class="modal fade" role="dialog" data-url="<%:Url.Action("ShowCompletedAddToCart","Product") %>">
    <div id="modalContent" class="modal-dialog">
    </div>
</div>
