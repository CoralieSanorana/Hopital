package model;
import java.util.*;

public class Med_Ordonnance {
    private String id;
    private String id_consultation;
    private Date daty;
    private String id_type_arret;
    private String nb_jours;
    private Date date_debut;
    private Date date_fin;
    private String observation;
    private String id_type_soins;
    private String type;
    private int etat;
    private String observation_s;
    private String idmedecin;
    private String identite;
    private String idretraite;
    private String iddeces;
    private String idmembre;
    private String societepriseen;

    public Med_Ordonnance(){}
    public Med_Ordonnance(String id,String id_consultation,
    Date daty,String nb_jours,Date date_debut,Date date_fin,
    String type,int etat,String observation_s,String idmedecin
    ) throws Exception{
        try {
            setId(id);
            setId_consultation(id_consultation);
            setDaty(daty);
            setDate_debut(date_debut);
            setDate_fin(date_fin);
            setNb_jours(nb_jours);
            setType(type);
            setEtat(etat);
            setObservation_s(observation_s);
            setIdmedecin(idmedecin);
        } catch (Exception e) {
            throw e;
        }
    }
// les GETTEURS
    public Date getDate_debut() {
        return date_debut;
    }
    public Date getDate_fin() {
        return date_fin;
    }
    public Date getDaty() {
        return daty;
    }
    public int getEtat() {
        return etat;
    }
    public String getId() {
        return id;
    }
    public String getId_consultation() {
        return id_consultation;
    }
    public String getId_type_arret() {
        return id_type_arret;
    }
    public String getId_type_soins() {
        return id_type_soins;
    }
    public String getIddeces() {
        return iddeces;
    }
    public String getIdentite() {
        return identite;
    }
    public String getIdmedecin() {
        return idmedecin;
    }
    public String getIdmembre() {
        return idmembre;
    }
    public String getIdretraite() {
        return idretraite;
    }
    public String getNb_jours() {
        return nb_jours;
    }
    public String getObservation() {
        return observation;
    }
    public String getObservation_s() {
        return observation_s;
    }
    public String getSocietepriseen() {
        return societepriseen;
    }
    public String getType() {
        return type;
    }
    
// les SETTEURS
    public void setDate_debut(Date date_debut) throws Exception{
        try {
            this.date_debut = date_debut;
        } catch (Exception e) {
            throw e;
        }
    }
    public void setId(String id) throws Exception{
        try {
            if (id == null || id == "") {
                throw new Exception("ID Med_ordonnance INVALIDE");
            } else{
                this.id = id;
            }
        } catch (Exception e) {
            throw e;
        }
    }
    public void setId_consultation(String id_consultation) throws Exception{
        try {
            this.id_consultation = id_consultation;
        } catch (Exception e) {
            // TODO: handle exception
        }
    }
    public void setDaty(Date daty) throws Exception{
        try {
            this.daty = daty;
        } catch (Exception e) {
            throw e;
        }
    }
    public void setId_type_arret(String id_type_arret) {
        this.id_type_arret = id_type_arret;
    }
    public void setNb_jours(String nb_jours) {
        this.nb_jours = nb_jours;
    }
    public void setDate_fin(Date date_fin) throws Exception{
        try {
            if (date_fin == null) {
                throw new Exception("DATE FIN Med_ordonnance INVALIDE");
            }else{
                this.date_fin = date_fin;
            }
        } catch (Exception e) {
            throw e;
        }
    }
    public void setObservation(String observation) {
        this.observation = observation;
    }
    public void setId_type_soins(String id_type_soins) {
        this.id_type_soins = id_type_soins;
    }
    public void setType(String type) {
        this.type = type;
    }
    public void setEtat(int etat) {
        this.etat = etat;
    }
    public void setObservation_s(String observation_s) {
        this.observation_s = observation_s;
    }
    public void setIdmedecin(String idmedecin) throws Exception{
        try {
            if (idmedecin == null || idmedecin == "") {
                throw new Exception("IDmedecin Med_ordonnance INVALIDE");
            } else{
                this.idmedecin = idmedecin;
            }
        } catch (Exception e) {
            throw e;
        }
    }
    public void setIdentite(String identite) {
        this.identite = identite;
    }
    public void setIdretraite(String idretraite) {
        this.idretraite = idretraite;
    }
    public void setIddeces(String iddeces) {
        this.iddeces = iddeces;
    }
    public void setIdmembre(String idmembre) {
        this.idmembre = idmembre;
    }public void setSocietepriseen(String societepriseen) {
        this.societepriseen = societepriseen;
    }

}
