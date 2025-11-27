package model;
import java.util.*;
public class Inventaire {
    String id;
    Date daty;
    String designation;
    String idmagasin;
    int etat;
    String remarque;
    String idcategorie;
    String idpoint;

    public Inventaire(){}
    public Inventaire(String id,Date daty,
    String designation, String idmagasin,
    int etat, String remarque,
    String idcategorie, String idpoint
    ) throws Exception{
        try {
            setId(id);
            setDaty(daty);
            setDesignation(designation);
            setIdmagasin(idmagasin);
            setEtat(etat);
            setRemarque(remarque);
            setIdcategorie(idcategorie);
            setIdpoint(idpoint);
        } catch (Exception e) {
            throw e;
        }
    }

    public void setDaty(Date daty) throws Exception{
        if (daty == null) {
            throw new Exception("Daty Inventaire NULL");
        } else{
            this.daty = daty;
        }
    }
    public void setDesignation(String designation) throws Exception{
        if(designation == null){
            throw new Exception("Desigantion Inventaire NULL");
        }else{
            this.designation = designation;
        }
    }
    public void setEtat(int etat) throws Exception{
        if (etat < 0) {
            throw new Exception("Etat Inventaire < 0");
        } else {
            this.etat = etat;
        }
    }
    public void setId(String id) throws Exception{
        if (id == null) {
            throw new Exception("ID Inventaire NULL");
        } else {
            this.id = id;
        }
    }
    public void setIdcategorie(String idcategorie) {
        this.idcategorie = idcategorie;
    }
    public void setIdmagasin(String idmagasin) {
        this.idmagasin = idmagasin;
    }
    public void setIdpoint(String idpoint) {
        this.idpoint = idpoint;
    }
    public void setRemarque(String remarque) {
        this.remarque = remarque;
    }

    public Date getDaty() {
        return daty;
    }
    public String getDesignation() {
        return designation;
    }
    public int getEtat() {
        return etat;
    }
    public String getId() {
        return id;
    }
    public String getIdcategorie() {
        return idcategorie;
    }
    public String getIdmagasin() {
        return idmagasin;
    }
    public String getIdpoint() {
        return idpoint;
    }
    public String getRemarque() {
        return remarque;
    }

}
