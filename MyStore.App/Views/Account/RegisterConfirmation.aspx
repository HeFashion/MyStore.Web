<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/SubSite.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="registerConfirmationTitle" ContentPlaceHolderID="TitleContent" runat="server">
    Xác Nhận | Hè-Vải Sợi
</asp:Content>

<asp:Content ID="registerConfirmationContent" ContentPlaceHolderID="MainContent" runat="server">
    <section id="do_action">
        <div class="container">
            <div class="row">
                <div class="col-sm-6">
                    <div class="signup-form">
                        <h2><%:ViewBag.Title %></h2>

                        <%:Html.Raw(ViewBag.Message) %>
                    </div>
                </div>
            </div>
        </div>
    </section>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="ScriptsSection" runat="server">
</asp:Content>
