﻿<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<MyStore.App.Models.Authentication.LocalPasswordModel>" %>

<p>
    Quý khách vẫn chưa có mật khẩu nội bộ của website. 
    Vui lòng thiết lập mật khẩu để có thể đăng nhập mà không cần xử dụng mạng xã hội.
</p>

<h2 class="title text-left">Thiết lập mật khẩu</h2>

<div class="manage-form">
    <% using (Html.BeginForm("Manage", "Account"))
       { %>
    <%: Html.AntiForgeryToken() %>
    <%: Html.ValidationSummary() %>

    <ol>
        <li>
            <%: Html.Label("1. Mật khẩu mới") %>
            <%: Html.PasswordFor(m => m.NewPassword) %>
        </li>
        <li>
            <%: Html.Label("2. Nhập lại mật khẩu mới") %>
            <%: Html.PasswordFor(m => m.ConfirmPassword) %>
        </li>
    </ol>
    <button type="submit" class="btn btn-default">Thiết Lập</button>
    <% } %>
</div>
