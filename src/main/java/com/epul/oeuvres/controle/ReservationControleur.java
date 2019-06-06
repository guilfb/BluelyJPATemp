package com.epul.oeuvres.controle;


import com.epul.oeuvres.dao.*;
import com.epul.oeuvres.meserreurs.MonException;
import com.epul.oeuvres.metier.*;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

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
    public ModelAndView monEspace(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String destinationPage;
        try {
            // Init des services
            BorneService borneService = new BorneService();

            //
            int idStation = Integer.parseInt(request.getParameter("idStation"));
            int nbV = Integer.parseInt(request.getParameter("idV"));

            List<BorneEntity> listBorne = borneService.getListBorneByStationWithVehicule(idStation);

            BorneEntity borneFinale = null;
            int i=0;
            boolean boucle = true;

            while(boucle && i<nbV) {
                for (BorneEntity borne : listBorne) {
                    if (borne.getVehicule().getTypeVehicule().getIdTypeVehicule() == Integer.parseInt(request.getParameter("id"+i))) {
                        borneFinale = borne;
                        boucle = false;
                        break;
                    }
                }
                i++;
            }
            request.setAttribute("borne", borneFinale);

            destinationPage = "/vues/reserverVehicule";
        } catch (Exception e) {
            request.setAttribute("MesErreurs", e.getMessage());
            destinationPage = "/vues/Erreur";

        }
        return new ModelAndView(destinationPage);
    }

    @RequestMapping(value = "reserver.htm")
    public ModelAndView reserver(HttpServletRequest request, HttpServletResponse response) throws Exception, MonException {
        String destinationPage = "";
        try {
            // Recupération de l'id client
            HttpSession session = request.getSession();
            int idClient = (int) session.getAttribute("id");

            // Init des services
            VehiculeService vehiculeService = new VehiculeService();
            ClientService clientService = new ClientService();
            ReservationService reservationService = new ReservationService();

            // Recup de l'id véhicule
            int numeroVehicule = Integer.parseInt(request.getParameter("idVehicule"));

            // Init des services
            VehiculeEntity vehicule = vehiculeService.consulterVehiculeById(numeroVehicule);
            ClientEntity client = clientService.consulterClientById(idClient);

            // Init date
            DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd");
            LocalDate localDate = LocalDate.now();
            Timestamp currentDate = Timestamp.valueOf(localDate.atStartOfDay());
            Timestamp maxDate = Timestamp.valueOf(localDate.plusDays(1).atStartOfDay());

            // Init reservation entity
            ReservationEntity reservation = new ReservationEntity();
            reservation.setClient(client);
            reservation.setDateEcheance(maxDate);
            reservation.setDateReservation(currentDate);
            reservation.setVehicule(vehicule);

            // Insertion reservation
            reservationService.insertReservation(reservation);
        } catch (Exception e) {
            request.setAttribute("MesErreurs", e.getMessage());
            destinationPage = "vues/Erreur";
        }

        destinationPage = "vues/index";
        return new ModelAndView(destinationPage);
    }


}