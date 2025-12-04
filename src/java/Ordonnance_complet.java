package model;
import java.util.*;

public class Ordonnance_complet {
    private String id;
    private String id_consultation;
    private Date daty;
    private String nb_jours;
    private Date date_debut;
    private Date date_fin;
    private String observation;
    private String type;
    private int etat;
    private String idmedecin;
    private String idclient;
    private String nom;
    private String telephone;
    private String mail;
    private String adresse;
    private String remarque;
    private String pers_sexe;
    private Date pers_date_nais;
    private String nomMedecin;
    private String prenomMedecin;
    private String matricule;
    private String telMedecin;
    private String emailMedecin;

    public Ordonnance_complet(){}
    public Ordonnance_complet(
    String id,String id_consultation,
    Date daty,String nb_jours,Date date_debut,Date date_fin,
    String observation,String type,int etat,String idmedecin,
    String idclient,String nom,String telephone,String mail,
    String adresse, String remarque,String pers_sexe,Date pers_date_nais,
    String nomMedecin, String prenomMedecin,String matricule, 
    String telMedecin, String emailMedecin
    ) throws Exception{
        try {
            setId(id);
            setId_consultation(id_consultation);
            setDaty(daty);
            setDate_debut(date_debut);
            setDate_fin(date_fin);
            setNb_jours(nb_jours);
            setObservation(observation);
            setType(type);
            setEtat(etat);
            setIdmedecin(idmedecin);
            setIdclient(idclient);
            setNom(nom);
            setTelephone(telephone);
            setMail(mail);
            setAdresse(adresse);
            setRemarque(remarque);
            setPers_sexe(pers_sexe);
            setPers_date_nais(pers_date_nais);
            setNomMedecin(prenomMedecin);
            setPrenomMedecin(prenomMedecin);
            setMatricule(matricule);
            setTelMedecin(telMedecin);
            setEmailMedecin(emailMedecin);
        } catch (Exception e) {
            throw e;
        }
    }
// les GETTEURS
    public int getEtat() {return etat;}
    public String getId() {return id;}
    public String getId_consultation() {return id_consultation;}
    public Date getDaty() {return daty;}
    public String getNb_jours() {return nb_jours;}
    public Date getDate_debut() {return date_debut;}
    public Date getDate_fin() {return date_fin;}
    public String getObservation() {return observation;}
    public String getType() {return type;}
    public String getIdmedecin() {return idmedecin;}
    public String getIdclient() {return idclient;}
    public String getNom() {return nom;}
    public String getTelephone() {return telephone;}
    public String getMail() {return mail;}
    public String getAdresse() {return adresse;}
    public String getRemarque() {return remarque;}
    public String getPers_sexe() {return pers_sexe;}
    public Date getPers_date_nais() {return pers_date_nais;}
    public String getNomMedecin() {return nomMedecin;}
    public String getPrenomMedecin() {return prenomMedecin;}
    public String getMatricule() {return matricule;}
    public String getTelMedecin() {return telMedecin;}
    public String getEmailMedecin() {return emailMedecin;}
    
// les SETTEURS
    public void setDate_debut(Date date_debut) throws Exception{
        this.date_debut = date_debut;
    }
    public void setId(String id) throws Exception{
        try {
            /* if (id == null || id == "") {
                throw new Exception("ID Med_ordonnance_completnance INVALIDE");
            } else{ */
                this.id = id;
            //}
        } catch (Exception e) {
            throw e;
        }
    }
    public void setId_consultation(String id_consultation) throws Exception{
        try {
            this.id_consultation = id_consultation;
        } catch (Exception e) {
            throw e;
        }
    }
    public void setDaty(Date daty) throws Exception{
        try {
            this.daty = daty;
        } catch (Exception e) {
            throw e;
        }
    }
    public void setNb_jours(String nb_jours) {
        this.nb_jours = nb_jours;
    }
    public void setDate_fin(Date date_fin) throws Exception{
        try {
            this.date_fin = date_fin;
        } catch (Exception e) {
            throw e;
        }
    }
    public void setObservation(String observation) {
        this.observation = observation;
    }
    public void setType(String type) {
        this.type = type;
    }
    public void setEtat(int etat) {
        this.etat = etat;
    }
    public void setIdmedecin(String idmedecin) throws Exception{
            if (idmedecin == null || idmedecin.equals("")) {
                throw new Exception("IDmedecin Med_ordonnance_complet  INVALIDE");
            } else{ 
                this.idmedecin = idmedecin;
            }

    }
    public void setIdclient(String idclient) {
        this.idclient = idclient;
    }
    public void setNom(String nom) {
        this.nom = nom;
    }
    public void setTelephone(String telephone) {
        this.telephone = telephone;
    }
    public void setMail(String mail) {
        this.mail = mail;
    }
    public void setAdresse(String adresse) {
        this.adresse = adresse;
    }
    public void setRemarque(String remarque) {
        this.remarque = remarque;
    }
    public void setPers_sexe(String pers_sexe) {
        this.pers_sexe = pers_sexe;
    }
    public void setPers_date_nais(Date pers_date_nais) {
        this.pers_date_nais = pers_date_nais;
    }
    public void setNomMedecin(String nomMedecin) {
        this.nomMedecin = nomMedecin;
    }
    public void setPrenomMedecin(String prenomMedecin) {
        this.prenomMedecin = prenomMedecin;
    }
    public void setMatricule(String matricule) {
        this.matricule = matricule;
    }
    public void setTelMedecin(String telMedecin) {
        this.telMedecin = telMedecin;
    }
    public void setEmailMedecin(String emailMedecin) {
        this.emailMedecin = emailMedecin;
    }
}
