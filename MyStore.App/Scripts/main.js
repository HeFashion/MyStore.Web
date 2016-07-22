function ShowModal() {
    var frmModal = $("#myModal");
    if (frmModal != null) {
        frmModal.modal("show");
    }
}
function hideLeftMenu(isHide, element) {
    if (isHide) {
        element.next('.list-group').toggle('slide');
        $('.mini-submenu').hide();
    }
    else {
        element.closest('.list-group').fadeOut('slide', function () {
            $('.mini-submenu').fadeIn();
        });
    }
}

function getData(myData) {
    $.ajax({
        type: 'GET',
        url: "/Product/ListItemPartial",
        data: myData,
        content: "application/json; charset=utf-8",
        success: function (data) {
            if (data != null) {
                $("#featureItems").append(data);
                nextIndex++;
            }
            isLocked = false;
        },
        beforeSend: function () {
            $("#progress").show();
            $("#featureItems").find("a").click(function (e) { e.preventDefault(); });
            $("#footer").find("a").click(function (e) { e.preventDefault(); });
            isLocked = true;
        },
        complete: function () {
            $("#progress").hide();
            $("#featureItems").find("a").unbind("click");
            $("#footer").find("a").unbind("click");
        },
        error: function () {
            alert("Error while retrieving data!");
            $("#featureItems").find("a").unbind("click");
            $("#footer").find("a").unbind("click");
        }
    });
}

function GetData(index) {
    var sendData = { "page": index };
    return getData(sendData);
}

function SortList(getUrl) {

}
//$('#sl2').slider();

var RGBChange = function () {
    $('#RGB').css('background', 'rgb(' + r.getValue() + ',' + g.getValue() + ',' + b.getValue() + ')')
};

/*scroll to top*/
$(document).ready(function () {
    $(function () {
        $.scrollUp({
            scrollName: 'scrollUp', // Element ID
            scrollDistance: 300, // Distance from top/bottom before showing element (px)
            scrollFrom: 'top', // 'top' or 'bottom'
            scrollSpeed: 300, // Speed back to top (ms)
            easingType: 'linear', // Scroll to top easing (see http://easings.net/)
            animation: 'fade', // Fade, slide, none
            animationSpeed: 200, // Animation in speed (ms)
            scrollTrigger: false, // Set a custom triggering element. Can be an HTML string or jQuery object
            //scrollTarget: false, // Set a custom target element for scrolling to the top
            scrollText: '<i class="fa fa-angle-up"></i>', // Text for element, can contain HTML
            scrollTitle: false, // Set a custom <a> title if required.
            scrollImg: false, // Set true to use image
            activeOverlay: false, // Set CSS color to display scrollUp active point, e.g '#00FFFF'
            zIndex: 2147483647 // Z-Index for the overlay
        });
    });

    if ($.cookie("mini-submenu") == 0) {
        hideLeftMenu(false, $('#slide-submenu'));
    }

    $('#slide-submenu').on('click', function () {
        hideLeftMenu(false, $(this));
        $.cookie("mini-submenu", 0, { expires: 10 });
    });

    $('.mini-submenu').on('click', function () {
        hideLeftMenu(true, $(this));
        $.cookie("mini-submenu", 1, { expires: 10 });
    })
});
