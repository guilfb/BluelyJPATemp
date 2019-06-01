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
public class StationControleur {

    @RequestMapping(value = "map.htm", method = RequestMethod.GET)
    public ModelAndView Afficheindex(HttpServletRequest request, HttpServletResponse response) throws Exception {
        return new ModelAndView("vues/map");
    }

	@RequestMapping(value = "afficherStation.htm")
	public void afficherStation(HttpServletRequest request, HttpServletResponse response) throws Exception {
		try {
            JsonArrayBuilder arrayBuilder = Json.createArrayBuilder();
            JsonObjectBuilder objectBuilder = Json.createObjectBuilder();

            StationService stationService = new StationService();
            BorneService borneService = new BorneService();

            List<StationEntity> listeStations = stationService.consulterListeStations();

            for(StationEntity station : listeStations) {
                objectBuilder.add("idStation", station.getIdStation());
                objectBuilder.add("latitude", station.getLatitude());
                objectBuilder.add("longitude", station.getLongitude());
                objectBuilder.add("adresse", station.getAdresse());
                objectBuilder.add("numero", station.getNumero());
                objectBuilder.add("ville", station.getVille());
                objectBuilder.add("codePostal", station.getCodePostal());

                /*
                List<BorneEntity> listeBorne = borneService.consulterListeBornesParStation(station.getIdStation());
                for(BorneEntity borne : listeBorne) {
                    // RUN TEST HERE
                }
                */

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