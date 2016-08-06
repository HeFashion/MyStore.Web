<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<dynamic>" %>

<img id="detailImg"
    src="<%:Url.Content(System.IO.Path.Combine("~/Images/shop",ViewBag.FolderName, ViewBag.DetailImg)) %>"
    alt="<%:ViewBag.DetailImg %>"
    data-zoom-image="<%:Url.Content(System.IO.Path.Combine("~/Images/shop", ViewBag.FolderName,ViewBag.OriginalImg)) %>"
    style="display: none" />

