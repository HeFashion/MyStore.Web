<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<MyStore.App.Models.Authentication.LocalPasswordModel>" %>


<div class="modal-content">
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="title text-center">Xin chào! <strong><%: ViewBag.UserName %></strong></h4>
    </div>
    <div class="modal-body">
        <p class="message-success"><%: (string)ViewBag.StatusMessage %></p>

        <% if (ViewBag.HasLocalPassword)
           {
               Html.RenderPartial("_ChangePasswordPartial");
           }
           else
           {
               Html.RenderPartial("_SetPasswordPartial");
           } %>

        <section id="externalLogins">
            <%: Html.Action("RemoveExternalLogins") %>

            <h3>Thêm vào tài khoản khác:</h3>
            <%: Html.Action("ExternalLoginsList", 
                            new { ReturnUrl = ViewBag.ReturnUrl }) %>
        </section>
    </div>
</div>
