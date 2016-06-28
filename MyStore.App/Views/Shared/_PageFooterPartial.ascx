<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<dynamic>" %>
<footer id="footer">
    <!--Footer-->
    <div class="footer-top">
        <div class="container">
            <div class="row">
                <div class="col-sm-2">
                    <div class="companyinfo">
                        <h2><span>Hè</span>-Vải Sợi</h2>
                        <p>
                            <strong>Số ĐKKD - MST: 8082286746 do UBND Huyện Long Thành, T. Đồng Nai, cấp ngày 28/07/2015</strong>
                        </p>
                        <p>
                            <strong>Địa Chỉ: <%:Convert.ToString(System.Configuration.ConfigurationManager.AppSettings[MyStore.App.Utilities.GeneralContanstClass.PAGE_ADDRESS]) %></strong>
                        </p>
                    </div>
                </div>
                <div class="col-sm-7">
                    <%var footerList = this.Session[MyStore.App.Utilities.GeneralContanstClass.Blog_Footer_Session_Key] as List<MyStore.App.ViewModels.FooterBlogListViewModel>;%>
                    <%if (footerList != null && footerList.Count > 0)
                      {%>
                    <%foreach (var item in footerList)
                      { %>
                    <div class="col-sm-3">
                        <div class="video-gallery text-center">
                            <a href="<%:Url.Action("Details", "Blog", new { id=item.Id })%>">
                                <div class="iframe-img">
                                    <img src="<%:Url.Content(string.Format("~/Images/blog/Blog_{0}/iframe.jpg", item.Id)) %>" alt="" />
                                </div>
                            </a>
                            <p><%:item.Title %></p>
                            <h2><%:string.Format("{0:dd, MM, yyyy}", item.CreatedDate) %></h2>
                        </div>
                    </div>

                    <%} %>
                    <%} %>
                </div>
                <div class="col-sm-3">
                    <div class="address">
                        <a href="<%:Convert.ToString(System.Configuration.ConfigurationManager.AppSettings[MyStore.App.Utilities.GeneralContanstClass.PAGE_GOV]) %>" target="_blank">
                            <img src="<%:Url.Content("~/Images/bo_cong_thuong.png") %>" alt="" />
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <%--<div class="footer-widget">
        <div class="container">
            <div class="row">
                <div class="col-sm-2">
                    <div class="single-widget">
                        <h2>Service</h2>
                        <ul class="nav nav-pills nav-stacked">
                            <li><a href="#">Online Help</a></li>
                            <li><a href="#">Contact Us</a></li>
                            <li><a href="#">Order Status</a></li>
                            <li><a href="#">Change Location</a></li>
                            <li><a href="#">FAQ’s</a></li>
                        </ul>
                    </div>
                </div>
                <div class="col-sm-2">
                    <div class="single-widget">
                        <h2>Quock Shop</h2>
                        <ul class="nav nav-pills nav-stacked">
                            <li><a href="#">T-Shirt</a></li>
                            <li><a href="#">Mens</a></li>
                            <li><a href="#">Womens</a></li>
                            <li><a href="#">Gift Cards</a></li>
                            <li><a href="#">Shoes</a></li>
                        </ul>
                    </div>
                </div>
                <div class="col-sm-2">
                    <div class="single-widget">
                        <h2>Policies</h2>
                        <ul class="nav nav-pills nav-stacked">
                            <li><a href="#">Terms of Use</a></li>
                            <li><a href="#">Privecy Policy</a></li>
                            <li><a href="#">Refund Policy</a></li>
                            <li><a href="#">Billing System</a></li>
                            <li><a href="#">Ticket System</a></li>
                        </ul>
                    </div>
                </div>
                <div class="col-sm-2">
                    <div class="single-widget">
                        <h2>About Shopper</h2>
                        <ul class="nav nav-pills nav-stacked">
                            <li><a href="#">Company Information</a></li>
                            <li><a href="#">Careers</a></li>
                            <li><a href="#">Store Location</a></li>
                            <li><a href="#">Affillate Program</a></li>
                            <li><a href="#">Copyright</a></li>
                        </ul>
                    </div>
                </div>
                <div class="col-sm-3 col-sm-offset-1">
                    <div class="single-widget">
                        <h2>About Shopper</h2>
                        <form action="#" class="searchform">
                            <input type="text" placeholder="Your email address" />
                            <button type="submit" class="btn btn-default"><i class="fa fa-arrow-circle-o-right"></i></button>
                            <p>Get the most recent updates from
                                <br />
                                our site and be updated your self...</p>
                        </form>
                    </div>
                </div>

            </div>
        </div>
    </div>--%>

    <div class="footer-bottom">
        <div class="container">
            <div class="row">
                <p class="pull-left">Developed by <span><a target="_blank" href="https://www.facebook.com/hoanh.cao.9">Cao Văn Hoành</a></span> </p>
                <p class="pull-right">Designed by <span><a target="_blank" href="http://www.themeum.com">Themeum</a></span></p>
            </div>
        </div>
    </div>

