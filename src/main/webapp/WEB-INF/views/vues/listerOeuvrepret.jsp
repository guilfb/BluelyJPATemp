<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>

<%@include file="header.jsp" %>
<body>
<%@include file="navigation.jsp"%>

<div class="jumbotron text-center">
	<h1>Listing des oeuvres</h1>
</div>

<div class="container" style="margin-bottom:150px;">
	<a class="btn btn-secondary" href="../index.jsp" role="button"><span class="glyphicon glyphicon-menu-left"></span> Retour accueil</a>
	<h2>Tableau des Oeuvres</h2>
	<div class="container">
		<h3>Liste des Oeuvres</h3>
		<table class="table table-hover">
			<tr>
				<th class="col-md-1">Numero</th>
				<th class="col-md-2">Titre</th>
				<th class="col-md-2">Nom proprietaire</th>
				<th class="col-md-2">Prenom proprietaire</th>
				<th class="col-md-2">Statut</th>
			</tr>

			<c:forEach items="${mesOeuvres}" var="item">
				<tr>
					<td>${item.idOeuvrepret}</td>
					<td>${item.titreOeuvrepret}</td>
					<td>${item.proprietaire.nomProprietaire}</td>
					<td>${item.proprietaire.prenomProprietaire}</td>
					<td>${item.statut}</td>
					<td><a class="btn btn-info" href="ajouterReservationpret.htm?id=${item.idOeuvrepret}" role="button"><span
							class="glyphicon glyphicon-pencil"></span> Réserver</a>
						<a class="btn btn-success" href="modifierOeuvrepret.htm?id=${item.idOeuvrepret}" role="button"><span
								class="glyphicon glyphicon-pencil"></span> Modifier</a>
						<a class="btn btn-alert" href="supprimerOeuvrepret.htm?id=${item.idOeuvrepret}" role="button"><span
								class="glyphicon glyphicon-pencil"></span> Supprimer</a>
					</td>
				</tr>
			</c:forEach>
		</table>
	</div>
</div>
<%@include file="footer.jsp"%>
</body>
</html>