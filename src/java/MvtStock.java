package model;

import java.util.Date;

public class MvtStock {

    private String id;
    private String designation;
    private String idMagasin;
    private String idVente;
    private String idTransfert;
    private String idTypeMvtStock;
    private Date daty;
    private int etat;
    private String idPoint;
    private String idObjet;
    private String fabPrecedent;
    private String source;

    public MvtStock() {}

    public MvtStock(String id, String designation, String idMagasin, String idVente,
                    String idTransfert, String idTypeMvtStock, Date daty, int etat,
                    String idPoint, String idObjet, String fabPrecedent, String source) {
        try {
            setId(id);
            setDesignation(designation);
            setIdMagasin(idMagasin);
            setIdVente(idVente);
            setIdTransfert(idTransfert);
            setIdTypeMvtStock(idTypeMvtStock);
            setDaty(daty);
            setEtat(etat);
            setIdPoint(idPoint);
            setIdObjet(idObjet);
            setFabPrecedent(fabPrecedent);
            setSource(source);
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

    public void setIdVente(String idVente) { this.idVente = idVente; }
    public void setIdTransfert(String idTransfert) { this.idTransfert = idTransfert; }
    public void setIdTypeMvtStock(String idTypeMvtStock) { this.idTypeMvtStock = idTypeMvtStock; }

    public void setDaty(Date daty) throws Exception {
        if (daty != null) this.daty = daty;
        else throw new Exception("DATY invalide");
    }

    public void setEtat(int etat) throws Exception {
        if (etat >= 0) this.etat = etat;
        else throw new Exception("ETAT invalide");
    }

    public void setIdPoint(String idPoint) { this.idPoint = idPoint; }
    public void setIdObjet(String idObjet) { this.idObjet = idObjet; }
    public void setFabPrecedent(String fabPrecedent) { this.fabPrecedent = fabPrecedent; }
    public void setSource(String source) { this.source = source; }

    // ---------- GETTERS ----------

    public String getId() { return id; }
    public String getDesignation() { return designation; }
    public String getIdMagasin() { return idMagasin; }
    public String getIdVente() { return idVente; }
    public String getIdTransfert() { return idTransfert; }
    public String getIdTypeMvtStock() { return idTypeMvtStock; }
    public Date getDaty() { return daty; }
    public int getEtat() { return etat; }
    public String getIdPoint() { return idPoint; }
    public String getIdObjet() { return idObjet; }
    public String getFabPrecedent() { return fabPrecedent; }
    public String getSource() { return source; }

    @Override
    public String toString() {
        return "MvtStock{" +
                "id='" + id + '\'' +
                ", designation='" + designation + '\'' +
                ", idMagasin='" + idMagasin + '\'' +
                ", idVente='" + idVente + '\'' +
                ", idTransfert='" + idTransfert + '\'' +
                ", idTypeMvtStock='" + idTypeMvtStock + '\'' +
                ", daty=" + daty +
                ", etat=" + etat +
                ", idPoint='" + idPoint + '\'' +
                ", idObjet='" + idObjet + '\'' +
                ", fabPrecedent='" + fabPrecedent + '\'' +
                ", source='" + source + '\'' +
                '}';
    }
}
