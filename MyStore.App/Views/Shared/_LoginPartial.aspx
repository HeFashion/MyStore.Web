﻿<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>

<ul class="nav navbar-nav">
    <li>
        <a href="<%:Url.Action("Index", "Cart", new { returnUrl=string.IsNullOrEmpty(ViewBag.ReturnUrl)?HttpContext.Current.Request.RawUrl: ViewBag.ReturnUrl})%>">
            <i class="fa fa-shopping-cart"></i>Giỏ hàng
        </a>
    </li>
    <%if (Request.IsAuthenticated)%>
    <%{ %>
    <li class="btn-group">
        <button type="button" class="btn btn-default dropdown-toggle user-account" data-toggle="dropdown">
            Xin chào, 
            <%if (User.Identity.Name.Contains('@'))
              { %>
            <%:User.Identity.Name.Substring(0,  User.Identity.Name.LastIndexOf('@'))%>
            <%} %>
            <%else
              {%>
            <%:User.Identity.Name %>

            <%}%>

            <span class="caret"></span>
        </button>
        <ul class="dropdown-menu">
            <li>
                <%: Ajax.ActionLink("Quản lý tài khoản", 
                                    "Manage",
                                    "Account", 
                                    new AjaxOptions{
                                        HttpMethod="Get", 
                                        InsertionMode=InsertionMode.Replace, 
                                        UpdateTargetId="modalContent", 
                                        OnComplete="ShowModal()"}) %>
            </li>
            <li>
                <% using (Html.BeginForm("LogOff", "Account", FormMethod.Post, new { id = "logoutForm" }))
                   { %>
                <%: Html.AntiForgeryToken() %>
                <a href="javascript:document.getElementById('logoutForm').submit()">Đăng xuất</a>
                <% } %>
            </li>
        </ul>
    </li>

    <% }
      else
      { %>
    <li>
        <a href="<%:Url.Action("Login", "Account", new { returnUrl=string.IsNullOrEmpty(ViewBag.ReturnUrl)?HttpContext.Current.Request.RawUrl: ViewBag.ReturnUrl })%>" id="loginLink">
            <i class="fa fa-lock"></i>Đăng nhập
        </a>
    </li>
    <li>
        <a href="<%:Url.Action("Register","Account") %>" id="registerLink">
            <i class="fa fa-key"></i>Đăng ký
        </a>
    </li>

    <% } %>
</ul>
