<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<dynamic>" %>

<div>
    <table>
        <tr>
            <td id="resultMsg">Select Your File:
            </td>
        </tr>
        <tr>
            <td>
                <input type="file" id="inputExcel"
                    accept="*.csv, application/vnd.openxmlformats-officedocument.spreadsheetml.sheet, application/vnd.ms-excel" />

                <div id="progressbar"></div>
            </td>
        </tr>

    </table>
    <a href="#" id="btnSubmit">OK</a>
    <a href="#" id="btnClose" style="display: none">Close</a>

</div>
<script type="text/javascript">
    $(document).ready(function () {
        $("#progressbar").progressbar({
            value: 0
        }).hide();
        $("#btnClose").button().click(function (e) {
            CloseDialog();
        });
        $("#btnSubmit").button().click(function (e) {
            var myFile = $("#inputExcel").prop('files');
            if (myFile[0] == null)
                alert("No file is selected");
            else {
                var file = myFile[0];
                name = file.name;
                size = file.size;

                if (file.size > 100000) {
                    alert("The file is too big");
                }
                else if (file.type != '.csv' &&
                         file.type != 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet' &&
                         file.type != 'application/vnd.ms-excel') {
                    alert("The file is not Excel file.");
                }
                else {
                    $("#inputExcel").hide()
                    $("#progressbar").show();

                    var intervalID = setInterval(updateProgress, 250);
                    var formData = new FormData();
                    formData.append('file', file);
                    $.ajax({
                        url: '<%:Url.Action("ImportExcelAction","Admin")%>',
                        type: 'POST',
                        data: formData,
                        processData: false,
                        contentType: false,
                        success: function (data) {
                            $("#resultMsg").text(data.msg);
                            $("#btnSubmit").hide();
                            $("#btnClose").show();
                            $("#progressbar").progressbar("value", 100);
                            clearInterval(intervalID);
                        }
                    });
                }
        }
        });
    });
</script>
