<%@ Page Language="C#" MasterPageFile="~/Views/Shared/SubSite.Master" Inherits="System.Web.Mvc.ViewPage<MyStore.App.Models.MyData.User_Advices>" %>

<%@ Import Namespace="BotDetect.Web.Mvc" %>
<asp:Content ID="contactTitle" ContentPlaceHolderID="TitleContent" runat="server">
    Liên lạc | Hè-Vải Sợi
</asp:Content>

<asp:Content ID="contactContent" ContentPlaceHolderID="MainContent" runat="server">
    <div id="contact-page" class="container">
        <%:Html.Partial("_BreadCrumbPartial", ViewData["BreadCrumbs"]) %>

        <div class="bg">
            <div class="row">
                <div class="col-sm-12">
                    <h2 class="title text-center">Địa Điểm Của Chúng Tôi</h2>
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
                            <%: Html.TextBox("SimpleCode8787", "", new { @placeholder = "Nhập vào mã số bên dưới", @class="form-control" })%>
                            <% MvcCaptcha simpleCaptcha = new MvcCaptcha("Captcha1987");
                               simpleCaptcha.UseSmallIcons = true;
                               simpleCaptcha.UserInputID = "SimpleCode8787"; %>
                            <%: Html.Captcha(simpleCaptcha) %>
                        </div>
                        <div class="form-group col-md-12">

                            <%: Html.ValidationMessage("SimpleCode8787") %>
                            <input type="submit" name="submit" class="btn btn-primary pull-right" value="Gửi Góp Ý">
                        </div>
                        <%} %>
                    </div>
                </div>
                <div class="col-sm-4">
                    <div class="contact-info">
                        <h2 class="title text-center">Địa Chỉ</h2>
                        <address>
                            <p>Cửa Hàng <strong>Hè - Vải Sợi</strong></p>
                            <p>ĐC: <%:Convert.ToString(System.Configuration.ConfigurationManager.AppSettings[MyStore.App.Utilities.GeneralContanstClass.PAGE_ADDRESS]) %></p>

                            <p><i class="fa fa-phone"></i>: <%:System.Configuration.ConfigurationManager.AppSettings[MyStore.App.Utilities.GeneralContanstClass.PAGE_PHONE] %></p>
                            <p><i class="fa fa-envelope"></i>: <%:System.Configuration.ConfigurationManager.AppSettings[MyStore.App.Utilities.GeneralContanstClass.PAGE_EMAIL] %></p>
                        </address>
                        <div class="social-networks">
                            <h2 class="title text-center">Liên Kết</h2>
                            <ul>
                                <li><a href="<%:Convert.ToString(System.Configuration.ConfigurationManager.AppSettings[MyStore.App.Utilities.GeneralContanstClass.FACE_BOOK_LINK]) %>"
                                    target="_blank"><i class="fa fa-facebook"></i></a></li>
                                <li><a href="<%:Convert.ToString(System.Configuration.ConfigurationManager.AppSettings[MyStore.App.Utilities.GeneralContanstClass.GOOGLE_PLUS_LINK]) %>"
                                    target="_blank"><i class="fa fa-google-plus"></i></a></li>
                            </ul>
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
