<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>

<%@include file="header.jsp" %>
<body>
<%@include file="navigation.jsp"%>

	<div class="jumbotron text-center">
		<h2>Réservation à la station<br/><c:out value="${borne.station.numero}" />, <c:out value="${borne.station.adresse}" /></h2>
	</div>

	<div class="container">
		<a class="btn btn-secondary" href="map.htm" role="button"><span class="glyphicon glyphicon-menu-left"></span> Retour à la carte</a>
		<div class="container">
			<table class="table table-hover">
				<tr>
					<th class="col-md-1">Véhicule</th>
					<th class="col-md-2">Catégorie Véhicule</th>
					<th class="col-md-2">Modèle Véhicule</th>
					<th class="col-md-1">N° borne</th>
					<th class="col-md-1">Etat batterie</th>
					<th class="col-md-1">Action</th>
				</tr>
				<tr>
					<td><c:out value="${borne.vehicule.idVehicule}" /></td>
					<td><c:out value="${borne.vehicule.typeVehicule.categorie}" /></td>
					<td><c:out value="${borne.vehicule.typeVehicule.typeVehicule}" /></td>
					<td><c:out value="${borne.idBorne}" /></td>
					<td><c:out value="${borne.vehicule.etatBatterie}"/> %</td>
					<td><a class="btn btn-info" href="reserver.htm?idVehicule=${borne.vehicule.idVehicule}" role="button"><span
							class="glyphicon glyphicon-pencil"></span> Reserver</a></td>
				</tr>
			</table>
		</div>
    </div>

<%@include file="footer.jsp"%>
</body>
</html>

<script>
	window.test = ${borne};
</script>