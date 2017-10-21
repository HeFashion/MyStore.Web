<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<dynamic>" %>

<div>
    <table>
        <tr>
            <td id="resultMsg">Total <%:ViewBag.TotalImportFiles %> files will be imported.
            </td>
        </tr>
        <tr>
            <td id="progressbar"></td>
        </tr>

    </table>
    <button id="btnSubmit">OK</button>
</div>
<script type="text/javascript">
    $(document).ready(function () {
        $("#progressbar").progressbar({
            value: 0
        });
        $("#btnSubmit").click(function (e) {
            e.preventDefault();
            var intervalID = setInterval(updateProgress, 250);
            $.ajax({
                type: "POST",
                url: "<%:Url.Action("ImportProductAction", "Admin") %>",
                data: "{}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: true,
                success: function (data) {
                    $("#progressbar").progressbar("value", 100);
                    $("#resultMsg").text(data.msg);
                    clearInterval(intervalID);
                }
            });
        });
    });
</script>
