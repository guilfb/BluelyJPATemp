package com.epul.oeuvres.controle;


import com.epul.oeuvres.dao.BorneService;
import com.epul.oeuvres.dao.StationService;
import com.epul.oeuvres.meserreurs.MonException;
import com.epul.oeuvres.metier.BorneEntity;
import com.epul.oeuvres.metier.StationEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import javax.json.Json;
import javax.json.JsonArrayBuilder;
import javax.json.JsonObjectBuilder;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;


@Controller
public class BorneControleur {

	@RequestMapping(value = "afficherBorne.htm")
	public void afficherStation(HttpServletRequest request, HttpServletResponse response) throws Exception {
		try {
            JsonArrayBuilder arrayBuilder = Json.createArrayBuilder();
            JsonObjectBuilder objectBuilder = Json.createObjectBuilder();

            BorneService borneService = new BorneService();

            List<BorneEntity> listeBornes = borneService.consulterListeBornes();

            for(BorneEntity borne : listeBornes) {
                objectBuilder.add("idBorne", borne.getIdBorne());
                objectBuilder.add("etatBorne", borne.getEtatBorne());
                objectBuilder.add("stationBorne", borne.getStation());
                objectBuilder.add("vehiculeBorne", borne.getVehicule());

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