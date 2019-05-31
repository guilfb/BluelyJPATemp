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

<%@include file="header.jsp" %>
<body>
<%@include file="navigation.jsp"%>
	<div class="container">
		<div class="container">
			<div class="row">
				<div class="col-sm-6" style="height: 100px; display: flex; flex-direction: column; justify-content:center; text-align: left;">
					<h2>Liste des Adhérents</h2>
				</div>
				<div class="col-sm-6" style="height: 100px; display: flex; flex-direction: column; justify-content:center; text-align: right;">
					<div>
						<button class="btn btn-info" name="ajouter" data-toggle="modal" data-target="#exampleModalCenter" role="button" style="text-align: right;"><span
								class="glyphicon glyphicon-remove-circle"></span> Ajouter</button>
					</div>
				</div>
			</div>

			<table class="table table-hover">
				<tr>
					<th class="col-md-1">Numero</th>
					<th class="col-md-2">Nom</th>
					<th class="col-md-2">Prénom</th>
					<th class="col-md-4">Ville</th>

				</tr>

				<c:forEach items="${mesAdherents}" var="item">
					<tr name="${item.idAdherent}">
						<td name="id">${item.idAdherent}</td>
						<td name="nom">${item.nomAdherent}</td>
						<td name="prenom">${item.prenomAdherent}</td>
						<td name="ville">${item.villeAdherent}</td>
						<td><button class="btn btn-info" name="modifier" data-toggle="modal" data-target="#exampleModalCenter" role="button"><span
								class="glyphicon glyphicon-pencil"></span> Modifier</button>
							<button class="btn btn-danger" name="supprimer" data-toggle="modal" data-target="#exampleModalCenter" role="button"><span
									class="glyphicon glyphicon-remove-circle"></span> Supprimer</button></td>
					</tr>
				</c:forEach>
			</table>
		</div>


		<div class="modal fade" id="exampleModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true" >
			<div class="modal-dialog modal-dialog-centered modal-md" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="exampleModalLongTitle"></h5>
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>

					<div class="modal-body">
						<div>
							<form name="formulaire">
								<div class="form-group" style="display: none;">
									<input type="number" id="id" name="form_id" class="form-control" required="required"/>
								</div>
								<div class="form-group">
									<input type="text" id="nom" name="form_nom" class="form-control" placeholder="Nom" required="required"/>
								</div>
								<div class="form-group">
									<input type="text" id="prenom" name="form_prenom" class="form-control" placeholder="Prenom" required="required"/>
								</div>
								<div class="form-group">
									<input type="text" id="ville" name="form_ville" class="form-control" placeholder="Ville" required="required"/>
								</div>
								<div class="form-group">
									<div class="loader" hidden="hidden"></div>
									<div class="tick" hidden="hidden">
										<p><span class="glyphicon glyphicon-ok" style="color:green;"></span></p>
									</div>

									<div class="submit">
										<button type="submit" name="submit" role="ajouter" class="btn" style="height:50px;"> Valider</button>
									</div>

								</div>
							</form>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary" name="fermerModal" data-dismiss="modal">Close</button>
					</div>
				</div>
			</div>
		</div>

    </div>
<%@include file="footer.jsp"%>
</body>

</html>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>