</footer>
<%--<footer id="footer">
    <!--Footer-->
    <%--  <div class="footer-top">
        <div class="container">
            <div class="row">
                <div class="col-sm-2">
                    <div class="companyinfo">
                        <h2><span>e</span>-shopper</h2>
                        <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit,sed do eiusmod tempor</p>
                    </div>
                </div>
                <div class="col-sm-7">
                    <div class="col-sm-3">
                        <div class="video-gallery text-center">
                            <a href="#">
                                <div class="iframe-img">
                                    <img src="images/home/iframe1.png" alt="" />
                                </div>
                                <div class="overlay-icon">
                                    <i class="fa fa-play-circle-o"></i>
                                </div>
                            </a>
                            <p>Circle of Hands</p>
                            <h2>24 DEC 2014</h2>
                        </div>
                    </div>

                    <div class="col-sm-3">
                        <div class="video-gallery text-center">
                            <a href="#">
                                <div class="iframe-img">
                                    <img src="images/home/iframe2.png" alt="" />
                                </div>
                                <div class="overlay-icon">
                                    <i class="fa fa-play-circle-o"></i>
                                </div>
                            </a>
                            <p>Circle of Hands</p>
                            <h2>24 DEC 2014</h2>
                        </div>
                    </div>

                    <div class="col-sm-3">
                        <div class="video-gallery text-center">
                            <a href="#">
                                <div class="iframe-img">
                                    <img src="images/home/iframe3.png" alt="" />
                                </div>
                                <div class="overlay-icon">
                                    <i class="fa fa-play-circle-o"></i>
                                </div>
                            </a>
                            <p>Circle of Hands</p>
                            <h2>24 DEC 2014</h2>
                        </div>
                    </div>

                    <div class="col-sm-3">
                        <div class="video-gallery text-center">
                            <a href="#">
                                <div class="iframe-img">
                                    <img src="images/home/iframe4.png" alt="" />
                                </div>
                                <div class="overlay-icon">
                                    <i class="fa fa-play-circle-o"></i>
                                </div>
                            </a>
                            <p>Circle of Hands</p>
                            <h2>24 DEC 2014</h2>
                        </div>
                    </div>
                </div>
                <div class="col-sm-3">
                    <div class="address">
                        <img src="images/home/map.png" alt="" />
                        <p>505 S Atlantic Ave Virginia Beach, VA(Virginia)</p>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="footer-widget">
        <div class="container">
            <div class="row">
                <div class="col-sm-2">
                    <div class="companyinfo">
                        <h2><span>Hè</span>-Vải Sợi</h2>
                        <h5>Vui lòng khách đến, vừa lòng khách đi</h5>
                    </div>
                </div>
                <div class="col-sm-2">
                    <div class="single-widget">
                        <h2>Quock Shop</h2>
                        <ul class="nav nav-pills nav-stacked">
                            <li><a href="">T-Shirt</a></li>
                            <li><a href="">Mens</a></li>
                            <li><a href="">Womens</a></li>
                            <li><a href="">Gift Cards</a></li>
                            <li><a href="">Shoes</a></li>
                        </ul>
                    </div>
                </div>
                <div class="col-sm-2">
                    <div class="single-widget">
                        <h2>Nội Quy</h2>
                        <ul class="nav nav-pills nav-stacked">
                            <li><a href="#">Hướng Dẫn Sử Dụng</a></li>
                            <li><a href="#">Quy Tắc Sử Dụng</a></li>
                            <li><a href="#">Quy Tắc Đổi Trả Hàng</a></li>
                        </ul>
                    </div>
                </div>
                <div class="col-sm-2">
                    <div class="single-widget">
                        <h2>Về Nhà May Hè</h2>
                        <ul class="nav nav-pills nav-stacked">
                            <li><a href="<%:Url.Action("About","Home") %>">Giới Thiệu</a></li>
                            <li><a href="<%:Url.Action("Contact","Home") %>">Chi Tiết Liên Lạc</a></li>
                        </ul>
                    </div>
                </div>
              <div class="col-sm-3 col-sm-offset-1">
                    <div class="single-widget">
                        <h2>About Shopper</h2>
                        <form action="#" class="searchform">
                            <input type="text" placeholder="Your email address" />
                            <button type="submit" class="btn btn-default"><i class="fa fa-arrow-circle-o-right"></i></button>
                            <p>Get the most recent updates from
                                <br />
                                our site and be updated your self...</p>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="footer-bottom">
        <div class="container">
            <div class="row">
                <p class="pull-left">Developed by CAO VAN HOANH.</p>
                <p class="pull-right">Designed by <span><a target="_blank" href="http://www.themeum.com">Themeum</a></span></p>
            </div>
        </div>
    </div>

</footer>--%>
