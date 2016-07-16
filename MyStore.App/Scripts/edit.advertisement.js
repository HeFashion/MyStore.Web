function ShowModal() {
    var url = $("#myModal").data("url");
    $.get(url,
        null,
        function (data) {
            $("#modalContent").html(data);
            $("#myModal").modal('show');
        });
}
$(document).ready(function () {
    var selectedType = 1;
    $("#btnDelete").click(function (e) {
        e.preventDefault();
        $("#slider_sub_img").val('');
        $("#subImg").attr("src", null);
    });
    $("#btnMainImg").click(function (e) {
        e.preventDefault();
        selectedType = 1;
        ShowModal();
    });
    $("#btnSubImg").click(function (e) {
        e.preventDefault();
        selectedType = 2;
        ShowModal();
    });

    $("#myModal").on("hidden", function () {
        var selectedImg = $("input[name=rdbSelected]:checked").val();
        if (selectedType == 1) {
            if (selectedImg != null) {
                $("#slider_main_img").val(selectedImg.substring(selectedImg.lastIndexOf('/') + 1));
                $("#mainImg").attr("src", selectedImg);
            }
        }
        else {
            $("#slider_sub_img").val(selectedImg.substring(selectedImg.lastIndexOf('/') + 1));
            $("#subImg").attr("src", selectedImg);
        }
    });
});