function OpenDialog(content) {
    var modal = $("#modalContent").html(content);
    $("#myModal").modal('show');
}

function Rating_Initialize(rated, objId, voteType, url) {
    var rateControl = $("#rateit").rateYo({
        fullStar: true,
        starWidth: "15px",
        rating: rated
    })

    rateControl.on("rateyo.set", function (e, data) {
        var voted = data.rating;
        $.ajax({
            type: "POST",
            content: "application/json; charset=utf-8",
            url: url,
            data: {'voteType':voteType, 'id': objId, 'score': voted },
            success: function (data) {
                if (data.isSuccess == false) {
                    OpenDialog(data.message);
                }
                else {
                    $.post(data.votedUrl, function (partial) {
                        $("#voteArea").html(partial);
                    });
                    OpenDialog(data.message);
                }
            }
        });
    });
}