package com.epul.oeuvres.controle;


import com.epul.oeuvres.dao.BorneService;
import com.epul.oeuvres.dao.VehiculeService;
import com.epul.oeuvres.meserreurs.MonException;
import com.epul.oeuvres.metier.BorneEntity;
import com.epul.oeuvres.metier.VehiculeEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.json.Json;
import javax.json.JsonArrayBuilder;
import javax.json.JsonObjectBuilder;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;


@Controller
public class VehiculeControleur {

	@RequestMapping(value = "afficherVehicule.htm")
	public void afficherStation(HttpServletRequest request, HttpServletResponse response) throws Exception {
		try {
            JsonArrayBuilder arrayBuilder = Json.createArrayBuilder();
            JsonObjectBuilder objectBuilder = Json.createObjectBuilder();

            VehiculeService vehiculeService = new VehiculeService();

            List<VehiculeEntity> listeVehicules = vehiculeService.consulterListeVehicules();

            for(VehiculeEntity vehicule : listeVehicules) {
                objectBuilder.add("idVehicule", vehicule.getIdVehicule());
                objectBuilder.add("dispoVehicule", vehicule.getDisponibilite());
                objectBuilder.add("batterieVehicule", vehicule.getEtatBatterie());
                objectBuilder.add("longitudeVehicule", vehicule.getLatitude());
                objectBuilder.add("latitudeVehicule", vehicule.getLongitude());
                objectBuilder.add("rfidVehicule", vehicule.getRfid());

                arrayBuilder.add(objectBuilder);
                objectBuilder = Json.createObjectBuilder();
            }

            response.setContentType("application/json; charset=UTF-8");
            response.getWriter().write(arrayBuilder.build().toString());
		} catch (MonException e) {
            JsonArrayBuilder arrayBuilder = Json.createArrayBuilder();
            JsonObjectBuilder objectBuilder = Json.createObjectBuilder();
            objectBuilder.add("msg", e.getMessage());
            arrayBuilder.add(objectBuilder);
            response.setContentType("application/json; charset=UTF-8");
            response.getWriter().write(arrayBuilder.build().toString());

			request.setAttribute("MesErreurs", e.getMessage());

		}
	}


}