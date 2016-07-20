function ChangeQuantityAction(target) {
    var proId = target.attr('id');
    var qty = target.val();
    var sendData = { id: proId, qty: qty };
    $.get('/Cart/ChangeQuantity',
          sendData,
        function (data) {
            $("#cartResult").html(data)
            $("input[name=quantity]").numericInput({ allowFloat: true });
        });
}
$(document).on('change', 'input[name=quantity]', function (e) {
    ChangeQuantityAction($(this));
});
$(document).on('keydown', 'input[name=quantity]', function (e) {
    if (e.which == 13) {
        $(this).trigger("change");
    }
});
$(document).ready(function () {
    $("input[name=quantity]").numericInput({ allowFloat: true });
});