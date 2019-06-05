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

<%@include file="header.jsp"%>

<body>
<%@include file="navigation.jsp"%>
	<div class="container">
        <div class="col-sm-2" style="border: 1px solid black">
            <div id="formType">
                <div class="form-check">
                    <input class="form-check-input" type="radio" name="exampleRadios" id="allVehicules" value="ALL" checked>
                    <label class="form-check-label" for="allVehicules">ALL VEHICULES</label>
                </div>
            </div>
        </div>
        <div class="col-sm-8">
            <div id="map" style="width:100%; height:80%;"></div>
        </div>
        <div class="col-sm-2" style="border: 1px solid black">
            <p>TEST</p>
        </div>
    </div>
<%@include file="footer.jsp"%>
</body>
</html>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
<script>

    // ICI FAIRE UNE VAR WINDOW TABLEAU 2 DIM POUR STOCKER TOUTE LA TABLE VEHICULE
    window.categories = [];
    window.categorieTypeVehicule = [];
    window.stations = [];
    window.bornes = [];
    window.vehicules = [];

    test();
    remplirWindowTypeVehicule();
    remplirWindowVehicule();
    remplirWindowBorne();

    function remplirWindowTypeVehicule() {
        var i = 0;
        var j = 0;
        jQuery.ajax({
            type: 'POST',
            url: 'afficherTypeVehicule.htm',
            success: function (result) {
                result.forEach(function (value) {
                    window.categories[i] = value;
                    if(window.categorieTypeVehicule.indexOf(value.categorie) == -1){
                        window.categorieTypeVehicule[j] = value.categorie;
                        j++;
                    }
                    i++;
                });
            }, complete: function(value){
                remplirTypeVehicule();
            }
        });
    };

    function remplirWindowBorne() {
        var i = 0;
        jQuery.ajax({
            type: 'POST',
            url: 'afficherBorne.htm',
            success: function (result) {
                result.forEach(function (value) {
                    window.bornes[i] = value;
                    console.log(value);
                    i++;
                });
            }, complete: function(value){
                remplirTypeVehicule();
            }
        });
    };

    function remplirWindowVehicule() {
        var i = 0;
        jQuery.ajax({
            type: 'POST',
            url: 'afficherVehicule.htm',
            success: function (result) {
                result.forEach(function (value) {
                    window.vehicules[i] = value;
                    i++;
                });
            }, complete: function(value){
                remplirTypeVehicule();
            }
        });
    };

    function remplirTypeVehicule() {
        window.categorieTypeVehicule.forEach(function(value) {
            $("#formType").append("<div class=\"form-check\">\n" +
                    "<input class=\"form-check-input\" type=\"radio\" name=\"exampleRadios\" id='" + value + "' value='" + value + "'>\n" +
                    "<label class=\"form-check-label\" for='"+value+"'>" + value + "</label>\n" +
                "</div>");
        });
    };

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
        var i = 0;
        console.log("1");
        jQuery.ajax({
			type: 'POST',
			url: 'afficherStation.htm',
			success: function (result) {
				result.forEach(function (value) {
                    window.stations[i] = value;
                    i++;
                    var marker = L.marker([value.latitude, value.longitude])
                            .addTo(map)
                            .bindPopup(
							    '<div>' +
                                    '<p>'+value.numero+', '+value.adresse+'</p>' +
                                    '<p>'+value.codePostal+', '+value.ville+'</p>' +
                                    '<button onclick="window.location.href = \'reserverVehicule.htm\';">Réserver</button>'+
                                '</div>');
				});
			}
		});
	};
</script>
