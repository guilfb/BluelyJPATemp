package com.epul.oeuvres.dao;

import com.epul.oeuvres.meserreurs.MonException;
import com.epul.oeuvres.metier.BorneEntity;

import javax.persistence.EntityTransaction;
import java.util.List;

public class BorneService extends EntityService {

	/* Lister les adherents
	 * */
	public List<BorneEntity> consulterListeBornes() throws MonException {
		List<BorneEntity> mesBornes = null;
		try
		{
			EntityTransaction transac = startTransaction();
			transac.begin();
			mesBornes = (List<BorneEntity>)
					entitymanager.createQuery(
							"SELECT a FROM BorneEntity a " +
									"ORDER BY a.idBorne").getResultList();
			entitymanager.close();
		}catch (RuntimeException e) {
			new MonException("Erreur de lecture", e.getMessage());
		}catch (Exception e) {
			e.printStackTrace();
		}
		return mesBornes;
	}

	/* Consultation d'une adherent par son numéro
	*/
	public BorneEntity consulterBorneById(int numero) throws MonException {
		List<BorneEntity> mesBornes = null;
		BorneEntity borne = new BorneEntity();
		try {
			EntityTransaction transac = startTransaction();
			transac.begin();

			mesBornes = (List<BorneEntity>)
						entitymanager.createQuery(
								"SELECT a FROM BorneEntity a " +
										"WHERE a.idBorne="+numero).getResultList();
			borne = mesBornes.get(0);
			entitymanager.close();
		}catch (RuntimeException e) {
			new MonException("Erreur de lecture", e.getMessage());
		}catch (Exception e) {
			e.printStackTrace();
		}
		return borne;
	}
}
