package com.epul.oeuvres.dao;

import com.epul.oeuvres.meserreurs.MonException;
import com.epul.oeuvres.metier.ReservationEntity;

import javax.persistence.EntityTransaction;
import java.util.List;

public class ReservationService extends EntityService {

	/* Insertion d'un adherent
	 * param Adherent unAdherent
	 * */
	public void insertReservation(ReservationEntity uneReservation) throws MonException {
		System.out.println(uneReservation);
	}

	public List<ReservationEntity> consulterListeReservations(int idUtilisateur) throws MonException {
		List<ReservationEntity> mesRes = null;
		try {
			EntityTransaction transac = startTransaction();
			transac.begin();

			mesRes = (List<ReservationEntity>)
					entitymanager.createQuery(
							"SELECT o FROM ReservationEntity o WHERE o.client.idClient="+idUtilisateur).getResultList();

			entitymanager.close();
		} catch (RuntimeException e) {
			new MonException("Erreur de lecture", e.getMessage());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return mesRes;
	}



}
