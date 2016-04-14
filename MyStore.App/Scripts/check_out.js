$(document).ready(function () {
    CheckedAction();
    $("#rdbUsePass, #rdbUnusePass").change(function () {

        CheckedAction();
    });
});

function CheckedAction() {
    if ($("#rdbUsePass").attr("checked")) {
        $("#frmOne").show();
        $("#frmTwo").hide();
    }
    else {
        $("#frmOne").hide();
        $("#frmTwo").show();
    }
}