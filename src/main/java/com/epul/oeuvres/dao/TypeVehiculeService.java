package com.epul.oeuvres.dao;

import com.epul.oeuvres.meserreurs.MonException;
import com.epul.oeuvres.metier.TypeVehiculeEntity;

import javax.persistence.EntityTransaction;
import java.util.List;

public class TypeVehiculeService extends EntityService {

    public List<TypeVehiculeEntity> consulterListeTypeVehicules() throws MonException {
        List<TypeVehiculeEntity> mesTypeVehicules = null;
        try
        {
            EntityTransaction transac = startTransaction();
            transac.begin();
            mesTypeVehicules = (List<TypeVehiculeEntity>)
                    entitymanager.createQuery(
                            "SELECT a FROM TypeVehiculeEntity a " +
                                    "ORDER BY a.idTypeVehicule").getResultList();
            entitymanager.close();
        }catch (RuntimeException e) {
            new MonException("Erreur de lecture", e.getMessage());
        }catch (Exception e) {
            e.printStackTrace();
        }
        return mesTypeVehicules;
    }

    public TypeVehiculeEntity consulterTypeVehiculeById(int numero) throws MonException {
        List<TypeVehiculeEntity> mesTypeVehicules = null;
        TypeVehiculeEntity typeVehicule = new TypeVehiculeEntity();
        try {
            EntityTransaction transac = startTransaction();
            transac.begin();

            mesTypeVehicules = (List<TypeVehiculeEntity>)entitymanager.createQuery("SELECT a FROM TypeVehiculeEntity a WHERE a.idTypeVehicule="+numero).getResultList();
            typeVehicule = mesTypeVehicules.get(0);
            entitymanager.close();
        }catch (RuntimeException e) {
            new MonException("Erreur de lecture", e.getMessage());
        }catch (Exception e) {
            e.printStackTrace();
        }
        return typeVehicule;
    }
}
