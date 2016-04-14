<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<MyStore.App.Models.MyData.Ad_Sliders>" %>

<div class="<%: ViewBag.ActiveItem ? "item active" : "item" %>">
    <div class="col-sm-6">
        <h1><span>Hè</span>-FASHION</h1>
        <h2><%:Model.slider_title %></h2>
        <p><%: Model.slider_desc %></p>

        <a class="btn btn-default get" href="<%:Model.slider_link %>">Xem ngay</a>
    </div>
    <div class="col-sm-6">
        <img src="<%:Url.Content(System.IO.Path.Combine("~/Images/home", Model.slider_main_img)) %>" class="girl img-responsive" alt="" />
        <%if (!string.IsNullOrEmpty(Model.slider_sub_img))
          { %>
        <img src="<%:Url.Content(System.IO.Path.Combine("~/Images/home", Model.slider_sub_img)) %>" class="pricing" alt="" />
        <%} %>
    </div>
</div>
