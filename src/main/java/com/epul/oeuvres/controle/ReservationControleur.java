package com.epul.oeuvres.controle;


import com.epul.oeuvres.dao.*;
import com.epul.oeuvres.meserreurs.MonException;
import com.epul.oeuvres.metier.ClientEntity;
import com.epul.oeuvres.metier.ReservationEntity;
import com.epul.oeuvres.metier.StationEntity;
import com.epul.oeuvres.metier.VehiculeEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.json.Json;
import javax.json.JsonArrayBuilder;
import javax.json.JsonObjectBuilder;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;


@Controller
public class ReservationControleur {


	@RequestMapping(value = "reserverVehicule.htm")
	public ModelAndView reserverVehicule(HttpServletRequest request, HttpServletResponse response) throws Exception, MonException {
        String destinationPage;
        // HttpSession session = request.getSession();


        //String vehicules = request.getParameter("vehicules");

        request.setAttribute("vehicules", "citroen");
        request.setAttribute("bornes", "borne 5");
        request.setAttribute("station", "11 Rue Gambetta");

        destinationPage = "/vues/reserverVehicule";
        return new ModelAndView(destinationPage);
	}


    @RequestMapping(value = "reserver.htm")
    public ModelAndView reserver(HttpServletRequest request, HttpServletResponse response) throws Exception, MonException {
        String destinationPage = "";
        try {
            HttpSession session = request.getSession();
            int idUtilisateur = (int) session.getAttribute("id");

            VehiculeService vehiculeService = new VehiculeService();
            ClientService clientService = new ClientService();
            ReservationService reservationService = new ReservationService();

            int numeroVehicule = Integer.parseInt(request.getParameter("idVehicule"));


            VehiculeEntity vehicule = vehiculeService.consulterVehiculeById(numeroVehicule);
            ClientEntity client = clientService.consulterClientById(idUtilisateur);

            DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd");
            LocalDate localDate = LocalDate.now();
            Timestamp currentDate = Timestamp.valueOf(localDate.atStartOfDay());
            Timestamp maxDate = Timestamp.valueOf(localDate.plusDays(1).atStartOfDay());

            ReservationEntity reservation = new ReservationEntity();

            reservation.setClient(client);
            reservation.setDateEcheance(maxDate);
            reservation.setDateReservation(currentDate);
            reservation.setVehicule(vehicule);

            reservationService.insertReservation(reservation);

        } catch (Exception e) {
            request.setAttribute("MesErreurs", e.getMessage());
            destinationPage = "vues/Erreur";
        }

        try {
            JsonArrayBuilder arrayBuilder = Json.createArrayBuilder();
            JsonObjectBuilder objectBuilder = Json.createObjectBuilder();

            StationService stationService = new StationService();

            List<StationEntity> listeStations = stationService.consulterListeStations();

            for(StationEntity station : listeStations) {
                objectBuilder.add("idStation", station.getIdStation());
                objectBuilder.add("latitude", station.getLatitude());
                objectBuilder.add("longitude", station.getLongitude());
                objectBuilder.add("adresse", station.getAdresse());
                objectBuilder.add("numero", station.getNumero());
                objectBuilder.add("ville", station.getVille());
                objectBuilder.add("codePostal", station.getCodePostal());

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

        return new ModelAndView(destinationPage);
    }


}