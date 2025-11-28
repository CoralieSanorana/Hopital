package model;
import java.util.*;

public class InventaireFille_ING {
    String id;
    String idInventaire;
    String idProduit;
    String idProduitLib;
    String explication;
    double quantite_theorique;
    double quantite;
    Date daty;
    String idmagasin;
    String idjauge;
    int etat;

    public InventaireFille_ING(){}
    public InventaireFille_ING( String id,String idInventaire,
    String idProduit, String idProduitLib,
    String explication, double quantite_theorique,
    double quantite, Date daty, String idmagasin,
    String idjauge, int etat
    ) throws Exception{
        try {
            setId(id);
            setIdInventaire(idInventaire);
            setIdProduit(idProduit);
            setIdProduitLib(idProduitLib);
            setExplication(explication);
            setQuantite_theorique(quantite_theorique);
            setQuantite(quantite);
            setDaty(daty);
            setIdmagasin(idmagasin);
            setIdjauge(idjauge);
            setEtat(etat);
        } catch (Exception e) {
            throw e;
        }
    }

    public void setDaty(Date daty) throws Exception{
        if (daty == null) {
            throw new Exception("Daty InventaireFille ING NULL");
        } else {
            this.daty = daty;
        }
    }
    public void setEtat(int etat) throws Exception{
        if (etat < 0) {
            throw new Exception("Etat InventaireFille ING < 0");
        } else{
            this.etat = etat;
        }
    }
    public void setExplication(String explication) {
        this.explication = explication;
    }
    public void setId(String id) throws Exception{
        if (id == null) {
            throw new Exception("ID InventaireFille ING NULL");
        } else {
            this.id = id;
        }
    }
    public void setIdInventaire(String idInventaire) throws Exception{
        if (idInventaire == null) {
            throw new Exception("IdInventaire InventaireFille ING NULL");
        } else {
            this.idInventaire = idInventaire;
        }
    }
    public void setIdProduit(String idProduit) throws Exception{
        if (idProduit == null) {
            throw new Exception("IdProduit InventaireFille ING NULL");
        } else{
            this.idProduit = idProduit;
        }
    }
    public void setIdProduitLib(String idProduitLib) throws Exception{
        /* if (idProduitLib == null) {
            throw new Exception("idProduitLib InventaireFille ING NULL");
        } else { */
            this.idProduitLib = idProduitLib;
        //}
    }
    public void setIdjauge(String idjauge) {
        this.idjauge = idjauge;
    }
    public void setIdmagasin(String idmagasin) {
        this.idmagasin = idmagasin;
    }
    public void setQuantite(double quantite) {
        this.quantite = quantite;
    }
    public void setQuantite_theorique(double quantite_theorique) {
        this.quantite_theorique = quantite_theorique;
    }
    public Date getDaty() {
        return daty;
    }
    public int getEtat() {
        return etat;
    }
    public String getExplication() {
        return explication;
    }
    public String getId() {
        return id;
    }
    public String getIdInventaire() {
        return idInventaire;
    }
    public String getIdProduit() {
        return idProduit;
    }
    public String getIdProduitLib() {
        return idProduitLib;
    }
    public String getIdjauge() {
        return idjauge;
    }
    public String getIdmagasin() {
        return idmagasin;
    }
    public double getQuantite() {
        return quantite;
    }
    public double getQuantite_theorique() {
        return quantite_theorique;
    }
}
