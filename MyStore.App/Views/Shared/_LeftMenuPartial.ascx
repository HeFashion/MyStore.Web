<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<dynamic>" %>
<div class="mini-submenu">
    <span class="icon-bar"></span>
    <span class="icon-bar"></span>
    <span class="icon-bar"></span>
</div>

<div class="left-sidebar">

    <div id="accordian" class="list-group category-products">
        <%if (Request.Browser.IsMobileDevice &&
                  MyStore.App.Utilities.DeviceHelper.IsSmartPhone(Request.UserAgent))
          {%>

        <span class="pull-right" id="slide-submenu">
            <i class="fa fa-angle-double-left" aria-hidden="true"></i>
        </span>
        <%} %>
        <span class="list-group-item header">
            <i class="fa fa-tags" aria-hidden="true"></i>
            Các loại vải sợi
        </span>
        <%IList<MyStore.App.ViewModels.ProductTypeModel> myMenu = this.Session[MyStore.App.Utilities.GeneralContanstClass.Menu_Session_Key] as List<MyStore.App.ViewModels.ProductTypeModel>; %>
        <%if (myMenu == null)
          {
              myMenu = MyStore.App.Models.MyMenu.BuildMenu();
          } %>
        <%foreach (var menuItem in myMenu)
          {%>

        <div class="panel panel-default">
            <div class="panel-heading">
                <h4 class="panel-title">
                    <%if (menuItem.ChildType == null ||
                          menuItem.ChildType.Count <= 0)
                      { %>
                    <%ViewBag.IsChild = false; %>
                    <%:Html.Partial("_LeftMenuItemPartial", menuItem) %>
                    <%}
                      else
                      {%>
                    <a data-toggle="collapse"
                        data-parent="#accordian"
                        href="<%:string.Format("#collapsible-{0}", menuItem.TypeId) %>">
                        <span class="badge pull-right"><i class="fa fa-plus"></i></span>
                        <%:menuItem.TypeDesc %>
                    </a>
                    <%}%>
                    
                </h4>
            </div>
            <%if (menuItem.ChildType != null &&
                  menuItem.ChildType.Count > 0)
              { %>

            <div id="<%:string.Format("collapsible-{0}", menuItem.TypeId) %>" class="collapse panel-collapse">
                <div class="panel-body">
                    <ul>
                        <%foreach (var childMenu in menuItem.ChildType)
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
    </div>
    <!--facebook page-->
    <div class="facebook-page">

        <h2>Facebook Page</h2>
        <div class="fb-page" data-href="https://www.facebook.com/hevaisoi/" data-small-header="false" data-adapt-container-width="true" data-hide-cover="false" data-show-facepile="true">
            <blockquote cite="https://www.facebook.com/hevaisoi/" class="fb-xfbml-parse-ignore"><a href="https://www.facebook.com/hevaisoi/">Hè Vải Sợi</a></blockquote>
        </div>
    </div>
    <!--/facebook page-->

    <!--shipping-->
    <div id="shippingImg" class="shipping text-center">
        <img src="<%: Url.Content("~/Images/home/shipping.jpg") %>" alt="" />
    </div>
    <!--/shipping-->

</div>
