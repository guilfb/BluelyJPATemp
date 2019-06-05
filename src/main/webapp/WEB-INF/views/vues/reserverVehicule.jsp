<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>

<%@include file="header.jsp" %>
<body>
<%@include file="navigation.jsp"%>

	<div class="jumbotron text-center">
		<h1>Réservation à la station, <c:out value="${station}"> </c:out> </h1>
	</div>

	<div class="container">
		<a class="btn btn-secondary" href="../index.htm" role="button"><span class="glyphicon glyphicon-menu-left"></span> Retour accueil</a>
		<h2>Mes réservations</h2>
		<div class="container">
			<table class="table table-hover">
				<tr>
					<th class="col-md-2">Véhicule</th>
					<th class="col-md-4">N° borne</th>
					<th class="col-md-4">Etat batterie</th>
					<th class="col-md-2">Action</th>
				</tr>


					<tr>
						<td><c:out value="${vehicules}"> </c:out></td>
						<td><c:out value="${bornes}"> </c:out></td>
						<td>100%</td>
						<td><a class="btn btn-info" href="reserver.htm?idVehicule=5" role="button"><span
								class="glyphicon glyphicon-pencil"></span> Reserver</a></td>
					</tr>

			</table>
		</div>
    </div>

<%@include file="footer.jsp"%>
</body>
</html>