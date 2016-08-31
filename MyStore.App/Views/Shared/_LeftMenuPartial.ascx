<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<dynamic>" %>
<div class="left-sidebar">
    <div class="mini-submenu">
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
    </div>
    <div id="accordian" class="list-group category-products">
        <span class="list-group-item header">Phân Loại
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

        <div class="panel panel-default">
            <div class="panel-heading">
                <h4 class="panel-title">
                    <%if (menuItem.ChildMenu == null ||
                          menuItem.ChildMenu.Count <= 0)
                      { %>
                    <%ViewBag.IsChild = false; %>
                    <%:Html.Partial("_LeftMenuItemPartial", menuItem) %>
                    <%}
                      else
                      {%>
                    <a data-toggle="collapse"
                        data-parent="#accordian"
                        href="<%:string.Format("#collapsible-{0}", menuItem.MenuId) %>">
                        <span class="badge pull-right"><i class="fa fa-plus"></i></span>
                        <%:menuItem.MenuDesc %>
                    </a>
                    <%}%>
                    
                </h4>
            </div>
            <%if (menuItem.ChildMenu != null &&
                  menuItem.ChildMenu.Count > 0)
              { %>

            <div id="<%:string.Format("collapsible-{0}", menuItem.MenuId) %>" class="collapse panel-collapse">
                <div class="panel-body">
                    <ul>
                        <%foreach (var childMenu in menuItem.ChildMenu)
                          {%>
                        <li>

                            <%ViewBag.IsChild = true; %>
                            <%:Html.Partial("_LeftMenuItemPartial", childMenu) %>
                        </li>
                        <%} %>
                    </ul>
                </div>
            </div>
            <%} %>
        </div>
        <%} %>
        <!--shipping-->
        <div id="shippingImg" class="shipping text-center">
            <img src="<%: Url.Content("~/Images/home/shipping.jpg") %>" alt="" />
        </div>
        <!--/shipping-->
    </div>


</div>
