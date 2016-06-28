<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<dynamic>" %>
<div class="left-sidebar">
    <div class="mini-submenu">
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
    </div>
    <div class="list-group">
        <span class="list-group-item active">Phân Loại
            <%if (Request.Browser.IsMobileDevice &&
                  MyStore.App.Utilities.DeviceHelper.IsSmartPhone(Request.UserAgent))
              {%>
            
            <span class="pull-right" id="slide-submenu">
                <i class="fa fa-times"></i>
            </span>
            <%} %>

        </span>
        <%IList<MyStore.App.Models.Menu> myMenu = this.Session[MyStore.App.Utilities.GeneralContanstClass.Menu_Session_Key] as List<MyStore.App.Models.Menu>; %>
        <%if (myMenu == null)
          {
              myMenu = MyStore.App.Models.MyMenu.BuildMenu();
          } %>
        <%foreach (var menuItem in myMenu)
          {%>
        <a href="<%:Url.Action("Index", 
                               "Product", 
                               new { prodType=menuItem.MenuId },
                               null) %>"
            class="list-group-item">
            <%:menuItem.MenuDesc %>
            <span class="badge"><%:menuItem.TotalProduct %></span>
        </a>
        <%} %>
        <!--shipping-->
        <div id="shippingImg" class="shipping text-center">
            <img src="<%: Url.Content("~/Images/home/shipping.jpg") %>" alt="" />
        </div>
        <!--/shipping-->
    </div>


</div>
