<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>

<style>
	@keyframes spin {
		0% { transform: rotate(0deg); }
		100% { transform: rotate(360deg); }
	}
</style>

<%@include file="header.jsp"%>

<body>
<%@include file="navigation.jsp"%>

<c:if test="${sessionScope.id == null }">
<script>window.location.href = 'http://localhost:8080/login.htm'</script>
</c:if>

<c:if test="${sessionScope.id > 0 }">
	<div class="container">
        <div class="col-sm-2" style="border: 1px solid black">
            <div id="formType"></div>
        </div>
        <div class="col-sm-8">
            <div id="map" style="width:100%; height:80%;"></div>
        </div>
        <div class="col-sm-2" style="border: 1px solid black">
            <div id="formVehicule">

            </div>
        </div>
    </div>
</c:if>
<%@include file="footer.jsp"%>
</body>
</html>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
<script>

    window.bornes = ${bornes};
    window.stations = [];
    window.vehicules = [];
    window.typeVehicules = [];
    window.categVehicules = [];
    window.categAffiche = [];
    window.vehiculeChoisis = [];
    window.stationsAffiche = [];
    window.marker = [];

    remplirListes();

    function launch() {

    };

    function remplirListes() {
        // Init de toutes les listes
        window.bornes.forEach(function(value) {
            window.stations.push(value.stationBorne);
            window.vehicules.push(value.vehiculeBorne);
        });

        // Liste de stations
        var idDejaVisit = [];
        window.stations = window.stations.filter(function(elem, index, self) {
            if(idDejaVisit.indexOf(elem.idStation) === -1){
                idDejaVisit.push(elem.idStation);
                return true;
            }
            return false;
        });

        // Affichage de la map
        afficherMap();

        // Liste de vehicules
        var idDejaVisit2 = [];
        window.vehicules = window.vehicules.filter(function(elem, index, self) {
            if((idDejaVisit2.indexOf(elem.idVehicule) === -1) && !(elem.idVehicule === "NO_VEHICULE" )){
                idDejaVisit2.push(elem.idVehicule);
                window.typeVehicules.push(elem.typeVehicule);
                return true;
            }
            return false;
        });

        // Liste de typeVehicule
        var idDejaVisit3 = [];
        window.typeVehicules = window.typeVehicules.filter(function(elem, index, self) {
            if(idDejaVisit3.indexOf(elem.idTV) === -1){
                idDejaVisit3.push(elem.idTV);
                return true;
            }
            return false;
        });

        // Liste de categVehicule
        var idDejaVisit4 = [];
        window.categVehicules = window.typeVehicules.filter(function(elem, index, self) {
            if (idDejaVisit4.indexOf(elem.categTV) === -1) {
                idDejaVisit4.push(elem.categTV);
                return true;
            }
            return false;
        });

        remplirCategVehicule();
    };

    function afficherMap() {
        window.map = L.map('map', {
            center: [45.76, 4.835],
            zoom: 13
        });
        var osmLayer = L.tileLayer('http://{s}.tile.osm.org/{z}/{x}/{y}.png', {
            attribution: '© OpenStreetMap contributors',
            maxZoom: 19
        });
        map.addLayer(osmLayer);

        window.myIcon = L.icon({
            iconUrl: './././resources/images/popup.png',
            iconSize: [38, 95],
            iconAnchor: [22, 94],
            popupAnchor: [-3, -76],
        });

    };

    $('#formType').change(function() {
        ifChecked();
        ifCheckedVehicule();
    });

    $('#formVehicule').change(function() {
        ifCheckedVehicule();
    });

	function ifChecked() {
	    window.categAffiche = [];
	    window.categVehicules.forEach(function(value) {
            if($("input[type='checkbox'][value='"+value.categTV+"']").prop("checked")) {
                window.categAffiche.push(value.categTV);
            }
        });
        remplirVehicule();
    };

    function ifCheckedVehicule() {
        window.vehiculeChoisis = [];
        window.typeVehicules.forEach(function(value) {
            if($("input[type='checkbox'][value='"+value.TV+"']").prop("checked")) {
                window.vehiculeChoisis.push(value.TV);
            }
        });
        triMarker();
    };

    function remplirCategVehicule() {
        window.categVehicules.forEach(function(value) {
            $("#formType").append("<div class=\"form-check\">\n" +
                "<input class=\"form-check-input\" type=\"checkbox\" name=\"exampleRadios\" id='" + value.categTV + "' value='" + value.categTV + "' checked=\"checked\">\n" +
                "<label class=\"form-check-label\" for='"+ value.categTV +"'>" + value.categTV + "</label>\n" +
                "</div>");
        });
        ifChecked();
        ifCheckedVehicule();
    };

    function remplirVehicule() {
        $("#formVehicule").empty();

        window.typeVehicules.forEach(function(item) {
            if(window.categAffiche.indexOf(item.categTV) !== -1){
                $("#formVehicule").append(
                    "<div class=\"form-check\">\n" +
                    "<input class=\"form-check-input\" type=\"checkbox\" name=\"exampleRadios\" id='" + item.TV + "' value='" + item.TV + "' checked=\"checked\">\n" +
                    "<label class=\"form-check-label\" for='"+item.TV+"'>" + item.TV + "</label>\n" +
                    "</div>");
            }
        });
    };

	function triMarker() {
	    window.marker.forEach(function(item) {
            map.removeLayer(item);
        });

        window.marker = [];
        window.stationsAffiche = [];
        var marker;

        window.bornes.forEach(function(elem) {
            if(elem.vehiculeBorne.idVehicule !== "NO_VEHICULE") {
                if(window.vehiculeChoisis.indexOf(elem.vehiculeBorne.typeVehicule.TV) !== -1) {
                    if(window.stationsAffiche.indexOf(elem.stationBorne.idStation) === -1){
                        window.stationsAffiche.push(elem.stationBorne.idStation);
                        marker = L.marker([elem.stationBorne.latitudeStation, elem.stationBorne.longitudeStation])
                            .addTo(map)
                            .bindPopup('<div><p>'
                                + elem.stationBorne.numAdresseStation + ', '
                                + elem.stationBorne.adresseStation + '<br />'
                                + elem.stationBorne.cpStation + ', '
                                + elem.stationBorne.villeStation + '</p></div>');
                        window.marker.push(marker);
                    }
                }
            }
        });
    };

</script>
