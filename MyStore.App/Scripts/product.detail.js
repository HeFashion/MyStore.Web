function LoadingImage(isLoading) {
    if (isLoading) {
        $("#detailImg").hide();
        $("#loadingImg").show();
    }
    else {
        $("#detailImg").show();
        $("#loadingImg").hide();
    }
}
function SwapImageAsyn(target, strImg) {

    target.click(function (e) {
        e.preventDefault();
        var imgIndex = $(this).attr('id');
        var altImg = $("#detailImg").attr('alt');
        if (altImg.indexOf(imgIndex) >= 0 ||
           (imgIndex == 0 && altImg == "detail.jpg")) return;

        var myData =
            {
                selectedIndex: imgIndex,
                folderName: strImg
            };
        $.ajax({
            type: "GET",
            url: "/Product/GetImageDetail",
            content: "application/json; charset=utf-8",
            data: myData,
            beforeSend: function () {
                LoadingImage(true);
            },
            complete: function () {
                LoadingImage(false);
            },
            error: function () {
                LoadingImage(false);
                alert("Error while retrieving data!");
            },
            success: function (data) {
                if (data != null) {
                    $("#detailImg").replaceWith(data);
                    ZoomImage(isSmartPhone);
                }
            },
        })
    });
}

function AddToCartWithNumber(target, sendData) {
    target.click(function (e) {
        e.preventDefault();
        AddToCart(sendData);
    });
}

function ZoomImage(isSmartPhone) {
    if (isSmartPhone) {
        $("#detailImg").elevateZoom();
    }
    else {
        $("#detailImg").elevateZoom({
            zoomType: "inner",
            cursor: "crosshair"
        });
    }
}