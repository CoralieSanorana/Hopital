package model;
import java.util.*;
public class InventaireFille {
    String id;
    String idInventaire;
    String idproduit;
    String explication;
    double quantite_theorique;
    double quantite;
    String idjauge;
    Date dateperemptiom;
    String dateperemptionLib;

    public InventaireFille(){}
    public InventaireFille( String id, String idInventaire,
    String idproduit,String explication, double quantite_theorique,
    double  quantite, String idjauge,
    Date dateperemptiom,String dateperemptionLib
    ) throws Exception{
        try {
            setId(id);
            setIdInventaire(idInventaire);
            setIdproduit(idproduit);
            setExplication(explication);
            setQuantite_theorique(quantite_theorique);
            setQuantite(quantite);
            setIdjauge(idjauge);
            setDateperemptiom(dateperemptiom);
            setDateperemptionLib(dateperemptionLib);
        } catch (Exception e) {
            throw e;
        }

    }

    public Date getDateperemptiom() {
        return dateperemptiom;
    }
    public String getDateperemptionLib() {
        return dateperemptionLib;
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
    public String getIdjauge() {
        return idjauge;
    }
    public String getIdproduit() {
        return idproduit;
    }
    public double getQuantite() {
        return quantite;
    }
    public double getQuantite_theorique() {
        return quantite_theorique;
    }

    public void setDateperemptiom(Date dateperemptiom) {
        this.dateperemptiom = dateperemptiom;
    }
    public void setDateperemptionLib(String dateperemptionLib) {
        this.dateperemptionLib = dateperemptionLib;
    }
    public void setExplication(String explication) {
        this.explication = explication;
    }
    public void setId(String id) throws Exception{
        if (id == null) {
            throw new Exception("ID Inventaire Fille NULL");
        } else {
            this.id = id;
        }
    }
    public void setIdInventaire(String idInventaire) throws Exception{
        if (idInventaire == null) {
            throw new Exception("IdIventaire Inventaire Fille NULL");
        } else {
            this.idInventaire = idInventaire;
        }
    }
    public void setIdjauge(String idjauge) {
        this.idjauge = idjauge;
    }
    public void setIdproduit(String idproduit) throws Exception{
        if (idproduit == null) {
            throw new Exception("Id Produit Inventaire Fille NULL");
        } else { 
            this.idproduit = idproduit;
        }
    }
    public void setQuantite(double quantite) {
        this.quantite = quantite;
    }
    public void setQuantite_theorique(double quantite_theorique) {
        this.quantite_theorique = quantite_theorique;
    }

}
