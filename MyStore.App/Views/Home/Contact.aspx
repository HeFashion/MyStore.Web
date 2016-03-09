<%@ Page Language="C#" MasterPageFile="~/Views/Shared/SubSite.Master" Inherits="System.Web.Mvc.ViewPage<MyStore.App.Models.MyData.User_Advices>" %>

<%@ Import Namespace="BotDetect.Web.UI.Mvc" %>
<asp:Content ID="contactTitle" ContentPlaceHolderID="TitleContent" runat="server">
    Liên lạc | Hè-Shopper
</asp:Content>

<asp:Content ID="contactContent" ContentPlaceHolderID="MainContent" runat="server">
    <div id="contact-page" class="container">
        <div class="bg">
            <div class="row">
                <div class="col-sm-12">
                    <h2 class="title text-center">Địa Chỉ <strong>Của Chúng Tôi</strong></h2>
                    <div id="gmap" class="contact-map">
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-sm-8">
                    <div class="contact-form">
                        <h2 class="title text-center">Hộp Thư Góp Ý</h2>
                        <%if (ViewBag.IsDisplayMesg)
                          {%>
                        <div class="status alert alert-success" id="formStatus">Thư góp ý đã được gửi. Cám ơn quý khách.</div>

                        <%} %>
                        <%using (Html.BeginForm("OfferAdvice", "Home", FormMethod.Post, new { @class = "contact-form row", @name = "contact-form" }))%>
                        <%{ %>
                        <%:Html.AntiForgeryToken()%>

                        <div class="form-group col-md-6">
                            <%:Html.ValidationMessageFor(model => model.user_name) %>
                            <%:Html.TextBoxFor(model => model.user_name, new { @class = "form-control", @required = "required", @placeholder = "Tên" })%>
                        </div>
                        <div class="form-group col-md-6">
                            <%:Html.ValidationMessageFor(model => model.user_mail) %>
                            <%:Html.TextBoxFor(model => model.user_mail, new { @class = "form-control", @required = "required", @placeholder = "Email" })%>
                        </div>
                        <div class="form-group col-md-12">
                            <%:Html.ValidationMessageFor(model => model.advise_subject) %>

                            <%:Html.TextBoxFor(model => model.advise_subject, new { @class = "form-control", @required = "required", @placeholder = "Tiêu đề" })%>
                        </div>
                        <div class="form-group col-md-12">
                            <%:Html.ValidationMessageFor(model => model.advise_body) %>
                            <%:Html.TextAreaFor(model => model.advise_body, new { @id="message", @required="required" ,@class="form-control" ,@rows="8" ,@placeholder="Lời nhắn của bạn"})%>
                        </div>
                        <div class="form-group col-md-6">
                            <%: Html.TextBox("CaptchaCode", "", new { @placeholder = "Nhập vào mã số bên dưới", @class="form-control" })%>
                            <% MvcCaptcha simpleCaptcha = new MvcCaptcha("SimpleCaptcha");
                               simpleCaptcha.UseSmallIcons = true;
                               simpleCaptcha.UserInputClientID = "CaptchaCode"; %>
                            <%: Html.Captcha(simpleCaptcha) %>
                        </div>
                        <div class="form-group col-md-12">

                            <%: Html.ValidationMessage("CaptchaCode") %>
                            <input type="submit" name="submit" class="btn btn-primary pull-right" value="Gửi Góp Ý">
                        </div>
                        <%} %>
                        <%--<form id="main-contact-form" class="contact-form row" name="contact-form" method="post">
                        </form>--%>
                    </div>
                </div>
                <div class="col-sm-4">
                    <div class="contact-info">
                        <h2 class="title text-center">Địa Chỉ Liên Lạc</h2>
                        <address>
                            <p>Cửa Hàng Vải Hè</p>
                            <p>Đường Lê Duẩn, tổ 12, khu Phước Hải, TT. Long Thành, Đồng Nai</p>
                            <p>Đối diện Ủy Ban Nhân Dân TT.Long Thành</p>
                            <p>Mobile: +84 933 24 36 88</p>
                            <p>Email: nhamayhe@gmail.com</p>
                        </address>
                        <div class="social-networks">
                            <h2 class="title text-center">Mạng Xã Hội</h2>
                            <%:Html.Action("ExternalLoginsList", "Account", new {returnUrl= ViewBag.ReturnUrl}) %>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="googlemapScript" ContentPlaceHolderID="ScriptsSection" runat="server">
    <link href="<%: Url.Content("~/" + BotDetect.Web.CaptchaUrls.Absolute.LayoutStyleSheetUrl) %>"
        rel="stylesheet" type="text/css" />

    <script type="text/javascript" src="http://maps.google.com/maps/api/js"></script>
    <%:Scripts.Render("~/bundles/contact") %>
</asp:Content>
