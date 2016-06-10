function OpenDialog(h, w) {
    $("#myModal").dialog({
        height: h,
        width: w,
    });
}
function CloseDialog() {
    $("#myModal").dialog('close');
}

function updateProgress() {
    var value = $("#progressbar").progressbar("option", "value");
    if (value < 100) {
        $("#progressbar").progressbar("value", value + 1);
    }
}
function GetCheckedList() {
    var result = new Array();
    $("input:checked").each(function () {
        result.push($(this).val());
    });
    return result;
}