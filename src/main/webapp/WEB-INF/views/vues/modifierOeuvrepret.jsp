<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@include file="header.jsp" %>
<body>
<%@include file="navigation.jsp"%>
<H1> Modifier d'un adhérent </H1>
<form method="post" action="updateOeuvrepret.htm?id=${uneOeuvrepret.idOeuvrepret}">
    <div class="col-md-12 well well-md">
        <h1>Modifer Séjour</h1>
        <div class="row" >
            <div class="col-md-12" style ="border:none; background-color:transparent; height :20px;">
            </div>
        </div>
        <div class="form-group">
            <label class="col-md-3 control-label">Titre de l'Oeuvre : </label>
            <div class="col-md-3">
                <INPUT type="text" name="txttitre" value='${uneOeuvrepret.titreOeuvrepret}' id="titre" class="form-control" min="0">
            </div>
        </div>
        <div class="row" >
            <div class="col-md-12" style ="border:none; background-color:transparent; height :20px;">
            </div>
        </div>
        <div class="form-group">
            <label class="col-md-3 control-label">Ville de l'adherent : </label>
            <div class="col-md-3">
                <SELECT name="proprietaire" id="proprietaire" class="form-control" min="0">
                    <c:forEach items="${mesProprios}" var="item">
                        <c:choose>
                            <c:when test="${uneOeuvrepret.proprietaire.nomProprietaire == item.nomProprietaire}"><OPTION value="${item.idProprietaire}" selected="selected">${item.nomProprietaire}</OPTION></c:when>
                            <c:otherwise><OPTION value="${item.idProprietaire}">${item.nomProprietaire}</OPTION></c:otherwise>
                        </c:choose>
                    </c:forEach>
                </SELECT>
            </div>
        </div>
        <div class="row" >
            <div class="col-md-12" style ="border:none; background-color:transparent; height :20px;">
            </div>
        </div>

        <div class="form-group">
            <button type="submit" class="btn btn-default btn-primary"><span class="glyphicon glyphicon-ok"></span>
                Valider
            </button>

            <button type="button" class="btn btn-default btn-primary"
                    onclick="{
                            window.location = 'index.htm';
                        }">
                <span class="glyphicon glyphicon-remove"></span> Annuler

            </button>
        </div>
    </div>
</form>
</body>
<%@include file="footer.jsp"%>
</html>