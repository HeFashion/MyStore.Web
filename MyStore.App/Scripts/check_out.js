$(document).ready(function () {
    CheckedAction();
    $("#rdbUsePass").on("change", function (e) {
        CheckedAction();
    });

    $("#rdbUnusePass").on("change", function (e) {
        CheckedAction();
    });
});

function CheckedAction() {

    if ($("#rdbUsePass").is(":checked")) {
        $("#frmOne").show();
        $("#frmTwo").hide();
    }
    else if ($("#rdbUnusePass").is(":checked")) {
        $("#frmOne").hide();
        $("#frmTwo").show();
    }
}