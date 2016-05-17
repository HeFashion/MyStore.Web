<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    <title>Login Failed</title>
    <%: Styles.Render("~/Content/themes/mystyle/css") %>
    <!--[if lt IE 9]>
    <script src="js/html5shiv.js"></script>
    <script src="js/respond.min.js"></script>
    <![endif]-->
    <link rel="shortcut icon" href="images/ico/favicon.ico">
    <link rel="apple-touch-icon-precomposed" sizes="144x144" href="images/ico/apple-touch-icon-144-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="114x114" href="images/ico/apple-touch-icon-114-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="72x72" href="images/ico/apple-touch-icon-72-precomposed.png">
    <link rel="apple-touch-icon-precomposed" href="images/ico/apple-touch-icon-57-precomposed.png">
</head>
<!--/head-->

<body>
    <div class="container text-center">
        <div class="logo-404">
            <a href="index.html">
                <img src="<%:Url.Content("~/images/home/logo.png") %>" alt="" /></a>
        </div>
        <div class="content-404">
            <img src="images/404/404.png" class="img-responsive" alt="" />
            <h1><b>OPPS!</b> Không thể Đăng Nhập</h1>
            <p>Có lỗi trong qua trình đăng nhập. Vui lòng thử lại sau.</p>
            <h2><%:Html.ActionLink("Quay lại trang chủ","Index", "Home") %></h2>
        </div>
    </div>
</body>
</html>
