package model;

import java.util.Date;

public class Vente {

    private String id;
    private String designation;
    private String idMagasin;
    private Date daty;
    private String remarque;
    private int etat;
    private String idOrigine;
    private String idClient;
    private int estPrevu;
    private Date datyPrevu;
    private String idReservation;
    private double remise;
    private String idModePaiement;
    private double remiseMontant;
    private double montantDonne;

    public Vente() {}

    public Vente(String id, String designation, String idMagasin, Date daty,
                 String remarque, int etat, String idOrigine, String idClient,
                 int estPrevu, Date datyPrevu, String idReservation, double remise,
                 String idModePaiement, double remiseMontant, double montantDonne) {
        try {
            setId(id);
            setDesignation(designation);
            setIdMagasin(idMagasin);
            setDaty(daty);
            setRemarque(remarque);
            setEtat(etat);
            setIdOrigine(idOrigine);
            setIdClient(idClient);
            setEstPrevu(estPrevu);
            setDatyPrevu(datyPrevu);
            setIdReservation(idReservation);
            setRemise(remise);
            setIdModePaiement(idModePaiement);
            setRemiseMontant(remiseMontant);
            setMontantDonne(montantDonne);
        } catch (Exception e) {
            e.fillInStackTrace();
        }
    }

    // ---------- SETTERS ----------

    public void setId(String id) throws Exception {
        if (id != null && !id.isEmpty()) this.id = id;
        else throw new Exception("ID invalide");
    }

    public void setDesignation(String designation) {
        this.designation = designation;
    }

    public void setIdMagasin(String idMagasin) throws Exception {
        if (idMagasin != null && !idMagasin.isEmpty()) this.idMagasin = idMagasin;
        else throw new Exception("IDMAGASIN invalide");
    }

    public void setDaty(Date daty) throws Exception {
        if (daty != null) this.daty = daty;
        else throw new Exception("DATY invalide");
    }

    public void setRemarque(String remarque) {
        this.remarque = remarque;
    }

    public void setEtat(int etat) throws Exception {
        if (etat >= 0) this.etat = etat;
        else throw new Exception("ETAT invalide");
    }

    public void setIdOrigine(String idOrigine) {
        this.idOrigine = idOrigine;
    }

    public void setIdClient(String idClient) {
        this.idClient = idClient;
    }

    public void setEstPrevu(int estPrevu) throws Exception {
        if (estPrevu >= 0) this.estPrevu = estPrevu;
        else throw new Exception("ESTPREVU invalide");
    }

    public void setDatyPrevu(Date datyPrevu) {
        this.datyPrevu = datyPrevu;
    }

    public void setIdReservation(String idReservation) {
        this.idReservation = idReservation;
    }

    public void setRemise(double remise) throws Exception {
        if (remise >= 0) this.remise = remise;
        else throw new Exception("REMISE invalide");
    }

    public void setIdModePaiement(String idModePaiement) {
        this.idModePaiement = idModePaiement;
    }

    public void setRemiseMontant(double remiseMontant) throws Exception {
        if (remiseMontant >= 0) this.remiseMontant = remiseMontant;
        else throw new Exception("REMISEMONTANT invalide");
    }

    public void setMontantDonne(double montantDonne) throws Exception {
        if (montantDonne >= 0) this.montantDonne = montantDonne;
        else throw new Exception("MONTANTDONNE invalide");
    }

    // ---------- GETTERS ----------

    public String getId() { return id; }
    public String getDesignation() { return designation; }
    public String getIdMagasin() { return idMagasin; }
    public Date getDaty() { return daty; }
    public String getRemarque() { return remarque; }
    public int getEtat() { return etat; }
    public String getIdOrigine() { return idOrigine; }
    public String getIdClient() { return idClient; }
    public int getEstPrevu() { return estPrevu; }
    public Date getDatyPrevu() { return datyPrevu; }
    public String getIdReservation() { return idReservation; }
    public double getRemise() { return remise; }
    public String getIdModePaiement() { return idModePaiement; }
    public double getRemiseMontant() { return remiseMontant; }
    public double getMontantDonne() { return montantDonne; }

    @Override
    public String toString() {
        return "Vente{" +
                "id='" + id + '\'' +
                ", designation='" + designation + '\'' +
                ", idMagasin='" + idMagasin + '\'' +
                ", daty=" + daty +
                ", remarque='" + remarque + '\'' +
                ", etat=" + etat +
                ", idOrigine='" + idOrigine + '\'' +
                ", idClient='" + idClient + '\'' +
                ", estPrevu=" + estPrevu +
                ", datyPrevu=" + datyPrevu +
                ", idReservation='" + idReservation + '\'' +
                ", remise=" + remise +
                ", idModePaiement='" + idModePaiement + '\'' +
                ", remiseMontant=" + remiseMontant +
                ", montantDonne=" + montantDonne +
                '}';
    }
}
