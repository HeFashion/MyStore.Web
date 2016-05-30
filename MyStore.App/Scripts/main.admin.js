function OpenDialog(h, w) {
    $("#myModal").dialog({
        height: h,
        width: w,
    });
}
function GetCheckedList() {
    var result = new Array();
    $("input:checked").each(function () {
        result.push($(this).val());
    });
    return result;
}