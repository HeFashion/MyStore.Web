$(document).ready(function(){
    initialize();
});
function initialize() {
    var map;
    var myLatLng = { lat: 10.781799, lng: 106.951289 };
    map = new GMaps({
        el: '#gmap',
        lat: myLatLng.lat,
        lng: myLatLng.lng,
        scrollwheel: false,
        zoom: 18,
        zoomControl: false,
        panControl: false,
        streetViewControl: false,
        mapTypeControl: false,
        overviewMapControl: false,
        clickable: false
    });

    //var image = 'images/map-icon.png';
    map.addMarker({
        lat: myLatLng.lat,
        lng: myLatLng.lng,
        // icon: image,
        animation: google.maps.Animation.DROP,
        verticalAlign: 'bottom',
        horizontalAlign: 'center',
        backgroundColor: '#ffffff',
    });

    var styles = [

	{
	    "featureType": "road",
	    "stylers": [
		{ "color": "" }
	    ]
	}, {
	    "featureType": "water",
	    "stylers": [
		{ "color": "#A2DAF2" }
	    ]
	}, {
	    "featureType": "landscape",
	    "stylers": [
		{ "color": "#ABCE83" }
	    ]
	}, {
	    "elementType": "labels.text.fill",
	    "stylers": [
		{ "color": "#000000" }
	    ]
	}, {
	    "featureType": "poi",
	    "stylers": [
		{ "color": "#2ECC71" }
	    ]
	}, {
	    "elementType": "labels.text",
	    "stylers": [
		{ "saturation": 1 },
		{ "weight": 0.1 },
		{ "color": "#111111" }
	    ]
	}

    ];

    map.addStyle({
        styledMapName: "Styled Map",
        styles: styles,
        mapTypeId: "map_style"
    });

    map.setStyle("map_style");

}
/*
function initialize() {
    var myLatLng = { lat: 10.781799, lng: 106.951289 };
    var styles = [

	{
	    "featureType": "road",
	    "stylers": [
		{ "color": "" }
	    ]
	}, {
	    "featureType": "water",
	    "stylers": [
		{ "color": "#A2DAF2" }
	    ]
	}, {
	    "featureType": "landscape",
	    "stylers": [
		{ "color": "#ABCE83" }
	    ]
	}, {
	    "elementType": "labels.text.fill",
	    "stylers": [
		{ "color": "#000000" }
	    ]
	}, {
	    "featureType": "poi",
	    "stylers": [
		{ "color": "#2ECC71" }
	    ]
	}, {
	    "elementType": "labels.text",
	    "stylers": [
		{ "saturation": 1 },
		{ "weight": 0.1 },
		{ "color": "#111111" }
	    ]
	}

    ];

   
    var mapOptions = {
        center: myLatLng,
        scrollwheel: false,
        zoom: 100,
        zoomControl: false,
        panControl: false,
        streetViewControl: false,
        mapTypeControl: false,
        overviewMapControl: false,
        clickable: false
    };
    var map = new google.maps.Map(document.getElementById("gmap"),
      mapOptions);

    map.addStyle({
        styledMapName: "Styled Map",
        styles: styles,
        mapTypeId: "map_style"
    });

    map.setStyle("map_style");

    map.addMarker({
        position: myLatLng,
        // icon: image,
        animation: google.maps.Animation.DROP,
        verticalAlign: 'bottom',
        horizontalAlign: 'center',
        backgroundColor: '#ffffff',
    });
}
*/