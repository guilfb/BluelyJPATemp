package com.epul.oeuvres.dao;

import com.epul.oeuvres.meserreurs.MonException;
import java.util.*;
import javax.persistence.*;
import com.epul.oeuvres.metier.*;


import javax.persistence.EntityTransaction;

public class Service extends EntityService{

	public ClientEntity getUtilisateur( String login) throws MonException
	{
		ClientEntity unClient=null;
	try {
		EntityTransaction transac = startTransaction();
		transac.begin();

		Query query = entitymanager.createNamedQuery("ClientEntity.rechercheNom");
		query.setParameter("login", login);
		unClient = (ClientEntity) query.getSingleResult();
		if (unClient == null) {
			new MonException("Utilisateur Inconnu", "Erreur ");
	}
		entitymanager.close();

	}
		catch(RuntimeException e)
		{
			new MonException("Erreur de lecture", e.getMessage());
		} catch (Exception e){
		new MonException("Erreur de lecture", e.getMessage());
	}
		return unClient;
	}


}