<script>
	var titre = "Lister Adherent";
	$(document).find('.titreAChanger').text(titre);

    $("button[role='button']").on("click",function() {

        window.role = $(this).attr("role");

        if($(this).attr("role") != "ajouter"){
            // On récupère les données dans la ligne sur laquelle on a cliqué
            var id = $(this).parents("tr").children("td[name='id']").text();
            var nom = $(this).parents("tr").children("td[name='nom']").text();
            var prenom = $(this).parents("tr").children("td[name='prenom']").text();
            var ville = $(this).parents("tr").children("td[name='ville']").text();

            // On insère les valeurs de la ligne dans le formulaire
            $(document).find("input[id='id']").val(id);
            $(document).find("input[id='nom']").val(nom);
            $(document).find("input[id='prenom']").val(prenom);
            $(document).find("input[id='ville']").val(ville);

            // Si le bouton est le bouton supprimer, on met tous les inputs en non cliquable, et on affecte le role de suppression au bouton submit
            if($(this).attr("name") == "supprimer"){
                modifierTitre("Supprimer Adhérent");
                $(document).find("input").attr("readonly","readonly");
                $(document).find("button[type='submit']").attr("role","supprimer");
            }else{
                modifierTitre("Modifier Adhérent");
                $(document).find("button[type='submit']").attr("role","modifier");
            }
        }else{
            modifierTitre("Ajouter Adhérent");
            $(document).find("input[id='id']").val(0);
            $(document).find("button[type='submit']").attr("role","ajouter");
        }
    });


	$("form").on("submit", function(event){
		event.preventDefault();
		var form = $(this).serialize();

		if(window.role === "modifier"){
			updateAdherent(form);
		}
		else if(window.role === "supprimer"){
			deleteAdherent(form);
		}
		else {
			insertAdherent(form);
		}
	});

	function insertAdherent(form) {
		jQuery.ajax({
			type: 'POST',
			url: 'insertAjax.htm',
			data: {form: form},
			beforeSend: function() {
				$(document).find("div[class*='loader']").attr("hidden",false);
				$(document).find("div[class*='submit']").attr("hidden","hidden");
				$(document).find("div[class*='tick']").attr("hidden","hidden");
			},
			success: function(result) {
				result.forEach(function(value) {
					add(value.id, value.nom, value.prenom, value.ville);
				})
			},
			complete: function() {
				$(document).find("div[class*='loader']").attr("hidden","hidden");
				$(document).find("div[class*='submit']").attr("hidden",false);
				$(document).find("div[class*='tick']").attr("hidden",false);
				setTimeOutFormulaire();
			}
		});
	};

	function updateAdherent(form) {
		jQuery.ajax({
			type: 'POST',
			url: 'updateAjax.htm',
			data: {form: form},
			beforeSend: function() {
				$(document).find("div[class*='loader']").attr("hidden",false);
				$(document).find("div[class*='submit']").attr("hidden","hidden");
				$(document).find("div[class*='tick']").attr("hidden","hidden");
			},
			success: function(result) {
				result.forEach(function(value) {
					var ligne = $(document).find("tr[name='"+value.id+"']");
					ligne.children("td[name='nom']").text(value.nom);
					ligne.children("td[name='prenom']").text(value.prenom);
					ligne.children("td[name='ville']").text(value.ville);
				})
			},
			complete: function() {
				$(document).find("div[class*='loader']").attr("hidden","hidden");
				$(document).find("div[class*='submit']").attr("hidden",false);
				$(document).find("div[class*='tick']").attr("hidden",false);
				setTimeOutFormulaire();
			}
		});
	};

	function deleteAdherent(form) {
		jQuery.ajax({
			type: 'POST',
			url: 'deleteAjax.htm',
			data: {form: form},
			beforeSend: function() {
				$(document).find("div[class*='loader']").attr("hidden",false);
				$(document).find("div[class*='submit']").attr("hidden","hidden");
				$(document).find("div[class*='tick']").attr("hidden","hidden");
			},
			success: function(result) {
				result.forEach(function(value) {
					$(document).find("tr[name='"+value.id+"']").remove();
				})
			},
			complete: function() {
				$(document).find("div[class*='loader']").attr("hidden","hidden");
				$(document).find("div[class*='submit']").attr("hidden",false);
				$(document).find("div[class*='tick']").attr("hidden",false);
				setTimeOutFormulaire();
			}
		});
	};

	function add(id, nom, prenom, ville) {
		var toAdd = 	"<tr name='id'>" +
								"<td name='id'>"+id+"</td>" +
								"<td name='nom'>"+nom+"</td>" +
								"<td name='prenom'>"+prenom+"</td>" +
								"<td name='ville'>"+ville+"</td>" +
								"<td>" +
									"<button class='btn btn-info' name='modifier' data-toggle='modal' data-target='#exampleModalCenter' role='button'>" +
										"<span class='glyphicon glyphicon-pencil'></span> Modifier</button> " +
									"<button class='btn btn-danger' name='supprimer' data-toggle='modal' data-target='#exampleModalCenter' role='button'>" +
										"<span class='glyphicon glyphicon-remove-circle'></span> Supprimer</button>" +
								"</td>"+
						"</tr>";

	 	$(document).find("tr").first().after(toAdd);
	}

	// Fonction permettant l'affichage du titre dans le formulaire
	function modifierTitre(title) {
		$(document).find("h5[id='exampleModalLongTitle']").text(title);
	};

	// Set TimeOut pour fermer le formulaire automatiquement si tout s'est bien passé dans l'ajout
	function setTimeOutFormulaire(){
		$(document).ready(function(){
			setTimeout(fermerFormulaire,1000);
		});
	};

	// Fermer le formulaire
	function fermerFormulaire(){
		$(document).ready(function(){
			$(this).find("#exampleModalCenter .close").click();
			afterClose();
		});
	};

	function afterClose() {
		// On cache les différents boutons submit que l'on affichera par la suite selon ce que l'on veut faire
		$("button[type='input']").attr("role","submit");
		$(document).find("div[class*='tick']").attr("hidden","hidden");

		// On vide le formulaire
		modifierTitre("");

		$(document).find("input[id='id']").val("").attr("readonly",false);
		$(document).find("input[id='nom']").val("").attr("readonly",false);
		$(document).find("input[id='prenom']").val("").attr("readonly",false);
		$(document).find("input[id='ville']").val("").attr("readonly",false);

		window.role = "";
	};

    $("#exampleModalCenter .close").on("click", function(){
        afterClose();
    });

</script>
