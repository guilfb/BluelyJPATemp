<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>

<style>
	.loader {
		border: 5px solid #f3f3f3; /* Light grey */
		border-top: 5px solid black; /* Blue */
		border-radius: 50%;
		width: 25px;
		height: 25px;
		animation: spin 2s linear infinite;
	}

	@keyframes spin {
		0% { transform: rotate(0deg); }
		100% { transform: rotate(360deg); }
	}
</style>

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="fr">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
	<link rel="stylesheet" href="https://unpkg.com/leaflet@1.3.1/dist/leaflet.css" />
	<script type="text/javascript" src="https://unpkg.com/leaflet@1.3.1/dist/leaflet.js"></script>
</head>

</html>
<body onload="test();">
<%@include file="navigation.jsp"%>
	<div class="container">
		<div class="container">
			<div class="row">
				<div id="map" style="width:80%; height:80%"></div>
			</div>
		</div>
    </div>
<%@include file="footer.jsp"%>
</body>
</html>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
<script>

	function test() {

		var map = L.map('map', {
			center: [45.750000, 4.84],
			zoom: 13
		});
		var osmLayer = L.tileLayer('http://{s}.tile.osm.org/{z}/{x}/{y}.png', {
			attribution: '© OpenStreetMap contributors',
			maxZoom: 19
		});
		map.addLayer(osmLayer);
		/*
		var LeafIcon = L.Icon.extend({
			options: {
				iconSize:     [30, 30],
				iconAnchor:   [22, 94],
				popupAnchor:  [-3, -76]
			}
		});
		var testIcon = new LeafIcon({iconUrl: './../../resources/images/popup.png'});
        */
		jQuery.ajax({
			type: 'POST',
			url: 'afficherStation.htm',
			success: function (result) {
				result.forEach(function (value) {

					var marker = L.marker([value.latitude, value.longitude]
                        //, {icon: testIcon}
                        ).addTo(map)
							.bindPopup(
							    '<div>' +
                                    '<p>'+value.numero+', '+value.adresse+'</p>' +
                                    '<p>'+value.codePostal+', '+value.ville+'</p>' +
                                '</div>');
				});
			}
		});
	};
</script>
