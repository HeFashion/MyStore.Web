<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<MyStore.App.Models.Authentication.LocalPasswordModel>" %>


<h2 class="title text-left">Thay Đổi Mật Khẩu</h2>


<div class="manage-form">

    <% using (Ajax.BeginForm("Manage", "Account", new AjaxOptions
       {
           HttpMethod = "POST",
           InsertionMode = InsertionMode.Replace,
           UpdateTargetId = "modalContent",
           OnComplete = "ShowModal()"
       }))
       { %>
    <%: Html.AntiForgeryToken() %>
    <%: Html.ValidationSummary() %>
    <ol>
        <li>
            <%: Html.Label("1. Mật khẩu cũ:") %>
            <%: Html.PasswordFor(m => m.OldPassword) %>
        </li>
        <li>
            <%: Html.Label("2. Mật khẩu mới:") %>
            <%: Html.PasswordFor(m => m.NewPassword) %>
        </li>
        <li>
            <%: Html.Label("3. Nhập lại mật khẩu mới:") %>
            <%: Html.PasswordFor(m => m.ConfirmPassword) %>
        </li>
    </ol>
    <button type="submit" class="btn btn-default">Đổi Mật Khẩu</button>
    <% } %>
</div>

