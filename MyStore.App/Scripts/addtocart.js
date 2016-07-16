
function SendProductAction(component, returnUrl) {
    $(document).on('click', component, function (e) {
        e.preventDefault();

        var sendInfo = {
            productId: e.target.value,
            productQuantity: 1
        };
        AddToCart(sendInfo, returnUrl);
    });
}

function AddToCart(sendInfo, returnUrl) {
    $.ajax({
        type: "POST",
        content: "application/json; charset=utf-8",
        url: '/Cart/AddToCart',
        data: sendInfo,
        success: function (data) {
            if (data.status) {
                var url = '/Product/ShowCompletedAddToCart';

                $.get(url,
                    { selectedId: sendInfo.productId, returnUrl: returnUrl },
                    function (data) {
                        $("#modalContent").html(data);
                        $("#myModal").modal('show');
                    });
            } else {
                alert("Không thể thêm vào danh sách !");
            }
        }
    });
}