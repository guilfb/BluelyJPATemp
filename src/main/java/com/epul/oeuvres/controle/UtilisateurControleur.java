package com.epul.oeuvres.controle;


import com.epul.oeuvres.dao.ClientService;
import com.epul.oeuvres.dao.ReservationService;
import com.epul.oeuvres.dao.StationService;
import com.epul.oeuvres.dao.UtilisationService;
import com.epul.oeuvres.meserreurs.MonException;
import com.epul.oeuvres.metier.ClientEntity;
import com.epul.oeuvres.metier.StationEntity;
import com.epul.oeuvres.metier.UtilisateurEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import javax.json.Json;
import javax.json.JsonArrayBuilder;
import javax.json.JsonObjectBuilder;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.List;


@Controller
public class UtilisateurControleur {


	@RequestMapping(value = "monEspace.htm")
	public ModelAndView monEspace(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String destinationPage;
        try {
            // HttpSession session = request.getSession();
            ReservationService reservationService = new ReservationService();
            UtilisationService utiliseService = new UtilisationService();

            ClientService clientService = new ClientService();

            HttpSession session = request.getSession();
            int idUtilisateur = (int) session.getAttribute("id");

            ClientEntity client = clientService.consulterClientById(idUtilisateur) ;
            request.setAttribute("mesReservations", reservationService.consulterListeReservations(idUtilisateur));
            request.setAttribute("mesUtilisations", utiliseService.consulterListeUtilisations(idUtilisateur));

            destinationPage = "/vues/monEspace";
        } catch (MonException e) {
            request.setAttribute("MesErreurs", e.getMessage());
            destinationPage = "Erreur";

        }
        return new ModelAndView(destinationPage);
	}

    @RequestMapping(value = "creerCompte.htm")
    public ModelAndView creerCompte(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String destinationPage;

        destinationPage = "/vues/creerCompte";
        return new ModelAndView(destinationPage);
    }

    @RequestMapping(value = "insererClient.htm")
    public ModelAndView insererClient(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String destinationPage;
        try {

            ClientEntity client = new ClientEntity();
            ClientService clientService = new ClientService();

            String login = request.getParameter("login");

            UtilisateurEntity user = clientService.consulterClientByLogin(login);
            System.out.println(user);
            System.out.println(login);
            if(user == null){
                System.out.println("cool");
                destinationPage = "/vues/creerCompte";
            }else{
                request.setAttribute("MesErreurs", "Utilisateur deja existant.");
                destinationPage = "/vues/creerCompte";
            }

        } catch (MonException e) {
            request.setAttribute("MesErreurs", e.getMessage());
            destinationPage = "Erreur";

        }
        return new ModelAndView(destinationPage);
    }


}