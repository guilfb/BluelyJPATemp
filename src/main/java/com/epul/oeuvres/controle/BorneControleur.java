package com.epul.oeuvres.controle;


import com.epul.oeuvres.dao.BorneService;
import com.epul.oeuvres.meserreurs.MonException;
import com.epul.oeuvres.metier.BorneEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.json.Json;
import javax.json.JsonArrayBuilder;
import javax.json.JsonObjectBuilder;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;


@Controller
public class BorneControleur {

	@RequestMapping(value = "map.htm")
	public ModelAndView afficherBorne(HttpServletRequest request, HttpServletResponse response) throws Exception {
		try {
            JsonArrayBuilder arrayBuilder = Json.createArrayBuilder();
            JsonObjectBuilder objectBuilder = Json.createObjectBuilder();

            BorneService borneService = new BorneService();

            List<BorneEntity> listeBornes = borneService.consulterListeBornes();

            for(BorneEntity borne : listeBornes) {
                objectBuilder
                        .add("idBorne", borne.getIdBorne())
                        .add("etatBorne", borne.getEtatBorne())
                        .add("stationBorne", Json.createObjectBuilder()
                                .add("idStation", borne.getStation().getIdStation())
                                .add("latitudeStation", borne.getStation().getLatitude())
                                .add("longitudeStation", borne.getStation().getLongitude())
                                .add("numAdresseStation", borne.getStation().getNumero())
                                .add("adresseStation", borne.getStation().getAdresse())
                                .add("cpStation", borne.getStation().getCodePostal())
                                .add("villeStation", borne.getStation().getVille()));

                if(borne.getVehicule() != null) {
                    objectBuilder
                        .add("vehiculeBorne", Json.createObjectBuilder()
                                .add("idVehicule", borne.getVehicule().getIdVehicule())
                                .add("rfidVehicule", borne.getVehicule().getRfid())
                                .add("batterieVehicule", borne.getVehicule().getEtatBatterie())
                                .add("dispoVehicule", borne.getVehicule().getDisponibilite())
                                .add("latitudeVehicule", borne.getVehicule().getLatitude())
                                .add("longitudeVehicule", borne.getVehicule().getLongitude())
                                .add("typeVehicule", Json.createObjectBuilder()
                                        .add("idTV", borne.getVehicule().getTypeVehicule().getIdTypeVehicule())
                                        .add("categTV", borne.getVehicule().getTypeVehicule().getCategorie())
                                        .add("TV", borne.getVehicule().getTypeVehicule().getTypeVehicule())));
                }else{
                    objectBuilder.add("vehiculeBorne",Json.createObjectBuilder()
                            .add("idVehicule", "NO_VEHICULE"));
                }

                arrayBuilder.add(objectBuilder);
                objectBuilder = Json.createObjectBuilder();
            }

            request.setAttribute("bornes",arrayBuilder.build().toString());

            //response.setContentType("application/json; charset=UTF-8");
            //response.getWriter().write(arrayBuilder.build().toString());

		} catch (MonException e) {
            JsonArrayBuilder arrayBuilder = Json.createArrayBuilder();
            JsonObjectBuilder objectBuilder = Json.createObjectBuilder();
            objectBuilder.add("msg", e.getMessage());
            arrayBuilder.add(objectBuilder);
            response.setContentType("application/json; charset=UTF-8");
            response.getWriter().write(arrayBuilder.build().toString());
            request.setAttribute("MesErreurs", e.getMessage());
		}

        return new ModelAndView("vues/map");
	}


}