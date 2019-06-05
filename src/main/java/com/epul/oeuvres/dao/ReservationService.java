package com.epul.oeuvres.dao;

import com.epul.oeuvres.meserreurs.MonException;
import com.epul.oeuvres.metier.ReservationEntity;
import com.epul.oeuvres.metier.UtilisateurEntity;

import javax.persistence.EntityTransaction;
import javax.persistence.Query;
import java.util.List;

public class ReservationService extends EntityService {

	/* Insertion d'un adherent
	 * param Adherent unAdherent
	 * */
	public void insertReservation(ReservationEntity uneReservation) throws MonException {

		System.out.println(uneReservation);
	}

	public void supprimerReservation(ReservationEntity uneReservation) throws MonException {
		try
		{

			EntityTransaction transac = startTransaction();
			transac.begin();
			String qryString = "delete from ReservationOeuvreventeEntity s where s.idReservationOeuvrevente="+uneReservation.getClient();//mettre id reservation
			Query query = entitymanager.createQuery(qryString);
			int count = query.executeUpdate();
			transac.commit();
			entitymanager.close();
		}
		catch (RuntimeException e)
		{
			new MonException("Erreur de lecture", e.getMessage());
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void modifierReservation(ReservationEntity reservation) throws MonException {
		try
		{
			EntityTransaction transac = startTransaction();
			transac.begin();
			entitymanager.merge(reservation);
			entitymanager.flush();
			transac.commit();
		}
		catch (RuntimeException e)
		{
			new MonException("Erreur de lecture", e.getMessage());
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public List<ReservationEntity> consulterListeReservations(int idUtilisateur) throws MonException {
		List<ReservationEntity> mesRes = null;
		try
		{
			EntityTransaction transac = startTransaction();
			transac.begin();
			mesRes = (List<ReservationEntity>)
					entitymanager.createQuery(
							"SELECT o FROM ReservationEntity o WHERE o.client.idClient="+idUtilisateur).getResultList();
			entitymanager.close();

		}
		catch (RuntimeException e)
		{
			new MonException("Erreur de lecture", e.getMessage());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return mesRes;
	}

	public ReservationEntity reservationById(int numero) throws MonException {
		List<ReservationEntity> reservations = null;
		ReservationEntity reservation = new ReservationEntity();
		try {
			EntityTransaction transac = startTransaction();
			transac.begin();

			reservations = (List<ReservationEntity>)entitymanager.createQuery("SELECT a FROM ReservationOeuvreventeEntity a WHERE a.idReservationOeuvrevente="+numero).getResultList();
			reservation = reservations.get(0);
			entitymanager.close();
		}catch (RuntimeException e)
		{
			new MonException("Erreur de lecture", e.getMessage());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return reservation;
	}



}
