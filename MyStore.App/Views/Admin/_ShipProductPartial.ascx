<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<MyStore.App.ViewModels.ShippingInfoViewModel>" %>
<div>
    <%using (Html.BeginForm("ShipOrdersConfirmed", "Admin"))
      { %>
    <table>
        <tr>
            <td>Ship date:
            </td>
            <td>
                <%:Html.TextBoxFor(model => model.ShipDate, new { @id="shipdate" })%>
            </td>
        </tr>
        <tr>
            <td>Ship code:
            </td>
            <td>
                <%:Html.TextBoxFor(model=>model.ShipCode) %>
            </td>
        </tr>
    </table>
    <input type="submit" value="Save" />
    <%} %>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#shipdate").datepicker();
        });
    </script>
</div>
