<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<MyStore.App.ViewModels.CheckoutViewModel>" %>
<div class="breadcrumbs">
    <ol class="breadcrumb">
        <li><a href="<%:Url.Action("Index", "Product") %>">Trang Chủ</a></li>
        <li class="active">Tính Tiền</li>
    </ol>
</div>
<!--/breadcrums-->

<div class="step-one">
    <h2 class="heading">Bước 1: Thông Tin Người Đặt Hàng</h2>
</div>
<div class="register-req">
    <p>Xin quý khách vui lòng đăng ký hoặc <b>Đăng nhập bằng tài khoản của website</b> để có thể theo dõi thông tin đơn hàng, hoặc quý khách có thể sử dụng chức năng <b>Không Cần Tài Khoản</b></p>
</div>

<div class="checkout-options">
    <ul class="nav">
        <li>
            <label>
                <input type="radio" id="rdbUsePass" name="IsPassword" <%: Model.IsPassword?"checked='checked'":string.Empty %> />
                Đăng nhập bằng tài khoản của website
            </label>
        </li>
        <li>
            <label>
                <input type="radio" id="rdbUnusePass" name="IsPassword" <%: Model.IsPassword?string.Empty:"checked='checked'" %> />
                Không cần tài khoản của website
            </label>
        </li>

    </ul>
</div>
<!--/checkout-options-->

<div class="shopper-informations">
    <div class="row">
        <div class="col-sm-4 col-sm-offset-1">
            <div class="shopper-info" id="frmOne">
                <%using (Html.BeginForm("AuthenticationMethod", "Checkout", FormMethod.Post))%>
                <%{ %>
                <%:Html.AntiForgeryToken()%>
                <%: Html.ValidationSummary(true)%>

                <%:Html.ValidationMessageFor(m => m.UserName)%>
                <%:Html.TextBoxFor(m => m.UserName, new { @placeholder = Html.DisplayNameFor(m => m.UserName) })%>

                <%:Html.ValidationMessageFor(m => m.Password)%>
                <%:Html.PasswordFor(m => m.Password, new { @placeholder = Html.DisplayNameFor(m => m.Password) })%>

                <input type="hidden" name="IsPassword" value="true" />
                <%:Html.HiddenFor(p => p.CurrentStep)%>

                <button type="submit" class="btn btn-primary">
                    Tiếp tục >>
                </button>
                <%} %>
            </div>
            <div class="shopper-info" id="frmTwo">
                <%using (Html.BeginForm("AuthenticationMethod", "Checkout", FormMethod.Post))%>
                <%{ %>
                <%:Html.AntiForgeryToken()%>
                <%: Html.ValidationSummary(true)%>
                <input type="hidden" name="IsPassword" value="false" />
                <%:Html.HiddenFor(p => p.CurrentStep)%>

                <%:Html.ValidationMessageFor(m => m.UserName)%>
                <%:Html.TextBoxFor(m => m.UserName, new { @placeholder = Html.DisplayNameFor(m => m.UserName) })%>

                <button type="submit" class="btn btn-primary">
                    Tiếp tục >>
                </button>
                <%} %>
            </div>
        </div>

    </div>
    <div class="row">
        <div class="col-sm-4">
            <div class="external-login-form social-icons pull-left">
                <h2>Hoặc đăng nhập với</h2>
                <%:Html.Action("ExternalLoginsList", "Account", new {returnUrl= Url.Action("Index","Checkout")}) %>
            </div>
        </div>

    </div>

</div>
